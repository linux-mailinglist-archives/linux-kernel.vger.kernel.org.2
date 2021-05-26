Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6923912EA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbhEZIuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbhEZItY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:49:24 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45D1C061345
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:52 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q5so215312wrs.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7L06mynHw/Hvp7IRLB9pK1ya6b4whZKrsJ5rjcKPGDA=;
        b=p6dcifpgLEh0iuGoFQK2sK66NWHym2V+MK8Mgj2Gbu/s3pxQpqNCHtulzP0eEwjZrY
         4tLExkvLFAZ7n3wVD5ZNye6+hzn+kXamD+QGeriuWID3n3FGGixGYHkvug2JciMuvZ8W
         5Bxhq7HvBx1KgntYp8NgJlzoyA/n79QXt2c17qR6kmkq4mxv/im0kF0i7b425G9BfDYc
         Pe7JbaSsicLm68CiND0fuJr8KunrGw7U6+OEjwTY3RZPloUNp/PPutNRq/VcOuifCJ6u
         LlOR/QhJkBUayFg11eW5qX/3K1QBsFiv3Qg8qkTuZSrkI57AS/nS7hRN5THRTKD4441l
         iozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7L06mynHw/Hvp7IRLB9pK1ya6b4whZKrsJ5rjcKPGDA=;
        b=DggOQF9WhN+MyfqwbfPTOYJ2BeO1f7T8TZihzcb8Zn7pD7v/P/CRTHGyVO036ZGEzL
         RT4nGppVeBWiwExCf2k8FPNTbsdBKGn+nuHr+K6O+BxllggTmp4NONsNwVwy2tlO63om
         K80Bq0nlOt7YYSET6UI8XtW0VUacV6lP4+oE0xpIwD7/3XXSvhLj3LAaOF2z7LHTjrXb
         aLfxzVUW9EYYChMRVY+/keLhnENRay0Uuc3WBpRXHRSQwTpAOC+wj2ULW4FP6hpG0yQY
         NtJqvevb2DtxE7gbO3Rvono0tUIU2FTZqjUOkaM61gWGo5YItA0GiLvmcx9p9sQ2YB6E
         tVZg==
X-Gm-Message-State: AOAM5328i2k3ghaCs7v6tdBEWtIwj2GYZtV4tex5B1OkM/T4cKklkd4G
        vQQy6R1we7UMcWUdPO3unXMIew==
X-Google-Smtp-Source: ABdhPJztuqUrTTlF820RG/YpKIy9kbje3NTxS+Y/DPltHPd2xWY9oQPpPtmaMh8sTZnnxSSSeP3iXw==
X-Received: by 2002:a5d:4346:: with SMTP id u6mr31619647wrr.304.1622018871538;
        Wed, 26 May 2021 01:47:51 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:47:51 -0700 (PDT)
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
Subject: [PATCH 20/34] drm/amd/display/amdgpu_dm/amdgpu_dm: Fix kernel-doc formatting issue
Date:   Wed, 26 May 2021 09:47:12 +0100
Message-Id: <20210526084726.552052-21-lee.jones@linaro.org>
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
index ae0a95c5f1d8c..0b4841f377e41 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -605,7 +605,7 @@ static void dm_crtc_high_irq(void *interrupt_params)
 /**
  * dm_dcn_vertical_interrupt0_high_irq() - Handles OTG Vertical interrupt0 for
  * DCN generation ASICs
- * @interrupt params - interrupt parameters
+ * @interrupt_params: interrupt parameters
  *
  * Used to set crc window/read out crc value at vertical line 0 position
  */
-- 
2.31.1

