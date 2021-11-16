Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2B145312F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 12:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbhKPLvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 06:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235482AbhKPLuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 06:50:40 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1330C061764
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 03:47:41 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso1693047wmr.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 03:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NY/9dxs1i7rzBFDDSa3S8h83sIZhyo69SFWrCR0SPuA=;
        b=WUl8g/+E00PsKiG7QBlLCp/qM10iKn0xkuoPHdydZnmVP4G+cAH22m9NrBNEE1hkcy
         cm/pC00h9jtMnUFIs+vlZxOaJa5glJo8poeYFfERL/Ez89kRXUr3C2aXqBmTNQFd+Pyb
         LOy6DgLPIhgfocWcBiVbZSEd8Zf/tZyY4ekYm3FFMwoDbuVl202kQt20oYNYb8571Dk/
         VkR3or1rPpknP5JsnC1UkvQFabxcPJynKB7diA0uaGAoEyILH4V2S3Zuhsmk9unGYPUd
         CfvTsfmidvWDbq2ugBH6wOi8gyqp4Dq6kIIYSo0rU+IKlU+RvMmNNHcG38WJy9006fn6
         wpRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NY/9dxs1i7rzBFDDSa3S8h83sIZhyo69SFWrCR0SPuA=;
        b=Sbaol7L3Vo431DdoGEZcHyaWdvpSjPHZEkWhD76MIJvsVZ13G4vPIPN/+u3hh6bQY7
         iwVZMUKPg+B7TjySyjM9x/x4/yNxNL8f/JB6hdOVgM0wcEcSJYog5fAHIk+vkgLQfeK7
         KikOB4iYC3Y83615x2h+OFpBeY4KdLWP0IfeqKHlkVZKXLt4KELn6XvKcaRFIkANNosA
         jnnBhmT7Ex1CvplnBU4u66EmG3CTIEO8Ts/sRMZsJmNfv2ufzuadPjSy2AZobm2rufOC
         si+mPR8N1tb4lTFQiexE4McGD0phKn1pm8lTSXmnYqN+243tWPWeD32oa0cZXIWwsJdM
         tD8w==
X-Gm-Message-State: AOAM533EErtWBqZ4wGOnU9Nma4uCq7VpYqrjcWlky6+xCp2eTbnFffnO
        pHgaY+MYTl1UrOm9INmGkmSQqA==
X-Google-Smtp-Source: ABdhPJxHibETHkgJR8cvzZpEuoIqQBlFDRYkoc9Cd58qbXLnYG8VSTdBdDMml5cXJUXlbjxz/+zWRg==
X-Received: by 2002:a7b:c7cd:: with SMTP id z13mr65615271wmk.172.1637063260576;
        Tue, 16 Nov 2021 03:47:40 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id l8sm2260523wmc.40.2021.11.16.03.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 03:47:40 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/5] ASoC: qdsp6: qdsp6: q6prm: handle clk disable correctly
Date:   Tue, 16 Nov 2021 11:47:17 +0000
Message-Id: <20211116114721.12517-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20211116114721.12517-1-srinivas.kandagatla@linaro.org>
References: <20211116114721.12517-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q6PRM clks need to be disabled using PRM_CMD_RELEASE_HW_RSC dsp command
rather then using PRM_CMD_RSP_REQUEST_HW_RSC cmd with rate set to zero.

DSP will throw errors if we try to disable the clock using existing code.

Fix this by properly handling the clk release.

