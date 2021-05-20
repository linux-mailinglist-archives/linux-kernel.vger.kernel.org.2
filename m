Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD9D38AECF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243011AbhETMpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242449AbhETMnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:43:52 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9544C0611AF
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:03:10 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v12so17386104wrq.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ORngqLW4L2zdTApLGcFRT++FkyS233QJRd+HHJUy1ZY=;
        b=OwZKFXat7QOpuAe9T/E2FnG6IWhBsxkdiaopAfAMhCSo2LU3SbsOU9JO7w72ceqS8C
         FZ9FqBXSiyasTx7FaT/iWnoyItrte5OQjvak4wHoXmVrBLWAxvpjXGgEApRHBZf8lRp0
         4ZlT4hCnoT9e8AiOqOF9Q3KeZ4cK0vIDsybkwg4673URzHQttcm2VMvZp50vWZgmndFx
         C5l9Qt8/ZJp40BVtvzY+QNgg+cQmC/mTbBy/uuZobIV47wGmvv2hzyIUBbKr557KROSa
         1u8i8WJsDmDcXFRHcPNRE27hhBJYy+FqOsVcxTcEMjZS/4o6tGNEBBvg4KjsngghfREV
         3Ozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ORngqLW4L2zdTApLGcFRT++FkyS233QJRd+HHJUy1ZY=;
        b=ToDmjb04il15AXcrDiNw4oI6xpFywY9H5sESo8X0dBOf6IKwjauZcSnNwPG2fj46Oa
         lYPY2auvlDAkDZqD7Wr1D/wcHHnH14R7JzTVxsOnnXWt3qzg7sD5sDvLty4xqKrOPH7m
         +Hrz3aU9NhTixsCyE7Y/LDDxq3XH+CNo1Cf/EcN5HNakrCikg0mESpGkG3pzoqq4Nhx8
         DjlhpQgpk/V2eYZk421dnI3AeHXWKEL1fk0H1lmJ5Fs6hL3dWWilDEsh10R/BT1EfuJF
         B2FHkluu+wlv++U4SjEHpV7Hmn84+9sNVKwWrzyZDWrjfdyW4jMaEx0H3yY2UEn44yp4
         uk9g==
X-Gm-Message-State: AOAM532XTKNddA0IpeLUO7TjcTNSaTZv8UpzqoRRCOHG2usvYmay315Y
        NbKdlDgGIpJMggQeO5kQHHR5ww==
X-Google-Smtp-Source: ABdhPJywahqmGqUniBXsHiwugmEi2oTc+D0Jdl2htYoDQ3fBFQRtKVzFD9Mqaj8Dp7jr9w/uo3hGqQ==
X-Received: by 2002:a5d:45c6:: with SMTP id b6mr3904749wrs.333.1621512189384;
        Thu, 20 May 2021 05:03:09 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:03:08 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Luben Tuikov <luben.tuikov@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 17/38] drm/amd/amdgpu/dce_v6_0: Repair function name of 'si_get_number_of_dram_channels()'
Date:   Thu, 20 May 2021 13:02:27 +0100
Message-Id: <20210520120248.3464013-18-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c:468: warning: expecting prototype for cik_get_number_of_dram_channels(). Prototype was for si_get_number_of_dram_channels() instead

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index dbcb09cf83e63..c7803dc2b2d53 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -456,7 +456,7 @@ static void dce_v6_0_program_fmt(struct drm_encoder *encoder)
 }
 
 /**
- * cik_get_number_of_dram_channels - get the number of dram channels
+ * si_get_number_of_dram_channels - get the number of dram channels
  *
  * @adev: amdgpu_device pointer
  *
-- 
2.31.1

