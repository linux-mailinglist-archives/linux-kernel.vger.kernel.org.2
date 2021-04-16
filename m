Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB753622E9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245110AbhDPOj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244543AbhDPOiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:38:24 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2D4C06134B
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:58 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id s15so32574425edd.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N6vojmZkPJ0W/HM2G539IcIFG9CT0JLwxTEhHQdKtaY=;
        b=rm9JZIGI7J8NRlsShT3Jm2NylnVTVIfGIeKW7Q1CXc8kPPNkWZKGqQ6MoWeTDN+jAM
         u2Dybq6Xdr1oghJSAxt/2RBf3XkhmwCSdKZuh6DGDh8XhyGoVk3FQrqp/6PoCIv5weuO
         PD1mxtYjsGeHgTVQYJk3Rcld+NVV6SY6H6Hg6kRv+SvOknye8SHOZSveDpoc92p1m4OC
         QWZw1sqOd5ppK/hMGjGSHPLowZpmCo2Vd0IazZLwQxaH3IE3jLa9MSoOH9A91pauiC10
         rc2kusC6vNjyYx06Va744Lews3kxxZkiTSM29kInghaUCaxCe0JGVE/DNBzrir9RV0j2
         xaOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N6vojmZkPJ0W/HM2G539IcIFG9CT0JLwxTEhHQdKtaY=;
        b=IBOhRvMcGFoj6qzBqRzjj6Q78cr5HtkW67wbdTbumYt0bcxhd9JfzBXm23Y+BavMK7
         717IV2pEnmXmU4XQx8/evOfeDtilFRPcUTsQV6Nsb4/Tx4thy5PFnI8ZAeR/QYZS2kk/
         XwRwi9MMs86HviRq0cUAVZFimgV/q8b+1GPlcBvdCuNI8p3k/VE7wJJO+0hyjIfNG4Fk
         lQNlQjJ974tKfVFjRSY6MMPU9zNB7QQJjLOSPTYxN1oBhbVq8vCi6O2dYiuZx5vUeCTl
         ZvDCdL1sV1NLVdrlv+ZEIv8uFopsgp4yuEOc6BonaWQAYfFO0pn77cqhMvk4XB+h8VXQ
         KBFg==
X-Gm-Message-State: AOAM533QBb68YL3EFceUSmm+MUVzAkYV0rP6sCcqEB+8bUD8NKMgV8tf
        9DyJUjabVSw7GwKZ5FHrqtntKQ==
X-Google-Smtp-Source: ABdhPJzm0j3Stuq4xPY8GX3G7xb61sxgZBcqIhiy5LHrxAjAX1VCvOlb9r5FvP0WCOuRJS4mdeFOIg==
X-Received: by 2002:a05:6402:1741:: with SMTP id v1mr10264129edx.127.1618583877582;
        Fri, 16 Apr 2021 07:37:57 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm1326523ejk.93.2021.04.16.07.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:37:57 -0700 (PDT)
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
Subject: [PATCH 26/40] drm/amd/amdgpu/amdgpu_device: Remove unused variable 'r'
Date:   Fri, 16 Apr 2021 15:37:11 +0100
Message-Id: <20210416143725.2769053-27-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210416143725.2769053-1-lee.jones@linaro.org>
References: <20210416143725.2769053-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c: In function ‘amdgpu_device_suspend’:
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:3733:6: warning: variable ‘r’ set but not used [-Wunused-but-set-variable]

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
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b4ad1c055c702..eef54b265ffdd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3730,7 +3730,6 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
 int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
-	int r;
 
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
@@ -3745,7 +3744,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 
 	amdgpu_ras_suspend(adev);
 
-	r = amdgpu_device_ip_suspend_phase1(adev);
+	amdgpu_device_ip_suspend_phase1(adev);
 
 	if (!adev->in_s0ix)
 		amdgpu_amdkfd_suspend(adev, adev->in_runpm);
@@ -3755,7 +3754,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 
 	amdgpu_fence_driver_suspend(adev);
 
-	r = amdgpu_device_ip_suspend_phase2(adev);
+	amdgpu_device_ip_suspend_phase2(adev);
 	/* evict remaining vram memory
 	 * This second call to evict vram is to evict the gart page table
 	 * using the CPU.
-- 
2.27.0

