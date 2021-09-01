Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68BA3FD2A9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 07:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241933AbhIAFGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 01:06:33 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:59399 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241912AbhIAFG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 01:06:28 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id F2FC75C01AC;
        Wed,  1 Sep 2021 01:05:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 01 Sep 2021 01:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=G403FiZrEXF10
        NkUtZME2MVjN18F7TyLXuqbc0sKEq8=; b=GumAqXahjJk6BHXf3AqXxDaOqQrdn
        MKuRHdjirdLxJZ3lbJ8DfGVYa/CuDsUuufDkKQhJ74OSIMQHz6tMlH8Bh4KzB8vU
        Myn0pknz3ME9iLHI41qvkq050iPxembiwpAh8Y51SYjJelyfxokzMttPAMKDXEEF
        i+uN0Z+qTA55c70yIHc/B+8JwN4+iKzz4R8DvlyCbNd7TlUva6bVfnA6996ycKb7
        I0T3CpjfZe6x/TT+fCtrZgtPun0NhobAO8tegOccr0QsWLJ6PJI7YUtWxHioJ9s8
        nSyqcW3BKl4/sp2XUppGwdzFdfAd3a8z2+gNUreWbNvX6a4dwDdj72KEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=G403FiZrEXF10NkUtZME2MVjN18F7TyLXuqbc0sKEq8=; b=CktxrdU6
        cWvjo13WSlZC3Ng2yTkUXWSviPWutw5ra8OOLE+rE1v0X4QraWEgpfXMKyhxAfUR
        25DazH1x6yOVb7z60+0l3kqiMYwkSKbSmG64TeaP1tYO25A07Qyc9TawRLgcjQIT
        Fr/T1YgW9Oh8irnJ6IJaNIl9OPOaf+F7ZxE1/VLmyN+pLpy+waFAADXIX1k4q4ho
        128c0HszonBsAFCfXsPhYu82fyW4mwOKHGHyNOZECwKS3NwlEN4+X5DMCQ60tPfe
        hyb8Dp4O8WoFByTGpvK4puhRjpnwhXYnA391Mp07yLkPQfCe5wjb1Ix6vuwUx9ac
        drk54r3HSS0yGA==
X-ME-Sender: <xms:GwovYa17sxdCB98ru0qRssC17Lg9Y0CeqWh5IRQoEEm8nxchJ3UTQQ>
    <xme:GwovYdEy-6kgQ45ZN0r19O958RFlxX6syVx8p4DRfwRMXh_zIgxa1Mr0PYSzYMhR3
    XdPzjRJbhzT_844dg>
X-ME-Received: <xmr:GwovYS7BqB1pjeg-ztYDxR_rq4qVjD681tX_ZaY-TWVQWPz40Kxg3L9pnVchBP_cmoLdWH4vlZVKyj0UG1wUc3ZKxFnGR6rXt0aGhmOSwfEOqLnHOD7yMxZvytyfqvUodWlJHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvvddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:GwovYb0AtX3d310neE4-yArCoeNXP0dH1_dWAUgckyTm34eCm0v18Q>
    <xmx:GwovYdHiOvXjHN1SmRy8ixMkTngMqLdwaRSnCVWpMV5rKrQ_Hs4B3A>
    <xmx:GwovYU_1bCnNjU9qfvlvDY8pkW81T1LUEfkBKYLXktJBosiE6nfPcg>
    <xmx:GwovYTZR4tnY3Er6GWux8Za1KJ8t-wFPPc2sBys25OF6lzu3xHYsCA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Sep 2021 01:05:30 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 1/8] clk: sunxi-ng: Unregister clocks/resets when unbinding
Date:   Wed,  1 Sep 2021 00:05:19 -0500
Message-Id: <20210901050526.45673-2-samuel@sholland.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210901050526.45673-1-samuel@sholland.org>
References: <20210901050526.45673-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, unbinding a CCU driver unmaps the device's MMIO region, while
leaving its clocks/resets and their providers registered. This can cause
a page fault later when some clock operation tries to perform MMIO. Fix
this by separating the CCU initialization from the memory allocation,
and then using a devres callback to unregister the clocks and resets.

