Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C56343325
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 16:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhCUPTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 11:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhCUPTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 11:19:30 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1EEC061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 08:19:29 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id l13so10523416qtu.9
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 08:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=au6yAq/994byN5B0Bwhkok5fWOyRbkNX7zhhajSq4Aw=;
        b=ns/uAHPvUjy2iZEKZoWbTS1sMcHu1FX5sa2+Z8yxjXxcwinwoh1oyHO4mBzFoz+fpP
         t9AdkaaVSj7Eu1xya6LHJaVIUcqswAx5v08y5I3BTb63tMUuXPyS3K84hMb0T+/eeKmc
         KaILdnSQt58/asDO3bjCrWZKNH5Mzbq3fDfqxwI+NkV3hn8wE3dPl0S/DJMWPcbTe4Tu
         uD5keox3ZMAS2sxZHl/Up9oKtEb10DorYYXPFnzVIjrNqccO+E1qLWfQKSBbfZdjt6Ap
         Ub4nMpKgmMjAYI1tXWC60AfBnDUUfg36l+ZcbzeesjUYFx4iHaOJjHSQ7KrEw/wRAW0h
         7RGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=au6yAq/994byN5B0Bwhkok5fWOyRbkNX7zhhajSq4Aw=;
        b=hWZnQazKWn+M7O1c0Y54ntMhsytEh34VCduXJmcoIEaj5lu/M3X9ZmrYvJIihgxPVh
         ysxtiaix/L7Z5MAdQ0Z6SKWy/LV27ynp5+JF+pWlw9Brj9Z2hsT+l/2ZUwWxhoTgCuyI
         6u81nhZcQRMnO7BG3np8XYhiaxtza8y492f8IJ09Rc3Jl1mEjtUWc8365TYYPs1Ts7UR
         vWKwPQ8X0+4HSALfq4gw8eLPGJ6Ie9849+y6jGdgIXY2PIXsjv6YQukG/6PnzZmohej3
         4sIfe/TwBN3SU6y+vFtR5k4v3LCmjuo5cIxWcQRquTCWtF4rgwzJazvSZqCHH/0Yz+03
         B4/A==
X-Gm-Message-State: AOAM533W7nbWDFeZTGVJIHoW8aHTn/Q/6V6lkhrJHHRqZD+itxrDf0mZ
        rPhTDCrewO4A3KtGTItX01w=
X-Google-Smtp-Source: ABdhPJwXT1ZITQY67+/yUvJVHD5s+98+2llrDVCVzJ7MdJbYm/lFiBOlr2ncZVUhSRoWxxr7oUHCsA==
X-Received: by 2002:ac8:1094:: with SMTP id a20mr6296117qtj.248.1616339967589;
        Sun, 21 Mar 2021 08:19:27 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c200:27c6:f925:bb4b:54d2:533])
        by smtp.googlemail.com with ESMTPSA id 84sm9302704qkg.8.2021.03.21.08.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 08:19:26 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Tong Zhang <ztong0001@gmail.com>
Subject: [PATCH v2] drm/radeon: don't evict if not initialized
Date:   Sun, 21 Mar 2021 11:19:07 -0400
Message-Id: <20210321151907.367586-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
v2: coding style fix

 drivers/gpu/drm/radeon/radeon_object.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_object.c b/drivers/gpu/drm/radeon/radeon_object.c
index 9b81786782de..499ce55e34cc 100644
--- a/drivers/gpu/drm/radeon/radeon_object.c
+++ b/drivers/gpu/drm/radeon/radeon_object.c
@@ -384,6 +384,8 @@ int radeon_bo_evict_vram(struct radeon_device *rdev)
 	}
 #endif
 	man = ttm_manager_type(bdev, TTM_PL_VRAM);
+	if (!man)
+		return 0;
 	return ttm_resource_manager_evict_all(bdev, man);
 }
 
-- 
2.25.1

