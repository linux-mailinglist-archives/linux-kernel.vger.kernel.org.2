Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CB0315F2C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 06:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbhBJFtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 00:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbhBJFtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 00:49:10 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1C6C061574;
        Tue,  9 Feb 2021 21:48:30 -0800 (PST)
Received: from ip4d149f6e.dynamic.kabel-deutschland.de ([77.20.159.110] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1l9iMS-0007A1-CB; Wed, 10 Feb 2021 06:48:24 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Joerg Roedel <joro@8bytes.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Damian Tometzki <linux@tometzki.de>
Subject: [PATCH] docs: reporting-issues.rst: explain how to decode stack traces
Date:   Wed, 10 Feb 2021 06:48:23 +0100
Message-Id: <20210210054823.242262-1-linux@leemhuis.info>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1612936110;3eff2481;
X-HE-SMSGID: 1l9iMS-0007A1-CB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace placeholder text about decoding stack traces with a section that
properly describes what a typical user should do these days. To make
it works for them, add a paragraph in an earlier section to ensure
people build their kernels with everything that's needed to decode stack
traces later.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
Reminder: This is not my area of expertise. Hopefully I didn't write anything
stupid or omitted something people find important. If I did, please let me know,
ideally suggesting what to write; bonus points for people sending text I can
simply include in the next revision.

I CCed Sasha, because he wrote decode_stacktrace.sh; I also CCed a bunch of
people that showed interest in this topic when I asked for help on Twitter.

I'm still unsure if linking to admin-guide/bug-hunting.rst is a good idea, as it
seems quite outdated; reporting-bugs did that, but for now I settled on 'don't
do that'.

Ciao, Thorsten
---
 .../admin-guide/reporting-issues.rst          | 77 +++++++++++++------
 1 file changed, 55 insertions(+), 22 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index 07879d01fe68..b9c07d8e3141 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -154,8 +154,8 @@ After these preparations you'll now enter the main part:
    that hear about it for the first time. And if you learned something in this
    process, consider searching again for existing reports about the issue.
 
- * If the failure includes a stack dump, like an Oops does, consider decoding
-   it to find the offending line of code.
+ * If your failure involves a 'panic', 'oops', or 'warning', consider decoding
+   the kernel log to find the line of code that trigger the error.
 
  * If your problem is a regression, try to narrow down when the issue was
    introduced as much as possible.
@@ -869,6 +869,15 @@ pick up the configuration of your current kernel and then tries to adjust it
 somewhat for your system. That does not make the resulting kernel any better,
 but quicker to compile.
 
+Note: If you are dealing with a kernel panic, oops, or warning, please make
+sure to enable CONFIG_KALLSYMS when configuring your kernel. Additionally,
+enable CONFIG_DEBUG_KERNEL and CONFIG_DEBUG_INFO, too; the latter is the
+relevant one of those two, but can only be reached if you enable the former. Be
+aware CONFIG_DEBUG_INFO increases the storage space required to build a kernel
+by quite a bit. But that's worth it, as these options will allow you later to
+pinpoint the exact line of code that triggers your issue. The section 'Decode
+failure messages' below explains this in more detail.
+
 
 Check 'taint' flag
 ------------------
@@ -923,31 +932,55 @@ instead you can join.
 Decode failure messages
 -----------------------
 
-.. note::
+    *If your failure involves a 'panic', 'oops', or 'warning', consider
+    decoding the kernel log to find the line of code that trigger the error.*
 
-   FIXME: The text in this section is a placeholder for now and quite similar to
-   the old text found in 'Documentation/admin-guide/reporting-bugs.rst'
-   currently. It and the document it references are known to be outdated and
-   thus need to be revisited. Thus consider this note a request for help: if you
-   are familiar with this topic, please write a few lines that would fit here.
-   Alternatively, simply outline the current situation roughly to the main
-   authors of this document (see intro), as they might be able to write
-   something then.
+When the kernel detects an internal problem, it will log some information about
+the executed code. This makes it possible to pinpoint the exact line in the
+source code that triggered the issue and shows how it was called. But that only
+works if you enabled CONFIG_DEBUG_INFO and CONFIG_KALLSYMS when configuring
+your kernel. If you did so, consider to decode the information from the
+kernel's log. That will make it a lot easier to understand what lead to the
+'panic', 'oops', or 'warning', which increases the chances enormously that
+someone can provide a fix.
 
-   This section in the end should answer questions like "when is this actually
-   needed", "what .config options to ideally set earlier to make this step easy
-   or unnecessary?" (likely CONFIG_UNWINDER_ORC when it's available, otherwise
-   CONFIG_UNWINDER_FRAME_POINTER; but is there anything else needed?).
+Decoding can be done with a script you find in the Linux source tree. If you
+are running a kernel you compiled yourself earlier, call it like this::
 
-..
+       [user@something ~]$ sudo dmesg | ./linux-5.10.5/scripts/decode_stacktrace.sh ./linux-5.10.5/vmlinux
+
+If you are running a packaged vanilla kernel, you will likely have to install
+the corresponding packages with debug symbols. Then call the script (which you
+might need to get from the Linux sources if your distro does not package it)
+like this::
+
+       [user@something ~]$ sudo dmesg | ./linux-5.10.5/scripts/decode_stacktrace.sh \
+        /usr/lib/debug/lib/modules/5.10.10-4.1.x86_64/vmlinux /usr/src/kernels/5.10.10-4.1.x86_64/
+
+The script will work on log lines like the following, which show the address of
+the code the kernel was executing when the error occurred::
+
+       [   68.387301] RIP: 0010:test_module_init+0x5/0xffa [test_module]
+
+Once decoded, these lines will look like this::
+
+       [   68.387301] RIP: 0010:test_module_init (/home/username/linux-5.10.5/test-module/test-module.c:16) test_module
+
+In this case the executed code was built from the file
+'~/linux-5.10.5/test-module/test-module.c' and the error occurred by the
+instructions found in line '16'.
 
-    *If the failure includes a stack dump, like an Oops does, consider decoding
-    it to find the offending line of code.*
+The script will similarly decode the addresses mentioned in the section
+starting with 'Call trace', which show the path to the function where the
+problem occurred. Additionally, the script will show the assembler output for
+the code section the kernel was executing.
 
-When the kernel detects an error, it will print a stack dump that allows to
-identify the exact line of code where the issue happens. But that information
-sometimes needs to get decoded to be readable, which is explained in
-admin-guide/bug-hunting.rst.
+Note, if you can't get this to work, simply skip this step and mention the
+reason for it in the report. If you're lucky, it might not be needed. And if it
+is, someone might help you to get things going. Also be aware this is just one
+of several ways to decode kernel stack traces. Sometimes different steps will
+be required to retrieve the relevant details. Don't worry about that, if that's
+needed in your case, developers will tell you what to do.
 
 
 Special care for regressions
-- 
2.29.2

