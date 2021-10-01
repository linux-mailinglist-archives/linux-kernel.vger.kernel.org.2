Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2982A41F367
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 19:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355456AbhJARoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 13:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355424AbhJARoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 13:44:04 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FEEC06177D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 10:42:20 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 5-20020a9d0685000000b0054706d7b8e5so12471745otx.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 10:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RuDmOgPfw7NqoydBG9DQd34tvaItfS8ZKq0v6QDg/FY=;
        b=XLFHevB6WrVgB1k383+Eu2L6o1qbyh58b6SA8R/5BAw8TC7lyqv5IHXHTh7gCmKLsD
         JtQJBcH+5/FlXZLnaln8on35bnRb9B7YlTtjle+vzTyxT191syLSAlrcBtl/HONyMZ5L
         OjhVF911PC8tk7jBqUUWTHpKZ2JcO4pvyNFhhZFz66ffzBIJdteqYwJbMYHqHhgrBR5/
         mINS3p9w6Jerb7cqf9Q6f2tv6/iw0CxHxcDrldyOOyDlZfSqqEDcgp/SjJV2EvHNzoD8
         Fn2r1P+gRCnNtt6UB9Edv2Guq8nw48v+1tcem18VUIAqkCcywLDGzRjzLEEBavkmiOaq
         j97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RuDmOgPfw7NqoydBG9DQd34tvaItfS8ZKq0v6QDg/FY=;
        b=zeBNIFbvkNnGsEXvRvCsrgbxdh3toVGhZJv76ydJwUyaC4dY2GAdRl522LcwfPqT6f
         Nbqigtofa/4mZiN9CUwGcIvpWZ/dqRVU0z1F2OPnJW5T1FPy9G2lYnieevtH9aDOvECC
         FdTszNlwx8bCXxtW8xNZgcP0ECZgvDeR8QKBwBRm4g9NJNTdTxKwuyNBJHGSlkZrOuFG
         /tW0s8/rKxsBG8xkKMsaRe1GTVC2osYLCNFw770R1mj/S1/mpystglLAGyilr1bT06ko
         fg2tJ/dxjxXr4a+dbY+PhJzFLGpiF62o2biRHKb+hlmusYvD+PjhdFUWl/yOdJ8T4RUN
         iRJg==
X-Gm-Message-State: AOAM533e/R3EDisqud1hnFZjV2h2ti/KUaeyELXBmtBgtDZLhstJOd4u
        qrVZvFJtZ+6EN6mq1yJjx4t0ag==
X-Google-Smtp-Source: ABdhPJws9faHBQvlTIfIFjLeXXFXgk7jiuKKfBY2CwB4kFziy9psiZ97T1gAtt89z7WID9l5hdsO1Q==
X-Received: by 2002:a05:6830:310c:: with SMTP id b12mr11691000ots.193.1633110139673;
        Fri, 01 Oct 2021 10:42:19 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id u15sm1369264oon.35.2021.10.01.10.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 10:42:19 -0700 (PDT)
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
Subject: [PATCH v3 5/5] drm/msm/dp: Allow sub-regions to be specified in DT
Date:   Fri,  1 Oct 2021 10:44:00 -0700
Message-Id: <20211001174400.981707-6-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211001174400.981707-1-bjorn.andersson@linaro.org>
References: <20211001174400.981707-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all platforms has P0 at an offset of 0x1000 from the base address,
so add support for specifying each sub-region in DT. The code falls back
to the predefined offsets in the case that only a single reg is
specified, in order to support existing DT.

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Abhinav Kumar <abhinavk@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- None

 drivers/gpu/drm/msm/dp/dp_parser.c | 49 +++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_parser.c b/drivers/gpu/drm/msm/dp/dp_parser.c
index 1f084b2b5bd3..4d6e047f803d 100644
--- a/drivers/gpu/drm/msm/dp/dp_parser.c
+++ b/drivers/gpu/drm/msm/dp/dp_parser.c
@@ -50,18 +50,45 @@ static int dp_parser_ctrl_res(struct dp_parser *parser)
 	if (IS_ERR(dss->ahb.base))
 		return PTR_ERR(dss->ahb.base);
 
-	if (dss->ahb.len < DP_DEFAULT_P0_OFFSET + DP_DEFAULT_P0_SIZE) {
-		DRM_ERROR("legacy memory region not large enough\n");
-		return -EINVAL;
-	}
+	dss->aux.base = dp_ioremap(pdev, 1, &dss->aux.len);
+	if (IS_ERR(dss->aux.base)) {
+		/*
+		 * The initial binding had a single reg, but in order to
+		 * support variation in the sub-region sizes this was split.
+		 * dp_ioremap() will fail with -ENODEV here if only a single
+		 * reg is specified, so fill in the sub-region offsets and
+		 * lengths based on this single region.
+		 */
+		if (PTR_ERR(dss->aux.base) == -ENODEV) {
+			if (dss->ahb.len < DP_DEFAULT_P0_OFFSET + DP_DEFAULT_P0_SIZE) {
+				DRM_ERROR("legacy memory region not large enough\n");
+				return -EINVAL;
+			}
+
+			dss->ahb.len = DP_DEFAULT_AHB_SIZE;
+			dss->aux.base = dss->ahb.base + DP_DEFAULT_AUX_OFFSET;
+			dss->aux.len = DP_DEFAULT_AUX_SIZE;
+			dss->link.base = dss->ahb.base + DP_DEFAULT_LINK_OFFSET;
+			dss->link.len = DP_DEFAULT_LINK_SIZE;
+			dss->p0.base = dss->ahb.base + DP_DEFAULT_P0_OFFSET;
+			dss->p0.len = DP_DEFAULT_P0_SIZE;
+		} else {
+			DRM_ERROR("unable to remap aux region: %pe\n", dss->aux.base);
+			return PTR_ERR(dss->aux.base);
+		}
+	} else {
+		dss->link.base = dp_ioremap(pdev, 2, &dss->link.len);
+		if (IS_ERR(dss->link.base)) {
+			DRM_ERROR("unable to remap link region: %pe\n", dss->link.base);
+			return PTR_ERR(dss->link.base);
+		}
 
-	dss->ahb.len = DP_DEFAULT_AHB_SIZE;
-	dss->aux.base = dss->ahb.base + DP_DEFAULT_AUX_OFFSET;
-	dss->aux.len = DP_DEFAULT_AUX_SIZE;
-	dss->link.base = dss->ahb.base + DP_DEFAULT_LINK_OFFSET;
-	dss->link.len = DP_DEFAULT_LINK_SIZE;
-	dss->p0.base = dss->ahb.base + DP_DEFAULT_P0_OFFSET;
-	dss->p0.len = DP_DEFAULT_P0_SIZE;
+		dss->p0.base = dp_ioremap(pdev, 3, &dss->p0.len);
+		if (IS_ERR(dss->p0.base)) {
+			DRM_ERROR("unable to remap p0 region: %pe\n", dss->p0.base);
+			return PTR_ERR(dss->p0.base);
+		}
+	}
 
 	io->phy = devm_phy_get(&pdev->dev, "dp");
 	if (IS_ERR(io->phy))
-- 
2.29.2

