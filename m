Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93875331C49
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 02:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhCIBWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 20:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbhCIBWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 20:22:08 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65286C061760
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 17:22:08 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id k12so18539552ljg.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 17:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wirenboard-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sv6Vbw1Oc2G6knz+M18/XZuiOqYFlQF9/Df8eSYIEM0=;
        b=T64RNAeJlRAxUpzgT4lP3yq50zSgt3tfmpgYNXesFoK0QMlJNs1J0Iue41seiMiv/n
         rD+9zBz0hQDcu77ixWDutGpv6gzTMIOWxEFBlwj1enK7N6B9lsy1vWXOQyoyPjY355Y0
         ZDXosS3+StW9f9ERv0ILtI9UI6pOU754QlehGtbS9f786IUvx8FjMqjLTtnPm4Aq3lv7
         QMwk/KW0f1nPwoV3nSSrniA+nQr7038CYuAmzi9ZmUSrs8WW9oleiUOFW7U9Qro6lnQD
         lbRHJ38dxAxgxwbc/sIkF88jzKqpRljvsaW78TT0hiMDvk4Kes6Mr1Z3aQR5WyoatW/D
         Fz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sv6Vbw1Oc2G6knz+M18/XZuiOqYFlQF9/Df8eSYIEM0=;
        b=FuqBS2YUTxDCkYzZC/Ln59vqptn1gc2m2nxjHa8jkAffu404zpUVP6b++55UUtjkzy
         zvg/7zQFu80e1gPr8KkIzHr9RZER5tueCbBE/CvM5KfNGCQTs5IVgEcyaD/objrMkWG9
         2iQNJ0PF9ZrK1dxivEBQniZWvkj3Qf5KZGYYlK4YD+1WKhyUf+8+9RICbq76DO8i5wZP
         ZFnUFuew4p0tsw8WsPA6m6ZKFHJ9hn55Jwa12jQHuN0z+cZPqHXce8oTMWcGuPH03Sko
         KubnPGKq8RHO1Q9H7+CN23i5OQO+F4iPjsQxZW2c2FOFj+1y8RjT0h3Oxp4JTxozQlDm
         MR+g==
X-Gm-Message-State: AOAM53222TbnRvfvJW0xiVgcQ9HM38CQX79Mu3vozJ3BuZdbPHBkrzDO
        S5TqFJ4qM5K2o0i33WTnwUZ84w==
X-Google-Smtp-Source: ABdhPJyvu02BnKVXFC5Nrg6sS6wCrwvVmzwrb8hK5C+TR9wc0kMXLFIsw9OlLSJmzCzwA3Mx0ZzKUQ==
X-Received: by 2002:a2e:b895:: with SMTP id r21mr15630176ljp.506.1615252926882;
        Mon, 08 Mar 2021 17:22:06 -0800 (PST)
Received: from boger-laptop.lan (81.5.99.6.dhcp.mipt-telecom.ru. [81.5.99.6])
        by smtp.gmail.com with ESMTPSA id o11sm1538395lfu.157.2021.03.08.17.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 17:22:06 -0800 (PST)
From:   Evgeny Boger <boger@wirenboard.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Evgeny Boger <boger@wirenboard.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 1/2] net: allwinner: reset control support
Date:   Tue,  9 Mar 2021 04:21:15 +0300
Message-Id: <20210309012116.2944-2-boger@wirenboard.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210309012116.2944-1-boger@wirenboard.com>
References: <20210309012116.2944-1-boger@wirenboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R40 (aka V40/A40i/T3) and A10/A20 share the same EMAC IP.
However, on R40 the EMAC is gated by default.

Signed-off-by: Evgeny Boger <boger@wirenboard.com>
---
 .../net/allwinner,sun4i-a10-emac.yaml         | 11 +++-
 drivers/net/ethernet/allwinner/sun4i-emac.c   | 65 +++++++++++++++++--
 2 files changed, 70 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/allwinner,sun4i-a10-emac.yaml b/Documentation/devicetree/bindings/net/allwinner,sun4i-a10-emac.yaml
index 8d8560a67abf..27f99372d153 100644
--- a/Documentation/devicetree/bindings/net/allwinner,sun4i-a10-emac.yaml
+++ b/Documentation/devicetree/bindings/net/allwinner,sun4i-a10-emac.yaml
@@ -15,7 +15,12 @@ maintainers:
 
 properties:
   compatible:
-    const: allwinner,sun4i-a10-emac
+    oneOf:
+      - const: allwinner,sun4i-a10-emac
+      - const: allwinner,sun4i-r40-emac
+      - items:
+          - const: allwinner,sun4i-r40-emac
+          - const: allwinner,sun4i-a10-emac
 
   reg:
     maxItems: 1
@@ -30,6 +35,9 @@ properties:
     description: Phandle to the device SRAM
     $ref: /schemas/types.yaml#/definitions/phandle-array
 
+  resets:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -47,6 +55,7 @@ examples:
         reg = <0x01c0b000 0x1000>;
         interrupts = <55>;
         clocks = <&ahb_gates 17>;
+        resets = <&ccu RST_BUS_EMAC>;
         phy-handle = <&phy0>;
         allwinner,sram = <&emac_sram 1>;
     };
