Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049793074F8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 12:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbhA1Lkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 06:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbhA1Lkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 06:40:32 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FE3C061756
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 03:39:52 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 3so5927674ljc.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 03:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GwaK0ImJaC9c729h1o/PYM4X2HOiHraHW9/VM2R/O6o=;
        b=Q25E3kmtsgjZS2WHGCmhD0UbDB5COo4hjuuoI5Rbw6WQQy3jLJsEjeILxTWNEE4AeE
         C9DyR7wiMzwZShVXNZh/z3cYFQJOAgJf/N42K5hawJd2DONxTZh0rSFzhWARxboxKppr
         jiaNtOcIHfge2ypZO+lT6KDS8MvKBMky0FFAjbOgB6sY20kK8mZfkAQynD/HUD8aVA1e
         htibBP4OGWH07eXzBvn//EYu1ij/dqe3XKdcU20B/TIo/033jiq1p8r5hzumL0UJnMbL
         Mlq279uKlaKVIy4UuYIumMg7RjFsSyYvhQAsOyUXCMn4YQ2CgUDdyOHFoUWGzCkwsO11
         6BRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GwaK0ImJaC9c729h1o/PYM4X2HOiHraHW9/VM2R/O6o=;
        b=rLT0gGFKwzCyLIttcuVW0O++ryUklRFDHkqe9b7kqKTXtilee2L7UFQRmMWRfvDZAo
         62SeuQG41OEQtTdX+JiKTSRYzH2/nFFfijrZJBpGDnB8Nqw+w+PMMitXZMIGy7JjDrgS
         PH+meuEOOhz/vq04dlRYfQLsfTa6NtWet7lzBirLDlZrrJHcLVcmAcjB7XdUI5EH3sbE
         4zEH/m4HvsOq0Fr/9iBrUQxiBtkXTDV4hIeQRH9DhVn8s8WEOZAZOVKeLCD/8H+t838i
         DM7W8sdLxSmtcy3QHZg8EKwViKYR8kzi4vnIDpEVg8wk31vOG5rgYXGHelCnYWliXpmE
         fhlg==
X-Gm-Message-State: AOAM5329BXcKFrB9awZM71UyEb1aVXaO7RBPGwW69TrXP0yjXAzJUGeQ
        T6Pe/2YBqcEQiL+GbNqTZKMVWYT14w/9rQ==
X-Google-Smtp-Source: ABdhPJzwCLaVLwtBPURsCwIT7hYOp1mbLY8rHXJ2rMJkyoLxQSmNnppCuPCbOuXb1VJ7ONI7GDkpGA==
X-Received: by 2002:a2e:3515:: with SMTP id z21mr7941384ljz.73.1611833990610;
        Thu, 28 Jan 2021 03:39:50 -0800 (PST)
Received: from localhost.localdomain ([188.163.52.44])
        by smtp.gmail.com with ESMTPSA id t4sm1934697ljc.50.2021.01.28.03.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 03:39:50 -0800 (PST)
From:   Roman Stratiienko <r.stratiienko@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     mripard@kernel.org, wens@csie.org, jernej.skrabec@siol.net,
        megous@megous.com, linux-sunxi@googlegroups.com,
        dri-devel@lists.freedesktop.org,
        Roman Stratiienko <r.stratiienko@gmail.com>
Subject: [PATCH v5 1/2] drm/sun4i: Add alpha property for sun8i UI layer
Date:   Thu, 28 Jan 2021 13:39:39 +0200
Message-Id: <20210128113940.347013-2-r.stratiienko@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210128113940.347013-1-r.stratiienko@gmail.com>
References: <20210128113940.347013-1-r.stratiienko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DE2.0 and DE3.0 UI layers supports plane-global alpha channel.
Add alpha property to the DRM plane and connect it to the
corresponding registers in mixer.

Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 29 ++++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun8i_ui_layer.h |  5 +++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
index 816ad4ce8996..e64f30595f64 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -72,6 +72,27 @@ static void sun8i_ui_layer_enable(struct sun8i_mixer *mixer, int channel,
 	}
 }
 
+static void sun8i_ui_layer_update_alpha(struct sun8i_mixer *mixer, int channel,
+					int overlay, struct drm_plane *plane)
+{
+	u32 mask, val, ch_base;
+
+	ch_base = sun8i_channel_base(mixer, channel);
+
+	mask = SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_MASK |
+		SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MASK;
+
+	val = SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA(plane->state->alpha >> 8);
+
+	val |= (plane->state->alpha == DRM_BLEND_ALPHA_OPAQUE) ?
+		SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_PIXEL :
+		SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_COMBINED;
+
+	regmap_update_bits(mixer->engine.regs,
+			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(ch_base, overlay),
+			   mask, val);
+}
+
 static int sun8i_ui_layer_update_coord(struct sun8i_mixer *mixer, int channel,
 				       int overlay, struct drm_plane *plane,
 				       unsigned int zpos)
@@ -290,6 +311,8 @@ static void sun8i_ui_layer_atomic_update(struct drm_plane *plane,
 
 	sun8i_ui_layer_update_coord(mixer, layer->channel,
 				    layer->overlay, plane, zpos);
+	sun8i_ui_layer_update_alpha(mixer, layer->channel,
+				    layer->overlay, plane);
 	sun8i_ui_layer_update_formats(mixer, layer->channel,
 				      layer->overlay, plane);
 	sun8i_ui_layer_update_buffer(mixer, layer->channel,
@@ -367,6 +390,12 @@ struct sun8i_ui_layer *sun8i_ui_layer_init_one(struct drm_device *drm,
 
 	plane_cnt = mixer->cfg->ui_num + mixer->cfg->vi_num;
 
+	ret = drm_plane_create_alpha_property(&layer->plane);
+	if (ret) {
+		dev_err(drm->dev, "Couldn't add alpha property\n");
+		return ERR_PTR(ret);
+	}
+
 	ret = drm_plane_create_zpos_property(&layer->plane, channel,
 					     0, plane_cnt - 1);
 	if (ret) {
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.h b/drivers/gpu/drm/sun4i/sun8i_ui_layer.h
index f4ab1cf6cded..e3e32ee1178d 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.h
@@ -40,6 +40,11 @@
 #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_MASK	GENMASK(12, 8)
 #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_OFFSET	8
 #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MASK	GENMASK(31, 24)
+#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA(x)		((x) << 24)
+
+#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_PIXEL		((0) << 1)
+#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_LAYER		((1) << 1)
+#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_COMBINED	((2) << 1)
 
 struct sun8i_mixer;
 
-- 
2.27.0