This also fixes a memory leak of the `struct ccu_reset`, and uses the
correct owner (the specific platform driver) for the clocks and resets.

Early OF clock providers are never unregistered, and limited error
handling is possible, so they are mostly unchanged. The error reporting
is made more consistent by moving the message inside of_sunxi_ccu_probe.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/clk/sunxi-ng/ccu-sun4i-a10.c     |  2 +-
 drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c |  2 +-
 drivers/clk/sunxi-ng/ccu-sun50i-a100.c   |  2 +-
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c    |  2 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c   |  2 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c     |  2 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h616.c   |  4 +-
 drivers/clk/sunxi-ng/ccu-sun5i.c         |  2 +-
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c     |  2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a23.c     |  2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c     |  2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c    |  2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c     |  2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c      |  2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-r.c       |  2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-r40.c     |  2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c     |  2 +-
 drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c  |  3 +-
 drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c |  3 +-
 drivers/clk/sunxi-ng/ccu-sun9i-a80.c     |  2 +-
 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c |  2 +-
 drivers/clk/sunxi-ng/ccu_common.c        | 89 ++++++++++++++++++++----
 drivers/clk/sunxi-ng/ccu_common.h        |  6 +-
 23 files changed, 100 insertions(+), 41 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun4i-a10.c b/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
index f32366d9336e..bd9a8782fec3 100644
--- a/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
+++ b/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
@@ -1464,7 +1464,7 @@ static void __init sun4i_ccu_init(struct device_node *node,
 	val &= ~GENMASK(7, 6);
 	writel(val | (2 << 6), reg + SUN4I_AHB_REG);
 
-	sunxi_ccu_probe(node, reg, desc);
+	of_sunxi_ccu_probe(node, reg, desc);
 }
 
 static void __init sun4i_a10_ccu_setup(struct device_node *node)
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c b/drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c
index a56142b90993..6f2a58970556 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c
@@ -196,7 +196,7 @@ static int sun50i_a100_r_ccu_probe(struct platform_device *pdev)
 	if (IS_ERR(reg))
 		return PTR_ERR(reg);
 
-	return sunxi_ccu_probe(pdev->dev.of_node, reg, &sun50i_a100_r_ccu_desc);
+	return devm_sunxi_ccu_probe(&pdev->dev, reg, &sun50i_a100_r_ccu_desc);
 }
 
 static const struct of_device_id sun50i_a100_r_ccu_ids[] = {
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a100.c b/drivers/clk/sunxi-ng/ccu-sun50i-a100.c
index 81b48c73d389..913bb08e6dee 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a100.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a100.c
@@ -1247,7 +1247,7 @@ static int sun50i_a100_ccu_probe(struct platform_device *pdev)
 		writel(val, reg + sun50i_a100_usb2_clk_regs[i]);
 	}
 
-	ret = sunxi_ccu_probe(pdev->dev.of_node, reg, &sun50i_a100_ccu_desc);
+	ret = devm_sunxi_ccu_probe(&pdev->dev, reg, &sun50i_a100_ccu_desc);
 	if (ret)
 		return ret;
 
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index 149cfde817cb..54f25c624f02 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -955,7 +955,7 @@ static int sun50i_a64_ccu_probe(struct platform_device *pdev)
 
 	writel(0x515, reg + SUN50I_A64_PLL_MIPI_REG);
 
-	ret = sunxi_ccu_probe(pdev->dev.of_node, reg, &sun50i_a64_ccu_desc);
+	ret = devm_sunxi_ccu_probe(&pdev->dev, reg, &sun50i_a64_ccu_desc);
 	if (ret)
 		return ret;
 
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
index f8909a7ed553..f30d7eb5424d 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
@@ -232,7 +232,7 @@ static void __init sunxi_r_ccu_init(struct device_node *node,
 		return;
 	}
 
-	sunxi_ccu_probe(node, reg, desc);
+	of_sunxi_ccu_probe(node, reg, desc);
 }
 
 static void __init sun50i_h6_r_ccu_setup(struct device_node *node)
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
index bff446b78290..c0800da2fa3d 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
@@ -1240,7 +1240,7 @@ static int sun50i_h6_ccu_probe(struct platform_device *pdev)
 	val |= BIT(24);
 	writel(val, reg + SUN50I_H6_HDMI_CEC_CLK_REG);
 
