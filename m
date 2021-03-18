Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B8A3405BF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 13:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhCRMlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 08:41:11 -0400
Received: from a0.mail.mailgun.net ([198.61.254.59]:52703 "EHLO
        a0.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbhCRMkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 08:40:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1616071247; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=sXAGynqSLidMzR64Daok0xr8LMCoEyfeck8DvZcB7b4=; b=ovwi9Y2MoE5Mz0BQIpPQFEw7+3VhrDj9VYg0YsqSpYWC7eWpDKtStMRatZG2TmVu6SLEoaoU
 BBYKO57qUWA3flKqhLAlsB4X4tWhwVunrSHcsch5MjU7JSexbcCpqD+UKJL88qBZ0G9Ndgnw
 iqHJKTiKVGmI/e6DQoWNAqPERno=
X-Mailgun-Sending-Ip: 198.61.254.59
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 60534a364db3bb68012ff843 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 18 Mar 2021 12:40:22
 GMT
Sender: kgunda=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DA017C433ED; Thu, 18 Mar 2021 12:40:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from kgunda-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kgunda)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AE246C43462;
        Thu, 18 Mar 2021 12:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AE246C43462
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kgunda@codeaurora.org
From:   Kiran Gunda <kgunda@codeaurora.org>
To:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        lee.jones@linaro.org, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, daniel.thompson@linaro.org,
        jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc:     Kiran Gunda <kgunda@codeaurora.org>
Subject: [PATCH V5 2/2] backlight: qcom-wled: Correct the sync_toggle sequence
Date:   Thu, 18 Mar 2021 18:09:40 +0530
Message-Id: <1616071180-24493-3-git-send-email-kgunda@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616071180-24493-1-git-send-email-kgunda@codeaurora.org>
References: <1616071180-24493-1-git-send-email-kgunda@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the current implementation, after FSC (Full Scale Current)
and brightness update the sync bits are set-then-cleared.
But, the FSC and brightness sync takes place when the sync bits are
set (e.g. on a rising edge). So the hardware team recommends a
clear-then-set approach in order to guarantee such a transition
regardless of the previous register state.

Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/video/backlight/qcom-wled.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index e9fbe24..7c02f87 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -337,13 +337,13 @@ static int wled3_sync_toggle(struct wled *wled)
 
 	rc = regmap_update_bits(wled->regmap,
 				wled->sink_addr + WLED3_SINK_REG_SYNC,
-				mask, mask);
+				mask, WLED3_SINK_REG_SYNC_CLEAR);
 	if (rc < 0)
 		return rc;
 
 	rc = regmap_update_bits(wled->regmap,
 				wled->sink_addr + WLED3_SINK_REG_SYNC,
-				mask, WLED3_SINK_REG_SYNC_CLEAR);
+				mask, mask);
 
 	return rc;
 }
@@ -353,17 +353,17 @@ static int wled5_mod_sync_toggle(struct wled *wled)
 	int rc;
 	u8 val;
 
-	val = (wled->cfg.mod_sel == MOD_A) ? WLED5_SINK_REG_SYNC_MOD_A_BIT :
-					     WLED5_SINK_REG_SYNC_MOD_B_BIT;
 	rc = regmap_update_bits(wled->regmap,
 				wled->sink_addr + WLED5_SINK_REG_MOD_SYNC_BIT,
-				WLED5_SINK_REG_SYNC_MASK, val);
+				WLED5_SINK_REG_SYNC_MASK, 0);
 	if (rc < 0)
 		return rc;
 
+	val = (wled->cfg.mod_sel == MOD_A) ? WLED5_SINK_REG_SYNC_MOD_A_BIT :
+					     WLED5_SINK_REG_SYNC_MOD_B_BIT;
 	return regmap_update_bits(wled->regmap,
 				  wled->sink_addr + WLED5_SINK_REG_MOD_SYNC_BIT,
-				  WLED5_SINK_REG_SYNC_MASK, 0);
+				  WLED5_SINK_REG_SYNC_MASK, val);
 }
 
 static int wled_ovp_fault_status(struct wled *wled, bool *fault_set)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
 a Linux Foundation Collaborative Project

