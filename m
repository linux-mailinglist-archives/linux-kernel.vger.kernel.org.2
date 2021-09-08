Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6DA403B26
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 16:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348156AbhIHOFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 10:05:34 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:19707 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235455AbhIHOF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 10:05:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631109860; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=7eNx0fhwCSF+xb+ymgZCfriGvUaN9NPGimpmZv0IsVw=; b=ZOKR4Uy3poIO5vv+tP88zxoOx6Rz2hoj7gi3hVLJxxVF0fdeVCDk7A1qA0Fs7D+rNdC2aqvb
 9HQJjV2UNAwwZ0xiOhHcWGvR7NvDBXFehnTou7FWIoqKUgllc1efj5S2Li8aJXHDBeljc67I
 Cg9+oWqr1DXxTTZnuvaHnv+DjSU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 6138c2dfd15f4d68a266ef05 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 08 Sep 2021 14:04:15
 GMT
Sender: srivasam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1F548C4361C; Wed,  8 Sep 2021 14:04:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from hu-srivasam-hyd.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srivasam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A0060C4338F;
        Wed,  8 Sep 2021 14:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org A0060C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, rohitkr@codeaurora.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org
Cc:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Subject: [PATCH v2] ASoC: dt-bindings: lpass: add binding headers for digital codecs
Date:   Wed,  8 Sep 2021 19:33:51 +0530
Message-Id: <1631109831-1360-1-git-send-email-srivasam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add header defining for lpass internal digital codecs rx,tx and va
dai node id's.

Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
---
Changes since v1:
    -- Add missing dai node ID's

 include/dt-bindings/sound/qcom,lpass.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/dt-bindings/sound/qcom,lpass.h b/include/dt-bindings/sound/qcom,lpass.h
index 7b0b80b..a9404c3 100644
--- a/include/dt-bindings/sound/qcom,lpass.h
+++ b/include/dt-bindings/sound/qcom,lpass.h
@@ -10,6 +10,37 @@
 
 #define LPASS_DP_RX	5
 
+#define LPASS_CDC_DMA_RX0 6
+#define LPASS_CDC_DMA_RX1 7
+#define LPASS_CDC_DMA_RX2 8
+#define LPASS_CDC_DMA_RX3 9
+#define LPASS_CDC_DMA_RX4 10
+#define LPASS_CDC_DMA_RX5 11
+#define LPASS_CDC_DMA_RX6 12
+#define LPASS_CDC_DMA_RX7 13
+#define LPASS_CDC_DMA_RX8 14
+#define LPASS_CDC_DMA_RX9 15
+
+#define LPASS_CDC_DMA_TX0 16
+#define LPASS_CDC_DMA_TX1 17
+#define LPASS_CDC_DMA_TX2 18
+#define LPASS_CDC_DMA_TX3 19
+#define LPASS_CDC_DMA_TX4 20
+#define LPASS_CDC_DMA_TX5 21
+#define LPASS_CDC_DMA_TX6 22
+#define LPASS_CDC_DMA_TX7 23
+#define LPASS_CDC_DMA_TX8 24
+
+#define LPASS_CDC_DMA_VA_TX0 25
+#define LPASS_CDC_DMA_VA_TX1 26
+#define LPASS_CDC_DMA_VA_TX2 27
+#define LPASS_CDC_DMA_VA_TX3 28
+#define LPASS_CDC_DMA_VA_TX4 29
+#define LPASS_CDC_DMA_VA_TX5 30
+#define LPASS_CDC_DMA_VA_TX6 31
+#define LPASS_CDC_DMA_VA_TX7 32
+#define LPASS_CDC_DMA_VA_TX8 33
+
 #define LPASS_MCLK0	0
 
 #endif /* __DT_QCOM_LPASS_H */
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

