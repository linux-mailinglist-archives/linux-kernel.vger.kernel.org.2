Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F2D34EA0F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbhC3ON6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbhC3ONW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:13:22 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F10C061762;
        Tue, 30 Mar 2021 07:13:21 -0700 (PDT)
Received: from ip4d14bd53.dynamic.kabel-deutschland.de ([77.20.189.83] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1lRF7I-0000jw-7j; Tue, 30 Mar 2021 16:13:12 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/4] docs: reporting-issues.rst: reshuffle and improve TLDR
Date:   Tue, 30 Mar 2021 16:13:06 +0200
Message-Id: <762ccd7735315d2fdaa79612fccc1f474881118b.1617113469.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617113469.git.linux@leemhuis.info>
References: <cover.1617113469.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1617113602;38c5c4bd;
X-HE-SMSGID: 1lRF7I-0000jw-7j
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the TLDR a bit shorter while improving it at the same time by going
straight to the aspects readers are more interested it. The change makes
the process especially more straight-forward for people that hit a
regression in a stable or longterm kernel. Due to the changes the TLDR
now also matches the step by step guide better.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
v1
- Incorporated feedback received from posting a draft to LKML. Also
  slightly change the beginning of the third paragraph to improve the
  flow.
---
 .../admin-guide/reporting-issues.rst          | 75 +++++++++----------
 1 file changed, 35 insertions(+), 40 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index ca809a4be620..77d38acca282 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -17,46 +17,41 @@ Reporting issues
 The short guide (aka TL;DR)
 ===========================
 
-If you're facing multiple issues with the Linux kernel at once, report each
-separately to its developers. Try your best guess which kernel part might be
-causing the issue. Check the :ref:`MAINTAINERS <maintainers>` file for how its
-developers expect to be told about issues. Note, it's rarely
-`bugzilla.kernel.org <https://bugzilla.kernel.org/>`_, as in almost all cases
-the report needs to be sent by email!
-
-Check the destination thoroughly for existing reports; also search the LKML
-archives and the web. Join existing discussion if you find matches. If you
-don't find any, install `the latest Linux mainline kernel
-<https://kernel.org/>`_. Make sure it's vanilla, thus is not patched or using
-add-on kernel modules. Also ensure the kernel is running in a healthy
-environment and is not already tainted before the issue occurs.
-
-If you can reproduce your issue with the mainline kernel, send a report to the
-destination you determined earlier. Make sure it includes all relevant
-information, which in case of a regression should mention the change that's
-causing it which can often can be found with a bisection. Also ensure the
-report reaches all people that need to know about it, for example the security
-team, the stable maintainers or the developers of the patch that causes a
-regression. Once the report is out, answer any questions that might be raised
-and help where you can. That includes keeping the ball rolling: every time a
-new rc1 mainline kernel is released, check if the issue is still happening
-there and attach a status update to your initial report.
-
-If you can not reproduce the issue with the mainline kernel, consider sticking
-with it; if you'd like to use an older version line and want to see it fixed
-there, first make sure it's still supported. Install its latest release as
-vanilla kernel. If you cannot reproduce the issue there, try to find the commit
-that fixed it in mainline or any discussion preceding it: those will often
-mention if backporting is planed or considered too complex. If backporting was
-not discussed, ask if it's in the cards. In case you don't find any commits or
-a preceding discussion, see the Linux-stable mailing list archives for existing
-reports, as it might be a regression specific to the version line. If it is,
-report it like you would report a problem in mainline (including the
-bisection).
-
-If you reached this point without a solution, ask for advice one the
-subsystem's mailing list.
-
+Are you facing a regression with vanilla kernels from the same stable or
+longterm series? One still supported? Then search the `LKML
+<https://lore.kernel.org/lkml/>`_ and the `Linux stable mailing list
+<https://lore.kernel.org/stable/>_` archives for matching reports to join. If
+you don't find any, install `the latest release from that series
+<https://kernel.org/>`_. If it still shows the issue, report it to the stable
+mailing list (stable@vger.kernel.org).
+
+In all other cases try your best guess which kernel part might be causing the
+issue. Check the :ref:`MAINTAINERS <maintainers>` file for how its developers
+expect to be told about problems, which most of the time will be by email with a
+mailing list in CC. Check the destination's archives for matching reports;
+search the `LKML <https://lore.kernel.org/lkml/>`_ and the web, too. If you
+don't find any to join, install `the latest mainline kernel
+<https://kernel.org/>`_. If the issue is present there, send a report.
+
+The issue was fixed there, but you would like to see it resolved in a still
+supported stable or longterm series as well? Then install its latest release.
+If it shows the problem, search for the change that fixed it in mainline and
+check if backporting is in the works or was discarded; if it's neither, ask
+those who handled the change for it.
+
+**General remarks**: When installing and testing a kernel as outlined above,
+ensure it's vanilla (IOW: not patched and not using add-on modules). Also make
+sure it's built and running in a healthy environment and not already tainted
+before the issue occurs.
+
+While writing your report, include all information relevant to the issue, like
+the kernel and the distro used. In case of a regression try to include the
+commit-id of the change causing it, which a bisection can find. If you're facing
+multiple issues with the Linux kernel at once, report each separately.
+
+Once the report is out, answer any questions that come up and help where you
+can. That includes keeping the ball rolling by occasionally retesting with newer
+releases and sending a status update afterwards.
 
 Step-by-step guide how to report issues to the kernel maintainers
 =================================================================
-- 
2.30.2

