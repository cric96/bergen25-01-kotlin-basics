#import "@preview/touying:0.5.2": *
#import themes.metropolis: *
#import "@preview/fontawesome:0.5.0": *
#import "@preview/ctheorems:1.1.3": *
#import "@preview/numbly:0.1.0": numbly

// Pdfpc configuration
// typst query --root . ./example.typ --field value --one "<pdfpc-file>" > ./example.pdfpc
#let pdfpc-config = pdfpc.config(
    duration-minutes: 30,
    start-time: datetime(hour: 14, minute: 10, second: 0),
    end-time: datetime(hour: 14, minute: 40, second: 0),
    last-minutes: 5,
    note-font-size: 12,
    disable-markdown: false,
    default-transition: (
      type: "push",
      duration-seconds: 2,
      angle: ltr,
      alignment: "vertical",
      direction: "inward",
    ),
  )

// Theorems configuration by ctheorems
#show: thmrules.with(qed-symbol: $square$)
#let theorem = thmbox("theorem", "Theorem", fill: rgb("#eeffee"))
#let corollary = thmplain(
  "corollary",
  "Corollary",
  base: "theorem",
  titlefmt: strong
)
#let definition = thmbox("definition", "Definition", inset: (x: 1.2em, top: 1em))
#let example = thmplain("example", "Example").with(numbering: none)
#let proof = thmproof("proof", "Proof")

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: self => self.info.author + ", " + self.info.institution + " - " + self.info.date,
  config-common(
    // handout: true,
    preamble: pdfpc-config, 
  ),
  config-info(
    title: [Kotlin Primer for Android Developers],
    subtitle: [Essentials of Kotlin for Compose],
    author: [Gianluca Aguzzi],
    date: datetime.today().display("[day] [month repr:long] [year]"),
    institution: [Università di Bologna],
    // logo: emoji.school,
  ),
)
// Option 2: Language-specific styling (just for Kotlin)
#show raw.where(lang: "kotlin"): block.with(
  fill: rgb("#f5f5f5"),
  stroke: rgb("#e0e0e0"),
  radius: 5pt,
  inset: 12pt,
  width: 100%,
)

#show raw.where(lang: "java"): block.with(
  fill: rgb("#f5f5f5"),
  stroke: rgb("#e0e0e0"),
  radius: 5pt,
  inset: 12pt,
  width: 100%,
)

#let styled-block(
  title, 
  content, 
  icon: "", 
  fill-color: rgb("#23373b").lighten(90%),
  stroke-color: rgb("#23373b").lighten(50%),
  title-color: rgb("#000000"),
  title-size: 20pt
) = {
  block(
    width: 100%,
    inset: (x: 24pt, y: 18pt),
    fill: fill-color,
    radius: 8pt,
    stroke: (
      paint: stroke-color, 
      thickness: 1pt,
      dash: "solid"
    ),
    [
      #text(weight: "bold", size: title-size, fill: title-color)[#icon #title]
      #v(-12pt)
      #line(length: 100%, stroke: (paint: stroke-color, thickness: 1.5pt))
      #v(-10pt)
      #content
    ]
  )
}

#let compact-styled-block(
  content, 
  icon: "", 
  fill-color: rgb("#23373b").lighten(90%),
  stroke-color: rgb("#23373b").lighten(50%)
) = {
  block(
    width: 100%,
    inset: (x: 24pt, y: 18pt),
    fill: fill-color,
    radius: 8pt,
    stroke: (
      paint: stroke-color, 
      thickness: 1pt,
      dash: "solid"
    ),
    [
      #text(weight: "bold", size: 20pt, fill: rgb("#000000"))[#icon] #h(0.4em) #content
    ]
  )
}
// Now define specialized blocks using the base block
#let feature-block(title, content, icon: "") = {
  styled-block(
    title, 
    content, 
    icon: icon,
    fill-color: rgb("#23373b").lighten(90%),
    stroke-color: rgb("#23373b").lighten(50%),
    title-size: 22pt
  )
}

#let note-block(title, content, icon: fa-info-circle() + " ") = {
  styled-block(
    title, 
    content, 
    icon: icon,
    fill-color: rgb("#fffde7"),
    stroke-color: rgb("#ffecb3"),
  )
}

#let warning-block(title, content, icon: fa-exclamation-triangle() + " ") = {
  styled-block(
    title, 
    content, 
    icon: icon,
    fill-color: rgb("#fff3e0"),
    stroke-color: rgb("#ffcc80"),
    title-color: rgb("#e65100"),
  )
}

// Now define compact versions of the specialized blocks
#let compact-feature-block(content, icon: "") = {
  compact-styled-block(
    content, 
    icon: icon,
    fill-color: rgb("#23373b").lighten(90%),
    stroke-color: rgb("#23373b").lighten(50%)
  )
}

#let compact-note-block(content, icon: fa-info-circle() + " ") = {
  compact-styled-block(
    content, 
    icon: icon,
    fill-color: rgb("#fffde7"),
    stroke-color: rgb("#ffecb3")
  )
}

#let compact-warning-block(content, icon: fa-exclamation-triangle() + " ") = {
  compact-styled-block(
    content, 
    icon: icon,
    fill-color: rgb("#fff3e0"),
    stroke-color: rgb("#ffcc80")
  )
}

#set text(font: "Fira Sans", weight: "light", size: 20pt)
#show math.equation: set text(font: "Fira Math")

#title-slide()

== Today's Lesson: Kotlin Primer for Compose

- *Learning Objectives:*
  - Understand Kotlin's syntax and features
  - Explore Kotlin's type system
  - Learn about Kotlin's functional programming capabilities
  - Discover Kotlin's DSL features
- *Prerequisites:*
  - Basic understanding of programming concepts
  - Familiarity with Java or another object-oriented language
  - No prior experience with Kotlin is required


== 
#focus-slide()[

  #image("figures/kotlin.png", width: 15%)
  Born in industry, for the industry

]

