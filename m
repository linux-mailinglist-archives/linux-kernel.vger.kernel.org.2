Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0BDF43BF30
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 03:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237701AbhJ0BsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 21:48:02 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:65396 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230160AbhJ0BsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 21:48:01 -0400
X-Greylist: delayed 924 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Oct 2021 21:48:01 EDT
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
        by Forcepoint Email with ESMTPS id A02AC4086C12E4F0992F;
        Wed, 27 Oct 2021 09:30:10 +0800 (CST)
Received: from kjyxapp03.zte.com.cn ([10.30.12.202])
        by mse-fl1.zte.com.cn with SMTP id 19R1U18h085498;
        Wed, 27 Oct 2021 09:30:01 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-cloudhost8.localdomain (unknown [10.234.72.110])
        by smtp (Zmail) with SMTP;
        Wed, 27 Oct 2021 09:30:01 +0800
X-Zmail-TransId: 3e886178ab9800a-07e39
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     stuyoder@gmail.com
Cc:     laurentiu.tudor@nxp.com, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        wang.liang82@zte.com.cn,
        =?UTF-8?q?=E7=8E=8B=E4=B8=9A=E8=B6=8510154425?= 
        <wang.yechao255@zte.com.cn>
Subject: [PATCH] bus: fsl-mc: Fix dma coherent not avaiable
Date:   Wed, 27 Oct 2021 09:24:41 +0800
Message-Id: <20211027012441.10091-1-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 2.33.0.rc0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 19R1U18h085498
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: 王业超10154425 <wang.yechao255@zte.com.cn>

Commit "a081bd4a" change the third argument of of_dma_configure_id,
from 1 to 0, and then the dpni cannot inherit the dma_coherent from
fsl-mc bus on fsl-lx2160a.

Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 8fd4a35..74dc47b 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -146,7 +146,7 @@ static int fsl_mc_dma_configure(struct device *dev)
 		dma_dev = dma_dev->parent;
 
 	if (dev_of_node(dma_dev))
-		return of_dma_configure_id(dev, dma_dev->of_node, 0, &input_id);
+		return of_dma_configure_id(dev, dma_dev->of_node, 1, &input_id);
 
 	return acpi_dma_configure_id(dev, DEV_DMA_COHERENT, &input_id);
 }
-- 
1.8.3.1
