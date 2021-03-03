Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7286E32BE67
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385703AbhCCRV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349238AbhCCNoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:44:15 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC433C0617A9
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:43:34 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id k66so6402091wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZlgsgeTsQs4mZ0QqFliW9MCgKZA8P4oKnuooJz0fj/s=;
        b=gVaHkDSRZ4XCGVHSPIw1rAYthoVgCtFdJwAry/SmYPLZyI0PyvecSEKZI/EXW4DvSV
         Bpqd9vwVd/8ZCypvVCmxBpYRy57M4/FRgGKDqYIq0nFYClOoTrnQyJ7ln/Q0lLfhi52t
         HJOLWHJFbgS7wZfDLdRrcP0fCEy+Ve3sqsGrlB4WrSqCuqfDM/tPNCgGnyEGnPCDCY3x
         26PaTDSTZzi+HCKHiHpvMLoshvx2IMO5xc3fAyRXCSpdqidzTstYHM2n8/XnXM+vLmYe
         4f+bhSH7K0S7757hRV6lRhNX0psijhfk3dfwCgxMunapIqceXx8QTX1q8jsGn3kYAkmf
         QNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZlgsgeTsQs4mZ0QqFliW9MCgKZA8P4oKnuooJz0fj/s=;
        b=qkHejDyGkJwpFVwDUxbYvBeFQt5VqZZO3YCkFkq0uHkZl80optPeECM6wx2jUn7PRC
         aMNsjNn69ZpT53uoB07Oi7bIvOgVZ47qTJccG+3jHmWgxykU+L0eghtWkzxSirmtkvPw
         pFCU+Xd6aL1Erzx9MxyufpsbkCvbOSXgKI9ImFy103Yf25IiivxHTZ23B0JQSQm+KpOv
         qolJpG+t0Qb4dBEv96SK4wQuFSF6eGyUi3/oT5YBMDVSpc7hR+LyKPnPAKcH/w+XmSEe
         b3WXqM8hWby4pgeENdRQtJRyFJrHXoqbf+Vndc0T7jRV3oKJaCIeT32IcJP7mCjJibtT
         mnvA==
X-Gm-Message-State: AOAM533B0fWXRx2UHErMlb8WS07vaDpqLBYovmYnqkXRBtDgTWIQwyCd
        0iNNVkc43sE/lg/GYxfSF5zjuA==
X-Google-Smtp-Source: ABdhPJx1BDI6vEwnLcvnd7UPVLQAAB3KdHvL5nicosU+YdtoR/ucUeX/XECUmu2FYY23px+LdytjDQ==
X-Received: by 2002:a1c:6543:: with SMTP id z64mr9300311wmb.50.1614779013487;
        Wed, 03 Mar 2021 05:43:33 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:43:33 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Qinglang Miao <miaoqinglang@huawei.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 04/53] drm/amd/display/dc/bios/command_table: Remove unused variable
Date:   Wed,  3 Mar 2021 13:42:30 +0000
Message-Id: <20210303134319.3160762-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

None of the surrounding code was removed just in case even a small
fraction of it was functional.

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table.c: In function ‘adjust_display_pll_v2’:
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table.c:1459:35: warning: variable ‘params’ set but not used [-Wunused-but-set-variable]

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Qinglang Miao <miaoqinglang@huawei.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/bios/command_table.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table.c b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
index afc10b954ffa7..9d3bc3a073821 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
@@ -1517,20 +1517,14 @@ static enum bp_result adjust_display_pll_v2(
 	struct bp_adjust_pixel_clock_parameters *bp_params)
 {
 	enum bp_result result = BP_RESULT_FAILURE;
-	ADJUST_DISPLAY_PLL_PS_ALLOCATION params = { 0 };
 
 	/* We need to convert from KHz units into 10KHz units and then convert
 	 * output pixel clock back 10KHz-->KHz */
 	uint32_t pixel_clock_10KHz_in = bp_params->pixel_clock / 10;
 
-	params.usPixelClock = cpu_to_le16((uint16_t)(pixel_clock_10KHz_in));
-	params.ucTransmitterID =
-			bp->cmd_helper->encoder_id_to_atom(
-					dal_graphics_object_id_get_encoder_id(
-							bp_params->encoder_object_id));
-	params.ucEncodeMode =
-			(uint8_t)bp->cmd_helper->encoder_mode_bp_to_atom(
-					bp_params->signal_type, false);
+	bp->cmd_helper->encoder_id_to_atom(
+		dal_graphics_object_id_get_encoder_id(bp_params->encoder_object_id));
+	bp->cmd_helper->encoder_mode_bp_to_atom(bp_params->signal_type, false);
 	return result;
 }
 
-- 
2.27.0

