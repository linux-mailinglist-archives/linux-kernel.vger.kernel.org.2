Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4EB3074B7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 12:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhA1LZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 06:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbhA1LY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 06:24:58 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C1BC0617AA
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 03:23:38 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id e9so3157795plh.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 03:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6+aPdHOYUNN/BAQZGmxejUv+570qMJ/KhCv3x60Q+k0=;
        b=Nfm9fvCz7ecUEhWluWek1LpFXtV53hC6ExHRjs3t70+nZ6y569zYD7K3/rl8tcubZh
         trkf6lylcXo8yDNLTkV0C+IxcatqamUnwS+3ZlZCisArmkqMRPriZHFRBdalAAQR23QO
         pdjMfjOys9/LtoZj4yqDi4lRZqSTibOwukOXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6+aPdHOYUNN/BAQZGmxejUv+570qMJ/KhCv3x60Q+k0=;
        b=p1n/LmV/A0aoLdSaaOi2TwPULQIRa3ccMNpPgzHh5EBf0tEPhYwZT7G54IO8fOm8cL
         a5mDZNzyzfPDGFq7tAztFWfK/6kVpUXvizNapFkJfDPmhHKW2qtqLxy4OsESYfyZBacy
         yeME1Xs2QEpK8fapnVNLjeY5tLNEyCsrM1mZ8puJFrPCiOIw572ELRob6A7UZyZNs3xL
         Z8z7pTL4spcy7TebVbQD9bPY8gHgkaN8MlCXq2UFlBXJxVbQMmvlQm7JsOJ14QV3pjwi
         g6wVjsyfMIL3dk/fPkotDQZP0fR+GZyEr/dTKD20V5NHfUo+s2isglCTggJr04BtxGF4
         jfEg==
X-Gm-Message-State: AOAM531Y2Ue1kPYPEV6rbsIWCpvRvMg7yKSY6BuSMh3k6YBJ5Jiu7DWT
        MZ8VRRazZYhbydazoQPDsbm5eA==
X-Google-Smtp-Source: ABdhPJxd/GuinpwOq9Ty8yAhL21nOEDACeAcunrIlJUerPuPVoHTNlWtju+HLMjLADP5ULBETfE51g==
X-Received: by 2002:a17:903:230f:b029:dc:9b7f:bd0e with SMTP id d15-20020a170903230fb02900dc9b7fbd0emr15689202plh.47.1611833017623;
        Thu, 28 Jan 2021 03:23:37 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:e0a5:d2fc:aaad:1e4a])
        by smtp.gmail.com with ESMTPSA id j198sm3138315pfd.71.2021.01.28.03.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 03:23:37 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v12 7/8] soc: mediatek: add mtk mutex support for MT8183
Date:   Thu, 28 Jan 2021 19:23:13 +0800
Message-Id: <20210128112314.1304160-8-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210128112314.1304160-1-hsinyi@chromium.org>
References: <20210128112314.1304160-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

Add mtk mutex support for MT8183 SoC.

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/soc/mediatek/mtk-mutex.c | 50 ++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
index f531b119da7a9..718a41beb6afb 100644
--- a/drivers/soc/mediatek/mtk-mutex.c
+++ b/drivers/soc/mediatek/mtk-mutex.c
@@ -14,6 +14,8 @@
 
 #define MT2701_MUTEX0_MOD0			0x2c
 #define MT2701_MUTEX0_SOF0			0x30
+#define MT8183_MUTEX0_MOD0			0x30
+#define MT8183_MUTEX0_SOF0			0x2c
 
 #define DISP_REG_MUTEX_EN(n)			(0x20 + 0x20 * (n))
 #define DISP_REG_MUTEX(n)			(0x24 + 0x20 * (n))
@@ -37,6 +39,18 @@
 #define MT8167_MUTEX_MOD_DISP_DITHER		15
 #define MT8167_MUTEX_MOD_DISP_UFOE		16
 
+#define MT8183_MUTEX_MOD_DISP_RDMA0		0
+#define MT8183_MUTEX_MOD_DISP_RDMA1		1
+#define MT8183_MUTEX_MOD_DISP_OVL0		9
+#define MT8183_MUTEX_MOD_DISP_OVL0_2L		10
+#define MT8183_MUTEX_MOD_DISP_OVL1_2L		11
+#define MT8183_MUTEX_MOD_DISP_WDMA0		12
+#define MT8183_MUTEX_MOD_DISP_COLOR0		13
+#define MT8183_MUTEX_MOD_DISP_CCORR0		14
+#define MT8183_MUTEX_MOD_DISP_AAL0		15
+#define MT8183_MUTEX_MOD_DISP_GAMMA0		16
+#define MT8183_MUTEX_MOD_DISP_DITHER0		17
+
 #define MT8173_MUTEX_MOD_DISP_OVL0		11
 #define MT8173_MUTEX_MOD_DISP_OVL1		12
 #define MT8173_MUTEX_MOD_DISP_RDMA0		13
