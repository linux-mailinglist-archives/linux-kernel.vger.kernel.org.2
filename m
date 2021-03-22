Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B228343D28
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 10:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhCVJoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 05:44:08 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:45201 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230011AbhCVJnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 05:43:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0USve7yu_1616406218;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0USve7yu_1616406218)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 22 Mar 2021 17:43:43 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] powerpc/iommu/debug: Remove redundant NULL check
Date:   Mon, 22 Mar 2021 17:43:37 +0800
Message-Id: <1616406217-94635-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:

./fs/io_uring.c:5989:4-9: WARNING: NULL check before some freeing
functions is not needed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 arch/powerpc/kernel/iommu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index c00214a..2168714 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -72,8 +72,7 @@ static void iommu_debugfs_del(struct iommu_table *tbl)
 
 	sprintf(name, "%08lx", tbl->it_index);
 	liobn_entry = debugfs_lookup(name, iommu_debugfs_dir);
-	if (liobn_entry)
-		debugfs_remove(liobn_entry);
+	debugfs_remove(liobn_entry);
 }
 #else
 static void iommu_debugfs_add(struct iommu_table *tbl){}
-- 
1.8.3.1

