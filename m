Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18854330058
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 12:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhCGLe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 06:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhCGLd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 06:33:57 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD08C06174A;
        Sun,  7 Mar 2021 03:33:57 -0800 (PST)
Received: from ip4d142c50.dynamic.kabel-deutschland.de ([77.20.44.80] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1lIrfT-0002Ox-R9; Sun, 07 Mar 2021 12:33:51 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] docs: reporting-issues.rst: shortcut for reporting stable regressions
Date:   Sun,  7 Mar 2021 12:33:50 +0100
Message-Id: <148a84de8d109ebbc01a337fb93cb246410c4351.1615116592.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1615116592.git.linux@leemhuis.info>
References: <cover.1615116592.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1615116837;e43d2063;
X-HE-SMSGID: 1lIrfT-0002Ox-R9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a much shorter and easier process for users that deal with
regressions in stable and longterm kernels, as those should be reported
quickly.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
CC: Randy Dunlap <rdunlap@infradead.org>
---
v2
* revist, lots of small improvements in various places

v1
* https://lore.kernel.org/linux-doc/20210214145454.357392-1-linux@leemhuis.info/
* initial version
---
 .../admin-guide/reporting-issues.rst          | 140 ++++++++++++------
 1 file changed, 94 insertions(+), 46 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index 24ee78455d3e..937797e52837 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -106,6 +106,10 @@ process won't feel wasted in the end:
    issue, or a really severe problem: those are 'issues of high priority' that
    need special handling in some steps that are about to follow.
 
+ * If you are facing a regression within a stable or longterm version line
+   (say something broke when updating from 5.10.4 to 5.10.5), head over to
+   'Dealing with regressions within a stable and longterm kernel line'.
+
  * Locate the driver or kernel subsystem that seems to be causing the issue.
    Find out how and where its developers expect reports. Note: most of the
    time this won't be bugzilla.kernel.org, as issues typically need to be sent
@@ -215,23 +219,42 @@ rebased on new stable or longterm releases. If that case follow these steps:
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
 
 
+Dealing with regressions within a stable and longterm kernel line
+-----------------------------------------------------------------
+
+This section is for you, if you face a regression within a stable or longterm
+kernel version line, e.g. if something breaks when updating from 5.10.4 to
+5.10.5 (a switch from 5.9.15 to 5.10.5 would not qualify). The developers want
+to fix such regressions as quickly as possible, hence there is a streamlined
+process to report them:
+
+ * Check the archives of the Linux stable mailing list for existing reports.
+
+ * Check if the kernel developers still maintain the Linux kernel version
+   line you care about: go to the front page of kernel.org and make sure it
+   mentions the latest release of the particular version line without an
+   '[EOL]' tag.
+
+ * Install the latest release from the particular version line as a vanilla
+   kernel. Ensure this kernel is not tainted and still shows the problem, as
+   the issue might have already been fixed there.
+
+ * Make sure it's not the kernel's surroundings that are causing the issue
+   you face.
+
+ * Send a short problem report by mail to the people and mailing lists the
+   :ref:`MAINTAINERS <maintainers>` file specifies in the section 'STABLE
+   BRANCH'. Roughly describe the issue and ideally explain how to reproduce
+   it. Mention the first version that shows the problem and the last version
+   that's working fine. Then wait for further instructions.
+
+
 Reference section: Reporting issues to the kernel maintainers
 =============================================================
 
@@ -433,6 +456,22 @@ fatal error where the kernel stop itself) with a 'Oops' (a recoverable error),
 as the kernel remains running after the latter.
 
 
+Regression in stable or longterm kernel?
+----------------------------------------
+
+    *If you are facing a regression within a stable or longterm version line
+    (say something broke when updating from 5.10.4 to 5.10.5), head over to
+    'Dealing with regressions within a stable and longterm kernel line'.*
+
+Regression within a stable and longterm kernel version line are something the
+Linux developers want to fix badly, as such issues are even more unwanted than
+regression in the main development branch, as they can quickly affect a lot of
+people. The developers thus want to learn about such issues as quickly as
+possible, hence there is a streamlined process to report them. Note,
+regressions with newer kernel version line (say something broke when switching
+from 5.9.15 to 5.10.5) do not qualify.
+
+
 Locate kernel area that causes the issue
 ----------------------------------------
 
@@ -1550,41 +1589,6 @@ discussions abound it.
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
@@ -1601,6 +1605,50 @@ for the subsystem as well as the stable mailing list the :ref:`MAINTAINERS
 <maintainers>` file mention in the section "STABLE BRANCH".
 
 
+Details about reporting regressions within a stable and longterm kernel lines
+-----------------------------------------------------------------------------
+
+This subsection provides details for the last step you need to perform if you
+face a regression within a stable and longterm kernel line. Four other steps
+need to be taken beforehand, as mentioned in the section 'Dealing with
+regressions within a stable and longterm kernel line' above. They are performed
+during the regular reporting process as well and thus already explained in
+other sections above in detail already.
+
+Report for stable or longterm regression
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+    *Send a short problem report by mail to the people and mailing lists the
+    :ref:`MAINTAINERS <maintainers>` file specifies in the section 'STABLE
+    BRANCH'. Roughly describe the issue and ideally explain how to reproduce
+    it. Mention the first version that shows the problem and the last version
+    that's working fine. Then wait for further instructions.*
+
+When reporting a regression that happens within a stable or longterm kernel
+line (say when updating from 5.10.4 to 5.10.5) a brief report is enough for
+the start to get the issue reported quickly. Hence a rough description is all
+it takes.
+
+But note, it helps developers a great deal if you can specify the exact version
+that introduced the problem. Hence if possible within a reasonable time frame,
+try to find that version using vanilla kernels. Lets assume something broke when
+your distributor released a update from Linux kernel 5.10.5 to 5.10.8. Then as
+instructed above go and check the latest kernel from that version line, say
+5.10.9. If it shows the problem, try a vanilla 5.10.5 to ensure that no patches
+the distributor applied interfere. If the issue doesn't manifest itself there,
+try 5.10.7 and then (depending on the outcome) 5.10.8 or 5.10.6 to find the
+first version where things broke. Mention it in the report and state that 5.10.9
+is still broken.
+
+What the previous paragraph outlines is basically a rough manual 'bisection'.
+Once your report is out your might get asked to do a proper one, as it allows to
+pinpoint the exact change that causes the issue (which then can easily get
+reverted to fix the issue quickly). Hence consider to do a proper bisection
+right away if time permits. See the section 'Special care for regressions' and
+the document 'Documentation/admin-guide/bug-bisect.rst' for details how to
+perform one.
+
+
 Why some issues won't get any reaction or remain unfixed after being reported
 =============================================================================
 
-- 
2.29.2

