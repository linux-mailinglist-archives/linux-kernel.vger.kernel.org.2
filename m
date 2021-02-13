Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB0A31AB8C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 14:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhBMNQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 08:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhBMNQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 08:16:03 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61523C0613D6;
        Sat, 13 Feb 2021 05:15:22 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id fa16so1157690pjb.1;
        Sat, 13 Feb 2021 05:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=stmDikBvtUAOkdTQwkBYron+CUPACHDgH7KtSH8FtAg=;
        b=h1oZAno9wK+4PNhwXjMJrLtjUfSW/v277dSNbzytLcHTnKeCZxEZSZz0p/mjM1K578
         6gw2UZTc4MbN2e3WxcnvGvvMnLfEA7q+gAFMS9Xc0rbJRTncdJEl2nVJ1Tw5/em13OCm
         d48ldTOIub4hE4Ngbj9XuSwH7QEoKyUi7vvNn0rYUqvnuAtTszFdkuJ22uc8jCNeYv2M
         0fwwNwZ7aCI8nkPkgad11ZDXpDbLRUgmN3ubsygTb4v1cfvYkh/2s6IOx2RtqY3+QohZ
         GIPdrurZ2dIRMPb0URRtn6uLl1L/0t1kfz4mVDmU7Ni+bGUj27XyWp+aos2/7pC7fuUH
         vbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=stmDikBvtUAOkdTQwkBYron+CUPACHDgH7KtSH8FtAg=;
        b=o3fmR6oHtdykA54ODXV3qRRMT/KhP6QwmWB5h16qM8ixCY5TWTXRvw6jnFOvNwWs0s
         k8RLwnt50sRHlv6cQUFO5cgl+qPsMjn+7xXCbmIhjjR0WXGk5gttS72xpWdgrdJ8YlQM
         Dukin5rXNofqVWHtXFC7NxVqLzAfDqWlhHgiIS1XQj4nK5lPjQhPdugK7MQ0sbRityVO
         MVfISgLHQmH9CZvF1y8vr9L0KmzVMHjDk+KpvMiGj0C6XNUsmoSI7EnE/zvDH9uHkplo
         275YITfn8068jvQ+381DIy9dnA1HnNwFIEp2cNNb1U99X0rmFnq4XsCaXwT27pogSKWX
         qxaQ==
X-Gm-Message-State: AOAM530iL/XX967n/cvDF9p1cvaQo0aDQOPw7SrzOS9XWseAMx4IRMwG
        yE4OyGNEGTszrQSXwL9cPlIWLZI1Xr/07nGV
X-Google-Smtp-Source: ABdhPJzucjrIClZO7tjyVuWVGZz1pJW21yXwsSTQLnE8apSybrEuI/JcYIcIgBqb49dbil74s3roLA==
X-Received: by 2002:a17:90a:fc4:: with SMTP id 62mr7118085pjz.181.1613222121671;
        Sat, 13 Feb 2021 05:15:21 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:6ab4:5c97:80e6:be35:2e49])
        by smtp.gmail.com with ESMTPSA id p11sm833533pjb.3.2021.02.13.05.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 05:15:21 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-doc@vger.kernel.org, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: [PATCH RFC v3 2/3] docs: add documentation for checkpatch
Date:   Sat, 13 Feb 2021 18:45:12 +0530
Message-Id: <20210213131513.51386-3-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210213131513.51386-1-dwaipayanray1@gmail.com>
References: <20210213131513.51386-1-dwaipayanray1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for kernel script checkpatch.pl.
This documentation is also parsed by checkpatch to
enable a verbose mode.