== But First, Hello World! :)
  
  #grid(
    columns: (1fr, 1fr),
    gutter: 24pt,
    [
      #box(
        width: 60%,
        clip: true,
        radius: 50%,
        stroke: (thickness: 5pt, paint: gray),
        image("figures/myself.jpeg", width: 100%)
      )
      
      #v(10pt)
      #text(weight: "medium", size: 20pt)[Gianluca Aguzzi]
      #text(style: "italic")[Postdococtoral Researcher]
      #text(style: "italic")[University of Bologna]
      ---
      #text(style: "italic")[#link("https://pslab-unibo.github.io/")[Pervasive Computing Lab]]
      
      #text(weight: "medium")[Connect with me:]
      #link("mailto:gianluca.aguzzi@unibo.it")[#emoji.email]
      #link("https://cric96.github.io")[#emoji.globe]
      
    ],
    [
      #v(30pt)
      #text(weight: "medium")[Adjunct Professor at UniBo]
      - Object-Oriented Programming
      - Functional Programming
      - AI for Code Development
      
      #v(10pt)
      #text(weight: "medium")[Research interests]
      - Collective Intelligence, Edge AI,
      - Edge AI
      - Distributed Systems
      
      #v(5pt)
      #emoji.heart  Passionate about teaching programming paradigms and software engineering
    ]
  )

== Kotlin Overview 
- #emoji.abcd *Kotlin* is a statically typed programming language developed by JetBrains
- #emoji.calendar Born in 2012, officially adopted for Android development in 2017
- #emoji.computer Originally targeting JVM, now supports multiple platforms:
  - JVM, JavaScript, Native, and WebAssembly
- #emoji.shield Designed to be *concise*, *expressive*, and *safe*
  - Eliminates common programming errors
  - Reduces boilerplate code compared to Java

== Kotlin - Philosophy
- #emoji.factory *Born in industry, for the industry* (vs. academic origins of Scala)
- #emoji.gear Pragmatic approach with rich standard library
  - More built-in keywords and core constructs than Scala
  - Less abstract than Haskell or F\# 
- #emoji.rocket *Optimized for developer productivity*
  - Concise syntax reduces boilerplate
  - Strong focus on reducing common programming errors
- #emoji.globe *Multi-target compilation strategy*
  - JVM, JavaScript, Native, WebAssembly
  - Stronger bidirectional Java interoperability than Scala
  - Seamless Android integration


== Kotlin - Why
#grid(
  columns: (1fr, 1fr),
  gutter: 16pt,
  [
    #figure(
      image("figures/why-kotlin.png", height: 55%),
      caption: [Java Dev transition to Kotlin]
    )
  ],
  [
    #figure(
      image("figures/why-kotlin-2.png", height: 55%), 
      caption: [Android Dev transition to Kotlin]
    )
  ]
)


#v(12pt)

#figure(
  image("figures/why-kotlin-3.png", width: 50%),
)

== How to Read this Presentation
- Each slide is a self-contained unit
- Slides are organized in a logical sequence
- In this time span, we will not cover everything
- Focus on understanding the concepts
- I leave the rest as a base for Compose presentation and the lab activity


= Kotlin 101

== Kotlin Basics
- *Functions*: First-class citizens (storable in variables, passable as arguments)
- *Type inference*: Optional type declarations, compiler determines types automatically
- *Variables*: `val` (immutable/final) and `var` (mutable/reassignable)
```kotlin
val x = 10 // constant
var y = 20 // variable, can be reassigned
fun foo() = 20 // function definition, single expression
fun bar(): Int { // same as above with multiple expression
    return 20 // requires a return in this form...
}
fun baz() { } // Unless it returns Unit
```

#link("https://play.kotlinlang.org/")[#emoji.laptop Try Kotlin online in the playground] // Interactive Kotlin REPL

== Kotlin Basics - Function Parameters and Return Types

- *Function parameters*: Can have default values, named arguments
- *Return types*: Optional, inferred by the compiler
```kotlin
fun foo(a: Int = 0, b: String = "foo"): Int = TODO()
// TODO() is a builtin function throwing a `NotImplementedError`
foo(1, "bar") // OK, positional
foo(a = 1, b = "bar") // OK, named
foo(1, b = "bar") // OK, hybrid
foo(a = 1, "bar") // error: no value passed for parameter 'b'
foo() // OK, both defaults
foo(1) // OK, same as foo(1, "foo")
foo("bar") // error: type mismatch: inferred type is String but Int was expected
foo(b = "bar") // OK, same as foo(0, "bar")
```

== Kotlin Basics - Top Level Functions & Entry Point
- *Top-level functions*: Functions defined outside classes
```kotlin
fun foo() = 20
fun main() {
    println("Hello, world!" + foo())
}
```
- When targetting JVM, it generates a FileNameKt class with a static main method

== Kotlin Basics - Nullable Types
- #emoji.shield *Nullable types*: Every type exists in two forms - normal and nullable
- #emoji.lock Non-nullable types cannot be assigned `null` (compile-time safety)
- #emoji.warning Kotlin solves the infamous "billion-dollar mistake" in Java

#grid(
  columns: (1fr, 1fr),
  gutter: 16pt,
  [
    *Java:*
    ```java
    String name = "John";
    name = null; // Allowed but dangerous
    name.length(); // Runtime NPE!
    ```
  ],
  [
    *Kotlin:*
    ```kotlin
    var name: String = "John"
    name = null // Compile error!
    
    var nullableName: String? = "John"
    nullableName = null // Allowed & safe
    ```
  ]
)

== Kotlin Basics - Working with Nullable Types
- #emoji.package Different from Java's `Optional<T>` - built into the type system
- #emoji.wrench Safe operators for handling nullable references:

#grid(
  columns: (1fr, 1fr),
  gutter: 16pt,
  [
    *Java:*
    ```java
    // Defensive programming needed
    if (user != null) {
      if (user.getAddress() != null) {
        return user.getAddress().getCity();
      }
    }
    return null;
    ```
  ],
  [
    *Kotlin:*
    ```kotlin
    // Safe call operator
    val city = user?.address?.city
    
    // Elvis operator
    val city = user?.address?.city ?: "Unknown"
    
    // Not-null assertion (use with caution)
    val city = user!!.address.city
    ```
  ]
)

== Kotlin Basics - Not-null Assertion and Elvis Operator

