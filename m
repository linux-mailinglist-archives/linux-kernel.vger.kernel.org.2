Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88EC43074F9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 12:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbhA1Lkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 06:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbhA1Lke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 06:40:34 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32BFC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 03:39:53 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id f11so5904742ljm.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 03:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HQ+u3UyNDrSG8w8P4bWJTRtBw00axMuz2NHEptw9qMc=;
        b=JDK1CHKmHnqF0SNxr0KEAoxPntDUGk08HoY2kXkTn23Z5YDZXerEM+VgR1OGuAPSKh
         BhPSMezatng/UQA+pBy2Rk/FF68x0dlWmlLReOJNnPe4QCeuTVvwTiv5uehEJ2PHjvCL
         7zv69Q0+fm7Zne4XHFMp8b/rVgKwKo3SCJ3bRIuZypFUnLs3hw8legbDGDH6k2PMvum/
         VRWOYLR1uz8us+cByhGKpEA3MBhgun6VbomUKQibL44kTNlRtu4jd6GV8jy9ejsoKkS6
         uuQFBOoFITchl7Vmtr2nbB2V/JgHo/vQQ/WgqS/+y7aUXA03CIYOA1NqPJuVvaslopwT
         A2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HQ+u3UyNDrSG8w8P4bWJTRtBw00axMuz2NHEptw9qMc=;
        b=m6AQaxVGF+fqdy5Gzix9gRhfMN1pyjnhWXa9EwzkqfGILz9ADUpHPXiHY3GattOV6u
         tlmtaDKNrS2EIRDZ1tKC7coXHeBPMLVSbVUeXdZXNLH/X1HVLXoJ7Vnr2ru2S/3eAhv2
         ltG+RVnyYxVjbuvWxzJbHolLx8jx/om9RczLTBFIA4HGljTFK8PoT/V+7zikLNg8kJtD
         Gjuo/QygPtFVKTnSt80IxNSnZo+uvH9bw+6gEUCH9R0wzTX5Y5naG9RBWhtCux8UnDgH
         Lp8CPniE+H2pWMY3aE0yWQwoagu5kVHulJEKY1aLwciqbEWuJGa19oFfbSiu/qoBRlgL
         ohrw==
X-Gm-Message-State: AOAM531DLF3N7bZxcdEYsYRfq7wM7S0FbsceU+ECvPwLkI+rTh00PXqO
        wF2OdM9xUQGI0gtUE9Fh6ZfnqImBQoaOcg==
X-Google-Smtp-Source: ABdhPJxrep+R54XMP2qS70YqhC34lawdwV2LlUl8//yAIp1kSuuqa30RgfAXDRpZxarE9LRdSE9uBQ==
X-Received: by 2002:a2e:89cb:: with SMTP id c11mr8064091ljk.98.1611833991953;
        Thu, 28 Jan 2021 03:39:51 -0800 (PST)
Received: from localhost.localdomain ([188.163.52.44])
        by smtp.gmail.com with ESMTPSA id t4sm1934697ljc.50.2021.01.28.03.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 03:39:51 -0800 (PST)
From:   Roman Stratiienko <r.stratiienko@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     mripard@kernel.org, wens@csie.org, jernej.skrabec@siol.net,
        megous@megous.com, linux-sunxi@googlegroups.com,
        dri-devel@lists.freedesktop.org,
        Roman Stratiienko <r.stratiienko@gmail.com>
Subject: [PATCH v5 2/2] drm/sun4i: Add alpha property for sun8i and sun50i VI layer
Date:   Thu, 28 Jan 2021 13:39:40 +0200
Message-Id: <20210128113940.347013-3-r.stratiienko@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210128113940.347013-1-r.stratiienko@gmail.com>
References: <20210128113940.347013-1-r.stratiienko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DE3.0 VI layers supports plane-global alpha channel.
DE2.0 FCC block have GLOBAL_ALPHA register that can be used as alpha source
for blender.

Add alpha property to the DRM plane and connect it to the
corresponding registers in the mixer.

Do not add alpha property for V3s SOC that have DE2.0 and 2 VI planes.

Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 48 +++++++++++++++++++++-----
 drivers/gpu/drm/sun4i/sun8i_vi_layer.h | 11 ++++++
 2 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index 76393fc976fe..684462ce2a9b 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -66,6 +66,36 @@ static void sun8i_vi_layer_enable(struct sun8i_mixer *mixer, int channel,
 	}
 }
 
