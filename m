Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685E330B962
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 09:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbhBBIPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 03:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbhBBIOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 03:14:07 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480C3C0617A9
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 00:12:58 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d13so12044064plg.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 00:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DZdphxYwQpNgHOFUOUaWm9uwAnlzsS+AdxWYfgDd9hA=;
        b=nyz2ipv8gR61iZC6SDEU3wS2dS5Fsq7B8cB5SdScOyLbk4RWn/orif0TrbbnOuimXP
         rOuZMPHgjm3LHUVOF1Pf07US1Dcky4JW3fryFcnj9+9+Ftw60OEv/6OPpg0Cp5hliapK
         gtUc64F3DmnzUxFYTaSI+3f3F74jTKBqr3PD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DZdphxYwQpNgHOFUOUaWm9uwAnlzsS+AdxWYfgDd9hA=;
        b=M8aICOh8IKc2J3ec5dV6UIyL6O1il6w7BjiMi+Be0J+Cyr8VJTQF3xlj7Albwo6S7F
         GQCLHl3XLjSfVj+CNovundZaRocJStkNFlNpZTwvC98yuKRa3VZfPp75Fm8Om6Eupp3+
         SmmRFqdnexjqv6Rep9vnbMUycHsLOyyn1jX8v0DAY1BwUq6oSdVW/ufJirHdQfUTde3p
         sB4LTSPMZWCOcqAbtui0G0rl+ZnUT9n6u4piJH9uXvnxKCLXlGz3iC/BU2hby8U8m4Jt
         pEo9YYN1pCH1ac475IgxXJxjlhCToNh/VPYHWquYwcbIrG5sKl5yf6VXC/vXLSMiysFI
         pbTw==
X-Gm-Message-State: AOAM533to1lY6tvNzlD4wjRp9To5W3tEGpnfmruu9pd5+PuymIQlmgI/
        o1S55p/+oI8Bj4bib7VfGAMTOQ==
X-Google-Smtp-Source: ABdhPJyF8bc5pdb1FJPBhQ+/6UsN7ak+pFPIp5SpdezQiD7juh3TAHxaPLhUkY/18ZfpcAMIdFReNw==
X-Received: by 2002:a17:90a:6549:: with SMTP id f9mr3147931pjs.17.1612253577756;
        Tue, 02 Feb 2021 00:12:57 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:743e:7944:50c8:ff72])
        by smtp.gmail.com with ESMTPSA id c8sm21343325pfo.148.2021.02.02.00.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 00:12:57 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v6 6/8] drm/mediatek: add matrix_bits private data for ccorr
Date:   Tue,  2 Feb 2021 16:12:35 +0800
Message-Id: <20210202081237.774442-7-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210202081237.774442-1-hsinyi@chromium.org>
References: <20210202081237.774442-1-hsinyi@chromium.org>
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
 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c | 27 ++++++++++++++---------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
index 6c86673a835c3..141cb36b9c07b 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
@@ -30,7 +30,7 @@
 #define DISP_CCORR_COEF_4			0x0090
 
 struct mtk_disp_ccorr_data {
-	u32 reserved;
+	u32 matrix_bits;
 };
 
 /**
@@ -85,21 +85,22 @@ void mtk_ccorr_stop(struct device *dev)
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
@@ -114,6 +115,7 @@ void mtk_ccorr_ctm_set(struct device *dev, struct drm_crtc_state *state)
 	uint16_t coeffs[9] = { 0 };
 	int i;
 	struct cmdq_pkt *cmdq_pkt = NULL;
+	u32 matrix_bits = ccorr->data->matrix_bits;
 
 	if (!blob)
 		return;
@@ -122,7 +124,7 @@ void mtk_ccorr_ctm_set(struct device *dev, struct drm_crtc_state *state)
 	input = ctm->matrix;
 
 	for (i = 0; i < ARRAY_SIZE(coeffs); i++)
-		coeffs[i] = mtk_ctm_s31_32_to_s1_10(input[i]);
+		coeffs[i] = mtk_ctm_s31_32_to_s1_n(input[i], matrix_bits);
 
 	mtk_ddp_write(cmdq_pkt, coeffs[0] << 16 | coeffs[1],
 		      &ccorr->cmdq_reg, ccorr->regs, DISP_CCORR_COEF_0);
@@ -199,8 +201,13 @@ static int mtk_disp_ccorr_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct mtk_disp_ccorr_data mt8183_ccorr_driver_data = {
+	.matrix_bits = 10,
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