#grid(
  columns: (1fr, 1fr),
  gutter: 16pt,
  [
    #text(weight: "medium")[Not-null assertion (`!!`)]
    
    - Also known as: "I want my code to break badly at runtime"
    - Invalidates the whole point of having nullable types
    - Deliberately ugly syntax to discourage use
    
    ```kotlin
    var baz: String? = "foo"
    baz!!         // OK
    baz!!.length  // OK
    
    baz = null
    baz!!         // Runtime exception!
    ```
  ],
  [
    #text(weight: "medium")[Elvis operator (`?:`)]
    
    - Named after Elvis Presley's haircut 😉
    - Returns left operand if not null, otherwise right one
    
    ```kotlin
    var baz: String? = "foo"
    baz ?: "bar"      // Returns "foo"
    baz?.length ?: 0  // Returns 3,
    baz = null
    baz ?: "bar"      // Returns "bar", type String
    baz?.length ?: 0  // Returns 0, type Int
    ```
  ]
)

== Kotlin Basics - Platform Types
- Kotlin integrates with JVM, JavaScript, and native platforms
- These platforms don't have inherent nullable types
- *Platform types*: Special Kotlin types from platform integrations
  - Marked with `!` in error messages (e.g., `String!`)
  - Can be treated as both nullable and non-nullable
  - Not explicitly declared in code

#compact-note-block[
  If the target platform offers some way to assert nullability, Kotlin tries to use it.
  For example, if a Java method/parameter is annotated with `@NotNull` (or similar common alternatives) it will be interpreted as a non-nullable type.
]

== Type Hierarcy in Kotlin
#align(center)[
  #image("figures/type-hierarchy.png", width: 100%)
]
== Kotlin Basics -- Booleans, Numeric, Type Conversion
- Similar to Java, Kotlin has `Boolean`, `Byte`, `Short`, `Int`, `Long`, `Float`, `Double`
- No implicit conversion between numeric types
- Explicit conversion required
- &&, ||, and ! operators work for non-nullable Booleans.

#grid(
  columns: (1fr, 1fr),
  gutter: 16pt,
  [
    #text(weight: "medium")[Type Conversion]
    ```kotlin
    val x: Int = 10
    val y: Long = x.toLong()
    val z: Double = x.toDouble()
    
    // All numeric types provide conversions:
    // .toByte(), .toShort(), .toInt(),
    // .toLong(), .toFloat(), .toDouble()
    ```
  ],
  [
    #text(weight: "medium")[Numeric Literals]
    ```kotlin
    // Decimal: directly written
    val decimal = 123
    // Long: marked with 'L'
    val long = 123L
    // Hexadecimal: '0x' prefix
    val hex = 0x0F
    // Binary: '0b' prefix
    val binary = 0b0101
    val million = 1_000_000
    ```
  ]
)

#grid(
  columns: (1fr),
  [
    #text(weight: "medium")[Boolean Operations]
    ```kotlin
    val isTrue: Boolean = true
    val isFalse: Boolean = false
    
    // Boolean operators
    val andResult = isTrue && isFalse  // false
    val orResult = isTrue || isFalse   // true
    val notResult = !isTrue            // false
    
    ```
  ]
)

#compact-note-block[
  Unlike Java, there's no implicit widening conversions for numbers. The following will not compile in Kotlin: `val i: Int = 1; val l: Long = i`
]

== Kotlin Basics - Strings
- Strings are immutable in Kotlin (like Java)
- String templates for easy string interpolation
- Triple-quoted strings for multi-line strings

```kotlin
val name = "John"
val greeting = "Hello, $name!"
val multiLine = """
  |This is a multi-line string
  |It supports string interpolation: $name
""".trimMargin()

"${Double.NaN}".repeat(5) + " $batman!"  // NaNNaNNaNNaNNaN Batman!
"Batman is $batman.length characters long"
"Batman is ${batman.length} characters long"

```

== Kotlin Basics - Packages and Imports
- #emoji.package *Packages*: Organize code with namespace hierarchy (same as Java)
- #emoji.filedividers *Package declaration*: Must be at the top of the file
- #emoji.mailbox *Import statements*: For classes, functions, properties
- #emoji.label *Import features*:
  - Selective imports with `import package.Class`
  - Wildcard imports with `import package.*`
  - Alias imports with `import package.Class as Alias`
  - Top-level function imports with `import package.function`

```kotlin
package com.example.myapp

import kotlin.math.PI
import kotlin.math.abs as absolute
import com.example.myapp.util.*
```

== Kotlin Basics - Varargs
- #emoji.gear *Varargs*: Allows a function to accept a variable number of arguments
- #emoji.mailbox Typically the last parameter (but not mandatory as in Java)
- #emoji.folder Maps to an `Array<out T>`

```kotlin
fun printall(vararg strings: String) {
    strings.forEach { println(it) } // We'll discuss this syntax later...
}
printall("Lorem", "ipsum", "dolor", "sit", "amet")
```

== Kotlin Basics - Control Flow (if, for, while)
- *`if`*: Expression that returns a value
- *`for`*: Iterates over a range, collection, or iterator
  - Rarely used, as Kotlin prefers functional constructs
- *`while`*: Executes a block of code as long as a condition is true

#grid(
  columns: (1fr, 1fr),
  gutter: 16pt,
  [
    #text(weight: "medium")[If Expression]
    ```kotlin
    val a = 10
    val b = 20
    val max = if (a > b) a else b
    println("Max is \$max")
    ```
  ],
  [
    #text(weight: "medium")[For Loop]
    ```kotlin
    val numbers = listOf(1, 2, 3, 4, 5)
    for (number in numbers) {
      println(number)
    }
    ```
  ]
)

#grid(
  columns: (1fr, 1fr),
  gutter: 16pt,
  [
    #text(weight: "medium")[While Loop]
    ```kotlin
    var i = 0
    while (i < 5) { i++ }
    ```
  ]
)

== Kotlin Basics - When Expression
- *`when`*: Kotlin's replacement for the `switch` statement
  - But much more powerful and flexible
  - Can be used as an expression or a statement

```kotlin
fun describe(obj: Any): String =
    when (obj) {
        1 -> "One"
        "Hello" -> "Greeting"
        is Long -> "Long"
        !is String -> "Not a string"
        else -> "Unknown"
    }
```

