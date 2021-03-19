Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7FD34262C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 20:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhCST2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 15:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhCST1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 15:27:53 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BA7C06174A;
        Fri, 19 Mar 2021 12:27:53 -0700 (PDT)
Received: from ip4d142c50.dynamic.kabel-deutschland.de ([77.20.44.80] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1lNKmk-0003Lu-CB; Fri, 19 Mar 2021 20:27:50 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] docs: reporting-issues.rst: tone down 'test vanilla mainline' a little
Date:   Fri, 19 Mar 2021 20:27:46 +0100
Message-Id: <652ee20eb36228f5d7ca842299faa4cb472feedb.1616181657.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616181657.git.linux@leemhuis.info>
References: <cover.1616181657.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1616182073;048012f6;
X-HE-SMSGID: 1lNKmk-0003Lu-CB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tell users that reporting bugs with vendor kernels which are only
slightly patched can be okay in some situations, but point out there's a
risk in doing so.

Adjust some related sections to make them compatible and a bit clearer.
At the same time make them less daunting: we want users to report bugs,
even if they can't test vanilla mainline kernel.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
CC: Randy Dunlap <rdunlap@infradead.org>

---
With this I try to get rid of the last remaining parts that have a
'this needs discussion' box that's in the text. I hope I've found a
middle ground that everybody can live with.

v2
* fix a few typos
* don't quote mainline, vanilla, stable, and longterm, except in the
  step by step guide, where users likely hit these special terms for the
  first time

v1, RFC https://lore.kernel.org/linux-doc/20210310072858.231776-1-linux@leemhuis.info/
* initial version
---
 .../admin-guide/reporting-issues.rst          | 273 ++++++++++--------
 1 file changed, 149 insertions(+), 124 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index 3b43748d8911..3c9bf24ebf66 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -94,10 +94,11 @@ early if an issue that looks like a Linux kernel problem is actually caused by
 something else. These steps thus help to ensure the time you invest in this
 process won't feel wasted in the end:
 
- * Stop reading this document and report the problem to your vendor instead,
-   unless you are running the latest mainline kernel already or are willing to
-   install it. This kernel must not be modified or enhanced in any way, and
-   thus be considered 'vanilla'.
+ * Are you facing an issue with a Linux kernel a hardware or software vendor
+   provided? Then in almost all cases you are better off to stop reading this
+   document and reporting the issue to your vendor instead, unless you are
+   willing to install the latest Linux version yourself. Be aware the latter
+   will often be needed anyway to hunt down and fix issues.
 
  * See if the issue you are dealing with qualifies as regression, security
    issue, or a really severe problem: those are 'issues of high priority' that
@@ -134,12 +135,14 @@ process won't feel wasted in the end:
 
 After these preparations you'll now enter the main part:
 
- * Install the latest Linux mainline kernel: that's where all issues get
-   fixed first, because it's the version line the kernel developers mainly
-   care about. Testing and reporting with the latest Linux stable kernel can
-   be an acceptable alternative in some situations, for example during the
-   merge window; but during that period you might want to suspend your efforts
-   till its end anyway.
+ * Unless you are already running the latest 'mainline' Linux kernel, better
+   go and install it for the reporting process. Testing and reporting with
+   the latest 'stable' Linux can be an acceptable alternative in some
+   situations; during the merge window that actually might be even the best
+   approach, but in that development phase it can be an even better idea to
+   suspend your efforts for a few days anyway. Whatever version you choose,
+   ideally use a 'vanilla' build. Ignoring these advices will dramatically
+   increase the risk your report will be rejected or ignored.
 
  * Ensure the kernel you just installed does not 'taint' itself when
    running.
@@ -276,55 +279,54 @@ issues to the Linux kernel developers.
 Make sure you're using the upstream Linux kernel
 ------------------------------------------------
 
-   *Stop reading this document and report the problem to your vendor instead,
-   unless you are running the latest mainline kernel already or are willing to
-   install it. This kernel must not be modified or enhanced in any way, and
-   thus be considered 'vanilla'.*
+   *Are you facing an issue with a Linux kernel a hardware or software vendor
+   provided? Then in almost all cases you are better off to stop reading this
+   document and reporting the issue to your vendor instead, unless you are
+   willing to install the latest Linux version yourself. Be aware the latter
+   will often be needed anyway to hunt down and fix issues.*
 
 Like most programmers, Linux kernel developers don't like to spend time dealing
