Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3E234176B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 09:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbhCSIZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 04:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbhCSIYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 04:24:39 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5E5C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:24:39 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a7so8267915ejs.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ef573ga7uPK4RT11JA+ndmyIfMn9BA+VJVp6MRgehP8=;
        b=dMHEsAJifnq9SaoiVy6a4jAv6q5TgWHN0bw6c6p3hNz495FrJQDoE9OcCaF22eFfWM
         Y271i2mpcSMboBFlLIBl0HPweJHQ9jYdxFp5oFiuxwtfjnf6q/kbycrsC8IFNA4kC4cF
         m0XAxOa8plu+zF0uFSTocoWXQ9K9Q2WcmWW7Xq3ZqXEkPtXxW5XulFE0GhOsikSqMZM+
         sVC7XhxYnKZ2UGxJTo2kCE/42j7NpETrP4WatfhcT9v2OIHbCChuRqGsPRueln8Tcfwd
         0PoQFgtpj8igf0PkSn56Xbc4kWtZl+VsTMZTz1wsXRo/UVdvlFTnVNOIO0Qkok15BohC
         tTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ef573ga7uPK4RT11JA+ndmyIfMn9BA+VJVp6MRgehP8=;
        b=MDjAgBed2MYA2JoND8HCq/ILVu0t5Ze4uaSRpzgLYrCs919wO4m7WTJ56Lld7PRey1
         xPc8Qc6S5JsURmFpPaRJQsXOSeZ6ci6XbV7drLp5GIruuIfndtne2dHms6McM8VLVA4L
         cc9GSGRhx6+HJgOmRmNMAgs5KABbuXek662g+SzOu/aJDW5vPM7GMfaxRPo1fBqcpGtz
         IVjNhBEm8p8t5QDLCi8sr/2q5Hi18hpQfqRQZR/dLogmpN11EFtVw+4S8Zy2fx4F5m0y
         V/QL1WwwHGjksRitW1nobE0mewO+5+S6Kt08e2knBO2Zmpi/cUJ7y2dYAqNTajMjy7F9
         O22Q==
X-Gm-Message-State: AOAM532apsLQpBR72uYwThoSE7KcfsiQCyo4dD5esJqJgzeupunXTaGN
        Fh3M8dX2mQs6WyYmqCc0QMYmSg==
X-Google-Smtp-Source: ABdhPJxdXVbdpgPImlGPZFJsAxubAlxjpG/iiUI8Oy7R25y473Q7mKlKgIPTVMWOSyzTGqHj8qZ/Mg==
X-Received: by 2002:a17:906:400b:: with SMTP id v11mr2984223ejj.194.1616142278182;
        Fri, 19 Mar 2021 01:24:38 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id b18sm3273727ejb.77.2021.03.19.01.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 01:24:37 -0700 (PDT)
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
Subject: [PATCH 06/19] drm/amd/display/dc/calcs/dce_calcs: Move some large variables from the stack to the heap
Date:   Fri, 19 Mar 2021 08:24:15 +0000
Message-Id: <20210319082428.3294591-7-lee.jones@linaro.org>
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
 .../gpu/drm/amd/display/dc/calcs/dce_calcs.c  | 32 ++++++++++++++++---
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
index e633f8a51edb6..9d8f2505a61c2 100644
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
+		goto free_yclk;
+
+	tiling_mode = kcalloc(maximum_number_of_surfaces, sizeof(*tiling_mode), GFP_KERNEL);
+	if (!tiling_mode)
+		goto free_sclk;
+
+	surface_type = kcalloc(maximum_number_of_surfaces, sizeof(*surface_type), GFP_KERNEL);
+	if (!surface_type)
+		goto free_tiling_mode;
+
 	yclk[low] = vbios->low_yclk;
 	yclk[mid] = vbios->mid_yclk;
 	yclk[high] = vbios->high_yclk;
@@ -2013,6 +2029,14 @@ static void calculate_bandwidth(
 			}
 		}
 	}
+
+	kfree(surface_type);
+free_tiling_mode:
+	kfree(tiling_mode);
+free_yclk:
+	kfree(yclk);
+free_sclk:
+	kfree(sclk);
 }
 
 /*******************************************************************************
-- 
2.27.0