== Kotlin OOP Basics - Classes
- SImilar to Java, Kotlin supports classes and objects
- Kotlin remove the new keyword
- Kotlin classes are final by default
```kotlin
class Foo
val foo = Foo()
```

== Kotlin OOP Basics - Classes - Members

- Kotlin classes have two types of members: *methods* and *properties*

// Properties vs Fields table with improved styling
#align(center)[
  #table(
    columns: (auto, auto, auto, auto),
    inset: 10pt,
    align: center,
    fill: (_, row) => if row == 0 { rgb("#23373b") } else { rgb("#f5f5f5") },
    stroke: 0.75pt + rgb("#cccccc"),
    [*Language / Member Type*], [*Fields*], [*Methods*], [*Properties*],
    [Java], [Yes], [Yes], [No],
    [Kotlin], [No (Hidden)], [Yes], [Yes],
    [C\#], [Yes], [Yes], [Yes],
  )
]

- In Kotlin, *methods/functions* (except when defined infix) are invoked with mandatory parentheses, properties are instead invoked without parentheses

== Kotlin OOP Basics - Properties vs Fields

#grid(
  columns: (1fr, 1fr),
  gutter: 16pt,
  [
    #text(weight: "medium")[Fields]
    - Object's actual state
    - Internal implementation detail
    - Hidden in Kotlin (cannot be directly exposed)
    - Part of the implementation
  ],
  [
    #text(weight: "medium")[Properties]
    - Ways to access/change object's state
    - Part of the public API
    - First-class language feature in Kotlin
    - Can have custom getters/setters
  ]
)

#compact-note-block[
  Kotlin enforces good OOP practices by requiring all state access through properties,
  allowing implementation details to change without affecting the API.
]

== Kotlin OOP Basics -- Properties

#text(size: 16pt)[
```kotlin
class Foo {
    val bar = 1
    var baz: String? = null
    val bazLength: Int // Property with no "backing field"
        get() = baz?.length ?: 0 // As its value will be computed every time
    var stringRepresentation: String = "" // Backing fields is generated
        get() = baz ?: field
        set(value) {
            // Access to backing field via `field` keyword
            field = "custom: $value"
        }

}
val foo = Foo()
foo.bar = 3
foo.stringRepresentation
foo.stringRepresentation = "zed"```
]

== Kotlin OOP Basics -- Backing Fields

- The keyword "field" lets you access the backing field of a property (if one exists).
- The Kotlin compiler generates backing fields only when needed.
```kotlin
class Student {
    var id: String? = null // Backing field generated
    val identifierOnce: String = "Student[${id ?: "unknown"}]" // Backing field generated
    val identifierUpdated: String get() = "Student[${id ?: "unknown"}]" // No backing field
}
```

- When you design with Kotlin, you must consider methods and properties, and forgot about fields.

== Kotlin OOP Basics -- Methods
- Methods are defined as functions within the scope of a class, with an implicit receiver (this).

#text(size: 16pt)[
```kotlin
class MutableComplex {
    var real: Double = 0.0
    var imaginary: Double = 0.0
    fun plus(other: MutableComplex): MutableComplex {
      this.real += other.real
      this.imaginary += other.imaginary
      return this
    }
}
val foo = MutableComplex()
foo.real = 1.0; foo.imaginary = 2.0
val bar = MutableComplex()
bar.real = 4.1; bar.imaginary = 0.1
val baz = foo.plus(bar)
"${baz.real}+${baz.imaginary}i"
```]

== Kotlin OOP Basics -- Interfaces
Similar to Java 8+
- Methods can have default implementations
- Interfaces can host properties
  - Property accessors can be defined, although no backing fields exist
- Both properties and methods can provide concrete implementations
- A Kotlin interface cannot be a subclass of a Kotlin class
#text(size: 16pt)[
```kotlin
interface Shape {
    val area: Double
    fun rotate(degrees: Double) = println("Rotating by $degrees degrees")
}
```]

== Kotlin OOP Basics -- Inheritance
- Much like Java. Subtyping keyword is :, overrides must be marked with override
```kotlin
class Circle() : Shape { // : is the subtyping keyword
  val radius: Double = 1.0
  override val area: Double
      get() = PI * radius * radius
}
```
- A call to super can be qualified to disambiguate between conflincting interface declarations:
```kotlin
interface A { fun foo() = "foo" }
interface B { fun foo() = "bar" }
class C : A, B { override fun foo() = super<A>.foo() + super<B>.foo() }
C().foo()
```


== Kotlin OOP Basics -- Construct and init
- Differently from Java, Kotlin define the constructor in the class header

```kotlin
class Foo(
    val bar: String, // This is a val property of the class
    var baz: Int, // This is a var property of the class
    greeting: String = "Hello from constructor" // non-property constructor parameter. Default values allowed
) {
    init {
        println(greeting) // This is the constructor body
    }
}
Foo("bar", 0)
```

== Kotlin OOP Basics -- Secondary Constrcturs
More constructors can be added to a class, but they must obey these rules:

- They must call another constructor.
- The primary constructor must be part of the delegation call chain.
- A call to another constructor is performed using the colon (:) notation.

```kotlin
class Foo(val bar: String) {
    constructor(longBar: Long) : this("number ${longBar.toString()}")
    constructor(intBar: Int) : this(intBar.toLong())
}
Foo(1).bar // number 1
```
== Kotlin OOP Basics -- Nullability and Late Initialization

  ```kotlin
  // Bad: Nullable references
  class Father(var son: Son? = null)

  // Better: lateinit
  class Father {
    lateinit var son: Son
    // Compiler ensures initialization before use
  }
  ```

  *Key Points:*
  - Avoid nullability when possible
  - `lateinit` promises initialization later
  - Raises exception if accessed before initialization


== Kotlin OOP Basics -- Inheritance and Visibility Controls
#text(size: 16pt)[
```kotlin
// Inheritance must be explicit
open class Base 
class Derived : Base() 

// Visibility modifiers
class Example(
  private val id: Int,
  internal val data: String
) {
  protected var state = 0
    private set // Restrict setter
}
```
]
  *Visibility Levels:*
  - `public` (default): Everywhere
  - `internal`: Within module
  - `protected`: Subclasses only
  - `private`: Within class


