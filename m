Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4626E433184
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 10:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234796AbhJSItH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 04:49:07 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:40541 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbhJSItE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 04:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634633212; x=1666169212;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=842zeHy7sq6BLpUJD4Mcm6yBLnZn7s8Naug6BsCHM1k=;
  b=D9uN6TdMcjrDLkrT0Zz2Hj11Ug01ZfWdgjlzy/G1NYmjnTYXrxRY+pOK
   zEA2U/GRNgRR5ckCE1e8gSeu4OhQbO3xRIN2tPP9ggaJFTz58/h9cygbr
   GLG7iAcF50G1pEnRQxoTnPgVi0FPSqvsx++qHqYLARjmB8OSK+R21wR/U
   vfKOZDfnPrN3Fj8yc6H/AaBL1XMsH2umAFpbvYjK+oMjOjHu9dxg58Bbl
   jCEeAImtA9sbWJBNnNRVKUCtck7bUXijL3wcHNpnaWnua9KnTH3j5zGhd
   YckJ/CPYPEXbxbp9K/JO1hsCKcpastBX+yDWUFnFZTVX+uBvPScukPfxP
   w==;
IronPort-SDR: 0up2T+zjOmnYuGz53Q0N4AuU/1+G/xUcBLCwPotUBXBuaDVTk3b8jgwLl+91FBLGE/JfC9OwBj
 8HfPZLDjLZC8EJtuGsCTvQWoDjWH3j8yUNlXmTJcJo86ZVrj1VFY22BmkWeGDgEG2CF3ChZWkg
 1cEqefMfqL+LgvdOdDdQwmGuZ2vmvAs7CJVIs7IlgeC4E3/ivvOdh6YtXwEdcU88YIztGqEAyf
 dRs4shDQ6oMLDIyiBS4yCvBoraW926UNa/hs5lPEgTqgKdSYB/lALnEtYUUlAzoEVZJ6wMtPpS
 OXkOaxXE0g/vZYMfnca9PUpk
X-IronPort-AV: E=Sophos;i="5.85,383,1624345200"; 
   d="scan'208";a="140848602"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Oct 2021 01:46:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 19 Oct 2021 01:46:51 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 19 Oct 2021 01:46:49 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <kavyasree.kotagiri@microchip.com>,
        <eugen.hristev@microchip.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [RFC PATCH 3/3] clk: lan966x: Extend lan966x clock driver for clock gating support
Date:   Tue, 19 Oct 2021 10:44:49 +0200
Message-ID: <20211019084449.1411060-4-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211019084449.1411060-1-horatiu.vultur@microchip.com>
References: <20211019084449.1411060-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the clock driver to add support also for clock gating. The
following peripherals can be gated: UHPHS, UDPHS, MCRAMC, HMATRIX.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/clk/clk-lan966x.c | 72 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 68 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-lan966x.c b/drivers/clk/clk-lan966x.c
index 19bec94e1551..40be47092a31 100644
--- a/drivers/clk/clk-lan966x.c
+++ b/drivers/clk/clk-lan966x.c
@@ -48,6 +48,20 @@ static struct clk_init_data init = {
 	.num_parents = ARRAY_SIZE(lan966x_gck_pdata),
 };
 
+struct clk_gate_soc_desc {
+	const char *name;
+	int bit_idx;
+};
+
+static const struct clk_gate_soc_desc clk_gate_desc[] = {
+	{ "uhphs", 11 },
+	{ "udphs", 10 },
+	{ "mcramc", 9 },
+	{ "hmatrix", 8 },
+	{ }
+};
+
+static DEFINE_SPINLOCK(clk_gate_lock);
 static void __iomem *base;
 
 static int lan966x_gck_enable(struct clk_hw *hw)
@@ -188,26 +202,64 @@ static struct clk_hw *lan966x_gck_clk_register(struct device *dev, int i)
 	return &priv->hw;
 };
 
+static int lan966x_gate_clk_register(struct device *dev,
+				     struct clk_hw_onecell_data *hw_data,
+				     void __iomem *gate_base)
+{
+	int i;
+
+	for (i = GCK_GATE_UHPHS; i < N_CLOCKS; ++i) {
+		int idx = i - GCK_GATE_UHPHS;
+
+		hw_data->hws[i] =
+			clk_hw_register_gate(dev, clk_gate_desc[idx].name,
+					     "lan966x", 0, base,
+					     clk_gate_desc[idx].bit_idx,
+					     0, &clk_gate_lock);
+
+		if (IS_ERR(hw_data->hws[i]))
+			return dev_err_probe(dev, PTR_ERR(hw_data->hws[i]),
+					     "failed to register %s clock\n",
+					     clk_gate_desc[idx].name);
+	}
+
+	return 0;
+}
+
+static void lan966x_gate_clk_unregister(struct clk_hw_onecell_data *hw_data)
+{
+	int i;
+
+	for (i = GCK_GATE_UHPHS; i < N_CLOCKS; ++i)
+		if (!IS_ERR(hw_data->hws[i]))
+			clk_hw_unregister(hw_data->hws[i]);
+}
+
 static int lan966x_clk_probe(struct platform_device *pdev)
 {
 	struct clk_hw_onecell_data *hw_data;
 	struct device *dev = &pdev->dev;
-	int i;
+	void __iomem *gate_base;
+	int i, ret;
 
 	hw_data = devm_kzalloc(dev, struct_size(hw_data, hws, N_CLOCKS),
 			       GFP_KERNEL);
 	if (!hw_data)
 		return -ENOMEM;
 
-	base = devm_platform_ioremap_resource(pdev, 0);
+	base = devm_platform_ioremap_resource_byname(pdev, "core");
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
+	gate_base = devm_platform_ioremap_resource_byname(pdev, "gate");
+	if (IS_ERR(gate_base))
+		return PTR_ERR(gate_base);
+
 	init.ops = &lan966x_gck_ops;
 
 	hw_data->num = N_CLOCKS;
 
-	for (i = 0; i < N_CLOCKS; i++) {
+	for (i = 0; i < GCK_ID_USB_REFCLK; i++) {
 		init.name = clk_names[i];
 		hw_data->hws[i] = lan966x_gck_clk_register(dev, i);
 		if (IS_ERR(hw_data->hws[i])) {
@@ -217,7 +269,19 @@ static int lan966x_clk_probe(struct platform_device *pdev)
 		}
 	}
 
-	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, hw_data);
+	ret = lan966x_gate_clk_register(dev, hw_data, gate_base);
+	if (ret)
+		goto unregister;
+
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, hw_data);
+	if (ret)
+		goto unregister;
+
+	return 0;
+
+unregister:
+	lan966x_gate_clk_unregister(hw_data);
+	return ret;
 }
 
 static const struct of_device_id lan966x_clk_dt_ids[] = {
-- 
2.33.0

