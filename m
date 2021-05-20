Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF63838AEE5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243097AbhETMr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242863AbhETMoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:44:24 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2809EC0564B0
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:03:39 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d11so17360803wrw.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tJTJtfpMV/J/H+YFu2v39vUwU64txzJ+siPwQcxgUUI=;
        b=mDFB9RE1bc0Vqz3kk4DPBdJ9UZ/aMsd+rUlwA7frOrSPKA4J5EOky+7+ysl+VIeslx
         VnuHUou9Hz0olWToCaUysglK/ryHBbFYTG1zdzpfEsRKX2oKSczKuKDc2NZI/0vROlwG
         nFEFSbfmg6XBybX7YhaVP+Tr/LE1gctAgIP1HLMc0JcMywAitb0spISUg8E4IOPhaaJJ
         Kqq4h1v8Gm03ZOYI1kvz7TzyM67/zNMNzWIRm1646/gx9rl1Tvfm9CQGE6wVv488bsYO
         r6S8oUrYDtO3fYI5BS7HPcNxS2VKfxQLPJABQ3qYCqjXM6uEPjbehPB4X9i5wQ+XUa3x
         o/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tJTJtfpMV/J/H+YFu2v39vUwU64txzJ+siPwQcxgUUI=;
        b=Br0ctwo4OozLU0LjMfvyHHuhXhqr5htiuH/6WlfbR0DvpJnd8Ar9ucLP48gqS1ff2m
         k4ltHv/mv4dtW0LD4RWssFMarC01ehfqMkgvbX0CIq2A4rRtXP4JAIlcCzxFuWpa72DX
         lT4Plto4QbuuxreJsPdFAbiV6wWqyHehYbBPeD1M/87q3uLWBBEZhN++MQpCzoRJ5dQX
         xjJgo6ATYhxminsnvQqsmPqI0ezm+ax1HnX2X2mDVrWE6KmSFjtnAK9lpKuWhOsZUqm9
         AilpN573e4g6OVuDkXPGYSHGtlwDAtwikWbK0csKlR8wie1foSC1ESr+IuiDE2avZ5RX
         9kAg==
X-Gm-Message-State: AOAM533QKF9T/VaMoUJfWvVHTq61kNhZQJRvo8/kMWqf3Yp7br8rIZgn
        Cb/YlmXTBd4BXBqw+Wt/Rca5bQ==
X-Google-Smtp-Source: ABdhPJwhOZLLUHKejvhGLkMhKQ561C0i0iSobmuqHgR5qbq460hZZkBpBeFxX4iu+mRWKCqZF6aUVQ==
X-Received: by 2002:adf:e0c6:: with SMTP id m6mr4107882wri.66.1621512217735;
        Thu, 20 May 2021 05:03:37 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:03:37 -0700 (PDT)
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
Subject: [PATCH 35/38] drm/amd/amdgpu/sdma_v5_2: Repair typo in function name
Date:   Thu, 20 May 2021 13:02:45 +0100
Message-Id: <20210520120248.3464013-36-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c:501: warning: expecting prototype for sdma_v_0_ctx_switch_enable(). Prototype was for sdma_v5_2_ctx_switch_enable() instead

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
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index ecb82c39b1062..deb907f960906 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -517,7 +517,7 @@ static void sdma_v5_2_rlc_stop(struct amdgpu_device *adev)
 }
 
 /**
- * sdma_v_0_ctx_switch_enable - stop the async dma engines context switch
+ * sdma_v5_2_ctx_switch_enable - stop the async dma engines context switch
  *
  * @adev: amdgpu_device pointer
  * @enable: enable/disable the DMA MEs context switch.
-- 
2.31.1

