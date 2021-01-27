Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3F03051E0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 06:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbhA0FTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 00:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238793AbhA0E5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 23:57:55 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B122C06178A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 20:54:44 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id m6so422000pfk.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 20:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kku5mUfG6ArzofT8Gp0G6Y6k/YXISfCSiI9xyZoXKqQ=;
        b=X5vP6xGTjUSeHE8naRaj4k/+Ch2Dg3rD0xr7wvpLCEmw8icxmNbTF2b7LI5A1AweXw
         ZHL+sT/Tkg10+Vjdq54CuPhsH5KAk/W501skMzJRDYOb6vTO9j1Z1vGhXzbScVf9qVBU
         yeKZQQ/4sM/E3YSVqJFHrTa4gyKCxqkRM2SdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kku5mUfG6ArzofT8Gp0G6Y6k/YXISfCSiI9xyZoXKqQ=;
        b=lfqr1Yb5cNYB1Ob4iD9fOYH4AOuSizAYmF2/oS9wOAylgPOhvCvbla7bzlZTEfZWpZ
         UZr1IkVksiNo9ZA9C5K5exNPpyC2AbLGUQ99O7ZO5ads0cWEy3RmToXGH8oppjx/6dn5
         yyIK90fJPG3suk2ETdWgtzf3+686etpAAoNslVotjMlN2LM2Kp5hHWO9A6M43pTz8Kwp
         xVxM2/pxHUKNgN90MrJFVNaYHRPTI3sl8EOSs85D0sZEuYf+TNR7R1uNLoMQuwhdYCiU
         emZrsyrfv9jTnvCwS0sH+2E36VcRtYAXdz6mlnjV4nNbRH4fWDAPnny7uYOXmb8dU5QF
         V3Ew==
X-Gm-Message-State: AOAM533F2rx2SlkM1vEDu8q45sbGQ8qTdOjtRiZBKKS1iFC44V2j9fDM
        ZneTkBxYWC2kpAzXGe0GoTkMUQ==
X-Google-Smtp-Source: ABdhPJw2cxb7tmc6QqJmdJ2QhCqQtOU+GGW+9Ce5oeS5V3z8NOuwcxgrUep+Xy1tAJkmYlz44icQgA==
X-Received: by 2002:a63:2009:: with SMTP id g9mr9225513pgg.219.1611723283660;
        Tue, 26 Jan 2021 20:54:43 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:e0a5:d2fc:aaad:1e4a])
        by smtp.gmail.com with ESMTPSA id a141sm684484pfa.189.2021.01.26.20.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 20:54:43 -0800 (PST)
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
Subject: [PATCH v10 4/9] drm/mediatek: generalize mtk_dither_set() function
Date:   Wed, 27 Jan 2021 12:54:17 +0800
Message-Id: <20210127045422.2418917-5-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210127045422.2418917-1-hsinyi@chromium.org>
References: <20210127045422.2418917-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There may be data structure other than mtk_ddp_comp_dev that would call
mtk_dither_set(), so use regs as parameter instead of device.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_disp_drv.h     |  4 ++++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 25 +++++++++++++--------
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_drv.h b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
index 46d199b7b4a29..c50d5fc9fd349 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
@@ -17,6 +17,10 @@ void mtk_color_config(struct device *dev, unsigned int w,
 		      unsigned int bpc, struct cmdq_pkt *cmdq_pkt);
 void mtk_color_start(struct device *dev);
 
+void mtk_dither_set_common(void __iomem *regs, struct cmdq_client_reg *cmdq_reg,
+			   unsigned int bpc, unsigned int CFG,
+			   struct cmdq_pkt *cmdq_pkt);
+
 void mtk_dpi_start(struct device *dev);
 void mtk_dpi_stop(struct device *dev);
 
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 7b5293429426d..53d25823a37cc 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -151,33 +151,40 @@ static void mtk_ddp_clk_disable(struct device *dev)
 	clk_disable_unprepare(priv->clk);
 }
 
-static void mtk_dither_set(struct device *dev, unsigned int bpc,
-		    unsigned int CFG, struct cmdq_pkt *cmdq_pkt)
-{
-	struct mtk_ddp_comp_dev *priv = dev_get_drvdata(dev);
 
+void mtk_dither_set_common(void __iomem *regs, struct cmdq_client_reg *cmdq_reg,
+			   unsigned int bpc, unsigned int CFG, struct cmdq_pkt *cmdq_pkt)
+{
 	/* If bpc equal to 0, the dithering function didn't be enabled */
 	if (bpc == 0)
 		return;
 
 	if (bpc >= MTK_MIN_BPC) {
-		mtk_ddp_write(cmdq_pkt, 0, &priv->cmdq_reg, priv->regs, DISP_DITHER_5);
-		mtk_ddp_write(cmdq_pkt, 0, &priv->cmdq_reg, priv->regs, DISP_DITHER_7);
+		mtk_ddp_write(cmdq_pkt, 0, cmdq_reg, regs, DISP_DITHER_5);
+		mtk_ddp_write(cmdq_pkt, 0, cmdq_reg, regs, DISP_DITHER_7);
 		mtk_ddp_write(cmdq_pkt,
 			      DITHER_LSB_ERR_SHIFT_R(MTK_MAX_BPC - bpc) |
 			      DITHER_ADD_LSHIFT_R(MTK_MAX_BPC - bpc) |
 			      DITHER_NEW_BIT_MODE,
-			      &priv->cmdq_reg, priv->regs, DISP_DITHER_15);
+			      cmdq_reg, regs, DISP_DITHER_15);
 		mtk_ddp_write(cmdq_pkt,
 			      DITHER_LSB_ERR_SHIFT_B(MTK_MAX_BPC - bpc) |
 			      DITHER_ADD_LSHIFT_B(MTK_MAX_BPC - bpc) |
 			      DITHER_LSB_ERR_SHIFT_G(MTK_MAX_BPC - bpc) |
 			      DITHER_ADD_LSHIFT_G(MTK_MAX_BPC - bpc),
-			      &priv->cmdq_reg, priv->regs, DISP_DITHER_16);
-		mtk_ddp_write(cmdq_pkt, DISP_DITHERING, &priv->cmdq_reg, priv->regs, CFG);
+			      cmdq_reg, regs, DISP_DITHER_16);
+		mtk_ddp_write(cmdq_pkt, DISP_DITHERING, cmdq_reg, regs, CFG);
 	}
 }
 
+static void mtk_dither_set(struct device *dev, unsigned int bpc,
+		    unsigned int CFG, struct cmdq_pkt *cmdq_pkt)
+{
+	struct mtk_ddp_comp_dev *priv = dev_get_drvdata(dev);
+
+	mtk_dither_set_common(priv->regs, &priv->cmdq_reg, bpc, CFG, cmdq_pkt);
+}
+
 static void mtk_od_config(struct device *dev, unsigned int w,
 			  unsigned int h, unsigned int vrefresh,
 			  unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
-- 
2.30.0.280.ga3ce27912f-goog

