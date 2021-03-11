Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE09336F35
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 10:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbhCKJsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 04:48:42 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:49342 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231639AbhCKJsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 04:48:14 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0URS8WsQ_1615456087;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0URS8WsQ_1615456087)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 11 Mar 2021 17:48:12 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     davem@davemloft.net
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] ide: fix warning comparing pointer to 0
Date:   Thu, 11 Mar 2021 17:48:06 +0800
Message-Id: <1615456086-127803-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

./drivers/ide/pmac.c:1680:38-39: WARNING comparing pointer to 0.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/ide/pmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/pmac.c b/drivers/ide/pmac.c
index ea0b064..d5171e0 100644
--- a/drivers/ide/pmac.c
+++ b/drivers/ide/pmac.c
@@ -1677,7 +1677,7 @@ static int pmac_ide_init_dma(ide_hwif_t *hwif, const struct ide_port_info *d)
 	/* We won't need pci_dev if we switch to generic consistent
 	 * DMA routines ...
 	 */
-	if (dev == NULL || pmif->dma_regs == 0)
+	if (!dev || pmif->dma_regs)
 		return -ENODEV;
 	/*
 	 * Allocate space for the DBDMA commands.
-- 
1.8.3.1

