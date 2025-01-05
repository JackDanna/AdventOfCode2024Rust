//use core::num;
use std::io::{self, BufRead, BufReader};
use std::fs::File;

fn main() -> io::Result<()> {
    let file = File::open("./input.txt")?;
    let reader = BufReader::new(file);

    let mut first_numbers = Vec::new();
    let mut second_numbers = Vec::new();

    for line in reader.lines() {
        match line {
            Ok(line) => {
                let numbers:Vec<u32> =
                    line
                    .split_whitespace()
                    .filter_map(|num| num.parse().ok())
                    .collect();

                if numbers.len() == 2 {
                    first_numbers.push(numbers[0]);
                    second_numbers.push(numbers[1]);
                }
            },
            Err(_) => {
                continue;
            },
        };
    }

    // Print some statistics
    println!("Number of pairs parsed: {}", first_numbers.len());
    
    // Print the first few entries from each list
    println!("\nFirst 5 entries from first list:");
    for num in first_numbers.iter().take(5) {
        println!("{}", num);
    }

    println!("\nFirst 5 entries from second list:");
    for num in second_numbers.iter().take(5) {
        println!("{}", num);
    }

    // Optional: You can use these vectors separately for further processing
    // For example, calculating statistics for each list:
    if !first_numbers.is_empty() {
        let avg_first = first_numbers.iter().sum::<u32>() as f64 / first_numbers.len() as f64;
        let avg_second = second_numbers.iter().sum::<u32>() as f64 / second_numbers.len() as f64;
        
        println!("\nAverage of first numbers: {:.2}", avg_first);
        println!("Average of second numbers: {:.2}", avg_second);
    }

    Ok(())

}
