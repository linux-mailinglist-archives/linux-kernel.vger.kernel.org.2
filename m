Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D376441506
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 09:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhKAIKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 04:10:09 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:62128 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbhKAIKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 04:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1635754053; x=1667290053;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pTXbIMogLm/Gpj95PGTVNgiDG10a/0swbYRYN9YELKM=;
  b=mTOpu/HfZjwJprU9IV8QUbsc69bmA9BdvalgYXAj+aIRWKSaVW3i7nZw
   rfhYt+AG75ss83FaiY5KYgVr1tsoLe9oJ7/WMbVcwnBGrilvBazcRBbCM
   75sTCz2d+nx2N67ReHpWXynSgzhFz1AvB5Tl5uXGfVp3/KiPAfmO2q22X
   pjB/hRtxylyytf61f5eel4VP+fy2sR+eY1Bbd9nEx+286TS13cN3esbKC
   +Z/Jr/5tv+te6iIl4v065fc9BqkdJSsYYpSPoRyc0YbM9SJdoz9c6BMB2
   N3Pv/lbvyv+v9/b2W+FPci+Rp+nvIenvXpKt5o9fy8QW4GFP/6EytluAB
   Q==;
IronPort-SDR: 8LdzmjO3bGiw3y0W+PqfK8JZtx+b7iTcqRLQVfiNIwubloD/ELxti2T79xBASE5zan7qNf9bdU
 jKd6bQQ9p/FSLkXhy1clFEiDnI2jeI71ZokkIs7c/lyt1/zs0nfujghV4k2Of4J0JZdHjxIYk9
 HEE9t8p9QQCgmkC+5julh4Ybo2DBcfiXks8GcUA/KStgl8WrV5lK7bRz2U93FfzkuvRhktQ8E0
 5OOn8gGTsSbWJChlFE9JTHdcL6wvTSuwa5ch+YHKUZJoYxqsVDnmqpGk2BX3ReN5MueD9JVc2m
 SGVwXJAQB0BrdpZB37K1n/Fe
X-IronPort-AV: E=Sophos;i="5.87,198,1631602800"; 
   d="scan'208";a="74923451"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Nov 2021 01:07:32 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 1 Nov 2021 01:07:32 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 1 Nov 2021 01:07:30 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <kavyasree.kotagiri@microchip.com>, <eugen.hristev@microchip.com>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [RFC PATCH v3 4/4] clk: lan966x: Extend lan966x clock driver for clock gating support
Date:   Mon, 1 Nov 2021 09:08:45 +0100
Message-ID: <20211101080845.3343836-5-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211101080845.3343836-1-horatiu.vultur@microchip.com>
References: <20211101080845.3343836-1-horatiu.vultur@microchip.com>
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
 drivers/clk/clk-lan966x.c | 59 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-lan966x.c b/drivers/clk/clk-lan966x.c
index 19bec94e1551..328ded6b2eae 100644
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
@@ -188,11 +202,37 @@ static struct clk_hw *lan966x_gck_clk_register(struct device *dev, int i)
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
+			devm_clk_hw_register_gate(dev, clk_gate_desc[idx].name,
+						  "lan966x", 0, base,
+						  clk_gate_desc[idx].bit_idx,
+						  0, &clk_gate_lock);
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
 static int lan966x_clk_probe(struct platform_device *pdev)
 {
 	struct clk_hw_onecell_data *hw_data;
 	struct device *dev = &pdev->dev;
-	int i;
+	void __iomem *gate_base;
+	struct resource *res;
+	int i, ret;
 
 	hw_data = devm_kzalloc(dev, struct_size(hw_data, hws, N_CLOCKS),
 			       GFP_KERNEL);
@@ -205,9 +245,9 @@ static int lan966x_clk_probe(struct platform_device *pdev)
 
 	init.ops = &lan966x_gck_ops;
 
-	hw_data->num = N_CLOCKS;
+	hw_data->num = GCK_GATE_UHPHS;
 
-	for (i = 0; i < N_CLOCKS; i++) {
+	for (i = 0; i < GCK_GATE_UHPHS; i++) {
 		init.name = clk_names[i];
 		hw_data->hws[i] = lan966x_gck_clk_register(dev, i);
 		if (IS_ERR(hw_data->hws[i])) {
@@ -217,6 +257,19 @@ static int lan966x_clk_probe(struct platform_device *pdev)
 		}
 	}
 
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (res) {
+		gate_base = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(gate_base))
+			return PTR_ERR(gate_base);
+
+		hw_data->num = N_CLOCKS;
+
+		ret = lan966x_gate_clk_register(dev, hw_data, gate_base);
+		if (ret)
+			return ret;
+	}
+
 	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, hw_data);
 }
 
-- 
2.33.0

