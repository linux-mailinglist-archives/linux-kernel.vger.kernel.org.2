Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C0538AEEB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242667AbhETMsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242935AbhETMoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:44:32 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A349C069147
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:03:42 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id f6-20020a1c1f060000b0290175ca89f698so5255471wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6mgshcP2pz5KQTmITqtWPb+8Vos4vgRG6+nB+UjzMjU=;
        b=tUt9PCzCAgYSzeHm+P1Ghip4HpN8YnHaAQec9JZBmLu/UiSm3dqz+0Eq4AUl1JeewR
         GPJihct9FOVQk7MB2BFf56q8fgx85aYR1AVv4Qb6uC8h6Ig9DVcUY7MNDzmrmoDmnIVb
         b/aDxqtCCaItHxQN4Vue6SffHLJ7GJRadEFaztJ5Q8avyChaDNrAD+Ve16oA+kOl3BzC
         I4cIFXOmH4nMVxIsG+Ishev7ik97tI0aY9qluBFyK3K2uGqRy9bxMoPdkvr2l4hkolMs
         M8aDaXX0uZ1vnu1y9mtQxAFhZKb3Dmtkr/iNiF1oT3caN0gj4X66CvQgpZcatQCGQTDQ
         Ig2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6mgshcP2pz5KQTmITqtWPb+8Vos4vgRG6+nB+UjzMjU=;
        b=plkLqpCemMK0fF0AYLJFtdk/2TMnZlMUpT9Jm6Hv//GJbFsQmlLFdrtj4ioAq/ZHf3
         kHHdLRyqDBUAhFnN00gUGhR1nOJtg+A7wasw2yUdp3fq4rX1NLVUlsXiE8q85rz1dj12
         WmOfoEWpCeG9NIm2geNMcVz60fwqJjl/khSv1C31uyMYu/w6BiS7joAQpujeCUdpP6CK
         7ZbU/3D990fLii+uWKI72hb0GWfcen6+Ywm2V6SOAI48IISw+cXFl9rCRbCYGiqgBUMH
         dwXAlVStdRfSjmU7ISsfEX0CHzGs00Y0aPazQXa7tzhIOOUtxkhJ+fbI1V9tf6bdKx/H
         kEIw==
X-Gm-Message-State: AOAM531xUh5euZtCPHl/ml6bdbsBlCRKwzr2zQJgrkXE8soKoaBCYW0b
        03K+yddzTW0u5Y02c7FYC5p4tg==
X-Google-Smtp-Source: ABdhPJy7Digd+9bRZbHP/CdiStM7jlSFRh4jCbRvATVAcPCDbZlUSdF/nEVi4DaSTU2nAfXjcoZCBQ==
X-Received: by 2002:a05:600c:2054:: with SMTP id p20mr3758231wmg.165.1621512221171;
        Thu, 20 May 2021 05:03:41 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:03:40 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 38/38] drm/amd/amdgpu/smuio_v13_0: Realign 'smuio_v13_0_is_host_gpu_xgmi_supported()' header
Date:   Thu, 20 May 2021 13:02:48 +0100
Message-Id: <20210520120248.3464013-39-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c:99: warning: expecting prototype for smuio_v13_0_supports_host_gpu_xgmi(). Prototype was for smuio_v13_0_is_host_gpu_xgmi_supported() instead

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c b/drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c
index 3c47c94846d6d..39b7c206770f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c
@@ -106,7 +106,7 @@ static u32 smuio_v13_0_get_socket_id(struct amdgpu_device *adev)
 }
 
 /**
- * smuio_v13_0_supports_host_gpu_xgmi - detect xgmi interface between cpu and gpu/s.
+ * smuio_v13_0_is_host_gpu_xgmi_supported - detect xgmi interface between cpu and gpu/s.
  *
  * @adev: amdgpu device pointer
  *
-- 
2.31.1