-with reports for issues that don't even happen with the source code they
-maintain: it's just a waste everybody's time, yours included. That's why you
-later will have to test your issue with the latest 'vanilla' kernel: a kernel
-that was build using the Linux sources taken straight from `kernel.org
-<https://kernel.org/>`_ and not modified or enhanced in any way.
-
-Almost all kernels used in devices (Computers, Laptops, Smartphones, Routers,
-…) and most kernels shipped by Linux distributors are ancient from the point of
-kernel development and heavily modified. They thus do not qualify for reporting
-an issue to the Linux kernel developers: the issue you face with such a kernel
-might be fixed already or caused by the changes or additions, even if they look
-small or totally unrelated. That's why issues with such kernels need to be
-reported to the vendor that distributed it. Its developers should look into the
+with reports for issues that don't even happen with their current code. It's
+just a waste everybody's time, especially yours. Unfortunately such situations
+easily happen when it comes to the kernel and often leads to frustration on both
+sides. That's because almost all Linux-based kernels pre-installed on devices
+(Computers, Laptops, Smartphones, Routers, …) and most shipped by Linux
+distributors are quite distant from the official Linux kernel as distributed by
+kernel.org: these kernels from these vendors are often ancient from the point of
+Linux development or heavily modified, often both.
+
+Most of these vendor kernels are quite unsuitable for reporting bugs to the
+Linux kernel developers: an issue you face with one of them might have been
+fixed by the Linux kernel developers months or years ago already; additionally,
+the modifications and enhancements by the vendor might be causing the issue you
+face, even if they look small or totally unrelated. That's why you should report
+issues with these kernels to the vendor. Its developers should look into the
 report and, in case it turns out to be an upstream issue, fix it directly
-upstream or report it there. In practice that sometimes does not work out. If
-that the case, you might want to circumvent the vendor by installing the latest
-mainline kernel yourself and reporting the issue as outlined in this document;
-just make sure to use really fresh kernel (see below).
-
-
-.. note::
-
-   FIXME: Should we accept reports for issues with kernel images that are pretty
-   close to vanilla? But when are they close enough and how to put that line in
-   words? Maybe something like this?
-
-    *Note: Some Linux kernel developers accept reports from vendor kernels that
-    are known to be close to upstream. That for example is often the case for
-    the kernels that Debian GNU/Linux Sid or Fedora Rawhide ship, which are
-    normally following mainline closely and carry only a few patches. So a
-    report with one of these might be accepted by the developers that need to
-    handle it. But if they do, depends heavily on the individual developers and
-    the issue at hand. That's why installing a mainline vanilla kernel is the
-    safe bet.*
-
-    *Arch Linux, other Fedora releases, and openSUSE Tumbleweed often use quite
-    recent stable kernels that are pretty close to upstream, too. Some
-    developers accept bugs from them as well. But note that you normally should
-    avoid stable kernels for reporting issues and use a mainline kernel instead
-    (see below).*
-
-   Are there any other major Linux distributions that should be mentioned here?
-
+upstream or forward the report there. In practice that often does not work out
+or might not what you want. You thus might want to consider circumventing the
+vendor by installing the very latest Linux kernel core yourself. If that's an
+option for you move ahead in this process, as a later step in this guide will
+explain how to do that once it rules out other potential causes for your issue.
+
+Note, the previous paragraph is starting with the word 'most', as sometimes
+developers in fact are willing to handle reports about issues occurring with
+vendor kernels. If they do in the end highly depends on the developers and the
+issue in question. Your chances are quite good if the distributor applied only
+small modifications to a kernel based on a recent Linux version; that for
+example often holds true for the mainline kernels shipped by Debian GNU/Linux
+Sid or Fedora Rawhide. Some developers will also accept reports about issues
+with kernels from distributions shipping the latest stable kernel, as long as
+its only slightly modified; that for example is often the case for Arch Linux,
+regular Fedora releases, and openSUSE Tumbleweed. But keep in mind, you better
+want to use a mainline Linux and avoid using a stable kernel for this
+process, as outlined in the section 'Install a fresh kernel for testing' in more
+detail.
+
+Obviously you are free to ignore all this advice and report problems with an old
+or heavily modified vendor kernel to the upstream Linux developers. But note,
+those often get rejected or ignored, so consider yourself warned. But it's still
+better than not reporting the issue at all: sometimes such reports directly or
+indirectly will help to get the issue fixed over time.
 
 Issue of high priority?
 -----------------------
@@ -690,13 +692,12 @@ Make sure your kernel doesn't get enhanced
     kernel modules on-the-fly, which solutions like DKMS might be doing locally
     without your knowledge.*
 
