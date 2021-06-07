Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7866639D3A3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 05:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhFGDwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 23:52:41 -0400
Received: from mx.socionext.com ([202.248.49.38]:21083 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230127AbhFGDwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 23:52:41 -0400
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 07 Jun 2021 12:50:50 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 4288E205902A;
        Mon,  7 Jun 2021 12:50:50 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 7 Jun 2021 12:50:50 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 010CEB62AB;
        Mon,  7 Jun 2021 12:50:49 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] phy: uniphier-pcie: Fix updating phy parameters
Date:   Mon,  7 Jun 2021 12:50:42 +0900
Message-Id: <1623037842-19363-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current driver uses a value from register TEST_O as the original
value for register TEST_I, though, the value is overwritten by "param",
so there is a bug that the original value isn't no longer used.

The value of TEST_O[7:0] should be masked with "mask", replaced with
"param", and placed in the bitfield TESTI_DAT_MASK as new TEST_I value.

Fixes: c6d9b1324159 ("phy: socionext: add PCIe PHY driver support")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/phy/socionext/phy-uniphier-pcie.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/socionext/phy-uniphier-pcie.c b/drivers/phy/socionext/phy-uniphier-pcie.c
index e4adab3..6bdbd1f 100644
--- a/drivers/phy/socionext/phy-uniphier-pcie.c
+++ b/drivers/phy/socionext/phy-uniphier-pcie.c
@@ -24,11 +24,13 @@
 #define PORT_SEL_1		FIELD_PREP(PORT_SEL_MASK, 1)
 
 #define PCL_PHY_TEST_I		0x2000
-#define PCL_PHY_TEST_O		0x2004
 #define TESTI_DAT_MASK		GENMASK(13, 6)
 #define TESTI_ADR_MASK		GENMASK(5, 1)
 #define TESTI_WR_EN		BIT(0)
 
+#define PCL_PHY_TEST_O		0x2004
+#define TESTO_DAT_MASK		GENMASK(7, 0)
+
 #define PCL_PHY_RESET		0x200c
 #define PCL_PHY_RESET_N_MNMODE	BIT(8)	/* =1:manual */
 #define PCL_PHY_RESET_N		BIT(0)	/* =1:deasssert */
@@ -77,11 +79,12 @@ static void uniphier_pciephy_set_param(struct uniphier_pciephy_priv *priv,
 	val  = FIELD_PREP(TESTI_DAT_MASK, 1);
 	val |= FIELD_PREP(TESTI_ADR_MASK, reg);
 	uniphier_pciephy_testio_write(priv, val);
-	val = readl(priv->base + PCL_PHY_TEST_O);
+	val = readl(priv->base + PCL_PHY_TEST_O) & TESTO_DAT_MASK;
 
 	/* update value */
-	val &= ~FIELD_PREP(TESTI_DAT_MASK, mask);
-	val  = FIELD_PREP(TESTI_DAT_MASK, mask & param);
+	val &= ~mask;
+	val |= mask & param;
+	val = FIELD_PREP(TESTI_DAT_MASK, val);
 	val |= FIELD_PREP(TESTI_ADR_MASK, reg);
 	uniphier_pciephy_testio_write(priv, val);
 	uniphier_pciephy_testio_write(priv, val | TESTI_WR_EN);
-- 
2.7.4

