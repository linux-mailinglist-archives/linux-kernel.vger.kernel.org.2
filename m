Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA88432BE80
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377004AbhCCRbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447315AbhCCNsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:48:47 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019DBC061B3F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:44:08 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id l12so23738030wry.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lf6C9KN2INyaFSGO743cOHm5zD9ZJ950nSP7LTkF5TI=;
        b=bt2sZX3tLNo53tzeRpyffFBZT6eJRI5MjhFu48OE8+BDQmPe4LWCB4ysm+1vshyG7x
         ys/adKdKThLKFPQ57Rg+UZ34+gEoc6Rk+xQDZm0blQ4U5EvJvgtexXyV373QK/J4mlUq
         7nWbZhHdDX7/gfBSYdi9dCr8mU7n7YL3ndel8c/oJEClPabAF77gwl188EkqoCgCnYS9
         FGks2rniFX7gWOyT4aPZvL8mqRtCsmAWDj3vUuPFhPeqJUG1qdzNKDZmT/vL6T7egPHH
         0sdq/qd4eDfCZJWLt9nb6n2xgOXVLF9vNON1NS9l8jECLJjOV7h3EQWIOv+ffNmzTX7m
         Rm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lf6C9KN2INyaFSGO743cOHm5zD9ZJ950nSP7LTkF5TI=;
        b=Q4xKuRKhR/3U5U/8wDZx7jGwanGboFLP+V48IErHTmv9q1IH2AQw4X+NMINspeWo5z
         vaOgp9aiObz7zu6posxaKqy3jyKN18xKSNHCv2Bzk7mYsixoPl7TJWyvMZUR8Q5LdId3
         IGjCKQGoMJZNY5NNPwx1Q6oWYmZTBGz26ZzkxRhU4KHUdkgPxb8M4sNsFRHURo0zXiW9
         gWXLraRn+eRFBE9W0u28e6+cGcrfPZlymwyBzwYAfrA3AmcSnMcqKV4JCKTu2Y9qt9js
         YZzfytItmJdUztaTuWRCs6m84afOIsfpALYV9yop4Ye096N1XJ5sFdSeHvtYFXw7V6AN
         J+/w==
X-Gm-Message-State: AOAM530iW2poUCGhfoj4DDhvslldy25HS14Psj61xphlzPC2oYeGhSt6
        JEriafradt25WomXdQD7olABEg==
X-Google-Smtp-Source: ABdhPJzWLVNYU3ADCx9azHH2ojgk47a2vYqfr3X9NmByV7NsOr6YE0hN8X9OTvZsyl2wA/so0ZieVg==
X-Received: by 2002:a5d:64ac:: with SMTP id m12mr27034845wrp.138.1614779046711;
        Wed, 03 Mar 2021 05:44:06 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:44:06 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Zack Rusin <zackr@vmware.com>
Subject: [PATCH 32/53] drm/vmwgfx/vmwgfx_kms: Update worthy function headers and demote others
Date:   Wed,  3 Mar 2021 13:42:58 +0000
Message-Id: <20210303134319.3160762-33-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 In file included from drivers/gpu/drm/vmwgfx/vmwgfx_kms.c:37:
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c:483: warning: Function parameter or member 'new_state' not described in 'vmw_du_cursor_plane_atomic_check'
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c:483: warning: Excess function parameter 'state' description in 'vmw_du_cursor_plane_atomic_check'
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c:1069: warning: Function parameter or member 'vfb' not described in 'vmw_framebuffer_pin'
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c:1281: warning: Function parameter or member 'dev_priv' not described in 'vmw_kms_srf_ok'
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c:1907: warning: Function parameter or member 'crtc' not described in 'vmw_get_vblank_counter'
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c:1915: warning: Function parameter or member 'crtc' not described in 'vmw_enable_vblank'
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c:1923: warning: Function parameter or member 'crtc' not described in 'vmw_disable_vblank'
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c:2131: warning: Function parameter or member 'mode' not described in 'vmw_guess_mode_timing'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Zack Rusin <zackr@vmware.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20210115181313.3431493-21-lee.jones@linaro.org
---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 9293dc19a7683..84143b707cd32 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -467,7 +467,7 @@ int vmw_du_primary_plane_atomic_check(struct drm_plane *plane,
  * vmw_du_cursor_plane_atomic_check - check if the new state is okay
  *
  * @plane: cursor plane
- * @state: info on the new plane state
+ * @new_state: info on the new plane state
  *
  * This is a chance to fail if the new cursor state does not fit
  * our requirements.
@@ -1057,7 +1057,7 @@ static const struct drm_framebuffer_funcs vmw_framebuffer_bo_funcs = {
 	.dirty = vmw_framebuffer_bo_dirty_ext,
 };
 
-/**
+/*
  * Pin the bofer in a location suitable for access by the
  * display system.
  */
@@ -1267,6 +1267,7 @@ static int vmw_kms_new_framebuffer_bo(struct vmw_private *dev_priv,
 /**
  * vmw_kms_srf_ok - check if a surface can be created
  *
+ * @dev_priv: Pointer to device private struct.
  * @width: requested width
  * @height: requested height
  *
@@ -1896,7 +1897,7 @@ bool vmw_kms_validate_mode_vram(struct vmw_private *dev_priv,
 }
 
 
-/**
+/*
  * Function called by DRM code called with vbl_lock held.
  */
 u32 vmw_get_vblank_counter(struct drm_crtc *crtc)
@@ -1904,7 +1905,7 @@ u32 vmw_get_vblank_counter(struct drm_crtc *crtc)
 	return 0;
 }
 
-/**
+/*
  * Function called by DRM code called with vbl_lock held.
  */
 int vmw_enable_vblank(struct drm_crtc *crtc)
@@ -1912,7 +1913,7 @@ int vmw_enable_vblank(struct drm_crtc *crtc)
 	return -EINVAL;
 }
 
-/**
+/*
  * Function called by DRM code called with vbl_lock held.
  */
 void vmw_disable_vblank(struct drm_crtc *crtc)
@@ -2120,7 +2121,7 @@ static struct drm_display_mode vmw_kms_connector_builtin[] = {
  * vmw_guess_mode_timing - Provide fake timings for a
  * 60Hz vrefresh mode.
  *
- * @mode - Pointer to a struct drm_display_mode with hdisplay and vdisplay
+ * @mode: Pointer to a struct drm_display_mode with hdisplay and vdisplay
  * members filled in.
  */
 void vmw_guess_mode_timing(struct drm_display_mode *mode)
-- 
2.27.0

