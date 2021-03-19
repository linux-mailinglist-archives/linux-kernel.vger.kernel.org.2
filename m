Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E958D34262E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 20:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhCST2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 15:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbhCST1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 15:27:54 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA0DC06175F;
        Fri, 19 Mar 2021 12:27:53 -0700 (PDT)
Received: from ip4d142c50.dynamic.kabel-deutschland.de ([77.20.44.80] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1lNKmk-0003Lu-Jo; Fri, 19 Mar 2021 20:27:50 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] docs: reporting-issues.rst: reorder some steps
Date:   Fri, 19 Mar 2021 20:27:47 +0100
Message-Id: <8dfc58efde25a05ccf9bf85929826c4b1b9e09c5.1616181657.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616181657.git.linux@leemhuis.info>
References: <cover.1616181657.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1616182073;048012f6;
X-HE-SMSGID: 1lNKmk-0003Lu-Jo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder some steps where the order in which the readers perform them is
not crucial. This is a preparation for a later change that would make
the text much more complex otherwise.

Content just moved, not changed at all in the process.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../admin-guide/reporting-issues.rst          | 222 +++++++++---------
 1 file changed, 111 insertions(+), 111 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index 3c9bf24ebf66..6234741caca8 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -104,19 +104,8 @@ process won't feel wasted in the end:
    issue, or a really severe problem: those are 'issues of high priority' that
    need special handling in some steps that are about to follow.
 
- * Check if your kernel was 'tainted' when the issue occurred, as the event
-   that made the kernel set this flag might be causing the issue you face.
-
- * Locate the driver or kernel subsystem that seems to be causing the issue.
-   Find out how and where its developers expect reports. Note: most of the
-   time this won't be bugzilla.kernel.org, as issues typically need to be sent
-   by mail to a maintainer and a public mailing list.
-
- * Search the archives of the bug tracker or mailing list in question
-   thoroughly for reports that might match your issue. Also check if you find
-   something with your favorite internet search engine or in the Linux Kernel
-   Mailing List (LKML) archives. If you find anything, join the discussion
-   instead of sending a new report.
+ * Make sure it's not the kernel's surroundings that are causing the issue
+   you face.
 
  * Create a fresh backup and put system repair and restore tools at hand.
 
@@ -124,8 +113,8 @@ process won't feel wasted in the end:
    kernel modules on-the-fly, which solutions like DKMS might be doing locally
    without your knowledge.
 
- * Make sure it's not the kernel's surroundings that are causing the issue
-   you face.
+ * Check if your kernel was 'tainted' when the issue occurred, as the event
+   that made the kernel set this flag might be causing the issue you face.
 
  * Write down coarsely how to reproduce the issue. If you deal with multiple
    issues at once, create separate notes for each of them and make sure they
@@ -133,6 +122,17 @@ process won't feel wasted in the end:
    needs to get reported to the kernel developers separately, unless they are
    strongly entangled.
 
+ * Locate the driver or kernel subsystem that seems to be causing the issue.
+   Find out how and where its developers expect reports. Note: most of the
+   time this won't be bugzilla.kernel.org, as issues typically need to be sent
+   by mail to a maintainer and a public mailing list.
+
+ * Search the archives of the bug tracker or mailing list in question
+   thoroughly for reports that might match your issue. Also check if you find
+   something with your favorite internet search engine or in the Linux Kernel
+   Mailing List (LKML) archives. If you find anything, join the discussion
+   instead of sending a new report.
+
 After these preparations you'll now enter the main part:
 
  * Unless you are already running the latest 'mainline' Linux kernel, better
@@ -367,6 +367,75 @@ fatal error where the kernel stop itself) with a 'Oops' (a recoverable error),
 as the kernel remains running after the latter.
 
 
