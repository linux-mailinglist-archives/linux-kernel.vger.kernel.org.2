Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC4A044720E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 08:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbhKGHo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 02:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235036AbhKGHot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 02:44:49 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049FFC061570;
        Sun,  7 Nov 2021 00:42:07 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id c4so21056231wrd.9;
        Sun, 07 Nov 2021 00:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x10IZirB5LB8RZRsT12IdJrVjqBTqx2EabDrhJCUln8=;
        b=W1swplioznskhYAQ1ZqCNQvi2fsHPXAhokpSmvufHZVx07Gvy69LzQTUeT3BrrJwQ+
         cEGUdNof1JflZwCpj3rWZ1sFMz6qePAAlqrfcF5Rl6zvIYbOzBXyYu5zCEN0pFssXzpe
         KTftB8wQZ5OE9QZ4rwH1RLbwiDfVfYio/ItfcKwh4mClDtUKsX0u+NyGt+S2tWtweiab
         6D2B4/tTRAbXpbw3Kh1j+UlsGOsuD2v+zso+X4Uj+CFF7dQt5ZhRQHI4Epadni1QIthG
         k7UlVntS0WFFLenHhKk6jYNDtNnQADal616xPCUxpPJf1tdDM8dp4kkDZVNImIVBMDXy
         cTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x10IZirB5LB8RZRsT12IdJrVjqBTqx2EabDrhJCUln8=;
        b=AKErGuxNf+nRM7zTrr+zMngL1CGEJibevbmcUt+tak8mQmxKwTsDImchaxFyaTQ6a0
         103ZjpHetfa5Sldzfm4mo0YMEtwbY2NBE5MBI03JezSiuFWNUuefjNUC3vOGl4qYwKgp
         ewYjfeojOwyoYESRjlOp1FrEsGRkZIhIfQBg0YOJ05R6P15bQBMf1Borzi/rdvasQBOX
         2ZlE0U89/SoMseKRYyeL1bKIbPrY1bODOU3XhXE91h8MEtgVpyjJ5xfVqV7PZjs6K/ds
         xs7p1unWF8Rf7aXgn/7EI25RljZCk1hchFWkKRLGeVwF8mQLL+TjaqzXOaPravUZIGN5
         B/yw==
X-Gm-Message-State: AOAM5313eEBTnPLmpXaXY6gvfUjV4p/qduPe2a2vxaAgF7MqtdRro+tL
        vr03zcWdm8pPfh9g149StcS9Ju3Y/TnxRQ==
X-Google-Smtp-Source: ABdhPJy75LeVj3e7rKYpSXW0JCBUnqe1MheUEqygdahEB/IjRYt1Pg4wLTfIvcAOBhhdkv7quCsSWA==
X-Received: by 2002:a5d:4348:: with SMTP id u8mr27088940wrr.35.1636270925443;
        Sun, 07 Nov 2021 00:42:05 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id e12sm15353352wrq.20.2021.11.07.00.42.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Nov 2021 00:42:05 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, sboyd@kernel.org, john@phrozen.org,
        linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        neil@brown.name
Subject: [PATCH v5 3/4] clk: ralink: make system controller node a reset provider
Date:   Sun,  7 Nov 2021 08:41:59 +0100
Message-Id: <20211107074200.18911-4-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211107074200.18911-1-sergio.paracuellos@gmail.com>
References: <20211107074200.18911-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT7621 system controller node is already providing the clocks for the whole
system but must also serve as a reset provider. Hence, add reset controller
related code to the clock driver itself. To get resets properly ready for
the rest of the world we need to move platform driver initialization process
to 'arch_initcall'.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/clk/ralink/clk-mt7621.c | 86 ++++++++++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ralink/clk-mt7621.c b/drivers/clk/ralink/clk-mt7621.c
index a2c045390f00..c725bf6e6e07 100644
--- a/drivers/clk/ralink/clk-mt7621.c
+++ b/drivers/clk/ralink/clk-mt7621.c
@@ -11,14 +11,17 @@
 #include <linux/mfd/syscon.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/reset-controller.h>
 #include <linux/slab.h>
 #include <dt-bindings/clock/mt7621-clk.h>
