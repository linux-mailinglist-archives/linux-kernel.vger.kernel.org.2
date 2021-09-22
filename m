Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D414148E1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 14:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbhIVMd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 08:33:26 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:17160 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235918AbhIVMdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 08:33:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632313915; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=7mD124mhl7RE5jPtSbpO/srSjUzxq/IF4hmJGkNDWLE=; b=JRH9etndnzjQ5iKpW9k3MdPI7Vqenr4HgYpimfQF2/DLHrW9i7u2PaGt9yoi5QeUa4XNqTHw
 6cB5JvjzH4MzHyohpmGtNjkqozeTtD6C4Inhg4ACHuASQ2pl8MOK+y0q5wYR60KrA9BIrW8l
 BiGqJftnrfkN3bcWegntJUK9URI=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 614b2236e0f78151d6db9f23 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 22 Sep 2021 12:31:50
 GMT
Sender: srivasam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 80F4AC4361A; Wed, 22 Sep 2021 12:31:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from hu-srivasam-hyd.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srivasam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C5D66C4361A;
        Wed, 22 Sep 2021 12:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org C5D66C4361A
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
Subject: [PATCH v2 1/5] ASoC: qcom: Add compatible names in va,wsa,rx,tx codec drivers for sc7280
Date:   Wed, 22 Sep 2021 18:01:14 +0530
Message-Id: <1632313878-12089-2-git-send-email-srivasam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1632313878-12089-1-git-send-email-srivasam@codeaurora.org>
References: <agross@kernel.org; bjorn.andersson@linaro.org; lgirdwood@gmail.com; broonie@kernel.org;robh+dt@kernel.org; plai@codeaurora.org; bgoswami@codeaurora.org; perex@perex.cz; tiwai@suse.com;srinivas.kandagatla@linaro.org; rohitkr@codeaurora.org; linux-arm-msm@vger.kernel.org; alsa-devel@alsa-project.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; swboyd@chromium.org; judyhsiao@chromium.org;>
 <1632313878-12089-1-git-send-email-srivasam@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible names for sc7280 based targets in digital codec drivers
va,wsa,rx and tx.

Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
---
 sound/soc/codecs/lpass-rx-macro.c  | 1 +
 sound/soc/codecs/lpass-tx-macro.c  | 1 +
 sound/soc/codecs/lpass-va-macro.c  | 1 +
 sound/soc/codecs/lpass-wsa-macro.c | 1 +
 4 files changed, 4 insertions(+)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index 196b068..c2b9333 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -3577,6 +3577,7 @@ static int rx_macro_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id rx_macro_dt_match[] = {
+	{ .compatible = "qcom,sc7280-lpass-rx-macro" },
 	{ .compatible = "qcom,sm8250-lpass-rx-macro" },
 	{ }
 };
diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index 27a0d5d..5dcae73 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -1843,6 +1843,7 @@ static int tx_macro_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id tx_macro_dt_match[] = {
+	{ .compatible = "qcom,sc7280-lpass-tx-macro" },
 	{ .compatible = "qcom,sm8250-lpass-tx-macro" },
 	{ }
 };
diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
index 56c93f4..70f09b4 100644
--- a/sound/soc/codecs/lpass-va-macro.c
+++ b/sound/soc/codecs/lpass-va-macro.c
@@ -1472,6 +1472,7 @@ static int va_macro_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id va_macro_dt_match[] = {
+	{ .compatible = "qcom,sc7280-lpass-va-macro" },
 	{ .compatible = "qcom,sm8250-lpass-va-macro" },
 	{}
 };
diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index d3ac318..75baf8e 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -2445,6 +2445,7 @@ static int wsa_macro_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id wsa_macro_dt_match[] = {
+	{.compatible = "qcom,sc7280-lpass-wsa-macro"},
 	{.compatible = "qcom,sm8250-lpass-wsa-macro"},
 	{}
 };
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

