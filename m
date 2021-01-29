Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F0B3086A2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 08:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbhA2HkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 02:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbhA2HgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 02:36:10 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376D4C061797
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 23:34:57 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id r38so6073544pgk.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 23:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z0VzfNDnc1RNpKDeThOpKuoraFZ7ZUithfDN0lHwcjc=;
        b=TZlyGJRidU43SvB+usEmJhbiogpEBxkWU7lt38+Hx8JDPJUO+68ZyCxSXCNgPBDW25
         0uYkOXwFqmxlBYwzrJ1s1BbLh8cDVbUleOI/cLu1ScjXfvn0gwFW6biVIqPg9Pe+fARn
         s3Z8/v3SE5rdkXQops9PO/SAcOecDmpJSPSjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z0VzfNDnc1RNpKDeThOpKuoraFZ7ZUithfDN0lHwcjc=;
        b=PrSnLwRaGLZVEiSXsWXJhYY2D0ty8Q/0RF9hF7zhpxCkE1xeyI1y7ZiJcY/FDEqHiF
         ZDxJWneZ4OM6dTQzYHyXiLXMVicrBX92+3bfXS0hBmCexyO9n+Qo5wPOuZtZdVJ6d10u
         8hQp5MK6hfZP+rOYYQDzPAMVbdfqj/CJBOQvq4nQ1tIv8jKYaHZA90EoVxJ6OlTgJiCC
         dpYFcQPQ+iMCjTkRrwSoJCpRmW/8HICtW5O4pVsUqejbWbSQcADspED/4ycKec9nL8d9
         VmP37DSNRmF0IbeTlyAUQUGb6glizFnFNPbQ9wuNhzw2pC0YflV10lU1VDU6mA2dHbhM
         Iaog==
X-Gm-Message-State: AOAM532/svmAtwBBu+uvZwAURVj4HX5DXdMiWaSbn+Pi6uFAZabQqbIP
        vPP3COdrIbkt/2z0h0eRn+59Hw==
X-Google-Smtp-Source: ABdhPJy0ekUDoYPIR7eUwYsy3duD/m0fqRvopGyLRi/0wI+d34WZYnW5TQk31h5jTmTx9tnOn/Drkw==
X-Received: by 2002:a63:e30d:: with SMTP id f13mr3528882pgh.39.1611905696728;
        Thu, 28 Jan 2021 23:34:56 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:51f1:c468:a70b:7c09])
        by smtp.gmail.com with ESMTPSA id p1sm7689980pfn.21.2021.01.28.23.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 23:34:56 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v4 6/8] drm/mediatek: add matrix bits private data for ccorr
Date:   Fri, 29 Jan 2021 15:34:34 +0800
Message-Id: <20210129073436.2429834-7-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210129073436.2429834-1-hsinyi@chromium.org>
References: <20210129073436.2429834-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

matrix bits of mt8183 is 12
matrix bits of mt8192 is 13

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
index 0c68090eb1e92..1c7163a12f3b1 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
@@ -31,8 +31,10 @@
 #define DISP_CCORR_COEF_3			0x008C
 #define DISP_CCORR_COEF_4			0x0090
 
+#define CCORR_MATRIX_BITS			12
+
 struct mtk_disp_ccorr_data {
-	u32 reserved;
+	u32 matrix_bits;
 };
 
 /**
@@ -116,6 +118,7 @@ void mtk_ccorr_ctm_set(struct device *dev, struct drm_crtc_state *state)
 	uint16_t coeffs[9] = { 0 };
 	int i;
 	struct cmdq_pkt *cmdq_pkt = NULL;
+	u32 matrix_bits;
 
 	if (!blob)
 		return;
@@ -123,8 +126,16 @@ void mtk_ccorr_ctm_set(struct device *dev, struct drm_crtc_state *state)
 	ctm = (struct drm_color_ctm *)blob->data;
 	input = ctm->matrix;
 
-	for (i = 0; i < ARRAY_SIZE(coeffs); i++)
+	if (ccorr->data)
+		matrix_bits = ccorr->data->matrix_bits;
+	else
+		matrix_bits = CCORR_MATRIX_BITS;
+
+	for (i = 0; i < ARRAY_SIZE(coeffs); i++) {
 		coeffs[i] = mtk_ctm_s31_32_to_s1_10(input[i]);
+		if (matrix_bits > CCORR_MATRIX_BITS)
+			coeffs[i] <<= (matrix_bits - CCORR_MATRIX_BITS);
+	}
 
 	mtk_ddp_write(cmdq_pkt, coeffs[0] << 16 | coeffs[1],
 		      &ccorr->cmdq_reg, ccorr->regs, DISP_CCORR_COEF_0);
@@ -205,8 +216,13 @@ static int mtk_disp_ccorr_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct mtk_disp_ccorr_data mt8183_ccorr_driver_data = {
+	.matrix_bits = CCORR_MATRIX_BITS,
+};
+
 static const struct of_device_id mtk_disp_ccorr_driver_dt_match[] = {
-	{ .compatible = "mediatek,mt8183-disp-ccorr"},
+	{ .compatible = "mediatek,mt8183-disp-ccorr",
+	  .data = &mt8183_ccorr_driver_data},
 	{},
 };
 MODULE_DEVICE_TABLE(of, mtk_disp_ccorr_driver_dt_match);
-- 
2.30.0.365.g02bc693789-goog

