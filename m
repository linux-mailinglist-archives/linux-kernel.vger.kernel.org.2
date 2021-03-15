Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B75D33AC5A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 08:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhCOHfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 03:35:44 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:44219 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230091AbhCOHff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 03:35:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0URxLfN3_1615793725;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0URxLfN3_1615793725)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 15 Mar 2021 15:35:32 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] powerpc/pci: fix warning comparing pointer to 0
Date:   Mon, 15 Mar 2021 15:35:24 +0800
Message-Id: <1615793724-97015-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

./arch/powerpc/platforms/maple/pci.c:37:16-17: WARNING comparing pointer
to 0.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 arch/powerpc/platforms/maple/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/maple/pci.c b/arch/powerpc/platforms/maple/pci.c
index a20b957..37875e4 100644
--- a/arch/powerpc/platforms/maple/pci.c
+++ b/arch/powerpc/platforms/maple/pci.c
@@ -34,7 +34,7 @@
 
 static int __init fixup_one_level_bus_range(struct device_node *node, int higher)
 {
-	for (; node != 0;node = node->sibling) {
+	for (; node; node = node->sibling) {
 		const int *bus_range;
 		const unsigned int *class_code;
 		int len;
-- 
1.8.3.1

