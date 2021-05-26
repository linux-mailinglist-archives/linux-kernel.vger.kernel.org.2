Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E19F3912C4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbhEZItQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbhEZItH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:49:07 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA130C061756
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:35 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id u4-20020a05600c00c4b02901774b80945cso15025869wmm.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ey2XQCTHoPB7PbhRpIhhlCIFboLF4MIg90vAb+6Iw48=;
        b=L/iJmUQ1wl4h9pSToLi6ngPyg5UA7AeSWQLOEuFjYdsGt+aIJ2JW3IZyE7TyAvl9zp
         glIhu+aKxXtueYZgd2owFNE0ZH3GVlcEDRAUqpItp+X/sLU+ZR0QYqsLVt80CWoZJUk/
         8d8WNwVuJvhfQqGDn92TSIpDtUNG2tSRqfbjU47JhqUsypTbNrf101/f47GA1k352++H
         H1+XxvhmsG5nyLGBwyds2ImgQK8W/kvKF7HlRSoMRQP+UXOpqJQkYUi1HhAHi+j/Z6X3
         TtYsAajhfILOXFoKHIGLxd1yRvhSIi+4tL6F4Et9K+iLfpi8CuxPUGxU+XqxliUJ2Jdq
         FoyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ey2XQCTHoPB7PbhRpIhhlCIFboLF4MIg90vAb+6Iw48=;
        b=lGKZAyAarCGWLgodCwEE2IymVsyVANB3DhQWiajEfYUjtYgwrQbuWbCuf/QIVXSr2z
         +H7WbfMGC2FI3PFhWTUiOGll8ztV8cP+ebgBcnWQp/m0NJGkxGpF/HvCtuaNaVxRWU+N
         ZkUUwKRQ9Lhi6Byd3+WQmHbWpmY9KfNCvvNOf/DQHYahe4M00cqRvlwS6h74Hz0StRFi
         U86kgO/JE2dSLbmq47LIcNEl/zvyMF+t1cOb+wmrUaekd/q9xRRJxGT/BHsadY1Fvjy3
         +3o7pUSbk29DtzURz6YC0hXm52Due691S89eRzMzfCURLvqD5pBjYHTibIv7u33IGF/h
         tkxg==
X-Gm-Message-State: AOAM530/cHcI8sQvGYIADIqZ0LdbCwImCtkwke4XiDh2F+DJKnjwfMp0
        h8raZNkAZYARk+Cht1iyrmYekWJ9Sp+h4Q==
X-Google-Smtp-Source: ABdhPJzhoEFdv2lfo6EL3yXLQSIgGr2CwhLPmszdq9ctvreMndQ6VRfnClZOGx7KUBNH8MO6zsGhOw==
X-Received: by 2002:a7b:c417:: with SMTP id k23mr11601416wmi.90.1622018854475;
        Wed, 26 May 2021 01:47:34 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:47:34 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 04/34] drm/amd/pm/powerplay/hwmgr/vega12_thermal: Provide function name
Date:   Wed, 26 May 2021 09:46:56 +0100
Message-Id: <20210526084726.552052-5-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega12_thermal.c:171: warning: expecting prototype for Set the requested temperature range for high and low alert signals(). Prototype was for vega12_thermal_set_temperature_range() instead

Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_thermal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_thermal.c
index 0dc16f25a463b..ed3dff0b52d21 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_thermal.c
@@ -159,7 +159,8 @@ int vega12_thermal_get_temperature(struct pp_hwmgr *hwmgr)
 }
 
 /**
- * Set the requested temperature range for high and low alert signals
+ * vega12_thermal_set_temperature_range - Set the requested temperature range
+ *                                        for high and low alert signals
  *
  * @hwmgr: The address of the hardware manager.
  * @range: Temperature range to be programmed for
-- 
2.31.1

