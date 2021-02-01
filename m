Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8644E30A5A2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbhBAKlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbhBAKjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:39:20 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A426CC0617A9
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 02:37:50 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id lw17so9397770pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 02:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gl0/z3i4ayOFcHHYY/rO4O6oPEvVoCzk+bniaclevbQ=;
        b=nFmOFpEdscgN+RyG88h/xZLsA5XgjukGMOPeLCWnanfZuat5AMDop/1bIY2rz8bPdq
         HU1+GDNU9bGPl9qbNPorEbVS8F7alA9uhZ2q5Ss19sIGgL9lGQeBypthIuRlGteU5/+m
         oshdNT+r6JLP26vfAVL7XlxFqRPIk7x9aG3Bg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gl0/z3i4ayOFcHHYY/rO4O6oPEvVoCzk+bniaclevbQ=;
        b=Bnwfzep7KHOzKTbcke3h7WjjTB5b/JwWZnwm6bNYLYm8p7C1GVdq7rJbsoDIwrFJiB
         AtpWfUidbkMwatvuMRd3RRlP11L8jd7qQ5uGA9HfXZNu8deKry2eh2UJ7sPBXj4Fx1ky
         fajfp9lV/veWydDzUg4S/2uVh+SdBgFIWlS22z9F483QyN7cVwL3B3J5pBwNMuc+j+hb
         g8JFn6+8xVakU0wwfL4Ov37JVnMQwNMxMxQ0YeNGgdn3rMRBB8o4Jd8epZ+xaz7tUGb9
         xKBLbZC5NidzWHfNyQqZBJrOvZNKyVLUTH9kU9U3LHu3rkX627hv8lR4UpYHnSoo56c7
         2v8w==
X-Gm-Message-State: AOAM531VmZSqyUeq54Dgvr7ykqSnEWWulVI3wdCS47dKmg/v9RKrV96Y
        jKGs8igZxWu0SgySVcpp7hxnEQ==
X-Google-Smtp-Source: ABdhPJzRLFu70Z31qpFMmzzhP7GX1paSUMzRMkb8NTXu4JkTwn+rSzXMrtcuSs++Oxs3EHlEdaHW5w==
X-Received: by 2002:a17:90a:d258:: with SMTP id o24mr17148849pjw.231.1612175870235;
        Mon, 01 Feb 2021 02:37:50 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:a0cd:1b84:6d56:68e1])
        by smtp.gmail.com with ESMTPSA id 76sm17610356pfz.174.2021.02.01.02.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 02:37:49 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v5 7/8] soc: mediatek: add mtk mutex support for MT8192
Date:   Mon,  1 Feb 2021 18:37:26 +0800
Message-Id: <20210201103727.376721-8-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210201103727.376721-1-hsinyi@chromium.org>
References: <20210201103727.376721-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

Add mtk mutex support for MT8192 SoC.

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/soc/mediatek/mtk-mutex.c | 35 ++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
index 718a41beb6afb..dfd9806d5a001 100644
--- a/drivers/soc/mediatek/mtk-mutex.c
+++ b/drivers/soc/mediatek/mtk-mutex.c
@@ -39,6 +39,18 @@
 #define MT8167_MUTEX_MOD_DISP_DITHER		15
 #define MT8167_MUTEX_MOD_DISP_UFOE		16
 
+#define MT8192_MUTEX_MOD_DISP_OVL0		0
+#define MT8192_MUTEX_MOD_DISP_OVL0_2L		1
+#define MT8192_MUTEX_MOD_DISP_RDMA0		2
+#define MT8192_MUTEX_MOD_DISP_COLOR0		4
+#define MT8192_MUTEX_MOD_DISP_CCORR0		5
+#define MT8192_MUTEX_MOD_DISP_AAL0		6
+#define MT8192_MUTEX_MOD_DISP_GAMMA0		7
+#define MT8192_MUTEX_MOD_DISP_POSTMASK0		8
+#define MT8192_MUTEX_MOD_DISP_DITHER0		9
+#define MT8192_MUTEX_MOD_DISP_OVL2_2L		16
+#define MT8192_MUTEX_MOD_DISP_RDMA4		17
+
 #define MT8183_MUTEX_MOD_DISP_RDMA0		0
 #define MT8183_MUTEX_MOD_DISP_RDMA1		1
 #define MT8183_MUTEX_MOD_DISP_OVL0		9
@@ -214,6 +226,20 @@ static const unsigned int mt8183_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_WDMA0] = MT8183_MUTEX_MOD_DISP_WDMA0,
 };
 
+static const unsigned int mt8192_mutex_mod[DDP_COMPONENT_ID_MAX] = {
+	[DDP_COMPONENT_AAL0] = MT8192_MUTEX_MOD_DISP_AAL0,
+	[DDP_COMPONENT_CCORR] = MT8192_MUTEX_MOD_DISP_CCORR0,
+	[DDP_COMPONENT_COLOR0] = MT8192_MUTEX_MOD_DISP_COLOR0,
+	[DDP_COMPONENT_DITHER] = MT8192_MUTEX_MOD_DISP_DITHER0,
+	[DDP_COMPONENT_GAMMA] = MT8192_MUTEX_MOD_DISP_GAMMA0,
+	[DDP_COMPONENT_POSTMASK0] = MT8192_MUTEX_MOD_DISP_POSTMASK0,
+	[DDP_COMPONENT_OVL0] = MT8192_MUTEX_MOD_DISP_OVL0,
+	[DDP_COMPONENT_OVL_2L0] = MT8192_MUTEX_MOD_DISP_OVL0_2L,
+	[DDP_COMPONENT_OVL_2L2] = MT8192_MUTEX_MOD_DISP_OVL2_2L,
+	[DDP_COMPONENT_RDMA0] = MT8192_MUTEX_MOD_DISP_RDMA0,
+	[DDP_COMPONENT_RDMA4] = MT8192_MUTEX_MOD_DISP_RDMA4,
+};
+
 static const unsigned int mt2712_mutex_sof[MUTEX_SOF_DSI3 + 1] = {
 	[MUTEX_SOF_SINGLE_MODE] = MUTEX_SOF_SINGLE_MODE,
 	[MUTEX_SOF_DSI0] = MUTEX_SOF_DSI0,
@@ -275,6 +301,13 @@ static const struct mtk_mutex_data mt8183_mutex_driver_data = {
 	.no_clk = true,
 };
 
+static const struct mtk_mutex_data mt8192_mutex_driver_data = {
+	.mutex_mod = mt8192_mutex_mod,
+	.mutex_sof = mt8183_mutex_sof,
+	.mutex_mod_reg = MT8183_MUTEX0_MOD0,
+	.mutex_sof_reg = MT8183_MUTEX0_SOF0,
+};
+
 struct mtk_mutex *mtk_mutex_get(struct device *dev)
 {
 	struct mtk_mutex_ctx *mtx = dev_get_drvdata(dev);
@@ -507,6 +540,8 @@ static const struct of_device_id mutex_driver_dt_match[] = {
 	  .data = &mt8173_mutex_driver_data},
 	{ .compatible = "mediatek,mt8183-disp-mutex",
 	  .data = &mt8183_mutex_driver_data},
+	{ .compatible = "mediatek,mt8192-disp-mutex",
+	  .data = &mt8192_mutex_driver_data},
 	{},
 };
 MODULE_DEVICE_TABLE(of, mutex_driver_dt_match);
-- 
2.30.0.365.g02bc693789-goog

