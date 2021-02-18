Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA1C31EF06
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 19:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbhBRSye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 13:54:34 -0500
Received: from z11.mailgun.us ([104.130.96.11]:49616 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231945AbhBRQwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 11:52:17 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613667108; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=6LqVTeB3qkKtgOGKEPy1XFDayXheTUcI36X8Z2+YBLE=; b=n/IGet9e/2dMXtlL/ZJZ+nybMaiUPdbJ4o09R8wkGG2ZRzeaZ/hffZu61A1DuQDUbnaeSKN9
 pSqQ+LquaInk/d+I+aKgZwVH9y/OufZAKn7n0CogppHIHT0/XFEXDOTPTfYmNipI6gFKeAo8
 DZ+iOcZ6gXfXuap2Jy8heWL6Ig0=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 602e9b07ba08663830168ebd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 18 Feb 2021 16:51:19
 GMT
Sender: khsieh=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 87C4DC43464; Thu, 18 Feb 2021 16:51:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from khsieh-linux1.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: khsieh)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2336EC433ED;
        Thu, 18 Feb 2021 16:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2336EC433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=khsieh@codeaurora.org
From:   Kuogee Hsieh <khsieh@codeaurora.org>
To:     robdclark@gmail.com, sean@poorly.run, swboyd@chromium.org,
        vkoul@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org
Cc:     tanmay@codeaurora.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, khsieh@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] phy/qualcomm: add hbr3_hbr2 voltage and premphasis swing table
Date:   Thu, 18 Feb 2021 08:51:10 -0800
Message-Id: <1613667070-27613-1-git-send-email-khsieh@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hbr3_hbr2 voltage and premphasis swing table to support
HBR3 link rate.

Changes in V2:
-- replaced upper case with lower case at hbr3_hbr2 table

Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 0939a9e..4dcc074 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -2965,6 +2965,20 @@ static void qcom_qmp_phy_dp_aux_init(struct qmp_phy *qphy)
 	       qphy->pcs + QSERDES_V3_DP_PHY_AUX_INTERRUPT_MASK);
 }
 
+static const u8 qmp_dp_v3_pre_emphasis_hbr3_hbr2[4][4] = {
+        { 0x00, 0x0c, 0x15, 0x1a },
+        { 0x02, 0x0e, 0x16, 0xff },
+        { 0x02, 0x11, 0xff, 0xff },
+        { 0x04, 0xff, 0xff, 0xff }
+};
+
+static const u8 qmp_dp_v3_voltage_swing_hbr3_hbr2[4][4] = {
+        { 0x02, 0x12, 0x16, 0x1a },
+        { 0x09, 0x19, 0x1f, 0xff },
+        { 0x10, 0x1f, 0xff, 0xff },
+        { 0x1f, 0xff, 0xff, 0xff }
+};
+
 static const u8 qmp_dp_v3_pre_emphasis_hbr_rbr[4][4] = {
 	{ 0x00, 0x0c, 0x14, 0x19 },
 	{ 0x00, 0x0b, 0x12, 0xff },
@@ -3000,8 +3014,13 @@ static void qcom_qmp_phy_configure_dp_tx(struct qmp_phy *qphy)
 		drvr_en = 0x10;
 	}
 
-	voltage_swing_cfg = qmp_dp_v3_voltage_swing_hbr_rbr[v_level][p_level];
-	pre_emphasis_cfg = qmp_dp_v3_pre_emphasis_hbr_rbr[v_level][p_level];
+	if (dp_opts->link_rate <= 2700) {
+		voltage_swing_cfg = qmp_dp_v3_voltage_swing_hbr_rbr[v_level][p_level];
+		pre_emphasis_cfg = qmp_dp_v3_pre_emphasis_hbr_rbr[v_level][p_level];
+	} else {
+		voltage_swing_cfg = qmp_dp_v3_voltage_swing_hbr3_hbr2[v_level][p_level];
+		pre_emphasis_cfg = qmp_dp_v3_pre_emphasis_hbr3_hbr2[v_level][p_level];
+	}
 
 	/* TODO: Move check to config check */
 	if (voltage_swing_cfg == 0xFF && pre_emphasis_cfg == 0xFF)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

