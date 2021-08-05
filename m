Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A083E12EF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 12:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240592AbhHEKqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 06:46:24 -0400
Received: from mailgw.kylinos.cn ([123.150.8.42]:42386 "EHLO nksmu.kylinos.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240478AbhHEKqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 06:46:23 -0400
X-UUID: 3aead53055cf4b128297025a3ac8fefb-20210805
X-CPASD-INFO: da93797b55bf4459b5115d9c3a60f804@rbFzU2RrZZJhVaSyg3eAc4JmYWFlkFm
        ydZtWYJRoXFSVhH5xTWJsXVKBfG5QZWNdYVN_eGpQYl9gZFB5i3-XblBgXoZgUZB3s6NzU2dnZw==
X-CPASD-FEATURE: 0.0
X-CLOUD-ID: da93797b55bf4459b5115d9c3a60f804
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,EXT:0.0,OB:0.0,URL:-5,T
        VAL:177.0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:395.0,IP:-2.0,MAL:0.0,ATTNUM:0
        .0,PHF:-5.0,PHC:-5.0,SPF:4.0,EDMS:-3,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:0.0,CF
        OB:0.0,SPC:0.0,SIG:-5,AUF:1,DUF:7720,ACD:2,DCD:104,SL:0,AG:0,CFC:0.814,CFSR:0
        .032,UAT:0,RAF:0,VERSION:2.3.4
X-CPASD-ID: 3aead53055cf4b128297025a3ac8fefb-20210805
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1, 1
X-UUID: 3aead53055cf4b128297025a3ac8fefb-20210805
X-User: lizhenneng@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by nksmu.kylinos.cn
        (envelope-from <lizhenneng@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1615833078; Thu, 05 Aug 2021 18:44:27 +0800
From:   Zhenneng Li <lizhenneng@kylinos.cn>
Cc:     Zhenneng Li <lizhenneng@kylinos.cn>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] drm/radeon: Update pitch for page flip
Date:   Thu,  5 Aug 2021 18:45:57 +0800
Message-Id: <20210805104557.306886-1-lizhenneng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="Add_By_Label_Mail_Nextpart_001"
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Add_By_Label_Mail_Nextpart_001
Content-Type: text/plain;
Content-Transfer-Encoding: 8bit


When primary bo is updated, crtc's pitch may
have not been updated, this will lead to show
disorder content when user changes display mode,
we update crtc's pitch in page flip to avoid
this bug.
This refers to amdgpu's pageflip.

v1->v2:
Update all of the pitch in all of the page_flip functions
in radeon rather than just the evergreen one.

v2->v3:
Update pitch set method for r100 according to
radeon_legacy_crtc.c

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Zhenneng Li <lizhenneng@kylinos.cn>
---
 drivers/gpu/drm/radeon/evergreen.c | 8 +++++++-
 drivers/gpu/drm/radeon/r100.c      | 9 +++++++++
 drivers/gpu/drm/radeon/rs600.c     | 8 +++++++-
 drivers/gpu/drm/radeon/rv770.c     | 8 +++++++-
 4 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/evergreen.c
index 36a888e1b179..eeb590d2dec2 100644
--- a/drivers/gpu/drm/radeon/evergreen.c
+++ b/drivers/gpu/drm/radeon/evergreen.c
@@ -28,6 +28,7 @@
 
 #include <drm/drm_vblank.h>
 #include <drm/radeon_drm.h>
+#include <drm/drm_fourcc.h>
 
 #include "atom.h"
 #include "avivod.h"
@@ -1414,10 +1415,15 @@ void evergreen_page_flip(struct radeon_device *rdev, int crtc_id, u64 crtc_base,
 			 bool async)
 {
 	struct radeon_crtc *radeon_crtc = rdev->mode_info.crtcs[crtc_id];
+	struct drm_framebuffer *fb = radeon_crtc->base.primary->fb;
 
-	/* update the scanout addresses */
+	/* flip at hsync for async, default is vsync */
 	WREG32(EVERGREEN_GRPH_FLIP_CONTROL + radeon_crtc->crtc_offset,
 	       async ? EVERGREEN_GRPH_SURFACE_UPDATE_H_RETRACE_EN : 0);
+	/* update pitch */
+	WREG32(EVERGREEN_GRPH_PITCH + radeon_crtc->crtc_offset,
+	       fb->pitches[0] / fb->format->cpp[0]);
+	/* update the scanout addresses */
 	WREG32(EVERGREEN_GRPH_PRIMARY_SURFACE_ADDRESS_HIGH + radeon_crtc->crtc_offset,
 	       upper_32_bits(crtc_base));
 	WREG32(EVERGREEN_GRPH_PRIMARY_SURFACE_ADDRESS + radeon_crtc->crtc_offset,
diff --git a/drivers/gpu/drm/radeon/r100.c b/drivers/gpu/drm/radeon/r100.c
index ba724198b72e..2dd85ba1faa2 100644
--- a/drivers/gpu/drm/radeon/r100.c
+++ b/drivers/gpu/drm/radeon/r100.c
@@ -162,6 +162,8 @@ void r100_wait_for_vblank(struct radeon_device *rdev, int crtc)
 void r100_page_flip(struct radeon_device *rdev, int crtc_id, u64 crtc_base, bool async)
 {
 	struct radeon_crtc *radeon_crtc = rdev->mode_info.crtcs[crtc_id];
+	uint32_t crtc_pitch, pitch_pixels;
+	struct drm_framebuffer *fb = radeon_crtc->base.primary->fb;
 	u32 tmp = ((u32)crtc_base) | RADEON_CRTC_OFFSET__OFFSET_LOCK;
 	int i;
 
@@ -169,6 +171,13 @@ void r100_page_flip(struct radeon_device *rdev, int crtc_id, u64 crtc_base, bool
 	/* update the scanout addresses */
 	WREG32(RADEON_CRTC_OFFSET + radeon_crtc->crtc_offset, tmp);
 
+	/* update pitch */
+	pitch_pixels = fb->pitches[0] / fb->format->cpp[0];
+	crtc_pitch = DIV_ROUND_UP(pitch_pixels * fb->format->cpp[0] * 8,
+				  fb->format->cpp[0] * 8 * 8);
+	crtc_pitch |= crtc_pitch << 16;
+	WREG32(RADEON_CRTC_PITCH + radeon_crtc->crtc_offset, crtc_pitch);
+
 	/* Wait for update_pending to go high. */
 	for (i = 0; i < rdev->usec_timeout; i++) {
 		if (RREG32(RADEON_CRTC_OFFSET + radeon_crtc->crtc_offset) & RADEON_CRTC_OFFSET__GUI_TRIG_OFFSET)
diff --git a/drivers/gpu/drm/radeon/rs600.c b/drivers/gpu/drm/radeon/rs600.c
index b2d22e25eee1..b87dd551e939 100644
--- a/drivers/gpu/drm/radeon/rs600.c
+++ b/drivers/gpu/drm/radeon/rs600.c
@@ -41,6 +41,7 @@
 
 #include <drm/drm_device.h>
 #include <drm/drm_vblank.h>
+#include <drm/drm_fourcc.h>
 
 #include "atom.h"
 #include "radeon.h"
@@ -118,6 +119,7 @@ void avivo_wait_for_vblank(struct radeon_device *rdev, int crtc)
 void rs600_page_flip(struct radeon_device *rdev, int crtc_id, u64 crtc_base, bool async)
 {
 	struct radeon_crtc *radeon_crtc = rdev->mode_info.crtcs[crtc_id];
+	struct drm_framebuffer *fb = radeon_crtc->base.primary->fb;
 	u32 tmp = RREG32(AVIVO_D1GRPH_UPDATE + radeon_crtc->crtc_offset);
 	int i;
 
@@ -125,9 +127,13 @@ void rs600_page_flip(struct radeon_device *rdev, int crtc_id, u64 crtc_base, boo
 	tmp |= AVIVO_D1GRPH_UPDATE_LOCK;
 	WREG32(AVIVO_D1GRPH_UPDATE + radeon_crtc->crtc_offset, tmp);
 
-	/* update the scanout addresses */
+	/* flip at hsync for async, default is vsync */
 	WREG32(AVIVO_D1GRPH_FLIP_CONTROL + radeon_crtc->crtc_offset,
 	       async ? AVIVO_D1GRPH_SURFACE_UPDATE_H_RETRACE_EN : 0);
+	/* update pitch */
+	WREG32(AVIVO_D1GRPH_PITCH + radeon_crtc->crtc_offset,
+	       fb->pitches[0] / fb->format->cpp[0]);
+	/* update the scanout addresses */
 	WREG32(AVIVO_D1GRPH_SECONDARY_SURFACE_ADDRESS + radeon_crtc->crtc_offset,
 	       (u32)crtc_base);
 	WREG32(AVIVO_D1GRPH_PRIMARY_SURFACE_ADDRESS + radeon_crtc->crtc_offset,
diff --git a/drivers/gpu/drm/radeon/rv770.c b/drivers/gpu/drm/radeon/rv770.c
index 74499307285b..e592e57be1bb 100644
--- a/drivers/gpu/drm/radeon/rv770.c
+++ b/drivers/gpu/drm/radeon/rv770.c
@@ -32,6 +32,7 @@
 
 #include <drm/drm_device.h>
 #include <drm/radeon_drm.h>
+#include <drm/drm_fourcc.h>
 
 #include "atom.h"
 #include "avivod.h"
@@ -809,6 +810,7 @@ u32 rv770_get_xclk(struct radeon_device *rdev)
 void rv770_page_flip(struct radeon_device *rdev, int crtc_id, u64 crtc_base, bool async)
 {
 	struct radeon_crtc *radeon_crtc = rdev->mode_info.crtcs[crtc_id];
+	struct drm_framebuffer *fb = radeon_crtc->base.primary->fb;
 	u32 tmp = RREG32(AVIVO_D1GRPH_UPDATE + radeon_crtc->crtc_offset);
 	int i;
 
@@ -816,9 +818,13 @@ void rv770_page_flip(struct radeon_device *rdev, int crtc_id, u64 crtc_base, boo
 	tmp |= AVIVO_D1GRPH_UPDATE_LOCK;
 	WREG32(AVIVO_D1GRPH_UPDATE + radeon_crtc->crtc_offset, tmp);
 
-	/* update the scanout addresses */
+	/* flip at hsync for async, default is vsync */
 	WREG32(AVIVO_D1GRPH_FLIP_CONTROL + radeon_crtc->crtc_offset,
 	       async ? AVIVO_D1GRPH_SURFACE_UPDATE_H_RETRACE_EN : 0);
+	/* update pitch */
+	WREG32(AVIVO_D1GRPH_PITCH + radeon_crtc->crtc_offset,
+	       fb->pitches[0] / fb->format->cpp[0]);
+	/* update the scanout addresses */
 	if (radeon_crtc->crtc_id) {
 		WREG32(D2GRPH_SECONDARY_SURFACE_ADDRESS_HIGH, upper_32_bits(crtc_base));
 		WREG32(D2GRPH_PRIMARY_SURFACE_ADDRESS_HIGH, upper_32_bits(crtc_base));
-- 
2.25.1


--Add_By_Label_Mail_Nextpart_001

Content-type: Text/plain

No virus found
		Checked by Hillstone Network AntiVirus

--Add_By_Label_Mail_Nextpart_001--
