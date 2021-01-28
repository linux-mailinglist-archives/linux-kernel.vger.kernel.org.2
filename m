Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919F23074B6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 12:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhA1LZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 06:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhA1LYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 06:24:49 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90667C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 03:23:35 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id u4so4100505pjn.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 03:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JFDIHF7A4xcJQCMZd2qVFd4aLKExesv1nCxMC8zcGnE=;
        b=oCMMsElsQjsYPCn7s2OLoPRchtAGewDclcCB5Q6GrqZA5TKeMKJPxdvzz6h5bJ889o
         dwktzpXo1aQ3vUb5IXfxY18SRSetXL1DRLDBttfCpGcP2Y+vDLMHzjjdVmmDqQSE70ed
         iHV7J2Vf+J+/L9+HQcJ6smMrv1O8bdvOxxEEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JFDIHF7A4xcJQCMZd2qVFd4aLKExesv1nCxMC8zcGnE=;
        b=Q7qKu4oy0lXkLBlwuZcmR28mrmNS9K6v/2N6TqALlzFzvucqKKb6bU7fyUDm1WzvLn
         gHBWg8YdA0Fg+KXLbhJfhinpCWopTyhRiLNPgNc4gwouvlnsyK0+drtXZpDaIJvzCkw/
         n88EeMBpSzyOAmVvULvgMjbBY7EuPU+IZEeU6HKtU8JHZ+/cXeZQez6ntDWqYIG9R14i
         nYjtVbveqRUr8nJ/5TYB8T39Nkd42hf8PgXimWiMIF0KClG7z0bl82uEzjZFBK3KXEqH
         3RrcnyeI8gurSHxNQH6XaYAvPOKkzVRa6xJ+3UR7kXW94XHFblM5bFrVZtTncB4BQeT9
         +WWw==
X-Gm-Message-State: AOAM531PI7U3tkfBrQ4vEANO9YkmjEuOoPORS5PjI0h9Rd4bko4QzoOb
        Vnd5Q/+JFbJWvxJp+y5+86JqSg==
X-Google-Smtp-Source: ABdhPJxvKZHW3iC9gdjoGC9Ej9lSJzioxFB5NLyQI/sXvEHdrcLtbheh/V1Xf/BpFNPjD0XrWJfwgg==
X-Received: by 2002:a17:902:8342:b029:e1:6aa:d770 with SMTP id z2-20020a1709028342b02900e106aad770mr7671394pln.27.1611833015130;
        Thu, 28 Jan 2021 03:23:35 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:e0a5:d2fc:aaad:1e4a])
        by smtp.gmail.com with ESMTPSA id j198sm3138315pfd.71.2021.01.28.03.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 03:23:34 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v12 6/8] drm/mediatek: enable dither function
Date:   Thu, 28 Jan 2021 19:23:12 +0800
Message-Id: <20210128112314.1304160-7-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210128112314.1304160-1-hsinyi@chromium.org>
References: <20210128112314.1304160-1-hsinyi@chromium.org>
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
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index ac2cb25620357..6c8f246380a74 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -53,6 +53,7 @@
 #define DITHER_EN				BIT(0)
 #define DISP_DITHER_CFG				0x0020
 #define DITHER_RELAY_MODE			BIT(0)
+#define DITHER_ENGINE_EN			BIT(1)
 #define DISP_DITHER_SIZE			0x0030
 
 #define LUT_10BIT_MASK				0x03ff
@@ -314,9 +315,19 @@ static void mtk_dither_config(struct device *dev, unsigned int w,
 			      unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
 {
 	struct mtk_ddp_comp_dev *priv = dev_get_drvdata(dev);
+	bool enable = (bpc == 5 || bpc == 6);
 
-	mtk_ddp_write(cmdq_pkt, h << 16 | w, &priv->cmdq_reg, priv->regs, DISP_DITHER_SIZE);
-	mtk_ddp_write(cmdq_pkt, DITHER_RELAY_MODE, &priv->cmdq_reg, priv->regs, DISP_DITHER_CFG);
+	if (enable) {
+		mtk_dither_set_common(priv->regs, &priv->cmdq_reg, bpc,
+				      DISP_DITHER_CFG, DITHER_ENGINE_EN,
+				      cmdq_pkt);
+	} else {
+		mtk_ddp_write(cmdq_pkt, DITHER_RELAY_MODE, &priv->cmdq_reg,
+			      priv->regs, DISP_DITHER_CFG);
+	}
+
+	mtk_ddp_write(cmdq_pkt, h << 16 | w, &priv->cmdq_reg, priv->regs,
+		      DISP_DITHER_SIZE);
 }
 
 static void mtk_dither_start(struct device *dev)
-- 
2.30.0.280.ga3ce27912f-goog

