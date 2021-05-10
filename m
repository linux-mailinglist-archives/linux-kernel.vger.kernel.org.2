Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEAFA377B9E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 07:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhEJFoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 01:44:24 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:33327 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230074AbhEJFoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 01:44:22 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id A78405803EE;
        Mon, 10 May 2021 01:43:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 10 May 2021 01:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=zeMjTxXMNLvgc
        rRh47QEf17e/Pjyznlid4yZDXfrvgI=; b=rGQNWhcSpwG/qdsT1nuTHhjgEojB9
        8tj3hTg/pMsfK4al46/EZQeNj+94PfzjkOqI8O+UsDkssX7l8z4FgjR7tc05A6ta
        QmgSUYO2rkNGhIy02Hn0o0BsKIKIMDpdhBM8tPsql/BI/BGkSbzQBCLMmhMTZ1J2
        f/28Sh0Goz9uNffxsmC6inxDrFrNmWlSU5Sj/DugljEZqpukU4Fp3+ElwB0f138K
        CK/4R+lmMRB2cQUhSUDBPT4c5NPWhl23KUXtni1NEHgMJ4pkuzaCq+otjVfYmOo/
        PNl9Noy/uQ1Py2B+JObS5vle+Gfa9QzUGJHIt1zJgkvTfjpjDnx+GHftA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=zeMjTxXMNLvgcrRh47QEf17e/Pjyznlid4yZDXfrvgI=; b=jPMeHoC6
        o8wExzoIVeSYjJhheujf7J915eW981hIKEQsSPIelrWZM22DVIlWZQJM+Z4AFirx
        lpHHGMh0NwwTgOTCKEVyZ8hhnc66m+ibtg5CUXRlSmeMevHKf6Od+8Mh3qi6D5eY
        G0ZnrpVkEmC9hcFqJ8lpVt60Z2Cnyq3MKoz27UMYM+jCnYMKTa1AervT4CH9a5HI
        cz6GIk4LigdvNMXNc5qHAFKJGjTSL0y8sAP6t5IHMR5Hz02dwIGY0ZhW1aIsLR2Z
        xpANEKV+qC7bTaFvVIiYs0ats+pdU/JuwV8dUq3Zdqe/XS3PGAuaJd9hjq5Ic1Q+
        /CyyHX07/t8yPQ==
X-ME-Sender: <xms:9MeYYIQuuNU5osDFnNmjtlpqF-Kig3DCCuX2FktrEEryF45LfRjuRQ>
    <xme:9MeYYFyC3BqT4Y5xmoDDF8roDKQUWVo3CqvOW4TRYyRVRy3_nSChbvjlZLuk8YqPj
    Kdu68mYrjuyFglcdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdegjedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
    jhdrihgurdgruheqnecuggftrfgrthhtvghrnhepjefgvdevheetkeevgeegleelgfelte
    etjeffleffvdduudevieffgeetleevhfetnecukfhppedvtdefrdehjedrvdduhedrkeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurh
    gvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:9MeYYF2BMnnLdUUmCMD9atFv18ObOPejrmBBtGhRiRCwvqqMI-ucGA>
    <xmx:9MeYYMAOWiehuj6gZNjMJ0nQVdzmvHmtoBKj9CRQ7CDpvDYx2UP-1Q>
    <xmx:9MeYYBiM3P_r6rNCcmjsMSrSslNpFDobPXh5dt_IoA6kIJI-H-x3MA>
    <xmx:9MeYYESq4aBzRcM7rWJujOifNBuKn5YjLMOdQHDzL9YfL4p73pJKhg>
Received: from localhost.localdomain (unknown [203.57.215.8])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Mon, 10 May 2021 01:43:10 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     openipmi-developer@lists.sourceforge.net, openbmc@lists.ozlabs.org,
        minyard@acm.org
Cc:     devicetree@vger.kernel.org, tmaimon77@gmail.com,
        linux-aspeed@lists.ozlabs.org, avifishman70@gmail.com,
        venture@google.com, linux-kernel@vger.kernel.org,
        tali.perry1@gmail.com, robh+dt@kernel.org,
        chiawei_wang@aspeedtech.com, linux-arm-kernel@lists.infradead.org,
        benjaminfair@google.com, arnd@arndb.de, zweiss@equinix.com
Subject: [PATCH v3 01/16] ipmi: kcs_bmc_aspeed: Use of match data to extract KCS properties
Date:   Mon, 10 May 2021 15:11:58 +0930
Message-Id: <20210510054213.1610760-2-andrew@aj.id.au>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210510054213.1610760-1-andrew@aj.id.au>
References: <20210510054213.1610760-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unpack and remove the aspeed_kcs_probe_of_v[12]() functions to aid
rearranging how the private device-driver memory is allocated.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/char/ipmi/kcs_bmc_aspeed.c | 154 ++++++++++++++---------------
 1 file changed, 76 insertions(+), 78 deletions(-)

diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
index eefe362f65f0..c94d36e195be 100644
--- a/drivers/char/ipmi/kcs_bmc_aspeed.c
+++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/poll.h>
 #include <linux/regmap.h>
@@ -63,6 +64,10 @@ struct aspeed_kcs_bmc {
 	struct regmap *map;
 };
 
+struct aspeed_kcs_of_ops {
+	int (*get_channel)(struct platform_device *pdev);
+	int (*get_io_address)(struct platform_device *pdev);
+};
 
 static u8 aspeed_kcs_inb(struct kcs_bmc *kcs_bmc, u32 reg)
 {
@@ -231,13 +236,10 @@ static const struct kcs_ioreg ast_kcs_bmc_ioregs[KCS_CHANNEL_MAX] = {
 	{ .idr = LPC_IDR4, .odr = LPC_ODR4, .str = LPC_STR4 },
 };
 
-static struct kcs_bmc *aspeed_kcs_probe_of_v1(struct platform_device *pdev)
+static int aspeed_kcs_of_v1_get_channel(struct platform_device *pdev)
 {
-	struct aspeed_kcs_bmc *priv;
 	struct device_node *np;
-	struct kcs_bmc *kcs;
 	u32 channel;
-	u32 slave;
 	int rc;
 
 	np = pdev->dev.of_node;
@@ -245,105 +247,79 @@ static struct kcs_bmc *aspeed_kcs_probe_of_v1(struct platform_device *pdev)
 	rc = of_property_read_u32(np, "kcs_chan", &channel);
 	if ((rc != 0) || (channel == 0 || channel > KCS_CHANNEL_MAX)) {
 		dev_err(&pdev->dev, "no valid 'kcs_chan' configured\n");
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 	}
 
-	kcs = kcs_bmc_alloc(&pdev->dev, sizeof(struct aspeed_kcs_bmc), channel);
-	if (!kcs)
-		return ERR_PTR(-ENOMEM);
+	return channel;
+}
 
-	priv = kcs_bmc_priv(kcs);
-	priv->map = syscon_node_to_regmap(pdev->dev.parent->of_node);
-	if (IS_ERR(priv->map)) {
-		dev_err(&pdev->dev, "Couldn't get regmap\n");
-		return ERR_PTR(-ENODEV);
-	}
+static int aspeed_kcs_of_v1_get_io_address(struct platform_device *pdev)
+{
+	u32 slave;
+	int rc;
 
-	rc = of_property_read_u32(np, "kcs_addr", &slave);
-	if (rc) {
+	rc = of_property_read_u32(pdev->dev.of_node, "kcs_addr", &slave);
+	if (rc || slave > 0xffff) {
 		dev_err(&pdev->dev, "no valid 'kcs_addr' configured\n");
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 	}
 
-	kcs->ioreg = ast_kcs_bmc_ioregs[channel - 1];
-	aspeed_kcs_set_address(kcs, slave);
-
-	return kcs;
-}
-
-static int aspeed_kcs_calculate_channel(const struct kcs_ioreg *regs)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(ast_kcs_bmc_ioregs); i++) {
-		if (!memcmp(&ast_kcs_bmc_ioregs[i], regs, sizeof(*regs)))
-			return i + 1;
-	}
-
-	return -EINVAL;
+	return slave;
 }
 
