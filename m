Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA6A43BA9A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 21:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237103AbhJZTXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 15:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbhJZTXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 15:23:32 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C8CC061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 12:21:08 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id y11so214190qtn.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 12:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=127m+2Fwn/io7KvRr/KOS7xqYguoXNnwDnCZDuDXMls=;
        b=RjhlVtWGRH4NjzWs8qEsffk9kM4I6eskC3WyXwXekquU/6FsHhbHoDWqRQ38FJhFj3
         OVKmUSkhG6dYmEXVnhONtOqwcfox1NOnxhpB5SyqTHS8vqpmAtEDeKS6Yv22i/k1TPDq
         Opcyro3k6lKG+TnIb7/tD9lpHOawtLLtfNAr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=127m+2Fwn/io7KvRr/KOS7xqYguoXNnwDnCZDuDXMls=;
        b=OHb1OJJY9vYmehbNDTFIUEnMl3aEeFDCnVUge24kDMbvIleeasmLWqRnHltSafz2j8
         cQ4DNAPL5NsEhxiupwb++8bfME2vnfPG+Zl0Jxw4GeMrEqG6M7CH7Xjf4LRI4dnXkdas
         FESrKps1EBkLDhLWSWN1LETHhJxfawbPUT/XIvxWcSmRoeyJ72PCRN7otsDLm6H8yJBH
         UeHRPWukmaQpAefYYzJa1S01G0hk5oYwr1vJnuE9plAtBCkWACxUdGydN55K3uda8s41
         O8Kc7dGrcAK6G+VrSgSX1yZHg8JtfQOEMILWiCpDDMs6Yq6daUxW9G+tuCIQ+1C3BDdw
         ZMiw==
X-Gm-Message-State: AOAM532oqZWT9MWjSyvavwPBaghpi3CIit6/EKidRXVMfvN2pNVdeX9V
        agR0rJiinplLVE7X9eAJw6emzg==
X-Google-Smtp-Source: ABdhPJxIvSKMXHMgOqR+0IzuDBjRv51mc+McEVmOd74PDkMDAluxSEORKPdsy6BHd6I0NnJCw5RNHQ==
X-Received: by 2002:ac8:7087:: with SMTP id y7mr3457600qto.112.1635276067936;
        Tue, 26 Oct 2021 12:21:07 -0700 (PDT)
Received: from markyacoub.nyc.corp.google.com ([2620:0:1003:314:6c5e:8134:a5e1:b63b])
        by smtp.gmail.com with ESMTPSA id c13sm2284643qtc.42.2021.10.26.12.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 12:21:07 -0700 (PDT)
From:   Mark Yacoub <markyacoub@chromium.org>
Cc:     seanpaul@chromium.org, pmenzel@molgen.mpg.de,
        Mark Yacoub <markyacoub@google.com>,
        Mark Yacoub <markyacoub@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org
Subject: [PATCH v3 1/3] drm: Rename lut check functions to lut channel checks
Date:   Tue, 26 Oct 2021 15:21:00 -0400
Message-Id: <20211026192104.1860504-1-markyacoub@chromium.org>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Yacoub <markyacoub@google.com>

[Why]
This function and enum do not do generic checking on the luts but they
test color channels in the LUTs.
Keeping the name explicit as more generic LUT checks will follow.

