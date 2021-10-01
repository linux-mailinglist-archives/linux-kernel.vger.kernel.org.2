Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6644041F35F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 19:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355443AbhJARoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 13:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354300AbhJARoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 13:44:02 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11188C0613E4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 10:42:18 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id y201so12365556oie.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 10:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fHZ78g5puTcAagNMTBHlfiD9Kb8rN2BoNZJ9C5Btpns=;
        b=vZl6euf7vMDgy/HfZaLxtxe6MvUas1MczCtWiJT8KkHgnHTjRL3SCeemb1hOwETRn6
         qoVlhSc5gsYa/fGKsaKFcNyW4AASsVLTYW80xhIdGqDTptv9CYVfktclQTOtAen5zT5I
         li+hHfHNuRduBoqpkPJgmmeyI8Kv6QgDY9rIFCA0OZwKpLdh3Pi/rYletrVRKH4LttT1
         PwgJzBl2lYDfCPhNbuZ84zmW+ic25rv+ETfLMxqnr/00oKpJ7mTAJrASEhmlvUiFw+6f
         uG6gL8Xkbir3FSTXO1sAQ26j3D3iXEQRSsXt/BVZC+70wgUa9LrNYQcRuAfngwMdNO98
         1zBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fHZ78g5puTcAagNMTBHlfiD9Kb8rN2BoNZJ9C5Btpns=;
        b=Q0iWYnniVI0fMSd/XcvBhhQmW0UzHX1bRA8oloXL6t9h8zzFp/yg2gQ7CxNFIyFL2u
         O1n/YAjT0TMVyNsMazV6+v7Y5qAfFEVQSof0K2b1JoM/HQWNvA7JcsLFlpcoKJJDtpnv
         BmQiDNrGrRiLB29xJMnCbfhOah9j/LNSG57I+tmx1/ZjOPkQNL9OmvHmSsfzIti/x8O3
         /NlnUBroUgr98V+/LIagOAOKrxudrCpJXemZul4x5bkIH5vd+C2CAUkXHOJP6d6KS95P
         1fa+rt86yjriCfIdUin3hunhb3y099g7Ay5bxj3Aleyu3riYMkXMZnmE/U32uowumNia
         KaXw==
X-Gm-Message-State: AOAM532zDa7fnorLj/AfYhb2NXLQVVBgcpuQZssp5wyKQcMw3DwBc+Ww
        LSYJ+GtDGfuaEaqSuYIVA7KxkA==
X-Google-Smtp-Source: ABdhPJyC/KFbJY7zlauhvqndeQmZGDFmEtHszqp6e/F7joBRyjlGnc2UpVYBQKZq2ZclVAXgP6L1sg==
X-Received: by 2002:a05:6808:2128:: with SMTP id r40mr4797532oiw.24.1633110137422;
        Fri, 01 Oct 2021 10:42:17 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id u15sm1369264oon.35.2021.10.01.10.42.16
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
Subject: [PATCH v3 3/5] drm/msm/dp: Refactor ioremap wrapper
Date:   Fri,  1 Oct 2021 10:43:58 -0700
Message-Id: <20211001174400.981707-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211001174400.981707-1-bjorn.andersson@linaro.org>
References: <20211001174400.981707-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to deal with multiple memory ranges in the following commit
change the ioremap wrapper to not poke directly into the dss_io_data
struct.

While at it, devm_ioremap_resource() already prints useful error
messages on failure, so omit the unnecessary prints from the caller.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- Switched to devm_platform_get_and_ioremap_resource()

 drivers/gpu/drm/msm/dp/dp_parser.c | 35 ++++++++++--------------------
 drivers/gpu/drm/msm/dp/dp_parser.h |  2 +-
 2 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_parser.c b/drivers/gpu/drm/msm/dp/dp_parser.c
index c064ced78278..c05ba1990218 100644
--- a/drivers/gpu/drm/msm/dp/dp_parser.c
+++ b/drivers/gpu/drm/msm/dp/dp_parser.c
@@ -19,40 +19,27 @@ static const struct dp_regulator_cfg sdm845_dp_reg_cfg = {
 	},
 };
 
-static int msm_dss_ioremap(struct platform_device *pdev,
-				struct dss_io_data *io_data)
+static void __iomem *dp_ioremap(struct platform_device *pdev, int idx, size_t *len)
 {
-	struct resource *res = NULL;
+	struct resource *res;
+	void __iomem *base;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		DRM_ERROR("%pS->%s: msm_dss_get_res failed\n",
-			__builtin_return_address(0), __func__);
-		return -ENODEV;
-	}
-
-	io_data->len = (u32)resource_size(res);
-	io_data->base = devm_ioremap(&pdev->dev, res->start, io_data->len);
-	if (!io_data->base) {
-		DRM_ERROR("%pS->%s: ioremap failed\n",
-			__builtin_return_address(0), __func__);
-		return -EIO;
-	}
+	base = devm_platform_get_and_ioremap_resource(pdev, idx, &res);
+	if (!IS_ERR(base))
+		*len = resource_size(res);
 
-	return 0;
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
-	}
+	dss->base = dp_ioremap(pdev, 0, &dss->len);
+	if (IS_ERR(dss->base))
+		return PTR_ERR(dss->base);
 
 	io->phy = devm_phy_get(&pdev->dev, "dp");
 	if (IS_ERR(io->phy))
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

