Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604CF3FE190
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 19:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344580AbhIAR4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 13:56:31 -0400
Received: from rosenzweig.io ([138.197.143.207]:45284 "EHLO rosenzweig.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344920AbhIAR41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 13:56:27 -0400
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
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: [PATCH 5/5] drm/zte: Use common drm_fixed_16_16 helper
Date:   Wed,  1 Sep 2021 13:54:31 -0400
Message-Id: <20210901175431.14060-5-alyssa@rosenzweig.io>
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
---
 drivers/gpu/drm/zte/zx_plane.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/zte/zx_plane.c b/drivers/gpu/drm/zte/zx_plane.c
index 93bcca428e35..80f61d79be83 100644
--- a/drivers/gpu/drm/zte/zx_plane.c
+++ b/drivers/gpu/drm/zte/zx_plane.c
@@ -11,6 +11,7 @@
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_plane_helper.h>
+#include <drm/drm_fixed.h>
 
 #include "zx_common_regs.h"
 #include "zx_drm_drv.h"
@@ -43,8 +44,6 @@ static const uint32_t vl_formats[] = {
 	 */
 };
 
-#define FRAC_16_16(mult, div)    (((mult) << 16) / (div))
-
 static int zx_vl_plane_atomic_check(struct drm_plane *plane,
 				    struct drm_atomic_state *state)
 {
@@ -53,8 +52,8 @@ static int zx_vl_plane_atomic_check(struct drm_plane *plane,
 	struct drm_framebuffer *fb = plane_state->fb;
 	struct drm_crtc *crtc = plane_state->crtc;
 	struct drm_crtc_state *crtc_state;
-	int min_scale = FRAC_16_16(1, 8);
-	int max_scale = FRAC_16_16(8, 1);
+	int min_scale = drm_fixed_16_16(1, 8);
+	int max_scale = drm_fixed_16_16(8, 1);
 
 	if (!crtc || WARN_ON(!fb))
 		return 0;
-- 
2.30.2

