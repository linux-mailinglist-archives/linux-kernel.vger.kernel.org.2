Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A283051E7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 06:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbhA0FVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 00:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239736AbhA0FAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 00:00:11 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B91C0617A9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 20:54:53 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id w14so421224pfi.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 20:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TylT5ylvrSjXZkyDWey49Aq08z8epZnlbLmRvBO6dZo=;
        b=Tc+it0gmwJ+uU8imyifVsbbL0tQbg1r0O7axx2m5PQMU9SsOBEtnFIz7NJrws/tPdI
         sGXJung+g6yOpezvv8bsQ+dzp/YEkvO+r4tRawUuKH7LbV8ps8tSe6A+eNjRiJspo3iG
         AkLDVUg68g1bYXieR5XnjrNugfmkRY9hL3sbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TylT5ylvrSjXZkyDWey49Aq08z8epZnlbLmRvBO6dZo=;
        b=EZ5FhBlbI+e4Xh7fe8eOe4RNP6K7DddONIhxNqrtXUIcyAZqRBmzcaEYcrsAZ/YrWa
         x2TRUM2sscKXhTFtNv713QA9RNRn6sUgVnnJXhTi4blrqfV1vUlsBECH8+/gHAF+SVuT
         9JGXfNyJX2h/Uycz1cM2hdcDIzSNB1or7RBPeD8oJtgsnqzIiLOKiY06OkLgfrIyUMPJ
         CvNBffMkStPrujt6tM/RFGkmbkJxrjWagg1Hx/8h1KkikBgvov/4jFeq5wtPwuCFcLgU
         Fre4/h0kwAewGtzQUXWUAeLIjXpcpNXaYczDDSpF5nKKwCW0sOjLeMnQtnmRtLO17YnU
         7/LQ==
X-Gm-Message-State: AOAM530Ouk5pjoK4HR4qFIczRlKY4CZJ8LP6J3J7hf/PwumVztQr48Hd
        FrAcIpkKdO7w4T5VIsRPtDNB1w==
X-Google-Smtp-Source: ABdhPJyy01Q5a/LPZ4E7UcdQg5mKkFvVyYvr6fPjvcMa6xvNPlRFx5WzfjRFbv8mXDBUtrtl/OLw0g==
X-Received: by 2002:a62:5c43:0:b029:1bb:9418:b59b with SMTP id q64-20020a625c430000b02901bb9418b59bmr8642305pfb.35.1611723293345;
        Tue, 26 Jan 2021 20:54:53 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:e0a5:d2fc:aaad:1e4a])
        by smtp.gmail.com with ESMTPSA id a141sm684484pfa.189.2021.01.26.20.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 20:54:52 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v10 7/9] drm/mediatek: enable dither function
Date:   Wed, 27 Jan 2021 12:54:20 +0800
Message-Id: <20210127045422.2418917-8-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210127045422.2418917-1-hsinyi@chromium.org>
References: <20210127045422.2418917-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

for 5 or 6 bpc panel, we need enable dither function
to improve the display quality

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 37 ++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 8173f709272be..ee54505412dcd 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -53,7 +53,9 @@
 #define DITHER_EN				BIT(0)
 #define DISP_DITHER_CFG				0x0020
 #define DITHER_RELAY_MODE			BIT(0)
+#define DITHER_ENGINE_EN			BIT(1)
 #define DISP_DITHER_SIZE			0x0030
+#define DITHER_REG(idx)				(0x100 + (idx) * 4)
 
 #define LUT_10BIT_MASK				0x03ff
 
@@ -313,8 +315,41 @@ static void mtk_dither_config(struct device *dev, unsigned int w,
 {
 	struct mtk_ddp_comp_dev *priv = dev_get_drvdata(dev);
 
+	bool enable = true;
+
+	const u32 dither_setting[] = {
+		0x00000000, /* 5 */
+		0x00003002, /* 6 */
+		0x00000000, /* 7 */
+		0x00000000, /* 8 */
+		0x00000000, /* 9 */
+		0x00000000, /* 10 */
+		0x00000000, /* 11 */
+		0x00000011, /* 12 */
+		0x00000000, /* 13 */
+		0x00000000, /* 14 */
+	};
+
+	if (bpc == 6) {
+		mtk_ddp_write(cmdq_pkt, 0x40400001, &priv->cmdq_reg, priv->regs, DITHER_REG(15));
+		mtk_ddp_write(cmdq_pkt, 0x40404040, &priv->cmdq_reg, priv->regs, DITHER_REG(16));
+	} else if (bpc == 5) {
+		mtk_ddp_write(cmdq_pkt, 0x50500001, &priv->cmdq_reg, priv->regs, DITHER_REG(15));
+		mtk_ddp_write(cmdq_pkt, 0x50504040, &priv->cmdq_reg, priv->regs, DITHER_REG(16));
+	} else {
+		enable = false;
+	}
+
+	if (enable) {
+		u32 idx;
+
+		for (idx = 0; idx < ARRAY_SIZE(dither_setting); idx++)
+			mtk_ddp_write(cmdq_pkt, dither_setting[idx], &priv->cmdq_reg, priv->regs,
+				      DITHER_REG(idx + 5));
+	}
+
 	mtk_ddp_write(cmdq_pkt, h << 16 | w, &priv->cmdq_reg, priv->regs, DISP_DITHER_SIZE);
-	mtk_ddp_write(cmdq_pkt, DITHER_RELAY_MODE, &priv->cmdq_reg, priv->regs, DISP_DITHER_CFG);
+        mtk_ddp_write(cmdq_pkt, enable ? DITHER_ENGINE_EN : DITHER_RELAY_MODE, &priv->cmdq_reg, priv->regs, DISP_DITHER_CFG);
 }
 
 static void mtk_dither_start(struct device *dev)
-- 
2.30.0.280.ga3ce27912f-goog

