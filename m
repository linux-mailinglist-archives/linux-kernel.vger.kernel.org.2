Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8074F401C47
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 15:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242451AbhIFN3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 09:29:24 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:13907 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242546AbhIFN3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 09:29:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630934898; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=gbdk/z9NV8rR1PUFsj2YfEYQF1fJd5KmOvl99jbC3Lg=; b=CwO8kUz/i7ykJkweezu9hf1zstJP6SYygqJX5Btm4uP47i/yekoDdhH/lexsnj+apyk9gQGa
 wX5h7KYbHyemvvgSuwL1Hjvik6CJt4HZ0eR86aIIMU0RSD+GWLi/OIqDaUmSk19FDiYRY5Rc
 mp+ALTeiOaisNsbALy0vhUIdnc0=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 6136175c6fc2cf7ad9e9326d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 06 Sep 2021 13:27:56
 GMT
Sender: srivasam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 564AFC4361A; Mon,  6 Sep 2021 13:27:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from hu-srivasam-hyd.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srivasam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 34764C4338F;
        Mon,  6 Sep 2021 13:27:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 34764C4338F
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
Subject: [PATCH] ASoC: dt-bindings: lpass: add binding headers for digital codecs
Date:   Mon,  6 Sep 2021 18:57:34 +0530
Message-Id: <1630934854-14086-1-git-send-email-srivasam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add header defining for lpass internal digital codecs rx,tx and va
dai node id's.

Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
---
 include/dt-bindings/sound/qcom,lpass.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/dt-bindings/sound/qcom,lpass.h b/include/dt-bindings/sound/qcom,lpass.h
index 7b0b80b..187af45 100644
--- a/include/dt-bindings/sound/qcom,lpass.h
+++ b/include/dt-bindings/sound/qcom,lpass.h
@@ -10,6 +10,11 @@
 
 #define LPASS_DP_RX	5
 
+#define LPASS_CDC_DMA_RX0 6
+#define LPASS_CDC_DMA_TX3 7
+#define LPASS_CDC_DMA_VA0 8
+#define LPASS_MAX_PORTS 9
+
 #define LPASS_MCLK0	0
 
 #endif /* __DT_QCOM_LPASS_H */
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

