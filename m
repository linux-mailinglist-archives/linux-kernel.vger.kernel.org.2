Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E2C3912E5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbhEZItx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbhEZItT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:49:19 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A25C061756
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:48 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id s5-20020a7bc0c50000b0290147d0c21c51so27573wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=457+N/Rh8MOrxunbiCqh3NZ4tXXcJQCrqwWFpwHmuoQ=;
        b=eXye2VAu7ke1QG4IA5t59RbwXPJrmfNRjjWM/ZX7aXe3V5WXvNCs51/BnAiW/87OUz
         wbOcor9aJeFxcyFGJ8DyP+Qj3cjKFWej4YMsPxuiE4t38l8Ic5nUbMO9lpdnG0KyCiQi
         7lPvW6oeQujoIP7rH75qwdi8IrQmjL8JUYacfvXVJHwRnZn/uTBjCC3SCfR2HyIOc622
         RJsWNXPl35qz6z9VIl9vyXc/I0TsXOoyC5V7cl11B0WOI/KaMIqLqiPXcbRiSOU8OJbV
         tXp42hBXkNzQ/tMiutLeRtr+2FKfmH5VySknnQh7tW6ZGGqmdTYHTJDNjvCG44cJdH2x
         kjmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=457+N/Rh8MOrxunbiCqh3NZ4tXXcJQCrqwWFpwHmuoQ=;
        b=rXzVkXZzjl7HA68y3FZquIcZNQGsPgEI2H4h13IC5eBRLuBA9sj3x1MObp32AN8kVP
         VWqO4ij1DAQlhgLyJK5IuONu5qZRse6LC2B7ZmsiebwjBgDp/s4gdOXarXXR7HWXAwbe
         QyYjjnzzwrodi5FRC9fi6PEP5tD5NbAjPs17BVXkoSNKkGHMr5YwpcTPHMJZ0i5XXRGR
         S8J7l08I7+Us71rJgSIZjSnzTIaaAGrNjq9UUYnaK0848reRUGvqzbSj5RT0EcMwiBrc
         HP75KpVQ27PNF19SLI0XhcpP2s5MOtHikJT7snEBrGyD7OHi4yzWf7RHVHy+OW2EZ0j6
         xvOg==
X-Gm-Message-State: AOAM533fFbop9gMcHYr8obUAMitgt6OF+PLsA+oYLbWjYJG5gQEDp2Zp
        nI004wyFWsUcz56s1sJpTKcpLw==
X-Google-Smtp-Source: ABdhPJwhQpXCO9aTmhAWOI0ab/F/dQs47s/6mY6P77cZcp8LMxjOIvTKWWaMq4vhjky5DggbReaIJQ==
X-Received: by 2002:a05:600c:4f0f:: with SMTP id l15mr2308055wmq.143.1622018866990;
        Wed, 26 May 2021 01:47:46 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:47:46 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mauro Rossi <issor.oruam@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 16/34] drm/amd/display/dc/dce/dce_transform: Remove superfluous re-initialisation of DCFE_MEM_LIGHT_SLEEP_CNTL,
Date:   Wed, 26 May 2021 09:47:08 +0100
Message-Id: <20210526084726.552052-17-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp_psp.c:374:22: warning: no previous prototype for ‘mod_hdcp_hdcp1_get_link_encryption_status’
 In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:28:
 drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_6_0_d.h:568:43: warning: initialized field overwritten [-Woverride-init]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:157:14: note: in expansion of macro ‘mmCRTC0_DCFE_MEM_LIGHT_SLEEP_CNTL’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_transform.h:170:2: note: in expansion of macro ‘SRI’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:183:3: note: in expansion of macro ‘XFM_COMMON_REG_LIST_DCE60’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:187:3: note: in expansion of macro ‘transform_regs’
 drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_6_0_d.h:568:43: note: (near initialization for ‘xfm_regs[0].DCFE_MEM_LIGHT_SLEEP_CNTL’)
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:157:14: note: in expansion of macro ‘mmCRTC0_DCFE_MEM_LIGHT_SLEEP_CNTL’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_transform.h:170:2: note: in expansion of macro ‘SRI’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:183:3: note: in expansion of macro ‘XFM_COMMON_REG_LIST_DCE60’
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:187:3: note: in expansion of macro ‘transform_regs’
 drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_6_0_d.h:645:43: warning: initialized field overwritten [-Woverride-init]

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Mauro Rossi <issor.oruam@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h
index cbce194ec7b82..e98b5d4141739 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h
@@ -166,8 +166,7 @@
 	SRI(SCL_F_SHARP_CONTROL, SCL, id)
 
 #define XFM_COMMON_REG_LIST_DCE60(id) \
-	XFM_COMMON_REG_LIST_DCE60_BASE(id), \
-	SRI(DCFE_MEM_LIGHT_SLEEP_CNTL, CRTC, id)
+	XFM_COMMON_REG_LIST_DCE60_BASE(id)
 #endif
 
 #define XFM_SF(reg_name, field_name, post_fix)\
-- 
2.31.1

