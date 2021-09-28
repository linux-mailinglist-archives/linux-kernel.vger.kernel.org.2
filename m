Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31E241B96A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 23:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242984AbhI1Vh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 17:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242971AbhI1Vhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 17:37:54 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA9EC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:36:12 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id k23so84381pji.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1LNSqUpNDlXbVZHt+Lb7O7KY/KMDbp0tDoKUCa6MfgQ=;
        b=BSP9s5A6HNs96Xx3gqzT+DHPRVUCnZ4QKZEF4NOnGWm0ur51PvnoX9wbs02LwzNzwQ
         ul1lq7z8w8PFSB7SbjCJH01zZU7Hv604HAD2e1CjM1A/DQG+YJQVbteLvOHVwYSQw9UH
         TCehEAZQTlJrOdXrob7IQA9eZy1fITvLTASSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1LNSqUpNDlXbVZHt+Lb7O7KY/KMDbp0tDoKUCa6MfgQ=;
        b=wD8/iGu11xcFKGDT+JegjdUFUbEW8/olaS05z/XAeMSlLz1IKAFWghya8h23+FZhKf
         WJu/x4pouN2FMYdSje3Qnp/7p7OXKh3yNfE2B/7eds6vHsR21nciCzrrD23NPS8rKSt7
         y7t4e5lIIA/iUo+RLCELoFNaYXA8ViL47jqtqzh/hec/+j7UNTV7Od+nqjCkVmW3iGcP
         /ecdiIu0Cbq3BCLD9rft0JapAORLwfasKifVdMAdqWBomGdLn9rVmHiaXPzKTXwEsid9
         UjqaT+Hbt0+wwGy5DXQ5AxaFRuEiiosh062OddDBkbU3xkyAi8P9RiDzN54+2qLFV5mY
         Rtiw==
X-Gm-Message-State: AOAM532Hygi3zKY7RN3TQamUi0ij9/UDGG5R6M4H4w86nUApNKnfVqoe
        Qqo4g3usyiDS+9uNX76jIHdTRQ==
X-Google-Smtp-Source: ABdhPJxjbWSkdJdJzilKLHeRp1lHIcZWzW4YtepNGEvc8VW+u0wUL7tQbw8C+0nidF1DgUI3HUWpyw==
X-Received: by 2002:a17:90b:1d12:: with SMTP id on18mr2316906pjb.180.1632864972431;
        Tue, 28 Sep 2021 14:36:12 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:d7ca:580:94ab:8af8])
        by smtp.gmail.com with UTF8SMTPSA id i24sm76520pjl.8.2021.09.28.14.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 14:36:11 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org,
        Sandy Huang <hjc@rock-chips.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Thomas Hebb <tommyhebb@gmail.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v3 4/4] drm/rockchip: dsi: Disable PLL clock on bind error
Date:   Tue, 28 Sep 2021 14:35:52 -0700
Message-Id: <20210928143413.v3.4.I8bb7a91ecc411d56bc155763faa15f289d7fc074@changeid>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <20210928213552.1001939-1-briannorris@chromium.org>
References: <20210928213552.1001939-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some error handling here noticed in review of other changes.

Fixes: 2d4f7bdafd70 ("drm/rockchip: dsi: migrate to use dw-mipi-dsi bridge driver")
Signed-off-by: Brian Norris <briannorris@chromium.org>
Reported-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---

Changes in v3:
- Add Fixes, Reviewed-by

Changes in v2:
- New

 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index 8ea852880d1c..59c3d8ef6bf9 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -945,7 +945,7 @@ static int dw_mipi_dsi_rockchip_bind(struct device *dev,
 	ret = clk_prepare_enable(dsi->grf_clk);
 	if (ret) {
 		DRM_DEV_ERROR(dsi->dev, "Failed to enable grf_clk: %d\n", ret);
-		goto out_pm_runtime;
+		goto out_pll_clk;
 	}
 
 	dw_mipi_dsi_rockchip_config(dsi);
@@ -957,19 +957,21 @@ static int dw_mipi_dsi_rockchip_bind(struct device *dev,
 	ret = rockchip_dsi_drm_create_encoder(dsi, drm_dev);
 	if (ret) {
 		DRM_DEV_ERROR(dev, "Failed to create drm encoder\n");
-		goto out_pm_runtime;
+		goto out_pll_clk;
 	}
 
 	ret = dw_mipi_dsi_bind(dsi->dmd, &dsi->encoder);
 	if (ret) {
 		DRM_DEV_ERROR(dev, "Failed to bind: %d\n", ret);
-		goto out_pm_runtime;
+		goto out_pll_clk;
 	}
 
 	dsi->dsi_bound = true;
 
 	return 0;
 
+out_pll_clk:
+	clk_disable_unprepare(dsi->pllref_clk);
 out_pm_runtime:
 	pm_runtime_put(dsi->dev);
 	if (dsi->slave)
-- 
2.33.0.685.g46640cef36-goog

