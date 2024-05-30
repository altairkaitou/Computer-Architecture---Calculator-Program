# Calculator Project - README

## Project Overview

This project is an implementation of a calculator in MIPS assembly language, developed as part of the Computer Architecture course at the Faculty of Computer Science and Engineering, Ho Chi Minh City University of Technology. The calculator supports basic arithmetic operations, exponentiation, factorials, and parentheses for operation precedence.

## Table of Contents

1. [Introduction](#introduction)
2. [Implementation Details](#implementation-details)
    - [Input Handling](#input-handling)
    - [Mathematical Operations](#mathematical-operations)
    - [Error Handling](#error-handling)
3. [Program Structure and Functionality](#program-structure-and-functionality)
4. [Testing and Results](#testing-and-results)
5. [Challenges](#challenges)
6. [Conclusion](#conclusion)

## Introduction

A calculator is a device used for performing mathematical calculations, from simple arithmetic to complex mathematics. Modern calculators are crucial tools in education, science, and everyday life. This project implements a simple calculator capable of handling basic arithmetic operations, factorials, exponents, and more, with a focus on robust input handling and error detection.

## Implementation Details

### Input Handling

The program begins by prompting the user to enter mathematical expressions via a command-line interface. User inputs are read as strings and parsed into tokens representing numbers and operators. This method ensures efficient and error-free input processing, with checks for invalid characters and syntax errors.

### Mathematical Operations

The calculator supports the following operations:

- **Addition, Subtraction, Multiplication, and Division:** Handles both integer and floating-point numbers.
- **Exponentiation:** Allows users to perform power calculations.
- **Factorials:** Calculates the product of all positive integers up to the given number.
- **Parentheses:** Respects mathematical precedence by evaluating expressions within parentheses first.

### Error Handling

Error handling is crucial for a reliable calculator. The program identifies potential input errors, such as non-numeric characters, misplaced operators, and unmatched parentheses, and provides descriptive error messages to the user without crashing.

## Program Structure and Functionality

The program runs in an infinite loop, continuously prompting the user for input. Key components include:

- **Parsing and Validation:** Checks for valid characters and balanced parentheses before computation.
- **Mathematical Operations:** Each operation has a specific section of code, handling addition, subtraction, multiplication, and division.
- **Error Handling:** Integrated into input validation and mathematical operations, providing immediate feedback on errors.

## Testing and Results

### Basic Operations

The calculator successfully performs basic arithmetic operations with both integers and floating-point numbers.

### Complex Expressions

The program can process and evaluate complex expressions involving multiple operations and parentheses.

### Error Handling

Effective error handling ensures that invalid inputs are caught, and descriptive error messages are provided.

### Additional Features

- **Quit Command:** Allows users to exit the program.
- **Memory Functionality:** Saves the result of the last calculation.

## Challenges

Some limitations in the current implementation include:

- **Operation Precedence:** The program does not prioritize multiplication and division over addition and subtraction, evaluating expressions from left to right instead.
- **Log File:** The program does not create a detailed log file to track user inputs.

## Conclusion

Implementing an interactive calculator in MIPS assembly language was a challenging yet rewarding project. It provided valuable insights into low-level programming and the intricacies of handling arithmetic operations and error detection. Despite some incomplete features, the calculator serves as a comprehensive tool for a wide range of mathematical calculations.

---

**Author:** Lê Minh Gia Bảo  
**Course:** Computer Architecture - CO2007  
**Institution:** Ho Chi Minh City University of Technology - VNU-HCM  
**Date:** 8 May 2023
