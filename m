Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B85D3622F0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245218AbhDPOkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244432AbhDPOib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:38:31 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDAAC061344
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:38:06 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id w3so42521943ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I8mWOth0SK24IkrgdA5t1Y60F5TC0397g52f7X8Rsig=;
        b=YgMDFePlDrbu+lfm/PqgYEnXq98IKmEE0loDCtjkfHsTCMpAqMSDSjSYx714+3DxwP
         sqWegEyqCp6hLKtv9sHQ3EY82v4t8frAeIWli699zbPAb40ZEiBEaw4QPxu4w63nO9cB
         KHuWXBQLE38YoaknaLtK242G6dcoG3qqnb4sXYX5R1NGPq/CEXHvxiHxdnLKTkhav9VT
         d5PwX9lVNlJCGvNS/uKWUMm0C3PLBjQW4xtOybaxuBcKZOVkTF1eiTg3+dod3uTSasqB
         6BDP78jpXknUPSDKOij9kcO1wkGkQeV+VEcLB6h7VbZ6fQUxzDiymRrTsnO2qA7yYH1c
         CIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I8mWOth0SK24IkrgdA5t1Y60F5TC0397g52f7X8Rsig=;
        b=ogaXSoYOWAjuTfOyvr/wgsXXONgjrEFYTcqcY+e5bQueDFuwCjJ1Zb+Hn4wzOWeI0q
         +WxbNdKazGaN4aQAkMRdXa9Q+bm+2WUWk/J/aRTJ87gHrE+wkhCykJ2TB7h8FQ0j+W4E
         YO4c9gmq1qVjmZQpdvCs8TMJjSo3pBccoTT51XscaAcS234wY6D+gruPgjUw3ZIBsCl2
         DEXLhCs+WJM+r9G68i6rsFvKd50g9yxS6z+ozP86KUBHj3IEsttSWeXYqgGjz5WLx3Ga
         uy4Q8K6KAYeCgb1bLwQIgpO5OvxFh7iZzistWzN+nHeSpXXi6Te4GL9euPXP07u7h82q
         E5pA==
X-Gm-Message-State: AOAM530Umc76Kya+5q/2EUwpra/KMPTeIOUHLqMHe+TfOg8TGh+Yz2M+
        XvXFfjJeJKLkYSNAz3eRKxc+hw==
X-Google-Smtp-Source: ABdhPJwB+j4w26WCbdC8MZ2fDdqzcj3geypeOzbRKQYNfP0KVkmEKSezvqx2DhR7+h5BUh8BM1TP8A==
X-Received: by 2002:a17:907:9691:: with SMTP id hd17mr8782424ejc.205.1618583884824;
        Fri, 16 Apr 2021 07:38:04 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm1326523ejk.93.2021.04.16.07.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:38:04 -0700 (PDT)
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
Subject: [PATCH 33/40] drm/amd/amdgpu/amdgpu_ring: Provide description for 'sched_score'
Date:   Fri, 16 Apr 2021 15:37:18 +0100
Message-Id: <20210416143725.2769053-34-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:169: warning: Function parameter or member 'sched_score' not described in 'amdgpu_ring_init'

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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 688624ebe4211..7b634a1517f9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -158,6 +158,7 @@ void amdgpu_ring_undo(struct amdgpu_ring *ring)
  * @irq_src: interrupt source to use for this ring
  * @irq_type: interrupt type to use for this ring
  * @hw_prio: ring priority (NORMAL/HIGH)
+ * @sched_score: optional score atomic shared with other schedulers
  *
  * Initialize the driver information for the selected ring (all asics).
  * Returns 0 on success, error on failure.
-- 
2.27.0

