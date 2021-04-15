Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E25336071D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbhDOK3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhDOK3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:29:39 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF304C061574;
        Thu, 15 Apr 2021 03:29:16 -0700 (PDT)
Received: from ip4d14bd53.dynamic.kabel-deutschland.de ([77.20.189.83] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1lWzFK-0007Zb-Mc; Thu, 15 Apr 2021 12:29:14 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] docs: reporting-issues.rst: CC subsystem and maintainers on regressions
Date:   Thu, 15 Apr 2021 12:29:14 +0200
Message-Id: <dd13f10c30e79e550215e53a8103406daec4e593.1618482489.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1618482557;f56efbec;
X-HE-SMSGID: 1lWzFK-0007Zb-Mc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reporting a regression, users ideally should CC the subsystem and
its maintainers, as that will ensure they get aware of the regression
quickly. And if the culprit is known, they should also CC everyone who
signed if off; the text mentioned the latter in once place already, but
forgot to do so in two other areas where it's relevant.

While fixing this also remind readers to check the mailing list archives
for issues that need to be reported to a bug tracker, as someone might
have reported it by mail only.

All of this got triggered by a recent report where these changes would
have made a difference.

Link: https://lore.kernel.org/lkml/dff6badf-58f5-98c8-871c-94d901ac6919@leemhuis.info/
Link: https://lore.kernel.org/lkml/CAJZ5v0hX2StQVttAciHYH-urUH+Hi92z9z2ZbcNgQPt0E2Jpwg@mail.gmail.com/
Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../admin-guide/reporting-issues.rst          | 49 ++++++++++++-------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index 48b4d0ef2b09..18d8e25ba9df 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -24,7 +24,8 @@ longterm series? One still supported? Then search the `LKML
 you don't find any, install `the latest release from that series
 <https://kernel.org/>`_. If it still shows the issue, report it to the stable
 mailing list (stable@vger.kernel.org) and CC the regressions list
-(regressions@lists.linux.dev).
+(regressions@lists.linux.dev); ideally also CC the maintainer and the mailing
+list for the subsystem in question.
 
 In all other cases try your best guess which kernel part might be causing the
 issue. Check the :ref:`MAINTAINERS <maintainers>` file for how its developers
@@ -48,8 +49,9 @@ before the issue occurs.
 If you are facing multiple issues with the Linux kernel at once, report each
 separately. While writing your report, include all information relevant to the
 issue, like the kernel and the distro used. In case of a regression, CC the
-regressions mailing list (regressions@lists.linux.dev) to your report; also try
-to include the commit-id of the change causing it, which a bisection can find.
+regressions mailing list (regressions@lists.linux.dev) to your report. Also try
+to pin-point the culprit with a bisection; if you succeed, include its
+commit-id and CC everyone in the sign-off-by chain.
 
 Once the report is out, answer any questions that come up and help where you
 can. That includes keeping the ball rolling by occasionally retesting with newer
@@ -198,10 +200,11 @@ report them:
 
  * Send a short problem report to the Linux stable mailing list
    (stable@vger.kernel.org) and CC the Linux regressions mailing list
-   (regressions@lists.linux.dev). Roughly describe the issue and ideally
-   explain how to reproduce it. Mention the first version that shows the
-   problem and the last version that's working fine. Then wait for further
-   instructions.
+   (regressions@lists.linux.dev); if you suspect the cause in a particular
+   subsystem, CC its maintainer and its mailing list. Roughly describe the
+   issue and ideally explain how to reproduce it. Mention the first version
+   that shows the problem and the last version that's working fine. Then
+   wait for further instructions.
 
 The reference section below explains each of these steps in more detail.
 
@@ -768,7 +771,9 @@ regular internet search engine and add something like
 the results to the archives at that URL.
 
 It's also wise to check the internet, LKML and maybe bugzilla.kernel.org again
-at this point.
+at this point. If your report needs to be filed in a bug tracker, you may want
+to check the mailing list archives for the subsystem as well, as someone might
+have reported it only there.
 
 For details how to search and what to do if you find matching reports see
 "Search for existing reports, first run" above.
@@ -1249,9 +1254,10 @@ and the oldest where the issue occurs (say 5.8-rc1).
 
 When sending the report by mail, CC the Linux regressions mailing list
 (regressions@lists.linux.dev). In case the report needs to be filed to some web
-tracker, proceed to do so; once filed, forward the report by mail to the
-regressions list. Make sure to inline the forwarded report, hence do not attach
-it. Also add a short note at the top where you mention the URL to the ticket.
+tracker, proceed to do so. Once filed, forward the report by mail to the
+regressions list; CC the maintainer and the mailing list for the subsystem in
+question. Make sure to inline the forwarded report, hence do not attach it.
+Also add a short note at the top where you mention the URL to the ticket.
 
 When mailing or forwarding the report, in case of a successful bisection add the
 author of the culprit to the recipients; also CC everyone in the signed-off-by
@@ -1536,17 +1542,20 @@ Report the regression
 
     *Send a short problem report to the Linux stable mailing list
     (stable@vger.kernel.org) and CC the Linux regressions mailing list
-    (regressions@lists.linux.dev). Roughly describe the issue and ideally
-    explain how to reproduce it.  Mention the first version that shows the
-    problem and the last version that's working fine. Then wait for further
-    instructions.*
+    (regressions@lists.linux.dev); if you suspect the cause in a particular
+    subsystem, CC its maintainer and its mailing list. Roughly describe the
+    issue and ideally explain how to reproduce it. Mention the first version
+    that shows the problem and the last version that's working fine. Then
+    wait for further instructions.*
 
 When reporting a regression that happens within a stable or longterm kernel
 line (say when updating from 5.10.4 to 5.10.5) a brief report is enough for
-the start to get the issue reported quickly. Hence a rough description is all
-it takes.
+the start to get the issue reported quickly. Hence a rough description to the
+stable and regressions mailing list is all it takes; but in case you suspect
+the cause in a particular subsystem, CC its maintainers and its mailing list
+as well, because that will speed things up.
 
-But note, it helps developers a great deal if you can specify the exact version
+And note, it helps developers a great deal if you can specify the exact version
 that introduced the problem. Hence if possible within a reasonable time frame,
 try to find that version using vanilla kernels. Lets assume something broke when
 your distributor released a update from Linux kernel 5.10.5 to 5.10.8. Then as
@@ -1563,7 +1572,9 @@ pinpoint the exact change that causes the issue (which then can easily get
 reverted to fix the issue quickly). Hence consider to do a proper bisection
 right away if time permits. See the section 'Special care for regressions' and
 the document 'Documentation/admin-guide/bug-bisect.rst' for details how to
-perform one.
+perform one. In case of a successful bisection add the author of the culprit to
+the recipients; also CC everyone in the signed-off-by chain, which you find at
+the end of its commit message.
 
 
 Reference for "Reporting issues only occurring in older kernel version lines"

base-commit: 6161a4b18a66746c3f5afa72c054d7e58e49c847
-- 
2.30.2

