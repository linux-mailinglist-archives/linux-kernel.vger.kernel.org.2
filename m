Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7635333F51E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 17:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbhCQQJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 12:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbhCQQJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 12:09:12 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C604C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 09:09:11 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id h13so2938132eds.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 09:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qtec.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LASiUJZzM9SBb9BxKINWFm41CPO6shbrsdTJEhF0yaI=;
        b=AcdBsvvDD2mwFdfxN/x9OEPZ9qMAuRMrKpdDV1i4T21fK6CjXwy9q2ec5vuUyhqSVU
         YxhQhmA2y8qF98lT8KeMsaGZPfVofrohBN4qyucfteUQI0I61JRe1UVjhPHK1PeaFQMA
         ucoRKbeWZNzY2G9CoetUJPJeJzegqAsY6/rh2iY23vl6MTgxFjhNGCIpBJhmp6a+qQlz
         CGLbNnuYh9DsXSx7OCVwbOiraQT/36gokUTMi3A0zCOo1FIhnkrJL5OyaKUTHFIl0Its
         nyBFM+XbIHW6ggbvMmmx1j9dHPQ8meFDMtsPe3h+6BxVenrUVbC/mPFole2mcp4CFu7A
         0YLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LASiUJZzM9SBb9BxKINWFm41CPO6shbrsdTJEhF0yaI=;
        b=m7KohO9jb6dEK9Yq+xy2aBmw63bqUYibi6f5L48dJRUQnxkq9xQV3eIXRg4AMYLaOV
         QwRwPZHBHrdMNr+0YuPrQrs3maFQaMtOfC89FWc1drfTENJUiePsE7oNiOK0VNMfjemn
         0u9w7DeJn6eoYmlWd5elTqkcyzVD1I+iO5wkX1JJQ/J/zgCId+/vUKKA+uAXzzK2luFG
         oHSL/jpuMRPOIwTC6KiwL7z6hBpNHBRiiUTwAsQt9yNGs5a4LdPIa+LjiaGh7LOs5ESC
         y8UDgijX0l6H/fqzkn64EELQaAlIEofu1p2ls+lTsZoYUvAkmOX94hLj5CNZdsxYKB21
         f2vQ==
X-Gm-Message-State: AOAM5305ulp4/NLEIGve/e9RZNRno5XgSH+egV6UkPI9dnPum53kD9tU
        aRlD0rjx6sdtW/Fx27j2epHXkg==
X-Google-Smtp-Source: ABdhPJw8pAC+ltODr7pfOGR0W+UPfJGOqgti1MYP3D5tSM/qw4/LpsgROfHRX/6VU5kN534YcFcn7Q==
X-Received: by 2002:a05:6402:22b5:: with SMTP id cx21mr43085461edb.27.1615997349970;
        Wed, 17 Mar 2021 09:09:09 -0700 (PDT)
Received: from localhost (cpe.ge-3-0-8-100.ryvnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id q11sm11728843ejr.36.2021.03.17.09.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 09:09:09 -0700 (PDT)
From:   Daniel Gomez <daniel@qtec.com>
Cc:     dagmcr@gmail.com, Daniel Gomez <daniel@qtec.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Likun Gao <Likun.Gao@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu/ttm: Fix memory leak userptr pages
Date:   Wed, 17 Mar 2021 17:08:37 +0100
Message-Id: <20210317160840.36019-1-daniel@qtec.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 9fd2157b133a..50c2b4827c13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1162,13 +1162,13 @@ static void amdgpu_ttm_backend_unbind(struct ttm_bo_device *bdev,
 	struct amdgpu_ttm_tt *gtt = (void *)ttm;
 	int r;
 
-	if (!gtt->bound)
-		return;
-
 	/* if the pages have userptr pinning then clear that first */
 	if (gtt->userptr)
 		amdgpu_ttm_tt_unpin_userptr(bdev, ttm);
 
+	if (!gtt->bound)
+		return;
+
 	if (gtt->offset == AMDGPU_BO_INVALID_OFFSET)
 		return;
 
-- 
2.30.2

