Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2BC343B9E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 09:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhCVIWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 04:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhCVIV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 04:21:58 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9575C061574;
        Mon, 22 Mar 2021 01:21:58 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id j25so10423914pfe.2;
        Mon, 22 Mar 2021 01:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=naDo2B0Y8tb92q/CLEBsTKBW7IXfc6n9te0GLhb7SNU=;
        b=bEMnxfGxLhV/IILGtNRgM83btB+qoaIS8yXE1FuBHFTQim/3LdiDbLTXpv5slDFTay
         cgGwbPfRyU5RBSdOjbzLy2f1NeBTmTHaUqHtSqsX3BKHgtxUekdF5blBjKCMK3Zi07TO
         KK3vJ6jYhDUe9wf7atXEf4lYKzk2Om9918FyIlRB9ma62GKbDAhXXSX9yhfh0kdVG9Pe
         G/HVVu+GyJFhLFE3TQs+ehL2swuFh9gUNSpMTT+bK4bp2C4a6yS7ALZu2V0HfV5r0r87
         jC6aQ/QRZP8BYjqdpfQy6b2myE/qtscfcjCKriI8AUf90J+sWfeVJI0uNHnI+pyjYku7
         gS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=naDo2B0Y8tb92q/CLEBsTKBW7IXfc6n9te0GLhb7SNU=;
        b=py6WfLVu6H5YisqtZeTwPuWwQ31dcbDVryxReXo23bsghtSLuILwSX1rdaGHzMKOiw
         EQJvfLpsjCNVy/AO/rA6nIfM6YaZYOoqe64lDGPybhXgUv2DtXEP/NqzeGcrMMiWvEkP
         XBDd2E8g/ijsET1sB46yrp+gnfN7mdyxJqYk2v9O5/rZc9diIn7v9kPXNsfF+ttxvF3Z
         BQm+ioteVIJ1US7Dy2FW+eOLNSsnOl5RXg3xaDytxY3lcoUC38NzHf3j6jKVfrmzIU0+
         s7bsJl+7RdM1LCqDWcuSXxZsJ0IvwKZRfAapASroO1q6hLGjkgSGPN5FOU+ozPw/t5B1
         IWKQ==
X-Gm-Message-State: AOAM533HS275zMdf+YhJzUwb6vpaZ5QhNGkU/8H9UBzPxTBwHdOQ8mqh
        xMUQ8Y6bCKnJyvX/hrIBm80=
X-Google-Smtp-Source: ABdhPJwvlsx8osU+sC6YU/KnPX5CJDbv4Aae1xAWshTvDEpJltz9l5vNqbaGR5vDezAXOolBjF448g==
X-Received: by 2002:a05:6a00:2288:b029:202:2103:3f21 with SMTP id f8-20020a056a002288b029020221033f21mr20372411pfe.39.1616401317903;
        Mon, 22 Mar 2021 01:21:57 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:9004:6aab:d12f:590e:aee7:abf4])
        by smtp.gmail.com with ESMTPSA id r10sm13504113pfq.216.2021.03.22.01.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 01:21:57 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     corbet@lwn.net, mchehab@kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH -next v4] docs: document all error message types in checkpatch
Date:   Mon, 22 Mar 2021 13:51:39 +0530
Message-Id: <20210322082139.33822-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the error message types now have a verbose description.

Also there are two new groups of message types:

- Macros, Attributes and Symbols
- Functions and Variables

Rearrange the message types to fit these new groups as needed.

Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---

Changes in v4:
- Use lore.kernel.org links
- modify explanation for DEFINE_ARCH_HAS

Changes in v3:
- Add more explanation for LOCKDEP
- Minor grammar fixes

Changes in v2:
- Replace 4.10 kernel doc links by latest

 Documentation/dev-tools/checkpatch.rst | 318 ++++++++++++++++++++++---
 1 file changed, 280 insertions(+), 38 deletions(-)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index 2671e54c8320..51fed1bd72ec 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -280,43 +280,12 @@ API usage
     However this is not always the case (See signal.h).
     This message type is emitted only for includes from arch/.
 
-  **ARRAY_SIZE**
-    The ARRAY_SIZE(foo) macro should be preferred over
-    sizeof(foo)/sizeof(foo[0]) for finding number of elements in an
-    array.
-
-    The macro is defined in include/linux/kernel.h::
-
-      #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
-
   **AVOID_BUG**
     BUG() or BUG_ON() should be avoided totally.
     Use WARN() and WARN_ON() instead, and handle the "impossible"
     error condition as gracefully as possible.
     See: https://www.kernel.org/doc/html/latest/process/deprecated.html#bug-and-bug-on
 
