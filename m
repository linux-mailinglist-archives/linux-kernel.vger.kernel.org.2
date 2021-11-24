Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F315145CBE0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 19:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243124AbhKXSNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 13:13:53 -0500
Received: from mail.pr-group.ru ([178.18.215.3]:54993 "EHLO mail.pr-group.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350347AbhKXSNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 13:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=To9e4hBk+9KWTAv+yOOa9YU2qidFr8D9clDVYMRnqn8=;
        b=DOevVwMSVvd9FTZE+Jo0u8a6CqSwzCp9wVIZ45wU3dFoyiHSE0rY9w74PMGyeE3c+9GyUVU2wik25
         PWSlZ6DDOXnqBl6Z/ZwbpgthPok518iKtxXmbwRbKZb3CTC9k0g02MIdj2T3U7zkaB+B8dBuMDyoJ2
         dhMUchOyBqlZptsf6D8YXaBbEnmljr/moIjCECp6M6KD7BuB1WCIoE1YRXAbBERDKzE1zBjZd6QdXD
         Qn5hl4sffWHoXDzFzn9nHmuGvRZzUJOt31gd8r7EaSxusJJimdHwlCI1/h/hGyxqX6fwXmw0DueOcG
         Use/NfGXn8XmuptCIbNwHpMekp3rwlw==
X-Spam-Status: No, hits=0.0 required=3.4
        tests=BAYES_00: -1.665, CUSTOM_RULE_FROM: ALLOW, TOTAL_SCORE: -1.665,autolearn=ham
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from localhost.localdomain ([178.66.213.198])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Wed, 24 Nov 2021 21:10:24 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>, system@metrotek.ru,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] bus: imx-weim: optionally enable continuous burst clock
Date:   Wed, 24 Nov 2021 20:55:41 +0300
Message-Id: <20211124175542.2772-2-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211124175542.2772-1-i.bornyakov@metrotek.ru>
References: <20211124175542.2772-1-i.bornyakov@metrotek.ru>
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


