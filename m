Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6AC130B965
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 09:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbhBBIQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 03:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbhBBIOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 03:14:36 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510D8C061352
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 00:13:03 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id gx20so1882173pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 00:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TNy35bTG+U0bsBdbmfAF9pdnMZteN4kSNXW/T/HMRVs=;
        b=OLx3jKiIICcF98xvHcClR/2NaaDVDl8fI/gZOHQOgVJdjPWi2LASuHzCOk4l8Dj7nl
         03a9iddEkk4bljXQMpaSphKKn95czqPr+fvcIDGNTx/01HxPEtAS5Q1GJ5gR/aOqvHM2
         Qn3KWLvxhWwDfWldPT7MEqLoEk1EgDCtsdlu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TNy35bTG+U0bsBdbmfAF9pdnMZteN4kSNXW/T/HMRVs=;
        b=mD20gudlMQxUx5tehWHRgGOjvGwf2UDhDU5JVqoNsOHTsPlcEamXvv1sbGXJi8zGMw
         5lkfsZrcwMLhrtFBGfY9EdYzfxa8la6rgI9NvsCYDFoURuj/Fv0H74QmFo1gpKxZ+0Fv
         JeUFpSpPqjYXvZUBxXTVga0lH9kwd+gzYYRjApUL0YPuoPqmcyeWlsCM9jU6aqO4aFeG
         8KoGnjfO9s5kGrlZNDHVXhs8y30JvX4T6+Y5Iou+H9gFWpci04L41QJyTQw8dOu4TlFD
         iSyF0GkkKJ1Sm5lZ38vTFzz7j/xEpMqFPrDtFzFXvG4vdHq+YSZPI3M3bqJw6GkGEk5/
         SURw==
X-Gm-Message-State: AOAM5309nhE6IcD6MlczewEyBbEfxivgNw718Orrfbxxzju1CTBRsiSv
        if6PfSZGo1whZSrn/eVZ5WMQ3Q==
X-Google-Smtp-Source: ABdhPJz2cRRqOcq8giQW++hgvQXhwY45c78+LuBZtwxBi1HYIMt5ev9bnctru52eW0nkEtCg3o04sg==
X-Received: by 2002:a17:902:e98d:b029:de:9a3a:1b8d with SMTP id f13-20020a170902e98db02900de9a3a1b8dmr21649134plb.3.1612253582867;
        Tue, 02 Feb 2021 00:13:02 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:743e:7944:50c8:ff72])
        by smtp.gmail.com with ESMTPSA id c8sm21343325pfo.148.2021.02.02.00.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 00:13:02 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v6 8/8] drm/mediatek: add support for mediatek SOC MT8192
Date:   Tue,  2 Feb 2021 16:12:37 +0800
Message-Id: <20210202081237.774442-9-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210202081237.774442-1-hsinyi@chromium.org>
References: <20210202081237.774442-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

add support for mediatek SOC MT8192

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c |  6 ++++
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c   | 20 +++++++++++
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c  |  6 ++++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c    | 42 +++++++++++++++++++++++
 4 files changed, 74 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
index 141cb36b9c07b..3a53ebc4e1724 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
@@ -205,9 +205,15 @@ static const struct mtk_disp_ccorr_data mt8183_ccorr_driver_data = {
 	.matrix_bits = 10,
 };
 
+static const struct mtk_disp_ccorr_data mt8192_ccorr_driver_data = {
+	.matrix_bits = 11,
+};
+
 static const struct of_device_id mtk_disp_ccorr_driver_dt_match[] = {
 	{ .compatible = "mediatek,mt8183-disp-ccorr",
 	  .data = &mt8183_ccorr_driver_data},
+	{ .compatible = "mediatek,mt8192-disp-ccorr",
+	  .data = &mt8192_ccorr_driver_data},
 	{},
 };
 MODULE_DEVICE_TABLE(of, mtk_disp_ccorr_driver_dt_match);
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 961f87f8d4d15..e266baae586c4 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -455,6 +455,22 @@ static const struct mtk_disp_ovl_data mt8183_ovl_2l_driver_data = {
 	.fmt_rgb565_is_0 = true,
 };
 
