Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4AA3074B8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 12:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhA1LZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 06:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbhA1LZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 06:25:23 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA129C0617AB
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 03:23:40 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id p15so3676522pjv.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 03:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uNC+fgIILnq+fz6YbmCt7WbdgK9dobVg7+XX/8F1ePc=;
        b=KaTda8x3y8nvWfAktv7Ew+B/uHzCEZTphWv0FszhznF1Nb8XOn/eND2cFX57qQGXgl
         lLfRDaKjcLyQmaaJzsRQ0uPj22fZG4JGIA6X2eiXlYzt1d9PYqLtNDcwy7ZEV5WaeldW
         cKpWTQxh0opGQ7dfnsEQe8g5wp1apecn0Vimg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uNC+fgIILnq+fz6YbmCt7WbdgK9dobVg7+XX/8F1ePc=;
        b=O0Mu8spvDhRjHXfzYQrAMMnRZ21GAztnSeTEHE1Jj4WMeFtoJ7Z5Q5Z07ga/jzFrNe
         Js8dwzV5z3o/S9uyHlFU38jy+vY4XjloS5cHEwFZy7M5cdFfd0pSfsMlclNVqLuklYar
         kBSjzvPemq9io1TjKpuG4t/WYlFWvns8CWubGBvzNp+NlmIvhxMjq4G9lF7aYw5e6rTe
         jiRECdptwEM3A1wx26SIxw5SUQZxVniijdh4G/Zhzeux6k/qlJFgP+C8lcHHe2IMO1RC
         I9kDYIc1vrYLA6FF381FZdlAiGvzCHvRy4IxLPuFir4yk9N+nB5YB9nivujCtwaRKAUY
         wLng==
X-Gm-Message-State: AOAM53272AAZ5VsB8kWoYRrUBDGsABJqqRZVv5Lgb25+Tr6nCgcoOlPp
        ZuHNtX8j9D8ebRDtxBEIxXzsLc4Tlg7usA==
X-Google-Smtp-Source: ABdhPJylQBK15I2sybXeLrecHPzgCEu2AT7ahJGayH/zpNAZ9gpBqafQ+h3PSGoZ8OTGVRUWf1aBow==
X-Received: by 2002:a17:902:7804:b029:e1:de3:4ae6 with SMTP id p4-20020a1709027804b02900e10de34ae6mr4648071pll.22.1611833020195;
        Thu, 28 Jan 2021 03:23:40 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:e0a5:d2fc:aaad:1e4a])
        by smtp.gmail.com with ESMTPSA id j198sm3138315pfd.71.2021.01.28.03.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 03:23:39 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v12 8/8] drm/mediatek: add support for mediatek SOC MT8183
Date:   Thu, 28 Jan 2021 19:23:14 +0800
Message-Id: <20210128112314.1304160-9-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210128112314.1304160-1-hsinyi@chromium.org>
References: <20210128112314.1304160-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

1. add ovl private data
2. add rdma private data
3. add gamma privte data
4. add main and external path module for crtc create

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c |  1 +
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c   | 18 +++++++++
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c  |  6 +++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c    | 45 +++++++++++++++++++++++
 4 files changed, 70 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
