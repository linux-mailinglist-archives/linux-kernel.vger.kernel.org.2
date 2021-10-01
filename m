Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495E441EBAE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 13:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353810AbhJALYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 07:24:25 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:10941 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353804AbhJALYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 07:24:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633087359; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=40ApUzuvtbwbH4t5Gb3Ts0gs6DJSioSNyNBn2+OJZQc=; b=YoSEUDyZmk84RDTjQhLOZiYMp+FCIuomCOxYWT+qRLVyJ1Dl26qKP7fkMwZLojHpxMu46Tq4
 /tqq2W1GuNDa13GrinGKPxlurWkOngDa3jPNVQR6L/KBWTcnNsUxF53WHnai4AVE6mczPa2G
 6qj67l1L9b/Kj3wn12hin88bTcc=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 6156ef7fa5a9bab6e84cda56 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 01 Oct 2021 11:22:39
 GMT
Sender: srivasam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 81D30C4361B; Fri,  1 Oct 2021 11:22:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from hu-srivasam-hyd.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srivasam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0FADBC4338F;
        Fri,  1 Oct 2021 11:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 0FADBC4338F
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
Subject: [PATCH 8/8] ASoc: qcom: lpass: Add suspend and resume for sc7280 platform
Date:   Fri,  1 Oct 2021 16:51:32 +0530
Message-Id: <1633087292-1378-9-git-send-email-srivasam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1633087292-1378-1-git-send-email-srivasam@codeaurora.org>
References: <1633087292-1378-1-git-send-email-srivasam@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds device suspend and resume callbacks for sc7280 platform driver ops.

Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
---
 sound/soc/qcom/lpass-cpu.c    | 22 ++++++++++++++++++++++
 sound/soc/qcom/lpass-sc7280.c |  2 ++
 sound/soc/qcom/lpass.h        |  2 ++
 3 files changed, 26 insertions(+)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index c8dec52..5aa5630 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -1307,6 +1307,28 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(asoc_qcom_lpass_cpu_platform_probe);
 
+int asoc_qcom_lpass_cpu_platform_resume(struct platform_device *pdev)
+{
+	struct lpass_data *drvdata = platform_get_drvdata(pdev);
+
+	if (drvdata->variant->init)
+		drvdata->variant->init(pdev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(asoc_qcom_lpass_cpu_platform_resume);
+
+int asoc_qcom_lpass_cpu_platform_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct lpass_data *drvdata = platform_get_drvdata(pdev);
+
+	if (drvdata->variant->exit)
+		drvdata->variant->exit(pdev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(asoc_qcom_lpass_cpu_platform_suspend);
+
 int asoc_qcom_lpass_cpu_platform_remove(struct platform_device *pdev)
 {
 	struct lpass_data *drvdata = platform_get_drvdata(pdev);
diff --git a/sound/soc/qcom/lpass-sc7280.c b/sound/soc/qcom/lpass-sc7280.c
index 983a61b..6fdf111 100644
--- a/sound/soc/qcom/lpass-sc7280.c
+++ b/sound/soc/qcom/lpass-sc7280.c
@@ -591,6 +591,8 @@ static struct platform_driver sc7280_lpass_cpu_platform_driver = {
 	.probe = asoc_qcom_lpass_cpu_platform_probe,
 	.remove = asoc_qcom_lpass_cpu_platform_remove,
 	.shutdown = asoc_qcom_lpass_cpu_platform_shutdown,
+	.resume = asoc_qcom_lpass_cpu_platform_resume,
+	.suspend = asoc_qcom_lpass_cpu_platform_suspend,
 };
 
 module_platform_driver(sc7280_lpass_cpu_platform_driver);
diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
index e0ea698..53d9b5d 100644
--- a/sound/soc/qcom/lpass.h
+++ b/sound/soc/qcom/lpass.h
@@ -419,5 +419,7 @@ extern const struct snd_soc_dai_ops asoc_qcom_lpass_cpu_dai_ops;
 int lpass_cpu_pcm_new(struct snd_soc_pcm_runtime *rtd,
 				struct snd_soc_dai *dai);
 extern const struct snd_soc_dai_ops asoc_qcom_lpass_wcd_dai_ops;
+int asoc_qcom_lpass_cpu_platform_suspend(struct platform_device *pdev, pm_message_t state);
+int asoc_qcom_lpass_cpu_platform_resume(struct platform_device *pdev);
 
 #endif /* __LPASS_H__ */
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

