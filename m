Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2AC32BE62
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385645AbhCCRVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359151AbhCCNoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:44:46 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90769C061224
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:43:43 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id o2so5882196wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aMrUqo0YqYh2lLrOaeq1NIAU7nPi5AK4ygCC5+IgXJs=;
        b=Dc9uXvQ6IBRfw4ce1lVqSawXu+pLRKluVs3NeIhk9HbiXv7ZEZLMHhwykMsSZ7IZe5
         hDaVIqxDvaDCGIyMHQU3NWzDcGkqIr96ToZwHbGuyAOUaI7DL138T5FGV7diH8RM9BN5
         s7Jz3B+/AzzGjx7XyUrPMciF/UdCBHouYNNjEXpJLz9WVrXXDLFkwCAe8rjW4II/WpdZ
         1pj/XOigS2sPnqxeoazfG2juwZXaJfVOWKHeY595SOaQRFeE84S+fmgARWcB3UPgdaSz
         EJKxdB9Je6nPqXTLbqhz3AQGNO9sC+dI7uBUmD/+IEf2MU9+kxpb0PI+owSB8pqu+sKh
         UyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aMrUqo0YqYh2lLrOaeq1NIAU7nPi5AK4ygCC5+IgXJs=;
        b=cnW6RAqmKnf0xMixZx19DLfItR8GD/FzuFPD+AQrW7NB/2iAHg4XZzTj1yyL67oL5n
         pBODQqn21yYUvJgaGCnBSfi4zPAUcArHGo7nBPMYX2N0iwVO42UvZFl/z1rzY43lXAj+
         6ErHov82IYF7FcInUGbPo52dK11nqVJx8xomq82eUfhC65g4RrHX275tbo2lKxl4AfII
         yHDqer014aYIRQnWb+JH15x6/ZiKmC0UvSK1sH3xE8wAlXDZFnYdC+xedQvPCBbWhWwR
         k2rSkhjHZYvTvbvVhuxp4i01sYr3FReG487x+T5G5PuFLaMsGeMaFTwXQVf0XAdeMGKA
         MUvA==
X-Gm-Message-State: AOAM530Ji6mwf6Y+ylUmIqT8+lkRLuAAuUyCCvQ8XjxV4S4lar3Z3hdp
        rzS2d+9ANAsQpoAx5wMfiJzWp01T+nTARA==
X-Google-Smtp-Source: ABdhPJyUsmM1IO4EwYI0BEIkTbyo3YB12LxzbU6D8L4Te30JrMCh1N+sS9upjnpmcZ3RLlKbfP6Gpw==
X-Received: by 2002:a1c:2c05:: with SMTP id s5mr9141285wms.70.1614779021825;
        Wed, 03 Mar 2021 05:43:41 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:43:41 -0800 (PST)
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
Subject: [PATCH 11/53] drm/amd/display/dc/dce80/dce80_resource: Make local functions static
Date:   Wed,  3 Mar 2021 13:42:37 +0000
Message-Id: <20210303134319.3160762-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
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