@@ -87,6 +101,11 @@
 #define MT2712_MUTEX_SOF_DSI3			6
 #define MT8167_MUTEX_SOF_DPI0			2
 #define MT8167_MUTEX_SOF_DPI1			3
+#define MT8183_MUTEX_SOF_DSI0			1
+#define MT8183_MUTEX_SOF_DPI0			2
+
+#define MT8183_MUTEX_EOF_DSI0			(MT8183_MUTEX_SOF_DSI0 << 6)
+#define MT8183_MUTEX_EOF_DPI0			(MT8183_MUTEX_SOF_DPI0 << 6)
 
 struct mtk_mutex {
 	int id;
@@ -181,6 +200,20 @@ static const unsigned int mt8173_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_WDMA1] = MT8173_MUTEX_MOD_DISP_WDMA1,
 };
 
+static const unsigned int mt8183_mutex_mod[DDP_COMPONENT_ID_MAX] = {
+	[DDP_COMPONENT_AAL0] = MT8183_MUTEX_MOD_DISP_AAL0,
+	[DDP_COMPONENT_CCORR] = MT8183_MUTEX_MOD_DISP_CCORR0,
+	[DDP_COMPONENT_COLOR0] = MT8183_MUTEX_MOD_DISP_COLOR0,
+	[DDP_COMPONENT_DITHER] = MT8183_MUTEX_MOD_DISP_DITHER0,
+	[DDP_COMPONENT_GAMMA] = MT8183_MUTEX_MOD_DISP_GAMMA0,
+	[DDP_COMPONENT_OVL0] = MT8183_MUTEX_MOD_DISP_OVL0,
+	[DDP_COMPONENT_OVL_2L0] = MT8183_MUTEX_MOD_DISP_OVL0_2L,
+	[DDP_COMPONENT_OVL_2L1] = MT8183_MUTEX_MOD_DISP_OVL1_2L,
+	[DDP_COMPONENT_RDMA0] = MT8183_MUTEX_MOD_DISP_RDMA0,
+	[DDP_COMPONENT_RDMA1] = MT8183_MUTEX_MOD_DISP_RDMA1,
+	[DDP_COMPONENT_WDMA0] = MT8183_MUTEX_MOD_DISP_WDMA0,
+};
+
 static const unsigned int mt2712_mutex_sof[MUTEX_SOF_DSI3 + 1] = {
 	[MUTEX_SOF_SINGLE_MODE] = MUTEX_SOF_SINGLE_MODE,
 	[MUTEX_SOF_DSI0] = MUTEX_SOF_DSI0,
@@ -198,6 +231,13 @@ static const unsigned int mt8167_mutex_sof[MUTEX_SOF_DSI3 + 1] = {
 	[MUTEX_SOF_DPI1] = MT8167_MUTEX_SOF_DPI1,
 };
 
+/* Add EOF setting so overlay hardware can receive frame done irq */
+static const unsigned int mt8183_mutex_sof[MUTEX_SOF_DSI3 + 1] = {
+	[MUTEX_SOF_SINGLE_MODE] = MUTEX_SOF_SINGLE_MODE,
+	[MUTEX_SOF_DSI0] = MUTEX_SOF_DSI0 | MT8183_MUTEX_EOF_DSI0,
+	[MUTEX_SOF_DPI0] = MT8183_MUTEX_SOF_DPI0 | MT8183_MUTEX_EOF_DPI0,
+};
+
 static const struct mtk_mutex_data mt2701_mutex_driver_data = {
 	.mutex_mod = mt2701_mutex_mod,
 	.mutex_sof = mt2712_mutex_sof,
@@ -227,6 +267,14 @@ static const struct mtk_mutex_data mt8173_mutex_driver_data = {
 	.mutex_sof_reg = MT2701_MUTEX0_SOF0,
 };
 
+static const struct mtk_mutex_data mt8183_mutex_driver_data = {
+	.mutex_mod = mt8183_mutex_mod,
+	.mutex_sof = mt8183_mutex_sof,
+	.mutex_mod_reg = MT8183_MUTEX0_MOD0,
+	.mutex_sof_reg = MT8183_MUTEX0_SOF0,
+	.no_clk = true,
+};
+
 struct mtk_mutex *mtk_mutex_get(struct device *dev)
 {
 	struct mtk_mutex_ctx *mtx = dev_get_drvdata(dev);
@@ -457,6 +505,8 @@ static const struct of_device_id mutex_driver_dt_match[] = {
 	  .data = &mt8167_mutex_driver_data},
 	{ .compatible = "mediatek,mt8173-disp-mutex",
 	  .data = &mt8173_mutex_driver_data},
+	{ .compatible = "mediatek,mt8183-disp-mutex",
+	  .data = &mt8183_mutex_driver_data},
 	{},
 };
 MODULE_DEVICE_TABLE(of, mutex_driver_dt_match);
-- 
2.30.0.280.ga3ce27912f-goog

