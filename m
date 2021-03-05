Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA29332E052
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 04:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbhCEDyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 22:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhCEDyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 22:54:43 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560E5C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 19:54:43 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id ba1so716783plb.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 19:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NAXf8RMnJpADBoaOf4LNGzMlYrRlmVtLwiw8GRRuOZU=;
        b=pIW0aBMY2TlkhvRip0uhHih55G5srjANFX17kViGM/RnSdxQvkzO6ZSljohzCwH5Zr
         c9YB45hISibqfNFvojTbHLX1HTT1g5lErjVwENvoMqXYKValn6vh0apJYur5RWOG5s1d
         aNMXTpmcGotESELfZzJwxm4MKgEYpCy1b6vdd4Hj9yhsW2+Nx1ZupczssrvXW3KUkqpZ
         tiUnPolHwO7+bQAcjr+/sRvlxvWz28sk1BTpXnMzMQC2wK96zZu6EQNORbQ7wYsfIu36
         tw9i+CNpyXrW4kOGBVzxWIsMAKbFvvZY5IpaOroinLQ+LqTUAtWNQ7uPRa2JpBRCkJWt
         Nx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NAXf8RMnJpADBoaOf4LNGzMlYrRlmVtLwiw8GRRuOZU=;
        b=PNUDskjWDGYL7Q+84C5ikZHW4uHpxopgG316EIDbN3dj4IOgvTsrtA/OfYjZuogZcw
         5ideBJmfuli/xr8chcjkUTpcP0O1OCIObamhjG/9UpER7QKiMg1VFaSsOQbuRycpMHnG
         /lJJ0bhJhX3/Nn62NK9qf6ybyk2ceauQJbxpgvTDDIU67+AH7CNsGog6ZwAtT3CzoBR3
         BjSCMEfogO/1TqtbWlVWLiCf80kAj6VClEtxW4KUEGH0VJNQtOuU5rDT/AuKw44xrEE7
         w5K/4xXDhcx1eEsy8clmhF1Nx5IhkijvkpDuX5TyNLPAyNoGq7fuggAlW+hLAgPejsMr
         vQvg==
X-Gm-Message-State: AOAM532PCpG6JWoQwOEFiDX4+LC3vr2vi6tWH3V3JH+m7iawCyfd0HQW
        S9yokrhiKFfTOup05XxNamE=
X-Google-Smtp-Source: ABdhPJxFhc5WEZjHgDo3N8QWr8dMIKAfsosSITeeqCXpCs9fHejy0sOsY0exXfysxg4kvuI35YrD5Q==
X-Received: by 2002:a17:90a:5901:: with SMTP id k1mr8030028pji.213.1614916482952;
        Thu, 04 Mar 2021 19:54:42 -0800 (PST)
Received: from localhost.localdomain ([45.135.186.129])
        by smtp.gmail.com with ESMTPSA id w4sm589207pjk.55.2021.03.04.19.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 19:54:42 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, evan.quan@amd.com,
        Hawking.Zhang@amd.com, kevin1.wang@amd.com, Likun.Gao@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] gpu: drm: swsmu: fix error return code of smu_v11_0_set_allowed_mask()
Date:   Thu,  4 Mar 2021 19:54:28 -0800
Message-Id: <20210305035428.6750-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When bitmap_empty() or feature->feature_num triggers an error, 
no error return code of smu_v11_0_set_allowed_mask() is assigned.
To fix this bug, ret is assigned with -EINVAL as error return code.

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 90585461a56e..82731a932308 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -747,8 +747,10 @@ int smu_v11_0_set_allowed_mask(struct smu_context *smu)
 	int ret = 0;
 	uint32_t feature_mask[2];
 
-	if (bitmap_empty(feature->allowed, SMU_FEATURE_MAX) || feature->feature_num < 64)
+	if (bitmap_empty(feature->allowed, SMU_FEATURE_MAX) || feature->feature_num < 64) {
+		ret = -EINVAL;
 		goto failed;
+	}
 
 	bitmap_copy((unsigned long *)feature_mask, feature->allowed, 64);
 
-- 
2.17.1

