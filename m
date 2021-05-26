Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE9D3912F1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbhEZIuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbhEZIt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:49:26 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0901DC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:54 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o127so239295wmo.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qhZgrAainLjec7+hq499eXjP+VFgJtwYW3msrbGd3QA=;
        b=e/cES6WXNf9+ZpY2D4VLQY1tDCYiL+YmBb4TxjZ2Yg7Tqivde+ECExm/VjRqhPnSwP
         pF8Dg4H6EuHK4qbZbPO+DGRTYWw4TuhME6GXJsqxUD9gzvrooDgB5lB8x9xiKzGig67T
         N8NBqVRkw51z8HuTtm2qK+cELNmbWunRFkBF6EJNSbgv7ANarLKuUJxEP+7/qMIYa+of
         HFTWFAqci9XzxxOxAndpAr5puhN1ats8ehvfyxupcGhc+COIFf7zIjylco2BMp0a5E+T
         WMrfVMcOJM1+t4t2yLfbGAPFUfRKjdwV6HG4pMnW90cWxOBzU2w//zjuoMjZbJ+iFBf5
         /dOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qhZgrAainLjec7+hq499eXjP+VFgJtwYW3msrbGd3QA=;
        b=sk1hdhmiLqolty7A5eAMF5RRdBcN8fIWnB72bOlFZZ33QPjpVphdrf1HlX76I5sWFp
         HkOteOzpqB+4eHCEwKgww18CE72Rokv60iZ/GbjIFAkYSNBUjHMmnpmTtp9MNUYE8tin
         X8WDJZ3v4aL7crk09T1a7QyizV2f/RRuPX9kFkm4MpYH5lA7aY6DWNWmh27SZTdBw4Ym
         NSgKuxANK1jovYlQpVN4IKa8eIzedLLzSMm8S+jzv0/Z0qe0X19eniOM2IqPCsmDf7wH
         8gJszr1yMHX4d5LuyqKL96ZkoZM+uR9lwKxh7AF5E7IFLFWDk4YcGq6Um/R7VFy9CKBZ
         qnmA==
X-Gm-Message-State: AOAM533+MSCORRajvt2WSJCBNahA2sPpb2ojhY0YUu8k3+g1qAf0GpsJ
        hXckr1qUBIdnQp8NIuJsb2GANQ==
X-Google-Smtp-Source: ABdhPJydthfwy6pyhiwfSi4Vw978YT5WPdxv2u67ek+4Ky6PZ2aPSphUROb7xbK91WYE7mAK79UCfQ==
X-Received: by 2002:a1c:c911:: with SMTP id f17mr28332218wmb.45.1622018872593;
        Wed, 26 May 2021 01:47:52 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:47:52 -0700 (PDT)
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
Subject: [PATCH 21/34] drm/amd/display/dc/dce110/dce110_hw_sequencer: Include header containing our prototypes
Date:   Wed, 26 May 2021 09:47:13 +0100
Message-Id: <20210526084726.552052-22-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_hw_sequencer.c:929:6: warning: no previous prototype for ‘dce110_edp_wait_for_T12’ [-Wmissing-prototypes]

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
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 9219db79f32b6..1ef1b1b33fb09 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -64,6 +64,7 @@
 #include "atomfirmware.h"
 
 #include "dce110_hw_sequencer.h"
+#include "dcn10/dcn10_hw_sequencer.h"
 
 #define GAMMA_HW_POINTS_NUM 256
 
-- 
2.31.1

