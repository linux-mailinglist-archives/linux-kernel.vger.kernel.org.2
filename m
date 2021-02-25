Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180ED325460
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 18:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbhBYRIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 12:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbhBYRG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 12:06:28 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DD4C061794
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 09:04:14 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id m22so9628094lfg.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 09:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e/iSON5QK+omS1XoqwWY7ETX5FXArOjI6pz19z6lB0I=;
        b=j6bY4H6kfrR0AN3pMN9cqLQivgCqUaS8EYdXbNzkj3DhKOys3gqvJdKERyEF7zKDvv
         BbFY5S8YB8Mfm18GmLWR7a+hGktWJflNKitgAKptY176lqfBwXP4Ej61uNqGS6p2HM34
         GJqj7nc0IVINWxhrpON80l4Tl9IUj6YFL0xDRwhgfNiX28fm63EIuU2il+33zEJ2eSpe
         nKtOwu8KHwN6CHOp3Z/wc6sXdMMOShJYoL0R2kw3W7yS59Bze2AIWt0KSWixL8LDz31p
         h5asIv/FzpV+kqHv+3z+O432JbxBqIo8dj6M/jQWOgB6O1D/4ZmY+v8WCuxaVSvDlVW3
         5YVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e/iSON5QK+omS1XoqwWY7ETX5FXArOjI6pz19z6lB0I=;
        b=OalmOkcz/C2bQ+Wuluqof4odmWA6OwR5i/caXd+9Gnqrt7w4WrQ46hSdq8aKQzVoIw
         xzT6PefGAD491Vbj2x+2CY7zn2Ka+4NuCbPe1NlLFOYmEht1oD8768Z5O0F/+uSKZlOk
         d1zHD2R3sXIjtRSmy4w939ZroH4GcbvMXWALuRMac/B1x7AIJHEt0LnzBTPsb4V9indL
         Fdd6o4YMaE6hRbVz/ZWQIGG3ckcD8ALR2tCPd7hAR4OW++vyAAgPqcbu31bVyF4BgjOm
         RokQ4Spv5FSvhYp3wUejbp4ITt+4yTXQb0YBsyszy1qNeamRffyEy5/XVRFP8ba2uj+v
         BHOQ==
X-Gm-Message-State: AOAM531PzASbBbkxHwobw6JGP5POI0l0Roep0Fd6+eTZvTIR4XbQHN+z
        QwZYFekpfbBqZKJvTa/oBlGUlA==
X-Google-Smtp-Source: ABdhPJx+R9ayXorBaTSiwQJpj6otLXaJvnFpp+m0n+rGegnSlXrw1gvtGaes4gOSb//SiZkmcutOTw==
X-Received: by 2002:a05:6512:398d:: with SMTP id j13mr2290695lfu.41.1614272652167;
        Thu, 25 Feb 2021 09:04:12 -0800 (PST)
Received: from localhost.localdomain (h-155-4-129-234.NA.cust.bahnhof.se. [155.4.129.234])
        by smtp.gmail.com with ESMTPSA id b39sm1103749ljf.68.2021.02.25.09.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 09:04:11 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        greg.tu@genesyslogic.com.tw, Renius Chen <reniuschengl@gmail.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Takao Orito <orito.takao@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] mmc: core: Extend support for mmc regulators with a vqmmc2
Date:   Thu, 25 Feb 2021 18:03:52 +0100
Message-Id: <20210225170352.76872-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210225170352.76872-1-ulf.hansson@linaro.org>
References: <20210225170352.76872-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow an additional external regulator to be controlled by an mmc host
driver, let's add support for a vqmmc2 regulator to the mmc core.

For an SD UHS-II interface the vqmmc2 regulator may correspond to the so
called vdd2 supply, as described by the SD spec. Initially, only 1.8V is
needed, hence limit the new helper function, mmc_regulator_set_vqmmc2() to
this too.

