def input_students
  puts "Please enter the names of the students and their cohorts"
  puts "To finish just hit return twice"

  students = []

  name = gets.chomp
  while !name.empty? do
    puts "Enter a cohort for #{name}"
    cohort = gets.chomp
    students << {name: name, cohort: cohort, hobbies: ['canoeing', 'climbing', 'fishing'], height: "5.11"}
    puts "Now we have #{students.count} students"
    name = gets.chomp
  end
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  puts "Select first letter of student name to print"
  letter = gets.chomp.downcase
  count = 0
  longest_name = students.sort_by{|name| name.size}.last.size
  while true
    break if students[count] == nil
    current_name_size = students[count][:name].size
    if students[count][:name][0].downcase == letter && students[count][:name].size < 12
      name = "#{count + 1}. #{students[count][:name]} "
      details = "(#{students[count][:cohort]} cohort, hobbies: #{students[count][:hobbies].join(', ')}, height: #{students[count][:height]})"
      offset = longest_name - current_name_size
      puts name + details.center(80 + (offset * 2))
    end
    count += 1
  end
end

def print_footer(names)
  puts "Overall,  we have #{names.count} great students"
end

students = input_students
print_header
print(students)
print_footer(students)
