Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A920411027
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 09:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhITHhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 03:37:39 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:61700 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhITHhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 03:37:38 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632123372; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=fdRUVtLB4jhQL95fW23aZmzrLGXO4OMaKMk6xck4L5A=; b=Ce/V91KawXJw0soe8qnT+bSDcBQEqRv8VAPwb8GOThW3AcwV63AM3+b2wTJRqadgof2KQtsr
 zWPEZ3WqhKU9PhVm2qLuncEmwzQ+9sOLIZGcoUx1E6dRxwPtDSHdogpqLGEyNtfGeoesHB7L
 vnQ0p9ttJNcEI+jOsG5X3o5vGoY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 614839eabd6681d8ed790121 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 20 Sep 2021 07:36:10
 GMT
Sender: srivasam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BD685C4360C; Mon, 20 Sep 2021 07:36:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from hu-srivasam-hyd.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srivasam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AF20AC43460;
        Mon, 20 Sep 2021 07:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org AF20AC43460
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
Cc:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        Venkata Prasad Potturu <potturu@codeaurora.org>
Subject: [PATCH 3/7] ASoC: codecs: tx-macro: Change mic control registers to volatile
Date:   Mon, 20 Sep 2021 13:05:27 +0530
Message-Id: <1632123331-2425-4-git-send-email-srivasam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1632123331-2425-1-git-send-email-srivasam@codeaurora.org>
References: <1632123331-2425-1-git-send-email-srivasam@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update amic and dmic related tx macro control registers to volatile

Fixes: c39667ddcfc5 (ASoC: codecs: lpass-tx-macro: add support for lpass tx macro)

Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
---
 sound/soc/codecs/lpass-tx-macro.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index 9273724..e65b592 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -423,6 +423,13 @@ static bool tx_is_volatile_register(struct device *dev, unsigned int reg)
 	case CDC_TX_TOP_CSR_SWR_DMIC1_CTL:
 	case CDC_TX_TOP_CSR_SWR_DMIC2_CTL:
 	case CDC_TX_TOP_CSR_SWR_DMIC3_CTL:
+	case CDC_TX_TOP_CSR_SWR_AMIC0_CTL:
+	case CDC_TX_TOP_CSR_SWR_AMIC1_CTL:
+	case CDC_TX_CLK_RST_CTRL_MCLK_CONTROL:
+	case CDC_TX_CLK_RST_CTRL_FS_CNT_CONTROL:
+	case CDC_TX_CLK_RST_CTRL_SWR_CONTROL:
+	case CDC_TX_TOP_CSR_SWR_CTRL:
+	case CDC_TX0_TX_PATH_SEC7:
 		return true;
 	}
 	return false;
@@ -1674,6 +1681,12 @@ static int tx_macro_component_probe(struct snd_soc_component *comp)
 
 	snd_soc_component_update_bits(comp, CDC_TX0_TX_PATH_SEC7, 0x3F,
 				      0x0A);
+	snd_soc_component_update_bits(comp, CDC_TX_TOP_CSR_SWR_AMIC0_CTL, 0xFF, 0x00);
+	snd_soc_component_update_bits(comp, CDC_TX_TOP_CSR_SWR_AMIC1_CTL, 0xFF, 0x00);
+	snd_soc_component_update_bits(comp, CDC_TX_TOP_CSR_SWR_DMIC0_CTL, 0xFF, 0x00);
+	snd_soc_component_update_bits(comp, CDC_TX_TOP_CSR_SWR_DMIC1_CTL, 0xFF, 0x00);
+	snd_soc_component_update_bits(comp, CDC_TX_TOP_CSR_SWR_DMIC2_CTL, 0xFF, 0x00);
+	snd_soc_component_update_bits(comp, CDC_TX_TOP_CSR_SWR_DMIC3_CTL, 0xFF, 0x00);
 
 	return 0;
 }
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