== Kotlin OOP Basics -- Operators, Companions and object
#text(size: 16pt)[
  ```kotlin
  object A { val x: Int = 10 } // Singleton object
  class Example {
    companion object { // Companion object, namely a singleton instance of the class
      fun create() = Example()
    }
    infix fun with(other: String) = "Combined: $other"
  }
  // Usage
  val result = Example() with "Test"
  val instance = Example.create()
  result == "Combined: Test" // true, 
  instance === Example() // true
  ```]
  *Highlights:*
  - `==` calls `equals()`
  - `===` for reference comparison
  - `infix` requires explicit keyword
  - Companion objects for class-level members
  == Kotlin Operator Overloading

  #grid(
    columns: (1fr, 1fr),
    gutter: 16pt,
    [
      #text(weight: "medium")[Unary & Invoke]
      #table(
        columns: (auto, auto),
        align: (center, left),
        [`+x`], [`unaryPlus()`],
        [`-x`], [`unaryMinus()`],
        [`++x/x++`], [`inc()`],
        [`--x/x--`], [`dec()`],
        [`!x`], [`not()`],
        [`x()`], [`invoke()`]
      )
    ],
    [
      #text(weight: "medium")[Binary & Assignment]
      #table(
        columns: (auto, auto),
        align: (center, left),
        [`x + y`], [`plus(y)`],
        [`x - y`], [`minus(y)`],
        [`x * y`], [`times(y)`],
        [`x / y`], [`div(y)`],
        [`x % y`], [`rem(y)`],
        [`x += y`], [`plusAssign(y)`]
      )
    ]
  )

  #grid(
    columns: (1fr, 1fr),
    gutter: 16pt,
    [
      #text(weight: "medium")[Comparison]
      #table(
        columns: (auto, auto),
        align: (center, left),
        [`x == y`], [`equals(y)`],
        [`x > y`], [`compareTo(y) > 0`],
        [`x < y`], [`compareTo(y) < 0`],
        [`x >= y`], [`compareTo(y) >= 0`],
        [`x <= y`], [`compareTo(y) <= 0`]
      )
    ],
    [
      #text(weight: "medium")[Indexing & Other]
      #table(
        columns: (auto, auto),
        align: (center, left),
        [`x..y`], [`rangeTo(y)`],
        [`x in y`], [`y.contains(x)`],
        [`x[y]`], [`get(y)`],
        [`x[y] = z`], [`set(y, z)`]
      )
      
    
    ]
  )

== Kotlin OOP Basics -- Generics

  Similar to Java generics

  ```kotlin
  class Foo<A, B : CharSequence>
  fun <T : Comparable<T>> maxOf3(first: T, second: T, third: T): T = when {
      first >= second && first >= third -> first
      second >= third -> second
      else -> third
  }
  ```

  - Type upper bounds can be specified with `:`
  - If no bound is specified, the generic is *nullable*!

  ```kotlin
  fun <T> className(receiver: T) = receiver::class.simpleName
  // error: expression in a class literal has a nullable type 'T', use !! to make the type non-nullable
  ```



=== `where` Clause

  In case multiple bounds are present, the definition can become cumbersome.
  
  Kotlin provides a `where` keyword to specify type bounds separately.
#text(size: 16pt)[
```kotlin
interface NavigationStrategy<T, P, A, L, R, N, E>
    where P : Position<P>, P : Vector<P>,
          A : GeometricTransformation<P>,
          L : ConvexGeometricShape<P, A>,
          N : ConvexGeometricShape<P, A> {
    // Interface content, if any
}

fun <T, P, A, L, R, N, E> navigationStrategy()
    where P : Position<P>, P : Vector<P>,
          A : GeometricTransformation<P>,
          L : ConvexGeometricShape<P, A>,
          N : ConvexGeometricShape<P, A> = TODO()
```
]

== Variance and Type Projection

  Kotlin supports variance using:
  - `<out T>` (covariance, similar to Java's `<? extends T>`)
  - `<in T>` (controvariance, similar to Java's `<? super T>`)
  - `<*>` (similar to Java's `<?>`)

  Type variance is expressed *at declaration site*!
  - In Java, type variance is only for methods
  - In Kotlin, type variance is only for classes and interfaces

  ```kotlin
  interface ProduceAndConsume<in X, out Y> {
      fun consume(x: X): Any = TODO() // OK
      fun consume2(y: Y): Any = TODO() // Error: Y is 'out' but in 'in' position
      fun produce(): Y = TODO() // OK
      fun produce2(): X = TODO() // Error: X is 'in' but in 'out' position
  }
  ```


== Type Reification

  Generic runtime strategies:
  - *Erasure*: Generic info discarded at runtime (Java/Scala)
  - *Monomorphization*: Concrete types emitted when used (Rust/C`#`)

  Kotlin uses erasure, but allows local monomorphization via `inline` and `reified`:

  ```kotlin
  inline fun <reified T> checkIsType(a: Any): Boolean = a is T
  checkIsType<Long>(1) // false
  checkIsType<Long>(1L) // true
  ```

  Caveats:
  - `inline` functions only work in Kotlin-compiled code
  - `reified` requires inlining
  - Limited Java interoperability


== Collection Characteristics
Kotlin collections is extensive and feature-rich (backend by Java collections):
  - `List`, `Set`, `Map` are *unmodifiable* but not guaranteed *immutable*
  - Mutable collections via `Mutable`(`List`/`Set`/`Map`)
  - Functional manipulations return new collections
  - Type usually returned as `List`
  - `Sequence`s prevent collection creation at each step
  - `Flow`s for parallel processing

  Creation via functions:
  - `flowOf`
  - `listOf`
  - `mapOf`
  - `sequenceOf`
  - `setOf`

= Kotlin for Compose 

== Kotlin for Compose -- Data Classes

- Data classes in Kotlin provide concise syntax for classes whose main purpose is to hold data.
- Auto-generated functions include toString, equals, hashCode, and copy 
- Compared to Java, data classes reduce boilerplate and enhance readability.

#grid(
  columns: (1fr, 1fr),
  gutter: 16pt,
  [
    #text(weight: "medium")[Kotlin Data Class]
    #text(size: 16pt)[
    ```kotlin
    data class Person(
      val name: String, val age: Int
    )
    
    fun main() {
        val alice = Person("Alice", 30)
        val bob = alice.copy(name = "Bob")
        // Person(name=Alice, age=30)
        println(alice) 
        println(bob) // Person(name=Bob, age=30)
    }
    ```]
  ],
  [
    #text(weight: "medium")[Java Equivalent]
    #text(size: 8pt)[
    ```java
    public final class Person {
        private final String name;
        private final int age;    
        public Person(String name, int age) {
            this.name = name;
            this.age = age;
        }
        public String getName() { return name; }
        public int getAge() { return age; }
        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Person)) return false;
            Person person = (Person) o;
            return age == person.age && name.equals(person.name);
        }
        @Override
        public int hashCode() { return Objects.hash(name, age); }
        @Override
        public String toString() {
            return "Person(name=" + name + ", age=" + age + ")";
        }
    }

    ```]
  ]
)


