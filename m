Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267A8342F76
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 21:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhCTULN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 16:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhCTUK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 16:10:58 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A201C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 13:10:58 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id g8so6818966qvx.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 13:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vk92B5101C0kSYxKtRdztG8qIATiTlmHbCiHUucp3As=;
        b=Fnfw2M9RhXcyiQzRjIyfVfnODuAjYcEbD3nWIZnkJmiyAcD9O8OdGEY3thX4LrGr+x
         76AhTu+XdFF2CQh76gziI3ZpzZzHRq2WNeEJ7O7MtFHaqRk8syZPpeQ+YNO3JMHsg7QD
         4Z+otCOKfVCt89vDCo1wfl9W/Hf6caKTfZOaPviyOF9tRlDPdt1Cjm+v6W7s9IMzV+yy
         fAKRgHse3hVQyhKsAgtl/M08guvjnrOCsB4ZIN5ZlAnPGw0CFJOJcc6I9RqO8/442RY2
         bSif9mguJU99QHzehNs4VpCwdOp1Fmuqs5jdYERmh07yUPyX2Of+eT8BANHfN8Sz01vG
         VzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vk92B5101C0kSYxKtRdztG8qIATiTlmHbCiHUucp3As=;
        b=rVQjZFmzFsfUftr6dG6a1OA1XU0oh0aQYv/1G0C3pTNAx5wey95W0QcnCWo4bXAWbF
         RsOyrkOhfPXKu/tmI+o/Qt8NP+bx27ZopxhSKAn7A3/qWmNRTSoRfJ36mMnePNd6Sy1x
         nGX+Vzun585Tzj4Dvg6ksbtDNQOVRkh25Cec2e3wfLzpWlMQ4+5Bn14NoiBc2IeTJGgU
         471nFOkCctTB3V+mCgDqq/sz+rCPrO5M736eVNNX41kFuMg2CjUL/4j1WiMXayg/Kl0L
         SYRrAcHdslA6o3aHoKA7S7FfXLxGi4fKCCYzfTdPojStU7wfR/q3RQrvvcP632oCo54k
         GErw==
X-Gm-Message-State: AOAM533TM45HODh/lDzPBzf1YjlfL8LJad2qf6sr5Zu5P8jCcbZERDaw
        lkk6bIjfg11M+i6CL9Blb+M=
X-Google-Smtp-Source: ABdhPJxtAXJH33gyeSSRkTb5jiBIK+W4Zj+npCFjzqCmqg9i+lBQjgHS2zHOrORVUGq+NT3Ucgzejg==
X-Received: by 2002:ad4:584a:: with SMTP id de10mr14886331qvb.50.1616271057303;
        Sat, 20 Mar 2021 13:10:57 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c200:27c6:f925:bb4b:54d2:533])
        by smtp.googlemail.com with ESMTPSA id h7sm7018999qkk.41.2021.03.20.13.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 13:10:57 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Tong Zhang <ztong0001@gmail.com>
Subject: [PATCH] drm/radeon: don't evict if not initialized
Date:   Sat, 20 Mar 2021 16:10:52 -0400
Message-Id: <20210320201052.114775-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TTM_PL_VRAM may not initialized at all when calling
radeon_bo_evict_vram(). We need to check before doing eviction.

[    2.160837] BUG: kernel NULL pointer dereference, address: 0000000000000020
[    2.161212] #PF: supervisor read access in kernel mode
[    2.161490] #PF: error_code(0x0000) - not-present page
[    2.161767] PGD 0 P4D 0
[    2.163088] RIP: 0010:ttm_resource_manager_evict_all+0x70/0x1c0 [ttm]
[    2.168506] Call Trace:
[    2.168641]  radeon_bo_evict_vram+0x1c/0x20 [radeon]
[    2.168936]  radeon_device_fini+0x28/0xf9 [radeon]
[    2.169224]  radeon_driver_unload_kms+0x44/0xa0 [radeon]
[    2.169534]  radeon_driver_load_kms+0x174/0x210 [radeon]
[    2.169843]  drm_dev_register+0xd9/0x1c0 [drm]
[    2.170104]  radeon_pci_probe+0x117/0x1a0 [radeon]

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_object.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_object.c b/drivers/gpu/drm/radeon/radeon_object.c
index 9b81786782de..04e9a8118b0e 100644
--- a/drivers/gpu/drm/radeon/radeon_object.c
+++ b/drivers/gpu/drm/radeon/radeon_object.c
@@ -384,7 +384,9 @@ int radeon_bo_evict_vram(struct radeon_device *rdev)
 	}
 #endif
 	man = ttm_manager_type(bdev, TTM_PL_VRAM);
-	return ttm_resource_manager_evict_all(bdev, man);
+	if (man)
+		return ttm_resource_manager_evict_all(bdev, man);
+	return 0;
 }
 
 void radeon_bo_force_delete(struct radeon_device *rdev)
-- 
2.25.1

