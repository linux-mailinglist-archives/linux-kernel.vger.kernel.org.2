Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64920330059
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 12:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhCGLe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 06:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhCGLd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 06:33:57 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E0BC06175F;
        Sun,  7 Mar 2021 03:33:57 -0800 (PST)
Received: from ip4d142c50.dynamic.kabel-deutschland.de ([77.20.44.80] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1lIrfT-0002Ox-KW; Sun, 07 Mar 2021 12:33:51 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] docs: reporting-issues.rst: move tainted check upwards
Date:   Sun,  7 Mar 2021 12:33:49 +0100
Message-Id: <e03e9f0bf7d2f1109bb736af5e3fdffedb475d81.1615116592.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1615116592.git.linux@leemhuis.info>
References: <cover.1615116592.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1615116837;e43d2063;
X-HE-SMSGID: 1lIrfT-0002Ox-KW
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the instuctions to check tainted status upwards one step. This is
done in preparation for a follow up patch that introduces a new step
that should come after the 'check tainted status' step, but is best done
right after the 'check if this qualifies as regression, ...' step.

Just moves text around, no other changes.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../admin-guide/reporting-issues.rst          | 84 +++++++++----------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index 18b1280f7abf..24ee78455d3e 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -99,13 +99,13 @@ process won't feel wasted in the end:
    install it. This kernel must not be modified or enhanced in any way, and
    thus be considered 'vanilla'.
 
+ * Check if your kernel was 'tainted' when the issue occurred, as the event
+   that made the kernel set this flag might be causing the issue you face.
+
  * See if the issue you are dealing with qualifies as regression, security
    issue, or a really severe problem: those are 'issues of high priority' that
    need special handling in some steps that are about to follow.
 
- * Check if your kernel was 'tainted' when the issue occurred, as the event
-   that made the kernel set this flag might be causing the issue you face.
-
  * Locate the driver or kernel subsystem that seems to be causing the issue.
    Find out how and where its developers expect reports. Note: most of the
    time this won't be bugzilla.kernel.org, as issues typically need to be sent
@@ -326,45 +326,6 @@ just make sure to use really fresh kernel (see below).
    Are there any other major Linux distributions that should be mentioned here?
 
 
-Issue of high priority?
------------------------
-
-    *See if the issue you are dealing with qualifies as regression, security
-    issue, or a really severe problem: those are 'issues of high priority' that
-    need special handling in some steps that are about to follow.*
-
-Linus Torvalds and the leading Linux kernel developers want to see some issues
-fixed as soon as possible, hence there are 'issues of high priority' that get
-handled slightly differently in the reporting process. Three type of cases
-qualify: regressions, security issues, and really severe problems.
-
-You deal with a 'regression' if something that worked with an older version of
-the Linux kernel does not work with a newer one or somehow works worse with it.
-It thus is a regression when a WiFi driver that did a fine job with Linux 5.7
-somehow misbehaves with 5.8 or doesn't work at all. It's also a regression if
-an application shows erratic behavior with a newer kernel, which might happen
-due to incompatible changes in the interface between the kernel and the
-userland (like procfs and sysfs). Significantly reduced performance or
-increased power consumption also qualify as regression. But keep in mind: the
-new kernel needs to be built with a configuration that is similar to the one
-from the old kernel (see below how to achieve that). That's because the kernel
-developers sometimes can not avoid incompatibilities when implementing new
-features; but to avoid regressions such features have to be enabled explicitly
-during build time configuration.
-
-What qualifies as security issue is left to your judgment. Consider reading
-'Documentation/admin-guide/security-bugs.rst' before proceeding, as it
-provides additional details how to best handle security issues.
-
-An issue is a 'really severe problem' when something totally unacceptably bad
-happens. That's for example the case when a Linux kernel corrupts the data it's
-handling or damages hardware it's running on. You're also dealing with a severe
-issue when the kernel suddenly stops working with an error message ('kernel
-panic') or without any farewell note at all. Note: do not confuse a 'panic' (a
-fatal error where the kernel stop itself) with a 'Oops' (a recoverable error),
-as the kernel remains running after the latter.
-
-
 Check 'taint' flag
 ------------------
 
@@ -433,6 +394,45 @@ three things:
     the name of the module in question).
 
 
+Issue of high priority?
+-----------------------
+
+    *See if the issue you are dealing with qualifies as regression, security
+    issue, or a really severe problem: those are 'issues of high priority' that
+    need special handling in some steps that are about to follow.*
+
+Linus Torvalds and the leading Linux kernel developers want to see some issues
+fixed as soon as possible, hence there are 'issues of high priority' that get
+handled slightly differently in the reporting process. Three type of cases
+qualify: regressions, security issues, and really severe problems.
+
+You deal with a 'regression' if something that worked with an older version of
+the Linux kernel does not work with a newer one or somehow works worse with it.
+It thus is a regression when a WiFi driver that did a fine job with Linux 5.7
+somehow misbehaves with 5.8 or doesn't work at all. It's also a regression if
+an application shows erratic behavior with a newer kernel, which might happen
+due to incompatible changes in the interface between the kernel and the
+userland (like procfs and sysfs). Significantly reduced performance or
+increased power consumption also qualify as regression. But keep in mind: the
+new kernel needs to be built with a configuration that is similar to the one
+from the old kernel (see below how to achieve that). That's because the kernel
+developers sometimes can not avoid incompatibilities when implementing new
+features; but to avoid regressions such features have to be enabled explicitly
+during build time configuration.
+
+What qualifies as security issue is left to your judgment. Consider reading
+'Documentation/admin-guide/security-bugs.rst' before proceeding, as it
+provides additional details how to best handle security issues.
+
+An issue is a 'really severe problem' when something totally unacceptably bad
+happens. That's for example the case when a Linux kernel corrupts the data it's
+handling or damages hardware it's running on. You're also dealing with a severe
+issue when the kernel suddenly stops working with an error message ('kernel
+panic') or without any farewell note at all. Note: do not confuse a 'panic' (a
+fatal error where the kernel stop itself) with a 'Oops' (a recoverable error),
+as the kernel remains running after the latter.
+
+
 Locate kernel area that causes the issue
 ----------------------------------------
 
-- 
2.29.2

