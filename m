Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5245434E636
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 13:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbhC3LOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 07:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbhC3LNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 07:13:49 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E331C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 04:13:49 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id e14so24165804ejz.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 04:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5OVLtyNt0MZAMy20EvLLVxsr5MSMfAxrbrXMehMXRKU=;
        b=xIaSseU8rJuPcQueqahMudCjxEZjHgcUs1D5jkXWNJsQ2f/EPoaX4Xluy4PUNitLLC
         LqZwR02ItMg0WlFNmeApUUaoYtsv6FI8070g+DqhjxbmU+vHaA6ADCCY1XWqa6zEfyf5
         dHNA1WkDrP2QxlUoZSKYCI4WbFAFUueW0tV1TlaLy6NRh7Aah8HtUKuGxjJWznZgDcI0
         vWIn5E3vtBKAh94oDygcXSQCKxK/q+dGN+dElPKTBExBvZ6VgC/cgMXLZT9EVNB1WxT/
         9VZEorn0ZqTuyP4VDmJo+U8kG0Y4OgNPojFahi8gIzXsTuQYTL1bAKmxoJqf7Rz9gyAw
         pE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5OVLtyNt0MZAMy20EvLLVxsr5MSMfAxrbrXMehMXRKU=;
        b=ccWS4Z0fsr5Dp/Ffe1LauytaoPDwoNMvU/2vKqj6rJpY2G72qVApIazijlbWRNRgb5
         qtIkvglXqMGMunDQyTAEEE4X4aBt1jBp/CsnI2oZXssCa0xcwcp00u7eXrtCcJxlfIky
         ecHIHBo/zaSzkNFH4OFChhAuoAuQWaZTuQeZ8LW0avAOtNK2zxv2iqo9uGUw0T3x1PkL
         SkaTJOykpJ3dbfLLV6vdrDPVvYraVfMx+UOTS7HDcwYMZEJldNe40AA0nZ0Am4FwI8lg
         oiRLqxV4qc+94Dj4FyEP3E221c3x0dPM2mmxgOPnVdMrKmjHlJjTnxNwQDDVD1pCuqXW
         TcbQ==
X-Gm-Message-State: AOAM533afrpqEEfGDZCViRinwfhWagtkEURzlKttupWPR1FDNYbuz4Ys
        uD4wirbyTbrU7rW49KXqqIiRdoGzOWG9VA==
X-Google-Smtp-Source: ABdhPJydiHwg7lBjZiwPQqXq/fH+u9qpgagWLvvSftEy6DVgqnpLsIaPQx3+dOpQ+N/UH3fS8n2X8g==
X-Received: by 2002:a17:907:2955:: with SMTP id et21mr15323373ejc.448.1617102828169;
        Tue, 30 Mar 2021 04:13:48 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id r19sm10961308edp.52.2021.03.30.04.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 04:13:47 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Ravi Kumar Bokka <rbokka@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 10/10] nvmem: qfprom: Add support for fuse blowing on sc7280
Date:   Tue, 30 Mar 2021 12:12:41 +0100
Message-Id: <20210330111241.19401-11-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210330111241.19401-1-srinivas.kandagatla@linaro.org>
References: <20210330111241.19401-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajendra Nayak <rnayak@codeaurora.org>

Handle the differences across LDO voltage needed for blowing fuses,
and the blow timer value, identified using a minor version of 15
on sc7280.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Ravi Kumar Bokka <rbokka@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/qfprom.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index 100d69d8f2e1..d6d3f24685a8 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -45,11 +45,13 @@ MODULE_PARM_DESC(read_raw_data, "Read raw instead of corrected data");
  * @qfprom_blow_timer_value: The timer value of qfprom when doing efuse blow.
  * @qfprom_blow_set_freq:    The frequency required to set when we start the
  *                           fuse blowing.
+ * @qfprom_blow_uV:          LDO voltage to be set when doing efuse blow
  */
 struct qfprom_soc_data {
 	u32 accel_value;
 	u32 qfprom_blow_timer_value;
 	u32 qfprom_blow_set_freq;
+	int qfprom_blow_uV;
 };
 
 /**
@@ -111,6 +113,15 @@ static const struct qfprom_soc_compatible_data sc7180_qfprom = {
 	.nkeepout = ARRAY_SIZE(sc7180_qfprom_keepout)
 };
 
+static const struct nvmem_keepout sc7280_qfprom_keepout[] = {
+	{.start = 0x128, .end = 0x148},
+	{.start = 0x238, .end = 0x248}
+};
+
+static const struct qfprom_soc_compatible_data sc7280_qfprom = {
+	.keepout = sc7280_qfprom_keepout,
+	.nkeepout = ARRAY_SIZE(sc7280_qfprom_keepout)
+};
 /**
  * qfprom_disable_fuse_blowing() - Undo enabling of fuse blowing.
  * @priv: Our driver data.
@@ -168,6 +179,7 @@ static int qfprom_enable_fuse_blowing(const struct qfprom_priv *priv,
 				      struct qfprom_touched_values *old)
 {
 	int ret;
+	int qfprom_blow_uV = priv->soc_data->qfprom_blow_uV;
 
 	ret = clk_prepare_enable(priv->secclk);
 	if (ret) {
@@ -187,9 +199,9 @@ static int qfprom_enable_fuse_blowing(const struct qfprom_priv *priv,
 	 * a rail shared do don't specify a max--regulator constraints
 	 * will handle.
 	 */
-	ret = regulator_set_voltage(priv->vcc, 1800000, INT_MAX);
+	ret = regulator_set_voltage(priv->vcc, qfprom_blow_uV, INT_MAX);
 	if (ret) {
-		dev_err(priv->dev, "Failed to set 1.8 voltage\n");
+		dev_err(priv->dev, "Failed to set %duV\n", qfprom_blow_uV);
 		goto err_clk_rate_set;
 	}
 
@@ -311,6 +323,14 @@ static const struct qfprom_soc_data qfprom_7_8_data = {
 	.accel_value = 0xD10,
 	.qfprom_blow_timer_value = 25,
 	.qfprom_blow_set_freq = 4800000,
+	.qfprom_blow_uV = 1800000,
+};
+
+static const struct qfprom_soc_data qfprom_7_15_data = {
+	.accel_value = 0xD08,
+	.qfprom_blow_timer_value = 24,
+	.qfprom_blow_set_freq = 4800000,
+	.qfprom_blow_uV = 1900000,
 };
 
 static int qfprom_probe(struct platform_device *pdev)
@@ -379,6 +399,8 @@ static int qfprom_probe(struct platform_device *pdev)
 
 		if (major_version == 7 && minor_version == 8)
 			priv->soc_data = &qfprom_7_8_data;
+		if (major_version == 7 && minor_version == 15)
+			priv->soc_data = &qfprom_7_15_data;
 
 		priv->vcc = devm_regulator_get(&pdev->dev, "vcc");
 		if (IS_ERR(priv->vcc))
@@ -405,6 +427,7 @@ static int qfprom_probe(struct platform_device *pdev)
 static const struct of_device_id qfprom_of_match[] = {
 	{ .compatible = "qcom,qfprom",},
 	{ .compatible = "qcom,sc7180-qfprom", .data = &sc7180_qfprom},
+	{ .compatible = "qcom,sc7280-qfprom", .data = &sc7280_qfprom},
 	{/* sentinel */},
 };
 MODULE_DEVICE_TABLE(of, qfprom_of_match);
-- 
2.21.0

