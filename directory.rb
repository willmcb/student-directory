@students = []

def add_student(student)
  @students << student
end

def try_load_students
  filename = ARGV.first ||= ask_for_filename
  return if filename.nil?
  if File.exists?(filename)
    load_students(filename)
     puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

def load_students(filename)
  if filename.nil?
    filename = ask_for_filename
  end
  file = File.open(filename, "r") do |f|
    f.readlines.each do |line|
      name, cohort = line.chomp.split(',')
      add_student({name: name, cohort: cohort.to_sym})
    end
  end
end

def save_students
  file = File.open(ask_for_filename, "w") do |f|
    @students.each do |student|
      student_data = [student[:name], student[:cohort]]
      csv_line = student_data.join(",")
      f.puts csv_line
    end
  end
end


def print_menu
  puts "1. input the students"
  puts "2. show the students"
  puts "3. save the list to students.csv"
  puts "4. load the list from students.csv"
  puts "9. exit"
end

def show_students
  print_header
  print_students_list
  print_footer
end

def process(selection)
  case selection
    when "1"
      input_students
      puts "Action complete"
    when "2"
      show_students
      puts "Action complete"
    when "3"
      save_students
      puts "Action complete"
    when "4"
      load_students(nil)
      puts "Action complete"
    when "9"
      exit
    else
      puts "I don't know what you mean, try again"
  end
end

def ask_for_filename
  puts "Please enter file name of students you want to load"
  STDIN.gets.chomp
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish just hit return twice"
  name = STDIN.gets.chomp
  while !name.empty? do
    add_student({name: name, cohort: :november})
    puts "Now we have #{@students.count} students"
    name = STDIN.gets.chomp
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_students_list
  if !@students.empty?
    @students.each_with_index  do |student, index|
      puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def print_footer
  puts "Overall,  we have #{@students.count} great students"
end

interactive_menu
