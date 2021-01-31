Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4587309A53
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 06:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhAaFMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 00:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhAaFLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 00:11:48 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50577C061573
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 21:11:05 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id s24so8375787pjp.5
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 21:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j678qJx/JPZkac4bEG/8rI07bilrUpTVTBhhwHGCLyE=;
        b=HVch7Qv7dq+iRZl0F7OTOFc01KRsOkitFn7szOaZ9AduniQxvk4XBoFLuthP8Kv6+0
         Plhwxk/rCbQwhF4rXRcgnKJqGrjCIonm0eYQsveQ2gVikK3JsdbZbzJnH6djhj1w6gIn
         +KOVbeHocLUgCb2ZDLZ7kmf5WqLdirwI4T2OY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j678qJx/JPZkac4bEG/8rI07bilrUpTVTBhhwHGCLyE=;
        b=cA+ShPK+NkyGXEfhYikqcf7FKXf8UtjPyjResKWnzRBRcVzBaIaZ5gpSuYsPWe/UtN
         /dTP2BjpeT40xJoj0z3G9SwhYRbbZxQRBRvfrZHyIVbDbOzwHdd70IUGripE63VlOH4X
         gIO39+ZzIcT4xTa7E4ZpYQdm/RmwufeCLVZjs5f315HLvIpzF+2lIC9bai+wcSfEBsXg
         U07S/J9ZPpI0XyyKrkIQwiioXc00XPsxpkIfE5zVKRwfYftFlFwxNEVxHqqzTE8H2Gyf
         Pv2WhxD76y2IAxxOGm7QPCO/mDoiGz6j1dWLhnTrnHIhBJSqvTQVHaWfyNxiuhFgJYfw
         AqHQ==
X-Gm-Message-State: AOAM5303WYbXwpNsC159MSR+SlHdVAj49kg4Saap+6ZBa3J0FD1YKIcG
        KXftP5JGcFQjiaXa4nc4JyJsOQ==
X-Google-Smtp-Source: ABdhPJw5rGGPEQ8dqERgZpeHNpM1Tn38J69RC4BmBr0NM6uPyiS94+8Vq5WTIlas3qzw4/OIei1tzw==
X-Received: by 2002:a17:90b:60c:: with SMTP id gb12mr11373176pjb.125.1612069865252;
        Sat, 30 Jan 2021 21:11:05 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:35ef:a870:bb74:2590])
        by smtp.gmail.com with ESMTPSA id d22sm11470680pjv.11.2021.01.30.21.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 21:11:04 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH] drm/mediatek: enable dither function
Date:   Sun, 31 Jan 2021 13:10:58 +0800
Message-Id: <20210131051058.3407985-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

Enable dither function to improve the display quality.

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
Previous version:
https://patchwork.kernel.org/project/linux-mediatek/patch/20210129092209.2584718-7-hsinyi@chromium.org/
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index c730029ac8fc7..0444b429daf00 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -53,6 +53,7 @@
 #define DITHER_EN				BIT(0)
 #define DISP_DITHER_CFG				0x0020
 #define DITHER_RELAY_MODE			BIT(0)
+#define DITHER_ENGINE_EN			BIT(1)
 #define DISP_DITHER_SIZE			0x0030
 
 #define LUT_10BIT_MASK				0x03ff
@@ -315,8 +316,12 @@ static void mtk_dither_config(struct device *dev, unsigned int w,
 {
 	struct mtk_ddp_comp_dev *priv = dev_get_drvdata(dev);
 
-	mtk_ddp_write(cmdq_pkt, h << 16 | w, &priv->cmdq_reg, priv->regs, DISP_DITHER_SIZE);
-	mtk_ddp_write(cmdq_pkt, DITHER_RELAY_MODE, &priv->cmdq_reg, priv->regs, DISP_DITHER_CFG);
+	mtk_ddp_write(cmdq_pkt, h << 16 | w, &priv->cmdq_reg, priv->regs,
+		      DISP_DITHER_SIZE);
+	mtk_ddp_write(cmdq_pkt, DITHER_RELAY_MODE, &priv->cmdq_reg, priv->regs,
+		      DISP_DITHER_CFG);
+	mtk_dither_set_common(priv->regs, &priv->cmdq_reg, bpc, DISP_DITHER_CFG,
+			      DITHER_ENGINE_EN, cmdq_pkt);
 }
 
 static void mtk_dither_start(struct device *dev)
-- 
2.30.0.365.g02bc693789-goog