Fixes: 9a0e5d6fb16f ("ASoC: qdsp6: audioreach: add q6prm support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/audioreach.h |  4 +++
 sound/soc/qcom/qdsp6/q6prm.c      | 53 +++++++++++++++++++++++++++++--
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/audioreach.h b/sound/soc/qcom/qdsp6/audioreach.h
index 4f693a2660b5..3ee8bfcd0121 100644
--- a/sound/soc/qcom/qdsp6/audioreach.h
+++ b/sound/soc/qcom/qdsp6/audioreach.h
@@ -550,6 +550,10 @@ struct audio_hw_clk_cfg {
 	uint32_t clock_root;
 } __packed;
 
+struct audio_hw_clk_rel_cfg {
+	uint32_t clock_id;
+} __packed;
+
 #define PARAM_ID_HW_EP_POWER_MODE_CFG	0x8001176
 #define AR_HW_EP_POWER_MODE_0	0 /* default */
 #define AR_HW_EP_POWER_MODE_1	1 /* XO Shutdown allowed */
diff --git a/sound/soc/qcom/qdsp6/q6prm.c b/sound/soc/qcom/qdsp6/q6prm.c
index 82c40f2d4e1d..cda33ded29be 100644
--- a/sound/soc/qcom/qdsp6/q6prm.c
+++ b/sound/soc/qcom/qdsp6/q6prm.c
@@ -42,6 +42,12 @@ struct prm_cmd_request_rsc {
 	struct audio_hw_clk_cfg clock_id;
 } __packed;
 
+struct prm_cmd_release_rsc {
+	struct apm_module_param_data param_data;
+	uint32_t num_clk_id;
+	struct audio_hw_clk_rel_cfg clock_id;
+} __packed;
+
 static int q6prm_send_cmd_sync(struct q6prm *prm, struct gpr_pkt *pkt, uint32_t rsp_opcode)
 {
 	return audioreach_send_cmd_sync(prm->dev, prm->gdev, &prm->result, &prm->lock,
@@ -102,8 +108,8 @@ int q6prm_unvote_lpass_core_hw(struct device *dev, uint32_t hw_block_id, uint32_
 }
 EXPORT_SYMBOL_GPL(q6prm_unvote_lpass_core_hw);
 
-int q6prm_set_lpass_clock(struct device *dev, int clk_id, int clk_attr, int clk_root,
-			  unsigned int freq)
+static int q6prm_request_lpass_clock(struct device *dev, int clk_id, int clk_attr, int clk_root,
+				     unsigned int freq)
 {
 	struct q6prm *prm = dev_get_drvdata(dev->parent);
 	struct apm_module_param_data *param_data;
@@ -138,6 +144,49 @@ int q6prm_set_lpass_clock(struct device *dev, int clk_id, int clk_attr, int clk_
 
 	return rc;
 }
+
+static int q6prm_release_lpass_clock(struct device *dev, int clk_id, int clk_attr, int clk_root,
+			  unsigned int freq)
+{
+	struct q6prm *prm = dev_get_drvdata(dev->parent);
+	struct apm_module_param_data *param_data;
+	struct prm_cmd_release_rsc *rel;
+	gpr_device_t *gdev = prm->gdev;
+	struct gpr_pkt *pkt;
+	int rc;
+
+	pkt = audioreach_alloc_cmd_pkt(sizeof(*rel), PRM_CMD_RELEASE_HW_RSC, 0, gdev->svc.id,
+				       GPR_PRM_MODULE_IID);
+	if (IS_ERR(pkt))
+		return PTR_ERR(pkt);
+
+	rel = (void *)pkt + GPR_HDR_SIZE + APM_CMD_HDR_SIZE;
+
+	param_data = &rel->param_data;
+
+	param_data->module_instance_id = GPR_PRM_MODULE_IID;
+	param_data->error_code = 0;
+	param_data->param_id = PARAM_ID_RSC_AUDIO_HW_CLK;
+	param_data->param_size = sizeof(*rel) - APM_MODULE_PARAM_DATA_SIZE;
+
+	rel->num_clk_id = 1;
+	rel->clock_id.clock_id = clk_id;
+
+	rc = q6prm_send_cmd_sync(prm, pkt, PRM_CMD_RSP_RELEASE_HW_RSC);
+
+	kfree(pkt);
+
+	return rc;
+}
+
+int q6prm_set_lpass_clock(struct device *dev, int clk_id, int clk_attr, int clk_root,
+			  unsigned int freq)
+{
+	if (freq)
+		return q6prm_request_lpass_clock(dev, clk_id, clk_attr, clk_attr, freq);
+
+	return q6prm_release_lpass_clock(dev, clk_id, clk_attr, clk_attr, freq);
+}
 EXPORT_SYMBOL_GPL(q6prm_set_lpass_clock);
 
 static int prm_callback(struct gpr_resp_pkt *data, void *priv, int op)
-- 
2.21.0

