Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B4C33362D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 08:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhCJHLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 02:11:09 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:58712 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230303AbhCJHKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 02:10:45 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0URFMPDg_1615360239;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0URFMPDg_1615360239)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 10 Mar 2021 15:10:43 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     chris@zankel.net
Cc:     jcmvbkbc@gmail.com, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] xtensa: fix warning comparing pointer to 0
Date:   Wed, 10 Mar 2021 15:10:38 +0800
Message-Id: <1615360238-22508-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

./arch/xtensa/kernel/pci.c:79:17-18: WARNING comparing pointer to 0.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 arch/xtensa/kernel/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/kernel/pci.c b/arch/xtensa/kernel/pci.c
index 3f32e27..62c900e 100644
--- a/arch/xtensa/kernel/pci.c
+++ b/arch/xtensa/kernel/pci.c
@@ -76,7 +76,7 @@ int pci_iobar_pfn(struct pci_dev *pdev, int bar, struct vm_area_struct *vma)
 	struct pci_controller *pci_ctrl = (struct pci_controller*) pdev->sysdata;
 	resource_size_t ioaddr = pci_resource_start(pdev, bar);
 
-	if (pci_ctrl == 0)
+	if (!pci_ctrl)
 		return -EINVAL;		/* should never happen */
 
 	/* Convert to an offset within this PCI controller */
-- 
1.8.3.1

