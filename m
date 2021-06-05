Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3CC39C6A2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 09:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhFEHib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 03:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhFEHia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 03:38:30 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AC8C061766
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jun 2021 00:36:29 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ce15so17970655ejb.4
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 00:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wbrIaaKI4niHyH2qMv2aNDzXwrJpctpYKQaNcqGlyac=;
        b=fQ7uILW5H1MekpLI3P/lZ6DGiQtjp5TI+TQiMTQAcMj0w5sw2CofM7pqTyMwu3QjM4
         M9oGn7zcgMGQKeCiL7lfdeMXigtACC0EwN5xN20+j8ix/DjUpunVTUV+mevYTsXVaRcN
         Xh3FbvDYpCr2dxtMPZuhEGvZjbec5bPZWAL1zAWcEhOpg0gD/JsSw8Q/TUSSOSA9V2lu
         i9wTnA2mt0GehzAN8ibpIoXjNzkkd5fo577ATE1rxM80WGXpDvRxpwxere0VnRolO+lc
         GRxeDWyYUGQLx/IKNrLorbnz4KaFeUskr1c6SxSW3uOCVwELS15qhUJoZe2MNOE2RJke
         iNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wbrIaaKI4niHyH2qMv2aNDzXwrJpctpYKQaNcqGlyac=;
        b=eMsUsb+3YTS/YLMjgGI/2RzOSG2/FloS0O/8IX8B22Yfr3ziqHCglbG6VDHbOk7KWu
         75Etv+JyAV4ZP5aBfm47b4Ke+1gJE8luDNOcRPpjYxfWJtLbNCl3+tzN0n5VYb8h1Z9I
         ltoomjTOMyq7pwSvmlsnqa36U62t6mJx8389Ep88FNvP4x0GmjE12K+AD+cLmH58LDQD
         GSndX49nVmuQkZVRy6oprDJ950KnZK2D42H70QvVNEYzix8RY8jkFDkK47fsvD+uUOgC
         nEZQEE21OnBVZ60QaCz9hufbDlAikOWJeyh9EpRGCQkkKx7BwBoWQ5BFzBxZv9WrPwzF
         oDlg==
X-Gm-Message-State: AOAM531jnLUjz5VjVs28tbJBaHfR6apQRN7Bz0aJK5srvbFd/p2aj/64
        jGRpkVD5ONt9CqYpkk09hm4=
X-Google-Smtp-Source: ABdhPJxZS46vj0gx1a8g5jF08xoc9nDXTbE/elS9v0x0sE5DVYzWQwkWvYxzDPddWd0hCFzkEKpywQ==
X-Received: by 2002:a17:906:b748:: with SMTP id fx8mr8315876ejb.477.1622878587956;
        Sat, 05 Jun 2021 00:36:27 -0700 (PDT)
Received: from kista.localdomain (cpe-86-58-17-133.cable.triera.net. [86.58.17.133])
        by smtp.gmail.com with ESMTPSA id t5sm3792159eje.29.2021.06.05.00.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 00:36:26 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, daniel.stone@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH] drm/sun4i: de3: Be explicit about supported modifiers
Date:   Sat,  5 Jun 2021 09:35:34 +0200
Message-Id: <20210605073534.3786194-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>

Currently only linear formats are supported in sun4i-drm driver, but
SoCs like H6 supports AFBC variant of some of them in multiple cores
(GPU, VPU, DE3). Panfrost already implements AFBC compression and is
sometimes confused what should be default choice (linear, AFBC) if DRM
driver is not explicit about modifier support (MiniMyth2 distro with
MythTV app).

After some discussion with Daniel Stone on #panfrost IRC, it was decided
to make modifiers in sun4i-drm explicit, to avoid any kind of guessing,
not just in panfrost, but everywhere. In fact, long term idea is to make
modifier parameter in drm_universal_plane_init() mandatory (non NULL).

Signed-off-by: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 7 ++++++-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 8 +++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
index 0db164a774a1..e779855bcd6e 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -370,6 +370,11 @@ static const u32 sun8i_ui_layer_formats[] = {
 	DRM_FORMAT_XRGB8888,
 };
 
+static const uint64_t sun8i_layer_modifiers[] = {
+	DRM_FORMAT_MOD_LINEAR,
+	DRM_FORMAT_MOD_INVALID
+};
+
 struct sun8i_ui_layer *sun8i_ui_layer_init_one(struct drm_device *drm,
 					       struct sun8i_mixer *mixer,
 					       int index)
@@ -392,7 +397,7 @@ struct sun8i_ui_layer *sun8i_ui_layer_init_one(struct drm_device *drm,
 				       &sun8i_ui_layer_funcs,
 				       sun8i_ui_layer_formats,
 				       ARRAY_SIZE(sun8i_ui_layer_formats),
-				       NULL, type, NULL);
+				       sun8i_layer_modifiers, type, NULL);
 	if (ret) {
 		dev_err(drm->dev, "Couldn't initialize layer\n");
 		return ERR_PTR(ret);
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index 46420780db59..1c86c2dd0bbf 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -534,6 +534,11 @@ static const u32 sun8i_vi_layer_de3_formats[] = {
 	DRM_FORMAT_YVU422,
 };
 
+static const uint64_t sun8i_layer_modifiers[] = {
+	DRM_FORMAT_MOD_LINEAR,
+	DRM_FORMAT_MOD_INVALID
+};
+
 struct sun8i_vi_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
 					       struct sun8i_mixer *mixer,
 					       int index)
@@ -560,7 +565,8 @@ struct sun8i_vi_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
 	ret = drm_universal_plane_init(drm, &layer->plane, 0,
 				       &sun8i_vi_layer_funcs,
 				       formats, format_count,
-				       NULL, DRM_PLANE_TYPE_OVERLAY, NULL);
+				       sun8i_layer_modifiers,
+				       DRM_PLANE_TYPE_OVERLAY, NULL);
 	if (ret) {
 		dev_err(drm->dev, "Couldn't initialize layer\n");
 		return ERR_PTR(ret);
-- 
2.31.1

