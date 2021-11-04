Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAE2445AE4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 21:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbhKDUFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 16:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbhKDUFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 16:05:45 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD6BC061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 13:03:07 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id k29so6056219qve.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 13:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n6LDFw29hZsoKOLns/SZzto6jZDnxgAkgjGJO4dyrRY=;
        b=T/ckcQBWOViogOXX72QJ6w3HvGmn5rL2NW06Yjte/zJcE/AB/v4oyf/SkjhFR0E227
         pI+xYaEgHixkWOy5DgzDRBV4gQ/rKqui2oQnykhq4YenADyPYoZHwx8ZkZpTVaERR2xz
         UduZGcSig2OE5calDBgcMjyWXIaGnoszW9veY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n6LDFw29hZsoKOLns/SZzto6jZDnxgAkgjGJO4dyrRY=;
        b=uZdXDjoZCbbdt7w4PeoNlyMYBtfm1kRorsnqI6d4OYgFN1uh/rqfCBWxYOazPIgYh+
         SDLlNcIbiIdMPb/I8/EDAcTu2eSJ5trvWqclkjJkbyORevTahN5jZSuEQ3kv3cYn0wP3
         maR63XPg4rBKIAjpvobyo23aXvp2Si1ha6vJ9IfaWxNzM97J1Jnm710YS+4RTcQvp2U7
         ADVoqYCtlSYqQQxK+5I7WW+XZ9ed+CI8hpULsassnIYFkXocW15gA681AoC1A85kENFY
         ALNOQBWAMm2/g1akB84khUKlnPOIk7jarCvCpgDSWLm9ve3qwHjWvM66ho2iyE93bJUc
         Y3Eg==
X-Gm-Message-State: AOAM531foXwsVPxgPkWiOVInW0XZVKYLCwUNOEI1WDID27P/QKSLvf7x
        X7QjIIJXjw3U1gUYetLEYJE/dg==
X-Google-Smtp-Source: ABdhPJxLZ+5Oy62QzLHHu/KSvILvzeCBEI0UAESxsEUKEIxTcMhOTMEEJsV+Day34F+jzG9/rBb/yA==
X-Received: by 2002:a05:6214:240c:: with SMTP id fv12mr3237449qvb.58.1636056186439;
        Thu, 04 Nov 2021 13:03:06 -0700 (PDT)
Received: from markyacoub.nyc.corp.google.com ([2620:0:1003:314:1118:14fe:72e3:f013])
        by smtp.gmail.com with ESMTPSA id j22sm4577411qko.121.2021.11.04.13.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 13:03:05 -0700 (PDT)
From:   Mark Yacoub <markyacoub@chromium.org>
Cc:     seanpaul@chromium.org, pmenzel@molgen.mpg.de,
        jani.nikula@linux.intel.com, Mark Yacoub <markyacoub@google.com>,
        Mark Yacoub <markyacoub@chromium.org>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] amd/amdgpu_dm: Verify Gamma and Degamma LUT sizes using DRM Core check
Date:   Thu,  4 Nov 2021 16:02:52 -0400
Message-Id: <20211104200255.63499-3-markyacoub@chromium.org>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
In-Reply-To: <20211104200255.63499-1-markyacoub@chromium.org>
References: <20211104200255.63499-1-markyacoub@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
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
Reviewed-by: Sean Paul <seanpaul@chromium.org>
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
2.34.0.rc0.344.g81b53c2807-goog

