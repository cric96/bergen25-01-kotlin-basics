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
