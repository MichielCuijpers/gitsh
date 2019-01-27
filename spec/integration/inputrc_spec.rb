require 'spec_helper'

describe 'A .inputrc file in the home directory' do
  it 'is used by gitsh' do
    with_a_temporary_home_directory do
      write_file(inputrc_path, <<-EOF)
        $if gitsh
          "\C-xx": "foobar"
        $endif
      EOF

      GitshRunner.interactive do |gitsh|
        gitsh.type "\cxx"

        expect(gitsh).to output_error(/'foobar' is not a git command/)
      end
    end
  end

  def inputrc_path
    "#{ENV['HOME']}/.inputrc"
  end
end
