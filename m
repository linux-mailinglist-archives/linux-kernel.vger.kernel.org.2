Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE9339C622
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 08:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhFEGCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 02:02:48 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:39586 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFEGCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 02:02:48 -0400
Received: by mail-pl1-f174.google.com with SMTP id q16so5734565pls.6;
        Fri, 04 Jun 2021 23:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0XaU3Q/Ci6RZSexSJmEnPHRXc7/Q5xfyGwjttyzgW0s=;
        b=ZXwu808z5LbPEiROSQ8cll6UBykgArbcM+zo4cO0cBzM5eJF6RjeWScu2xPbW+Tem+
         7hesfM+61tMcQPERSMVmj4dnoUYUFWge76kfzHligLmrToG20h2Oi2HaZHMr+g2rSap2
         M25SERZvzpg44z9x60Zb3EGw/xvhJ5Eh3zrwnVBA2JJTD3m53Jn0USgvDHAvlzJdrvG4
         z3TTfPeccb/eTvW3v7WJ1sr0eMo6xlwbElselBp9L67OzWlMXFOeMgYbFjthISzk+ooJ
         LlU+7omLItmse3L0rD6IA9wYEHz+aJfhtSUaNiFvfmU+CS78cX2iCtOLDbjcDEgEPw+D
         ttBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0XaU3Q/Ci6RZSexSJmEnPHRXc7/Q5xfyGwjttyzgW0s=;
        b=U75Fc8sa4LjEiPvLwidlArGfC8InmrGWGtF6lrU+2PvONiklBtPqOuqrmqXpq7dJFV
         h2Dfllk1mykuEs/YOYyuQRmkE3SNEEJXmK1RWiL2hmBwuGisWPCfkC0vWCTg2YXVqG3B
         3h9EKxExjD7uCVmcbE2Zkg3/YIfZWsZzsr+t66L9kP2CfKCkXdL7baezwKMbrcxrj7AU
         zk0wpelVShAKZ5ENCJIhytuFfGKuBQkiT0iMrVTM+Mo/84k05kVVub2H1KT6btN2MHsN
         fjTmdbgXrpic/EvF+L7csmWjHrdTE1h+9HCpUd02JnmPmp9kICfR++3uPoW9o/hq80eg
         GMUw==
X-Gm-Message-State: AOAM530UIK2mhii4uF5ZZ7OGNZxnnRveYJrto4oeO2NL8h2rtVu/YFY5
        b3cDiQVh6nOGTnwhuz3RHQQvOFeIN5kZaA==
X-Google-Smtp-Source: ABdhPJyjJvNXniz5w2Py1xaBqOYaqpAWQbJStd12fJolYNqPkx3f5RUlxVu7QSxvjkpZozLxE705IA==
X-Received: by 2002:a17:90a:43a6:: with SMTP id r35mr19964238pjg.222.1622872800487;
        Fri, 04 Jun 2021 23:00:00 -0700 (PDT)
Received: from localhost.localdomain ([49.37.1.243])
        by smtp.gmail.com with ESMTPSA id q22sm3073777pfk.215.2021.06.04.22.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 22:59:59 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     corbet@lwn.net, lukas.bulwahn@gmail.com, joe@perches.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: [PATCH] docs: checkpatch: Document and segregate more checkpatch message types
Date:   Sat,  5 Jun 2021 11:29:32 +0530
Message-Id: <20210605055932.18393-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add and document more checkpatch message types. About 50% of all
message types are documented now.

In addition to this:

- Create a new subsection 'Indentation and Line Breaks'.
- Rename subsection 'Comment style' to simply 'Comments'
- Refactor some of the existing types to appropriate subsections.

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 Documentation/dev-tools/checkpatch.rst | 359 ++++++++++++++++++++-----
 1 file changed, 291 insertions(+), 68 deletions(-)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index 87b859f321de..a19cbe45c41d 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -298,6 +298,114 @@ API usage
 
     See: https://www.kernel.org/doc/html/latest/process/deprecated.html#simple-strtol-simple-strtoll-simple-strtoul-simple-strtoull
 