-Your kernel must be 'vanilla' when reporting an issue, but stops being pure as
-soon as it loads a kernel module not built from the sources used to compile the
-kernel image itself. That's why you need to ensure your Linux kernel stays
-vanilla by removing or disabling mechanisms like akmods and DKMS: those might
-build additional kernel modules automatically, for example when your boot into
-a newly installed Linux kernel the first time. Reboot after removing them and
-any modules they installed.
+The risk your issue report gets ignored or rejected dramatically increases if
+your kernel gets enhanced in any way. That's why you should remove or disable
+mechanisms like akmods and DKMS: those build add-on kernel modules
+automatically, for example when you install a new Linux kernel or boot it for
+the first time. Also remove any modules they might have installed. Then reboot
+before proceeding.
 
 Note, you might not be aware that your system is using one of these solutions:
 they often get set up silently when you install Nvidia's proprietary graphics
@@ -770,44 +771,47 @@ is hard to reproduce.
 Install a fresh kernel for testing
 ----------------------------------
 
-    *Install the latest Linux mainline kernel: that's where all issues get
-    fixed first, because it's the version line the kernel developers mainly
-    care about. Testing and reporting with the latest Linux stable kernel can
-    be an acceptable alternative in some situations, for example during the
-    merge window; but during that period you might want to suspend your efforts
-    till its end anyway.*
-
-Reporting an issue to the Linux kernel developers they fixed weeks or months
-ago is annoying for them and wasting their and your time. That's why it's in
-everybody's interest to check if the issue occurs with the latest codebase
-before reporting it.
-
-In the scope of the Linux kernel the term 'latest' means: a kernel version
-recently created from the main line of development, as this 'mainline' tree is
-where developers first apply fixes; only after that are they are allowed to get
-backported to older, still supported version lines called 'stable' and
-'longterm' kernels. That's why you should check a recent mainline kernel, even
-if you deal with an issue you only want to see fixed in an older version line.
-Another reason: some fixes are only applied to mainline or recent version
-lines, as it's too hard or risky to backport them to older versions. If that
-the case, reporting the issue again is unlikely to change anything.
-
-Longterm kernels (sometimes called "LTS kernels") are therefore unsuitable for
-testing; they simply are too distant from current development. Even the latest
-Linux 'stable' kernel is a significant bit behind and thus better avoided. At
-least most of the time, as sometimes a stable kernel can the best choice; but
-in those situations you might want to wait a few days anyway:
-
-Choosing between mainline, stable and waiting
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-Head over to `kernel.org <https://kernel.org/>`_ to decide which version to
-use. Ignore the big yellow button that says 'Latest release' and look a little
-lower for a table. At its top you'll see a line starting with 'mainline', which
-most of the time will point to a pre-release with a version number like
-'5.8-rc2'. If that's the case, you'll want to use this mainline kernel for
-testing. Do not let that 'rc' scare you, these 'development kernels' are pretty
-reliable — and you made a backup, as you were instructed above, didn't you?
+    *Unless you are already running the latest 'mainline' Linux kernel, better
+    go and install it for the reporting process. Testing and reporting with
+    the latest 'stable' Linux can be an acceptable alternative in some
+    situations; during the merge window that actually might be even the best
+    approach, but in that development phase it can be an even better idea to
+    suspend your efforts for a few days anyway. Whatever version you choose,
+    ideally use a 'vanilla' built. Ignoring these advices will dramatically
+    increase the risk your report will be rejected or ignored.*
+
+As mentioned in the detailed explanation for the first step already: Like most
+programmers, Linux kernel developers don't like to spend time dealing with
+reports for issues that don't even happen with the current code. It's just a
+waste everybody's time, especially yours. That's why it's in everybody's
+interest that you confirm the issue still exists with the latest upstream code
+before reporting it. You are free to ignore this advice, but as outlined
+earlier: doing so dramatically increases the risk that your issue report might
+get rejected or simply ignored.
+
+In the scope of the kernel "latest upstream" normally means:
+
+ * Install a mainline kernel; the latest stable kernel can be an option, but
+   most of the time is better avoided. Longterm kernels (sometimes called 'LTS
+   kernels') are unsuitable at this point of the process. The next subsection
+   explains all of this in more detail.
+
+ * The over next subsection describes way to obtain and install such a kernel.
+   It also outlines that using a pre-compiled kernel are fine, but better are
+   vanilla, which means: it was built using Linux sources taken straight `from
+   kernel.org <https://kernel.org/>`_ and not modified or enhanced in any way.
+
+Choosing the right version for testing
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Head over to `kernel.org <https://kernel.org/>`_ to find out which version you
+want to use for testing. Ignore the big yellow button that says 'Latest release'
+and look a little lower at the table. At its top you'll see a line starting with
+mainline, which most of the time will point to a pre-release with a version
+number like '5.8-rc2'. If that's the case, you'll want to use this mainline
+kernel for testing, as that where all fixes have to be applied first. Do not let
+that 'rc' scare you, these 'development kernels' are pretty reliable — and you
+made a backup, as you were instructed above, didn't you?
 
 In about two out of every nine to ten weeks, 'mainline' might point you to a
 proper release with a version number like '5.7'. If that happens, consider
@@ -830,39 +834,60 @@ case mainline for some reason does currently not work for you. An in general:
 using it for reproducing the issue is also better than not reporting it issue
 at all.
 
+Better avoid using the latest stable kernel outside merge windows, as all fixes
+must be applied to mainline first. That's why checking the latest mainline
+kernel is so important: any issue you want to see fixed in older version lines
+needs to be fixed in mainline first before it can get backported, which can
+take a few days or weeks. Another reason: the fix you hope for might be too
+hard or risky for backporting; reporting the issue again hence is unlikely to
+change anything.
+
+These aspects are also why longterm kernels (sometimes called "LTS kernels")
+are unsuitable for this part of the reporting process: they are to distant from
+the current code. Hence go and test mainline first and follow the process
+further: if the issue doesn't occur with mainline it will guide you how to get
+it fixed in older version lines, if that's in the cards for the fix in question.
+
 How to obtain a fresh Linux kernel
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-You can use pre-built or self-compiled kernel for testing; if you choose the
-latter approach, you can either obtain the source code using git or download it
-as tar archive.
-
-Using a pre-compiled kernel for testing is often the quickest, easiest, and
-safest way – especially is you are unfamiliar with the Linux kernel. But it
-needs to be a vanilla kernel, which can be hard to come buy. You are in luck if
-you are using a popular Linux distribution: for quite a few of them you'll find
-repositories on the net that contain packages with the latest mainline or
-stable kernels in vanilla fashion. It's totally okay to use these, just make
-sure from the repository's documentation they are really vanilla. And ensure
-the packages contain the latest versions as offered on kernel.org; they are
-likely unsuitable if the package is older than a week, as new mainline and
-stable kernels typically get released at least once a week. And be aware that
-you might need to get build your own kernel later anyway when it comes to
-helping test fixes, as described later in this document.
-
-Developers and experienced Linux users familiar with git are often best served
-by obtaining the latest Linux kernel sources straight from the `official
-development repository on kernel.org
+**Using a pre-compiled kernel**: This is often the quickest, easiest, and safest
+way for testing — especially is you are unfamiliar with the Linux kernel. The
+problem: most of those shipped by distributors or add-on repositories are build
+from modified Linux sources. They are thus not vanilla and therefore often
+unsuitable for testing and issue reporting: the changes might cause the issue
+you face or influence it somehow.
+
+But you are in luck if you are using a popular Linux distribution: for quite a
+few of them you'll find repositories on the net that contain packages with the
+latest mainline or stable Linux built as vanilla kernel. It's totally okay to
+use these, just make sure from the repository's description they are vanilla or
+at least close to it. Additionally ensure the packages contain the latest
+versions as offered on kernel.org. The packages are likely unsuitable if they
+are older than a week, as new mainline and stable kernels typically get released
+at least once a week.
+
+Please note that you might need to build your own kernel manually later: that's
+sometimes needed for debugging or testing fixes, as described later in this
+document. Also be aware that pre-compiled kernels might lack debug symbols that
+are needed to decode messages the kernel prints when a panic, Oops, warning, or
+BUG occurs; if you plan to decode those, you might be better off compiling a
+kernel yourself (see the end of this subsection and the section titled 'Decode
+failure messages' for details).
+
+**Using git**: Developers and experienced Linux users familiar with git are
+often best served by obtaining the latest Linux kernel sources straight from the
+`official development repository on kernel.org
 <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/>`_.
 Those are likely a bit ahead of the latest mainline pre-release. Don't worry
 about it: they are as reliable as a proper pre-release, unless the kernel's
 development cycle is currently in the middle of a merge window. But even then
 they are quite reliable.
 
-People unfamiliar with git are often best served by downloading the sources as
-tarball from `kernel.org <https://kernel.org/>`_.
+**Conventional**: People unfamiliar with git are often best served by
+downloading the sources as tarball from `kernel.org <https://kernel.org/>`_.
 
-How to actually build a kernel isnot described here, as many websites explain
+How to actually build a kernel is not described here, as many websites explain
 the necessary steps already. If you are new to it, consider following one of
 those how-to's that suggest to use ``make localmodconfig``, as that tries to
 pick up the configuration of your current kernel and then tries to adjust it
-- 
2.30.2