-static struct kcs_bmc *aspeed_kcs_probe_of_v2(struct platform_device *pdev)
+static int aspeed_kcs_of_v2_get_channel(struct platform_device *pdev)
 {
-	struct aspeed_kcs_bmc *priv;
 	struct device_node *np;
 	struct kcs_ioreg ioreg;
-	struct kcs_bmc *kcs;
 	const __be32 *reg;
-	int channel;
-	u32 slave;
-	int rc;
+	int i;
 
 	np = pdev->dev.of_node;
 
 	/* Don't translate addresses, we want offsets for the regmaps */
 	reg = of_get_address(np, 0, NULL, NULL);
 	if (!reg)
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 	ioreg.idr = be32_to_cpup(reg);
 
 	reg = of_get_address(np, 1, NULL, NULL);
 	if (!reg)
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 	ioreg.odr = be32_to_cpup(reg);
 
 	reg = of_get_address(np, 2, NULL, NULL);
 	if (!reg)
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 	ioreg.str = be32_to_cpup(reg);
 
-	channel = aspeed_kcs_calculate_channel(&ioreg);
-	if (channel < 0)
-		return ERR_PTR(channel);
-
-	kcs = kcs_bmc_alloc(&pdev->dev, sizeof(struct aspeed_kcs_bmc), channel);
-	if (!kcs)
-		return ERR_PTR(-ENOMEM);
-
-	kcs->ioreg = ioreg;
-
-	priv = kcs_bmc_priv(kcs);
-	priv->map = syscon_node_to_regmap(pdev->dev.parent->of_node);
-	if (IS_ERR(priv->map)) {
-		dev_err(&pdev->dev, "Couldn't get regmap\n");
-		return ERR_PTR(-ENODEV);
+	for (i = 0; i < ARRAY_SIZE(ast_kcs_bmc_ioregs); i++) {
+		if (!memcmp(&ast_kcs_bmc_ioregs[i], &ioreg, sizeof(ioreg)))
+			return i + 1;
 	}
 
-	rc = of_property_read_u32(np, "aspeed,lpc-io-reg", &slave);
-	if (rc)
-		return ERR_PTR(rc);
+	return -EINVAL;
+}
 
-	aspeed_kcs_set_address(kcs, slave);
+static int aspeed_kcs_of_v2_get_io_address(struct platform_device *pdev)
+{
+	uint32_t slave;
+	int rc;
 
-	return kcs;
+	rc = of_property_read_u32(pdev->dev.of_node, "aspeed,lpc-io-reg", &slave);
+	if (rc || slave > 0xffff)
+		return -EINVAL;
+
+	return slave;
 }
 
 static int aspeed_kcs_probe(struct platform_device *pdev)
 {
+	const struct aspeed_kcs_of_ops *ops;
 	struct device *dev = &pdev->dev;
+	struct aspeed_kcs_bmc *priv;
 	struct kcs_bmc *kcs_bmc;
 	struct device_node *np;
-	int rc;
+	int rc, channel, addr;
 
 	np = dev->of_node->parent;
 	if (!of_device_is_compatible(np, "aspeed,ast2400-lpc-v2") &&
@@ -352,23 +328,35 @@ static int aspeed_kcs_probe(struct platform_device *pdev)
 		dev_err(dev, "unsupported LPC device binding\n");
 		return -ENODEV;
 	}
-
-	np = dev->of_node;
-	if (of_device_is_compatible(np, "aspeed,ast2400-kcs-bmc") ||
-	    of_device_is_compatible(np, "aspeed,ast2500-kcs-bmc"))
-		kcs_bmc = aspeed_kcs_probe_of_v1(pdev);
-	else if (of_device_is_compatible(np, "aspeed,ast2400-kcs-bmc-v2") ||
-		 of_device_is_compatible(np, "aspeed,ast2500-kcs-bmc-v2"))
-		kcs_bmc = aspeed_kcs_probe_of_v2(pdev);
-	else
+	ops = of_device_get_match_data(&pdev->dev);
+	if (!ops)
 		return -EINVAL;
 
-	if (IS_ERR(kcs_bmc))
-		return PTR_ERR(kcs_bmc);
+	channel = ops->get_channel(pdev);
+	if (channel < 0)
+		return channel;
 
+	kcs_bmc = kcs_bmc_alloc(&pdev->dev, sizeof(struct aspeed_kcs_bmc), channel);
+	if (!kcs_bmc)
+		return -ENOMEM;
+
+	kcs_bmc->ioreg = ast_kcs_bmc_ioregs[channel - 1];
 	kcs_bmc->io_inputb = aspeed_kcs_inb;
 	kcs_bmc->io_outputb = aspeed_kcs_outb;
 
+	addr = ops->get_io_address(pdev);
+	if (addr < 0)
+		return addr;
+
+	priv = kcs_bmc_priv(kcs_bmc);
+	priv->map = syscon_node_to_regmap(pdev->dev.parent->of_node);
+	if (IS_ERR(priv->map)) {
+		dev_err(&pdev->dev, "Couldn't get regmap\n");
+		return -ENODEV;
+	}
+
+	aspeed_kcs_set_address(kcs_bmc, addr);
+
 	rc = aspeed_kcs_config_irq(kcs_bmc, pdev);
 	if (rc)
 		return rc;
@@ -400,11 +388,21 @@ static int aspeed_kcs_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct aspeed_kcs_of_ops of_v1_ops = {
+	.get_channel = aspeed_kcs_of_v1_get_channel,
+	.get_io_address = aspeed_kcs_of_v1_get_io_address,
+};
+
+static const struct aspeed_kcs_of_ops of_v2_ops = {
+	.get_channel = aspeed_kcs_of_v2_get_channel,
+	.get_io_address = aspeed_kcs_of_v2_get_io_address,
+};
+
 static const struct of_device_id ast_kcs_bmc_match[] = {
-	{ .compatible = "aspeed,ast2400-kcs-bmc" },
-	{ .compatible = "aspeed,ast2500-kcs-bmc" },
-	{ .compatible = "aspeed,ast2400-kcs-bmc-v2" },
-	{ .compatible = "aspeed,ast2500-kcs-bmc-v2" },
+	{ .compatible = "aspeed,ast2400-kcs-bmc", .data = &of_v1_ops },
+	{ .compatible = "aspeed,ast2500-kcs-bmc", .data = &of_v1_ops },
+	{ .compatible = "aspeed,ast2400-kcs-bmc-v2", .data = &of_v2_ops },
+	{ .compatible = "aspeed,ast2500-kcs-bmc-v2", .data = &of_v2_ops },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ast_kcs_bmc_match);
-- 
2.27.0