-  **AVOID_EXTERNS**
-    Function prototypes don't need to be declared extern in .h
-    files.  It's assumed by the compiler and is unnecessary.
-
-  **AVOID_L_PREFIX**
-    Local symbol names that are prefixed with `.L` should be avoided,
-    as this has special meaning for the assembler; a symbol entry will
-    not be emitted into the symbol table.  This can prevent `objtool`
-    from generating correct unwind info.
-
-    Symbols with STB_LOCAL binding may still be used, and `.L` prefixed
-    local symbol names are still generally usable within a function,
-    but `.L` prefixed local symbol names should not be used to denote
-    the beginning or end of code regions via
-    `SYM_CODE_START_LOCAL`/`SYM_CODE_END`
-
-  **BIT_MACRO**
-    Defines like: 1 << <digit> could be BIT(digit).
-    The BIT() macro is defined in include/linux/bitops.h::
-
-      #define BIT(nr)         (1UL << (nr))
-
   **CONSIDER_KSTRTO**
     The simple_strtol(), simple_strtoll(), simple_strtoul(), and
     simple_strtoull() functions explicitly ignore overflows, which
@@ -325,6 +294,25 @@ API usage
     correct replacements.
     See: https://www.kernel.org/doc/html/latest/process/deprecated.html#simple-strtol-simple-strtoll-simple-strtoul-simple-strtoull
 
+  **LOCKDEP**
+    The lockdep_no_validate class was added as a temporary measure to
+    prevent warnings on conversion of device->sem to device->mutex.
+    It should not be used for any other purpose.
+    See: https://lore.kernel.org/lkml/1268959062.9440.467.camel@laptop/
+
+  **MALFORMED_INCLUDE**
+    The #include statement has a malformed path.  This has happened
+    because the author has included a double slash "//" in the pathname
+    accidentally.
+
+  **USE_LOCKDEP**
+    lockdep_assert_held() annotations should be preferred over
+    assertions based on spin_is_locked()
+    See: https://www.kernel.org/doc/html/latest/locking/lockdep-design.html#annotations
+
+  **UAPI_INCLUDE**
+    No #include statements in include/uapi should use a uapi/ path.
+
 
 Comment style
 -------------
@@ -353,7 +341,6 @@ Comment style
     See: https://www.kernel.org/doc/html/latest/process/coding-style.html#commenting
 
 
-
 Commit message
 --------------
 
@@ -397,6 +384,35 @@ Commit message
     source patch.
     See: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
 
