Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37EE3947F7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 22:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbhE1Ucq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 16:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhE1Ucn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 16:32:43 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89FDC061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 13:31:06 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id b26so7065750lfq.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 13:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v8xVloNSwUArvoTMkBR5f76XblNpfoHgt5cDxTC0lU8=;
        b=qmiGFj0YDzYpAbQdR8x5Yzw+RgFdcINbUhgY4M21l4IJXs3PC9WFQmgtnicUC17QC3
         tvEQFiPhz/LgUV+zVIz0f9bOc1eLNAqHT9nqdkTw2BKI4riBH5yLSiVtYkgjXJWadpQM
         eZc5uIH934rlRmuMCTXpUqAmsYEaJqUW3h9grB9YcF9jr4ccC0kfzXMQj8dnmzIwQ7GQ
         LkhbfM51jjv6rf0ohZQfwv/wd5T8gQlbTXG7M+IjmN4+LR7i0MLmQphbH7MZ3h+sR/Wb
         Et4zhpi32ekhRkJE3WQ82gV+ZZFhsZrlePlKJwudDsCAKn6tNFacB878DtYadF+U/GZu
         /1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v8xVloNSwUArvoTMkBR5f76XblNpfoHgt5cDxTC0lU8=;
        b=rGr5brl0bnJz48VBYcvpBKDPgjioJOxlQxcMGx2FuPN4sHofJM3nOEazHQJ+FtKbNl
         gpsJeXn0CDGpMGYDXoAeV3LQF6twqA/lahUkpAyuHfkEwq6h+sINZJeofZmF5qv1Uv6U
         VC8G00bN7m19CDWywdeVTxblrop/QkOU+CJrc4+TR0IXT1iECLdETcutZG+pnA+crCxE
         fYHLCg0RUmnXS3DUyseMnI6C2c0ifYAFCI44wzm1aP6DGRjiu5upaJn0U1elJ15SdiiD
         v25/N5Y6ErMgcrT8XybGMMNBE9A47wtmYgVdXQglLCEeQAtw0C+WewV9dUxgrI4YwiYr
         +68g==
X-Gm-Message-State: AOAM533zaHKdYEACFLowJ7mRk+Gqrw18hvhFXFOkSecW7HjEbROOZkcU
        KAnyr+h0BNuMJqYKF28SnAohCCSlQfexrg==
X-Google-Smtp-Source: ABdhPJxvftq8FIoOxl5fmCcw1FqBhlWR+H/WUS+YRoLHTZHCt928nPBZeARvGEfkoohxkBgbI7JSYA==
X-Received: by 2002:a05:6512:31c2:: with SMTP id j2mr6708560lfe.69.1622233864968;
        Fri, 28 May 2021 13:31:04 -0700 (PDT)
Received: from roman-S500CA.. (72-28-179-94.pool.ukrtel.net. [94.179.28.72])
        by smtp.gmail.com with ESMTPSA id a12sm655820ljk.34.2021.05.28.13.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 13:31:04 -0700 (PDT)
From:   Roman Stratiienko <r.stratiienko@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     mripard@kernel.org, wens@csie.org, jernej.skrabec@siol.net,
        megous@megous.com, linux-sunxi@googlegroups.com,
        dri-devel@lists.freedesktop.org,
        Roman Stratiienko <r.stratiienko@gmail.com>
Subject: [PATCH v4 2/2] drm/sun4i: Use CRTC size instead of primary plane size as mixer frame
Date:   Fri, 28 May 2021 23:30:36 +0300
Message-Id: <20210528203036.17999-3-r.stratiienko@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210528203036.17999-1-r.stratiienko@gmail.com>
References: <20210528203036.17999-1-r.stratiienko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes corrupted display picture when primary plane isn't full-screen.

Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c    | 28 ++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 30 --------------------------
 2 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 5b42cf25cc86..810c731566c0 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -248,6 +248,33 @@ int sun8i_mixer_drm_format_to_hw(u32 format, u32 *hw_format)
 	return -EINVAL;
 }
 