+#include <dt-bindings/reset/mt7621-reset.h>
 
 /* Configuration registers */
 #define SYSC_REG_SYSTEM_CONFIG0         0x10
 #define SYSC_REG_SYSTEM_CONFIG1         0x14
 #define SYSC_REG_CLKCFG0		0x2c
 #define SYSC_REG_CLKCFG1		0x30
+#define SYSC_REG_RESET_CTRL		0x34
 #define SYSC_REG_CUR_CLK_STS		0x44
 #define MEMC_REG_CPU_PLL		0x648
 
@@ -398,6 +401,76 @@ static void __init mt7621_clk_init(struct device_node *node)
 }
 CLK_OF_DECLARE_DRIVER(mt7621_clk, "mediatek,mt7621-sysc", mt7621_clk_init);
 
+struct mt7621_rst {
+	struct reset_controller_dev rcdev;
+	struct regmap *sysc;
+};
+
+static struct mt7621_rst *to_mt7621_rst(struct reset_controller_dev *dev)
+{
+	return container_of(dev, struct mt7621_rst, rcdev);
+}
+
+static int mt7621_assert_device(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	struct mt7621_rst *data = to_mt7621_rst(rcdev);
+	struct regmap *sysc = data->sysc;
+
+	if (id == MT7621_RST_SYS)
+		return -EINVAL;
+
+	return regmap_update_bits(sysc, SYSC_REG_RESET_CTRL, BIT(id), BIT(id));
+}
+
+static int mt7621_deassert_device(struct reset_controller_dev *rcdev,
+				  unsigned long id)
+{
+	struct mt7621_rst *data = to_mt7621_rst(rcdev);
+	struct regmap *sysc = data->sysc;
+
+	if (id == MT7621_RST_SYS)
+		return -EINVAL;
+
+	return regmap_update_bits(sysc, SYSC_REG_RESET_CTRL, BIT(id), 0);
+}
+
+static int mt7621_reset_device(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	int ret;
+
+	ret = mt7621_assert_device(rcdev, id);
+	if (ret < 0)
+		return ret;
+
+	return mt7621_deassert_device(rcdev, id);
+}
+
+static const struct reset_control_ops reset_ops = {
+	.reset = mt7621_reset_device,
+	.assert = mt7621_assert_device,
+	.deassert = mt7621_deassert_device
+};
+
+static int mt7621_reset_init(struct device *dev, struct regmap *sysc)
+{
+	struct mt7621_rst *rst_data;
+
+	rst_data = devm_kzalloc(dev, sizeof(*rst_data), GFP_KERNEL);
+	if (!rst_data)
+		return -ENOMEM;
+
+	rst_data->sysc = sysc;
+	rst_data->rcdev.ops = &reset_ops;
+	rst_data->rcdev.owner = THIS_MODULE;
+	rst_data->rcdev.nr_resets = 32;
+	rst_data->rcdev.of_reset_n_cells = 1;
+	rst_data->rcdev.of_node = dev_of_node(dev);
+
+	return devm_reset_controller_register(dev, &rst_data->rcdev);
+}
+
 static int mt7621_clk_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -424,6 +497,12 @@ static int mt7621_clk_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = mt7621_reset_init(dev, priv->sysc);
+	if (ret) {
+		dev_err(dev, "Could not init reset controller\n");
+		return ret;
+	}
+
 	count = ARRAY_SIZE(mt7621_clks_base) +
 		ARRAY_SIZE(mt7621_fixed_clks) + ARRAY_SIZE(mt7621_gates);
 	clk_data = devm_kzalloc(dev, struct_size(clk_data, hws, count),
@@ -485,4 +564,9 @@ static struct platform_driver mt7621_clk_driver = {
 		.of_match_table = mt7621_clk_of_match,
 	},
 };
-builtin_platform_driver(mt7621_clk_driver);
+
+static int __init mt7621_clk_reset_init(void)
+{
+	return platform_driver_register(&mt7621_clk_driver);
+}
+arch_initcall(mt7621_clk_reset_init);
-- 
2.33.0

