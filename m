Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2531534EA0E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbhC3ON4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbhC3ONW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:13:22 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E9CC061765;
        Tue, 30 Mar 2021 07:13:21 -0700 (PDT)
Received: from ip4d14bd53.dynamic.kabel-deutschland.de ([77.20.189.83] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1lRF7I-0000jw-DA; Tue, 30 Mar 2021 16:13:12 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/4] docs: reporting-issues: reduce quoting and assorted fixes
Date:   Tue, 30 Mar 2021 16:13:07 +0200
Message-Id: <07bca15d8465b8e234537feb8841dd2ff20243bc.1617113469.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617113469.git.linux@leemhuis.info>
References: <cover.1617113469.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1617113602;38c5c4bd;
X-HE-SMSGID: 1lRF7I-0000jw-DA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A pile of small fixes:

- don't quote terms like vanilla, mainline, and stable, unless in they
  occur in places where readers new to the kernel might see them for the
  first time

- make people rule out that vendor patches are interfering if they face
  a regression in a stable or longterm kernel they saw in a vendor
  kernel for the first time

- s/bugs/issues/ in a selected spots

- exchange two headlines that got mixed up somehow

- add a few links to some of the steps in the guide

- Greg mentioned sending reports to the stable mailing list is
  sufficient, so remove the "CC stable maintainers" bits

- fix a few typos and mistakes in the text, with a few very small
  improvements along the way

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../admin-guide/reporting-issues.rst          | 79 +++++++++++--------
 1 file changed, 45 insertions(+), 34 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index 77d38acca282..e6137c971007 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -77,9 +77,9 @@ process won't feel wasted in the end:
    will often be needed anyway to hunt down and fix issues.
 
  * Perform a rough search for existing reports with your favorite internet
-   search engine; additionally, check the archives of the Linux Kernel Mailing
-   List (LKML). If you find matching reports, join the discussion instead of
-   sending a new one.
+   search engine; additionally, check the archives of the `Linux Kernel Mailing
+   List (LKML) <https://lore.kernel.org/lkml/>`_. If you find matching reports,
+   join the discussion instead of sending a new one.
 
  * See if the issue you are dealing with qualifies as regression, security
    issue, or a really severe problem: those are 'issues of high priority' that
@@ -181,21 +181,23 @@ regressions as quickly as possible, hence there is a streamlined process to
 report them:
 
  * Check if the kernel developers still maintain the Linux kernel version
-   line you care about: go to the front page of kernel.org and make sure it
-   mentions the latest release of the particular version line without an
-   '[EOL]' tag.
+   line you care about: go to the  `front page of kernel.org
+   <https://kernel.org/>`_ and make sure it mentions
+   the latest release of the particular version line without an '[EOL]' tag.
 
- * Check the archives of the Linux stable mailing list for existing reports.
+ * Check the archives of the `Linux stable mailing list
+   <https://lore.kernel.org/stable/>`_ for existing reports.
 
  * Install the latest release from the particular version line as a vanilla
    kernel. Ensure this kernel is not tainted and still shows the problem, as
-   the issue might have already been fixed there.
+   the issue might have already been fixed there. If you first noticed the
+   problem with a vendor kernel, check a vanilla build of the last version
+   known to work performs fine as well.*
 
- * Send a short problem report by mail to the people and mailing lists the
-   :ref:`MAINTAINERS <maintainers>` file specifies in the section 'STABLE
-   BRANCH'. Roughly describe the issue and ideally explain how to reproduce
-   it. Mention the first version that shows the problem and the last version
-   that's working fine. Then wait for further instructions.
+ * Send a short problem report to the Linux stable mailing list
+   (stable@vger.kernel.org). Roughly describe the issue and ideally explain
+   how to reproduce it. Mention the first version that shows the problem and
+   the last version that's working fine. Then wait for further instructions.*
 
 The reference section below explains each of these steps in more detail.
 
@@ -205,8 +207,8 @@ Reporting issues only occurring in older kernel version lines
 
 This subsection is for you, if you tried the latest mainline kernel as outlined
 above, but failed to reproduce your issue there; at the same time you want to
-see the issue fixed in older version lines or a vendor kernel that's regularly
-rebased on new stable or longterm releases. If that case follow these steps:
+see the issue fixed in a still supported stable or longterm series or vendor
+kernels regularly rebased on those. If that the case, follow these steps:
 
  * Prepare yourself for the possibility that going through the next few steps
    might not get the issue solved in older releases: the fix might be too big
@@ -291,7 +293,7 @@ distributors are quite distant from the official Linux kernel as distributed by
 kernel.org: these kernels from these vendors are often ancient from the point of
 Linux development or heavily modified, often both.
 
-Most of these vendor kernels are quite unsuitable for reporting bugs to the
+Most of these vendor kernels are quite unsuitable for reporting issues to the
 Linux kernel developers: an issue you face with one of them might have been
 fixed by the Linux kernel developers months or years ago already; additionally,
 the modifications and enhancements by the vendor might be causing the issue you
