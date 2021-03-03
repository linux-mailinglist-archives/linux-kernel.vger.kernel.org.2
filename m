Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE7032BE55
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385580AbhCCRUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350106AbhCCNoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:44:20 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866C0C06121F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:43:39 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id f12so19930480wrx.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Quc2kUn4zxyJwPjFnwIzGGrQHrzECWlhqtsSXbJueZc=;
        b=ZsyMPRW9QBkC/Ih85kKhmz4YGoEObQ/YxdodsqQrvvAe4BorhfF8b0CVqsxplW4lZJ
         G6nXul6/Poxd7MlR+c60M/IowDeDVmsoSNAO7/XZofVeoq0Wx+U73wYVvL9gD+ecPCTa
         SdkbYZTluzU7XVX6LBWI1Z2WYNNfuTvs9rn7OWz/Ud1K5KnZJG5i5a7fj0LIB2MJE+bT
         hsjumX83elTXdLYYw/z3vZ9IxGOtgTVucQn18omtvAXrzksJoibAz0enmNfcdvJYIrib
         YrnNGjo+6n1FULBR+nT8xa26l3ctUCgLASQSzuE9nyZNcfID+1sRyXk+z/2C9uPVOH7n
         gD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Quc2kUn4zxyJwPjFnwIzGGrQHrzECWlhqtsSXbJueZc=;
        b=H+ioICUHrbFRdv1fFXv7LTMW3ae8wBLlgay7YfDNcbLuKqy5nO9nJfHvx+Ei8nAOKr
         DF4GgFOkI4j9fJrk2DGgbk5E+rQ/gv2l5zbhnPqiLziFV2uute0fDoa3asB5OgsYp3B1
         RnGB9mvJHoIs9d5Smhsw6R7IVRD7Y1sYfmWReqwMFM9SY8II3Mk6o2t808FpYVXM+87R
         9oDRFXD2ZCOk2Q95uZbHPITeeXWuBentscGNr3np1ezntDyWEc6eOyUxukBwwXcVNtG2
         gOX+pQwLXIjyCYT9TQtjjKVQl9a2gOrZX8QaPVccVoR/UT91yBPqwQGYhEnorJkKR4QA
         3Djg==
X-Gm-Message-State: AOAM532fUZMRL+auKFpKXP1EXYq4DxeCE2U2yq3QafFWrnsgubWibpd5
        hyoBYA0oPcfMJ2nmJWb20RLpKQ==
X-Google-Smtp-Source: ABdhPJwoS+oCFNTWZ5t67qRoR7YW69ytGqSXrSMYfn60dFtl/bMIFBBKbbS7ueU75+L9BeANFKW4gg==
X-Received: by 2002:a5d:64ac:: with SMTP id m12mr27033016wrp.138.1614779018312;
        Wed, 03 Mar 2021 05:43:38 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:43:37 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Colin Ian King <colin.king@canonical.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 08/53] drm/amd/display/dc/calcs/dce_calcs: Move some large variables from the stack to the heap
Date:   Wed,  3 Mar 2021 13:42:34 +0000
Message-Id: <20210303134319.3160762-9-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c: In function ‘calculate_bandwidth’:
 drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:2016:1: warning: the frame size of 1216 bytes is larger than 1024 bytes [-Wframe-larger-than=]

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../gpu/drm/amd/display/dc/calcs/dce_calcs.c  | 29 ++++++++++++++++---
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
index e633f8a51edb6..4f0474a3bbcad 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
@@ -98,16 +98,16 @@ static void calculate_bandwidth(
 	int32_t num_cursor_lines;
 
 	int32_t i, j, k;
-	struct bw_fixed yclk[3];
-	struct bw_fixed sclk[8];
+	struct bw_fixed *yclk;
+	struct bw_fixed *sclk;
 	bool d0_underlay_enable;
 	bool d1_underlay_enable;
 	bool fbc_enabled;
 	bool lpt_enabled;
 	enum bw_defines sclk_message;
 	enum bw_defines yclk_message;
-	enum bw_defines tiling_mode[maximum_number_of_surfaces];
-	enum bw_defines surface_type[maximum_number_of_surfaces];
+	enum bw_defines *tiling_mode;
+	enum bw_defines *surface_type;
 	enum bw_defines voltage;
 	enum bw_defines pipe_check;
 	enum bw_defines hsr_check;
@@ -122,6 +122,22 @@ static void calculate_bandwidth(
 	int32_t number_of_displays_enabled_with_margin = 0;
 	int32_t number_of_aligned_displays_with_no_margin = 0;
 
+	yclk = kcalloc(3, sizeof(*yclk), GFP_KERNEL);
+	if (!yclk)
+		return;
+
+	sclk = kcalloc(8, sizeof(*sclk), GFP_KERNEL);
+	if (!sclk)
+		return;
+
+	tiling_mode = kcalloc(maximum_number_of_surfaces, sizeof(*tiling_mode), GFP_KERNEL);
+	if (!tiling_mode)
+		return;
+
+	surface_type = kcalloc(maximum_number_of_surfaces, sizeof(*surface_type), GFP_KERNEL);
+	if (!surface_type)
+		return;
+
 	yclk[low] = vbios->low_yclk;
 	yclk[mid] = vbios->mid_yclk;
 	yclk[high] = vbios->high_yclk;
@@ -2013,6 +2029,11 @@ static void calculate_bandwidth(
 			}
 		}
 	}
+
+	kfree(tiling_mode);
+	kfree(surface_type);
+	kfree(yclk);
+	kfree(sclk);
 }
 
 /*******************************************************************************
-- 
2.27.0

