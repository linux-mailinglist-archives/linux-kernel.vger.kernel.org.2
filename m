Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 491203337CD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 09:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhCJItT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 03:49:19 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:35380 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229544AbhCJItN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 03:49:13 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UREgr3u_1615366150;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UREgr3u_1615366150)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 10 Mar 2021 16:49:10 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     jdike@addtoit.com
Cc:     richard@nod.at, anton.ivanov@cambridgegreys.com,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] uml: remove unneeded variable 'ret'
Date:   Wed, 10 Mar 2021 16:49:08 +0800
Message-Id: <1615366148-5357-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:
./arch/um/drivers/hostaudio_kern.c:125:10-14: Unneeded variable: "mask".
Return "0" on line 131

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/um/drivers/hostaudio_kern.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/um/drivers/hostaudio_kern.c b/arch/um/drivers/hostaudio_kern.c
index d35d3f3..5b064d3 100644
--- a/arch/um/drivers/hostaudio_kern.c
+++ b/arch/um/drivers/hostaudio_kern.c
@@ -122,13 +122,11 @@ static ssize_t hostaudio_write(struct file *file, const char __user *buffer,
 static __poll_t hostaudio_poll(struct file *file,
 				struct poll_table_struct *wait)
 {
-	__poll_t mask = 0;
-
 #ifdef DEBUG
 	printk(KERN_DEBUG "hostaudio: poll called (unimplemented)\n");
 #endif
 
-	return mask;
+	return 0;
 }
 
 static long hostaudio_ioctl(struct file *file,
-- 
1.8.3.1

