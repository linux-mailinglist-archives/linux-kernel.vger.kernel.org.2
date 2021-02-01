Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C79D30A591
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbhBAKjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbhBAKjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:39:05 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F50C061797
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 02:37:48 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id e9so10664855pjj.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 02:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bmlVZxRAeFFue/kiN8+5f974mHTD70ZbhDvKpUk4Gzs=;
        b=f0pALAO8VmIYrpoeT3/Gzaw9jnKwBfItRcJVJK6bGkcbC0gNJCuZe/oCZGrynzA46w
         M52kvJWVt6V0JS2KrKMpVReScojO0m/mC2n8N5v2nmb8Ny3sKr8CfCAJrFIeD43Ko3sn
         /mJar9R/i/bJ/VnUpjS89f9Kkbsn4ST/FdFPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bmlVZxRAeFFue/kiN8+5f974mHTD70ZbhDvKpUk4Gzs=;
        b=C/GjYrF5MRqaS8CYHw/iJkYLAqWmD64wVRzOK8jeDl54Ap3RDZuwNk7kdgtcuDn/IS
         hggHyzDra5u8lPxPV9EW0JqtiJZhLb/hc9Uk2iq2AEPV18IDRBaFYgJG/Xled9tjvU91
         HGLbEwS0F0wgHoYGR9lraOAFfxF+yOi9h2RMZP15h3vc1deDwKg6XCeHGg5VQF52cojt
         eCDzYj8TAQEIWmELHn8os+dDHr/paMZGwcThj68LjQiJkc4K3lyUDQRHeEKG5OhG4EsO
         tZ10W9LlxkcXnoVcoEWRfPVC4gP+diq///nr9JhShYzBqyWWxzF4cLaKhNn10EInRI0o
         rSyg==
X-Gm-Message-State: AOAM530sdK7FqB0Ml2ZlNdq6OClvNZxLX5CbPcjXiwj+Pe56QBO2p25/
        +QEE8U3hp4yxNcnU3r7woAE92g==
X-Google-Smtp-Source: ABdhPJyevrQLko0WXEGY9fNaysu7Q70Imh1x0kXORk9gQmwkyhIgPr5rgBQQ3Et8G8Cx6xxCiLsfBg==
X-Received: by 2002:a17:90b:4004:: with SMTP id ie4mr3233169pjb.114.1612175867800;
        Mon, 01 Feb 2021 02:37:47 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:a0cd:1b84:6d56:68e1])
        by smtp.gmail.com with ESMTPSA id 76sm17610356pfz.174.2021.02.01.02.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 02:37:47 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v5 6/8] drm/mediatek: add matrix_bits private data for ccorr
Date:   Mon,  1 Feb 2021 18:37:25 +0800
Message-Id: <20210201103727.376721-7-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210201103727.376721-1-hsinyi@chromium.org>
References: <20210201103727.376721-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

Add matrix_bits and coeffs_precision to ccorr private data:
- matrix bits of mt8183 is 10
- matrix bits of mt8192 is 11

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c | 34 ++++++++++++++++-------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
index 6c86673a835c3..fb86f3a8b3a18 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
@@ -29,8 +29,10 @@
 #define DISP_CCORR_COEF_3			0x008C
 #define DISP_CCORR_COEF_4			0x0090
 
+#define CCORR_MATRIX_BITS			10
+
 struct mtk_disp_ccorr_data {
-	u32 reserved;
+	u32 matrix_bits;
 };
 
 /**
@@ -85,21 +87,22 @@ void mtk_ccorr_stop(struct device *dev)
 	writel_relaxed(0x0, ccorr->regs + DISP_CCORR_EN);
 }
 
-/* Converts a DRM S31.32 value to the HW S1.10 format. */
-static u16 mtk_ctm_s31_32_to_s1_10(u64 in)
+/* Converts a DRM S31.32 value to the HW S1.n format. */
+static u16 mtk_ctm_s31_32_to_s1_n(u64 in, u32 n)
 {
 	u16 r;
 
 	/* Sign bit. */
-	r = in & BIT_ULL(63) ? BIT(11) : 0;
+	r = in & BIT_ULL(63) ? BIT(n + 1) : 0;
 
 	if ((in & GENMASK_ULL(62, 33)) > 0) {
-		/* identity value 0x100000000 -> 0x400, */
+		/* identity value 0x100000000 -> 0x400(mt8183), */
+		/* identity value 0x100000000 -> 0x800(mt8192), */
 		/* if bigger this, set it to max 0x7ff. */
-		r |= GENMASK(10, 0);
+		r |= GENMASK(n, 0);
 	} else {
-		/* take the 11 most important bits. */
-		r |= (in >> 22) & GENMASK(10, 0);
+		/* take the n+1 most important bits. */
+		r |= (in >> (32 - n)) & GENMASK(n, 0);
 	}
 
 	return r;
@@ -114,6 +117,7 @@ void mtk_ccorr_ctm_set(struct device *dev, struct drm_crtc_state *state)
 	uint16_t coeffs[9] = { 0 };
 	int i;
 	struct cmdq_pkt *cmdq_pkt = NULL;
+	u32 matrix_bits;
 
 	if (!blob)
 		return;
@@ -121,8 +125,13 @@ void mtk_ccorr_ctm_set(struct device *dev, struct drm_crtc_state *state)
 	ctm = (struct drm_color_ctm *)blob->data;
 	input = ctm->matrix;
 
+	if (ccorr->data)
+		matrix_bits = ccorr->data->matrix_bits;
+	else
+		matrix_bits = CCORR_MATRIX_BITS;
+
 	for (i = 0; i < ARRAY_SIZE(coeffs); i++)
-		coeffs[i] = mtk_ctm_s31_32_to_s1_10(input[i]);
+		coeffs[i] = mtk_ctm_s31_32_to_s1_n(input[i], matrix_bits);
 
 	mtk_ddp_write(cmdq_pkt, coeffs[0] << 16 | coeffs[1],
 		      &ccorr->cmdq_reg, ccorr->regs, DISP_CCORR_COEF_0);
@@ -199,8 +208,13 @@ static int mtk_disp_ccorr_remove(struct platform_device *pdev)
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