-	return sunxi_ccu_probe(pdev->dev.of_node, reg, &sun50i_h6_ccu_desc);
+	return devm_sunxi_ccu_probe(&pdev->dev, reg, &sun50i_h6_ccu_desc);
 }
 
 static const struct of_device_id sun50i_h6_ccu_ids[] = {
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h616.c b/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
index 225307305880..22eb18079a15 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
@@ -1141,9 +1141,7 @@ static void __init sun50i_h616_ccu_setup(struct device_node *node)
 	val |= BIT(24);
 	writel(val, reg + SUN50I_H616_HDMI_CEC_CLK_REG);
 
-	i = sunxi_ccu_probe(node, reg, &sun50i_h616_ccu_desc);
-	if (i)
-		pr_err("%pOF: probing clocks fails: %d\n", node, i);
+	of_sunxi_ccu_probe(node, reg, &sun50i_h616_ccu_desc);
 }
 
 CLK_OF_DECLARE(sun50i_h616_ccu, "allwinner,sun50i-h616-ccu",
diff --git a/drivers/clk/sunxi-ng/ccu-sun5i.c b/drivers/clk/sunxi-ng/ccu-sun5i.c
index b78e9b507c1c..1f4bc0e773a7 100644
--- a/drivers/clk/sunxi-ng/ccu-sun5i.c
+++ b/drivers/clk/sunxi-ng/ccu-sun5i.c
@@ -1012,7 +1012,7 @@ static void __init sun5i_ccu_init(struct device_node *node,
 	val &= ~GENMASK(7, 6);
 	writel(val | (2 << 6), reg + SUN5I_AHB_REG);
 
-	sunxi_ccu_probe(node, reg, desc);
+	of_sunxi_ccu_probe(node, reg, desc);
 }
 
 static void __init sun5i_a10s_ccu_setup(struct device_node *node)
diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
index 9b40d53266a3..3df5c0b41580 100644
--- a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
@@ -1257,7 +1257,7 @@ static void __init sun6i_a31_ccu_setup(struct device_node *node)
 	val |= 0x3 << 12;
 	writel(val, reg + SUN6I_A31_AHB1_REG);
 
-	sunxi_ccu_probe(node, reg, &sun6i_a31_ccu_desc);
+	of_sunxi_ccu_probe(node, reg, &sun6i_a31_ccu_desc);
 
 	ccu_mux_notifier_register(pll_cpu_clk.common.hw.clk,
 				  &sun6i_a31_cpu_nb);
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a23.c b/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
index 103aa504f6c8..577bb235d658 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
@@ -745,7 +745,7 @@ static void __init sun8i_a23_ccu_setup(struct device_node *node)
 	val &= ~BIT(16);
 	writel(val, reg + SUN8I_A23_PLL_MIPI_REG);
 
-	sunxi_ccu_probe(node, reg, &sun8i_a23_ccu_desc);
+	of_sunxi_ccu_probe(node, reg, &sun8i_a23_ccu_desc);
 }
 CLK_OF_DECLARE(sun8i_a23_ccu, "allwinner,sun8i-a23-ccu",
 	       sun8i_a23_ccu_setup);
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
index 91838cd11037..8f65cd03f5ac 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
@@ -805,7 +805,7 @@ static void __init sun8i_a33_ccu_setup(struct device_node *node)
 	val &= ~BIT(16);
 	writel(val, reg + SUN8I_A33_PLL_MIPI_REG);
 
-	sunxi_ccu_probe(node, reg, &sun8i_a33_ccu_desc);
+	of_sunxi_ccu_probe(node, reg, &sun8i_a33_ccu_desc);
 
 	/* Gate then ungate PLL CPU after any rate changes */
 	ccu_pll_notifier_register(&sun8i_a33_pll_cpu_nb);
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
index 2b434521c5cc..c2ddcd2ddab4 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
@@ -906,7 +906,7 @@ static int sun8i_a83t_ccu_probe(struct platform_device *pdev)
 	sun8i_a83t_cpu_pll_fixup(reg + SUN8I_A83T_PLL_C0CPUX_REG);
 	sun8i_a83t_cpu_pll_fixup(reg + SUN8I_A83T_PLL_C1CPUX_REG);
 
