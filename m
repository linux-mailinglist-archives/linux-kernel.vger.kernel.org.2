Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224F53912E3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbhEZIts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbhEZItT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:49:19 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA3DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:47 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id f75-20020a1c1f4e0000b0290171001e7329so34516wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lH0QiIv9GplFfw8+sE0Oz9qNWUTXoSa9cJ3TV4liCwY=;
        b=RB/7ogGfRKR/H7xbMg6lQNSx4WrXK0TQZTmShXZ6vEsfWcdJt9mpwfOSaOSL1ocabF
         /L+NmojU7HiAsSEG+onzR8iw/jSwxAwiZvxxqQyIh2jDsOsHAv+ydEDMELlHuh+aoT/g
         wpOlNrw7F5oyIq8Weqcxg396wPPR2XTefQA029ZoYa2V3AFlbiST21TRICtIVUMwcLLD
         Uo5g2JUO6sWhLAmjiX8yx4YZrpjAmi5mrFL+Ue9nh/8iBuYPdLZEerF1WKq0TdqvD82T
         V0R0QuLlc77v1p3bR65MevvgCbC0PfDSSyJ2Qsd6JNxadfxJ6XpGRtK6u1DqxeuhxICk
         HxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lH0QiIv9GplFfw8+sE0Oz9qNWUTXoSa9cJ3TV4liCwY=;
        b=T6NN6zV+K43O+FVlIgzA3XMLy4mTOIuSunvZKd7S04g+G5kHuFpMkMd2/LbqthwJRx
         PvtUElT4kr/b7CVsLtt+Sa2iZTUyMB0jumusGBgAZQN2ShWZadPRLo9tQ8Ye0sQairRf
         4F716/4aNq2h8Ue2BWPh408AD06akZMJ2DagxC6IwKmE8W0prk6jw83ouEg8G3Ho5aos
         3sjkg1fIX7oI9b1r2NrY4y714a6eZVaQBmBWSG1qDLFfyDibIdf3pfR7m4sQxCwMq7tT
         GW+KnjNqqfYJcX7jA/7jlnGSqnz7JT3V/VqsWM4149PI2sASXz9mEMUprYpIs8icAvoi
         ZATw==
X-Gm-Message-State: AOAM530WCXSeuZT2/j1L0yxHrLtYlxPJf/WDEfzGQ6P6I5DPtil7R/Lc
        mAg7dg82DhTnGKDJeGmRxgmChA==
X-Google-Smtp-Source: ABdhPJxtgNzpcQUJUz+PEveawDKv5XlwuQ3p/fcDcouhayhnN7/EaDgJ8QeVnCBVRTFNMYQbAi+g0Q==
X-Received: by 2002:a1c:5454:: with SMTP id p20mr2263933wmi.160.1622018865874;
        Wed, 26 May 2021 01:47:45 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:47:45 -0700 (PDT)
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
Subject: [PATCH 15/34] drm/amd/display/dc/dce110/dce110_hw_sequencer: Include our own header
Date:   Wed, 26 May 2021 09:47:07 +0100
Message-Id: <20210526084726.552052-16-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_hw_sequencer.c:927:6: warning: no previous prototype for ‘dce110_edp_wait_for_T12’ [-Wmissing-prototypes]

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
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 5ddeee96bf235..9219db79f32b6 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -63,6 +63,8 @@
 
 #include "atomfirmware.h"
 
+#include "dce110_hw_sequencer.h"
+
 #define GAMMA_HW_POINTS_NUM 256
 
 /*
-- 
2.31.1

