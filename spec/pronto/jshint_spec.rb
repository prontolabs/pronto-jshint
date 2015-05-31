require 'spec_helper'

module Pronto
  describe JSHint do
    let(:jshint) { JSHint.new }

    describe '#run' do
      subject { jshint.run(patches, nil) }

      context 'patches are nil' do
        let(:patches) { nil }
        it { should == [] }
      end

      context 'no patches' do
        let(:patches) { [] }
        it { should == [] }
      end

      context 'patches with a one warning' do
        include_context 'test repo'

        let(:patches) { repo.diff('master') }

        its(:count) { should == 1 }
        its(:'first.msg') { should == 'Missing semicolon.' }
      end
    end
  end
end