-	return sunxi_ccu_probe(pdev->dev.of_node, reg, &sun8i_a83t_ccu_desc);
+	return devm_sunxi_ccu_probe(&pdev->dev, reg, &sun8i_a83t_ccu_desc);
 }
 
 static const struct of_device_id sun8i_a83t_ccu_ids[] = {
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
index 524f33275bc7..4b94b6041b27 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
@@ -342,7 +342,7 @@ static int sunxi_de2_clk_probe(struct platform_device *pdev)
 		goto err_disable_mod_clk;
 	}
 
-	ret = sunxi_ccu_probe(pdev->dev.of_node, reg, ccu_desc);
+	ret = devm_sunxi_ccu_probe(&pdev->dev, reg, ccu_desc);
 	if (ret)
 		goto err_assert_reset;
 
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
index 7e629a4493af..d2fc2903787d 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
@@ -1154,7 +1154,7 @@ static void __init sunxi_h3_h5_ccu_init(struct device_node *node,
 	val &= ~GENMASK(19, 16);
 	writel(val | (0 << 16), reg + SUN8I_H3_PLL_AUDIO_REG);
 
-	sunxi_ccu_probe(node, reg, desc);
+	of_sunxi_ccu_probe(node, reg, desc);
 
 	/* Gate then ungate PLL CPU after any rate changes */
 	ccu_pll_notifier_register(&sun8i_h3_pll_cpu_nb);
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r.c b/drivers/clk/sunxi-ng/ccu-sun8i-r.c
index 4c8c491b87c2..9e754d1f754a 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-r.c
@@ -265,7 +265,7 @@ static void __init sunxi_r_ccu_init(struct device_node *node,
 		return;
 	}
 
-	sunxi_ccu_probe(node, reg, desc);
+	of_sunxi_ccu_probe(node, reg, desc);
 }
 
 static void __init sun8i_a83t_r_ccu_setup(struct device_node *node)
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
index 84153418453f..002e0c3a04db 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
@@ -1346,7 +1346,7 @@ static int sun8i_r40_ccu_probe(struct platform_device *pdev)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	ret = sunxi_ccu_probe(pdev->dev.of_node, reg, &sun8i_r40_ccu_desc);
+	ret = devm_sunxi_ccu_probe(&pdev->dev, reg, &sun8i_r40_ccu_desc);
 	if (ret)
 		return ret;
 
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
index f49724a22540..ce150f83ab54 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
@@ -822,7 +822,7 @@ static void __init sun8i_v3_v3s_ccu_init(struct device_node *node,
 	val &= ~GENMASK(19, 16);
 	writel(val, reg + SUN8I_V3S_PLL_AUDIO_REG);
 
-	sunxi_ccu_probe(node, reg, ccu_desc);
+	of_sunxi_ccu_probe(node, reg, ccu_desc);
 }
 
 static void __init sun8i_v3s_ccu_setup(struct device_node *node)
diff --git a/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c b/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c
index 6616e8114f62..261e64416f26 100644
--- a/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c
+++ b/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c
@@ -246,8 +246,7 @@ static int sun9i_a80_de_clk_probe(struct platform_device *pdev)
 		goto err_disable_clk;
 	}
 
-	ret = sunxi_ccu_probe(pdev->dev.of_node, reg,
-			      &sun9i_a80_de_clk_desc);
+	ret = devm_sunxi_ccu_probe(&pdev->dev, reg, &sun9i_a80_de_clk_desc);
 	if (ret)
 		goto err_assert_reset;
 
diff --git a/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c b/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c
index 4b4a507d04ed..596243b3e0fa 100644
--- a/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c
+++ b/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c
@@ -117,8 +117,7 @@ static int sun9i_a80_usb_clk_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = sunxi_ccu_probe(pdev->dev.of_node, reg,
-			      &sun9i_a80_usb_clk_desc);
+	ret = devm_sunxi_ccu_probe(&pdev->dev, reg, &sun9i_a80_usb_clk_desc);
 	if (ret)
 		goto err_disable_clk;
 
