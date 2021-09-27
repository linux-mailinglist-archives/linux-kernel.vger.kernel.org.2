Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A7A419DBF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 20:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbhI0SCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 14:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235900AbhI0SCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 14:02:03 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1533C061604
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 11:00:25 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id h3so18512266pgb.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 11:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1+a7FKoAYL96RPr7QGB+xkOteevSmzHcwGmtuLohIN4=;
        b=b/opL5QdAO5JDtZRjNuLtZQB/wib0usA33ZEHqJAYreIpRU/NtWka3Z1lPgKGBurqF
         qtg47my+uHjW3vpgdrtd9bvjcDcayVvHg0fMWGju5Uwm4LP2FFLetaGlofSo6sL5vi/y
         XNVcsAIuTod4ooj0W5mOYNv54mwVOVVemSZCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1+a7FKoAYL96RPr7QGB+xkOteevSmzHcwGmtuLohIN4=;
        b=5vkl+KUIztSylW1SeYJcoGDPKlCp7vuHHGGQhkwzfunrXmFROW+zaaU4HvAKqRAK3U
         eFspq0+nPY4TpjNNhQK1dyUWW4EPsUkg9/ZHt2CEOp7Zh2Jsp9NYkmE/GMWR7PavW579
         VYHaZmLJbJaJiwdqQwJlv0tynkfpMuyfB7rkfZnd6TCc5+uyR4ws6ksoD6L6Z+64a29y
         bA+iikJwObM/gobAsXzGTferhtT5qukW8MPbxRG2+mreJ2D3xD3iQa0vJFZfhr04UvyJ
         vkIFcssGBj1WkKZkQV3XYRuzm67RBHQXyC+og7x5MBk2uWU2ic8TGDx3YIiJP7rzJj9o
         RB4w==
X-Gm-Message-State: AOAM531NMGU6EKqukMSnZ5lx5+4wH9qVTtdPKiA0tmXRnpvAnB9l4/rX
        n5m1DXjI76vdF4fGZ3YWHCiA1A==
X-Google-Smtp-Source: ABdhPJxq7Y5R55DSsFgb767+FM/jYFg4xB9p3IXsKCB/X5PXOi8QwLfnVvoTDnR7LOJjxiCl1fIfRg==
X-Received: by 2002:a63:8541:: with SMTP id u62mr822463pgd.308.1632765625576;
        Mon, 27 Sep 2021 11:00:25 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:82d7:f099:76bc:7017])
        by smtp.gmail.com with UTF8SMTPSA id b2sm18139527pfr.58.2021.09.27.11.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 11:00:25 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>
Cc:     Thomas Hebb <tommyhebb@gmail.com>, dri-devel@lists.freedesktop.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Sandy Huang <hjc@rock-chips.com>, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 3/3] drm/rockchip: dsi: Disable PLL clock on bind error
Date:   Mon, 27 Sep 2021 10:59:44 -0700
Message-Id: <20210927105928.v2.3.I8bb7a91ecc411d56bc155763faa15f289d7fc074@changeid>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <20210927175944.3381314-1-briannorris@chromium.org>
References: <20210927175944.3381314-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some error handling here noticed in review of other changes.

Reported-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
- New

 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index fa4080176719..0ed13d81fe60 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -943,7 +943,7 @@ static int dw_mipi_dsi_rockchip_bind(struct device *dev,
 	ret = clk_prepare_enable(dsi->grf_clk);
 	if (ret) {
 		DRM_DEV_ERROR(dsi->dev, "Failed to enable grf_clk: %d\n", ret);
-		goto out_pm_runtime;
+		goto out_pll_clk;
 	}
 
 	dw_mipi_dsi_rockchip_config(dsi);
@@ -955,17 +955,19 @@ static int dw_mipi_dsi_rockchip_bind(struct device *dev,
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
 
 	return 0;
 
+out_pll_clk:
+	clk_disable_unprepare(dsi->pllref_clk);
 out_pm_runtime:
 	pm_runtime_put(dsi->dev);
 	if (dsi->slave)
-- 
2.33.0.685.g46640cef36-goog

