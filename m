Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84875340115
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 09:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhCRIfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 04:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhCRIew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 04:34:52 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C5AC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 01:34:52 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id r12so2591918ejr.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 01:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qtec.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TGI8HIQlc4uaCPugxl2JDwGzxpy1JYs+5hYiFdwZIn4=;
        b=JHznz+RlAzfthyHdm4DXDxFzqBAGb+To7jbFrFPGg1J8RBHYexcZoqiGSSofvrjX2t
         nPHfdm613VsfXavQiZJYsxJkK9fzmAA2q9SwR/vJY9U3QGOXUiuFWtlsu5ySOonOrY9f
         vYg8B32bjUhCxH9JpXr/IfmJUUzZWXTRjEzyhgkE10BmFMVRvgdeFwysSJEzyMcEzVsx
         hiBzus8RSHx/T/7f+Mo/cY1cWKd+3MrMJzJaA1xJzc7ynrhLb50g1zE7NJkp+pF3EGQp
         785qiDE5otl8YdCjWvspELG7FamIPz1KwFQOPz+ADm6w6yHFrjFV+jnn+wJXzuAbn+hl
         f6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TGI8HIQlc4uaCPugxl2JDwGzxpy1JYs+5hYiFdwZIn4=;
        b=m5dzeDoeJbgRyIt6jaCZUK3q1BVgPqvI4Umau3NH7u1zBcj0Af97Qd8Gx0ejfKo+EX
         hrT6J65x3fpJEl6olOEH2oZT+UL2DLlJvnz1DQpFPdAnTFaRpZi/vgGaFF0TSwgm4n2Z
         X82tZkMVtE5MVhBRQjykofeOmHsVAJLU2pKRJp7qkK5jdmxJWoulA7PjijgjT+Mk2NrY
         Di8aK5+uSgzJ2eKYz5a0Wk1RAbuG5RUsnByaqZ631kKbVU298PfQoCi8gtg9OmcglUZi
         IZMedSTqJEywh56nOgyWNe6TpDMcHOGWRG4JEzZ5A1CfmUzaL6knW6KAXjFhEweiw9om
         Ra6w==
X-Gm-Message-State: AOAM5314zaANwY2E1pRtOsaOksyVQdUEjCdXXHAgsY2G+VDZlWt4TwAO
        +kGe+Fd2jwNlvEO5amVfqBcueA==
X-Google-Smtp-Source: ABdhPJybE5Kdxq92QLKVUG8Nhp0he0ishzyEmigHj7338liUP4XJbTsowAkqIM8U1qmXN+OPvVRe4Q==
X-Received: by 2002:a17:906:d71:: with SMTP id s17mr40870466ejh.126.1616056490945;
        Thu, 18 Mar 2021 01:34:50 -0700 (PDT)
Received: from localhost (cpe.ge-3-0-8-100.ryvnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id bt14sm1316462edb.92.2021.03.18.01.34.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 01:34:50 -0700 (PDT)
From:   Daniel Gomez <daniel@qtec.com>
Cc:     dagmcr@gmail.com, Daniel Gomez <daniel@qtec.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon/ttm: Fix memory leak userptr pages
Date:   Thu, 18 Mar 2021 09:32:36 +0100
Message-Id: <20210318083236.43578-1-daniel@qtec.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If userptr pages have been pinned but not bounded,
they remain uncleared.

Signed-off-by: Daniel Gomez <daniel@qtec.com>
---
 drivers/gpu/drm/radeon/radeon_ttm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index e8c66d10478f..bbcc6264d48f 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -485,13 +485,14 @@ static void radeon_ttm_backend_unbind(struct ttm_bo_device *bdev, struct ttm_tt
 	struct radeon_ttm_tt *gtt = (void *)ttm;
 	struct radeon_device *rdev = radeon_get_rdev(bdev);
 
+	if (gtt->userptr)
+		radeon_ttm_tt_unpin_userptr(bdev, ttm);
+
 	if (!gtt->bound)
 		return;
 
 	radeon_gart_unbind(rdev, gtt->offset, ttm->num_pages);
 
-	if (gtt->userptr)
-		radeon_ttm_tt_unpin_userptr(bdev, ttm);
 	gtt->bound = false;
 }
 
-- 
2.30.2

