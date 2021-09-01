Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F0B3FE18C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 19:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237005AbhIARzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 13:55:54 -0400
Received: from rosenzweig.io ([138.197.143.207]:45154 "EHLO rosenzweig.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236754AbhIARzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 13:55:53 -0400
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
        linux-amlogic@lists.infradead.org
Subject: [PATCH 2/5] drm/meson: Use common drm_fixed_16_16 helper
Date:   Wed,  1 Sep 2021 13:54:28 -0400
Message-Id: <20210901175431.14060-2-alyssa@rosenzweig.io>
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
Cc: linux-amlogic@lists.infradead.org
---
 drivers/gpu/drm/meson/meson_overlay.c | 7 +++----
 drivers/gpu/drm/meson/meson_plane.c   | 5 ++---
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_overlay.c b/drivers/gpu/drm/meson/meson_overlay.c
index dfef8afcc245..d8fc6bbb332f 100644
--- a/drivers/gpu/drm/meson/meson_overlay.c
+++ b/drivers/gpu/drm/meson/meson_overlay.c
@@ -15,6 +15,7 @@
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_plane_helper.h>
+#include <drm/drm_fixed.h>
 
 #include "meson_overlay.h"
 #include "meson_registers.h"
@@ -162,8 +163,6 @@ struct meson_overlay {
 };
 #define to_meson_overlay(x) container_of(x, struct meson_overlay, base)
 
-#define FRAC_16_16(mult, div)    (((mult) << 16) / (div))
-
 static int meson_overlay_atomic_check(struct drm_plane *plane,
 				      struct drm_atomic_state *state)
 {
@@ -181,8 +180,8 @@ static int meson_overlay_atomic_check(struct drm_plane *plane,
 
 	return drm_atomic_helper_check_plane_state(new_plane_state,
 						   crtc_state,
-						   FRAC_16_16(1, 5),
-						   FRAC_16_16(5, 1),
+						   drm_fixed_16_16(1, 5),
+						   drm_fixed_16_16(5, 1),
 						   true, true);
 }
 
diff --git a/drivers/gpu/drm/meson/meson_plane.c b/drivers/gpu/drm/meson/meson_plane.c
index 8640a8a8a469..4fae9ebbf178 100644
--- a/drivers/gpu/drm/meson/meson_plane.c
+++ b/drivers/gpu/drm/meson/meson_plane.c
@@ -19,6 +19,7 @@
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_plane_helper.h>
+#include <drm/drm_fixed.h>
 
 #include "meson_plane.h"
 #include "meson_registers.h"
@@ -68,8 +69,6 @@ struct meson_plane {
 };
 #define to_meson_plane(x) container_of(x, struct meson_plane, base)
 
-#define FRAC_16_16(mult, div)    (((mult) << 16) / (div))
-
 static int meson_plane_atomic_check(struct drm_plane *plane,
 				    struct drm_atomic_state *state)
 {
@@ -92,7 +91,7 @@ static int meson_plane_atomic_check(struct drm_plane *plane,
 	 */
 	return drm_atomic_helper_check_plane_state(new_plane_state,
 						   crtc_state,
-						   FRAC_16_16(1, 5),
+						   drm_fixed_16_16(1, 5),
 						   DRM_PLANE_HELPER_NO_SCALING,
 						   false, true);
 }
-- 
2.30.2

