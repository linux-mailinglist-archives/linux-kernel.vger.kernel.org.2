Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0120F42C86F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 20:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238339AbhJMSPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 14:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238626AbhJMSOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 14:14:48 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2686EC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 11:12:45 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id az39so3095122qkb.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 11:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3abP2WHjviZFuUihwWSZiOzZT2kMeD1KagMF6ysUSKs=;
        b=hYhNJr0rvk4nDGkl+F9/YupWmWLryQ4tzG4IVbSmz3mnlbIcFQRr7H7j5Gl2QLRFCU
         vZpapa9UQi8KTpVnjfeGylfVlfApkcmU1ZcrwcunKMNbnxlgo6Mr3nlA0nJeT73ZvC6m
         giNl5V9+wqMKUFO8GTCykZ1VOK2EpqEGnDxDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3abP2WHjviZFuUihwWSZiOzZT2kMeD1KagMF6ysUSKs=;
        b=Dt3Qz3ciUNup8FEQ3MTqICU5kxiefngJ711DAGreUIA/dQoCdLe2wqZCN/YNeE4gBq
         Dpqdwc3TpGDJpizG3WPkHw4mB7Q9+A8BCWFPVyXJ11SfkRpuWlq4/+OdqeNnVcMhPmV1
         Qa5ZUdfqL2Yvjtze/EWjT2ZEquIt1vyhrjcVytxdGb7D0GwfqZ1oovD9HgatOP7Vgkiu
         W1bucf6VFP2NQw2149AQOWpKEp1pC47HYkBcoT0W6CD5QJqztreFKcIxeNHQjvBNNGeB
         Cpaup2NgT1mlDpmN45exT2X4fWMxR5L5m7LqlC5IYk+EOz7bm2GzBl4Uhm5H8jKNT2GB
         tzGA==
X-Gm-Message-State: AOAM533c3DMpDi48J0mfTsKQcHfBPr4rakbtw+Agb7KokG1+j4vLs/xy
        OCRFWgSA6ucwtLDYIyZMiu9gwA==
X-Google-Smtp-Source: ABdhPJxjJoVuupK1VcQeYGveTJTbD7guaAk7qkcputfenEppSPOnvmvXtK4aSP7GM+La59cbyjVZ0A==
X-Received: by 2002:ae9:dd83:: with SMTP id r125mr707257qkf.159.1634148764337;
        Wed, 13 Oct 2021 11:12:44 -0700 (PDT)
Received: from markyacoub.nyc.corp.google.com ([2620:15c:6c:200:61dd:96a:9268:3c4d])
        by smtp.gmail.com with ESMTPSA id s203sm160130qke.21.2021.10.13.11.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 11:12:43 -0700 (PDT)
From:   Mark Yacoub <markyacoub@chromium.org>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     seanpaul@chromium.org, harry.wentland@amd.com,
        Mark Yacoub <markyacoub@google.com>,
        Mark Yacoub <markyacoub@chromium.org>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] amd/amdgpu_dm: Verify Gamma and Degamma LUT sizes using DRM Core check
Date:   Wed, 13 Oct 2021 14:12:21 -0400
Message-Id: <20211013181228.1578201-2-markyacoub@chromium.org>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
In-Reply-To: <20211013181228.1578201-1-markyacoub@chromium.org>
References: <20210929194012.3433306-1-markyacoub@chromium.org>
 <20211013181228.1578201-1-markyacoub@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Yacoub <markyacoub@google.com>

[Why]
drm_atomic_helper_check_crtc now verifies both legacy and non-legacy LUT
sizes. There is no need to check it within amdgpu_dm_atomic_check.

[How]
Remove the local call to verify LUT sizes and use DRM Core function
instead.

Tested on ChromeOS Zork.

v1:
Remove amdgpu_dm_verify_lut_sizes everywhere.

Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  8 ++---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 -
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 35 -------------------
 3 files changed, 4 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f74663b6b046e..47f8de1cfc3a5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10244,6 +10244,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 		}
 	}
 #endif
+	ret = drm_atomic_helper_check_crtcs(state);
+	if (ret)
+		return ret;
+
 	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
 		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
 
@@ -10253,10 +10257,6 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 			dm_old_crtc_state->dsc_force_changed == false)
 			continue;
 
-		ret = amdgpu_dm_verify_lut_sizes(new_crtc_state);
-		if (ret)
-			goto fail;
-
 		if (!new_crtc_state->enable)
 			continue;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index fcb9c4a629c32..22730e5542092 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -617,7 +617,6 @@ void amdgpu_dm_trigger_timing_sync(struct drm_device *dev);
 #define MAX_COLOR_LEGACY_LUT_ENTRIES 256
 
 void amdgpu_dm_init_color_mod(void);
-int amdgpu_dm_verify_lut_sizes(const struct drm_crtc_state *crtc_state);
 int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc);
 int amdgpu_dm_update_plane_color_mgmt(struct dm_crtc_state *crtc,
 				      struct dc_plane_state *dc_plane_state);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index a022e5bb30a5c..319f8a8a89835 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -284,37 +284,6 @@ static int __set_input_tf(struct dc_transfer_func *func,
 	return res ? 0 : -ENOMEM;
 }
 
-/**
- * Verifies that the Degamma and Gamma LUTs attached to the |crtc_state| are of
- * the expected size.
- * Returns 0 on success.
- */
-int amdgpu_dm_verify_lut_sizes(const struct drm_crtc_state *crtc_state)
-{
-	const struct drm_color_lut *lut = NULL;
-	uint32_t size = 0;
-
-	lut = __extract_blob_lut(crtc_state->degamma_lut, &size);
-	if (lut && size != MAX_COLOR_LUT_ENTRIES) {
-		DRM_DEBUG_DRIVER(
-			"Invalid Degamma LUT size. Should be %u but got %u.\n",
-			MAX_COLOR_LUT_ENTRIES, size);
-		return -EINVAL;
-	}
-
-	lut = __extract_blob_lut(crtc_state->gamma_lut, &size);
-	if (lut && size != MAX_COLOR_LUT_ENTRIES &&
-	    size != MAX_COLOR_LEGACY_LUT_ENTRIES) {
-		DRM_DEBUG_DRIVER(
-			"Invalid Gamma LUT size. Should be %u (or %u for legacy) but got %u.\n",
-			MAX_COLOR_LUT_ENTRIES, MAX_COLOR_LEGACY_LUT_ENTRIES,
-			size);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 /**
  * amdgpu_dm_update_crtc_color_mgmt: Maps DRM color management to DC stream.
  * @crtc: amdgpu_dm crtc state
@@ -348,10 +317,6 @@ int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc)
 	bool is_legacy;
 	int r;
 
-	r = amdgpu_dm_verify_lut_sizes(&crtc->base);
-	if (r)
-		return r;
-
 	degamma_lut = __extract_blob_lut(crtc->base.degamma_lut, &degamma_size);
 	regamma_lut = __extract_blob_lut(crtc->base.gamma_lut, &regamma_size);
 
-- 
2.33.0.882.g93a45727a2-goog

