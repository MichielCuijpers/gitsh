require 'spec_helper'

describe 'A .inputrc file in the home directory' do
  it 'is used by gitsh' do
    with_a_temporary_home_directory do
      write_file(inputrc_path, <<-INPUTRC)
        $if gitsh
          "\C-xx": "notacommand"
        $endif
      INPUTRC

      GitshRunner.interactive do |gitsh|
        gitsh.type 'init'
        gitsh.type "\cxx"

        expect(gitsh).to output_error(/'notacommand' is not a git command/)
      end
    end
  end

  def inputrc_path
    "#{ENV['HOME']}/.inputrc"
  end
end
