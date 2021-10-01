Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F9B41F365
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 19:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355463AbhJARoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 13:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354604AbhJARoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 13:44:02 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036AFC0613E3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 10:42:17 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id r43-20020a05683044ab00b0054716b40005so12445598otv.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 10:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=59j+ppAnA3GClcXblCq4bc27uTFd0Elka2ulfgZ16K8=;
        b=u5XSprnyphaZ98shNU0AoIBqdCI1ygik1nxlbMerLiJIsEVY11mKu96UI+E1IOBzR7
         j+UJ8Z9zJ3xW4GJ65NOAKnPIgoqTfkBC5hjEshfh7HRybbwkasu+Cy0KmQ/TfUtqiz5w
         U6D+z/5AOFRPkg5zZvlFV9rJ8JCNio+Lv6odBMisd3hbzMf5icTI4dc+OXTRTl50LMm4
         C+7v2NBNanKQS4tqi+vZbZnHs3tNQGYmmKjbcrcIecn/aNTB07lvs80vBtBNBPBQ/UlF
         yjKJN7/6ga40co2OOOpIbJxrkO2dnhdvcy6aCAh+fv3T4z0/38RtmMneHMjnxr7LV16u
         Z3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=59j+ppAnA3GClcXblCq4bc27uTFd0Elka2ulfgZ16K8=;
        b=GpYMQnHNjo1HT7cQhZ6FmXFto+Gh3khmD3Xcwrmz+7ybObhjMF6eyhyTtZP0W61IUZ
         O+B7ehJcBJ76f/jBEnC/i9JivJrDFRRhG5VxIIDf5DTfJMpQSez2oWaHg90h+mh+wHmL
         r1D+cH4ZM9IaxyUtHIa2pD2LEZu5n4bYVJ8ODRLk6t52n+eYcBpWrGMoIip8DzCREOo6
         aSseKQX2QlnlQvmy9oZZeV7hHSJ28jCRJdiPrx+/uROtfwJWz4EPUht24Au2Nwys8RYJ
         fDhfjTCmgcTyc4UBs+rUTBHdKz12Tyjlvc5WRljT4VfwaZgo4D06NYAl+Ng3+JDv0Twt
         2E0g==
X-Gm-Message-State: AOAM531fQLFPxmMq75QEDQqv7orpnxH+G6Lfje73WfAKce3bbRPqZrlp
        5BO+GA51RWF4JYfCO+JuNtAiKQ==
X-Google-Smtp-Source: ABdhPJyuD9dTkDpl1caAxTajSERBBi4xtihxbClz3LCfV4+vrp8RPWUmh7M1riNl7I06YKIlHrESTA==
X-Received: by 2002:a9d:411e:: with SMTP id o30mr11481720ote.97.1633110136352;
        Fri, 01 Oct 2021 10:42:16 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id u15sm1369264oon.35.2021.10.01.10.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 10:42:16 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>
Cc:     Kuogee Hsieh <khsieh@codeaurora.org>,
        Tanmay Shah <tanmay@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] drm/msm/dp: Use devres for ioremap()
Date:   Fri,  1 Oct 2021 10:43:57 -0700
Message-Id: <20211001174400.981707-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211001174400.981707-1-bjorn.andersson@linaro.org>
References: <20211001174400.981707-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The non-devres version of ioremap is used, which requires manual
cleanup. But the code paths leading here is mixed with other devres
users, so rely on this for ioremap as well to simplify the code.

Reviewed-by: Abhinav Kumar <abhinavk@codeaurora.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- None

 drivers/gpu/drm/msm/dp/dp_parser.c | 29 ++++-------------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_parser.c b/drivers/gpu/drm/msm/dp/dp_parser.c
index 0519dd3ac3c3..c064ced78278 100644
--- a/drivers/gpu/drm/msm/dp/dp_parser.c
+++ b/drivers/gpu/drm/msm/dp/dp_parser.c
@@ -32,7 +32,7 @@ static int msm_dss_ioremap(struct platform_device *pdev,
 	}
 
 	io_data->len = (u32)resource_size(res);
-	io_data->base = ioremap(res->start, io_data->len);
+	io_data->base = devm_ioremap(&pdev->dev, res->start, io_data->len);
 	if (!io_data->base) {
 		DRM_ERROR("%pS->%s: ioremap failed\n",
 			__builtin_return_address(0), __func__);
@@ -42,22 +42,6 @@ static int msm_dss_ioremap(struct platform_device *pdev,
 	return 0;
 }
 
-static void msm_dss_iounmap(struct dss_io_data *io_data)
-{
-	if (io_data->base) {
-		iounmap(io_data->base);
-		io_data->base = NULL;
-	}
-	io_data->len = 0;
-}
-
-static void dp_parser_unmap_io_resources(struct dp_parser *parser)
-{
-	struct dp_io *io = &parser->io;
-
-	msm_dss_iounmap(&io->dp_controller);
-}
-
 static int dp_parser_ctrl_res(struct dp_parser *parser)
 {
 	int rc = 0;
@@ -67,19 +51,14 @@ static int dp_parser_ctrl_res(struct dp_parser *parser)
 	rc = msm_dss_ioremap(pdev, &io->dp_controller);
 	if (rc) {
 		DRM_ERROR("unable to remap dp io resources, rc=%d\n", rc);
-		goto err;
+		return rc;
 	}
 
 	io->phy = devm_phy_get(&pdev->dev, "dp");
-	if (IS_ERR(io->phy)) {
-		rc = PTR_ERR(io->phy);
-		goto err;
-	}
+	if (IS_ERR(io->phy))
+		return PTR_ERR(io->phy);
 
 	return 0;
-err:
-	dp_parser_unmap_io_resources(parser);
-	return rc;
 }
 
 static int dp_parser_misc(struct dp_parser *parser)
-- 
2.29.2

