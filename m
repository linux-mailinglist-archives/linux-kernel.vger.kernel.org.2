Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9640438AEE4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243002AbhETMrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242613AbhETMoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:44:00 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC076C05649F
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:03:17 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id h3-20020a05600c3503b0290176f13c7715so5060672wmq.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+fmZglR54ll04aap/nnrS1lTMmfuDtfEf2wXqJX6PX0=;
        b=ovUuBIpidetnGOoSyQualmIn8fZ/i0UtYvGw3trII7Y8HUSva2w3aKXILZI3TNQoTq
         cGX973y1nw9iyAPD/T6ZLlSmDs6LUAvNrTbiLiqtEwiWwkegm+qkApuZZqKss6d5oeCz
         8h/YpzebuSZkEhunQpCVEDiE5fm4VjYhzR+4CXlHHGDwWwtDi5VRyt3DHu95k6ufJks3
         Snu0++kd82BETGmIUFSYJkr0kwMzPOs8qagvuxn3Klw10mKm0lW6CwjPlyhi/KHN1RDy
         dftAbTbwEIo5qNGZWjVG5hM//kJX7lDw+n1oU9wYzzfblnJKWdb6h7OhK4+tBxk1otrg
         Rn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+fmZglR54ll04aap/nnrS1lTMmfuDtfEf2wXqJX6PX0=;
        b=B8cpQogKJPkUfTvNKIFTDThtHr7fNsMXoWHLpuqWz6QowR0ekBgLoxybpGjLS8Jbrh
         wUMFK1tF86lZzIcThndWQQztt8XN/Wxqp3IPnYkfD8ciadfl7XZaRQJvYL6ZoLhRCM7l
         yuzleA0nfe4MHW2RctN3lEytvvMVxmuhfVHG4o6FmjPfB8fLrl5PWVbFuqjCRktAu6Bl
         NseHo9a/DCRbkF7B5b8KUeS2IJfWzCI6/Yfx8/Snrvs0JpnUF9yeWVBFB1YAKhWr0VRm
         XS2/eHMUlXnSwPXiay/cQFA05Wxi41z7POkHUhRebCX1mAVFNCRYDKIBNP22YlwecXeX
         w+UA==
X-Gm-Message-State: AOAM530SSd07EZ9YkwWm9yl94ztNIJucKorI4vkN3LncCtQM8PclLIRS
        BJK/KxwZdynyNWSsIoUqKXfG5MnC+MQ5VA==
X-Google-Smtp-Source: ABdhPJw8kaYI5LLeHaobAMA/X+5SKA38x92KIomeDesCAADoarpEPLvyZ1HDdbjflDFVnFg5Iwu2fw==
X-Received: by 2002:a1c:6503:: with SMTP id z3mr3279429wmb.72.1621512196541;
        Thu, 20 May 2021 05:03:16 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:03:16 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 24/38] drm/amd/amdgpu/mmhub_v9_4: Fix naming disparity with 'mmhub_v9_4_set_fault_enable_default()'
Date:   Thu, 20 May 2021 13:02:34 +0100
Message-Id: <20210520120248.3464013-25-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120248.3464013-1-lee.jones@linaro.org>
References: <20210520120248.3464013-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c:446: warning: expecting prototype for mmhub_v1_0_set_fault_enable_default(). Prototype was for mmhub_v9_4_set_fault_enable_default() instead

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index 47c8dd9d1c78e..c4ef822bbe8c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -436,7 +436,7 @@ static void mmhub_v9_4_gart_disable(struct amdgpu_device *adev)
 }
 
 /**
- * mmhub_v1_0_set_fault_enable_default - update GART/VM fault handling
+ * mmhub_v9_4_set_fault_enable_default - update GART/VM fault handling
  *
  * @adev: amdgpu_device pointer
  * @value: true redirects VM faults to the default page
-- 
2.31.1

