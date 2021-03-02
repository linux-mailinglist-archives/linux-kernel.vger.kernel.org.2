Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8085732A67E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574189AbhCBPOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 10:14:00 -0500
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:6124 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447170AbhCBMvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 07:51:04 -0500
Received: from spf.mail.chinamobile.com (unknown[172.16.121.19]) by rmmx-syy-dmz-app12-12012 (RichMail) with SMTP id 2eec603e347f975-90ad9; Tue, 02 Mar 2021 20:50:09 +0800 (CST)
X-RM-TRANSID: 2eec603e347f975-90ad9
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.112.105.130])
        by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea603e347d2a6-1de80;
        Tue, 02 Mar 2021 20:50:09 +0800 (CST)
X-RM-TRANSID: 2eea603e347d2a6-1de80
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     broonie@kernel.org, timur@kernel.org, nicoleotsuka@gmail.com,
        Xiubo.Lee@gmail.com, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] ASoC: fsl_xcvr: Use devm_platform_ioremap_resource_byname() to simplify code
Date:   Tue,  2 Mar 2021 20:50:02 +0800
Message-Id: <20210302125002.23900-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this function, devm_platform_ioremap_resource_byname() should be 
suitable to simplify code.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/fsl/fsl_xcvr.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index 6dd0a5fcd455..5e8284db857b 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -1131,7 +1131,7 @@ static int fsl_xcvr_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct fsl_xcvr *xcvr;
-	struct resource *ram_res, *regs_res, *rx_res, *tx_res;
+	struct resource *rx_res, *tx_res;
 	void __iomem *regs;
 	int ret, irq;
 
@@ -1166,13 +1166,11 @@ static int fsl_xcvr_probe(struct platform_device *pdev)
 		return PTR_ERR(xcvr->pll_ipg_clk);
 	}
 
-	ram_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ram");
-	xcvr->ram_addr = devm_ioremap_resource(dev, ram_res);
+	xcvr->ram_addr = devm_platform_ioremap_resource_byname(pdev, "ram");
 	if (IS_ERR(xcvr->ram_addr))
 		return PTR_ERR(xcvr->ram_addr);
 
-	regs_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
-	regs = devm_ioremap_resource(dev, regs_res);
+	regs = devm_platform_ioremap_resource_byname(pdev, "regs");
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 
-- 
2.18.2



