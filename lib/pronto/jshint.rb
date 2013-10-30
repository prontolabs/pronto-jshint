require 'pronto'
require 'jshintrb'

module Pronto
  class JSHint < Runner
    def run(patches, commit)
      return [] unless patches

      patches.select { |patch| patch.additions > 0 }
             .select { |patch| js_file?(patch.new_file_full_path) }
             .map { |patch| inspect(patch) }
             .flatten.compact
    end

    def inspect(patch)
      offences = Jshintrb.lint(patch.new_file_full_path)

      offences.map do |offence|
        patch.added_lines.select { |line| line.new_lineno == offence['line'] }
                         .map { |line| new_message(offence, line) }
      end
    end

    def new_message(offence, line)
      path = line.patch.delta.new_file[:path]
      level = :warning

      Message.new(path, line, level, offence['reason'])
    end

    def js_file?(path)
      File.extname(path) == '.js'
    end
  end
end
