Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3090342E0B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 16:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhCTP5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 11:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhCTP5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 11:57:12 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C71EC061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 08:57:12 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id z9so10844666ilb.4
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 08:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QkOsDJQJRcIv/IpNT9XJ0+lkXViFL8PhH9fzVnhDUGc=;
        b=Q/Z+C1HWi7cD3lGtDFKFbC3XHqYUA1S63DhFn8LhTgcPHcnpuPmTLhAGFZT8R3vuUj
         VXgw1eJETCGZhC6PYOfM3Nkwl+Y6je1uY63thEnAQbdQZwgn3O9uuYPxAAMJjoPJU1q9
         kOkg2R6wVg9J2NcXRWqm7WlOnZ06lSwK+XHEwQIZj4hF29bHmQHlCv4yTwx8atyQ62Dv
         n7NJ2qA7YqBq96MwB/2L4kJAlW39dF53ON8uzkX5XdDpsafdheDiA1lTsI2Y3DbrN63G
         Uzy3uL61Yf2oQFumM7xblOYMeOsfI8ZN9jQnDjD8qLJbFfOTAVpLqHUgyWAHngNn7Cb5
         rGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QkOsDJQJRcIv/IpNT9XJ0+lkXViFL8PhH9fzVnhDUGc=;
        b=QUHjDXuIc1luwZCs2V5gC0t7OM82VhqPUoOWhCempBe8KbPTAJxQnRBK8QXebQjm2a
         1xiLBo9RpuGkfuY/Eh9dc9daa4P8uMxHoDN6kWoHqMhSYyv0NKpdNFv1EaUYSKho1eUn
         rjBzOwLbBgnYJrmAX2oQEBX1zdi4Eaf+5iVQrgrrYF4urO9mI2bqoMBsB1F8Y4KoS3V0
         RnXiatqV1SHmqnBSJAGoBQUEAyZWOoWE/TcmMRWKl5RQccDL8hJRqJwRcJTh9//cta8T
         86jibXPYDDBd6kV+7hqkFGkBikV/BeNsm+GAPq4l/PZZGsJlAOgGdDi1/SDolVMvVHp4
         +s0g==
X-Gm-Message-State: AOAM532IXOaiK34aTciBNnIph5wY2NNed8+GIn4M4MUP7A9DN1dFCYrc
        279M645w+PRBysJVQIXpjwZGTQ==
X-Google-Smtp-Source: ABdhPJw2ctcTaFRuXP2E40sTbARJYCVxpfyR0ZLeFx8kZJp/lYFt9sXkV2Qddcl942ZW8wmVA6ReOQ==
X-Received: by 2002:a05:6e02:1068:: with SMTP id q8mr6680438ilj.57.1616255831615;
        Sat, 20 Mar 2021 08:57:11 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id n16sm4501698ilq.71.2021.03.20.08.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 08:57:11 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/5] net: ipa: use configuration data for QSB settings
Date:   Sat, 20 Mar 2021 10:57:03 -0500
Message-Id: <20210320155707.2009962-2-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210320155707.2009962-1-elder@linaro.org>
References: <20210320155707.2009962-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the QSB configuration data in ipa_hardware_config_qsb(), rather
than determining in code what values to use based on IPA version.
Pass configuration data to ipa_hardware_config() so it can be passed
to ipa_hardware_config_qsb().

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_main.c | 73 +++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 45 deletions(-)

diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index d354e3e65ec50..1ce593b46b04c 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -249,53 +249,35 @@ static void ipa_hardware_config_comp(struct ipa *ipa)
 	iowrite32(val, ipa->reg_virt + IPA_REG_COMP_CFG_OFFSET);
 }
 
