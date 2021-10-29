Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CBF43FC39
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 14:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbhJ2MXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 08:23:14 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:49381 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbhJ2MXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 08:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1635510043; x=1667046043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qWLANHqrECD1c00l6A2+f9SeN9ESj/I6wRgyvY0QQ0w=;
  b=zgZH7DwyQ08DfT07lt4aemxYdb5EJQ+9GsgyAPqKir/13ppGy+2jfdV4
   bb4p1Xbp8ZKnHh1D2l6T0ZojsLPTyu5aDe9n46DJ5I8E2ufWVvYjcWT2E
   zMh6kJPI/Jsnit/AHLsEQwCD8uc2J+XhxZ1trFK67W3Of5uAujyNduliZ
   ah6uLtgTmXe4x0+orbQ9B8eb0VtIWzrsBowH9xNdzrb6bFsS6+KgZ2JwL
   F0abYr5hudPVfLHGQWeIGOdrATgAiAztiGt5NLkmsF2CBXLReWilasdmo
   +JCi+HJnOtrF6UOSQe43ZgAMRWPjutTU9K877uGEilBk+yXxncMGhuBrg
   Q==;
IronPort-SDR: ld3sOUvLWFsX1oIqoWbrGKddLKx7HmupsXw494TAodEDBSUaY4/bChqQ9cemqpsQDtI9vRuWEt
 TemU2Moc4DbeaeXyGC0Dam9XAI7w2dDBMeq6cgDdRXXURWsGCcaVxclxbhsfJGWOJ20ZkvZQHQ
 NXu6XNnNVyIo/jqK68ul+HHUkQYGiCNGZs/GQuI7Osi6ourA14qN6FZqHMZfzenO8X7eaUsIay
 Fwx9WuIF3QvOAxXHbEa348DpyoWor0YPnYtCpJAf0s6JexandyHwzL0P9ebRQA4isi7GyJ1K7I
 fK29EmOo9pSKG3U9DNpGAdi3
X-IronPort-AV: E=Sophos;i="5.87,192,1631602800"; 
   d="scan'208";a="134789148"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Oct 2021 05:20:43 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 29 Oct 2021 05:20:29 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 29 Oct 2021 05:20:26 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <kavyasree.kotagiri@microchip.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [RFC PATCH v2 3/3] clk: lan966x: Extend lan966x clock driver for clock gating support
Date:   Fri, 29 Oct 2021 14:19:29 +0200
Message-ID: <20211029121929.2811811-4-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211029121929.2811811-1-horatiu.vultur@microchip.com>
References: <20211029121929.2811811-1-horatiu.vultur@microchip.com>
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
 drivers/clk/clk-lan966x.c | 78 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 74 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-lan966x.c b/drivers/clk/clk-lan966x.c
index 19bec94e1551..cd372e2c0654 100644
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
@@ -188,11 +202,46 @@ static struct clk_hw *lan966x_gck_clk_register(struct device *dev, int i)
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
+	struct resource *res;
+	int i, ret;
 
 	hw_data = devm_kzalloc(dev, struct_size(hw_data, hws, N_CLOCKS),
 			       GFP_KERNEL);
@@ -205,9 +254,9 @@ static int lan966x_clk_probe(struct platform_device *pdev)
 
 	init.ops = &lan966x_gck_ops;
 
-	hw_data->num = N_CLOCKS;
+	hw_data->num = GCK_GATE_UHPHS;
 
-	for (i = 0; i < N_CLOCKS; i++) {
+	for (i = 0; i < GCK_GATE_UHPHS; i++) {
 		init.name = clk_names[i];
 		hw_data->hws[i] = lan966x_gck_clk_register(dev, i);
 		if (IS_ERR(hw_data->hws[i])) {
@@ -217,7 +266,28 @@ static int lan966x_clk_probe(struct platform_device *pdev)
 		}
 	}
 
-	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, hw_data);
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
+			goto unregister;
+	}
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