The message types in checkpatch are documented with rst
field lists. A total of 33 checkpatch type descriptions
are added.

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 Documentation/dev-tools/checkpatch.rst | 494 +++++++++++++++++++++++++
 1 file changed, 494 insertions(+)
 create mode 100644 Documentation/dev-tools/checkpatch.rst

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
new file mode 100644
index 000000000000..8e6ff1e27353
--- /dev/null
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -0,0 +1,494 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+==========
+Checkpatch
+==========
+
+This document describes the kernel script checkpatch.pl.
+
+.. Table of Contents
+
+	=== 1 Introduction
+	=== 2 Options
+	=== 3 Message Levels
+	=== 4 Type Descriptions
+
+1 Introduction
+--------------
+
+Checkpatch (scripts/checkpatch.pl) is a perl script which checks for trivial style
+violations in patches and optionally corrects them.  Checkpatch can also be run on
+file contexts and without the kernel tree.
+
+Checkpatch is not always right. Your judgement takes precedence over checkpatch
+messages.  If your code looks better with the violations, then its probably
+best left alone.
+
+
+2 Options
+---------
+
+This section will describe the options checkpatch can be run with.
+
+Usage::
+
+  ./scripts/checkpatch.pl [OPTION]... [FILE]...
+
+Available options:
+
+ - -q,  --quiet
+
+   Enable quiet mode.
+
+ - -v,  --verbose
+   Enable verbose mode.  Additional verbose test descriptions are output
+   so as to provide information on why that particular message is shown.
+
+ - --no-tree
+
+   Run checkpatch without the kernel tree.
+
+ - --no-signoff
+
+   Disable the 'Signed-off-by' line check.  The sign-off is a simple line at
+   the end of the explanation for the patch, which certifies that you wrote it
+   or otherwise have the right to pass it on as an open-source patch.
+
+   Example::
+
+	 Signed-off-by: Random J Developer <random@developer.example.org>
+
+   Setting this flag effectively stops a message for a missing signed-off-by line
+   in a patch context.
+
+ - --patch
+
+   Treat FILE as a patch.  This is the default option and need not be
+   explicitly specified.
+
+ - --emacs
+
+   Set output to emacs compile window format.  This allows emacs users to jump
+   from the error in the compile window directly to the offending line in the patch.
+
+ - --terse
+
+   Output only one line per report.
+
+ - --showfile
+
+   Show the diffed file position instead of the input file position.
+
+ - -g,  --git
+
+   Treat FILE as a single commit or a git revision range.
+
+   Single commit with:
+
+   - <rev>
+   - <rev>^
+   - <rev>~n
+
+   Multiple commits with:
+
+   - <rev1>..<rev2>
+   - <rev1>...<rev2>
+   - <rev>-<count>
+
+ - -f,  --file
+
+   Treat FILE as a regular source file.  This option must be used when running
+   checkpatch on source files in the kernel.
+
+ - --subjective,  --strict
+
+   Enable stricter tests in checkpatch.  By default the tests emitted as CHECK
+   do not activate by default.  Use this flag to activate the CHECK tests.
+
+ - --list-types
+
+   Every message emitted by checkpatch has an associated TYPE.  Add this flag to
+   display all the types in checkpatch.
+
+   Note that when this flag is active, checkpatch does not read the input FILE, and
+   no message is emitted.  Only a list of types in checkpatch is output.
+
+ - --types TYPE(,TYPE2...)
+
+   Only display messages with the given types.
+
+   Example::
+
+     ./scripts/checkpatch.pl mypatch.patch --types EMAIL_SUBJECT,NO_AUTHOR_SIGN_OFF
+
+ - --ignore TYPE(,TYPE2...)
+
+   Checkpatch will not emit messages for the specified types.
+
+   Example::
+
+     ./scripts/checkpatch.pl mypatch.patch --ignore EMAIL_SUBJECT,NO_AUTHOR_SIGN_OFF
+
+ - --show-types
+
+   By default checkpatch doesn't display the type associated with the messages.
+   Set this flag to show the message type in the output.
+
+ - --max-line-length=n
+
+   Set the max line length (default 100).  If a line exceeds the specified length,
+   a LONG_LINE message is emitted.
+
+
+   The message level is different for patch and file contexts.  For patches, a WARNING is
+   emitted.  While a milder CHECK is emitted for files.  So for file contexts, the --strict
+   flag must also be enabled.
+
+ - --min-conf-desc-length=n
+
+   Set the Kconfig entry minimum description length, if shorter, warn.
+
+ - --tab-size=n
+
+   Set the number of spaces for tab (default 8).
+
+ - --root=PATH
+
+   PATH to the kernel tree root.
+
+   This option must be specified when invoking checkpatch from outside
+   the kernel root.
+
+ - --no-summary
+
+   Suppress the per file summary.
+
+ - --mailback
+
+   Only produce a report in case of Warnings or Errors.  Milder Checks are
+   excluded from this.
+
+ - --summary-file
+
+   Include the filename in summary.
+
+ - --debug KEY=[0|1]
+
+   Turn on/off debugging of KEY, where KEY is one of 'values', 'possible',
+   'type', and 'attr' (default is all off).
+
+ - --fix
+
+   This is an EXPERIMENTAL feature.  If correctable errors exists, a file
+   <inputfile>.EXPERIMENTAL-checkpatch-fixes is created which has the
+   automatically fixable errors corrected.
+
+ - --fix-inplace
+
+   EXPERIMENTAL - Similar to --fix but the input file is overwritten with fixes.
+
+   DO NOT USE this flag unless you are absolutely sure and you have a backup in place.
+
+ - --ignore-perl-version
+
+   Override checking of perl version.  Runtime errors maybe encountered after
+   enabling this flag if the perl version does not meet the minimum specified.
+
+ - --codespell
+
+   Use the codespell dictionary for checking spelling errors.
+
+ - --codespellfile
+
+   Use the specified codespell file.  Default is '/usr/share/codespell/dictionary.txt'.
+
+ - --typedefsfile
+
+   Read additional types from this file.
+
+ - --color[=WHEN]
+
+   Use colors 'always', 'never', or only when output is a terminal ('auto').
+   Default is 'auto'.
+
+ - --kconfig-prefix=WORD
+
+   Use WORD as a prefix for Kconfig symbols (default is `CONFIG_`).
+
+ - -h, --help, --version
+
+   Display the help text.
+
+3 Message Levels
+----------------
+
+Messages in checkpatch are divided into three levels. The levels of messages in
+checkpatch denote the severity of the error. They are:
+
+ - ERROR
+
+   This is the most strict level.  Messages of type ERROR must be taken
+   seriously as they denote things that are very likely to be wrong.
+
+ - WARNING
+
+   This is the next stricter level.  Messages of type WARNING requires a
+   more careful review.  But it is milder than an ERROR.
+
+ - CHECK
+
+   This is the mildest level.  These are things which may require some thought.
+
+4 Type Descriptions
+-------------------
+
+This section contains a description of all the message types in checkpatch.
+
+.. Types in this section are also parsed by checkpatch.
+.. Please keep the types sorted alphabetically.
+
+:ALLOC_ARRAY_ARGS:
+  The first argument for kcalloc or kmalloc_array should be the
+  number of elements.  sizeof() as the first argument is generally
+  wrong.
+
+:ALLOC_SIZEOF_STRUCT:
+  The allocation style is bad.  In general for family of
+  allocation functions using sizeof() to get memory size,
+  constructs like::
+
+    p = alloc(sizeof(struct foo), ...)
+
+  should be::
+
+    p = alloc(sizeof(*p), ...)
+
+:ALLOC_WITH_MULTIPLY:
+  Prefer kmalloc_array/kcalloc over kmalloc/kzalloc with a
+  sizeof multiply.
+  Ref: `Documentation/core-api/memory-allocation.rst`
+
+:ARCH_DEFINES:
+  Architecture specific defines should be avoided wherever
+  possible.
+
+:ARCH_INCLUDE_LINUX:
+  Whenever asm/file.h is included and linux/file.h exists, a
+  conversion can be made when linux/file.h includes asm/file.h.
+  However this is not always the case (See signal.h).
+  This message type is emitted only for includes from arch/.
+
+:ARRAY_SIZE:
+  The ARRAY_SIZE(foo) macro should be preferred over
+  sizeof(foo)/sizeof(foo[0]) for finding number of elements in an
+  array.
+
+  The macro is defined in include/linux/kernel.h::
+
+    #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
+:ASSIGNMENT_CONTINUATIONS:
+  Assignment operators should not be written at the start of a
+  line but should follow the operand at the previous line.
+
+:ASSIGN_IN_IF:
+  Do not use assignments in if condition.
+  Example::
+
+    if ((foo = bar(...)) < BAZ) {
+
+  should be written as::
+
+    foo = bar(...);
+    if (foo < BAZ) {
+
+:AVOID_BUG:
+  BUG() or BUG_ON() should be avoided totally.
+  Use WARN() and WARN_ON() instead, and handle the "impossible"
+  error condition as gracefully as possible.
+  Ref: `Documentation/process/deprecated.rst`
+
+:AVOID_EXTERNS:
+  Function prototypes don't need to be declared extern in .h
+  files.  It's assumed by the compiler and is unnecessary.
+
+:AVOID_L_PREFIX:
+  Local symbol names that are prefixed with `.L` should be avoided,
+  as this has special meaning for the assembler; a symbol entry will
+  not be emitted into the symbol table.  This can prevent `objtool`
+  from generating correct unwind info.
+
+  Symbols with STB_LOCAL binding may still be used, and `.L` prefixed
+  local symbol names are still generally usable within a function,
+  but `.L` prefixed local symbol names should not be used to denote
+  the beginning or end of code regions via
+  `SYM_CODE_START_LOCAL`/`SYM_CODE_END`
+
+:BAD_SIGN_OFF:
+  The signed-off-by line does not fall in line with the standards
+  specified by the community.
+  Ref: `Documentation/process/submitting-patches.rst`
+
+:BAD_STABLE_ADDRESS_STYLE:
+  The email format for stable is incorrect.
+  Some valid options for stable address are::
+
+    1. stable@vger.kernel.org
+    2. stable@kernel.org
+
+  For adding version info, the following comment style should be used::
+
+    stable@vger.kernel.org # version info
+
+:BIT_MACRO:
+  Defines like: 1 << <digit> could be BIT(digit).
+  The BIT() macro is defined in include/linux/bitops.h::
+
+    #define BIT(nr)         (1UL << (nr))
+
+:BLOCK_COMMENT_STYLE:
+  The comment style is incorrect.  The preferred style for multi-
+  line comments is::
+
+    /*
+     * This is the preferred style
+     * for multi line comments.
+     */
+
+  The networking comment style is a bit different, with the first line
+  not empty like the former::
+
+    /* This is the preferred comment style
+     * for files in net/ and drivers/net/
+     */
+
+  Ref: `Documentation/process/coding-style.rst`
+
+:BOOL_COMPARISON:
+  Comparisons of A to true and false are better written
+  as A and !A.
+  Ref: `https://lore.kernel.org/lkml/1365563834.27174.12.camel@joe-AO722/`
+
+:BRACES:
+  The placement of braces is stylistically incorrect.
+  The preferred way is to put the opening brace last on the line,
+  and put the closing brace first::
+
+    if (x is true) {
+      we do y
+    }
+
+  This applies for all non-functional blocks.
+  However, there is one special case, namely functions: they have the
+  opening brace at the beginning of the next line, thus::
+
+    int function(int x)
+    {
+      body of function
+    }
+
+  Ref: `Documentation/process/coding-style.rst Section 3`
+
+:BRACKET_SPACE:
+  Whitespace before opening bracket '[' is prohibited.
+  There are some exceptions:
+
+  1. With a type on the left::
+
+     ;int [] a;
+
+  2. At the beginning of a line for slice initialisers::
+
+     [0...10] = 5,
+
+  3. Inside a curly brace::
+
+     = { [0...10] = 5 }
+
+:C99_COMMENTS:
+  C99 style single line comments (//) should not be used.
+  Prefer the block comment style instead.
+  Ref: `Documentation/process/coding-style.rst Section 8`
+
+:CAMELCASE:
+  Avoid CamelCase Identifiers.  snake_case can be an
+  alternative.
+
+:CODE_INDENT:
+  Code indent should use tabs instead of spaces.
+  Outside of comments, documentation and Kconfig,
+  spaces are never used for indentation.
+  Ref: `Documentation/process/coding-style.rst Section 1`
+
+:COMMIT_COMMENT_SYMBOL:
+  Commit log lines starting with a '#' are ignored by git as
+  comments.  To solve this problem addition of a single space
+  infront of the log line is enough.
+
+:COMMIT_MESSAGE:
+  The patch is missing a commit description.  A brief
+  description of the changes made by the patch should be added.
+  Ref: `Documentation/process/submitting-patches.rst`
+
+:COMPARISON_TO_NULL:
+  Comparisons to NULL in the form (foo == NULL) or (foo != NULL)
+  are better written as (!foo) and (foo).
+
+:COMPLEX_MACRO:
+  Macros with complex values should be enclosed within parentheses.
+  Consider::
+
+    #define SOME_MACRO IS_ENABLED(CONFIG_XX) ? 1 : 0
+
+  This can be better written as::
+
+    #define SOME_MACRO (IS_ENABLED(CONFIG_XX) ? 1 : 0)
+
+:CONCATENATED_STRING:
+  Concatenated elements should have a space in between.
+  Example::
+
+    printk(KERN_INFO"bar");
+
+  should be::
+
+    printk(KERN_INFO "bar");
+
+:CONFIG_DESCRIPTION:
+  Kconfig symbols should have a help text which fully describes
+  it.
+
+:CONSIDER_KSTRTO:
+  The simple_strtol(), simple_strtoll(), simple_strtoul(), and
+  simple_strtoull() functions explicitly ignore overflows, which
+  may lead to unexpected results in callers.  The respective kstrtol(),
+  kstrtoll(), kstrtoul(), and kstrtoull() functions tend to be the
+  correct replacements.
+  Ref: `Documentation/process/deprecated.rst`
+
+:CONSTANT_COMPARISON:
+  Comparisons with a constant or upper case identifier on the left
+  side of the test should be avoided.
+
+:LINE_SPACING:
+  Vertical space is wasted given the limited number of lines an
+  editor window can display when multiple blank lines are used.
+  Ref: `Documentation/process/coding-style.rst Section 3.1`
+
+:MISSING_SIGN_OFF:
+  The patch is missing a Signed-off-by line.  A signed-off-by
+  line should be added according to Developer's certificate of
+  Origin.
+  ref: `Documentation/process/submitting-patches.rst`
+
+:NO_AUTHOR_SIGN_OFF:
+  The author of the patch has not signed off the patch.  It is
+  required that a simple sign off line should be present at the
+  end of explanation of the patch to denote that the author has
+  written it or otherwise has the rights to pass it on as an open
+  source patch.
+
+:TRAILING_WHITESPACE:
+  Trailing whitespace should always be removed.
+  Some editors highlight the trailing whitespace and cause visual
+  distractions when editing files.
-- 
2.30.0