== Kotlin for Compose -- Delegation

#compact-styled-block(
  [
    #text(weight: "bold")[Favour composition over inheritance]
    
    #fa-quote-left() #text(style: "italic")[A should extend B only if A truly 'is-a' B, if not, *use composition* instead, which means A should hold a reference of B and expose a simpler API.] #fa-quote-right()
    
    #text(style: "italic", size: 0.9em)[— J. Bloch, Effective Java, Item 16]
  ],
  icon: fa-lightbulb(),
  fill-color: rgb("#e8f5e9"),
  stroke-color: rgb("#81c784")
)

#v(12pt)

- *Delegation* is one of the mechanisms to implement composition..
  - But it is often verbose and very mechanic in implementation:

#text(size: 16pt)[
```kotlin
data class Student(val name: String, val surname: String, val id: String)
class Exam : MutableCollection<Student> {
    private val representation = mutableListOf<Student>()
    override fun add(e E) = representation.add(e)
    .. // BOOOORING
}
```]

== Kotlin for Compose -- Delegation via `by`

Kotlin supports delegation at the language level

```kotlin
data class Student(val name: String, val surname: String, val id: String)

class Exam : MutableCollection<Student> by mutableListOf<Student>() {
    fun register(name: String, surname: String, id: String) = 
      add(Student(name, surname, id))
    override fun toString() = toList().toString() // No access to the delegate! `toString` unavailable!
}
val exam = Exam()
exam.register("Gianluca", "Aguzzi", "00000025")
exam // [Student(name=Gianluca, surname=Aguzzi, id=00000025)]
exam.clear()
exam // []
```

== Kotlin for Compose -- Delegated Properties and Variables

Properties and variables can be delegated as well.
Some delegates are built-in, e.g. `lazy`

```kotlin
val someLazyString by lazy {
    println("I'm initializing myself")
    "I'm intialized"
}
println("Doing stuff")
println(someLazyString) // "I'm initializing myself" gets printed here
```

== Kotlin for Compose -- Delegation via Maps

Class properties can be stored in an appropriate `Map`.
Useful when dealing with dynamic languages or untyped serialization (e.g. JSON or YAML)

```kotlin
val fromJson = mapOf("name" to "John Smith", "birthYear" to 2020)
class Person(val jsonRepresentation: Map<String, Any>) {
    val name by jsonRepresentation
    val birthYear: Int by jsonRepresentation
    override fun toString() = "\$name born in \$birthYear"
}
Person(fromJson)
```

== Kotlin for Compose -- Delegation via Maps and Mutability

In case of mutable properties, a `MutableMap` is required as delegate

```kotlin
val janesJson: MutableMap<\String, Any> = mutableMapOf("name" to "Jane Smith", "birthYear" to 1999)
class MutablePerson(val jsonRepresentation: MutableMap<\String, Any>) {
    var name by jsonRepresentation
    var birthYear: Int by jsonRepresentation
    override fun toString() = "\$name born in \$birthYear"
}
val jane = MutablePerson(janesJson)
jane.toString()
jane.name = "Janet Smitherson"
jane.toString()
janesJson // Does it change? {name=Janet Smitherson, birthYear=1999} -- YES! Bidirectional
```

== Kotlin for Compose -- Custom Delegates

A valid delegate for a `val` is a `class` with a method:
```kotlin
operator fun getValue(thisRef: T, property: KProperty<*>): R
```
where T is the "owner" type, and R is the type of the property

A valid delegate for a `var` must also have a `setValue` method:
```kotlin
operator fun setValue(thisRef: T, property: KProperty<*>, value: P): R
```
where T and R are the same as in `getValue`, and P is a supertype of R

== Kotlin for Compose -- Lambda Expressions

Kotlin lambda expression's syntax is inspired by Groovy
and is similar to Smalltalk / Ceylon / Xtend / Ruby as well:
- Enclosing an expression in curly brackets creates a lambda expression
- Parameters are listed *inside* the brackets, a `->` separates them from the body
- If there is one single parameter, it can be unspecified and referred with the keyword `it`

#text(size: 15pt)[
```kotlin
val myLambda = {
    println("Hey I'm computing")
}
fun whatsMyReturnType() = {
    "A string"
}
myLambda.invoke() // Java-style invocation
myLambda() // Decent-style invocation (invoke is an operator!)
myLambda()() // Guess error: expression 'myLambda()' of type 'Unit' cannot be invoked as a function.
whatsMyReturnType() // Subtle, but the compiler raises warnings
whatsMyReturnType()() // A string```
]
== Kotlin for Compose -- Function Type Literals

Kotlin supports function type literals, eliminating the need for verbose Java interfaces like `Function<T, R>`, `BiConsumer<T, R>`, etc.

Function type literals have parameter types in parentheses, a `->`, and the return type:
- `() -> Any` -- 0-ary function returning `Any`
- `(String) -> Any` -- Unary function taking a `String` and returning `Any`
- `(String, Int) -> Unit` -- Binary function taking a `String` and an `Int` and returning `Unit`
- `(String, Int?) -> Any?` -- Binary function taking a `String` and a nullable `Int?` returning a nullable `Any?`

