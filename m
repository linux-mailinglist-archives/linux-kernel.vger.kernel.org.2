Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72703443EA1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 09:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbhKCIxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 04:53:20 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:41046 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbhKCIxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 04:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1635929436; x=1667465436;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pTXbIMogLm/Gpj95PGTVNgiDG10a/0swbYRYN9YELKM=;
  b=c+qCpxzQaJIvq/HKm4fZVJIXyAtPumeBLmM20NYDyUF497vUEqqfYxUf
   8LF/96kgtbaBzUvWIOP4JIvVkA0AZYEtf0Y9c5YeO+D5fPr3WV/wHd43Z
   HUU8EPav0MkImhSVv1K3Ti5sVIpB9k65wuFEi9HdDx6LTkzLtnI/TGZ/h
   6xAm7AQT1NQDhKEa5fuY7Zvslta/6lvvp/PjLgZYLihXhJnEjV2j4K2PU
   bg+IoWN8RXQGme+4g46d/+saEZWrdjC/CbXhFhNXxvW58VhCS6SnGWsmz
   ZNieR92AKaPB/kNuLq36tyQdSHjDrJVL5Mnn1JQrktFQnoZppGpbRIwg0
   A==;
IronPort-SDR: gVDOsWKNcuPqYltAcw7bGUMHJLUTTzhI6ywd9J9EWg9vOd0hFx4CcifmI4QKU2jKCsvi07fL2r
 1i0n4MqdeUY0P2wOXudMeDJQtcAyhtBCNSFl2Gz3SX/7yccvJl6rLO4BoxOPpuEaAZrrLvavnK
 rm1nlJ+/rCOozxKmxiwHk1ItsqxmfdJgDqRwuajH0VsRzzrEvPxPcW3TISizTKjuggg5KpBvmB
 uGGktSn8OTttE0feUyrutBvMDCfNybpcHyVTLHdC0DV+zCrxOIQDXRNvGq02L5QNR8v8tq6cQ0
 qZdtES10eb2VqR/PmYQXORj+
X-IronPort-AV: E=Sophos;i="5.87,205,1631602800"; 
   d="scan'208";a="75206335"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Nov 2021 01:50:35 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 3 Nov 2021 01:50:35 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 3 Nov 2021 01:50:33 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <kavyasree.kotagiri@microchip.com>,
        <nicolas.ferre@microchip.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [RFC PATCH v4 4/4] clk: lan966x: Extend lan966x clock driver for clock gating support
Date:   Wed, 3 Nov 2021 09:51:02 +0100
Message-ID: <20211103085102.1656081-5-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211103085102.1656081-1-horatiu.vultur@microchip.com>
References: <20211103085102.1656081-1-horatiu.vultur@microchip.com>
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

