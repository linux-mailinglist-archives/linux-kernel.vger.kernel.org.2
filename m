Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADA645C852
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 16:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbhKXPNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 10:13:16 -0500
Received: from mail.pr-group.ru ([178.18.215.3]:54244 "EHLO mail.pr-group.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231372AbhKXPNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 10:13:13 -0500
X-Greylist: delayed 1814 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Nov 2021 10:13:13 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding;
        bh=To9e4hBk+9KWTAv+yOOa9YU2qidFr8D9clDVYMRnqn8=;
        b=twqwQWfNlK8kMwmrtAIFufCQIhp2x37D35hlm2tP4b8+8EQdvP5yMlbFK7JBGyv/lgrOKL6qNfhqa
         s31gH6q9hw3I6AYEpBU05BSTfkAWlHzFNv8KKxCgD2St2C3ZSxt2FHkgbscxm9nQmvQb6QuKbkQjin
         CA4IvdQZkohzK/BVwM7eSbnQaKuLXa5BWVu5SdV3pQdkLeGEOygMBAZclZikVN3ZNDS2id618Mr4/K
         UlLeO7ccIMbV02QI7lBpMrZtyBhJbXva7Kk1HT46sUNHBgIeBXzCNrEVvxkf4LM6HVB70pT4rPdjYP
         Jx3pUn3tsPVxNtlDZilQXNOyxisK04Q==
X-Spam-Status: No, hits=0.0 required=3.4
        tests=BAYES_00: -1.665, CUSTOM_RULE_FROM: ALLOW, TOTAL_SCORE: -1.665,autolearn=ham
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from localhost.localdomain ([178.66.213.198])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Wed, 24 Nov 2021 17:39:38 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru, Ivan Bornyakov <i.bornyakov@metrotek.ru>
Subject: [PATCH] bus: imx-weim: optionally enable continuous burst clock
Date:   Wed, 24 Nov 2021 17:25:30 +0300
Message-Id: <20211124142530.366-1-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable continuous burst clock, add "fsl,continuous-burst-clk" along
with "fsl,burst-clk-enable" property to the weim bus's devicetree node.

Example:
weim: weim@21b8000 {
	compatible = "fsl,imx6ul-weim", "fsl,imx6q-weim";
	reg = <0x021b8000 0x4000>;
	clocks = <&clks 143>;
	#address-cells = <2>;
	#size-cells = <1>;
	ranges = <0 0 0x50000000 0x08000000>;
	fsl,weim-cs-gpr = <&gpr>;
	fsl,burst-clk-enable;
	fsl,continuous-burst-clk;

	client-device@0 {
		...
	};
};

Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
---
 drivers/bus/imx-weim.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index 28bb65a5613f..bccb275b65ba 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -21,6 +21,7 @@ struct imx_weim_devtype {
 	unsigned int	cs_stride;
 	unsigned int	wcr_offset;
 	unsigned int	wcr_bcm;
+	unsigned int	wcr_cont_bclk;
 };
 
 static const struct imx_weim_devtype imx1_weim_devtype = {
@@ -41,6 +42,7 @@ static const struct imx_weim_devtype imx50_weim_devtype = {
 	.cs_stride	= 0x18,
 	.wcr_offset	= 0x90,
 	.wcr_bcm	= BIT(0),
+	.wcr_cont_bclk	= BIT(3),
 };
 
 static const struct imx_weim_devtype imx51_weim_devtype = {
@@ -206,8 +208,20 @@ static int weim_parse_dt(struct platform_device *pdev, void __iomem *base)
 	if (of_property_read_bool(pdev->dev.of_node, "fsl,burst-clk-enable")) {
 		if (devtype->wcr_bcm) {
 			reg = readl(base + devtype->wcr_offset);
-			writel(reg | devtype->wcr_bcm,
-				base + devtype->wcr_offset);
+			reg |= devtype->wcr_bcm;
+
+			if (of_property_read_bool(pdev->dev.of_node,
+						"fsl,continuous-burst-clk")) {
+				if (devtype->wcr_cont_bclk) {
+					reg |= devtype->wcr_cont_bclk;
+				} else {
+					dev_err(&pdev->dev,
+						"continuous burst clk not supported.\n");
+					return -EINVAL;
+				}
+			}
+
+			writel(reg, base + devtype->wcr_offset);
 		} else {
 			dev_err(&pdev->dev, "burst clk mode not supported.\n");
 			return -EINVAL;
-- 
2.32.0


