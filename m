Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4E93C879A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 17:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239941AbhGNPe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 11:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239788AbhGNPeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 11:34:09 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9783EC061765
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 08:31:17 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id i94so3746716wri.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 08:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Lp0zZwDjM0o67Qr8IPD9fZg8MpkDEKyh4GA3N2Mu00=;
        b=LiBvy+mqpa9juYGqFMgrRvy5qkizs2Cp8TjMp41i3uDErqMjPTy02avYokshjxleW6
         bc1hwBPPYIsfV7pBtWCoifHgQ9FfYoUO9hOq0l8TJo1HQt6OLIla5X1ML3tpEgt5BcO6
         sSjVsVgBrpyBXn1mEIC6umg5vFMMYI2b5+3gX6BWw9YW26HcONQruouX0g8FTfeeXx/6
         VY8TWQYizMW/apMc0EjejQ9rpreX5Y606+0mEus2tAg2M13x0xZsplXFX/VcgWZCN0iX
         7SCDdx/Prl/ngUI36WoeotLi+1Npj2/9pMlwmnVrVW8q5v9+sW6+zgAIafvkW/QXFCFf
         8kLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Lp0zZwDjM0o67Qr8IPD9fZg8MpkDEKyh4GA3N2Mu00=;
        b=t1y6QgQFuXN9noKsZ02nuoILrcE85hlpcxYQQGxetNUzIxRBA0MEsrAvlTnODx3MW4
         F+6dXClm/+LGc577lFxyOr/Qij/NSLIGjEmI41gkUE1s2u+7XqZwJMNPbLYXD48f+TeW
         3krSubYfCgvgqKKDFhG5BOd24EmwzZRJG1snvw9un8kIM5UIaepW3hdn8ob7MOSWhmp2
         mHZjE4QuB2gsQ45HO2AE3eqCXKPp7FyJmsRuvQghsSg8jVq6wMy8vz/+brKVqexW1cwr
         oHJJqviALAeuOSiR+RObLaFCL3lToAiqGRZX90UgLgOXxV2I4uKpMZoE4gVQUDds0Lyw
         O8TA==
X-Gm-Message-State: AOAM532FylwWPi62orZuA+2OstwdvGy+XfMp0zmnEjD4BqkOugcbYgMW
        D6xodzuDBqsgCWMLHJqeHHD4Gw==
X-Google-Smtp-Source: ABdhPJx/imkJrMeCLBPiFq0W4NwN7lyBr8ae7Q2NqE/UHdM21l0TfgWsssg77d8a1oibt5anw4hltw==
X-Received: by 2002:adf:facf:: with SMTP id a15mr13666345wrs.39.1626276676193;
        Wed, 14 Jul 2021 08:31:16 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id y6sm2465174wma.48.2021.07.14.08.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 08:31:15 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     bjorn.andersson@linaro.org, broonie@kernel.org, robh@kernel.org
Cc:     plai@codeaurora.org, tiwai@suse.de, devicetree@vger.kernel.org,
        perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        bgoswami@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 14/16] ASoC: qcom: audioreach: add volume ctrl module support
Date:   Wed, 14 Jul 2021 16:30:37 +0100
Message-Id: <20210714153039.28373-15-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210714153039.28373-1-srinivas.kandagatla@linaro.org>
References: <20210714153039.28373-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/audioreach/audioreach.c | 34 ++++++++++++++++++++++++++
 sound/soc/qcom/audioreach/audioreach.h |  8 ++++++
 2 files changed, 42 insertions(+)

diff --git a/sound/soc/qcom/audioreach/audioreach.c b/sound/soc/qcom/audioreach/audioreach.c
index 1839d872fd5f..5a50eede4496 100644
--- a/sound/soc/qcom/audioreach/audioreach.c
+++ b/sound/soc/qcom/audioreach/audioreach.c
@@ -928,6 +928,40 @@ static int audioreach_shmem_set_media_format(struct q6apm_graph *graph,
 	return rc;
 }
 
+int audioreach_gain_set_vol_ctrl(struct q6apm *apm, struct audioreach_module
+				 *module, int vol)
+{
+	struct apm_module_param_data *param_data;
+	struct param_id_vol_ctrl_master_gain *cfg;
+	int rc, payload_size;
+	struct gpr_pkt *pkt;
+	void *p;
+
+	payload_size = sizeof(*cfg) + APM_MODULE_PARAM_DATA_SIZE;
+	p = audioreach_alloc_apm_cmd_pkt(payload_size, APM_CMD_SET_CFG, 0);
+	if (IS_ERR(p))
+		return -ENOMEM;
+
+	pkt = p;
+	p = p + GPR_HDR_SIZE + APM_CMD_HDR_SIZE;
+
+	param_data = p;
+	param_data->module_instance_id = module->instance_id;
+	param_data->error_code = 0;
+	param_data->param_id = PARAM_ID_VOL_CTRL_MASTER_GAIN;
+	param_data->param_size = payload_size - APM_MODULE_PARAM_DATA_SIZE;
+
+	p = p + APM_MODULE_PARAM_DATA_SIZE;
+	cfg = p;
+	cfg->master_gain =  vol;
+	rc = q6apm_send_cmd_sync(apm, pkt, 0);
+
+	kfree(pkt);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(audioreach_gain_set_vol_ctrl);
+
 static int audioreach_gain_set(struct q6apm_graph *graph,
 			 struct audioreach_module *module)
 {
diff --git a/sound/soc/qcom/audioreach/audioreach.h b/sound/soc/qcom/audioreach/audioreach.h
index 6279ddc3c5ce..2c6d5f4e66b4 100644
--- a/sound/soc/qcom/audioreach/audioreach.h
+++ b/sound/soc/qcom/audioreach/audioreach.h
@@ -536,6 +536,14 @@ struct param_id_hw_ep_dma_data_align {
 	uint32_t dma_data_align;
 } __packed;
 
+#define PARAM_ID_VOL_CTRL_MASTER_GAIN	0x08001035
+#define VOL_CTRL_DEFAULT_GAIN		0x2000
+struct param_id_vol_ctrl_master_gain {
+	uint16_t master_gain;
+	uint16_t reserved;
+} __packed;
+
+
 /* Graph */
 struct audioreach_connection {
 	/* Connections */
-- 
2.21.0