Tested on Eldrid ChromeOS (TGL).

Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
---
 drivers/gpu/drm/drm_color_mgmt.c           | 12 ++++++------
 drivers/gpu/drm/i915/display/intel_color.c | 10 +++++-----
 include/drm/drm_color_mgmt.h               |  7 ++++---
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/drm_color_mgmt.c b/drivers/gpu/drm/drm_color_mgmt.c
index bb14f488c8f6c..6f4e04746d90f 100644
--- a/drivers/gpu/drm/drm_color_mgmt.c
+++ b/drivers/gpu/drm/drm_color_mgmt.c
@@ -585,17 +585,17 @@ int drm_plane_create_color_properties(struct drm_plane *plane,
 EXPORT_SYMBOL(drm_plane_create_color_properties);
 
 /**
- * drm_color_lut_check - check validity of lookup table
+ * drm_color_lut_channels_check - check validity of the channels in the lookup table
  * @lut: property blob containing LUT to check
  * @tests: bitmask of tests to run
  *
- * Helper to check whether a userspace-provided lookup table is valid and
- * satisfies hardware requirements.  Drivers pass a bitmask indicating which of
- * the tests in &drm_color_lut_tests should be performed.
+ * Helper to check whether each color channel of userspace-provided lookup table is valid and
+ * satisfies hardware requirements. Drivers pass a bitmask indicating which of in
+ * &drm_color_lut_channels_tests should be performed.
  *
  * Returns 0 on success, -EINVAL on failure.
  */
-int drm_color_lut_check(const struct drm_property_blob *lut, u32 tests)
+int drm_color_lut_channels_check(const struct drm_property_blob *lut, u32 tests)
 {
 	const struct drm_color_lut *entry;
 	int i;
@@ -625,4 +625,4 @@ int drm_color_lut_check(const struct drm_property_blob *lut, u32 tests)
 
 	return 0;
 }
-EXPORT_SYMBOL(drm_color_lut_check);
+EXPORT_SYMBOL(drm_color_lut_channels_check);
diff --git a/drivers/gpu/drm/i915/display/intel_color.c b/drivers/gpu/drm/i915/display/intel_color.c
index dab892d2251ba..4bb1bc76c4de9 100644
--- a/drivers/gpu/drm/i915/display/intel_color.c
+++ b/drivers/gpu/drm/i915/display/intel_color.c
@@ -1285,7 +1285,7 @@ static int check_luts(const struct intel_crtc_state *crtc_state)
 	const struct drm_property_blob *gamma_lut = crtc_state->hw.gamma_lut;
 	const struct drm_property_blob *degamma_lut = crtc_state->hw.degamma_lut;
 	int gamma_length, degamma_length;
-	u32 gamma_tests, degamma_tests;
+	u32 gamma_channels_tests, degamma_channels_tests;
 
 	/* Always allow legacy gamma LUT with no further checking. */
 	if (crtc_state_is_legacy_gamma(crtc_state))
@@ -1300,15 +1300,15 @@ static int check_luts(const struct intel_crtc_state *crtc_state)
 
 	degamma_length = INTEL_INFO(dev_priv)->color.degamma_lut_size;
 	gamma_length = INTEL_INFO(dev_priv)->color.gamma_lut_size;
-	degamma_tests = INTEL_INFO(dev_priv)->color.degamma_lut_tests;
-	gamma_tests = INTEL_INFO(dev_priv)->color.gamma_lut_tests;
+	degamma_channels_tests = INTEL_INFO(dev_priv)->color.degamma_lut_tests;
+	gamma_channels_tests = INTEL_INFO(dev_priv)->color.gamma_lut_tests;
 
 	if (check_lut_size(degamma_lut, degamma_length) ||
 	    check_lut_size(gamma_lut, gamma_length))
 		return -EINVAL;
 
-	if (drm_color_lut_check(degamma_lut, degamma_tests) ||
-	    drm_color_lut_check(gamma_lut, gamma_tests))
+	if (drm_color_lut_channels_check(degamma_lut, degamma_channels_tests) ||
+	    drm_color_lut_channels_check(gamma_lut, gamma_channels_tests))
 		return -EINVAL;
 
 	return 0;
diff --git a/include/drm/drm_color_mgmt.h b/include/drm/drm_color_mgmt.h
index 81c298488b0c8..cb1bf361ad3e3 100644
--- a/include/drm/drm_color_mgmt.h
+++ b/include/drm/drm_color_mgmt.h
@@ -94,12 +94,12 @@ int drm_plane_create_color_properties(struct drm_plane *plane,
 				      enum drm_color_range default_range);
 
 /**
- * enum drm_color_lut_tests - hw-specific LUT tests to perform
+ * enum drm_color_lut_channels_tests - hw-specific LUT tests to perform
  *
  * The drm_color_lut_check() function takes a bitmask of the values here to
  * determine which tests to apply to a userspace-provided LUT.
  */
-enum drm_color_lut_tests {
+enum drm_color_lut_channels_tests {
 	/**
 	 * @DRM_COLOR_LUT_EQUAL_CHANNELS:
 	 *
@@ -119,5 +119,6 @@ enum drm_color_lut_tests {
 	DRM_COLOR_LUT_NON_DECREASING = BIT(1),
 };
 
-int drm_color_lut_check(const struct drm_property_blob *lut, u32 tests);
+int drm_color_lut_channels_check(const struct drm_property_blob *lut,
+				 u32 tests);
 #endif
-- 
2.33.0.1079.g6e70778dc9-goog

