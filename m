Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4C23D1BFA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 04:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhGVCDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 22:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbhGVCDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 22:03:39 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB763C0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 19:44:14 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id u11so5130662oiv.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 19:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jLfCGQhZ9sWWK6V+miB0xsO475S4ojkH6KbRA6dRnQ4=;
        b=enHglQkCfAeXdX2XT+ADILAHKBjtUZAqEoRhEBxzapVPkQhqIWS4apVqPKtTnx1joi
         DUSrlS4z6vYBIliupHyaFkUYPcxR+vNP+ZTXKQGHizjl1Za4cj0ULDNdh/4QJ6mb04R2
         pWEduzwKUx6sLfFmqgaATyOIG0mu6tz6Q3xLkfRSaJc5YtrouH65Gx5tcTnUxe9HaSoR
         6ZV5KKvwbTZ7Gyl1p9XR70JT+nDqO+JwqJi/XLILzYdQgKS+XsKPhgcb6caDZu/5kcOD
         9/fg43z7lKyi7sw/geLrThpfA9raDy0MbPgbweomzYD4vNs7x6OIMlw8Rw/qJhvsr0h+
         5VVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jLfCGQhZ9sWWK6V+miB0xsO475S4ojkH6KbRA6dRnQ4=;
        b=MtnyfA68Gc0NC2/97ILF8Ta63t67JE33ClzDf16aRQXCeSrAfXJcCFLqe4g1Bk1g64
         ZdwOoDjdNgM8+863y8pNzAWpnZDYqgGm8w9aKtocroB4/NFWCmHVCzO8P6Wyl85bY/iz
         vAW+ivDYQxUH0+5sDHsx5mmW8nZbqBvRhySdTIsPe679TY8vL+JG95FyBn1H9JVhyMW6
         aXH06VRivLQ0PkikFGG0vHQBfYj9dEdIfNyUriPRoOPzkUXGPuFW1E1SLylVvtHLuMVl
         BKFnVvmJAY4FwSV6hyDdhZ5OZv7QEaoZSqfL18OTCte61+YckqQXsy2sgSbRw5kikbds
         SSfw==
X-Gm-Message-State: AOAM533Tighoze4oqMJryCOLI7q4b4mUlBhsZ6flMzWm+u0EvIGIvRWT
        AbXgzpro44GVh0OSf3Gmc4kzWA==
X-Google-Smtp-Source: ABdhPJxv5tX28bUZMIQ2i4FRhBPM5G8KFvgAH21RAfpzAtTS4CaoeIjq0CgLpSyBZVsVug8cKsefIQ==
X-Received: by 2002:aca:1e11:: with SMTP id m17mr4309603oic.104.1626921854077;
        Wed, 21 Jul 2021 19:44:14 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id u18sm5346519oif.9.2021.07.21.19.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 19:44:13 -0700 (PDT)
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
Subject: [PATCH 3/5] drm/msm/dp: Refactor ioremap wrapper
Date:   Wed, 21 Jul 2021 19:42:25 -0700
Message-Id: <20210722024227.3313096-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210722024227.3313096-1-bjorn.andersson@linaro.org>
References: <20210722024227.3313096-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to deal with multiple memory ranges in the following commit
change the ioremap wrapper to not poke directly into the dss_io_data
struct.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_parser.c | 28 ++++++++++++++--------------
 drivers/gpu/drm/msm/dp/dp_parser.h |  2 +-
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_parser.c b/drivers/gpu/drm/msm/dp/dp_parser.c
index c064ced78278..e68dacef547c 100644
--- a/drivers/gpu/drm/msm/dp/dp_parser.c
+++ b/drivers/gpu/drm/msm/dp/dp_parser.c
@@ -19,39 +19,39 @@ static const struct dp_regulator_cfg sdm845_dp_reg_cfg = {
 	},
 };
 
-static int msm_dss_ioremap(struct platform_device *pdev,
-				struct dss_io_data *io_data)
+static void __iomem *dp_ioremap(struct platform_device *pdev, int idx, size_t *len)
 {
 	struct resource *res = NULL;
+	void __iomem *base;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, idx);
 	if (!res) {
 		DRM_ERROR("%pS->%s: msm_dss_get_res failed\n",
 			__builtin_return_address(0), __func__);
-		return -ENODEV;
+		return ERR_PTR(-ENODEV);
 	}
 
-	io_data->len = (u32)resource_size(res);
-	io_data->base = devm_ioremap(&pdev->dev, res->start, io_data->len);
-	if (!io_data->base) {
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (!base) {
 		DRM_ERROR("%pS->%s: ioremap failed\n",
 			__builtin_return_address(0), __func__);
-		return -EIO;
+		return ERR_PTR(-EIO);
 	}
 
-	return 0;
+	*len = resource_size(res);
+	return base;
 }
 
 static int dp_parser_ctrl_res(struct dp_parser *parser)
 {
-	int rc = 0;
 	struct platform_device *pdev = parser->pdev;
 	struct dp_io *io = &parser->io;
+	struct dss_io_data *dss = &io->dp_controller;
 
-	rc = msm_dss_ioremap(pdev, &io->dp_controller);
-	if (rc) {
-		DRM_ERROR("unable to remap dp io resources, rc=%d\n", rc);
-		return rc;
+	dss->base = dp_ioremap(pdev, 0, &dss->len);
+	if (IS_ERR(dss->base)) {
+		DRM_ERROR("unable to remap dp io region: %pe\n", dss->base);
+		return PTR_ERR(dss->base);
 	}
 
 	io->phy = devm_phy_get(&pdev->dev, "dp");
diff --git a/drivers/gpu/drm/msm/dp/dp_parser.h b/drivers/gpu/drm/msm/dp/dp_parser.h
index 34b49628bbaf..dc62e70b1640 100644
--- a/drivers/gpu/drm/msm/dp/dp_parser.h
+++ b/drivers/gpu/drm/msm/dp/dp_parser.h
@@ -26,7 +26,7 @@ enum dp_pm_type {
 };
 
 struct dss_io_data {
-	u32 len;
+	size_t len;
 	void __iomem *base;
 };
 
-- 
2.29.2