+Ensure a healthy environment
+----------------------------
+
+    *Make sure it's not the kernel's surroundings that are causing the issue
+    you face.*
+
+Problems that look a lot like a kernel issue are sometimes caused by build or
+runtime environment. It's hard to rule out that problem completely, but you
+should minimize it:
+
+ * Use proven tools when building your kernel, as bugs in the compiler or the
+   binutils can cause the resulting kernel to misbehave.
+
+ * Ensure your computer components run within their design specifications;
+   that's especially important for the main processor, the main memory, and the
+   motherboard. Therefore, stop undervolting or overclocking when facing a
+   potential kernel issue.
+
+ * Try to make sure it's not faulty hardware that is causing your issue. Bad
+   main memory for example can result in a multitude of issues that will
+   manifest itself in problems looking like kernel issues.
+
+ * If you're dealing with a filesystem issue, you might want to check the file
+   system in question with ``fsck``, as it might be damaged in a way that leads
+   to unexpected kernel behavior.
+
+ * When dealing with a regression, make sure it's not something else that
+   changed in parallel to updating the kernel. The problem for example might be
+   caused by other software that was updated at the same time. It can also
+   happen that a hardware component coincidentally just broke when you rebooted
+   into a new kernel for the first time. Updating the systems BIOS or changing
+   something in the BIOS Setup can also lead to problems that on look a lot
+   like a kernel regression.
+
+
+Prepare for emergencies
+-----------------------
+
+    *Create a fresh backup and put system repair and restore tools at hand.*
+
+Reminder, you are dealing with computers, which sometimes do unexpected things,
+especially if you fiddle with crucial parts like the kernel of its operating
+system. That's what you are about to do in this process. Thus, make sure to
+create a fresh backup; also ensure you have all tools at hand to repair or
+reinstall the operating system as well as everything you need to restore the
+backup.
+
+
+Make sure your kernel doesn't get enhanced
+------------------------------------------
+
+    *Ensure your system does not enhance its kernels by building additional
+    kernel modules on-the-fly, which solutions like DKMS might be doing locally
+    without your knowledge.*
+
+The risk your issue report gets ignored or rejected dramatically increases if
+your kernel gets enhanced in any way. That's why you should remove or disable
+mechanisms like akmods and DKMS: those build add-on kernel modules
+automatically, for example when you install a new Linux kernel or boot it for
+the first time. Also remove any modules they might have installed. Then reboot
+before proceeding.
+
+Note, you might not be aware that your system is using one of these solutions:
+they often get set up silently when you install Nvidia's proprietary graphics
+driver, VirtualBox, or other software that requires a some support from a
+module not part of the Linux kernel. That why your might need to uninstall the
+packages with such software to get rid of any 3rd party kernel module.
+
+
 Check 'taint' flag
 ------------------
 
@@ -435,6 +504,33 @@ three things:
     the name of the module in question).
 
 
+Document how to reproduce issue
+-------------------------------
+
+    *Write down coarsely how to reproduce the issue. If you deal with multiple
+    issues at once, create separate notes for each of them and make sure they
+    work independently on a freshly booted system. That's needed, as each issue
+    needs to get reported to the kernel developers separately, unless they are
+    strongly entangled.*
+
+If you deal with multiple issues at once, you'll have to report each of them
+separately, as they might be handled by different developers. Describing
+various issues in one report also makes it quite difficult for others to tear
+it apart. Hence, only combine issues in one report if they are very strongly
+entangled.
+
+Additionally, during the reporting process you will have to test if the issue
+happens with other kernel versions. Therefore, it will make your work easier if
+you know exactly how to reproduce an issue quickly on a freshly booted system.
+
+Note: it's often fruitless to report issues that only happened once, as they
+might be caused by a bit flip due to cosmic radiation. That's why you should
+try to rule that out by reproducing the issue before going further. Feel free
+to ignore this advice if you are experienced enough to tell a one-time error
+due to faulty hardware apart from a kernel issue that rarely happens and thus
+is hard to reproduce.
+
+
 Locate kernel area that causes the issue
 ----------------------------------------
 
@@ -672,102 +768,6 @@ test a proposed fix. Jump to the section 'Duties after the report went out' for
 details on how to get properly involved.
 
 