+  **DIFF_IN_COMMIT_MSG**
+    Avoid having diff content in commit message.
+    This causes problems when one tries to apply a file containing both
+    the changelog and the diff because patch(1) tries to apply the diff
+    which it found in the changelog.
+    See: https://lore.kernel.org/lkml/20150611134006.9df79a893e3636019ad2759e@linux-foundation.org/
+
+  **GERRIT_CHANGE_ID**
+    To be picked up by gerrit, the footer of the commit message might
+    have a Change-Id like::
+
+      Change-Id: Ic8aaa0728a43936cd4c6e1ed590e01ba8f0fbf5b
+      Signed-off-by: A. U. Thor <author@example.com>
+
+    The Change-Id line must be removed before submitting.
+
+  **GIT_COMMIT_ID**
+    The proper way to reference a commit id is:
+    commit <12+ chars of sha1> ("<title line>")
+
+    An example may be::
+
+      Commit e21d2170f36602ae2708 ("video: remove unnecessary
+      platform_set_drvdata()") removed the unnecessary
+      platform_set_drvdata(), but left the variable "dev" unused,
+      delete it.
+
+    See: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
+
 
 Comparison style
 ----------------
@@ -426,6 +442,147 @@ Comparison style
     side of the test should be avoided.
 
 
+Macros, Attributes and Symbols
+------------------------------
+
+  **ARRAY_SIZE**
+    The ARRAY_SIZE(foo) macro should be preferred over
+    sizeof(foo)/sizeof(foo[0]) for finding number of elements in an
+    array.
+
+    The macro is defined in include/linux/kernel.h::
+
+      #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
+  **AVOID_EXTERNS**
+    Function prototypes don't need to be declared extern in .h
+    files.  It's assumed by the compiler and is unnecessary.
+
+  **AVOID_L_PREFIX**
+    Local symbol names that are prefixed with `.L` should be avoided,
+    as this has special meaning for the assembler; a symbol entry will
+    not be emitted into the symbol table.  This can prevent `objtool`
+    from generating correct unwind info.
+
+    Symbols with STB_LOCAL binding may still be used, and `.L` prefixed
+    local symbol names are still generally usable within a function,
+    but `.L` prefixed local symbol names should not be used to denote
+    the beginning or end of code regions via
+    `SYM_CODE_START_LOCAL`/`SYM_CODE_END`
+
+  **BIT_MACRO**
+    Defines like: 1 << <digit> could be BIT(digit).
+    The BIT() macro is defined in include/linux/bitops.h::
+
+      #define BIT(nr)         (1UL << (nr))
+
+  **CONST_READ_MOSTLY**
+    When a variable is tagged with the __read_mostly annotation, it is a
+    signal to the compiler that accesses to the variable will be mostly
+    reads and rarely(but NOT never) a write.
+
+    const __read_mostly does not make any sense as const data is already
+    read-only.  The __read_mostly annotation thus should be removed.
+
+  **DATE_TIME**
+    It is generally desirable that building the same source code with
+    the same set of tools is reproducible, i.e. the output is always
+    exactly the same.
+
+    The kernel does *not* use the ``__DATE__`` and ``__TIME__`` macros,
+    and enables warnings if they are used as they can lead to
+    non-deterministic builds.
+    See: https://www.kernel.org/doc/html/latest/kbuild/reproducible-builds.html#timestamps
+
+  **DEFINE_ARCH_HAS**
+    The ARCH_HAS_xyz and ARCH_HAVE_xyz patterns are wrong.
+
+    For big conceptual features use Kconfig symbols instead.  And for
+    smaller things where we have compatibility fallback functions but
+    want architectures able to override them with optimized ones, we
+    should either use weak functions (appropriate for some cases), or
+    the symbol that protects them should be the same symbol we use.
+    See: https://lore.kernel.org/lkml/CA+55aFycQ9XJvEOsiM3txHL5bjUc8CeKWJNR_H+MiicaddB42Q@mail.gmail.com/
+
+  **INIT_ATTRIBUTE**
+    Const init definitions should use __initconst instead of
+    __initdata.
+
+    Similarly init definitions without const require a separate
+    use of const.
+
+  **INLINE_LOCATION**
+    The inline keyword should sit between storage class and type.
+
+    For example, the following segment::
+
+      inline static int example_function(void)
+      {
+              ...
+      }
+
+    should be::
+
+      static inline int example_function(void)
+      {
+              ...
+      }
+
+  **MULTISTATEMENT_MACRO_USE_DO_WHILE**
+    Macros with multiple statements should be enclosed in a
+    do - while block.  Same should also be the case for macros
+    starting with `if` to avoid logic defects::
+
+      #define macrofun(a, b, c)                 \
+        do {                                    \
+                if (a == 5)                     \
+                        do_this(b, c);          \
+        } while (0)
+
+    See: https://www.kernel.org/doc/html/latest/process/coding-style.html#macros-enums-and-rtl
+
+  **WEAK_DECLARATION**
+    Using weak declarations like __attribute__((weak)) or __weak
+    can have unintended link defects.  Avoid using them.
+
+
+Functions and Variables
+-----------------------
+
+  **CAMELCASE**
+    Avoid CamelCase Identifiers.
+    See: https://www.kernel.org/doc/html/latest/process/coding-style.html#naming
+
+  **FUNCTION_WITHOUT_ARGS**
+    Function declarations without arguments like::
+
+      int foo()
+
+    should be::
+
+      int foo(void)
+
+  **GLOBAL_INITIALISERS**
+    Global variables should not be initialized explicitly to
+    0 (or NULL, false, etc.).  Your compiler (or rather your
+    loader, which is responsible for zeroing out the relevant
+    sections) automatically does it for you.
+
+  **INITIALISED_STATIC**
+    Static variables should not be initialized explicitly to zero.
+    Your compiler (or rather your loader) automatically does
+    it for you.
+
+  **RETURN_PARENTHESES**
+    return is not a function and as such doesn't need parentheses::
+
+      return (bar);
+
+    can simply be::
+
+      return bar;
+
+
 Spacing and Brackets
 --------------------
 
@@ -439,7 +596,7 @@ Spacing and Brackets
     and put the closing brace first::
 
       if (x is true) {
-        we do y
+              we do y
       }
 
     This applies for all non-functional blocks.
@@ -448,7 +605,7 @@ Spacing and Brackets
 
       int function(int x)
       {
-        body of function
+              body of function
       }
 
     See: https://www.kernel.org/doc/html/latest/process/coding-style.html#placing-braces-and-spaces
@@ -485,29 +642,114 @@ Spacing and Brackets
 
       printk(KERN_INFO "bar");
 
+  **ELSE_AFTER_BRACE**
+    `else {` should follow the closing block `}` on the same line.
+    See: https://www.kernel.org/doc/html/latest/process/coding-style.html#placing-braces-and-spaces
+
   **LINE_SPACING**
     Vertical space is wasted given the limited number of lines an
     editor window can display when multiple blank lines are used.
     See: https://www.kernel.org/doc/html/latest/process/coding-style.html#spaces
 
+  **OPEN_BRACE**
+    The opening brace should be following the function definitions on the
+    next line.  For any non-functional block it should be on the same line
+    as the last construct.
+    See: https://www.kernel.org/doc/html/latest/process/coding-style.html#placing-braces-and-spaces
+
+  **POINTER_LOCATION**
+    When using pointer data or a function that returns a pointer type,
+    the preferred use of * is adjacent to the data name or function name
+    and not adjacent to the type name.
+    Examples::
+
+      char *linux_banner;
+      unsigned long long memparse(char *ptr, char **retptr);
+      char *match_strdup(substring_t *s);
+
+    See: https://www.kernel.org/doc/html/latest/process/coding-style.html#spaces
+
   **SPACING**
     Whitespace style used in the kernel sources is described in kernel docs.
     See: https://www.kernel.org/doc/html/latest/process/coding-style.html#spaces
 
+  **SWITCH_CASE_INDENT_LEVEL**
+    switch should be at the same indent as case.
+    Example::
+
+      switch (suffix) {
+      case 'G':
+      case 'g':
+              mem <<= 30;
+              break;
+      case 'M':
+      case 'm':
+              mem <<= 20;
+              break;
+      case 'K':
+      case 'k':
+              mem <<= 10;
+              /* fall through */
+      default:
+              break;
+      }
+
+    See: https://www.kernel.org/doc/html/latest/process/coding-style.html#indentation
+
   **TRAILING_WHITESPACE**
     Trailing whitespace should always be removed.
     Some editors highlight the trailing whitespace and cause visual
     distractions when editing files.
     See: https://www.kernel.org/doc/html/latest/process/coding-style.html#spaces
 
+  **WHILE_AFTER_BRACE**
+    while should follow the closing bracket on the same line::
+
+      do {
+              ...
+      } while(something);
+
+    See: https://www.kernel.org/doc/html/latest/process/coding-style.html#placing-braces-and-spaces
+
 
 Others
 ------
 
-  **CAMELCASE**
-    Avoid CamelCase Identifiers.
-    See: https://www.kernel.org/doc/html/latest/process/coding-style.html#naming
-
   **CONFIG_DESCRIPTION**
     Kconfig symbols should have a help text which fully describes
     it.
+
+  **CORRUPTED_PATCH**
+    The patch seems to be corrupted or lines are wrapped.
+    Please regenerate the patch file before sending it to the maintainer.
+
+  **DOS_LINE_ENDINGS**
+    For DOS-formatted patches, there are extra ^M symbols at the end of
+    the line.  These should be removed.
+
+  **EXECUTE_PERMISSIONS**
+    There is no reason for source files to be executable.  The executable
+    bit can be removed safely.
+
+  **NON_OCTAL_PERMISSIONS**
+    Permission bits should use 4 digit octal permissions (like 0700 or 0444).
+    Avoid using any other base like decimal.
+
+  **NOT_UNIFIED_DIFF**
+    The patch file does not appear to be in unified-diff format.  Please
+    regenerate the patch file before sending it to the maintainer.
+
+  **PRINTF_0XDECIMAL**
+    Prefixing 0x with decimal output is defective and should be corrected.
+
+  **TRAILING_STATEMENTS**
+    Trailing statements (for example after any conditional) should be
+    on the next line.
+    Like::
+
+      if (x == y) break;
+
+    should be::
+
+      if (x == y)
+              break;
-- 
2.30.0