diff --git a/drivers/clk/sunxi-ng/ccu-sun9i-a80.c b/drivers/clk/sunxi-ng/ccu-sun9i-a80.c
index ef29582676f6..97aaed0e6850 100644
--- a/drivers/clk/sunxi-ng/ccu-sun9i-a80.c
+++ b/drivers/clk/sunxi-ng/ccu-sun9i-a80.c
@@ -1231,7 +1231,7 @@ static int sun9i_a80_ccu_probe(struct platform_device *pdev)
 	sun9i_a80_cpu_pll_fixup(reg + SUN9I_A80_PLL_C0CPUX_REG);
 	sun9i_a80_cpu_pll_fixup(reg + SUN9I_A80_PLL_C1CPUX_REG);
 
-	return sunxi_ccu_probe(pdev->dev.of_node, reg, &sun9i_a80_ccu_desc);
+	return devm_sunxi_ccu_probe(&pdev->dev, reg, &sun9i_a80_ccu_desc);
 }
 
 static const struct of_device_id sun9i_a80_ccu_ids[] = {
diff --git a/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c b/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
index 7ecc3a5a5b5e..61ad7ee91c11 100644
--- a/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
+++ b/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
@@ -538,7 +538,7 @@ static void __init suniv_f1c100s_ccu_setup(struct device_node *node)
 	val &= ~GENMASK(19, 16);
 	writel(val | (3 << 16), reg + SUNIV_PLL_AUDIO_REG);
 
-	sunxi_ccu_probe(node, reg, &suniv_ccu_desc);
+	of_sunxi_ccu_probe(node, reg, &suniv_ccu_desc);
 
 	/* Gate then ungate PLL CPU after any rate changes */
 	ccu_pll_notifier_register(&suniv_pll_cpu_nb);
diff --git a/drivers/clk/sunxi-ng/ccu_common.c b/drivers/clk/sunxi-ng/ccu_common.c
index 2e20e650b6c0..88cb569e5835 100644
--- a/drivers/clk/sunxi-ng/ccu_common.c
+++ b/drivers/clk/sunxi-ng/ccu_common.c
@@ -7,6 +7,7 @@
 
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/device.h>
 #include <linux/iopoll.h>
 #include <linux/slab.h>
 
@@ -14,6 +15,11 @@
 #include "ccu_gate.h"
 #include "ccu_reset.h"
 
+struct sunxi_ccu {
+	const struct sunxi_ccu_desc	*desc;
+	struct ccu_reset		reset;
+};
+
 static DEFINE_SPINLOCK(ccu_lock);
 
 void ccu_helper_wait_for_lock(struct ccu_common *common, u32 lock)
@@ -79,12 +85,15 @@ int ccu_pll_notifier_register(struct ccu_pll_nb *pll_nb)
 				     &pll_nb->clk_nb);
 }
 
