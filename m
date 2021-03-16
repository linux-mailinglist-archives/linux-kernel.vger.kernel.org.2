Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBCED33DA66
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 18:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbhCPRNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 13:13:23 -0400
Received: from m42-2.mailgun.net ([69.72.42.2]:20923 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238679AbhCPRNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 13:13:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615914794; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=TQTBRIJj8Bo5J118t2/zBRZB9UcCbCThJruh4BKjMdM=; b=hAsUpU50wWbfXz30vhOygad2HV1WytnUuDnb6W8VoMlcEB5UCxdfF8nNGd98/jUSV3NsuFd5
 gYL0n6q0Vw/2Yz7SpHAj89KxhuCL2xCH4+tdBABVD7db/FevWPYh8utib7DAJhnc8xcBPYVx
 rV7Z4CbX7ckmgEaQTcxf9qFeC9E=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 6050e718e2200c0a0dff5002 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 16 Mar 2021 17:12:56
 GMT
Sender: khsieh=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BF9CFC43462; Tue, 16 Mar 2021 17:12:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from khsieh-linux1.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: khsieh)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5E59BC433C6;
        Tue, 16 Mar 2021 17:12:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5E59BC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=khsieh@codeaurora.org
From:   Kuogee Hsieh <khsieh@codeaurora.org>
To:     robdclark@gmail.com, sean@poorly.run, swboyd@chromium.org,
        vkoul@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org
Cc:     tanmay@codeaurora.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, khsieh@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] phy: qcom-qmp: add hbr3_hbr2 voltage and premphasis swing table
Date:   Tue, 16 Mar 2021 10:12:41 -0700
Message-Id: <1615914761-12300-1-git-send-email-khsieh@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hbr3_hbr2 voltage and premphasis swing table to support
HBR3 link rate.

Changes in V2:
-- replaced upper case with lower case at hbr3_hbr2 table

Changes in v3:
-- replace space with tab at hbr3_hbr2 table

Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 0939a9e..6aaa59c 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -2965,6 +2965,20 @@ static void qcom_qmp_phy_dp_aux_init(struct qmp_phy *qphy)
 	       qphy->pcs + QSERDES_V3_DP_PHY_AUX_INTERRUPT_MASK);
 }
 
+static const u8 qmp_dp_v3_pre_emphasis_hbr3_hbr2[4][4] = {
+	{ 0x00, 0x0c, 0x15, 0x1a },
+	{ 0x02, 0x0e, 0x16, 0xff },
+	{ 0x02, 0x11, 0xff, 0xff },
+	{ 0x04, 0xff, 0xff, 0xff }
+};
+
+static const u8 qmp_dp_v3_voltage_swing_hbr3_hbr2[4][4] = {
+	{ 0x02, 0x12, 0x16, 0x1a },
+	{ 0x09, 0x19, 0x1f, 0xff },
+	{ 0x10, 0x1f, 0xff, 0xff },
+	{ 0x1f, 0xff, 0xff, 0xff }
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

