Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20FC141B967
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 23:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242981AbhI1Vhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 17:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242950AbhI1Vhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 17:37:48 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7659C061745
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:36:08 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id y5so54885pll.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BvF8KK2WJfnodz32WDGFF00fES1dwKaygVo7KmPDeNE=;
        b=ltFqLngXnk/KSMYdiA5CGoaX3k59QOKwxat6vmMM2pAWH6+Q3LJfk/6+VxFg0c/qkN
         Md9QPCNWyFB+kKVl5PNqk6rmOS7Cjm8Jep3xZyUhAElR1CELLhltrMCBtmakLZiFaoVU
         ZujTXQJAJyz1kPLYxSlCuHd6sqVv4xme2WaWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BvF8KK2WJfnodz32WDGFF00fES1dwKaygVo7KmPDeNE=;
        b=w6hBdeQzqBmBy5lLITfIjdpFVDlcOig6NooYOE0At+yYDQdAoWnFwvutzerk7OiS/Y
         vD8FSGM9S6XOGsqNGNvP+K1TJHDa2IlYKYj6aEzk42bgNmbgcqulu6dPLMEw6sz+dQER
         EEHnRcUQ9FCbW5U0I/jQ6EeZ79JIgCi5SfMv41KLc/O4Dem/+3M7mDJ+cV5AAuOr3s3S
         jiCOoqK/43wme8LRRjbA7D9XYqsD3WRZ8XPoi6Q+WhfUu3hO0UQ1jTYjxSWKNhSn00Jn
         ibsmjQ8qBy3GKaYBfEl3lr8l/4TNN7tRr9CQR/RA/Xn9sxkdYkabsg4T1SOmia7yPweg
         sPWg==
X-Gm-Message-State: AOAM5302ogficH4S2vxNpjPH+P+xNGSeoW/0dNPV3jO5g9xB8Fu6JRs7
        38V/aFv6B+QiVzs5nCe2Ojam+A==
X-Google-Smtp-Source: ABdhPJzvggZ9gBKEuPs9zideFUu63Vp+I+f6NqeBAH2GCiY2gg26v07OXL/8k0pHgvYTC/VEpQwCAw==
X-Received: by 2002:a17:90b:4ac3:: with SMTP id mh3mr2378205pjb.29.1632864968273;
        Tue, 28 Sep 2021 14:36:08 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:d7ca:580:94ab:8af8])
        by smtp.gmail.com with UTF8SMTPSA id mn22sm2796646pjb.11.2021.09.28.14.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 14:36:07 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org,
        Sandy Huang <hjc@rock-chips.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Thomas Hebb <tommyhebb@gmail.com>,
        Brian Norris <briannorris@chromium.org>, stable@vger.kernel.org
Subject: [PATCH v3 2/4] drm/rockchip: dsi: Reconfigure hardware on resume()
Date:   Tue, 28 Sep 2021 14:35:50 -0700
Message-Id: <20210928143413.v3.2.I4e9d93aadb00b1ffc7d506e3186a25492bf0b732@changeid>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <20210928213552.1001939-1-briannorris@chromium.org>
References: <20210928213552.1001939-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 43c2de1002d2, we perform most HW configuration in the
bind() function. This configuration may be lost on suspend/resume, so we
need to call it again. That may lead to errors like this after system
suspend/resume:

  dw-mipi-dsi-rockchip ff968000.mipi: failed to write command FIFO
  panel-kingdisplay-kd097d04 ff960000.mipi.0: failed write init cmds: -110

Tested on Acer Chromebook Tab 10 (RK3399 Gru-Scarlet).

Note that early mailing list versions of this driver borrowed Rockchip's
downstream/BSP solution, to do HW configuration in mode_set() (which
*is* called at the appropriate pre-enable() times), but that was
discarded along the way. I've avoided that still, because mode_set()
documentation doesn't suggest this kind of purpose as far as I can tell.

Fixes: 43c2de1002d2 ("drm/rockchip: dsi: move all lane config except LCDC mux to bind()")
Cc: <stable@vger.kernel.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v3:
 - New patch, to fix related PM issue discovered after patch 1

 .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index 45676b23c019..21c67343cc6c 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -268,6 +268,8 @@ struct dw_mipi_dsi_rockchip {
 	struct dw_mipi_dsi *dmd;
 	const struct rockchip_dw_dsi_chip_data *cdata;
 	struct dw_mipi_dsi_plat_data pdata;
+
+	bool dsi_bound;
 };
 
 struct dphy_pll_parameter_map {
@@ -964,6 +966,8 @@ static int dw_mipi_dsi_rockchip_bind(struct device *dev,
 		goto out_pm_runtime;
 	}
 
+	dsi->dsi_bound = true;
+
 	return 0;
 
 out_pm_runtime:
@@ -983,6 +987,8 @@ static void dw_mipi_dsi_rockchip_unbind(struct device *dev,
 	if (dsi->is_slave)
 		return;
 
+	dsi->dsi_bound = false;
+
 	dw_mipi_dsi_unbind(dsi->dmd);
 
 	clk_disable_unprepare(dsi->pllref_clk);
@@ -1277,6 +1283,36 @@ static const struct phy_ops dw_mipi_dsi_dphy_ops = {
 	.exit		= dw_mipi_dsi_dphy_exit,
 };
 
+static int __maybe_unused dw_mipi_dsi_rockchip_resume(struct device *dev)
+{
+	struct dw_mipi_dsi_rockchip *dsi = dev_get_drvdata(dev);
+	int ret;
+
+	/*
+	 * Re-configure DSI state, if we were previously initialized. We need
+	 * to do this before rockchip_drm_drv tries to re-enable() any panels.
+	 */
+	if (dsi->dsi_bound) {
+		ret = clk_prepare_enable(dsi->grf_clk);
+		if (ret) {
+			DRM_DEV_ERROR(dsi->dev, "Failed to enable grf_clk: %d\n", ret);
+			return ret;
+		}
+
+		dw_mipi_dsi_rockchip_config(dsi);
+		if (dsi->slave)
+			dw_mipi_dsi_rockchip_config(dsi->slave);
+
+		clk_disable_unprepare(dsi->grf_clk);
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops dw_mipi_dsi_rockchip_pm_ops = {
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(NULL, dw_mipi_dsi_rockchip_resume)
+};
+
 static int dw_mipi_dsi_rockchip_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1594,6 +1630,7 @@ struct platform_driver dw_mipi_dsi_rockchip_driver = {
 	.remove		= dw_mipi_dsi_rockchip_remove,
 	.driver		= {
 		.of_match_table = dw_mipi_dsi_rockchip_dt_ids,
+		.pm	= &dw_mipi_dsi_rockchip_pm_ops,
 		.name	= "dw-mipi-dsi-rockchip",
 	},
 };
-- 
2.33.0.685.g46640cef36-goog