```kotlin
fun <T, I, R> compose(f: (I) -> R, g: (T) -> I): (T) -> R = { f(g(it)) }
compose({v: Int -> v * v}, {v: Double -> v.toInt()})(3.9) // 9
```

== Kotlin for Compose -- Function References

- *Function references* allow treating functions as values using the `::` operator
- *Syntax*: 
  - `::functionName` for top-level functions
  - `ReceiverType::functionName` for extension functions
  - `instanceRef::memberFunction` for member functions


```kotlin
fun <T, I, R> compose(f: (I) -> R, g: (T) -> I): (T) -> R = { f(g(it)) }
fun square(v: Int) = v * v
fun floor(v: Double) = v.toInt()
compose(::square, ::floor)(3.9)
```

== Kotlin for Compose -- The Trailing Lambda Convention

#styled-block(
  "The Trailing Lambda Convention", 
  [
    Kotlin convention that improves readability:
    
    #text(style: "italic")[When a lambda is the last parameter, it can be placed outside the parentheses.]
    
    This simple rule enables elegant DSL-like syntax that feels like creating custom language constructs.
  
  ],
  icon: fa-code() + h(0.4em),
  fill-color: rgb("#e3f2fd"),
  stroke-color: rgb("#90caf9"),
  title-color: rgb("#1565c0")
)
#text(size: 12pt)[
```kotlin
fun delayed(delay: Long = 1000L, operation: () -> Unit) = Thread {
    Thread.sleep(delay); operation()
}.start()
println("Start")
// Now we have a delayed block!
delayed {
    println("I was waiting")
}
delayed(300) { println("I wait less") }
println("Finished")
```]

== Kotlin for Compose -- Closures

- Closures are supported and can capture both mutable and immutable variables.
- Unlike Java, Kotlin allows modification of captured variables.

#grid(
  columns: (1fr, 1fr),
  gutter: 16pt,
  [
    #text(weight: "medium")[Kotlin]
    ```kotlin
    // Modifying captured variable - works fine
    var sum = 0
    (0..100).map {
        sum += it  // Modifies outer variable
        it * 2
    }
    println(sum)  // 5050
    ```
  ],
  [
    #text(weight: "medium")[Java]
    ```java
    // Java requires effectively final variables
    int sum = 0;  // Not final
    List.of(1, 2, 3).stream().map(it -> {
        sum += it;  // Error: Variable used in lambda
                    // should be final or effectively final
        return it * 2;
    });
    ```
  ]
)

== Kotlin for Compose -- Flow Control with Lambdas

Kotlin rule: `return` returns from the closest *named* function

```kotlin
fun breakingFlow(): List<Int> = (0..10).toList().map {
    if (it > 4) {
        return (0..it).toList() // returns from breakingFlow
    }
    it
}
breakingFlow()
```

== Kotlin for Compose -- Destructuring Lambda Parameters

Lambda parameters can be destructured

```kotlin
mapOf(46 to "Rossi", 4 to "Dovizioso").map { (number, rider) ->
    // destructured Pair
    "$rider has number $number"
}
```

== Kotlin for Compose -- Extension Functions

Kotlin allows to extend any type capabilities from anywhere via _extension functions_

#text(size: 12pt)[
```kotlin
fun String.containsBatman(): Boolean = 
  ".*b.*a.*t.*m.*a.*n.*".toRegex().matches(this)
"nanananan batman".containsBatman() // true
```]

Inside extension functions, the *receiver* of the method is overridden\
Any type, including nullables, can be extended (object`s and `companion`s)
`

#compact-warning-block(
  [*IMPORTANT*: calls to extension methods are resolved *statically*.\
   Namely, *the receiver type is determined at compile time*.],
  icon: fa-exclamation-circle() + " "
)
#compact-warning-block(
  [*IMPORTANT/2*: Extensions cannot shadow members,\
   *members always take priority*],
  icon: fa-exclamation-triangle() + " "
)

== Kotlin for Compose -- Extension Properties

Same as functions, but for properties

```kotlin
val String.containsBatman get(): Boolean = 
  ".*b.*a.*t.*m.*a.*n.*".toRegex().matches(this)
"nananananana batman".containsBatman // true
```

Note:
1. extension properties cannot have backing fields
2. extension properties can't get initialized,
their behaviour is entirely specified by `get` and `set` accessors.

== Kotlin for Compose -- Extension Function Type Literals

Extensions functions are... functions, like any other as such, their type can be legally expressed by:
- prefixing the *receiver type*
- following by a `.`
- then list parameters and return types as for any function type literal

#text(size: 12pt)[
```kotlin
// Extension function taking an extension function as parameter
fun <T> MutableList<T>.configure(configuration: MutableList<T>.() -> Unit): MutableList<T> {
    configuration()
    return this
}
// We are creating a configuration block!
mutableListOf<String>().configure {
    add("Pippo")
    add("Pluto")
    add("Paperino")
}
```]

... sounds easy to write DSLs ...

== Kotlin for Compose -- Extension Members and Implicit Receivers

When extensions are defined as members, there are multiple *implicit receivers*:
1. _dispatch receiver_: the `object` or instance of the `class` in which the extension is declared
2. -extension receiver- the instance of the *receiver type* of the extension is called

*Extension receivers have priority*, dispatch receivers access requires the *qualified `this`* syntax

#text(size: 12pt)[
```kotlin
object Batman { // the Batman object is the dispatch receiver
    val name = "Batman"
    val String.Companion.intro get() = generateSequence { Double.NaN } // String.Companion is extension receiver
        .take(10)
        .joinToString(separator = "")
    fun String.withBatman() = "$this ${ this@Batman.name }!" // Qualified this access to the dispatch receiver
}
```]

== Kotlin for Compose -- DSL Scope Control via Extension Members

Extension members are visible only when the dispatch receiver is the type where the extensions were defined\
This enables a powerful form of *scope control*

