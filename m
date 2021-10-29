Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A1E43FAEA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 12:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhJ2Klt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 06:41:49 -0400
Received: from mx.socionext.com ([202.248.49.38]:20369 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231740AbhJ2Kll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 06:41:41 -0400
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 29 Oct 2021 19:39:11 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id B9F21207616C;
        Fri, 29 Oct 2021 19:39:11 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 29 Oct 2021 19:39:11 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 25E18B62AC;
        Fri, 29 Oct 2021 19:39:11 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 4/8] phy: uniphier-pcie: Add compatible string and SoC-dependent data for NX1 SoC
Date:   Fri, 29 Oct 2021 19:39:03 +0900
Message-Id: <1635503947-18250-5-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1635503947-18250-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1635503947-18250-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic support for UniPhier NX1 SoC. This includes a compatible string,
SoC-dependent data, and a function that set to 2-lane mode.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/phy/socionext/phy-uniphier-pcie.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/phy/socionext/phy-uniphier-pcie.c b/drivers/phy/socionext/phy-uniphier-pcie.c
index 6bdbd1f214dd..fde8aac5f4b6 100644
--- a/drivers/phy/socionext/phy-uniphier-pcie.c
+++ b/drivers/phy/socionext/phy-uniphier-pcie.c
@@ -39,6 +39,10 @@
 #define SG_USBPCIESEL		0x590
 #define SG_USBPCIESEL_PCIE	BIT(0)
 
+/* SC */
+#define SC_US3SRCSEL		0x2244
+#define SC_US3SRCSEL_2LANE	GENMASK(9, 8)
+
 #define PCL_PHY_R00		0
 #define   RX_EQ_ADJ_EN		BIT(3)		/* enable for EQ adjustment */
 #define PCL_PHY_R06		6
@@ -261,6 +265,12 @@ static void uniphier_pciephy_ld20_setmode(struct regmap *regmap)
 			   SG_USBPCIESEL_PCIE, SG_USBPCIESEL_PCIE);
 }
 
+static void uniphier_pciephy_nx1_setmode(struct regmap *regmap)
+{
+	regmap_update_bits(regmap, SC_US3SRCSEL,
+			   SC_US3SRCSEL_2LANE, SC_US3SRCSEL_2LANE);
+}
+
 static const struct uniphier_pciephy_soc_data uniphier_pro5_data = {
 	.is_legacy = true,
 };
@@ -274,6 +284,11 @@ static const struct uniphier_pciephy_soc_data uniphier_pxs3_data = {
 	.is_legacy = false,
 };
 
+static const struct uniphier_pciephy_soc_data uniphier_nx1_data = {
+	.is_legacy = false,
+	.set_phymode = uniphier_pciephy_nx1_setmode,
+};
+
 static const struct of_device_id uniphier_pciephy_match[] = {
 	{
 		.compatible = "socionext,uniphier-pro5-pcie-phy",
@@ -287,6 +302,10 @@ static const struct of_device_id uniphier_pciephy_match[] = {
 		.compatible = "socionext,uniphier-pxs3-pcie-phy",
 		.data = &uniphier_pxs3_data,
 	},
+	{
+		.compatible = "socionext,uniphier-nx1-pcie-phy",
+		.data = &uniphier_nx1_data,
+	},
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, uniphier_pciephy_match);
-- 
2.7.4