+  **CONSTANT_CONVERSION**
+    Use of __constant_<foo> form is discouraged for the following functions::
+
+      __constant_cpu_to_be[x]
+      __constant_cpu_to_le[x]
+      __constant_be[x]_to_cpu
+      __constant_le[x]_to_cpu
+      __constant_htons
+      __constant_ntohs
+
+    Using any of these outside of include/uapi/ isn't preferred as using the
+    function without __constant_ is identical when the argument is a
+    constant.
+
+  **DEPRECATED_API**
+    Usage of a deprecated RCU API is detected.  It is recommended to replace
+    old flavourful RCU APIs by their new vanilla-RCU counterparts.
+
+    The full list of available RCU API's can be viewed from the kernel docs.
+
+    See: https://www.kernel.org/doc/html/latest/RCU/whatisRCU.html#full-list-of-rcu-apis
+
+  **DEPRECATED_VARIABLE**
+    EXTRA_{A,C,CPP,LD}FLAGS are deprecated and should be replaced by the new
+    flags added via commit f77bf01425b1 ("kbuild: introduce ccflags-y,
+    asflags-y and ldflags-y").
+
+    The following conversion scheme maybe used::
+
+      EXTRA_AFLAGS    ->  asflags-y
+      EXTRA_CFLAGS    ->  ccflags-y
+      EXTRA_CPPFLAGS  ->  cppflags-y
+      EXTRA_LDFLAGS   ->  ldflags-y
+
+    See:
+
+      1. https://lore.kernel.org/lkml/20070930191054.GA15876@uranus.ravnborg.org/
+      2. https://lore.kernel.org/lkml/1313384834-24433-12-git-send-email-lacombar@gmail.com/
+
+  **DEVICE_ATTR_FUNCTIONS**
+    The function names used in DEVICE_ATTR is unusual.
+    Typically, the store and show functions are named as name_store and
+    name_show, where name is the device name.
+
+    Consider the following examples::
+
+      static DEVICE_ATTR(type, 0444, type_show, NULL);
+      static DEVICE_ATTR(power, 0644, power_show, power_store);
+
+    The function names should preferably follow the above pattern.
+
+    See: https://www.kernel.org/doc/html/latest/driver-api/driver-model/device.html#attributes
+
+  **DEVICE_ATTR_RO**
+    The DEVICE_ATTR_RO(name) helper macro can be used in place of
+    DEVICE_ATTR(name, 0444, name_show, NULL);
+
+    Note that the macro automatically appends _show to the device name
+    for the show method.
+
+  **DEVICE_ATTR_RW**
+    The DEVICE_ATTR_RW(name) helper macro can be used in place of
+    DEVICE_ATTR(name, 0644, name_show, name_store);
+
+    Note that the macro automatically appends _show and _store to the
+    device name for the show and store methods.
+
+  **DEVICE_ATTR_WO**
+    The DEVICE_AATR_WO(name) helper macro can be used in place of
+    DEVICE_ATTR(name, 0200, NULL, name_store);
+
+    Note that the macro automatically appends _store to the device
+    name for the store method.
+
+  **DUPLICATED_SYSCTL_CONST**
+    Commit d91bff3011cf ("proc/sysctl: add shared variables for range
+    check") added some shared const variables to be used instead of a local
+    copy in each source file.
+
+    Consider replacing the sysctl range checking value with the shared
+    one in include/linux/sysctl.h.  The following conversion scheme may
+    be used::
+
+      &zero     ->  SYSCTL_ZERO
+      &one      ->  SYSCTL_ONE
+      &int_max  ->  SYSCTL_INT_MAX
+
+    See:
+
+      1. https://lore.kernel.org/lkml/20190430180111.10688-1-mcroce@redhat.com/
+      2. https://lore.kernel.org/lkml/20190531131422.14970-1-mcroce@redhat.com/
+
+  **ENOSYS**
+    ENOSYS means that a nonexistent system call was called.  We have a
+    bad habit of using it for things like invalid operations on
+    otherwise valid syscalls.  This should be avoided in new code.
+
+    See: https://lore.kernel.org/lkml/5eb299021dec23c1a48fa7d9f2c8b794e967766d.1408730669.git.luto@amacapital.net/
+
+  **ENOTSUPP**
+    ENOTSUPP is not a standard error code and should be avoided in new patches.
+    EOPNOTSUPP should be used instead.
+
+    See: https://lore.kernel.org/netdev/20200510182252.GA411829@lunn.ch/
+
+  **EXPORT_SYMBOL**
+    EXPORT_SYMBOL should immediately follow the thing it is exporting.
+
   **IN_ATOMIC**
     in_atomic() is not for driver use so any such use is reported as an ERROR.
     Also in_atomic() is often used to determine if we may sleep, but it is not
@@ -335,8 +443,8 @@ API usage
     See: https://www.kernel.org/doc/html/latest/timers/timers-howto.html#delays-information-on-the-various-kernel-delay-sleep-mechanisms
 
 
-Comment style
--------------
+Comments
+--------
 
   **BLOCK_COMMENT_STYLE**
     The comment style is incorrect.  The preferred style for multi-
@@ -362,6 +470,21 @@ Comment style
 
     See: https://www.kernel.org/doc/html/latest/process/coding-style.html#commenting
 
+  **DATA_RACE**
+    Applications of data_race() should have a comment so as to document the
+    reasoning behind why it was deemed safe.
+
+    See: https://lore.kernel.org/lkml/20200401101714.44781-1-elver@google.com/
+
+  **FSF_MAILING_ADDRESS**
+    Kernel maintainers reject new instances of the GPL boilerplate paragraph
+    directing people to write to the FSF for a copy of the GPL, since the
+    FSF has moved in the past and may do so again.
+    So do not write paragraphs about writing to the Free Software Foundation's
+    mailing address.
+
+    See: https://lore.kernel.org/lkml/20131006222342.GT19510@leaf/
+
 
 Commit message
 --------------
@@ -394,6 +517,13 @@ Commit message
 
     See: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
 
+  **EMAIL_SUBJECT**
+    Naming the tool that found the issue is not very useful in the
+    subject line.  A good subject line summarizes the change that
+    the patch brings.
+
+    See: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
+
   **FROM_SIGN_OFF_MISMATCH**
     The author's email does not match with that in the Signed-off-by:
     line(s). This can be sometimes caused due to an improperly configured
@@ -482,6 +612,83 @@ Comparison style
     side of the test should be avoided.
 
 
+Indentation and Line Breaks
+---------------------------
+
+  **CODE_INDENT**
+    Code indent should use tabs instead of spaces.
+    Outside of comments, documentation and Kconfig,
+    spaces are never used for indentation.
+
+    See: https://www.kernel.org/doc/html/latest/process/coding-style.html#indentation
+
+  **DEEP_INDENTATION**
+    Indentation with 6 or more tabs usually indicate overly indented
+    code.
+
+    It is suggested to refactor excessive indentation of
+    if/else/for/do/while/switch statements.
+
+    See: https://lore.kernel.org/lkml/1328311239.21255.24.camel@joe2Laptop/
+
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
+  **LONG_LINE**
+    The line has exceeded the specified maximum length. Consider refactoring
+    it.
+    To use a different maximum line length, the --max-line-length=n option
+    may be added while invoking checkpatch.
+
+    See: https://www.kernel.org/doc/html/latest/process/coding-style.html#breaking-long-lines-and-strings
+
+  **LONG_LINE_STRING**
+    A string starts before but extends beyond the maximum line length.
+    To use a different maximum line length, the --max-line-length=n option
+    may be added while invoking checkpatch.
+
+    See: https://www.kernel.org/doc/html/latest/process/coding-style.html#breaking-long-lines-and-strings
+
+  **LONG_LINE_COMMENT**
+    A comment starts before but extends beyond the maximum line length.
+    To use a different maximum line length, the --max-line-length=n option
+    may be added while invoking checkpatch.
+
+    See: https://www.kernel.org/doc/html/latest/process/coding-style.html#breaking-long-lines-and-strings
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
+
+
 Macros, Attributes and Symbols
 ------------------------------
 
@@ -546,6 +753,9 @@ Macros, Attributes and Symbols
 
     See: https://lore.kernel.org/lkml/CA+55aFycQ9XJvEOsiM3txHL5bjUc8CeKWJNR_H+MiicaddB42Q@mail.gmail.com/
 
+  **DO_WHILE_MACRO_WITH_TRAILING_SEMICOLON**
+    do {} while(0) macros should not have a trailing semicolon.
+
   **INIT_ATTRIBUTE**
     Const init definitions should use __initconst instead of
     __initdata.
@@ -614,6 +824,48 @@ Functions and Variables
 
     See: https://www.kernel.org/doc/html/latest/process/coding-style.html#naming
 
+  **CONST_CONST**
+    Using `const <type> const *` is generally meant to be
+    written `const <type> * const`.
+
+  **CONST_STRUCT**
+    Using const is generally a good idea.  Checkpatch reads
+    a list of frequently used structs that are always or
+    almost always constant.
+
+    The existing structs list can be viewed from
+    `scripts/const_structs.checkpatch`.
+
+    See: https://lore.kernel.org/lkml/alpine.DEB.2.10.1608281509480.3321@hadrien/
+
+  **EMBEDDED_FUNCTION_NAME**
+    Embedded function names are less appropriate to use as
+    refactoring can cause function renaming.  Prefer the use of
+    "%s", __func__ to embedded function names.
+
+    Note that this does not work with -f (--file) checkpatch option
+    as it depends on patch context providing the function name.
+
+  **FUNCTION_ARGUMENTS**
+    This warning is emitted due to any of the following reasons::
+
+      1. Arguments for the function declaration does not follow
+         the identifier name.  Example::
+
+           void foo
+           (int bar, int baz)
+
+         This should be corrected to::
+
+           void foo(int bar, int baz)
+
+      2. Some arguments for the function definition does not
+         have an identifier name.  Example::
+
+           void foo(int)
+
+         All arguments should have identifier names.
+
   **FUNCTION_WITHOUT_ARGS**
     Function declarations without arguments like::
 
@@ -647,6 +899,13 @@ Functions and Variables
 Permissions
 -----------
 
+  **DEVICE_ATTR_PERMS**
+    The permissions used in DEVICE_ATTR is unusual.
+    Typically only three permissions are used - 0644 (RW), 0444 (RO)
+    and 0200 (WO).
+
+    See: https://www.kernel.org/doc/html/latest/filesystems/sysfs.html#attributes
+
   **EXECUTE_PERMISSIONS**
     There is no reason for source files to be executable.  The executable
     bit can be removed safely.
@@ -708,13 +967,6 @@ Spacing and Brackets
 
         = { [0...10] = 5 }
 
-  **CODE_INDENT**
-    Code indent should use tabs instead of spaces.
-    Outside of comments, documentation and Kconfig,
-    spaces are never used for indentation.
-
-    See: https://www.kernel.org/doc/html/latest/process/coding-style.html#indentation
-
   **CONCATENATED_STRING**
     Concatenated elements should have a space in between.
     Example::
@@ -760,29 +1012,6 @@ Spacing and Brackets
 
     See: https://www.kernel.org/doc/html/latest/process/coding-style.html#spaces
 
-  **SWITCH_CASE_INDENT_LEVEL**
-    switch should be at the same indent as case.
-    Example::
-
-      switch (suffix) {
-      case 'G':
-      case 'g':
-              mem <<= 30;
-              break;
-      case 'M':
-      case 'm':
-              mem <<= 20;
-              break;
-      case 'K':
-      case 'k':
-              mem <<= 10;
-              /* fall through */
-      default:
-              break;
-      }
-
-    See: https://www.kernel.org/doc/html/latest/process/coding-style.html#indentation
-
   **TRAILING_WHITESPACE**
     Trailing whitespace should always be removed.
     Some editors highlight the trailing whitespace and cause visual
@@ -842,40 +1071,46 @@ Others
     The patch seems to be corrupted or lines are wrapped.
     Please regenerate the patch file before sending it to the maintainer.
 
+  **CVS_KEYWORD**
+    Since linux moved to git, the CVS markers are no longer used.
+    So, CVS style keywords ($Id$, $Revision$, $Log$) should not be
+    added.
+
+  **DEFAULT_NO_BREAK**
+    switch default case is sometimes written as "default:;".  This can
+    cause new cases added below default to be defective.
+
+    A "break;" should be added after empty default statement to avoid
+    unwanted fallthrough.
+
   **DOS_LINE_ENDINGS**
     For DOS-formatted patches, there are extra ^M symbols at the end of
     the line.  These should be removed.
 
-  **FSF_MAILING_ADDRESS**
-    Kernel maintainers reject new instances of the GPL boilerplate paragraph
-    directing people to write to the FSF for a copy of the GPL, since the
-    FSF has moved in the past and may do so again.
-    So do not write paragraphs about writing to the Free Software Foundation's
-    mailing address.
-
-    See: https://lore.kernel.org/lkml/20131006222342.GT19510@leaf/
+  **DT_SCHEMA_BINDING_PATCH**
+    DT bindings moved to using a json-schema based schema format
+    instead of freeform text.
 
-  **LONG_LINE**
-    The line has exceeded the specified maximum length. Consider refactoring
-    it.
-    To use a different maximum line length, the --max-line-length=n option
-    may be added while invoking checkpatch.
+    See: https://www.kernel.org/doc/html/latest/devicetree/bindings/writing-schema.html
 
-    See: https://www.kernel.org/doc/html/latest/process/coding-style.html#breaking-long-lines-and-strings
+  **DT_SPLIT_BINDING_PATCH**
+    Devicetree bindings should be their own patch.  This is because
+    bindings are logically independent from a driver implementation,
+    they have a different maintainer (even though they often
+    are applied via the same tree), and it makes for a cleaner history in the
+    DT only tree created with git-filter-branch.
 
-  **LONG_LINE_STRING**
-    A string starts before but extends beyond the maximum line length.
-    To use a different maximum line length, the --max-line-length=n option
-    may be added while invoking checkpatch.
+    See: https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
 
-    See: https://www.kernel.org/doc/html/latest/process/coding-style.html#breaking-long-lines-and-strings
+  **EMBEDDED_FILENAME**
+    Embedding the complete filename path inside the file isn't particularly
+    useful as often the path is moved around and becomes incorrect.
 
-  **LONG_LINE_COMMENT**
-    A comment starts before but extends beyond the maximum line length.
-    To use a different maximum line length, the --max-line-length=n option
-    may be added while invoking checkpatch.
+  **FILE_PATH_CHANGES**
+    Whenever files are added, moved, or deleted, the MAINTAINERS file
+    patterns can be out of sync or outdated.
 
-    See: https://www.kernel.org/doc/html/latest/process/coding-style.html#breaking-long-lines-and-strings
+    So MAINTAINERS might need updating in these cases.
 
   **MEMSET**
     The memset use appears to be incorrect.  This may be caused due to
@@ -895,17 +1130,5 @@ Others
 
     See: https://www.kernel.org/doc/html/latest/process/license-rules.html
 
-  **TRAILING_STATEMENTS**
-    Trailing statements (for example after any conditional) should be
-    on the next line.
-    Like::
-
-      if (x == y) break;
-
-    should be::
-
-      if (x == y)
-              break;
-
   **TYPO_SPELLING**
     Some words may have been misspelled.  Consider reviewing them.
-- 
2.28.0

