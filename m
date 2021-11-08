Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75395448078
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 14:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240109AbhKHNr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 08:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240083AbhKHNrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 08:47:48 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213D0C061746
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 05:45:04 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id iq11so8146073pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 05:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2SsoXlIEyA7M7oMepGUCAXbufcXq3sSqZoUCUyAHvCU=;
        b=Rh/WDrUBEdWGDRXKQdDay5CItIX8kUAL6HHZo+Hww1b90kKjzsmnbBn76HYmrpHWdB
         sTmCcBcsq0tOjjuXma4yCbzBK+JqFFi/kflvJ71ZFEsWf/RRN0WKrsyjzQxPZI2agQ41
         xnt2De17E5PDNaAHT+M+rAeqd1ZQZ/lr0LDB8eLJ39p35sWpDZW2hM5Bfi28vzcesfuL
         J3KKVqkhJd258VIX4cRJQoRDT5c1rN7OSev/PnHfGI/nFhuNeq5j2arRajVOUpj+KNq9
         xwcH2edrXgALRMnjGlTHbqHPz5iKpEd5mCUjLYWMPLqnn7ZJLduC28Ia9R9pKh+EvgQW
         gYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2SsoXlIEyA7M7oMepGUCAXbufcXq3sSqZoUCUyAHvCU=;
        b=oIq2zOMfNAUM+HfltumREFB/JvIqYk8DAylWv8soNbz5sZJ9B1R2zHhttBqUzQwvuc
         Ptzc32YxbC1i7CcCYEiRm788OyOuffyQUMSamaW2dOaahQ7QSmEVAHDH/xgVzyUJCxOb
         zJXn9eAjZxWajDtFAErxgULRza2Q74U4Wnp7eWzJDssKC7PiQSh/j0Hw7nSD47KFxBl8
         AbVdfHBuNUcT/3WXtKY9tzR4+T3qDG6Gqa02Zd+tsMoGBDaANm4wefW9zHqnLLYt/2wl
         dS3XmJQjy/gxVcYwlE8kQFMRhWEImxoahhtLwKbVH3tT+5EoyNZrf0L8t9ARhdE9/3dY
         RjrA==
X-Gm-Message-State: AOAM530xwvK52NC1mTbdn5AOTJhrW+/HsSY0c35g786kDuGx8q7YQjeS
        5TP9s9EtBoUaVVahoRcN4cpgag==
X-Google-Smtp-Source: ABdhPJzJ13KWDy70wNVqIrlae8ZGm1C9RGa6I9/T0uTLRxiD6Fvr7g3RJZ2By3Zvj3XwBsK3VgvibQ==
X-Received: by 2002:a17:90a:db89:: with SMTP id h9mr51675447pjv.71.1636379103605;
        Mon, 08 Nov 2021 05:45:03 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id m184sm3693974pga.61.2021.11.08.05.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:45:03 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 3/3] soc: qcom: rpmpd: Add QCM2290 support
Date:   Mon,  8 Nov 2021 21:44:42 +0800
Message-Id: <20211108134442.30051-4-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211108134442.30051-1-shawn.guo@linaro.org>
References: <20211108134442.30051-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCM2290 has the same RPM power domains as SM6115.  Add QCM2290
support by reusing SM6115 power domains.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/soc/qcom/rpmpd.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index 3e7905854eb9..36b2381039e6 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -395,6 +395,23 @@ static const struct rpmpd_desc sm6115_desc = {
 	.max_state = RPM_SMD_LEVEL_TURBO_NO_CPR,
 };
 
+static struct rpmpd *qcm2290_rpmpds[] = {
+	[QCM2290_VDDCX] = &sm6115_vddcx,
+	[QCM2290_VDDCX_AO] = &sm6115_vddcx_ao,
+	[QCM2290_VDDCX_VFL] = &sm6115_vddcx_vfl,
+	[QCM2290_VDDMX] = &sm6115_vddmx,
+	[QCM2290_VDDMX_AO] = &sm6115_vddmx_ao,
+	[QCM2290_VDDMX_VFL] = &sm6115_vddmx_vfl,
+	[QCM2290_VDD_LPI_CX] = &sm6115_vdd_lpi_cx,
+	[QCM2290_VDD_LPI_MX] = &sm6115_vdd_lpi_mx,
+};
+
+static const struct rpmpd_desc qcm2290_desc = {
+	.rpmpds = qcm2290_rpmpds,
+	.num_pds = ARRAY_SIZE(qcm2290_rpmpds),
+	.max_state = RPM_SMD_LEVEL_TURBO_NO_CPR,
+};
+
 static const struct of_device_id rpmpd_match_table[] = {
 	{ .compatible = "qcom,mdm9607-rpmpd", .data = &mdm9607_desc },
 	{ .compatible = "qcom,msm8916-rpmpd", .data = &msm8916_desc },
@@ -404,6 +421,7 @@ static const struct of_device_id rpmpd_match_table[] = {
 	{ .compatible = "qcom,msm8994-rpmpd", .data = &msm8994_desc },
 	{ .compatible = "qcom,msm8996-rpmpd", .data = &msm8996_desc },
 	{ .compatible = "qcom,msm8998-rpmpd", .data = &msm8998_desc },
+	{ .compatible = "qcom,qcm2290-rpmpd", .data = &qcm2290_desc },
 	{ .compatible = "qcom,qcs404-rpmpd", .data = &qcs404_desc },
 	{ .compatible = "qcom,sdm660-rpmpd", .data = &sdm660_desc },
 	{ .compatible = "qcom,sm6115-rpmpd", .data = &sm6115_desc },
-- 
2.17.1

