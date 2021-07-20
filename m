Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B453CF9E3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 14:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhGTMKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 08:10:07 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:19407 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhGTMJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 08:09:55 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.13]) by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee960f6c67aa01-3e2a6; Tue, 20 Jul 2021 20:50:03 +0800 (CST)
X-RM-TRANSID: 2ee960f6c67aa01-3e2a6
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.0.144.134])
        by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee760f6c6772ab-8f84b;
        Tue, 20 Jul 2021 20:50:02 +0800 (CST)
X-RM-TRANSID: 2ee760f6c6772ab-8f84b
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     stuyoder@gmail.com, laurentiu.tudor@nxp.com
Cc:     linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] bus: fsl-mc: fsl-mc-bus: Use devm_platform_ioremap_resource() to simplify code
Date:   Tue, 20 Jul 2021 20:50:50 +0800
Message-Id: <20210720125050.28064-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() instead of
platform_get_resource() + devm_ioremap_resource().

Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 380ad1fdb745..472f0daf4271 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -1080,12 +1080,9 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mc);
 
-	plat_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (plat_res) {
-		mc->fsl_mc_regs = devm_ioremap_resource(&pdev->dev, plat_res);
-		if (IS_ERR(mc->fsl_mc_regs))
-			return PTR_ERR(mc->fsl_mc_regs);
-	}
+	mc->fsl_mc_regs = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(mc->fsl_mc_regs))
+		return PTR_ERR(mc->fsl_mc_regs);
 
 	if (mc->fsl_mc_regs) {
 		/*
-- 
2.18.2