-int sunxi_ccu_probe(struct device_node *node, void __iomem *reg,
-		    const struct sunxi_ccu_desc *desc)
+static int sunxi_ccu_probe(struct sunxi_ccu *ccu, struct device *dev,
+			   struct device_node *node, void __iomem *reg,
+			   const struct sunxi_ccu_desc *desc)
 {
 	struct ccu_reset *reset;
 	int i, ret;
 
+	ccu->desc = desc;
+
 	for (i = 0; i < desc->num_ccu_clks; i++) {
 		struct ccu_common *cclk = desc->ccu_clks[i];
 
@@ -103,7 +112,10 @@ int sunxi_ccu_probe(struct device_node *node, void __iomem *reg,
 			continue;
 
 		name = hw->init->name;
-		ret = of_clk_hw_register(node, hw);
+		if (dev)
+			ret = clk_hw_register(dev, hw);
+		else
+			ret = of_clk_hw_register(node, hw);
 		if (ret) {
 			pr_err("Couldn't register clock %d - %s\n", i, name);
 			goto err_clk_unreg;
@@ -115,15 +127,10 @@ int sunxi_ccu_probe(struct device_node *node, void __iomem *reg,
 	if (ret)
 		goto err_clk_unreg;
 
-	reset = kzalloc(sizeof(*reset), GFP_KERNEL);
-	if (!reset) {
-		ret = -ENOMEM;
-		goto err_alloc_reset;
-	}
-
+	reset = &ccu->reset;
 	reset->rcdev.of_node = node;
 	reset->rcdev.ops = &ccu_reset_ops;
-	reset->rcdev.owner = THIS_MODULE;
+	reset->rcdev.owner = dev ? dev->driver->owner : THIS_MODULE;
 	reset->rcdev.nr_resets = desc->num_resets;
 	reset->base = reg;
 	reset->lock = &ccu_lock;
@@ -131,13 +138,11 @@ int sunxi_ccu_probe(struct device_node *node, void __iomem *reg,
 
 	ret = reset_controller_register(&reset->rcdev);
 	if (ret)
-		goto err_of_clk_unreg;
+		goto err_del_provider;
 
 	return 0;
 
-err_of_clk_unreg:
-	kfree(reset);
-err_alloc_reset:
+err_del_provider:
 	of_clk_del_provider(node);
 err_clk_unreg:
 	while (--i >= 0) {
@@ -149,3 +154,59 @@ int sunxi_ccu_probe(struct device_node *node, void __iomem *reg,
 	}
 	return ret;
 }
+
+static void devm_sunxi_ccu_release(struct device *dev, void *res)
+{
+	struct sunxi_ccu *ccu = res;
+	const struct sunxi_ccu_desc *desc = ccu->desc;
+	int i;
+
+	reset_controller_unregister(&ccu->reset.rcdev);
+	of_clk_del_provider(dev->of_node);
+
+	for (i = 0; i < desc->hw_clks->num; i++) {
+		struct clk_hw *hw = desc->hw_clks->hws[i];
+
+		if (!hw)
+			continue;
+		clk_hw_unregister(hw);
+	}
+}
+
+int devm_sunxi_ccu_probe(struct device *dev, void __iomem *reg,
+			 const struct sunxi_ccu_desc *desc)
+{
+	struct sunxi_ccu *ccu;
+	int ret;
+
+	ccu = devres_alloc(devm_sunxi_ccu_release, sizeof(*ccu), GFP_KERNEL);
+	if (!ccu)
+		return -ENOMEM;
+
+	ret = sunxi_ccu_probe(ccu, dev, dev->of_node, reg, desc);
+	if (ret) {
+		devres_free(ccu);
+		return ret;
+	}
+
+	devres_add(dev, ccu);
+
+	return 0;
+}
+
+void of_sunxi_ccu_probe(struct device_node *node, void __iomem *reg,
+			const struct sunxi_ccu_desc *desc)
+{
+	struct sunxi_ccu *ccu;
+	int ret;
+
+	ccu = kzalloc(sizeof(*ccu), GFP_KERNEL);
+	if (!ccu)
+		return;
+
+	ret = sunxi_ccu_probe(ccu, NULL, node, reg, desc);
+	if (ret) {
+		pr_err("%pOF: probing clocks failed: %d\n", node, ret);
+		kfree(ccu);
+	}
+}
diff --git a/drivers/clk/sunxi-ng/ccu_common.h b/drivers/clk/sunxi-ng/ccu_common.h
index 04e7a12200a2..98a1834b58bb 100644
--- a/drivers/clk/sunxi-ng/ccu_common.h
+++ b/drivers/clk/sunxi-ng/ccu_common.h
@@ -63,7 +63,9 @@ struct ccu_pll_nb {
 
 int ccu_pll_notifier_register(struct ccu_pll_nb *pll_nb);
 
-int sunxi_ccu_probe(struct device_node *node, void __iomem *reg,
-		    const struct sunxi_ccu_desc *desc);
+int devm_sunxi_ccu_probe(struct device *dev, void __iomem *reg,
+			 const struct sunxi_ccu_desc *desc);
+void of_sunxi_ccu_probe(struct device_node *node, void __iomem *reg,
+			const struct sunxi_ccu_desc *desc);
 
 #endif /* _COMMON_H_ */
-- 
2.31.1

