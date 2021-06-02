Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03930398D14
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 16:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbhFBOg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 10:36:27 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:45721 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbhFBOgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 10:36:11 -0400
Received: by mail-wr1-f54.google.com with SMTP id z8so2519136wrp.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 07:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=457+N/Rh8MOrxunbiCqh3NZ4tXXcJQCrqwWFpwHmuoQ=;
        b=uActT3hvfwlLPIZ6RHgWI18UgapOBE6UhJ2FV+Z+7kx0FYvKBWb1JGMK+67m4XiN9W
         6KPxYFTp5kApYGtKlboWnuuZKOMlm55yon52q3jbgurwUFvSAZaacGVCHpXtSaZLG8r+
         MJN7c8Z58Duav2e+ZBSjATW+gRHrbGOFQl1xeUto/T3dFqI1TZOKJmL+QZmah37Sx6zO
         ha4P1AtfU02ImH5mnEFK0btmUyvMrEeraouty6b/pRgossm0hMwhryMK9NxXtJaOWuo3
         auIC+ZbLq7w/uCK8T+qn2Ejsr5/wyntXgh3uyC7WkVgTX13doyl1Vym8AkivxbZitD/T
         OnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=457+N/Rh8MOrxunbiCqh3NZ4tXXcJQCrqwWFpwHmuoQ=;
        b=XV/D30Yb3ATJ2XVP3gVd8g75mMOFhlTtdvV7btpMnc281zJkmOhU0VmyDJgtPvWnjr
         w/H052/BbpQjOYQ8lUTFGnh0vpmEtVwNxmb+0n0GWfi2J78fxBBAx5bToraj2nrSDv1D
         wdOR1510elfI18IyBaKyz7M3FNQ48vh6Re8MmDaBucmjsj9jkUUiIsnpsgY7dTXJhAJ5
         TNCQmrnLTnsaschGdFEBIusjgnoK7Yp541uCVawbyGBe94LLvOr60+TRyMMKgNCFKPiD
         kfpM/U2OLfsCMAhonSAfbrHoYrWas40OaN3MzTlIUrvzqnfacQzkMk/WiTOxFOcU0Qoz
         6PZQ==
X-Gm-Message-State: AOAM533utdCIFeUwauewU/OO+7UZGprRcI7AI7GqqNBnVGB7ceu0MmVr
        sns5pR23xro+iT893q5ScnGnHA==
X-Google-Smtp-Source: ABdhPJyVZdTdil8cZTIEEb4JxiStiib0c/SBUoFAYxulgJqOyRrYcJQd+VVKJ3BGvVLvI19muxWRrw==
X-Received: by 2002:a05:6000:508:: with SMTP id a8mr33884629wrf.315.1622644407227;
        Wed, 02 Jun 2021 07:33:27 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id o11sm132315wrq.93.2021.06.02.07.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 07:33:26 -0700 (PDT)
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
Subject: [RESEND 16/26] drm/amd/display/dc/dce/dce_transform: Remove superfluous re-initialisation of DCFE_MEM_LIGHT_SLEEP_CNTL,
Date:   Wed,  2 Jun 2021 15:32:50 +0100
Message-Id: <20210602143300.2330146-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602143300.2330146-1-lee.jones@linaro.org>
References: <20210602143300.2330146-1-lee.jones@linaro.org>
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