Note that, to allow for flexibility mmc host drivers need to manage the
enable/disable of the vqmmc2 regulator themselves, while the regulator is
looked up through the common mmc_regulator_get_supply().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/regulator.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h     | 11 +++++++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/mmc/core/regulator.c b/drivers/mmc/core/regulator.c
index 609201a467ef..3c189682797c 100644
--- a/drivers/mmc/core/regulator.c
+++ b/drivers/mmc/core/regulator.c
@@ -223,6 +223,33 @@ int mmc_regulator_set_vqmmc(struct mmc_host *mmc, struct mmc_ios *ios)
 }
 EXPORT_SYMBOL_GPL(mmc_regulator_set_vqmmc);
 
+/**
+ * mmc_regulator_set_vqmmc2 - Set vqmmc2 as per the ios->vqmmc2_voltage
+ * @mmc: The mmc host to regulate
+ * @ios: The io bus settings
+ *
+ * Sets a new voltage level for the vqmmc2 regulator, which may correspond to
+ * the vdd2 regulator for an SD UHS-II interface. This function is expected to
+ * be called by mmc host drivers.
+ *
+ * Returns a negative error code on failure, zero if the voltage level was
+ * changed successfully or a positive value if the level didn't need to change.
+ */
+int mmc_regulator_set_vqmmc2(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	if (IS_ERR(mmc->supply.vqmmc2))
+		return -EINVAL;
+
+	switch (ios->vqmmc2_voltage) {
+	case MMC_VQMMC2_VOLTAGE_180:
+		return mmc_regulator_set_voltage_if_supported(
+			mmc->supply.vqmmc2, 1700000, 1800000, 1950000);
+	default:
+		return -EINVAL;
+	}
+}
+EXPORT_SYMBOL_GPL(mmc_regulator_set_vqmmc2);
+
 #else
 
 static inline int mmc_regulator_get_ocrmask(struct regulator *supply)
@@ -249,6 +276,7 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
 
 	mmc->supply.vmmc = devm_regulator_get_optional(dev, "vmmc");
 	mmc->supply.vqmmc = devm_regulator_get_optional(dev, "vqmmc");
+	mmc->supply.vqmmc2 = devm_regulator_get_optional(dev, "vqmmc2");
 
 	if (IS_ERR(mmc->supply.vmmc)) {
 		if (PTR_ERR(mmc->supply.vmmc) == -EPROBE_DEFER)
@@ -268,6 +296,12 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
 		dev_dbg(dev, "No vqmmc regulator found\n");
 	}
 
+	if (IS_ERR(mmc->supply.vqmmc2)) {
+		if (PTR_ERR(mmc->supply.vqmmc2) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		dev_dbg(dev, "No vqmmc2 regulator found\n");
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mmc_regulator_get_supply);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 0a777caaf7f3..ac9f45e3e203 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -65,6 +65,9 @@ struct mmc_ios {
 #define MMC_TIMING_SD_EXP_1_2V	12
 #define MMC_TIMING_SD_UHS2	13
 
+	unsigned char	vqmmc2_voltage;
+#define MMC_VQMMC2_VOLTAGE_180	0
+
 	unsigned char	signal_voltage;		/* signalling voltage (1.8V or 3.3V) */
 
 #define MMC_SIGNAL_VOLTAGE_330	0
@@ -299,6 +302,7 @@ struct mmc_pwrseq;
 struct mmc_supply {
 	struct regulator *vmmc;		/* Card power supply */
 	struct regulator *vqmmc;	/* Optional Vccq supply */
+	struct regulator *vqmmc2;	/* Optional supply for phy */
 };
 
 struct mmc_ctx {
@@ -579,6 +583,7 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
 			struct regulator *supply,
 			unsigned short vdd_bit);
 int mmc_regulator_set_vqmmc(struct mmc_host *mmc, struct mmc_ios *ios);
+int mmc_regulator_set_vqmmc2(struct mmc_host *mmc, struct mmc_ios *ios);
 #else
 static inline int mmc_regulator_set_ocr(struct mmc_host *mmc,
 				 struct regulator *supply,
@@ -592,6 +597,12 @@ static inline int mmc_regulator_set_vqmmc(struct mmc_host *mmc,
 {
 	return -EINVAL;
 }
+
+static inline int mmc_regulator_set_vqmmc2(struct mmc_host *mmc,
+					   struct mmc_ios *ios)
+{
+	return -EINVAL;
+}
 #endif
 
 int mmc_regulator_get_supply(struct mmc_host *mmc);
-- 
2.25.1