+static void sun8i_mode_set(struct sunxi_engine *engine,
+			   struct drm_display_mode *mode)
+{
+	u32 size = SUN8I_MIXER_SIZE(mode->crtc_hdisplay, mode->crtc_vdisplay);
+	struct sun8i_mixer *mixer = engine_to_sun8i_mixer(engine);
+	u32 bld_base = sun8i_blender_base(mixer);
+	u32 val;
+
+	DRM_DEBUG_DRIVER("Mode change, updating global size W: %u H: %u\n",
+			 mode->crtc_hdisplay, mode->crtc_vdisplay);
+	regmap_write(mixer->engine.regs, SUN8I_MIXER_GLOBAL_SIZE, size);
+	regmap_write(mixer->engine.regs,
+		     SUN8I_MIXER_BLEND_OUTSIZE(bld_base), size);
+
+	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
+		val = SUN8I_MIXER_BLEND_OUTCTL_INTERLACED;
+	else
+		val = 0;
+
+	regmap_update_bits(mixer->engine.regs,
+			   SUN8I_MIXER_BLEND_OUTCTL(bld_base),
+			   SUN8I_MIXER_BLEND_OUTCTL_INTERLACED,
+			   val);
+	DRM_DEBUG_DRIVER("Switching display mixer interlaced mode %s\n",
+			 val ? "on" : "off");
+}
+
 static void sun8i_mixer_commit(struct sunxi_engine *engine)
 {
 	DRM_DEBUG_DRIVER("Committing changes\n");
@@ -301,6 +328,7 @@ static struct drm_plane **sun8i_layers_init(struct drm_device *drm,
 static const struct sunxi_engine_ops sun8i_engine_ops = {
 	.commit		= sun8i_mixer_commit,
 	.layers_init	= sun8i_layers_init,
+	.mode_set	= sun8i_mode_set,
 };
 
 static const struct regmap_config sun8i_mixer_regmap_config = {
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
index 0db164a774a1..d66fff582278 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -120,36 +120,6 @@ static int sun8i_ui_layer_update_coord(struct sun8i_mixer *mixer, int channel,
 	insize = SUN8I_MIXER_SIZE(src_w, src_h);
 	outsize = SUN8I_MIXER_SIZE(dst_w, dst_h);
 
-	if (plane->type == DRM_PLANE_TYPE_PRIMARY) {
-		bool interlaced = false;
-		u32 val;
-
-		DRM_DEBUG_DRIVER("Primary layer, updating global size W: %u H: %u\n",
-				 dst_w, dst_h);
-		regmap_write(mixer->engine.regs,
-			     SUN8I_MIXER_GLOBAL_SIZE,
-			     outsize);
-		regmap_write(mixer->engine.regs,
-			     SUN8I_MIXER_BLEND_OUTSIZE(bld_base), outsize);
-
-		if (state->crtc)
-			interlaced = state->crtc->state->adjusted_mode.flags
-				& DRM_MODE_FLAG_INTERLACE;
-
-		if (interlaced)
-			val = SUN8I_MIXER_BLEND_OUTCTL_INTERLACED;
-		else
-			val = 0;
-
-		regmap_update_bits(mixer->engine.regs,
-				   SUN8I_MIXER_BLEND_OUTCTL(bld_base),
-				   SUN8I_MIXER_BLEND_OUTCTL_INTERLACED,
-				   val);
-
-		DRM_DEBUG_DRIVER("Switching display mixer interlaced mode %s\n",
-				 interlaced ? "on" : "off");
-	}
-
 	/* Set height and width */
 	DRM_DEBUG_DRIVER("Layer source offset X: %d Y: %d\n",
 			 state->src.x1 >> 16, state->src.y1 >> 16);
-- 
2.30.2