#text(size: 12pt)[
```kotlin
object Batman { // Batman is the dispatch receiver
    val name = "Batman"
    val String.Companion.intro get() = generateSequence { Double.NaN } // String is extension receiver
        .take(10)
        .joinToString(separator = "")
    fun String.withBatman() = "$this ${ this@Batman.name }!" // Qualified this access to the dispatch receiver
}
// Extension members are actual members! They require a receiver!
String.intro.withBatman() // error: unresolved reference: intro
fun <T, R> insideTheScopeOf(receiver: T, method: T.() -> R): R = receiver.method()
insideTheScopeOf(Batman) { // inside this function, Batman is the dispatch receiver!
    String.intro.withBatman() // OK!
}
```]

== Kotlin for Compose -- Scope Functions

Kotlin provides a number of built-in functions that run a lambda expression in a custom scope:
- by changing the receiver (as we've done with `insideTheScopeOf` in the previous slide)
- by creating an implicit `it` parameter
- by changing the return type

=== Kotlin for Compose -- `let`: `T.((T) -> R) -> R`

Can be invoked on an object, passing a lambda expression.\
The method receiver is bound to the lambda parameter\
the return type is the result of the function

```kotlin
1.let { "${it + 1}1" } // 21: String
1.let { one -> "${one + 1}1" } // Same as above: it's a normal lambda
```

=== Kotlin for Compose -- `run`: `T.(T.() -> R) -> R`

Can be invoked on an object, passing a lambda expression.\
The method receiver is bound to the implicit receiver `this`\
the return type is the result of the function

```kotlin
1.run { "${this + 1}1" } // 21: String
```

=== Kotlin for Compose -- `with`: `(T.() -> R) -> R`

Non-extension version of `run`,\
the context object is passed as first parameter\
The method receiver is bound to the implicit receiver `this`\
the return type is the result of the function

```kotlin
with(1) { "${this + 1}1" } // 21: String
```

=== Kotlin for Compose -- `apply`: `T.(T.() -> Unit) -> T`

Similar to `run`, but returns the context object\
Used to cause side effects from a specific context, and returning the original object

#text(size: 14pt)[
```kotlin
1.apply { println("${this + 1}1") } // Prints 21, returns 1
mutableListOf<Int>().apply {
    addAll((1..10).toList())
} // [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
```
]
=== Kotlin for Compose -- `also`: `T.((T) -> Unit) -> T`

Similar to `apply`, but does not change the context,\
the context object is bound to the first lambda parameter\
Used to cause side effects and returning the original object

```kotlin
1.also { println("${it + 1}1") } // Prints 21, returns 1
```

= Kotlin Advanced 

==  Kotlin Advanced -- Destructuring Declarations

If a class has `operator` functions named called `componentX` with `X` an integer from `1`,
they can be "destructured".

This feature is *way* less powerful than Scala's pattern matching.

#grid(
  columns: (1fr, 1fr),
  gutter: 16pt,
  [
    #text(weight: "medium")[Destructuring Pairs]
    ```kotlin
    val ferrari2021 = "Ferrari" to Pair("Sainz", "Leclerc")
    val (team, lineup) = ferrari2021
    team // "Ferrari"
    lineup // Sainz to Leclerc
    val (driver1, driver2) = lineup
    driver1 // Sainz
    driver2 // Leclerc
    ```
  ],
  [
    #text(weight: "medium")[Custom Component Functions]
    ```kotlin
    class A {
        operator fun component1() = 1
        operator fun component2() = 2
        operator fun component3() = 3
    }
    val (a, b, c) = A()
    ```
  ]
)

== Kotlin Advanced -- Sealed Hierarchies
- classes, not supported for interfaces -- Supported since Kotlin 1.5.0
- subtypes must be defined inside the sealed class
- sealed hierarchies proved *exhaustive checking* inside `where` clauses

```kotlin
sealed interface Booze {
    object Rum : Booze
    object Whisky : Booze
    object Vodka : Booze
}
fun goGetMeSome(beverage: Booze) = when (beverage) {
    is Booze.Rum -> "Diplomatico"
    is Booze.Whisky -> "Caol Ila"
    is Booze.Vodka -> "Zubrowka"
}
goGetMeSome(Booze.Rum)
```

== Kotlin Advanced -- Object Expressions

`object` expressions replace Java anonymous classes

#grid(
  columns: (1fr, 1fr),
  gutter: 16pt,
  [
    *Java:*
    ```java
    Test anonymousTest = new Test() {
        @Override
        public void first() { }
        
        @Override
        public void second() { }
    };
    ```
  ],
  [
    *Kotlin:*
    ```kotlin
    interface Test {
        fun first(): Unit
        fun second(): Unit
    }
    val anonymousTest = object : Test {
        override fun first() { }
        override fun second() { }
    }
    ```
  ]
)

== Kotlin Advanced  -- Type Aliases

- Types can be aliased
- Only at the top level

```kotlin
typealias Drivers = Pair<\String, String>
typealias Lineup = Pair<\String, Drivers>
typealias F1Season = Map<\String, Drivers>
val `f1 2020`: F1Season = mapOf(
    Team("Ferrari", Drivers("Vettel", "Leclerc")),
    Team("RedBull", Drivers("Versbatten", "Albon")),
    Team("Merdeces", Drivers("Hamilton", "Bottas")),
)
`f1 2020` // Map<String, Pair<String, Pair<String, String>>>
```

== Kotlin Advanced -- What next?
- Kotlin is a very rich language with a lot of features
- We've only scratched the surface
- Some of aother features include:
  - Coroutines
  - Inline classes
  - Contracts
  - Multiplatform projects
  - Coroutines
  - Annotations

== Acknowledgements

#grid(
  columns: (1fr),
  gutter: 16pt,
  [
    #feature-block(
      "Acknowledgements & References", 
      [
        These slides draw inspiration from:
        
        - The work of my colleague at the University of Bologna, Prof. Danilo Pianini
        - Official Kotlin documentation and learning resources
        - JetBrains Kotlin tutorials and guides
        
        #v(8pt)
        #align(center)[
          #link("https://unibo-spe.github.io/02-kotlin/")[Official course slides: unibo-spe.github.io/02-kotlin/]
        ]
        
        #v(8pt)
        #align(center)[
          #text(style: "italic")[Thank you for your attention! Questions?]
        ]
      ],
      icon: fa-book() + " "
    )
  ]
)
