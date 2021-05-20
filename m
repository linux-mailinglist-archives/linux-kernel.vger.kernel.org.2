Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6987338AEDE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242594AbhETMqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242806AbhETMoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:44:21 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636B7C0564AD
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:03:35 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id i17so17366400wrq.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X9eczHip+J0dwqD8Nynlf0SQVH9uQ9i0PT+0Vah0Gl0=;
        b=EBBm/BAj9BTJp956f9eBv+yUCERX2gUNVAM6K/5E4csMp3i8GsP0qbgOm0BU51QRPT
         6nZwAPPp4tiz1c50sSMPznww3MHbW2TC23YqcXaF+HTp7ZnZ9HSGMonK8a1ZKw5SrLH5
         oJpnp4A7uLGuhrKjG6xl92kK2l3WXZ9+gU6bOrPj+wQ1mvnabg1GgtQs7S7B30Y19HIE
         MCTWxGCtlQMnK/H+JaYrycrc2+WEVxcDH//S1RDdP5XUC7hL8qakz0B2Bpve4HW+1qd5
         tu8gFTy3HGzvAwq/DnIU51mjniWNYmOd2pDlwG3048bxvSJ0F4DAUgCO+tlb+dlgUz9Y
         6ckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X9eczHip+J0dwqD8Nynlf0SQVH9uQ9i0PT+0Vah0Gl0=;
        b=CGbM2ndtNACM1oXbsTlE5bQM6iUXVt3voq6NNWaODG2f00VD6eX1ssO2XWHo/dkYfN
         Ly5aiJVwXaqvhQuOMl1j/vZw8fM2ikDZRgRmtLB9C1EePB4D4ZxdTlEPji5uHN9qZuRU
         oDTLkRd0+6dmyIRwF7JrPNcteJHqPRf3dpXfSsyKD5deJTz24BLkILqNQr4Wnh3LOtii
         BO/fCKPpSuFfDpcgcwxLllCwudxk+zwqeDYpzgnkLhvddmqSyuZAWn4z4ox76f1e224G
         kjrwdP7PVsnCDS82QUKBFDsBZlSHFVnJAnZze4C0ueTYD1jTjpxAmS0/WY7jKlSHRvDd
         xU5A==
X-Gm-Message-State: AOAM533UQMRQpYnMO/AE4gdqPkUKOtuGMSbAT8leWX2Nq652tIF2Q2o7
        QZfdx24+4LTyLu5fd8su3KgJ1A==
X-Google-Smtp-Source: ABdhPJyRIxha+2unj4GubwBfRPOO/kKMbHctRfrTKSCS4y70HgOgR3Rv8Bl0IBQd/a0bAg1psWp//Q==
X-Received: by 2002:adf:ed47:: with SMTP id u7mr3957954wro.254.1621512214037;
        Thu, 20 May 2021 05:03:34 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:03:33 -0700 (PDT)
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
Subject: [PATCH 32/38] drm/amd/amdgpu/sdma_v4_0: Realign functions with their headers
Date:   Thu, 20 May 2021 13:02:42 +0100
Message-Id: <20210520120248.3464013-33-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c:764: warning: expecting prototype for sdma_v4_0_page_ring_set_wptr(). Prototype was for sdma_v4_0_ring_set_wptr() instead
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c:830: warning: expecting prototype for sdma_v4_0_ring_set_wptr(). Prototype was for sdma_v4_0_page_ring_set_wptr() instead

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
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index d197185f77890..ae5464e2535a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -754,7 +754,7 @@ static uint64_t sdma_v4_0_ring_get_wptr(struct amdgpu_ring *ring)
 }
 
 /**
- * sdma_v4_0_page_ring_set_wptr - commit the write pointer
+ * sdma_v4_0_ring_set_wptr - commit the write pointer
  *
  * @ring: amdgpu ring pointer
  *
@@ -820,7 +820,7 @@ static uint64_t sdma_v4_0_page_ring_get_wptr(struct amdgpu_ring *ring)
 }
 
 /**
- * sdma_v4_0_ring_set_wptr - commit the write pointer
+ * sdma_v4_0_page_ring_set_wptr - commit the write pointer
  *
  * @ring: amdgpu ring pointer
  *
-- 
2.31.1

