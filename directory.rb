@students = []

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"

  name = gets.chomp

  while !name.empty?
    puts "Now please enter the student's cohort"
    cohort = gets.chomp
      if cohort.empty?
        cohort = "Cohort unknown"
      end

    @students << {name: name, cohort: cohort}
      if @students.count > 1
        puts "Now we have #{@students.count} students"
      else
        puts "Now we have #{@students.count} student"
      end

    puts "Please enter the name of the student"
    name = gets.chomp
  end
end

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "9. Exit"
end

def show_students
  print_header
  print_student_list
  print_footer
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "9"
      exit
    else
      puts "Please enter a valid selection"
  end
end

def print_header
  puts "The Students of Demo Academy".center(50)
  puts "-".center(50, "-")
end

def print_student_list
  @students.each_with_index() do |student, i|
    puts "#{i + 1}. #{student[:name]} (#{student[:cohort]} cohort)".center(50, " ")
  end
end

def print_footer
  if @students.count > 1
    puts "Overall, we have #{@students.count} great students".center(50, "-")
  else
    puts "Overall, we have #{@students.count} great student".center(50, "-")
  end
end

interactive_menu