diff --git a/drivers/net/ethernet/allwinner/sun4i-emac.c b/drivers/net/ethernet/allwinner/sun4i-emac.c
index 5ed80d9a6b9f..b26913610a38 100644
--- a/drivers/net/ethernet/allwinner/sun4i-emac.c
+++ b/drivers/net/ethernet/allwinner/sun4i-emac.c
@@ -28,6 +28,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/phy.h>
+#include <linux/reset.h>
 #include <linux/soc/sunxi/sunxi_sram.h>
 
 #include "sun4i-emac.h"
@@ -68,6 +69,15 @@ MODULE_PARM_DESC(watchdog, "transmit timeout in milliseconds");
  * devices, EMACA and EMACB.
  */
 
+/**
+ * struct emac_quirks - Differences between SoC variants.
+ *
+ * @has_reset: SoC needs reset deasserted.
+ */
+struct emac_quirks {
+	bool		has_reset;
+};
+
 struct emac_board_info {
 	struct clk		*clk;
 	struct device		*dev;
@@ -85,6 +95,7 @@ struct emac_board_info {
 	unsigned int		link;
 	unsigned int		speed;
 	unsigned int		duplex;
+	struct reset_control	*reset;
 
 	phy_interface_t		phy_interface;
 };
@@ -791,6 +802,7 @@ static int emac_probe(struct platform_device *pdev)
 	struct net_device *ndev;
 	int ret = 0;
 	const char *mac_addr;
+	const struct emac_quirks *quirks;
 
 	ndev = alloc_etherdev(sizeof(struct emac_board_info));
 	if (!ndev) {
@@ -809,6 +821,13 @@ static int emac_probe(struct platform_device *pdev)
 
 	spin_lock_init(&db->lock);
 
+	quirks = of_device_get_match_data(&pdev->dev);
+	if (!quirks) {
+		dev_err(&pdev->dev, "Failed to determine the quirks to use\n");
+		ret = -ENODEV;
+		goto out;
+	}
+
 	db->membase = of_iomap(np, 0);
 	if (!db->membase) {
 		dev_err(&pdev->dev, "failed to remap registers\n");
@@ -825,16 +844,31 @@ static int emac_probe(struct platform_device *pdev)
 		goto out_iounmap;
 	}
 
+	if (quirks->has_reset) {
+		db->reset = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+		if (IS_ERR(db->reset)) {
+			dev_err(&pdev->dev, "unable to request reset\n");
+			ret = PTR_ERR(db->reset);
+			goto out_dispose_mapping;
+		}
+
+		ret = reset_control_deassert(db->reset);
+		if (ret) {
+			dev_err(&pdev->dev, "could not deassert EMAC reset\n");
+			goto out_dispose_mapping;
+		}
+	}
+
 	db->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(db->clk)) {
 		ret = PTR_ERR(db->clk);
-		goto out_dispose_mapping;
+		goto out_assert_reset;
 	}
 
 	ret = clk_prepare_enable(db->clk);
 	if (ret) {
 		dev_err(&pdev->dev, "Error couldn't enable clock (%d)\n", ret);
-		goto out_dispose_mapping;
+		goto out_assert_reset;
 	}
 
 	ret = sunxi_sram_claim(&pdev->dev);
@@ -852,6 +886,7 @@ static int emac_probe(struct platform_device *pdev)
 		goto out_release_sram;
 	}
 
+
 	/* Read MAC-address from DT */
 	mac_addr = of_get_mac_address(np);
 	if (!IS_ERR(mac_addr))
@@ -893,6 +928,8 @@ static int emac_probe(struct platform_device *pdev)
 	sunxi_sram_release(&pdev->dev);
 out_clk_disable_unprepare:
 	clk_disable_unprepare(db->clk);
+out_assert_reset:
+	reset_control_assert(db->reset);
 out_dispose_mapping:
 	irq_dispose_mapping(ndev->irq);
 out_iounmap:
@@ -913,6 +950,7 @@ static int emac_remove(struct platform_device *pdev)
 	unregister_netdev(ndev);
 	sunxi_sram_release(&pdev->dev);
 	clk_disable_unprepare(db->clk);
+	reset_control_assert(db->reset);
 	irq_dispose_mapping(ndev->irq);
 	iounmap(db->membase);
 	free_netdev(ndev);
@@ -944,11 +982,28 @@ static int emac_resume(struct platform_device *dev)
 	return 0;
 }
 
-static const struct of_device_id emac_of_match[] = {
-	{.compatible = "allwinner,sun4i-a10-emac",},
+static const struct emac_quirks sun4i_a10_emac_quirks = {
+	.has_reset = false,
+};
 
+static const struct emac_quirks sun4i_r40_emac_quirks = {
+	.has_reset = true,
+};
+
+static const struct of_device_id emac_of_match[] = {
+	{
+		.compatible = "allwinner,sun4i-a10-emac",
+		.data = &sun4i_a10_emac_quirks
+	},
+	{
+		.compatible = "allwinner,sun4i-r40-emac",
+		.data = &sun4i_r40_emac_quirks
+	},
 	/* Deprecated */
-	{.compatible = "allwinner,sun4i-emac",},
+	{
+		.compatible = "allwinner,sun4i-emac",
+		.data = &sun4i_a10_emac_quirks
+	},
 	{},
 };
 
-- 
2.17.1

