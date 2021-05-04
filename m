Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4670C372A85
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 14:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhEDNAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 09:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhEDNAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 09:00:18 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52171C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 05:59:22 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 82-20020a1c01550000b0290142562ff7c9so1277540wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 05:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8wApOpJhCU9tfgd/Dj9rvLGUlH1ua1FJRVoJ9b+ybUY=;
        b=mSZKtm0qtHgXPjNZf3T0OZd79W0shIJ+8mLIAsRgiJy5fOBwwTgG+2TSjTTD8uC3pS
         /NpdjVstmh8JBPVlnHnyUMBWn+7rC2MibquiBJeYaP/tnSol66mn/xw5jTSs1rUwWLWq
         pKORykqgkqocPNnoZ/qcke2nsEo6rBzf4C6S8ETfAEVfN50eSuKQvM1yDHNYRWewbr8V
         4sy4+qOVCs5qW3/c1Uw78dgzKdavwi3Vlzge+uRdfloyl7hdimORq7CNylSv4vXWpRTm
         H4IVPyu6cXgQINNdE2nEPLuSR4VzQJSdrygVJCfM2yLyvy09ImmU2Z5QV3Ch1JgSpiv3
         MHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8wApOpJhCU9tfgd/Dj9rvLGUlH1ua1FJRVoJ9b+ybUY=;
        b=U7El8d73Ve1NSTxrDNbp1CvMOj7f5SQC8PgwLBivyRRwVHJzu2/qf2vnoERPuYRMuu
         cGtL5U2MoiFBgHAiLZcxErqp94t+4iNVqBb+COVc5KmsynlK4VEgojOr+nsCF0t5BsB3
         j8enYctjuJLLb4mUygTWj2deiekBfDQv9CX62faMR4i2PwcgzwIeoX5CO7J3WTPBCTnR
         mtuTvHrQ5laufL329g4wsHG5AakjcilxUtEz2SGF9gFOavCTnkPxsmdm2pHnaXp4WlaG
         6ydBO8kzE92kRXOq+XiGze/VJ6iBUS+55l8ruueMQnl4p7ljZbmnt4rgwQfts+P3vrBA
         Awmw==
X-Gm-Message-State: AOAM530YFcblcu7eKVUH7NTmREPm+9mMkGv7RSjAIz1y29gOKUH/+OR/
        AKV2z3/mqVnSrp+rWEYcVx7qzw==
X-Google-Smtp-Source: ABdhPJxYrJ5SvegT6/GQLBTJhJ+E6KkApAj5p70zLOSyZs9P4mRlQIFu8+K2HzTCbfng9oSHJJu4Qw==
X-Received: by 2002:a1c:cc0e:: with SMTP id h14mr27637427wmb.4.1620133161053;
        Tue, 04 May 2021 05:59:21 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id a21sm2483055wmj.34.2021.05.04.05.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 05:59:20 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, amit.pundir@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] soundwire: qcom: fix handling of qcom,ports-block-pack-mode
Date:   Tue,  4 May 2021 13:59:09 +0100
Message-Id: <20210504125909.16108-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support to "qcom,ports-block-pack-mode" was added at later stages
to support a variant of Qualcomm SoundWire controllers available
on Apps processor. However the older versions of the SoundWire
controller which are embedded in WCD Codecs do not need this property.

So returning on error for those cases will break boards like DragonBoard
DB845c and Lenovo Yoga C630.

This patch fixes error handling on this property considering older usecases.

Fixes: 5943e4fb14e3 ("soundwire: qcom: check of_property_read status")
Reported-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 2827085a323b..0ef79d60e88e 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -1150,8 +1150,16 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
 
 	ret = of_property_read_u8_array(np, "qcom,ports-block-pack-mode",
 					bp_mode, nports);
-	if (ret)
-		return ret;
+	if (ret) {
+		u32 version;
+
+		ctrl->reg_read(ctrl, SWRM_COMP_HW_VERSION, &version);
+
+		if (version <= 0x01030000)
+			memset(bp_mode, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
+		else
+			return ret;
+	}
 
 	memset(hstart, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
 	of_property_read_u8_array(np, "qcom,ports-hstart", hstart, nports);
-- 
2.21.0