+static const struct mtk_disp_ovl_data mt8192_ovl_driver_data = {
+	.addr = DISP_REG_OVL_ADDR_MT8173,
+	.gmc_bits = 10,
+	.layer_nr = 4,
+	.fmt_rgb565_is_0 = true,
+	.smi_id_en = true,
+};
+
+static const struct mtk_disp_ovl_data mt8192_ovl_2l_driver_data = {
+	.addr = DISP_REG_OVL_ADDR_MT8173,
+	.gmc_bits = 10,
+	.layer_nr = 2,
+	.fmt_rgb565_is_0 = true,
+	.smi_id_en = true,
+};
+
 static const struct of_device_id mtk_disp_ovl_driver_dt_match[] = {
 	{ .compatible = "mediatek,mt2701-disp-ovl",
 	  .data = &mt2701_ovl_driver_data},
@@ -464,6 +480,10 @@ static const struct of_device_id mtk_disp_ovl_driver_dt_match[] = {
 	  .data = &mt8183_ovl_driver_data},
 	{ .compatible = "mediatek,mt8183-disp-ovl-2l",
 	  .data = &mt8183_ovl_2l_driver_data},
+	{ .compatible = "mediatek,mt8192-disp-ovl",
+	  .data = &mt8192_ovl_driver_data},
+	{ .compatible = "mediatek,mt8192-disp-ovl-2l",
+	  .data = &mt8192_ovl_2l_driver_data},
 	{},
 };
 MODULE_DEVICE_TABLE(of, mtk_disp_ovl_driver_dt_match);
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index 728aaadfea8cf..f123fc00a3935 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -355,6 +355,10 @@ static const struct mtk_disp_rdma_data mt8183_rdma_driver_data = {
 	.fifo_size = 5 * SZ_1K,
 };
 
+static const struct mtk_disp_rdma_data mt8192_rdma_driver_data = {
+	.fifo_size = 5 * SZ_1K,
+};
+
 static const struct of_device_id mtk_disp_rdma_driver_dt_match[] = {
 	{ .compatible = "mediatek,mt2701-disp-rdma",
 	  .data = &mt2701_rdma_driver_data},
@@ -362,6 +366,8 @@ static const struct of_device_id mtk_disp_rdma_driver_dt_match[] = {
 	  .data = &mt8173_rdma_driver_data},
 	{ .compatible = "mediatek,mt8183-disp-rdma",
 	  .data = &mt8183_rdma_driver_data},
+	{ .compatible = "mediatek,mt8192-disp-rdma",
+	  .data = &mt8192_rdma_driver_data},
 	{},
 };
 MODULE_DEVICE_TABLE(of, mtk_disp_rdma_driver_dt_match);
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index b013d56d27773..6df551055630c 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -147,6 +147,25 @@ static const enum mtk_ddp_comp_id mt8183_mtk_ddp_ext[] = {
 	DDP_COMPONENT_DPI0,
 };
 
+static const enum mtk_ddp_comp_id mt8192_mtk_ddp_main[] = {
+	DDP_COMPONENT_OVL0,
+	DDP_COMPONENT_OVL_2L0,
+	DDP_COMPONENT_RDMA0,
+	DDP_COMPONENT_COLOR0,
+	DDP_COMPONENT_CCORR,
+	DDP_COMPONENT_AAL0,
+	DDP_COMPONENT_GAMMA,
+	DDP_COMPONENT_POSTMASK0,
+	DDP_COMPONENT_DITHER,
+	DDP_COMPONENT_DSI0,
+};
+
+static const enum mtk_ddp_comp_id mt8192_mtk_ddp_ext[] = {
+	DDP_COMPONENT_OVL_2L2,
+	DDP_COMPONENT_RDMA4,
+	DDP_COMPONENT_DPI0,
+};
+
 static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
 	.main_path = mt2701_mtk_ddp_main,
 	.main_len = ARRAY_SIZE(mt2701_mtk_ddp_main),
@@ -186,6 +205,13 @@ static const struct mtk_mmsys_driver_data mt8183_mmsys_driver_data = {
 	.ext_len = ARRAY_SIZE(mt8183_mtk_ddp_ext),
 };
 
