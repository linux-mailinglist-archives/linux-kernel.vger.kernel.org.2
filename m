Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBDD342631
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 20:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhCST21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 15:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhCST1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 15:27:53 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BCAC061760;
        Fri, 19 Mar 2021 12:27:53 -0700 (PDT)
Received: from ip4d142c50.dynamic.kabel-deutschland.de ([77.20.44.80] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1lNKmk-0003Lu-5b; Fri, 19 Mar 2021 20:27:50 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] docs: reporting-issues.rst: fix small typos and style issues
Date:   Fri, 19 Mar 2021 20:27:45 +0100
Message-Id: <fb845d2f1db6138337203bbfac419c04b5f28053.1616181657.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616181657.git.linux@leemhuis.info>
References: <cover.1616181657.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1616182073;048012f6;
X-HE-SMSGID: 1lNKmk-0003Lu-5b
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo and change "head over" to "scroll down", as suggested by Jon
when reviewing another patch that used the phrase the same way.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/admin-guide/reporting-issues.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index 18b1280f7abf..3b43748d8911 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -145,7 +145,7 @@ After these preparations you'll now enter the main part:
    running.
 
  * Reproduce the issue with the kernel you just installed. If it doesn't show
-   up there, head over to the instructions for issues only happening with
+   up there, scroll down to the instructions for issues only happening with
    stable and longterm kernels.
 
  * Optimize your notes: try to find and write the most straightforward way to
@@ -901,7 +901,7 @@ Reproduce issue with the fresh kernel
 -------------------------------------
 
     *Reproduce the issue with the kernel you just installed. If it doesn't show
-    up there, head over to the instructions for issues only happening with
+    up there, scroll down to the instructions for issues only happening with
     stable and longterm kernels.*
 
 Check if the issue occurs with the fresh Linux kernel version you just
@@ -1292,7 +1292,7 @@ you never have heard of yet; or you might be asked to apply a patch to the
 Linux kernel sources to test if it helps. In some cases it will be fine sending
 a reply asking for instructions how to do that. But before going that route try
 to find the answer own your own by searching the internet; alternatively
-consider asking in other places for advice. For example ask a fried or post
+consider asking in other places for advice. For example ask a friend or post
 about it to a chatroom or forum you normally hang out.
 
 **Be patient**: If you are really lucky you might get a reply to your report
-- 
2.30.2

