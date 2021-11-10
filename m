Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90EEF44C908
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 20:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbhKJTjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 14:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhKJTjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 14:39:25 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC1DC061764;
        Wed, 10 Nov 2021 11:36:37 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id u18so5891826wrg.5;
        Wed, 10 Nov 2021 11:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Z8SMunWQcnk6H7z0v7bcp6qKVk9GWG+Oiz8OpqEszI=;
        b=oXIysTlNVbQRqVPcfuFaK+8pnGVtAvR/go8VDsPZbXbW5IRK582fEcwaxvWkrVUkts
         6CvO/a6K4cVEdcVhI+g3uCdJEWfbM1jjpH3wn55zbMO85O1CaLALThPknDVyX6E/JYP8
         +wDF9Z00irYxSgWcn0u5TTF//8gXbJLRv98DwMozzFwWUA9ZEHeZfo02lG9sYfTETJuA
         QeG1Xi0dt8qbLwiFGl5x42+vjdhw9xt5Z7HDi9dzNhL83GQz/dg+um6DyVVPvNzlBgU/
         CDJBufGmQrvh9auLzKZSXbU+qLVofPHj3Vpq0iyoUekogBz89p7xWmFEnFIwQ7//eadF
         xh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Z8SMunWQcnk6H7z0v7bcp6qKVk9GWG+Oiz8OpqEszI=;
        b=epre1jDr1rUcaMrNfo6HU+I5dn9FHJ5yfO7QLpb7+oq31xXzq/uTs0hentr30VmVYn
         RF96O2FF0EWpiAGF0/ADdhdgyEYKlKiuYwJPIGJK1PCKMMsEXw9797jrGcStDQELy3wx
         oiMhkERbZdYoikFviv+wIBb8zCc076VNG9WFmiBF3zFy329O6PYT1OIdlgttqE90QPyN
         WHuK2i0TfH4FvWtQfOh7IZV/udw5vaCuLxYNj2pk5sD4hnVuDr+MTfMbROBBaeNFsJzU
         huHPQx2r9HH3IX9UD+8HF0oTb44pHkhZieS2ouTz6bv3KJ/iUoK04HVWX320wDYQsihC
         Yw9A==
X-Gm-Message-State: AOAM532vp1wI0QDXkaXsKSWWt8AEL9tLaUbqoHd3sEMv9ZRPEH61ZocY
        ZvuSgPrKJ1dqXQ==
X-Google-Smtp-Source: ABdhPJyEPqNej1qS/wX6Ss4Bd6tM6SnB5Dz2gtv4liSwPZVQZWxIX1ItETpYJTswugwKLMv+oNRcZA==
X-Received: by 2002:a5d:534b:: with SMTP id t11mr1807334wrv.75.1636572996346;
        Wed, 10 Nov 2021 11:36:36 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id h204sm650777wmh.33.2021.11.10.11.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 11:36:36 -0800 (PST)
From:   Colin Ian King <colin.i.king@googlemail.com>
X-Google-Original-From: Colin Ian King <colin.i.king@gmail.com>
To:     Emma Anholt <emma@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Melissa Wen <mwen@igalia.com>,
        Iago Toral Quiroga <itoral@igalia.com>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/v3d: pass null pointers using NULL
Date:   Wed, 10 Nov 2021 19:36:35 +0000
Message-Id: <20211110193635.312328-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a couple of calls that are passing null pointers as
integer zeros rather than NULL. Fix this by using NULL instead.

Fixes: 07c2a41658c4 ("drm/v3d: alloc and init job in one shot")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/v3d/v3d_gem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index e47ae40a865a..c7ed2e1cbab6 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -774,7 +774,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 
 	if (args->flags & DRM_V3D_SUBMIT_CL_FLUSH_CACHE) {
 		ret = v3d_job_init(v3d, file_priv, (void *)&clean_job, sizeof(*clean_job),
-				   v3d_job_free, 0, 0, V3D_CACHE_CLEAN);
+				   v3d_job_free, 0, NULL, V3D_CACHE_CLEAN);
 		if (ret)
 			goto fail;
 
@@ -1007,7 +1007,7 @@ v3d_submit_csd_ioctl(struct drm_device *dev, void *data,
 		goto fail;
 
 	ret = v3d_job_init(v3d, file_priv, (void *)&clean_job, sizeof(*clean_job),
-			   v3d_job_free, 0, 0, V3D_CACHE_CLEAN);
+			   v3d_job_free, 0, NULL, V3D_CACHE_CLEAN);
 	if (ret)
 		goto fail;
 
-- 
2.32.0