index 5092a27ccc28b..7121d75a06bdc 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
@@ -182,6 +182,7 @@ static const struct mtk_disp_gamma_data mt8173_gamma_driver_data = {
 static const struct of_device_id mtk_disp_gamma_driver_dt_match[] = {
 	{ .compatible = "mediatek,mt8173-disp-gamma",
 	  .data = &mt8173_gamma_driver_data},
+	{ .compatible = "mediatek,mt8183-disp-gamma"},
 	{},
 };
 MODULE_DEVICE_TABLE(of, mtk_disp_gamma_driver_dt_match);
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 1c295c58a5e82..da7e38a28759b 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -424,11 +424,29 @@ static const struct mtk_disp_ovl_data mt8173_ovl_driver_data = {
 	.fmt_rgb565_is_0 = true,
 };
 
+static const struct mtk_disp_ovl_data mt8183_ovl_driver_data = {
+	.addr = DISP_REG_OVL_ADDR_MT8173,
+	.gmc_bits = 10,
+	.layer_nr = 4,
+	.fmt_rgb565_is_0 = true,
+};
+
+static const struct mtk_disp_ovl_data mt8183_ovl_2l_driver_data = {
+	.addr = DISP_REG_OVL_ADDR_MT8173,
+	.gmc_bits = 10,
+	.layer_nr = 2,
+	.fmt_rgb565_is_0 = true,
+};
+
 static const struct of_device_id mtk_disp_ovl_driver_dt_match[] = {
 	{ .compatible = "mediatek,mt2701-disp-ovl",
 	  .data = &mt2701_ovl_driver_data},
 	{ .compatible = "mediatek,mt8173-disp-ovl",
 	  .data = &mt8173_ovl_driver_data},
+	{ .compatible = "mediatek,mt8183-disp-ovl",
+	  .data = &mt8183_ovl_driver_data},
+	{ .compatible = "mediatek,mt8183-disp-ovl-2l",
+	  .data = &mt8183_ovl_2l_driver_data},
 	{},
 };
 MODULE_DEVICE_TABLE(of, mtk_disp_ovl_driver_dt_match);
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index b84004394970f..728aaadfea8cf 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -351,11 +351,17 @@ static const struct mtk_disp_rdma_data mt8173_rdma_driver_data = {
 	.fifo_size = SZ_8K,
 };
 
+static const struct mtk_disp_rdma_data mt8183_rdma_driver_data = {
+	.fifo_size = 5 * SZ_1K,
+};
+
 static const struct of_device_id mtk_disp_rdma_driver_dt_match[] = {
 	{ .compatible = "mediatek,mt2701-disp-rdma",
 	  .data = &mt2701_rdma_driver_data},
 	{ .compatible = "mediatek,mt8173-disp-rdma",
 	  .data = &mt8173_rdma_driver_data},
+	{ .compatible = "mediatek,mt8183-disp-rdma",
+	  .data = &mt8183_rdma_driver_data},
 	{},
 };
 MODULE_DEVICE_TABLE(of, mtk_disp_rdma_driver_dt_match);
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 279d3e6f11563..486e73e675ad5 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -129,6 +129,24 @@ static const enum mtk_ddp_comp_id mt8173_mtk_ddp_ext[] = {
 	DDP_COMPONENT_DPI0,
 };
 
+static const enum mtk_ddp_comp_id mt8183_mtk_ddp_main[] = {
+	DDP_COMPONENT_OVL0,
+	DDP_COMPONENT_OVL_2L0,
+	DDP_COMPONENT_RDMA0,
+	DDP_COMPONENT_COLOR0,
+	DDP_COMPONENT_CCORR,
+	DDP_COMPONENT_AAL0,
+	DDP_COMPONENT_GAMMA,
+	DDP_COMPONENT_DITHER,
+	DDP_COMPONENT_DSI0,
+};
+
+static const enum mtk_ddp_comp_id mt8183_mtk_ddp_ext[] = {
+	DDP_COMPONENT_OVL_2L1,
+	DDP_COMPONENT_RDMA1,
+	DDP_COMPONENT_DPI0,
+};
+
 static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
 	.main_path = mt2701_mtk_ddp_main,
 	.main_len = ARRAY_SIZE(mt2701_mtk_ddp_main),
@@ -161,6 +179,13 @@ static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
 	.ext_len = ARRAY_SIZE(mt8173_mtk_ddp_ext),
 };
 
+static const struct mtk_mmsys_driver_data mt8183_mmsys_driver_data = {
+	.main_path = mt8183_mtk_ddp_main,
+	.main_len = ARRAY_SIZE(mt8183_mtk_ddp_main),
+	.ext_path = mt8183_mtk_ddp_ext,
+	.ext_len = ARRAY_SIZE(mt8183_mtk_ddp_ext),
+};
+
 static int mtk_drm_kms_init(struct drm_device *drm)
 {
 	struct mtk_drm_private *private = drm->dev_private;
@@ -375,12 +400,20 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
 	  .data = (void *)MTK_DISP_OVL },
 	{ .compatible = "mediatek,mt8173-disp-ovl",
 	  .data = (void *)MTK_DISP_OVL },
