Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E46F43E882
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 20:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhJ1Si0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 14:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbhJ1SiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 14:38:14 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8274C0613B9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 11:35:39 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id l13so15530032lfg.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 11:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hU+RESS0IujZsBqyvNbXzNXQg4dk7Tku3/T9o6vZEbg=;
        b=BzN19lpvtma2rZrB8dHRsCmLFHLw3Q8UqeKtIRqq8a8tZwUmTFISby5BY9xmHjC8Ri
         0RDJssEdcb10bZjtMgUakEJkgN4pZ1N+QztRcNkb9dWeCIwu51glf2rzzo2sGyfXo1V9
         wfKpod2owpglL0XlPNb14G4Y6v31eG02KWGpMJVOeP/DkOQc8asHrFDvdQ/FzYb3iH2N
         CmTcIyG5NmIyz/1MsNQAnrfJ4asMrUqkfb4SBDCBStJswGJVAlQDv2G7mniiD4goSGiT
         lxAsI0ow8uhx4g3/4Eym/XU7Y5TtPqi+tflaGnNJwXvjuDJawgz7GvgZ6/nEv00nyjNa
         qy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hU+RESS0IujZsBqyvNbXzNXQg4dk7Tku3/T9o6vZEbg=;
        b=Qn6KDjcwoIXDrLarjnBFUMoyTPrp6/b2UTVQPBPyEgUlvW58rriGa2Yy5qo3my2w+s
         wkrTYYA6TtFNzIW3il11yhq+eXuiQqhclCTscgNll68HHw9+cpHoQVmuLG8aq5Th/tdc
         vzNgjyGJ6XMaYDbNyP9b9TpPYbElWv1UBHE0ptL/hUylVMAROJBjyeCkmC4lEzXT7Zg7
         u+qN9MHl2egisx2RpH6aXXEwMg3jxBUNNTWs7iZuvmNPaczIKut4p9ias17N7U7YNi/l
         Fvvtrx6stemScSfDGzV8rqXsSsbRQjC4QWlrVKFalyK2GPtR/zWytqZb2kHtACLto5mk
         VFAg==
X-Gm-Message-State: AOAM533C0WgV5gXKmfvebM5K/s8io6fhYXW830Y5sVnlpkuGOcGqHmja
        ViINDgyUVJFToNCyo61uoEIrhTskEP6dP7nG
X-Google-Smtp-Source: ABdhPJxn7K0lBUsJvXWo1vCNTw0mE29EUqOwFLOa38BUdNLv1YQABFsI/jy4gP9ovi7+I7VArZqtcw==
X-Received: by 2002:a05:6512:1586:: with SMTP id bp6mr5879988lfb.363.1635446138079;
        Thu, 28 Oct 2021 11:35:38 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id n17sm165349ljc.124.2021.10.28.11.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 11:35:37 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 6/7] watchdog: s3c2410: Add Exynos850 support
Date:   Thu, 28 Oct 2021 21:35:26 +0300
Message-Id: <20211028183527.3050-7-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211028183527.3050-1-semen.protsenko@linaro.org>
References: <20211028183527.3050-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exynos850 is a bit different from SoCs already supported in WDT driver:
  - AUTOMATIC_WDT_RESET_DISABLE register is removed, so its value is
    always 0; .disable_auto_reset callback is not set for that reason
  - MASK_WDT_RESET_REQUEST register is replaced with
    CLUSTERx_NONCPU_IN_EN register; instead of masking (disabling) WDT
    reset interrupt it's now enabled with the same value; .mask_reset
    callback is reused for that functionality though
  - To make WDT functional, WDT counter needs to be enabled in
    CLUSTERx_NONCPU_OUT register; it's done using .enable_counter
    callback

Also Exynos850 has two CPU clusters, each has its own dedicated WDT
instance. It takes two different driver data structures (and thus two
different compatibles), as for each cluster there are different
registers and different bits used.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/watchdog/s3c2410_wdt.c | 49 ++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index bfc5872ca497..ca082b1226e3 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -56,6 +56,10 @@
 #define EXYNOS5_RST_STAT_REG_OFFSET		0x0404
 #define EXYNOS5_WDT_DISABLE_REG_OFFSET		0x0408
 #define EXYNOS5_WDT_MASK_RESET_REG_OFFSET	0x040c
