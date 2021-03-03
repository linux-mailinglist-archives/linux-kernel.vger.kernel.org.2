Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F077932BE54
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385571AbhCCRUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349396AbhCCNoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:44:18 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAEFC06121E
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:43:38 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d11so23733583wrj.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wtdOZUPejXIxG4DafVTSnIWvo2XUWaKv8nLuUC2cuVs=;
        b=UZEv1TixOjptA51Xf0D3ZWP6qBa1BuK4fprFPpRVDcuJ49xPXUPJGp6E+dNYNXVJVb
         +wirSDrdZyG+W4R4vXCa+dP800Du/zenIk68HzB2fuoOISKqgdhiA0Yo9Dw6klTLejAP
         njUqmMMsdKiLqi/ldUnjDL3a/hP1xjda+KEfypBrkeXVvofjvEQ/A/MZ4RtN27PbnryP
         0Fp/Tpi1gfoz7AUMR+Ibx7IharnIQuPfmLONZAFKP0/IGEiKunj9r4odx6NNNPjayLCZ
         JfFU7iUcQlv+uNB5/2b5otcEpP3m/Dd0Eeq1XR9kHdAkIqe8fzQggTMec9s32vZPWYbr
         8Yqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wtdOZUPejXIxG4DafVTSnIWvo2XUWaKv8nLuUC2cuVs=;
        b=p7qUJj3oc1MeJSWkj8hbRCfDaSkQU1oYAl1dwEgyFWMFy8bd8Cz9HU/ECWIgmCjTbj
         pD06ZQ7BDwC3wTZHwi3nh4//sAjIRxbVaxz2t6zYJ3UFBaCpjBgYIw8jxzArBGf35uWs
         xfjjhY5tb5n/5RCFRdg5ZyFoiBNCcty3PhfY34sbyqprz9fsXEWEsv30d/QM3Rwm4Lve
         /6TtTc42asZ3KNZMD7FxSver19wg4QXdlf2vp5iILyQ8CfCK3FMZjjdQxUdSx/uB8vgf
         /Kuj1zf/nCg/Bcu79ItvqV9M1csKmYgRPvGZniWelXNIBXNzhnHe7tnjh2nNKvFbR7yA
         j8Jg==
X-Gm-Message-State: AOAM533T2/msH+l6rwVFd5GtoudlMhhF5AFouiSKqvqB+ZtY56ARARfy
        wFtQ2UMJo2OnQOPlT9TPuFNTtw==
X-Google-Smtp-Source: ABdhPJwcK9+jl2BDg1cjYoyYZxUkL7WUrEez2h4jezFZeCdqRD7CYTxftZHx2OfGFGjkntOswUUmDw==
X-Received: by 2002:a5d:6d0c:: with SMTP id e12mr26589790wrq.136.1614779016850;
        Wed, 03 Mar 2021 05:43:36 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:43:36 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 07/53] drm/amd/display/dc/bios/command_table: Remove unused variable and associated comment
Date:   Wed,  3 Mar 2021 13:42:33 +0000
Message-Id: <20210303134319.3160762-8-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table.c: In function ‘adjust_display_pll_v2’:
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table.c:1462:11: warning: unused variable ‘pixel_clock_10KHz_in’ [-Wunused-variable]

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/bios/command_table.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table.c b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
index 9d3bc3a073821..e879ceb0c49ed 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
@@ -1518,10 +1518,6 @@ static enum bp_result adjust_display_pll_v2(
 {
 	enum bp_result result = BP_RESULT_FAILURE;
 
-	/* We need to convert from KHz units into 10KHz units and then convert
-	 * output pixel clock back 10KHz-->KHz */
-	uint32_t pixel_clock_10KHz_in = bp_params->pixel_clock / 10;
-
 	bp->cmd_helper->encoder_id_to_atom(
 		dal_graphics_object_id_get_encoder_id(bp_params->encoder_object_id));
 	bp->cmd_helper->encoder_mode_bp_to_atom(bp_params->signal_type, false);
-- 
2.27.0

