require 'pronto'
require 'jshintrb'

module Pronto
  class JSHint < Runner
    def run
      return [] unless @patches

      @patches.select { |patch| patch.additions > 0 }
        .select { |patch| js_file?(patch.new_file_full_path) }
        .map { |patch| inspect(patch) }
        .flatten.compact
    end

    def inspect(patch)
      offences = if File.exist?('.jshintrc')
                   Jshintrb.lint(patch.new_file_full_path, :jshintrc)
                 else
                   Jshintrb.lint(patch.new_file_full_path)
                 end.compact

      offences.map do |offence|
        patch.added_lines.select { |line| line.new_lineno == offence['line'] }
          .map { |line| new_message(offence, line) }
      end
    end

    def new_message(offence, line)
      path = line.patch.delta.new_file[:path]
      level = :warning

      Message.new(path, line, level, offence['reason'], nil, self.class)
    end

    def js_file?(path)
      %w(.js .es6 .js.es6).include? File.extname(path)
    end
  end
end
