Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4152434BDA8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 19:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhC1Rb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 13:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbhC1RbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 13:31:18 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEC8C061762
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 10:31:17 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id w2so8880101ilj.12
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 10:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yyjEhsQuVjegTsG/OXDUJjA1PIxhUXIU8zVC7etU+X0=;
        b=h1J2y671XUWPpHh2PmZjX9zHbeVkUYvf8upgjPoUelpAZlVqDoIsYt5L3BI5wYCQdz
         Wi+lt3hcbrSwJFuvgMivsfKGnuLaSrQO9NfO5n5eQl0gg2SdY+a8sRiTxvX0ihCAZBM8
         GI8WUSqJfUqhl5jYYt/dZNZe0q98lX94PH1WYEHz58pBpukwft8mTMTwgJANXSoDGStx
         2Gia7IMNu2zdpIu0AHyp3Wk8SYhw1BlukyCt9OGf6iO4436EUeETvo2cwzpYvMBCiTux
         FUVgDGoH+6Ba/+WliXHMZRrVT8PnNqvD8nzn//KZF8aflArtkoE0SQTXHJzuq1yFPg1V
         LWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yyjEhsQuVjegTsG/OXDUJjA1PIxhUXIU8zVC7etU+X0=;
        b=CeksEKOySrdHW4sBZ9TqAqIjLc3Ivgk3Xp8m1LjUKuvaso30Zo+KqhREtalUXyVZs+
         smNdMz82Dp8PNwof1U/oB0cih2GG/IlTtUeiuMgKf5397DkpIhwZADuSnYvJFvmkkGWl
         mjvM8VA+JO6XoDje1LmG0BUAYg6gJ66vso7DyxWBCUh7LdpNAEWSDW+AWbVJ+Zq6mS8e
         WaqDDgIVEqFeGea4h7829dK6UPfawHTpORH+t/rUJzEtzJiY2LlRD8ShwpWyk+LZg5wX
         jWPcnqo5wSAleHwTIZnfOFb1l0Gj4hxOWEHBodwg24yU+ZMsJElfevqKQrEy1l+eZ5hi
         1lLw==
X-Gm-Message-State: AOAM53371JnO+VjPOr6N32FuA/kqf59T7RJVG5gvLduS6+8KxeQgg0XO
        OhBttYC4YQvvLZePKSoEXAA7BQ==
X-Google-Smtp-Source: ABdhPJx6zO3Swo3aEdhbM+ZrhXsg7NRS0mzzHaOts59Je66blBBxoSSokzrzxf4vc9mihZ4ZFTLCTw==
X-Received: by 2002:a05:6e02:15c6:: with SMTP id q6mr17677389ilu.17.1616952677326;
        Sun, 28 Mar 2021 10:31:17 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id d22sm8014422iof.48.2021.03.28.10.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 10:31:17 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/7] net: ipa: store BCR register values in config data
Date:   Sun, 28 Mar 2021 12:31:06 -0500
Message-Id: <20210328173111.3399063-3-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210328173111.3399063-1-elder@linaro.org>
References: <20210328173111.3399063-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The backward compatibility register value is a platform-specific
property that is not stored in the platform data.  Create a data
field where this can be represented, and get rid ipa_reg_bcr_val().

This register is not present starting with IPA v4.5.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_data-sc7180.c |  1 +
 drivers/net/ipa/ipa_data-sdm845.c |  5 +++++
 drivers/net/ipa/ipa_data.h        |  2 ++
 drivers/net/ipa/ipa_main.c        |  4 ++--
 drivers/net/ipa/ipa_reg.h         | 21 ---------------------
 5 files changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ipa/ipa_data-sc7180.c b/drivers/net/ipa/ipa_data-sc7180.c
