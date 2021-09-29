Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A9E41C366
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 13:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244409AbhI2L0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 07:26:46 -0400
Received: from smtp181.sjtu.edu.cn ([202.120.2.181]:44226 "EHLO
        smtp181.sjtu.edu.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhI2L0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 07:26:45 -0400
Received: from proxy02.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
        by smtp181.sjtu.edu.cn (Postfix) with ESMTPS id 9E7231008CBCD;
        Wed, 29 Sep 2021 19:25:03 +0800 (CST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by proxy02.sjtu.edu.cn (Postfix) with ESMTP id 831DC200BC2D9;
        Wed, 29 Sep 2021 19:25:03 +0800 (CST)
X-Virus-Scanned: amavisd-new at 
Received: from proxy02.sjtu.edu.cn ([127.0.0.1])
        by localhost (proxy02.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jqi84HosEhSJ; Wed, 29 Sep 2021 19:25:03 +0800 (CST)
Received: from guozhi-ipads.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
        (Authenticated sender: qtxuning1999@sjtu.edu.cn)
        by proxy02.sjtu.edu.cn (Postfix) with ESMTPSA id 80FC42007EB3E;
        Wed, 29 Sep 2021 19:24:55 +0800 (CST)
From:   Guo Zhi <qtxuning1999@sjtu.edu.cn>
To:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guo Zhi <qtxuning1999@sjtu.edu.cn>, linux-kernel@vger.kernel.org
Subject: [PATCH] dirvers/lkdtm: Fix kernel pointer leak
Date:   Wed, 29 Sep 2021 19:24:45 +0800
Message-Id: <20210929112446.1115555-1-qtxuning1999@sjtu.edu.cn>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointers should be printed with %p rather than %px
which printed kernel pointer directly.
Change %px to %p to print the secured pointer.

Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
---
 drivers/misc/lkdtm/perms.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index 2dede2ef658f..ceff8668877a 100644
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -47,7 +47,7 @@ static noinline void execute_location(void *dst, bool write)
 {
 	void (*func)(void) = dst;
 
-	pr_info("attempting ok execution at %px\n", do_nothing);
+	pr_info("attempting ok execution at %p\n", do_nothing);
 	do_nothing();
 
 	if (write == CODE_WRITE) {
@@ -55,7 +55,7 @@ static noinline void execute_location(void *dst, bool write)
 		flush_icache_range((unsigned long)dst,
 				   (unsigned long)dst + EXEC_SIZE);
 	}
-	pr_info("attempting bad execution at %px\n", func);
+	pr_info("attempting bad execution at %p\n", func);
 	func();
 	pr_err("FAIL: func returned\n");
 }
@@ -67,14 +67,14 @@ static void execute_user_location(void *dst)
 	/* Intentionally crossing kernel/user memory boundary. */
 	void (*func)(void) = dst;
 
-	pr_info("attempting ok execution at %px\n", do_nothing);
+	pr_info("attempting ok execution at %p\n", do_nothing);
 	do_nothing();
 
 	copied = access_process_vm(current, (unsigned long)dst, do_nothing,
 				   EXEC_SIZE, FOLL_WRITE);
 	if (copied < EXEC_SIZE)
 		return;
-	pr_info("attempting bad execution at %px\n", func);
+	pr_info("attempting bad execution at %p\n", func);
 	func();
 	pr_err("FAIL: func returned\n");
 }
@@ -84,7 +84,7 @@ void lkdtm_WRITE_RO(void)
 	/* Explicitly cast away "const" for the test and make volatile. */
 	volatile unsigned long *ptr = (unsigned long *)&rodata;
 
-	pr_info("attempting bad rodata write at %px\n", ptr);
+	pr_info("attempting bad rodata write at %p\n", ptr);
 	*ptr ^= 0xabcd1234;
 	pr_err("FAIL: survived bad write\n");
 }
@@ -103,7 +103,7 @@ void lkdtm_WRITE_RO_AFTER_INIT(void)
 		return;
 	}
 
-	pr_info("attempting bad ro_after_init write at %px\n", ptr);
+	pr_info("attempting bad ro_after_init write at %p\n", ptr);
 	*ptr ^= 0xabcd1234;
 	pr_err("FAIL: survived bad write\n");
 }
@@ -116,7 +116,7 @@ void lkdtm_WRITE_KERN(void)
 	size = (unsigned long)do_overwritten - (unsigned long)do_nothing;
 	ptr = (unsigned char *)do_overwritten;
 
-	pr_info("attempting bad %zu byte write at %px\n", size, ptr);
+	pr_info("attempting bad %zu byte write at %p\n", size, ptr);
 	memcpy((void *)ptr, (unsigned char *)do_nothing, size);
 	flush_icache_range((unsigned long)ptr, (unsigned long)(ptr + size));
 	pr_err("FAIL: survived bad write\n");
@@ -195,12 +195,12 @@ void lkdtm_ACCESS_USERSPACE(void)
 
 	ptr = (unsigned long *)user_addr;
 
-	pr_info("attempting bad read at %px\n", ptr);
+	pr_info("attempting bad read at %p\n", ptr);
 	tmp = *ptr;
 	tmp += 0xc0dec0de;
 	pr_err("FAIL: survived bad read\n");
 
-	pr_info("attempting bad write at %px\n", ptr);
+	pr_info("attempting bad write at %p\n", ptr);
 	*ptr = tmp;
 	pr_err("FAIL: survived bad write\n");
 
@@ -212,12 +212,12 @@ void lkdtm_ACCESS_NULL(void)
 	unsigned long tmp;
 	volatile unsigned long *ptr = (unsigned long *)NULL;
 
-	pr_info("attempting bad read at %px\n", ptr);
+	pr_info("attempting bad read at %p\n", ptr);
 	tmp = *ptr;
 	tmp += 0xc0dec0de;
 	pr_err("FAIL: survived bad read\n");
 
-	pr_info("attempting bad write at %px\n", ptr);
+	pr_info("attempting bad write at %p\n", ptr);
 	*ptr = tmp;
 	pr_err("FAIL: survived bad write\n");
 }
-- 
2.33.0