+#define EXYNOS850_CLUSTER0_NONCPU_OUT		0x1220
+#define EXYNOS850_CLUSTER0_NONCPU_INT_EN	0x1244
+#define EXYNOS850_CLUSTER1_NONCPU_OUT		0x1620
+#define EXYNOS850_CLUSTER1_NONCPU_INT_EN	0x1644
 #define QUIRK_HAS_PMU_CONFIG			(1 << 0)
 #define QUIRK_HAS_RST_STAT			(1 << 1)
 #define QUIRK_HAS_WTCLRINT_REG			(1 << 2)
@@ -141,6 +145,7 @@ struct s3c2410_wdt {
 
 static int s3c2410wdt_disable_wdt_reset(struct s3c2410_wdt *wdt, bool mask);
 static int s3c2410wdt_mask_wdt_reset(struct s3c2410_wdt *wdt, bool mask);
+static int s3c2410wdt_enable_wdt_reset(struct s3c2410_wdt *wdt, bool mask);
 static int s3c2410wdt_enable_counter(struct s3c2410_wdt *wdt, bool en);
 
 static const struct s3c2410_wdt_variant drv_data_s3c2410 = {
@@ -188,6 +193,32 @@ static const struct s3c2410_wdt_variant drv_data_exynos7 = {
 	.mask_reset = s3c2410wdt_mask_wdt_reset,
 };
 
+static const struct s3c2410_wdt_variant drv_data_exynos850_cl0 = {
+	.mask_reset_reg = EXYNOS850_CLUSTER0_NONCPU_INT_EN,
+	.mask_bit = 2,
+	.rst_stat_reg = EXYNOS5_RST_STAT_REG_OFFSET,
+	.rst_stat_bit = 24,	/* CLUSTER0 WDTRESET */
+	.cnt_en_reg = EXYNOS850_CLUSTER0_NONCPU_OUT,
+	.cnt_en_bit = 7,
+	.quirks = QUIRK_HAS_PMU_CONFIG | QUIRK_HAS_RST_STAT \
+		  | QUIRK_HAS_WTCLRINT_REG,
+	.mask_reset = s3c2410wdt_enable_wdt_reset,
+	.enable_counter = s3c2410wdt_enable_counter,
+};
+
+static const struct s3c2410_wdt_variant drv_data_exynos850_cl1 = {
+	.mask_reset_reg = EXYNOS850_CLUSTER1_NONCPU_INT_EN,
+	.mask_bit = 2,
+	.rst_stat_reg = EXYNOS5_RST_STAT_REG_OFFSET,
+	.rst_stat_bit = 23,	/* CLUSTER1 WDTRESET */
+	.cnt_en_reg = EXYNOS850_CLUSTER1_NONCPU_OUT,
+	.cnt_en_bit = 7,
+	.quirks = QUIRK_HAS_PMU_CONFIG | QUIRK_HAS_RST_STAT \
+		  | QUIRK_HAS_WTCLRINT_REG,
+	.mask_reset = s3c2410wdt_enable_wdt_reset,
+	.enable_counter = s3c2410wdt_enable_counter,
+};
+
 static const struct of_device_id s3c2410_wdt_match[] = {
 	{ .compatible = "samsung,s3c2410-wdt",
 	  .data = &drv_data_s3c2410 },
@@ -199,6 +230,10 @@ static const struct of_device_id s3c2410_wdt_match[] = {
 	  .data = &drv_data_exynos5420 },
 	{ .compatible = "samsung,exynos7-wdt",
 	  .data = &drv_data_exynos7 },
+	{ .compatible = "samsung,exynos850-cl0-wdt",
+	  .data = &drv_data_exynos850_cl0 },
+	{ .compatible = "samsung,exynos850-cl1-wdt",
+	  .data = &drv_data_exynos850_cl1 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, s3c2410_wdt_match);
@@ -254,6 +289,20 @@ static int s3c2410wdt_mask_wdt_reset(struct s3c2410_wdt *wdt, bool mask)
 	return ret;
 }
 
+static int s3c2410wdt_enable_wdt_reset(struct s3c2410_wdt *wdt, bool mask)
+{
+	const u32 mask_val = 1 << wdt->drv_data->mask_bit;
+	const u32 val = mask ? 0 : mask_val; /* reset interrupt enable value */
+	int ret;
+
+	ret = regmap_update_bits(wdt->pmureg, wdt->drv_data->mask_reset_reg,
+				 mask_val, val);
+	if (ret < 0)
+		dev_err(wdt->dev, "failed to update reg(%d)\n", ret);
+
+	return ret;
+}
+
 static int s3c2410wdt_enable_counter(struct s3c2410_wdt *wdt, bool en)
 {
 	const u32 mask_val = 1 << wdt->drv_data->cnt_en_bit;
-- 
2.30.2