+	{ .compatible = "mediatek,mt8183-disp-ovl",
+	  .data = (void *)MTK_DISP_OVL },
+	{ .compatible = "mediatek,mt8183-disp-ovl-2l",
+	  .data = (void *)MTK_DISP_OVL_2L },
 	{ .compatible = "mediatek,mt2701-disp-rdma",
 	  .data = (void *)MTK_DISP_RDMA },
 	{ .compatible = "mediatek,mt8173-disp-rdma",
 	  .data = (void *)MTK_DISP_RDMA },
+	{ .compatible = "mediatek,mt8183-disp-rdma",
+	  .data = (void *)MTK_DISP_RDMA },
 	{ .compatible = "mediatek,mt8173-disp-wdma",
 	  .data = (void *)MTK_DISP_WDMA },
+	{ .compatible = "mediatek,mt8183-disp-ccorr",
+	  .data = (void *)MTK_DISP_CCORR },
 	{ .compatible = "mediatek,mt2701-disp-color",
 	  .data = (void *)MTK_DISP_COLOR },
 	{ .compatible = "mediatek,mt8173-disp-color",
@@ -389,22 +422,32 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
 	  .data = (void *)MTK_DISP_AAL},
 	{ .compatible = "mediatek,mt8173-disp-gamma",
 	  .data = (void *)MTK_DISP_GAMMA, },
+	{ .compatible = "mediatek,mt8183-disp-gamma",
+	  .data = (void *)MTK_DISP_GAMMA, },
+	{ .compatible = "mediatek,mt8183-disp-dither",
+	  .data = (void *)MTK_DISP_DITHER },
 	{ .compatible = "mediatek,mt8173-disp-ufoe",
 	  .data = (void *)MTK_DISP_UFOE },
 	{ .compatible = "mediatek,mt2701-dsi",
 	  .data = (void *)MTK_DSI },
 	{ .compatible = "mediatek,mt8173-dsi",
 	  .data = (void *)MTK_DSI },
+	{ .compatible = "mediatek,mt8183-dsi",
+	  .data = (void *)MTK_DSI },
 	{ .compatible = "mediatek,mt2701-dpi",
 	  .data = (void *)MTK_DPI },
 	{ .compatible = "mediatek,mt8173-dpi",
 	  .data = (void *)MTK_DPI },
+	{ .compatible = "mediatek,mt8183-dpi",
+	  .data = (void *)MTK_DPI },
 	{ .compatible = "mediatek,mt2701-disp-mutex",
 	  .data = (void *)MTK_DISP_MUTEX },
 	{ .compatible = "mediatek,mt2712-disp-mutex",
 	  .data = (void *)MTK_DISP_MUTEX },
 	{ .compatible = "mediatek,mt8173-disp-mutex",
 	  .data = (void *)MTK_DISP_MUTEX },
+	{ .compatible = "mediatek,mt8183-disp-mutex",
+	  .data = (void *)MTK_DISP_MUTEX },
 	{ .compatible = "mediatek,mt2701-disp-pwm",
 	  .data = (void *)MTK_DISP_BLS },
 	{ .compatible = "mediatek,mt8173-disp-pwm",
@@ -423,6 +466,8 @@ static const struct of_device_id mtk_drm_of_ids[] = {
 	  .data = &mt2712_mmsys_driver_data},
 	{ .compatible = "mediatek,mt8173-mmsys",
 	  .data = &mt8173_mmsys_driver_data},
+	{ .compatible = "mediatek,mt8183-mmsys",
+	  .data = &mt8183_mmsys_driver_data},
 	{ }
 };
 
-- 
2.30.0.280.ga3ce27912f-goog

