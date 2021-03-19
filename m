Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4519E3416DC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 08:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbhCSHsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 03:48:06 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:43829 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbhCSHrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 03:47:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1616140071; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=FvJ5yBLgBQZV8r7U4qSnErjL3cCvpmDZCdhaBipeFLM=; b=nc38c+i2sTTjwgRXK0CSz19YvfFzGlQ4izXLfsjJXk1k5+jd4ihY3ZN8k26X4cIxS/SanItw
 2V9zvpLHkTJ+dm61DiBek4iq4czvc5bwmtiX2Uxy7irVnxNtoeudkVLoeHOXoxuQNUCKkgf0
 iB9kyCJB4VmN26yA2KnBxYR0L+U=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 60545726e2200c0a0dbd98eb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 19 Mar 2021 07:47:50
 GMT
Sender: tdas=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 31872C433ED; Fri, 19 Mar 2021 07:47:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tdas-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 31265C433CA;
        Fri, 19 Mar 2021 07:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 31265C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH] clk: qcom: camcc: Update the clock ops for the SC7180
Date:   Fri, 19 Mar 2021 13:17:34 +0530
Message-Id: <1616140054-5141-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the RCGs to use shared ops to park the RCGs at XO.

Fixes: 15d09e830bbc ("clk: qcom: camcc: Add camera clock controller driver for SC7180")
Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/clk/qcom/camcc-sc7180.c | 50 ++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/clk/qcom/camcc-sc7180.c b/drivers/clk/qcom/camcc-sc7180.c
index dbac565..9bcf2f8 100644
--- a/drivers/clk/qcom/camcc-sc7180.c
+++ b/drivers/clk/qcom/camcc-sc7180.c
@@ -304,7 +304,7 @@ static struct clk_rcg2 cam_cc_bps_clk_src = {
 		.name = "cam_cc_bps_clk_src",
 		.parent_data = cam_cc_parent_data_2,
 		.num_parents = 5,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };

@@ -325,7 +325,7 @@ static struct clk_rcg2 cam_cc_cci_0_clk_src = {
 		.name = "cam_cc_cci_0_clk_src",
 		.parent_data = cam_cc_parent_data_5,
 		.num_parents = 3,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };

@@ -339,7 +339,7 @@ static struct clk_rcg2 cam_cc_cci_1_clk_src = {
 		.name = "cam_cc_cci_1_clk_src",
 		.parent_data = cam_cc_parent_data_5,
 		.num_parents = 3,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };

@@ -360,7 +360,7 @@ static struct clk_rcg2 cam_cc_cphy_rx_clk_src = {
 		.name = "cam_cc_cphy_rx_clk_src",
 		.parent_data = cam_cc_parent_data_3,
 		.num_parents = 6,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };

@@ -379,7 +379,7 @@ static struct clk_rcg2 cam_cc_csi0phytimer_clk_src = {
 		.name = "cam_cc_csi0phytimer_clk_src",
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = 4,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };

@@ -393,7 +393,7 @@ static struct clk_rcg2 cam_cc_csi1phytimer_clk_src = {
 		.name = "cam_cc_csi1phytimer_clk_src",
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = 4,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };

@@ -407,7 +407,7 @@ static struct clk_rcg2 cam_cc_csi2phytimer_clk_src = {
 		.name = "cam_cc_csi2phytimer_clk_src",
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = 4,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };

@@ -421,7 +421,7 @@ static struct clk_rcg2 cam_cc_csi3phytimer_clk_src = {
 		.name = "cam_cc_csi3phytimer_clk_src",
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = 4,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };

@@ -443,7 +443,7 @@ static struct clk_rcg2 cam_cc_fast_ahb_clk_src = {
 		.name = "cam_cc_fast_ahb_clk_src",
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = 4,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };

@@ -466,7 +466,7 @@ static struct clk_rcg2 cam_cc_icp_clk_src = {
 		.name = "cam_cc_icp_clk_src",
 		.parent_data = cam_cc_parent_data_2,
 		.num_parents = 5,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };

@@ -488,7 +488,7 @@ static struct clk_rcg2 cam_cc_ife_0_clk_src = {
 		.name = "cam_cc_ife_0_clk_src",
 		.parent_data = cam_cc_parent_data_4,
 		.num_parents = 4,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };

@@ -510,7 +510,7 @@ static struct clk_rcg2 cam_cc_ife_0_csid_clk_src = {
 		.name = "cam_cc_ife_0_csid_clk_src",
 		.parent_data = cam_cc_parent_data_3,
 		.num_parents = 6,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };

@@ -524,7 +524,7 @@ static struct clk_rcg2 cam_cc_ife_1_clk_src = {
 		.name = "cam_cc_ife_1_clk_src",
 		.parent_data = cam_cc_parent_data_4,
 		.num_parents = 4,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };

@@ -538,7 +538,7 @@ static struct clk_rcg2 cam_cc_ife_1_csid_clk_src = {
 		.name = "cam_cc_ife_1_csid_clk_src",
 		.parent_data = cam_cc_parent_data_3,
 		.num_parents = 6,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };

@@ -553,7 +553,7 @@ static struct clk_rcg2 cam_cc_ife_lite_clk_src = {
 		.parent_data = cam_cc_parent_data_4,
 		.num_parents = 4,
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };

@@ -567,7 +567,7 @@ static struct clk_rcg2 cam_cc_ife_lite_csid_clk_src = {
 		.name = "cam_cc_ife_lite_csid_clk_src",
 		.parent_data = cam_cc_parent_data_3,
 		.num_parents = 6,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };

@@ -590,7 +590,7 @@ static struct clk_rcg2 cam_cc_ipe_0_clk_src = {
 		.name = "cam_cc_ipe_0_clk_src",
 		.parent_data = cam_cc_parent_data_2,
 		.num_parents = 5,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };

@@ -613,7 +613,7 @@ static struct clk_rcg2 cam_cc_jpeg_clk_src = {
 		.name = "cam_cc_jpeg_clk_src",
 		.parent_data = cam_cc_parent_data_2,
 		.num_parents = 5,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };

@@ -635,7 +635,7 @@ static struct clk_rcg2 cam_cc_lrme_clk_src = {
 		.name = "cam_cc_lrme_clk_src",
 		.parent_data = cam_cc_parent_data_6,
 		.num_parents = 5,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };

@@ -656,7 +656,7 @@ static struct clk_rcg2 cam_cc_mclk0_clk_src = {
 		.name = "cam_cc_mclk0_clk_src",
 		.parent_data = cam_cc_parent_data_1,
 		.num_parents = 3,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };

@@ -670,7 +670,7 @@ static struct clk_rcg2 cam_cc_mclk1_clk_src = {
 		.name = "cam_cc_mclk1_clk_src",
 		.parent_data = cam_cc_parent_data_1,
 		.num_parents = 3,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };

@@ -684,7 +684,7 @@ static struct clk_rcg2 cam_cc_mclk2_clk_src = {
 		.name = "cam_cc_mclk2_clk_src",
 		.parent_data = cam_cc_parent_data_1,
 		.num_parents = 3,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };

@@ -698,7 +698,7 @@ static struct clk_rcg2 cam_cc_mclk3_clk_src = {
 		.name = "cam_cc_mclk3_clk_src",
 		.parent_data = cam_cc_parent_data_1,
 		.num_parents = 3,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };

@@ -712,7 +712,7 @@ static struct clk_rcg2 cam_cc_mclk4_clk_src = {
 		.name = "cam_cc_mclk4_clk_src",
 		.parent_data = cam_cc_parent_data_1,
 		.num_parents = 3,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };

@@ -732,7 +732,7 @@ static struct clk_rcg2 cam_cc_slow_ahb_clk_src = {
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = 4,
 		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