@@ -816,7 +818,7 @@ kernel for testing, as that where all fixes have to be applied first. Do not let
 that 'rc' scare you, these 'development kernels' are pretty reliable — and you
 made a backup, as you were instructed above, didn't you?
 
-In about two out of every nine to ten weeks, 'mainline' might point you to a
+In about two out of every nine to ten weeks, mainline might point you to a
 proper release with a version number like '5.7'. If that happens, consider
 suspending the reporting process until the first pre-release of the next
 version (5.8-rc1) shows up on kernel.org. That's because the Linux development
@@ -1231,7 +1233,7 @@ Special handling for high priority issues
 
 Reports for high priority issues need special handling.
 
-**Severe bugs**: make sure the subject or ticket title as well as the first
+**Severe issues**: make sure the subject or ticket title as well as the first
 paragraph makes the severeness obvious.
 
 **Regressions**: If the issue is a regression add [REGRESSION] to the mail's
@@ -1455,11 +1457,11 @@ easier. And with a bit of luck there might be someone in the team that knows a
 bit about programming and might be able to write a fix.
 
 
-Reference for "Reporting issues only occurring in older kernel version lines"
------------------------------------------------------------------------------
+Reference for "Reporting regressions within a stable and longterm kernel line"
+------------------------------------------------------------------------------
 
-This subsection provides details for step you need to perform if you face a
-regression within a stable and longterm kernel line.
+This subsection provides details for the steps you need to perform if you face
+a regression within a stable and longterm kernel line.
 
 Make sure the particular version line still gets support
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -1475,7 +1477,7 @@ chosen and gets supported for at least two years (often six). That's why you
 need to check if the kernel developers still support the version line you care
 for.
 
-Note, if kernel.org lists two 'stable' version lines on the front page, you
+Note, if kernel.org lists two stable version lines on the front page, you
 should consider switching to the newer one and forget about the older one:
 support for it is likely to be abandoned soon. Then it will get a "end-of-life"
 (EOL) stamp. Version lines that reached that point still get mentioned on the
@@ -1498,7 +1500,9 @@ Reproduce issue with the newest release
 
     *Install the latest release from the particular version line as a vanilla
     kernel. Ensure this kernel is not tainted and still shows the problem, as
-    the issue might have already been fixed there.*
+    the issue might have already been fixed there. If you first noticed the
+    problem with a vendor kernel, check a vanilla build of the last version
+    known to work performs fine as well.*
 
 Before investing any more time in this process you want to check if the issue
 was already fixed in the latest release of version line you're interested in.
@@ -1506,14 +1510,22 @@ This kernel needs to be vanilla and shouldn't be tainted before the issue
 happens, as detailed outlined already above in the section "Install a fresh
 kernel for testing".
 
+Did you first notice the regression with a vendor kernel? Then changes the
+vendor applied might be interfering. You need to rule that out by performing
+a recheck. Say something broke when you updated from 5.10.4-vendor.42 to
+5.10.5-vendor.43. Then after testing the latest 5.10 release as outlined in
+the previous paragraph check if a vanilla build of Linux 5.10.4 works fine as
+well. If things are broken there, the issue does not qualify as upstream
+regression and you need switch back to the main step-by-step guide to report
+the issue.
+
 Report the regression
 ~~~~~~~~~~~~~~~~~~~~~
 
-    *Send a short problem report by mail to the people and mailing lists the
-    :ref:`MAINTAINERS <maintainers>` file specifies in the section 'STABLE
-    BRANCH'. Roughly describe the issue and ideally explain how to reproduce
-    it. Mention the first version that shows the problem and the last version
-    that's working fine. Then wait for further instructions.*
+    *Send a short problem report to the Linux stable mailing list
+    (stable@vger.kernel.org). Roughly describe the issue and ideally explain
+    how to reproduce it. Mention the first version that shows the problem and
+    the last version that's working fine. Then wait for further instructions.*
 
 When reporting a regression that happens within a stable or longterm kernel
 line (say when updating from 5.10.4 to 5.10.5) a brief report is enough for
@@ -1540,10 +1552,10 @@ the document 'Documentation/admin-guide/bug-bisect.rst' for details how to
 perform one.
 
 
-Reference for "Reporting regressions within a stable and longterm kernel line"
-------------------------------------------------------------------------------
+Reference for "Reporting issues only occurring in older kernel version lines"
+-----------------------------------------------------------------------------
 
-This section provides details for steps you need to take if you could not
+This section provides details for the steps you need to take if you could not
 reproduce your issue with a mainline kernel, but want to see it fixed in older
 version lines (aka stable and longterm kernels).
 
@@ -1648,8 +1660,7 @@ Ask for advice
 If the previous three steps didn't get you closer to a solution there is only
 one option left: ask for advice. Do that in a mail you sent to the maintainers
 for the subsystem where the issue seems to have its roots; CC the mailing list
-for the subsystem as well as the stable mailing list the :ref:`MAINTAINERS
-<maintainers>` file mention in the section "STABLE BRANCH".
+for the subsystem as well as the stable mailing list (stable@vger.kernel.org).
 
 
 Why some issues won't get any reaction or remain unfixed after being reported
-- 
2.30.2

