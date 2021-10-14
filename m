Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA4842DA8D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 15:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhJNNhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 09:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbhJNNhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 09:37:16 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F817C061753
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 06:35:11 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id j21so27457713lfe.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 06:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SnGd6eHlejKEAJbTJQfvjpkOnD5FU3ZOdS7LGYeSVQM=;
        b=LFHWvAvYptUUEwmCDCxDAs2myodlz51oOeMeTvZxN/Y8w2HD/vwmfxslH+XAO/3Akw
         AWYDDA61Mq8tbsHwEDB3jW9dW8ujxO2AOgyXIn0CmO54nOjYuncsL3868rp/iB8ohcyx
         6R32LXFFu6IwDMpHjjKOkTLKPkAHMWIF/fdqnuiNsbgXc5xflhG3mikrJiEwq6NlKets
         +KbHbs4BNFIqutraBS5IvVuJ7XFEVHLUEIRPDktysfcknOQvN7CbOrtRjuwrbrjGuRLq
         TX1oKK+y6VgszQWvErn/KcEc4X0iXzoGnYUmsak3tLbQ/0VTTfo/YLtssePMqoaFnh7i
         dWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SnGd6eHlejKEAJbTJQfvjpkOnD5FU3ZOdS7LGYeSVQM=;
        b=rEr1Cgtdnw+pblrCaFefwMMygWsQYCFKyNCbpQZ9tA8cXKpgxeFM6cnWI2SFN72Zum
         wa2kzdMJtCWMrIMgymd2acok6YM5QE17pWlk2oX3YjiH3xpzo3TkV6QnTHyRHGJSL4WL
         MqBduCeeGdQwmmwsMiy21cmuRc87olgg7kYUuMTaFYvHbyjNATsAYKEBFtFgH82jgMkV
         ODdyQPsRHJVw0HQfpaL7suuVkwVhA75n8WbdrRqCemIHU3VAcIJUcrd+hXbhyMEUaYTj
         8TLDkwCyd6TTh/7i+deH//FZO4ee2bh6KqKjRTRj+wzHR/ejhvlL0FF5tuB7RnzRdEj0
         A0Nw==
X-Gm-Message-State: AOAM532LjGcMCUae1HejE10MGsgli4yyeEHQNrEFf0VZaCOkA7XamNZt
        HyABqZOiW+08fKD+gC8oAPNZYA==
X-Google-Smtp-Source: ABdhPJxSZ3mCoCDfRA0lLn090vlCYBrcrcsLIxi2Vr/8FmIlPzISr0w3ZHh7eCksH/bWGWxmYfCYEg==
X-Received: by 2002:a2e:8143:: with SMTP id t3mr5907365ljg.461.1634218509931;
        Thu, 14 Oct 2021 06:35:09 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id s7sm227554lfe.258.2021.10.14.06.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 06:35:09 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] soc: samsung: exynos-chipid: Pass revision reg offsets
Date:   Thu, 14 Oct 2021 16:35:06 +0300
Message-Id: <20211014133508.1210-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Old Exynos SoCs have both Product ID and Revision ID in one single
register, while new SoCs tend to have two separate registers for those
IDs. Implement handling of both cases by passing Revision ID register
offsets in driver data.

Previously existing macros for Exynos4210 (removed in this patch) were
incorrect:

    #define EXYNOS_SUBREV_MASK         (0xf << 4)
    #define EXYNOS_MAINREV_MASK        (0xf << 0)

Actual format of PRO_ID register in Exynos4210 (offset 0x0):

    [31:12] Product ID
      [9:8] Package information
      [7:4] Main Revision Number
      [3:0] Sub Revision Number

This patch doesn't change the behavior on existing platforms, so
'/sys/devices/soc0/revision' will show the same string as before.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - Renamed *_rev_bit fields in 'struct exynos_chipid_variant' to
    *_rev_shift
  - Renamed EXYNOS_REV_PART_LEN to EXYNOS_REV_PART_MASK
  - Renamed EXYNOS_REV_PART_OFF to EXYNOS_REV_PART_SHIFT

Changes in v3:
  - Rebased on top of krzk/for-next tree
  - Fixed wrong *_rev_shift values in exynos4210_chipid_drv_data
  - Implemented reading the register only once in case when both
    Product ID and Revision ID are stored in the same register
  - Tested all possible cases by emulating read register values
  - Provided more detailed explanation in commit message

 drivers/soc/samsung/exynos-chipid.c       | 69 +++++++++++++++++++----
 include/linux/soc/samsung/exynos-chipid.h |  6 +-
 2 files changed, 60 insertions(+), 15 deletions(-)

diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
index b2627a3a127a..986978e83661 100644
--- a/drivers/soc/samsung/exynos-chipid.c
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -17,6 +17,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -25,6 +26,17 @@
 
 #include "exynos-asv.h"
 
+struct exynos_chipid_variant {
+	unsigned int rev_reg;		/* revision register offset */
+	unsigned int main_rev_shift;	/* main revision offset in rev_reg */
+	unsigned int sub_rev_shift;	/* sub revision offset in rev_reg */
+};
+
+struct exynos_chipid_info {
+	u32 product_id;
+	u32 revision;
+};
+
 static const struct exynos_soc_id {
 	const char *name;
 	unsigned int id;
@@ -50,31 +62,57 @@ static const char *product_id_to_soc_id(unsigned int product_id)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(soc_ids); i++)
-		if ((product_id & EXYNOS_MASK) == soc_ids[i].id)
+		if (product_id == soc_ids[i].id)
 			return soc_ids[i].name;
 	return NULL;
 }
 
