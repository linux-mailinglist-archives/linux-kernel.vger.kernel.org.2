Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819053567E1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350060AbhDGJYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 05:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350049AbhDGJWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:22:10 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45721C06175F;
        Wed,  7 Apr 2021 02:22:01 -0700 (PDT)
Received: from ip4d14bd53.dynamic.kabel-deutschland.de ([77.20.189.83] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1lU4Np-0004en-NP; Wed, 07 Apr 2021 11:21:57 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 2/2] docs: reporting-issues: make everyone CC the regressions list
Date:   Wed,  7 Apr 2021 11:21:56 +0200
Message-Id: <813fc7b082a4b47ec6d34542971e9bba74fd4a51.1617786974.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617786974.git.linux@leemhuis.info>
References: <cover.1617786974.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1617787321;cddfe957;
X-HE-SMSGID: 1lU4Np-0004en-NP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make people CC the recently created mailing list dedicated to Linux
kernel regressions when reporting one. Some paragraphs had to be
reshuffled and slightly rewritten during the process, as the text
otherwise would have gotten unnecessarily hard to follow.

The new text also makes reporters include a line useful for automatic
regression tracking solution which does not exist yet, but is planned.
The term "#regzb" (short for regression bot) is inspired by the "#syz"
which can be used to communicate with syszbot (see
https://github.com/google/syzkaller/blob/master/docs/syzbot.md).

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
Lo! Now that we have a mailing list for regressions I was inclined to
remove the "Make the report's subject start with '[REGRESSION]'" part
from the text. But in the end I left it, to make it obvious on other
lists that the mail is about a regression. Nevertheless, I'm still
wondering if it should be toned down a bit, as it might be enough if the
subject starts with "regression:" or contains the word somewhere.

That automatic tracking solution hinted at in the commit message is
something I plan to work on in the next months. It won't be another
bugzilla-like tracker, more a simple database that works in the
background like syzbot. I'm not attached to the "#regzb" term, so please
speak up if you can think of something better that also works when
searching the internet.

Ciao, Thorsten
---
 .../admin-guide/reporting-issues.rst          | 64 +++++++++++++------
 1 file changed, 44 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index fd407c6951ea..45065c501beb 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -23,7 +23,8 @@ longterm series? One still supported? Then search the `LKML
 <https://lore.kernel.org/stable/>`_ archives for matching reports to join. If
 you don't find any, install `the latest release from that series
 <https://kernel.org/>`_. If it still shows the issue, report it to the stable
-mailing list (stable@vger.kernel.org).
+mailing list (stable@vger.kernel.org) and CC the regressions list
+(regressions@lists.linux.dev).
 
 In all other cases try your best guess which kernel part might be causing the
 issue. Check the :ref:`MAINTAINERS <maintainers>` file for how its developers
@@ -44,10 +45,11 @@ ensure it's vanilla (IOW: not patched and not using add-on modules). Also make
 sure it's built and running in a healthy environment and not already tainted
 before the issue occurs.
 
-While writing your report, include all information relevant to the issue, like
-the kernel and the distro used. In case of a regression try to include the
-commit-id of the change causing it, which a bisection can find. If you're facing
-multiple issues with the Linux kernel at once, report each separately.
+If you are facing multiple issues with the Linux kernel at once, report each
+separately. While writing your report, include all information relevant to the
+issue, like the kernel and the distro used. In case of a regression, CC the
+regressions mailing list (regressions@lists.linux.dev) to your report; also try
+to include the commit-id of the change causing it, which a bisection can find.
 
 Once the report is out, answer any questions that come up and help where you
 can. That includes keeping the ball rolling by occasionally retesting with newer
@@ -192,12 +194,14 @@ report them:
    kernel. Ensure this kernel is not tainted and still shows the problem, as
    the issue might have already been fixed there. If you first noticed the
    problem with a vendor kernel, check a vanilla build of the last version
-   known to work performs fine as well.*
+   known to work performs fine as well.
 
  * Send a short problem report to the Linux stable mailing list
-   (stable@vger.kernel.org). Roughly describe the issue and ideally explain
-   how to reproduce it. Mention the first version that shows the problem and
-   the last version that's working fine. Then wait for further instructions.*
+   (stable@vger.kernel.org) and CC the Linux regressions mailing list
+   (regressions@lists.linux.dev). Roughly describe the issue and ideally
+   explain how to reproduce it.  Mention the commit or version that introduced
+   the regression as outlined in 'Special handling for high priority issues'.
+   Then wait for further instructions.
 
 The reference section below explains each of these steps in more detail.
 
@@ -1236,14 +1240,32 @@ Reports for high priority issues need special handling.
 **Severe issues**: make sure the subject or ticket title as well as the first
 paragraph makes the severeness obvious.
 
-**Regressions**: If the issue is a regression add [REGRESSION] to the mail's
-subject or the title in the bug-tracker. If you did not perform a bisection
-mention at least the latest mainline version you tested that worked fine (say
-5.7) and the oldest where the issue occurs (say 5.8). If you did a successful
-bisection mention the commit id and subject of the change that causes the
-regression. Also make sure to add the author of that change to your report; if
-you need to file your bug in a bug-tracker forward the report to him in a
-private mail and mention where your filed it.
+**Regressions**: Make the report's subject start with '[REGRESSION]'.
+
+In case you performed a successful bisection, use the title of the change that
+introduced the regression as the second part of your subject. Make the report
+also mention the commit id of the culprit. For tracking purposes, add a line
+like the following that contains both pieces of information, but with the
+commit id shortened to 12 characters::
+
+    #regzb introduced: 94a632d91ad1 ("usc: xhbi-foo: check bar_params earlier")
+
+In case of an unsuccessful bisection, make your report mention the latest tested
+version that's working fine (say 5.7) and the oldest where the issue occurs (say
+5.8-rc1). For tracking purposes add a line expressing it like this::
+
+    #regzb introduced: v5.7..v5.8-rc1
+
+When sending the report by mail, CC the Linux regressions mailing list
+(regressions@lists.linux.dev). In case the report needs to be filed to some web
+tracker, proceed to do so; once filed, forward the report by mail to the
+regressions list. Make sure to inline the forwarded report, hence do not attach
+it. Also add a short note at the top where you mention the URL to the ticket and
+repeat the line starting with '#regzb'.
+
+When mailing or forwarding the report, in case of a successful bisection add the
+author of the culprit to the recipients; also CC everyone in the signed-off-by
+chain, which you find at the end of its commit message.
 
 **Security issues**: for these issues your will have to evaluate if a
 short-term risk to other users would arise if details were publicly disclosed.
@@ -1523,9 +1545,11 @@ Report the regression
 ~~~~~~~~~~~~~~~~~~~~~
 
     *Send a short problem report to the Linux stable mailing list
-    (stable@vger.kernel.org). Roughly describe the issue and ideally explain
-    how to reproduce it. Mention the first version that shows the problem and
-    the last version that's working fine. Then wait for further instructions.*
+    (stable@vger.kernel.org) and CC the Linux regressions mailing list
+    (regressions@lists.linux.dev). Roughly describe the issue and ideally
+    explain how to reproduce it. Mention the commit or version that introduced
+    the regression as outlined in 'Special handling for high priority issues'.
+    Then wait for further instructions.*
 
 When reporting a regression that happens within a stable or longterm kernel
 line (say when updating from 5.10.4 to 5.10.5) a brief report is enough for
-- 
2.30.2