-/* Configure DDR and PCIe max read/write QSB values */
-static void ipa_hardware_config_qsb(struct ipa *ipa)
+/* Configure DDR and (possibly) PCIe max read/write QSB values */
+static void
+ipa_hardware_config_qsb(struct ipa *ipa, const struct ipa_data *data)
 {
-	enum ipa_version version = ipa->version;
-	u32 max0;
-	u32 max1;
+	const struct ipa_qsb_data *data0;
+	const struct ipa_qsb_data *data1;
 	u32 val;
 
-	/* QMB_0 represents DDR; QMB_1 represents PCIe */
-	val = u32_encode_bits(8, GEN_QMB_0_MAX_WRITES_FMASK);
-	switch (version) {
-	case IPA_VERSION_4_2:
-		max1 = 0;		/* PCIe not present */
-		break;
-	case IPA_VERSION_4_5:
-		max1 = 8;
-		break;
-	default:
-		max1 = 4;
-		break;
-	}
-	val |= u32_encode_bits(max1, GEN_QMB_1_MAX_WRITES_FMASK);
+	/* assert(data->qsb_count > 0); */
+	/* assert(data->qsb_count < 3); */
+
+	/* QMB 0 represents DDR; QMB 1 (if present) represents PCIe */
+	data0 = &data->qsb_data[IPA_QSB_MASTER_DDR];
+	if (data->qsb_count > 1)
+		data1 = &data->qsb_data[IPA_QSB_MASTER_PCIE];
+
+	/* Max outstanding write accesses for QSB masters */
+	val = u32_encode_bits(data0->max_writes, GEN_QMB_0_MAX_WRITES_FMASK);
+	if (data->qsb_count > 1)
+		val |= u32_encode_bits(data1->max_writes,
+				       GEN_QMB_1_MAX_WRITES_FMASK);
 	iowrite32(val, ipa->reg_virt + IPA_REG_QSB_MAX_WRITES_OFFSET);
 
-	max1 = 12;
-	switch (version) {
-	case IPA_VERSION_3_5_1:
-		max0 = 8;
-		break;
-	case IPA_VERSION_4_0:
-	case IPA_VERSION_4_1:
-		max0 = 12;
-		break;
-	case IPA_VERSION_4_2:
-		max0 = 12;
-		max1 = 0;		/* PCIe not present */
-		break;
-	case IPA_VERSION_4_5:
-		max0 = 0;		/* No limit (hardware maximum) */
-		break;
-	}
-	val = u32_encode_bits(max0, GEN_QMB_0_MAX_READS_FMASK);
-	val |= u32_encode_bits(max1, GEN_QMB_1_MAX_READS_FMASK);
-	if (version != IPA_VERSION_3_5_1) {
-		/* GEN_QMB_0_MAX_READS_BEATS is 0 */
-		/* GEN_QMB_1_MAX_READS_BEATS is 0 */
-	}
+	/* Max outstanding read accesses for QSB masters */
+	val = u32_encode_bits(data0->max_reads, GEN_QMB_0_MAX_READS_FMASK);
+	/* GEN_QMB_0_MAX_READS_BEATS is 0 (IPA v4.0 and above) */
+	if (data->qsb_count > 1)
+		val |= u32_encode_bits(data1->max_reads,
+				       GEN_QMB_1_MAX_READS_FMASK);
 	iowrite32(val, ipa->reg_virt + IPA_REG_QSB_MAX_READS_OFFSET);
 }
 
@@ -385,8 +367,9 @@ static void ipa_hardware_dcd_deconfig(struct ipa *ipa)
 /**
  * ipa_hardware_config() - Primitive hardware initialization
  * @ipa:	IPA pointer
+ * @data:	IPA configuration data
  */
-static void ipa_hardware_config(struct ipa *ipa)
+static void ipa_hardware_config(struct ipa *ipa, const struct ipa_data *data)
 {
 	enum ipa_version version = ipa->version;
 	u32 granularity;
@@ -414,7 +397,7 @@ static void ipa_hardware_config(struct ipa *ipa)
 	ipa_hardware_config_comp(ipa);
 
 	/* Configure system bus limits */
-	ipa_hardware_config_qsb(ipa);
+	ipa_hardware_config_qsb(ipa, data);
 
 	if (version < IPA_VERSION_4_5) {
 		/* Configure aggregation timer granularity */
@@ -610,7 +593,7 @@ static int ipa_config(struct ipa *ipa, const struct ipa_data *data)
 	 */
 	ipa_clock_get(ipa);
 
-	ipa_hardware_config(ipa);
+	ipa_hardware_config(ipa, data);
 
 	ret = ipa_endpoint_config(ipa);
 	if (ret)
-- 
2.27.0

