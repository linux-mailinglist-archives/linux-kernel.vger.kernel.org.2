Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650323912DE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbhEZItj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbhEZItP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:49:15 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03094C06138E
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:44 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id y184-20020a1ce1c10000b02901769b409001so29495wmg.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X92MMk5kMi/9Whx04jPkFETzN+cajEcLCrynmOFE/4E=;
        b=h9EonsBwz/L4qhRXfcmGTgEQaj4rDXaTaENbNk0xlbWhzOzw3iokduWpAr1XGqvUYN
         mCQkU7iW5Ma/zft9eiE3GgFXXMsv0TDecBvlMSmwZWwY7ZGw4yQ73VZqRG+4OGWcHcsw
         AZH1HqlOL6gyIIGI5k42oq5XLy2rYWrZmQkya+Anjm0IScxY7bMXLGi+fvFVR0BAATM5
         14SQjCaAeDmemdH/qHWXKgE/GLkh/lKQILaBoIVP1pkFXhTxLckAaIcg+AcEPnrEv4re
         WgukuG4TDE9/Uz7FvNnqB9w/Mk6LFDWBrDCr+Lz0T2ooic53RQuR70abTxVsWAVfvGkc
         CBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X92MMk5kMi/9Whx04jPkFETzN+cajEcLCrynmOFE/4E=;
        b=hPKtVQ0dLIE2IThufHEbOZjYpaCQlsCILLKBkUfmf4C7EC73IUKeOzFDYAS3Od2Uwi
         2qrTqgixcse1DCfznCnKM9Ll8qRacoM5J7JdYgaIejxuby7HH6K7LW8hwwQdSjse+WQf
         vgQvdjqGUzc3Xl5vRaHPgpEZL+X06v3NmxxH8HWfjc2xfHo19xsUesmSQJXyWDRIOD+Q
         EuosSpBce+U78sr5Tgd6YABx3NUgRJXNUqIKpUMePOuviX8OQyXD9bpk72yHqZAN2AoJ
         4zHL3Nr2ia9cWoiEh5XrglCVhfB98nt/bzyK/V16dt0IjuNsMRsAwCTpOa0RhYMw+Sas
         VR9Q==
X-Gm-Message-State: AOAM532pA7d9rwb+yPvqAQmTJEE1ghhR1eSu7uMuvHEBMoZo3Vw19wXF
        7/aYR3OBRgHYz69272CrmDQnvA==
X-Google-Smtp-Source: ABdhPJyx1uFISeXmdtKQQhnTK23vTXiJRYW6DYcboA9WMr5VX5C3wH+hrPWw8ug/Shp608nkyZ0i8A==
X-Received: by 2002:a1c:e284:: with SMTP id z126mr1717471wmg.108.1622018862620;
        Wed, 26 May 2021 01:47:42 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:47:42 -0700 (PDT)
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
Subject: [PATCH 12/34] drm/amd/display/amdgpu_dm/amdgpu_dm: Functions must directly follow their headers
Date:   Wed, 26 May 2021 09:47:04 +0100
Message-Id: <20210526084726.552052-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526084726.552052-1-lee.jones@linaro.org>
References: <20210526084726.552052-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:608: warning: Function parameter or member 'interrupt_params' not described in 'dm_dcn_vertical_interrupt0_high_irq'

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b4e95d3ff3b88..ae0a95c5f1d8c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -601,6 +601,7 @@ static void dm_crtc_high_irq(void *interrupt_params)
 }
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
+#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 /**
  * dm_dcn_vertical_interrupt0_high_irq() - Handles OTG Vertical interrupt0 for
  * DCN generation ASICs
@@ -608,7 +609,6 @@ static void dm_crtc_high_irq(void *interrupt_params)
  *
  * Used to set crc window/read out crc value at vertical line 0 position
  */
-#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 static void dm_dcn_vertical_interrupt0_high_irq(void *interrupt_params)
 {
 	struct common_irq_params *irq_params = interrupt_params;
-- 
2.31.1

