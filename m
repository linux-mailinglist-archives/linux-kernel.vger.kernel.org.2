Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274AC33D03A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 09:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbhCPI55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 04:57:57 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:48027 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235866AbhCPI5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 04:57:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0US7btel_1615885042;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0US7btel_1615885042)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Mar 2021 16:57:22 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     robinmholt@gmail.com
Cc:     steve.wahl@hpe.com, mike.travis@hpe.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] misc/sgi-xp: use NULL instead of using plain integer as pointer
Date:   Tue, 16 Mar 2021 16:57:21 +0800
Message-Id: <1615885041-68750-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following sparse warnings:
drivers/misc/sgi-xp/xpc_main.c:210:23: warning: Using plain integer as
NULL pointer

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/misc/sgi-xp/xpc_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/sgi-xp/xpc_main.c b/drivers/misc/sgi-xp/xpc_main.c
index 84610bb..b2c3c22 100644
--- a/drivers/misc/sgi-xp/xpc_main.c
+++ b/drivers/misc/sgi-xp/xpc_main.c
@@ -207,7 +207,7 @@
 {
 	xpc_arch_ops.heartbeat_init();
 	timer_setup(&xpc_hb_timer, xpc_hb_beater, 0);
-	xpc_hb_beater(0);
+	xpc_hb_beater(NULL);
 }
 
 static void
-- 
1.8.3.1

