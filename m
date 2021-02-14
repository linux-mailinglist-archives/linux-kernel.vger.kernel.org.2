Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5856931B0DF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 15:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhBNOzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 09:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhBNOzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 09:55:41 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A54C061574;
        Sun, 14 Feb 2021 06:55:01 -0800 (PST)
Received: from ip4d149f6e.dynamic.kabel-deutschland.de ([77.20.159.110] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1lBInW-0002Tn-Uv; Sun, 14 Feb 2021 15:54:55 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: reporting-issues.rst: shortcut for stable regressions
Date:   Sun, 14 Feb 2021 15:54:54 +0100
Message-Id: <20210214145454.357392-1-linux@leemhuis.info>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1613314501;d004843a;
X-HE-SMSGID: 1lBInW-0002Tn-Uv
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a much shorter and easier process for users that deal with
regressions in stable and longterm kernels, as those should be reported
quickly.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../admin-guide/reporting-issues.rst          | 91 ++++++++-----------
 1 file changed, 40 insertions(+), 51 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index 07879d01fe68..9679d1e0849d 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -99,13 +99,16 @@ process won't feel wasted in the end:
    install it. This kernel must not be modified or enhanced in any way, and
    thus be considered 'vanilla'.
 
- * See if the issue you are dealing with qualifies as regression, security
-   issue, or a really severe problem: those are 'issues of high priority' that
-   need special handling in some steps that are about to follow.
-
  * Check if your kernel was 'tainted' when the issue occurred, as the event
    that made the kernel set this flag might be causing the issue you face.
 
+ * See if the issue you are dealing with qualifies as regression, security
+   issue, or a really severe problem: those are 'issues of high priority' that
+   need special handling in some steps that are about to follow. If you are
+   dealing with a regression in a vanilla built stable or longterm kernel
+   that's still supported, head over to the section 'Dealing with regressions
+   in stable and longterm kernels'.
+
  * Locate the driver or kernel subsystem that seems to be causing the issue.
    Find out how and where its developers expect reports. Note: most of the
    time this won't be bugzilla.kernel.org, as issues typically need to be sent
@@ -215,23 +218,41 @@ rebased on new stable or longterm releases. If that case follow these steps:
    deemed unsuitable for backporting. If backporting was not considered at
    all, join the newest discussion, asking if it's in the cards.
 
- * Check if you're dealing with a regression that was never present in
-   mainline by installing the first release of the version line you care
-   about. If the issue doesn't show up with it, you basically need to report
-   the issue with this version like you would report a problem with mainline
-   (see above). This ideally includes a bisection followed by a search for
-   existing reports on the net; with the help of the subject and the two
-   relevant commit-ids. If that doesn't turn up anything, write the report; CC
-   or forward the report to the stable maintainers, the stable mailing list,
-   and those who authored the change. Include the shortened commit-id if you
-   found the change that causes it.
-
  * One of the former steps should lead to a solution. If that doesn't work
    out, ask the maintainers for the subsystem that seems to be causing the
    issue for advice; CC the mailing list for the particular subsystem as well
    as the stable mailing list.
 
 
+Dealing with regressions in stable and longterm kernels
+-------------------------------------------------------
+
+Regression in stable and longterm kernels (say when updating from 5.10.4 to
+5.10.5) are something really bad, as they can quickly affect a lot of people.
+They thus should be quickly dealt with by everyone involved, hence you are free
+to use a streamlined process to report your issue:
+
+ * Check the archives of the Linux stable mailing list for existing reports.
+
+ * Install the latest release from the particular version line as a vanilla
+   kernel. Ensure this kernel is not tainted and still shows the problem, as
+   the issue might have already been fixed there.
+
+ * Make sure it's not the kernel's surroundings that are causing the issue
+   you face.
+
+Those steps are also needed during the normal reporting process and explained in
+more details below. Once you performed them, send a rough problem report by mail
+to the people and mailing lists the :ref:`MAINTAINERS <maintainers>` file
+specifies in the section 'STABLE BRANCH'. Ask for further instruction and
+roughly explain how to reproduce the issue.
+
+With a bit of luck that might be all that is needed. Sometimes you will be asked
+to find the exact commit that causes the regression by using a process called
+'bisection'. The document 'Documentation/admin-guide/bug-bisect.rst' describes
+it in detail.
+
+
 Reference section: Reporting issues to the kernel maintainers
 =============================================================
 
@@ -331,7 +352,10 @@ Issue of high priority?
 
     *See if the issue you are dealing with qualifies as regression, security
     issue, or a really severe problem: those are 'issues of high priority' that
-    need special handling in some steps that are about to follow.*
+    need special handling in some steps that are about to follow. If you are
+    dealing with a regression in a vanilla built stable or longterm kernel
+    that's still supported, head over to the section 'Dealing with regressions
+    in stable and longterm kernels'.*
 
 Linus Torvalds and the leading Linux kernel developers want to see some issues
 fixed as soon as possible, hence there are 'issues of high priority' that get
@@ -1513,41 +1537,6 @@ discussions abound it.
      join the discussion: mention the version where you face the issue and that
      you would like to see it fixed, if suitable.
 
-Check if it's a regression specific to stable or longterm kernels
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-    *Check if you're dealing with a regression that was never present in
-    mainline by installing the first release of the version line you care
-    about. If the issue doesn't show up with it, you basically need to report
-    the issue with this version like you would report a problem with mainline
-    (see above). This ideally includes a bisection followed by a search for
-    existing reports on the net; with the help of the subject and the two
-    relevant commit-ids. If that doesn't turn up anything, write the report; CC
-    or forward the report to the stable maintainers, the stable mailing list,
-    and those who authored the change. Include the shortened commit-id if you
-    found the change that causes it.*
-
-Sometimes you won't find anything in the previous step: the issue you face
-might have never occurred in mainline, as it is caused by some change that is
-incomplete or not correctly applied. To check this, install the first release
-from version line you care about, e.g., if you care about 5.4.x, install 5.4.
-
-If the issue doesn't show itself there, it's a regression specific to the
-particular version line. In that case you need to report it like an issue
-happening in mainline, like the last few steps in the main section in the above
-outline.
-
-One of them suggests doing a bisection, which you are strongly advised to do in
-this case. After finding the culprit, search the net for existing reports
-again: not only search for the exact subject and the commit-id (proper and
-shortened to twelve characters) of the change, but also for the commit-id
-(proper and shortened) mentioned as 'Upstream commit' in the commit message.
-
-Write the report; just keep a few specialties in mind: CC or forward the report
-to the stable maintainers, the stable mailing list, which the :ref:`MAINTAINERS
-<maintainers>` file mentions in the section "STABLE BRANCH". If you performed a
-successful bisection, CC the author of the change and include its subject and
-the shortened commit-id.
 
 Ask for advice
 ~~~~~~~~~~~~~~
-- 
2.29.2