-Prepare for emergencies
------------------------
-
-    *Create a fresh backup and put system repair and restore tools at hand.*
-
-Reminder, you are dealing with computers, which sometimes do unexpected things,
-especially if you fiddle with crucial parts like the kernel of its operating
-system. That's what you are about to do in this process. Thus, make sure to
-create a fresh backup; also ensure you have all tools at hand to repair or
-reinstall the operating system as well as everything you need to restore the
-backup.
-
-
-Make sure your kernel doesn't get enhanced
-------------------------------------------
-
-    *Ensure your system does not enhance its kernels by building additional
-    kernel modules on-the-fly, which solutions like DKMS might be doing locally
-    without your knowledge.*
-
-The risk your issue report gets ignored or rejected dramatically increases if
-your kernel gets enhanced in any way. That's why you should remove or disable
-mechanisms like akmods and DKMS: those build add-on kernel modules
-automatically, for example when you install a new Linux kernel or boot it for
-the first time. Also remove any modules they might have installed. Then reboot
-before proceeding.
-
-Note, you might not be aware that your system is using one of these solutions:
-they often get set up silently when you install Nvidia's proprietary graphics
-driver, VirtualBox, or other software that requires a some support from a
-module not part of the Linux kernel. That why your might need to uninstall the
-packages with such software to get rid of any 3rd party kernel module.
-
-
-Ensure a healthy environment
-----------------------------
-
-    *Make sure it's not the kernel's surroundings that are causing the issue
-    you face.*
-
-Problems that look a lot like a kernel issue are sometimes caused by build or
-runtime environment. It's hard to rule out that problem completely, but you
-should minimize it:
-
- * Use proven tools when building your kernel, as bugs in the compiler or the
-   binutils can cause the resulting kernel to misbehave.
-
- * Ensure your computer components run within their design specifications;
-   that's especially important for the main processor, the main memory, and the
-   motherboard. Therefore, stop undervolting or overclocking when facing a
-   potential kernel issue.
-
- * Try to make sure it's not faulty hardware that is causing your issue. Bad
-   main memory for example can result in a multitude of issues that will
-   manifest itself in problems looking like kernel issues.
-
- * If you're dealing with a filesystem issue, you might want to check the file
-   system in question with ``fsck``, as it might be damaged in a way that leads
-   to unexpected kernel behavior.
-
- * When dealing with a regression, make sure it's not something else that
-   changed in parallel to updating the kernel. The problem for example might be
-   caused by other software that was updated at the same time. It can also
-   happen that a hardware component coincidentally just broke when you rebooted
-   into a new kernel for the first time. Updating the systems BIOS or changing
-   something in the BIOS Setup can also lead to problems that on look a lot
-   like a kernel regression.
-
-
-Document how to reproduce issue
--------------------------------
-
-    *Write down coarsely how to reproduce the issue. If you deal with multiple
-    issues at once, create separate notes for each of them and make sure they
-    work independently on a freshly booted system. That's needed, as each issue
-    needs to get reported to the kernel developers separately, unless they are
-    strongly entangled.*
-
-If you deal with multiple issues at once, you'll have to report each of them
-separately, as they might be handled by different developers. Describing
-various issues in one report also makes it quite difficult for others to tear
-it apart. Hence, only combine issues in one report if they are very strongly
-entangled.
-
-Additionally, during the reporting process you will have to test if the issue
-happens with other kernel versions. Therefore, it will make your work easier if
-you know exactly how to reproduce an issue quickly on a freshly booted system.
-
-Note: it's often fruitless to report issues that only happened once, as they
-might be caused by a bit flip due to cosmic radiation. That's why you should
-try to rule that out by reproducing the issue before going further. Feel free
-to ignore this advice if you are experienced enough to tell a one-time error
-due to faulty hardware apart from a kernel issue that rarely happens and thus
-is hard to reproduce.
-
-
 Install a fresh kernel for testing
 ----------------------------------
 
-- 
2.30.2

