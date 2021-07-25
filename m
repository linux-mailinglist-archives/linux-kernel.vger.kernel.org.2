Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900223D4B15
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 05:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbhGYCTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 22:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbhGYCTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 22:19:51 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB1EC0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 20:00:22 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id a19so6766625oiw.6
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 20:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S/k3pA60ouJZ44RuPSvAHC3cHM/2BM3D5bSCGPUdEZs=;
        b=iq0K/p/JvUX/Z/CG55BUou126nQBafLr1kMc5mgq8q/oDBu9G65nyc05mN1gGOrEt4
         3C9jkBsNNznOxbtZe2exQZHfZfdZUOqcXvI1rcX8lfOSpkU+EyjrRtPQ9cNltYylscOs
         +gcjvnrEgrkoR7Owc3YOYhvtQc5LXNd84lVB3nyb/DU89zgtnu2L/Ga6hF8l33QHefLN
         8enENhTX/6A6i8moBkIbRdgGbxXcg3gzqfh1iXxtTX9Mf2IsRhxE8jKfpULoSYC9MPiT
         Q8JbgPUm3+ZGBP4NvxJKBKTdABOm63th9D/3l3rSKci1Qkb5+sFV7qJ0G93ppP8AIp35
         bdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S/k3pA60ouJZ44RuPSvAHC3cHM/2BM3D5bSCGPUdEZs=;
        b=lJrhbrxkej3DsuCjeZYyL/ID+Pk1hYuX9qQGxltb8wZLy2NtwDFEuHP2YYEDRLxXiY
         w3GBfMNJx6DT+Q6yzq/caWjzTFus0lrUP2qdSsdCOmUGwqZnMQBF1zHLedfe9PZQ9SAm
         2l1AuAHlrLKMXv32UcgxWpWppFI02anZCpQPv7DJMyNAQ2v7yfMrzPqeP76shst6f4pL
         MydqzqCoZPv+yNg/08aAU0FBySEFpbeqpVHtFTN0C+3rJmNguj3UMz2FVh9IYSLz8t8A
         tUNv2jjpKp+WIdWY9Mxz2z838ezFlGOf++ryNg9fecDECGi1Dby4R2KAK+qc/JcjW3up
         BPIQ==
X-Gm-Message-State: AOAM5334GxZSiXN1HjKHsH0cc/RhIJ43CzkGIqP0YMnEeTn1hoM0gM5c
        emcxLNH1/ZQcebzlwsswHHj38Q==
X-Google-Smtp-Source: ABdhPJwlJGY5pKXD+dB0PHg5IdDOxBBvz6DMMSWilQtk3xGQY92qcMGuJFoaqIMXzG0EXmwyNb4euw==
X-Received: by 2002:aca:7589:: with SMTP id q131mr12489680oic.76.1627182022100;
        Sat, 24 Jul 2021 20:00:22 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id n202sm3366180oig.10.2021.07.24.20.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 20:00:21 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] interconnect: qcom: osm-l3: Add sc8180x support
Date:   Sat, 24 Jul 2021 19:58:34 -0700
Message-Id: <20210725025834.3941777-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210725025834.3941777-1-bjorn.andersson@linaro.org>
References: <20210725025834.3941777-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Qualcomm SC8180x platform to the OSM L3 driver.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/interconnect/qcom/osm-l3.c  | 18 ++++++++++++++++++
 drivers/interconnect/qcom/sc8180x.h |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
index 695f28789e98..13e41b932567 100644
--- a/drivers/interconnect/qcom/osm-l3.c
+++ b/drivers/interconnect/qcom/osm-l3.c
@@ -15,6 +15,7 @@
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
 
 #include "sc7180.h"
+#include "sc8180x.h"
 #include "sdm845.h"
 #include "sm8150.h"
 #include "sm8250.h"
@@ -113,6 +114,22 @@ static const struct qcom_icc_desc sc7180_icc_osm_l3 = {
 	.reg_perf_state = OSM_REG_PERF_STATE,
 };
 
+DEFINE_QNODE(sc8180x_osm_apps_l3, SC8180X_MASTER_OSM_L3_APPS, 32, SC8180X_SLAVE_OSM_L3);
+DEFINE_QNODE(sc8180x_osm_l3, SC8180X_SLAVE_OSM_L3, 32);
+
+static const struct qcom_icc_node *sc8180x_osm_l3_nodes[] = {
+	[MASTER_OSM_L3_APPS] = &sc8180x_osm_apps_l3,
+	[SLAVE_OSM_L3] = &sc8180x_osm_l3,
+};
+
+static const struct qcom_icc_desc sc8180x_icc_osm_l3 = {
+	.nodes = sc8180x_osm_l3_nodes,
+	.num_nodes = ARRAY_SIZE(sc8180x_osm_l3_nodes),
+	.lut_row_size = OSM_LUT_ROW_SIZE,
+	.reg_freq_lut = OSM_REG_FREQ_LUT,
+	.reg_perf_state = OSM_REG_PERF_STATE,
+};
+
 DEFINE_QNODE(sm8150_osm_apps_l3, SM8150_MASTER_OSM_L3_APPS, 32, SM8150_SLAVE_OSM_L3);
 DEFINE_QNODE(sm8150_osm_l3, SM8150_SLAVE_OSM_L3, 32);
 
@@ -311,6 +328,7 @@ static const struct of_device_id osm_l3_of_match[] = {
 	{ .compatible = "qcom,sc7180-osm-l3", .data = &sc7180_icc_osm_l3 },
 	{ .compatible = "qcom,sdm845-osm-l3", .data = &sdm845_icc_osm_l3 },
 	{ .compatible = "qcom,sm8150-osm-l3", .data = &sm8150_icc_osm_l3 },
+	{ .compatible = "qcom,sc8180x-osm-l3", .data = &sc8180x_icc_osm_l3 },
 	{ .compatible = "qcom,sm8250-epss-l3", .data = &sm8250_icc_epss_l3 },
 	{ }
 };
diff --git a/drivers/interconnect/qcom/sc8180x.h b/drivers/interconnect/qcom/sc8180x.h
index fed2dc2d4acb..e70cf7032f80 100644
--- a/drivers/interconnect/qcom/sc8180x.h
+++ b/drivers/interconnect/qcom/sc8180x.h
@@ -168,5 +168,7 @@
 #define SC8180X_SLAVE_EBI_CH0_DISPLAY		158
 #define SC8180X_SLAVE_MNOC_SF_MEM_NOC_DISPLAY	159
 #define SC8180X_SLAVE_MNOC_HF_MEM_NOC_DISPLAY	160
+#define SC8180X_MASTER_OSM_L3_APPS		161
+#define SC8180X_SLAVE_OSM_L3			162
 
 #endif
-- 
2.29.2

