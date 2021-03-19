Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3542934176D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 09:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbhCSIZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 04:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbhCSIYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 04:24:42 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7546C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:24:41 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id t18so8256006ejc.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aMrUqo0YqYh2lLrOaeq1NIAU7nPi5AK4ygCC5+IgXJs=;
        b=xMzgbPZVOLQWV/WNZ8/zEFm7gXF06+16gnuNa/aVAK/QKIuo7EHaH+rwqwNGLQjtif
         jLAgrbn2DMVYgyKAh4q8fTdNeE5eSDIaWn8r5CtBX12ewcz2WSn+XnR08LDXXGAmBnXL
         8HFIyQCuQlni67VIHl/TZ5hLVGq8KJKlGpFg8e+J40gcX9yqYxdq0sFefFdYBYqlq1p7
         u40JNKLG2Z4Ca3mThnxGSZs+dR7H1Xw+Z825hmVNUjE4gHbvDv95ue3pc2RgzbvR4dLw
         luQ8c4ljbt4ONQQCVTSFcI+2k4OdBa6RY+a9GuFjhhIccV1z4OngdsUVSx/Ymxkp1YXZ
         brrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aMrUqo0YqYh2lLrOaeq1NIAU7nPi5AK4ygCC5+IgXJs=;
        b=OzD7ndpFPwPZmuXtvdLOUypg4g69/p5rTaOrkfVfLAo1vSNgqp7m1dUjp4dVJ5mrHV
         1hBf23N3BZmevjUkiSJwyVHx5UT6QgY14BM5ZOa3PxNscs4mtXWSsQoEEativiWda0F4
         F9xko8Eta6vR+sjVYbHV0feuO+OIhamw+N7jv4DisCq0V+IwyrLtPewRMsNgIf75YDVP
         sVgp6ismcyCVQIgMmGKKCmsvG2QNVA+SXXFGzeuhAQP2YujHaCnYsiMrnAJCKacx31yK
         BYH5+3m3lU6UnvoHsalaKQ0ovh2Ibk8IN+UI8XZSwk/aCCExH80O30Oj9vY5uQ+2luKb
         0jGw==
X-Gm-Message-State: AOAM532p5wF/iuFJwwDQqcbBnLpirOja9bKn6aFNszM1olYgJ3WCRZvL
        WX40HP1RNvy3SgxSyk34ppZsIA1duKsg9A==
X-Google-Smtp-Source: ABdhPJzCaJaYhWu/7aVLIj1OQefDJ0Zu0iphS7NUCv/3Jcao8PWD08wakjGaaz0dRN3665HiRtM6Bg==
X-Received: by 2002:a17:906:86c1:: with SMTP id j1mr3063849ejy.373.1616142280425;
        Fri, 19 Mar 2021 01:24:40 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id b18sm3273727ejb.77.2021.03.19.01.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 01:24:40 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Anthony Koo <Anthony.Koo@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 08/19] drm/amd/display/dc/dce80/dce80_resource: Make local functions static
Date:   Fri, 19 Mar 2021 08:24:17 +0000
Message-Id: <20210319082428.3294591-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210319082428.3294591-1-lee.jones@linaro.org>
References: <20210319082428.3294591-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:527:17: warning: no previous prototype for ‘dce80_aux_engine_create’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:565:20: warning: no previous prototype for ‘dce80_i2c_hw_create’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:581:20: warning: no previous prototype for ‘dce80_i2c_sw_create’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:715:22: warning: no previous prototype for ‘dce80_link_encoder_create’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:754:22: warning: no previous prototype for ‘dce80_clock_source_create’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:778:6: warning: no previous prototype for ‘dce80_clock_source_destroy’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:868:6: warning: no previous prototype for ‘dce80_validate_bandwidth’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:913:16: warning: no previous prototype for ‘dce80_validate_global’ [-Wmissing-prototypes]

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Anthony Koo <Anthony.Koo@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../drm/amd/display/dc/dce80/dce80_resource.c    | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
index 612450f992782..725d92e40cd30 100644
--- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
@@ -526,7 +526,7 @@ static struct output_pixel_processor *dce80_opp_create(
 	return &opp->base;
 }
 
-struct dce_aux *dce80_aux_engine_create(
+static struct dce_aux *dce80_aux_engine_create(
 	struct dc_context *ctx,
 	uint32_t inst)
 {
@@ -564,7 +564,7 @@ static const struct dce_i2c_mask i2c_masks = {
 		I2C_COMMON_MASK_SH_LIST_DCE_COMMON_BASE(_MASK)
 };
 
-struct dce_i2c_hw *dce80_i2c_hw_create(
+static struct dce_i2c_hw *dce80_i2c_hw_create(
 	struct dc_context *ctx,
 	uint32_t inst)
 {
@@ -580,7 +580,7 @@ struct dce_i2c_hw *dce80_i2c_hw_create(
 	return dce_i2c_hw;
 }
 
-struct dce_i2c_sw *dce80_i2c_sw_create(
+static struct dce_i2c_sw *dce80_i2c_sw_create(
 	struct dc_context *ctx)
 {
 	struct dce_i2c_sw *dce_i2c_sw =
@@ -714,7 +714,7 @@ static const struct encoder_feature_support link_enc_feature = {
 		.flags.bits.IS_TPS3_CAPABLE = true
 };
 
-struct link_encoder *dce80_link_encoder_create(
+static struct link_encoder *dce80_link_encoder_create(
 	const struct encoder_init_data *enc_init_data)
 {
 	struct dce110_link_encoder *enc110 =
@@ -753,7 +753,7 @@ static struct panel_cntl *dce80_panel_cntl_create(const struct panel_cntl_init_d
 	return &panel_cntl->base;
 }
 
-struct clock_source *dce80_clock_source_create(
+static struct clock_source *dce80_clock_source_create(
 	struct dc_context *ctx,
 	struct dc_bios *bios,
 	enum clock_source_id id,
@@ -777,7 +777,7 @@ struct clock_source *dce80_clock_source_create(
 	return NULL;
 }
 
-void dce80_clock_source_destroy(struct clock_source **clk_src)
+static void dce80_clock_source_destroy(struct clock_source **clk_src)
 {
 	kfree(TO_DCE110_CLK_SRC(*clk_src));
 	*clk_src = NULL;
@@ -867,7 +867,7 @@ static void dce80_resource_destruct(struct dce110_resource_pool *pool)
 	}
 }
 
-bool dce80_validate_bandwidth(
+static bool dce80_validate_bandwidth(
 	struct dc *dc,
 	struct dc_state *context,
 	bool fast_validate)
@@ -912,7 +912,7 @@ static bool dce80_validate_surface_sets(
 	return true;
 }
 
-enum dc_status dce80_validate_global(
+static enum dc_status dce80_validate_global(
 		struct dc *dc,
 		struct dc_state *context)
 {
-- 
2.27.0

