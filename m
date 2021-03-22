Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45AAE344BFE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 17:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhCVQn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 12:43:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231253AbhCVQnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:43:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 137706157F;
        Mon, 22 Mar 2021 16:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616431392;
        bh=XBODrVwui1BLGA9uFZuR76atFHHSxrtpJdBrM3gOevE=;
        h=From:To:Cc:Subject:Date:From;
        b=Yctwy+c7ufuuaKai6RHxr2DdFolb+BulYyvDxs/bKwMftGTbVTYQeWDHiIBqsWaps
         gGmPu+if5ZZniByWFiQV3tkZOGK8q1xj92yGICB9J7GgP/NDJA2iRlt+Cn5sNNmOHn
         N+DtfOBf8FDU2oSX8m6bZq1AOIlRjFA2+8/HaTUrn6ehDLDI+5Sg0LNZ+Ynf5HLjxh
         GqBYu8vXVSDOLxIibSTIh4XGDRKQKlO//wRW4MgsHCEKgx6TzJSLAw78i6LV6reHqf
         qFUDU+vVEodKvqfl7S8qcO1WWOuqBoOf0shrNQ1Dz099exMBL0zAvaB4iF8kQXWa7/
         qeEA84nfHvmLQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@elte.hu>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] kgdb: fix gcc-11 warning on indentation
Date:   Mon, 22 Mar 2021 17:43:03 +0100
Message-Id: <20210322164308.827846-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcc-11 starts warning about misleading indentation inside of macros:

drivers/misc/kgdbts.c: In function ‘kgdbts_break_test’:
drivers/misc/kgdbts.c:103:9: error: this ‘if’ clause does not guard... [-Werror=misleading-indentation]
  103 |         if (verbose > 1) \
      |         ^~
drivers/misc/kgdbts.c:200:9: note: in expansion of macro ‘v2printk’
  200 |         v2printk("kgdbts: breakpoint complete\n");
      |         ^~~~~~~~
drivers/misc/kgdbts.c:105:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the ‘if’
  105 |                 touch_nmi_watchdog();   \
      |                 ^~~~~~~~~~~~~~~~~~

The code looks correct to me, so just reindent it for readability.

Fixes: e8d31c204e36 ("kgdb: add kgdb internal test suite")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/misc/kgdbts.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/kgdbts.c b/drivers/misc/kgdbts.c
index 945701bce553..2e081a58da6c 100644
--- a/drivers/misc/kgdbts.c
+++ b/drivers/misc/kgdbts.c
@@ -95,19 +95,19 @@
 
 #include <asm/sections.h>
 
-#define v1printk(a...) do { \
-	if (verbose) \
-		printk(KERN_INFO a); \
-	} while (0)
-#define v2printk(a...) do { \
-	if (verbose > 1) \
-		printk(KERN_INFO a); \
-		touch_nmi_watchdog();	\
-	} while (0)
-#define eprintk(a...) do { \
-		printk(KERN_ERR a); \
-		WARN_ON(1); \
-	} while (0)
+#define v1printk(a...) do {		\
+	if (verbose)			\
+		printk(KERN_INFO a);	\
+} while (0)
+#define v2printk(a...) do {		\
+	if (verbose > 1)		\
+		printk(KERN_INFO a);	\
+	touch_nmi_watchdog();		\
+} while (0)
+#define eprintk(a...) do {		\
+	printk(KERN_ERR a);		\
+	WARN_ON(1);			\
+} while (0)
 #define MAX_CONFIG_LEN		40
 
 static struct kgdb_io kgdbts_io_ops;
-- 
2.29.2

