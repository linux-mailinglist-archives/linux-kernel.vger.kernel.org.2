Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3342B3074B3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 12:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhA1LZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 06:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbhA1LYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 06:24:45 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14389C061793
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 03:23:33 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id u15so3162770plf.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 03:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0GfJG1NolFJolLu0toUQEenQ6To6l1YhR3Wj2jMdwnY=;
        b=nbIK8k5HGwdeJPuiKijB8ehESstla+9kuSupW6ptPDFIvs+IExuXiO4nN+112Qx2yd
         +42oLP1FEv0owna6tg/baauqZ91TkRWxAvBV2dW9QKmhSO3D1BrbwFgkZOHzFtjMBVcN
         9wWiDgqZJ7vdJQIHITmZJmzww2NMkhTDbiuCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0GfJG1NolFJolLu0toUQEenQ6To6l1YhR3Wj2jMdwnY=;
        b=b9jOGZ+efoXlHzXVgUUYrePY97np+V4lqqV8MGab/rhxtW2zzeqE83WaapWr52b1bD
         DHMdEBwPX8wZ6wESldcJrAPvRv+zP9PiRKnlb9s9tLUKuqwr7Nnp+pIQ8IpYfo178gNm
         hsHNAs9Fn7ydchViEIhUaER/L3tl4Fh7MzZaftJC5JWJQvN5nMhdBbJQOdZbpfQ32YnU
         t4t3+GLDNQU22dXGxVd6K7LrMar/oiUb9k7bLYQ2UHxOpOlUOvnyD9gdmZy3HDZd+pBj
         8YFChRqKlGRW+XCbZcVZORlz/KwjSiWNkDJKvz8twc8vP1c7cdKL+fmXxibTJAKAtPRH
         CNew==
X-Gm-Message-State: AOAM531HRtKoGAIsajptaTAOgxq3ls4EjZJnzaVEpNzHtWeQcqk7ipx8
        6KW4yKjO8UZNbBZ7redEYnLpUw==
X-Google-Smtp-Source: ABdhPJwcmLQsIkjjvwkUVmik/AWHcieafkBYpo34fY2RntjPEZDLF3oQQR6ps4P1+m5z9CODqvjgNQ==
X-Received: by 2002:a17:90b:1196:: with SMTP id gk22mr10605229pjb.168.1611833012608;
        Thu, 28 Jan 2021 03:23:32 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:e0a5:d2fc:aaad:1e4a])
        by smtp.gmail.com with ESMTPSA id j198sm3138315pfd.71.2021.01.28.03.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 03:23:32 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v12 5/8] drm/mediatek: add has_dither private data for gamma
Date:   Thu, 28 Jan 2021 19:23:11 +0800
Message-Id: <20210128112314.1304160-6-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210128112314.1304160-1-hsinyi@chromium.org>
References: <20210128112314.1304160-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

Not all SoC has dither function in gamma module.
Add private data to control this function setting.

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
index 6b520807921e3..5092a27ccc28b 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
@@ -27,7 +27,7 @@
 #define LUT_10BIT_MASK				0x03ff
 
 struct mtk_disp_gamma_data {
-	u32 reserved;
+	bool has_dither;
 };
 
 /**
@@ -93,8 +93,9 @@ void mtk_gamma_config(struct device *dev, unsigned int w,
 
 	mtk_ddp_write(cmdq_pkt, h << 16 | w, &gamma->cmdq_reg, gamma->regs,
 		      DISP_GAMMA_SIZE);
-	mtk_dither_set_common(gamma->regs, &gamma->cmdq_reg, bpc, DISP_GAMMA_CFG,
-			      GAMMA_DITHERING, cmdq_pkt);
+	if (gamma->data && gamma->data->has_dither)
+		mtk_dither_set_common(gamma->regs, &gamma->cmdq_reg, bpc,
+				      DISP_GAMMA_CFG, GAMMA_DITHERING, cmdq_pkt);
 }
 
 void mtk_gamma_start(struct device *dev)
@@ -174,8 +175,13 @@ static int mtk_disp_gamma_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct mtk_disp_gamma_data mt8173_gamma_driver_data = {
+	.has_dither = true,
+};
+
 static const struct of_device_id mtk_disp_gamma_driver_dt_match[] = {
-	{ .compatible = "mediatek,mt8173-disp-gamma"},
+	{ .compatible = "mediatek,mt8173-disp-gamma",
+	  .data = &mt8173_gamma_driver_data},
 	{},
 };
 MODULE_DEVICE_TABLE(of, mtk_disp_gamma_driver_dt_match);
-- 
2.30.0.280.ga3ce27912f-goog