+static int exynos_chipid_get_chipid_info(struct regmap *regmap,
+		const struct exynos_chipid_variant *data,
+		struct exynos_chipid_info *soc_info)
+{
+	int ret;
+	unsigned int val, main_rev, sub_rev;
+
+	ret = regmap_read(regmap, EXYNOS_CHIPID_REG_PRO_ID, &val);
+	if (ret < 0)
+		return ret;
+	soc_info->product_id = val & EXYNOS_MASK;
+
+	if (data->rev_reg != EXYNOS_CHIPID_REG_PRO_ID) {
+		ret = regmap_read(regmap, data->rev_reg, &val);
+		if (ret < 0)
+			return ret;
+	}
+	main_rev = (val >> data->main_rev_shift) & EXYNOS_REV_PART_MASK;
+	sub_rev = (val >> data->sub_rev_shift) & EXYNOS_REV_PART_MASK;
+	soc_info->revision = (main_rev << EXYNOS_REV_PART_SHIFT) | sub_rev;
+
+	return 0;
+}
+
 static int exynos_chipid_probe(struct platform_device *pdev)
 {
+	const struct exynos_chipid_variant *drv_data;
+	struct exynos_chipid_info soc_info;
 	struct soc_device_attribute *soc_dev_attr;
 	struct soc_device *soc_dev;
 	struct device_node *root;
 	struct regmap *regmap;
-	u32 product_id;
-	u32 revision;
 	int ret;
 
+	drv_data = of_device_get_match_data(&pdev->dev);
+	if (!drv_data)
+		return -EINVAL;
+
 	regmap = device_node_to_regmap(pdev->dev.of_node);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	ret = regmap_read(regmap, EXYNOS_CHIPID_REG_PRO_ID, &product_id);
+	ret = exynos_chipid_get_chipid_info(regmap, drv_data, &soc_info);
 	if (ret < 0)
 		return ret;
 
-	revision = product_id & EXYNOS_REV_MASK;
-
 	soc_dev_attr = devm_kzalloc(&pdev->dev, sizeof(*soc_dev_attr),
 				    GFP_KERNEL);
 	if (!soc_dev_attr)
@@ -87,8 +125,8 @@ static int exynos_chipid_probe(struct platform_device *pdev)
 	of_node_put(root);
 
 	soc_dev_attr->revision = devm_kasprintf(&pdev->dev, GFP_KERNEL,
-						"%x", revision);
-	soc_dev_attr->soc_id = product_id_to_soc_id(product_id);
+						"%x", soc_info.revision);
+	soc_dev_attr->soc_id = product_id_to_soc_id(soc_info.product_id);
 	if (!soc_dev_attr->soc_id) {
 		pr_err("Unknown SoC\n");
 		return -ENODEV;
@@ -106,7 +144,7 @@ static int exynos_chipid_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, soc_dev);
 
 	dev_info(&pdev->dev, "Exynos: CPU[%s] PRO_ID[0x%x] REV[0x%x] Detected\n",
-		 soc_dev_attr->soc_id, product_id, revision);
+		 soc_dev_attr->soc_id, soc_info.product_id, soc_info.revision);
 
 	return 0;
 
@@ -125,9 +163,18 @@ static int exynos_chipid_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct exynos_chipid_variant exynos4210_chipid_drv_data = {
+	.rev_reg	= 0x0,
+	.main_rev_shift	= 4,
+	.sub_rev_shift	= 0,
+};
+
 static const struct of_device_id exynos_chipid_of_device_ids[] = {
-	{ .compatible = "samsung,exynos4210-chipid" },
-	{}
+	{
+		.compatible	= "samsung,exynos4210-chipid",
+		.data		= &exynos4210_chipid_drv_data,
+	},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, exynos_chipid_of_device_ids);
 
diff --git a/include/linux/soc/samsung/exynos-chipid.h b/include/linux/soc/samsung/exynos-chipid.h
index 8bca6763f99c..62f0e2531068 100644
--- a/include/linux/soc/samsung/exynos-chipid.h
+++ b/include/linux/soc/samsung/exynos-chipid.h
@@ -9,10 +9,8 @@
 #define __LINUX_SOC_EXYNOS_CHIPID_H
 
 #define EXYNOS_CHIPID_REG_PRO_ID	0x00
-#define EXYNOS_SUBREV_MASK		(0xf << 4)
-#define EXYNOS_MAINREV_MASK		(0xf << 0)
-#define EXYNOS_REV_MASK			(EXYNOS_SUBREV_MASK | \
-					 EXYNOS_MAINREV_MASK)
+#define EXYNOS_REV_PART_MASK		0xf
+#define EXYNOS_REV_PART_SHIFT		4
 #define EXYNOS_MASK			0xfffff000
 
 #define EXYNOS_CHIPID_REG_PKG_ID	0x04
-- 
2.30.2

