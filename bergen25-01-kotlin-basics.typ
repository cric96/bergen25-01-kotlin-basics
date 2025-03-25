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