+static void sun8i_vi_layer_update_alpha(struct sun8i_mixer *mixer, int channel,
+					int overlay, struct drm_plane *plane)
+{
+	u32 mask, val, ch_base;
+
+	ch_base = sun8i_channel_base(mixer, channel);
+
+	if (mixer->cfg->is_de3) {
+		mask = SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MASK |
+		       SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MODE_MASK;
+		val = SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA
+			(plane->state->alpha >> 8);
+
+		val |= (plane->state->alpha == DRM_BLEND_ALPHA_OPAQUE) ?
+			SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MODE_PIXEL :
+			SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MODE_COMBINED;
+
+		regmap_update_bits(mixer->engine.regs,
+				   SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base,
+								  overlay),
+				   mask, val);
+	} else if (mixer->cfg->vi_num == 1) {
+		regmap_update_bits(mixer->engine.regs,
+				   SUN8I_MIXER_FCC_GLOBAL_ALPHA_REG,
+				   SUN8I_MIXER_FCC_GLOBAL_ALPHA_MASK,
+				   SUN8I_MIXER_FCC_GLOBAL_ALPHA
+					(plane->state->alpha >> 8));
+	}
+}
+
 static int sun8i_vi_layer_update_coord(struct sun8i_mixer *mixer, int channel,
 				       int overlay, struct drm_plane *plane,
 				       unsigned int zpos)
@@ -268,14 +298,6 @@ static int sun8i_vi_layer_update_formats(struct sun8i_mixer *mixer, int channel,
 			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base, overlay),
 			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR_RGB_MODE, val);
 
-	/* It seems that YUV formats use global alpha setting. */
-	if (mixer->cfg->is_de3)
-		regmap_update_bits(mixer->engine.regs,
-				   SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base,
-								  overlay),
-				   SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MASK,
-				   SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA(0xff));
-
 	return 0;
 }
 
@@ -393,6 +415,8 @@ static void sun8i_vi_layer_atomic_update(struct drm_plane *plane,
 
 	sun8i_vi_layer_update_coord(mixer, layer->channel,
 				    layer->overlay, plane, zpos);
+	sun8i_vi_layer_update_alpha(mixer, layer->channel,
+				    layer->overlay, plane);
 	sun8i_vi_layer_update_formats(mixer, layer->channel,
 				      layer->overlay, plane);
 	sun8i_vi_layer_update_buffer(mixer, layer->channel,
@@ -534,6 +558,14 @@ struct sun8i_vi_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
 
 	plane_cnt = mixer->cfg->ui_num + mixer->cfg->vi_num;
 
+	if (mixer->cfg->vi_num == 1 || mixer->cfg->is_de3) {
+		ret = drm_plane_create_alpha_property(&layer->plane);
+		if (ret) {
+			dev_err(drm->dev, "Couldn't add alpha property\n");
+			return ERR_PTR(ret);
+		}
+	}
+
 	ret = drm_plane_create_zpos_property(&layer->plane, index,
 					     0, plane_cnt - 1);
 	if (ret) {
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.h b/drivers/gpu/drm/sun4i/sun8i_vi_layer.h
index eaa6076f5dbc..48c399e1c86d 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.h
@@ -29,14 +29,25 @@
 #define SUN8I_MIXER_CHAN_VI_VDS_UV(base) \
 		((base) + 0xfc)
 
+#define SUN8I_MIXER_FCC_GLOBAL_ALPHA_REG \
+		(0xAA000 + 0x90)
+
+#define SUN8I_MIXER_FCC_GLOBAL_ALPHA(x)			((x) << 24)
+#define SUN8I_MIXER_FCC_GLOBAL_ALPHA_MASK		GENMASK(31, 24)
+
 #define SUN8I_MIXER_CHAN_VI_LAYER_ATTR_EN		BIT(0)
 /* RGB mode should be set for RGB formats and cleared for YCbCr */
 #define SUN8I_MIXER_CHAN_VI_LAYER_ATTR_RGB_MODE		BIT(15)
 #define SUN8I_MIXER_CHAN_VI_LAYER_ATTR_FBFMT_OFFSET	8
 #define SUN8I_MIXER_CHAN_VI_LAYER_ATTR_FBFMT_MASK	GENMASK(12, 8)
+#define SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MODE_MASK	GENMASK(2, 1)
 #define SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MASK	GENMASK(31, 24)
 #define SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA(x)	((x) << 24)
 
+#define SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MODE_PIXEL	((0) << 1)
+#define SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MODE_LAYER	((1) << 1)
+#define SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MODE_COMBINED	((2) << 1)
+
 #define SUN8I_MIXER_CHAN_VI_DS_N(x)			((x) << 16)
 #define SUN8I_MIXER_CHAN_VI_DS_M(x)			((x) << 0)
 
-- 
2.27.0

