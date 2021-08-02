Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D093DD16C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 09:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbhHBHni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 03:43:38 -0400
Received: from mailgw.kylinos.cn ([123.150.8.42]:4203 "EHLO nksmu.kylinos.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232531AbhHBHnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 03:43:37 -0400
X-UUID: bf244a08b01545c0a3c76fca0c5f9e7b-20210802
X-UUID: bf244a08b01545c0a3c76fca0c5f9e7b-20210802
X-User: lizhenneng@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by nksmu.kylinos.cn
        (envelope-from <lizhenneng@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 439848347; Mon, 02 Aug 2021 15:41:48 +0800
From:   Zhenneng Li <lizhenneng@kylinos.cn>
Cc:     Zhenneng Li <lizhenneng@kylinos.cn>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon: Update pitch for page flip
Date:   Mon,  2 Aug 2021 15:43:10 +0800
Message-Id: <20210802074310.1526526-1-lizhenneng@kylinos.cn>
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
 1 file changed, 7 insertions(+), 1 deletion(-)

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
-- 
2.25.1


--Add_By_Label_Mail_Nextpart_001

Content-type: Text/plain

No virus found
		Checked by Hillstone Network AntiVirus

--Add_By_Label_Mail_Nextpart_001--