+static const struct mtk_mmsys_driver_data mt8192_mmsys_driver_data = {
+	.main_path = mt8192_mtk_ddp_main,
+	.main_len = ARRAY_SIZE(mt8192_mtk_ddp_main),
+	.ext_path = mt8192_mtk_ddp_ext,
+	.ext_len = ARRAY_SIZE(mt8192_mtk_ddp_ext),
+};
+
 static int mtk_drm_kms_init(struct drm_device *drm)
 {
 	struct mtk_drm_private *private = drm->dev_private;
@@ -404,22 +430,32 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
 	  .data = (void *)MTK_DISP_OVL },
 	{ .compatible = "mediatek,mt8183-disp-ovl-2l",
 	  .data = (void *)MTK_DISP_OVL_2L },
+	{ .compatible = "mediatek,mt8192-disp-ovl",
+	  .data = (void *)MTK_DISP_OVL },
+	{ .compatible = "mediatek,mt8192-disp-ovl-2l",
+	  .data = (void *)MTK_DISP_OVL_2L },
 	{ .compatible = "mediatek,mt2701-disp-rdma",
 	  .data = (void *)MTK_DISP_RDMA },
 	{ .compatible = "mediatek,mt8173-disp-rdma",
 	  .data = (void *)MTK_DISP_RDMA },
 	{ .compatible = "mediatek,mt8183-disp-rdma",
 	  .data = (void *)MTK_DISP_RDMA },
+	{ .compatible = "mediatek,mt8192-disp-rdma",
+	  .data = (void *)MTK_DISP_RDMA },
 	{ .compatible = "mediatek,mt8173-disp-wdma",
 	  .data = (void *)MTK_DISP_WDMA },
 	{ .compatible = "mediatek,mt8183-disp-ccorr",
 	  .data = (void *)MTK_DISP_CCORR },
+	{ .compatible = "mediatek,mt8192-disp-ccorr",
+	  .data = (void *)MTK_DISP_CCORR },
 	{ .compatible = "mediatek,mt2701-disp-color",
 	  .data = (void *)MTK_DISP_COLOR },
 	{ .compatible = "mediatek,mt8173-disp-color",
 	  .data = (void *)MTK_DISP_COLOR },
 	{ .compatible = "mediatek,mt8173-disp-aal",
 	  .data = (void *)MTK_DISP_AAL},
+	{ .compatible = "mediatek,mt8192-disp-aal",
+	  .data = (void *)MTK_DISP_AAL},
 	{ .compatible = "mediatek,mt8173-disp-gamma",
 	  .data = (void *)MTK_DISP_GAMMA, },
 	{ .compatible = "mediatek,mt8183-disp-gamma",
@@ -448,12 +484,16 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
 	  .data = (void *)MTK_DISP_MUTEX },
 	{ .compatible = "mediatek,mt8183-disp-mutex",
 	  .data = (void *)MTK_DISP_MUTEX },
+	{ .compatible = "mediatek,mt8192-disp-mutex",
+	  .data = (void *)MTK_DISP_MUTEX },
 	{ .compatible = "mediatek,mt2701-disp-pwm",
 	  .data = (void *)MTK_DISP_BLS },
 	{ .compatible = "mediatek,mt8173-disp-pwm",
 	  .data = (void *)MTK_DISP_PWM },
 	{ .compatible = "mediatek,mt8173-disp-od",
 	  .data = (void *)MTK_DISP_OD },
+	{ .compatible = "mediatek,mt8192-disp-postmask",
+	  .data = (void *)MTK_DISP_POSTMASK },
 	{ }
 };
 
@@ -468,6 +508,8 @@ static const struct of_device_id mtk_drm_of_ids[] = {
 	  .data = &mt8173_mmsys_driver_data},
 	{ .compatible = "mediatek,mt8183-mmsys",
 	  .data = &mt8183_mmsys_driver_data},
+	{ .compatible = "mediatek,mt8192-mmsys",
+	 .data = &mt8192_mmsys_driver_data},
 	{ }
 };
 
-- 
2.30.0.365.g02bc693789-goog

