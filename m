Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A9B38AEDC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242651AbhETMqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242774AbhETMoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:44:17 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB76C069141
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:03:34 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id s5-20020a7bc0c50000b0290147d0c21c51so5065485wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nynxxR/OsBCzgQqs0HwpEzxLm2OUnGw35ueUBnmCZ5g=;
        b=UVushAvSHMxa0C5XeIr0bdnDeei0Y1WMhTJYIgy8dRMkWcdNb44elX1h9GjF+D91/g
         3k64urbysVJKIrBU6PzA9VQ3NsXOwtgj13lRJYOyJYsJA3e0j/9qshxBzBZ6TtR5YRPe
         y/FRBOgs+Ef7wwJovho+qJW4lgNU1EePROSRQxihFEpoh+ATXkOFcIUpzwu4AUnPeVOm
         EeRD4yDhkcOrQtK2qkzw9DlMihFqF2Kcnh/TOt5xZU2mcps7qvrMLId8Ald+2NeO/5nr
         4koCiRAM+2HJ0uXudQpe77PWXptcGWavHthevwz9C/nmG0EBxHYBX7QkwZ5OVHTnadHs
         /Pkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nynxxR/OsBCzgQqs0HwpEzxLm2OUnGw35ueUBnmCZ5g=;
        b=o3os6rAhfvcFwMNiuyX33FMKj0k2HaJVeYhVo/gCW78xqPN23bF7JIn4TiokhHYRXW
         VEdZ4bt/GHH1m1w/Igo4qMn4XFDDI/Qkm7UG8V4uC50Opuidb6QNfQj7Mt6RSkgVgqta
         VSziyygW1gw14WWZTOxUr7D453cgZL/IQQDB3p5f+aBwyd2SgPvfIqejl0KQPG42PUyK
         HB25WqK4o8Cb3tnxAvQ8SUh5I6KaBenVD0gjj63zwVgw1rsKHyw5J4XHyDJuCL34N4Hb
         cia/pbvCHGdtbJnAAh+SWlUri3XT9JqWSqh05qNb8VUcCFRu6Ge2+MmXu/BHhSKCA+TG
         AFtQ==
X-Gm-Message-State: AOAM5327JwEiuhYg7rwLgldYPxSRgDHDjJOQ25ey7tIyrtFh2wF1xMp0
        nbPQVmVxK/lm01tfg5zV4BRf4A==
X-Google-Smtp-Source: ABdhPJwMr2S46p+INbbf4IlG3gi+W3uNAXiPXWi5P3w8PnLPD7lw+1iFRHCGlUXFBNZ3FsCYsPxzCA==
X-Received: by 2002:a1c:f30a:: with SMTP id q10mr3317496wmq.138.1621512213083;
        Thu, 20 May 2021 05:03:33 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:03:32 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH 31/38] drm/amd/amdgpu/sdma_v2_4: Correct misnamed function 'sdma_v2_4_ring_emit_hdp_flush()'
Date:   Thu, 20 May 2021 13:02:41 +0100
Message-Id: <20210520120248.3464013-32-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c:281: warning: expecting prototype for sdma_v2_4_hdp_flush_ring_emit(). Prototype was for sdma_v2_4_ring_emit_hdp_flush() instead

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 9f0dda040ec88..4509bd4cce2d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -271,7 +271,7 @@ static void sdma_v2_4_ring_emit_ib(struct amdgpu_ring *ring,
 }
 
 /**
- * sdma_v2_4_hdp_flush_ring_emit - emit an hdp flush on the DMA ring
+ * sdma_v2_4_ring_emit_hdp_flush - emit an hdp flush on the DMA ring
  *
  * @ring: amdgpu ring pointer
  *
-- 
2.31.1

