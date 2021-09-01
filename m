Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1463C3FE18F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 19:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344813AbhIAR4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 13:56:18 -0400
Received: from rosenzweig.io ([138.197.143.207]:45246 "EHLO rosenzweig.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344753AbhIAR4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 13:56:17 -0400
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 4/5] drm/rockchip: Use common drm_fixed_16_16 helper
Date:   Wed,  1 Sep 2021 13:54:30 -0400
Message-Id: <20210901175431.14060-4-alyssa@rosenzweig.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210901175431.14060-1-alyssa@rosenzweig.io>
References: <20210901175431.14060-1-alyssa@rosenzweig.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace our open-coded FRAC_16_16 with the common drm_fixed_16_16
helper to reduce code duplication between drivers.

Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: linux-rockchip@lists.infradead.org
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 9 +++++----
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h | 1 -
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index ba9e14da41b4..9428fcba400f 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -29,6 +29,7 @@
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_self_refresh_helper.h>
 #include <drm/drm_vblank.h>
+#include <drm/drm_fixed.h>
 
 #ifdef CONFIG_DRM_ANALOGIX_DP
 #include <drm/bridge/analogix_dp.h>
@@ -789,9 +790,9 @@ static int vop_plane_atomic_check(struct drm_plane *plane,
 	struct vop_win *vop_win = to_vop_win(plane);
 	const struct vop_win_data *win = vop_win->data;
 	int ret;
-	int min_scale = win->phy->scl ? FRAC_16_16(1, 8) :
+	int min_scale = win->phy->scl ? drm_fixed_16_16(1, 8) :
 					DRM_PLANE_HELPER_NO_SCALING;
-	int max_scale = win->phy->scl ? FRAC_16_16(8, 1) :
+	int max_scale = win->phy->scl ? drm_fixed_16_16(8, 1) :
 					DRM_PLANE_HELPER_NO_SCALING;
 
 	if (!crtc || WARN_ON(!fb))
@@ -1037,9 +1038,9 @@ static int vop_plane_atomic_async_check(struct drm_plane *plane,
 										 plane);
 	struct vop_win *vop_win = to_vop_win(plane);
 	const struct vop_win_data *win = vop_win->data;
-	int min_scale = win->phy->scl ? FRAC_16_16(1, 8) :
+	int min_scale = win->phy->scl ? drm_fixed_16_16(1, 8) :
 					DRM_PLANE_HELPER_NO_SCALING;
-	int max_scale = win->phy->scl ? FRAC_16_16(8, 1) :
+	int max_scale = win->phy->scl ? drm_fixed_16_16(8, 1) :
 					DRM_PLANE_HELPER_NO_SCALING;
 	struct drm_crtc_state *crtc_state;
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
index 857d97cdc67c..cada12e653cc 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
@@ -335,7 +335,6 @@ enum vop_pol {
 	DEN_NEGATIVE   = 2
 };
 
-#define FRAC_16_16(mult, div)    (((mult) << 16) / (div))
 #define SCL_FT_DEFAULT_FIXPOINT_SHIFT	12
 #define SCL_MAX_VSKIPLINES		4
 #define MIN_SCL_FT_AFTER_VSKIP		1
-- 
2.30.2

