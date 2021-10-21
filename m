Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB78435F69
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 12:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhJUKnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 06:43:51 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:26827 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbhJUKnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 06:43:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634812894; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=oxfZ2u0DtXtulpHkjgD2dEjso9E85yHPTGC3GFzvOwg=; b=FPNRjXAt10r2a2Y+9xdyUeMo3UXMWEi/iP7/me6JRebGjnwBlgpkxHTb45NRt68JdVEbbypN
 rPX8VqCyUGc6MrGgwEMEax/NBrMGgdHeh/WQZo5UpHQf2ghNbBmJbeFbQofq3T8s20A4xijK
 wA/BB4h58ljTThzLOQp7b3a7M/Q=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 617143d9308e0dd330181097 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 21 Oct 2021 10:41:29
 GMT
Sender: okukatla=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A206EC4360D; Thu, 21 Oct 2021 10:41:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from okukatla1-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okukatla)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1D101C43460;
        Thu, 21 Oct 2021 10:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 1D101C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Odelu Kukatla <okukatla@codeaurora.org>
To:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        evgreen@google.com, Andy Gross <agross@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sboyd@kernel.org, mdtipton@codeaurora.org, sibis@codeaurora.org,
        saravanak@google.com, okukatla@codeaurora.org,
        seansw@qti.qualcomm.com, elder@linaro.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: [v8 2/3] interconnect: qcom: Add EPSS L3 support on SC7280
Date:   Thu, 21 Oct 2021 16:10:56 +0530
Message-Id: <1634812857-10676-3-git-send-email-okukatla@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1634812857-10676-1-git-send-email-okukatla@codeaurora.org>
References: <1634812857-10676-1-git-send-email-okukatla@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Epoch Subsystem (EPSS) L3 interconnect provider support on
SC7280 SoCs.

Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
---
 drivers/interconnect/qcom/osm-l3.c | 20 +++++++++++++++++++-
 drivers/interconnect/qcom/sc7280.h |  2 ++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
index c7af143..eec1309 100644
--- a/drivers/interconnect/qcom/osm-l3.c
+++ b/drivers/interconnect/qcom/osm-l3.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
  */
 
 #include <linux/bitfield.h>
@@ -15,6 +15,7 @@
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
 
 #include "sc7180.h"
+#include "sc7280.h"
 #include "sc8180x.h"
 #include "sdm845.h"
 #include "sm8150.h"
@@ -114,6 +115,22 @@ static const struct qcom_osm_l3_desc sc7180_icc_osm_l3 = {
 	.reg_perf_state = OSM_REG_PERF_STATE,
 };
 
+DEFINE_QNODE(sc7280_epss_apps_l3, SC7280_MASTER_EPSS_L3_APPS, 32, SC7280_SLAVE_EPSS_L3);
+DEFINE_QNODE(sc7280_epss_l3, SC7280_SLAVE_EPSS_L3, 32);
+
+static const struct qcom_osm_l3_node *sc7280_epss_l3_nodes[] = {
+	[MASTER_EPSS_L3_APPS] = &sc7280_epss_apps_l3,
+	[SLAVE_EPSS_L3_SHARED] = &sc7280_epss_l3,
+};
+
+static const struct qcom_osm_l3_desc sc7280_icc_epss_l3 = {
+	.nodes = sc7280_epss_l3_nodes,
+	.num_nodes = ARRAY_SIZE(sc7280_epss_l3_nodes),
+	.lut_row_size = EPSS_LUT_ROW_SIZE,
+	.reg_freq_lut = EPSS_REG_FREQ_LUT,
+	.reg_perf_state = EPSS_REG_PERF_STATE,
+};
+
 DEFINE_QNODE(sc8180x_osm_apps_l3, SC8180X_MASTER_OSM_L3_APPS, 32, SC8180X_SLAVE_OSM_L3);
 DEFINE_QNODE(sc8180x_osm_l3, SC8180X_SLAVE_OSM_L3, 32);
 
@@ -326,6 +343,7 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 
 static const struct of_device_id osm_l3_of_match[] = {
 	{ .compatible = "qcom,sc7180-osm-l3", .data = &sc7180_icc_osm_l3 },
+	{ .compatible = "qcom,sc7280-epss-l3", .data = &sc7280_icc_epss_l3 },
 	{ .compatible = "qcom,sdm845-osm-l3", .data = &sdm845_icc_osm_l3 },
 	{ .compatible = "qcom,sm8150-osm-l3", .data = &sm8150_icc_osm_l3 },
 	{ .compatible = "qcom,sc8180x-osm-l3", .data = &sc8180x_icc_osm_l3 },
diff --git a/drivers/interconnect/qcom/sc7280.h b/drivers/interconnect/qcom/sc7280.h
index 175e400..1fb9839 100644
--- a/drivers/interconnect/qcom/sc7280.h
+++ b/drivers/interconnect/qcom/sc7280.h
@@ -150,5 +150,7 @@
 #define SC7280_SLAVE_PCIE_1			139
 #define SC7280_SLAVE_QDSS_STM			140
 #define SC7280_SLAVE_TCU			141
+#define SC7280_MASTER_EPSS_L3_APPS		142
+#define SC7280_SLAVE_EPSS_L3			143
 
 #endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

