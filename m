Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2796930868F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 08:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhA2Hhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 02:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbhA2HgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 02:36:06 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29616C06178A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 23:34:52 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id w18so5683709pfu.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 23:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jv+2JS9/1bK95pcHO0im9CAvoGtup1mDnivR04MejrA=;
        b=Wy5bJ3qFy8UxMKk04MxCVxkLzslgVcgIeUbeQqPPmUzi9N0uI/soGqP0zn1SWneXZp
         +FxeEOPdJgn6o8wRppIJC1X/QPu7VCWr2uMkRcm6IVX8GGQcJSEuuYI2nHYoSc25b5wu
         ARK5VW6qltB3qy1xNer6u33+8erAECyJOl40E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jv+2JS9/1bK95pcHO0im9CAvoGtup1mDnivR04MejrA=;
        b=uhHImTnUVeZsLRUNSEmiIBc9LABKoRuVTdQqd2DVxM0WuY//7T9ROxa0+QTEVnNCD6
         CywiuiMtK2sr6j8l0BVjsT7udU4ciQcPMUk2D+2wpm7TeuvaQ8pbPYjv+518CfWK2aOO
         PhG0a8akelAPSy9D227zG9JcYGcUjCoZZuI5IS4k+rPLFxHcOFjnkqpTNdLLyFSybs7E
         R2Z+DnPQVqTA8oYlNfS3kYHiJGQwqsdZ2LhwEBYIxR7RSkjiTGgh7W1U2cQZCg9wEhc9
         awIH43foNNQzkBeld9JYKSkxsBJiBNFw4ak9Jupyi393cxULA0lY9+d5OnWvZ76lqaYv
         /u+g==
X-Gm-Message-State: AOAM533br3kwuK7fhbhu/o61Ma3PITjwf1+O/Ea3t1JUEM83qUyuNFM7
        XlyEnzHN0k5nL25wdUolXWtVSA==
X-Google-Smtp-Source: ABdhPJwf69hCMciq2Y+DX8eJKfTvpms85Hit7oril+FLzlt6OiRN8iWLPAuxIiAP5jzf6DYCWVnVGA==
X-Received: by 2002:a65:498e:: with SMTP id r14mr3481282pgs.235.1611905691669;
        Thu, 28 Jan 2021 23:34:51 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:51f1:c468:a70b:7c09])
        by smtp.gmail.com with ESMTPSA id p1sm7689980pfn.21.2021.01.28.23.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 23:34:51 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v4 4/8] drm/mediatek: enable OVL_LAYER_SMI_ID_EN for multi-layer usecase
Date:   Fri, 29 Jan 2021 15:34:32 +0800
Message-Id: <20210129073436.2429834-5-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210129073436.2429834-1-hsinyi@chromium.org>
References: <20210129073436.2429834-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

enable OVL_LAYER_SMI_ID_EN for multi-layer usecase, without this patch,
ovl will hang up when more than 1 layer enabled.

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index da7e38a28759b..961f87f8d4d15 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -24,6 +24,7 @@
 #define DISP_REG_OVL_RST			0x0014
 #define DISP_REG_OVL_ROI_SIZE			0x0020
 #define DISP_REG_OVL_DATAPATH_CON		0x0024
+#define OVL_LAYER_SMI_ID_EN				BIT(0)
 #define OVL_BGCLR_SEL_IN				BIT(2)
 #define DISP_REG_OVL_ROI_BGCLR			0x0028
 #define DISP_REG_OVL_SRC_CON			0x002c
@@ -62,6 +63,7 @@ struct mtk_disp_ovl_data {
 	unsigned int gmc_bits;
 	unsigned int layer_nr;
 	bool fmt_rgb565_is_0;
+	bool smi_id_en;
 };
 
 /**
@@ -134,6 +136,13 @@ void mtk_ovl_start(struct device *dev)
 {
 	struct mtk_disp_ovl *ovl = dev_get_drvdata(dev);
 
+	if (ovl->data->smi_id_en) {
+		unsigned int reg;
+
+		reg = readl(ovl->regs + DISP_REG_OVL_DATAPATH_CON);
+		reg = reg | OVL_LAYER_SMI_ID_EN;
+		writel_relaxed(reg, ovl->regs + DISP_REG_OVL_DATAPATH_CON);
+	}
 	writel_relaxed(0x1, ovl->regs + DISP_REG_OVL_EN);
 }
 
@@ -142,6 +151,14 @@ void mtk_ovl_stop(struct device *dev)
 	struct mtk_disp_ovl *ovl = dev_get_drvdata(dev);
 
 	writel_relaxed(0x0, ovl->regs + DISP_REG_OVL_EN);
+	if (ovl->data->smi_id_en) {
+		unsigned int reg;
+
+		reg = readl(ovl->regs + DISP_REG_OVL_DATAPATH_CON);
+		reg = reg & ~OVL_LAYER_SMI_ID_EN;
+		writel_relaxed(reg, ovl->regs + DISP_REG_OVL_DATAPATH_CON);
+	}
+
 }
 
 void mtk_ovl_config(struct device *dev, unsigned int w,
-- 
2.30.0.365.g02bc693789-goog