index c9b6a6aaadacc..810c673be56ee 100644
--- a/drivers/net/ipa/ipa_data-sc7180.c
+++ b/drivers/net/ipa/ipa_data-sc7180.c
@@ -349,6 +349,7 @@ static const struct ipa_clock_data ipa_clock_data = {
 /* Configuration data for the SC7180 SoC. */
 const struct ipa_data ipa_data_sc7180 = {
 	.version	= IPA_VERSION_4_2,
+	/* backward_compat value is 0 */
 	.qsb_count	= ARRAY_SIZE(ipa_qsb_data),
 	.qsb_data	= ipa_qsb_data,
 	.endpoint_count	= ARRAY_SIZE(ipa_gsi_endpoint_data),
diff --git a/drivers/net/ipa/ipa_data-sdm845.c b/drivers/net/ipa/ipa_data-sdm845.c
index e14e3fb1d9700..49a18b1047c58 100644
--- a/drivers/net/ipa/ipa_data-sdm845.c
+++ b/drivers/net/ipa/ipa_data-sdm845.c
@@ -397,6 +397,11 @@ static const struct ipa_clock_data ipa_clock_data = {
 /* Configuration data for the SDM845 SoC. */
 const struct ipa_data ipa_data_sdm845 = {
 	.version	= IPA_VERSION_3_5_1,
+	.backward_compat = BCR_CMDQ_L_LACK_ONE_ENTRY_FMASK |
+			   BCR_TX_NOT_USING_BRESP_FMASK |
+			   BCR_SUSPEND_L2_IRQ_FMASK |
+			   BCR_HOLB_DROP_L2_IRQ_FMASK |
+			   BCR_DUAL_TX_FMASK,
 	.qsb_count	= ARRAY_SIZE(ipa_qsb_data),
 	.qsb_data	= ipa_qsb_data,
 	.endpoint_count	= ARRAY_SIZE(ipa_gsi_endpoint_data),
diff --git a/drivers/net/ipa/ipa_data.h b/drivers/net/ipa/ipa_data.h
index ea8f99286228e..843d818f78e18 100644
--- a/drivers/net/ipa/ipa_data.h
+++ b/drivers/net/ipa/ipa_data.h
@@ -279,6 +279,7 @@ struct ipa_clock_data {
 /**
  * struct ipa_data - combined IPA/GSI configuration data
  * @version:		IPA hardware version
+ * @backward_compat:	BCR register value (prior to IPA v4.5 only)
  * @qsb_count:		number of entries in the qsb_data array
  * @qsb_data:		Qualcomm System Bus configuration data
  * @endpoint_count:	number of entries in the endpoint_data array
@@ -289,6 +290,7 @@ struct ipa_clock_data {
  */
 struct ipa_data {
 	enum ipa_version version;
+	u32 backward_compat;
 	u32 qsb_count;		/* number of entries in qsb_data[] */
 	const struct ipa_qsb_data *qsb_data;
 	u32 endpoint_count;	/* number of entries in endpoint_data[] */
diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index e18029152d780..afb8eb5618f73 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -397,9 +397,9 @@ static void ipa_hardware_config(struct ipa *ipa, const struct ipa_data *data)
 	u32 granularity;
 	u32 val;
 
-	/* IPA v4.5 has no backward compatibility register */
+	/* IPA v4.5+ has no backward compatibility register */
 	if (version < IPA_VERSION_4_5) {
-		val = ipa_reg_bcr_val(version);
+		val = data->backward_compat;
 		iowrite32(val, ipa->reg_virt + IPA_REG_BCR_OFFSET);
 	}
 
diff --git a/drivers/net/ipa/ipa_reg.h b/drivers/net/ipa/ipa_reg.h
index de2a944bad86b..286ea9634c49d 100644
--- a/drivers/net/ipa/ipa_reg.h
+++ b/drivers/net/ipa/ipa_reg.h
@@ -235,27 +235,6 @@ static inline u32 ipa_reg_state_aggr_active_offset(enum ipa_version version)
 #define BCR_FILTER_PREFETCH_EN_FMASK		GENMASK(8, 8)
 #define BCR_ROUTER_PREFETCH_EN_FMASK		GENMASK(9, 9)
 
-/* Backward compatibility register value to use for each version */
-static inline u32 ipa_reg_bcr_val(enum ipa_version version)
-{
-	if (version == IPA_VERSION_3_5_1)
-		return BCR_CMDQ_L_LACK_ONE_ENTRY_FMASK |
-			BCR_TX_NOT_USING_BRESP_FMASK |
-			BCR_SUSPEND_L2_IRQ_FMASK |
-			BCR_HOLB_DROP_L2_IRQ_FMASK |
-			BCR_DUAL_TX_FMASK;
-
-	if (version == IPA_VERSION_4_0 || version == IPA_VERSION_4_1)
-		return BCR_CMDQ_L_LACK_ONE_ENTRY_FMASK |
-			BCR_SUSPEND_L2_IRQ_FMASK |
-			BCR_HOLB_DROP_L2_IRQ_FMASK |
-			BCR_DUAL_TX_FMASK;
-
-	/* assert(version != IPA_VERSION_4_5); */
-
-	return 0x00000000;
-}
-
 /* The value of the next register must be a multiple of 8 (bottom 3 bits 0) */
 #define IPA_REG_LOCAL_PKT_PROC_CNTXT_OFFSET		0x000001e8
 
-- 
2.27.0

