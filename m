Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3967430DA7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 03:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345062AbhJRBjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 21:39:55 -0400
Received: from mx.socionext.com ([202.248.49.38]:26102 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344960AbhJRBjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 21:39:42 -0400
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 18 Oct 2021 10:37:30 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id C61B12058B40;
        Mon, 18 Oct 2021 10:37:30 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 18 Oct 2021 10:37:30 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 11D14AB192;
        Mon, 18 Oct 2021 10:37:30 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 5/8] phy: uniphier-pcie: Set VCOPLL clamp mode in PHY register
Date:   Mon, 18 Oct 2021 10:37:10 +0900
Message-Id: <1634521033-17003-6-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1634521033-17003-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1634521033-17003-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set VCOPLL clamp mode to mode 0 to avoid hardware unstable issue.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/phy/socionext/phy-uniphier-pcie.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/phy/socionext/phy-uniphier-pcie.c b/drivers/phy/socionext/phy-uniphier-pcie.c
index fde8aac5f4b6..2bd8df619712 100644
--- a/drivers/phy/socionext/phy-uniphier-pcie.c
+++ b/drivers/phy/socionext/phy-uniphier-pcie.c
@@ -51,6 +51,9 @@
 #define PCL_PHY_R26		26
 #define   VCO_CTRL		GENMASK(7, 4)	/* Tx VCO adjustment value */
 #define   VCO_CTRL_INIT_VAL	5
+#define PCL_PHY_R28		28
+#define   VCOPLL_CLMP		GENMASK(3, 2)	/* Tx VCOPLL clamp mode */
+#define   VCOPLL_CLMP_VAL	0
 
 struct uniphier_pciephy_priv {
 	void __iomem *base;
@@ -158,6 +161,8 @@ static int uniphier_pciephy_init(struct phy *phy)
 				   FIELD_PREP(RX_EQ_ADJ, RX_EQ_ADJ_VAL));
 	uniphier_pciephy_set_param(priv, PCL_PHY_R26, VCO_CTRL,
 				   FIELD_PREP(VCO_CTRL, VCO_CTRL_INIT_VAL));
+	uniphier_pciephy_set_param(priv, PCL_PHY_R28, VCOPLL_CLMP,
+				   FIELD_PREP(VCOPLL_CLMP, VCOPLL_CLMP_VAL));
 	usleep_range(1, 10);
 
 	uniphier_pciephy_deassert(priv);
-- 
2.7.4

