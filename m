Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24463F7E6D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 00:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbhHYWZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 18:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbhHYWZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 18:25:33 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDEDC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:24:46 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 61-20020a9d0d430000b02903eabfc221a9so999563oti.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J4aVSShQAfZChFaza0fhmy7POKfSYqt3Cdubgt9SAys=;
        b=v3qNOwbSJA3+w3kcVQU3QOduZqgfCs2YUi2A6YoBwiV0cBZMOs1SOa9Lh4a2haY3ui
         WAV0oC2MFNuuUR2iaPPOSVsKJR7D3/J7hFBAa58kLymminvvGeYu7bY3g+sQK4+TTi+5
         YXUXq1jE/ERWbb4ku4oe0JXEoX/IZrAetPHeXqkSaVDGvEiUpdKSsYh6kzy8aBTJkMj8
         pdkjWKLbmjEVmgyYeNX8yqV1+FPPt3iJ4rv/nlrXYE4HCNon8NgZnkjAV2MY0iIYaQvF
         a1JKcfgJHFbaaP7K7D4RSMkzIVsHgloPck40EvaofwYKDa5JuI3PqPa/I8R1NL0leMBH
         YI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J4aVSShQAfZChFaza0fhmy7POKfSYqt3Cdubgt9SAys=;
        b=m+E+mYnjL8XTdNSkZNPY/kWZvUu5tAgOrQKqavRPyhc+NNPRFHS5X67tEfqXtrQrJr
         f1JGqgAqcTgpl8cz1erYCmZCf//GWPxaTJbB1anzPlrl4S5XDaK9EWI4FTQyzkWQ/r6t
         eSVPAHaUhcsQRtaYaRfkbwmoHGaa1WmgHhEgNBhOzUF0o129BlutHLYXEe0NGLW8f1qt
         6j/c7ZzWQXbXDTZJBBin7EApfGPYlWldUtzzEjhfFsgdIBMEHuvstmemh0N15EGzBU+U
         W5lvj3VklK2cOCX1VBV4kRKDhXV6LW+vdgQPtxpU+GPFSeZZbmbjlz4qvP8cg4sJBtc5
         vB1Q==
X-Gm-Message-State: AOAM530uVDxl+pwXgfCcEIaV4JVVHh+20XH2kfUNV3J7KfYglAYRKIWf
        i29RbsZ/MHOtt9pewK8UhIWoQw==
X-Google-Smtp-Source: ABdhPJzKbgtqbZCY9eWF+8ml5GhKeIcSK/IOgVh66k3pCSPO9Woc12y62Qo0GSYhxdkVAkT/y846/A==
X-Received: by 2002:a05:6830:2470:: with SMTP id x48mr568001otr.103.1629930286341;
        Wed, 25 Aug 2021 15:24:46 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id u19sm263721oiv.28.2021.08.25.15.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 15:24:46 -0700 (PDT)
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
Subject: [PATCH v2 2/5] drm/msm/dp: Use devres for ioremap()
Date:   Wed, 25 Aug 2021 15:25:54 -0700
Message-Id: <20210825222557.1499104-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210825222557.1499104-1-bjorn.andersson@linaro.org>
References: <20210825222557.1499104-1-bjorn.andersson@linaro.org>
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

Changes since v1:
- Picked up R-bs

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

