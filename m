Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B953BEFD8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 20:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhGGSx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 14:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhGGSx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 14:53:56 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501DBC061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 11:51:15 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id u18so6610957lff.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 11:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JUWgrVFh2/qFHv+c7cx9WrsAZfLxb2SYVIzx1ikmyn4=;
        b=XttfrQzllZ5hfvz+r8DOgpYrpWtvyB5t0PHEX1Y2eNOFgk5dUY3OuvXI0CqDFd/pgI
         A+N9rMBzTUNYTkONuNy9MPqR+5kve6+bLqTDIaqBl7rsEvwwWqE6ExgQ8cBU3khvcl/e
         +/3nzatZ9yAdZ2XqcA9KwWC10g+fcc8ThxqtUVC7DNCMNKlhCaIg30MVE1dnpapPxHCL
         sTzVs/nE0VCBbZcpxwwveFhqivFSVMiy1OzhvYAGX7nApIOBMfoM6aRlb9loMSSy2cga
         b0n+QYDRmWy5/CqVjVUb+UlAoYhKUWSo+uqmXKIvCut32wSjXRQEgPg/Wl338+C1ChUn
         64aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JUWgrVFh2/qFHv+c7cx9WrsAZfLxb2SYVIzx1ikmyn4=;
        b=IyTDn+OWWLf1lU29m+k50T2vpjU5LvdkeDuiv9hwMcKEfSL7v5ZUljbvh26/KRUadC
         fU1XfX0a5rpDei5xFG+emR4wuczKm5vg6kjovITv2eHgfDHefuhZzXWsUrTliTaSFl1X
         K/47zHuTwlz17XPaeHEkqbdSDxu7uqv+0g95Ej1z0A1FCgGG2bs3WDml8hB2/eMR5NFs
         eSNjKFavKWgob74bLFeryGgDDfV6RqRs0PN+S8cMnf41PCbtutSMl5z5e83hzgemPNEt
         0WJbyaGIaV0+GF8YHY+LRzdBxpPo65BdwSB3KC9ceuOLIGmxbJGE6nqy+7pfuIZr/TZ1
         ld5g==
X-Gm-Message-State: AOAM533xzZlVJFoJ3c0WLKqnw/K7+0LNVf1d8L6VK5a5AiZv5iHnKA0u
        eZcEsQ0u1O1TgPKOsTZ4vMEUbwVfAoVZwQ==
X-Google-Smtp-Source: ABdhPJyY0sPA6voeOdJpmUyMRS+n1X52MH+w/yjUa9d9/HKQaGQd3HPJAjrNlVGOH8HfguGmgEMwfQ==
X-Received: by 2002:ac2:4191:: with SMTP id z17mr19370786lfh.457.1625683873605;
        Wed, 07 Jul 2021 11:51:13 -0700 (PDT)
Received: from localhost.localdomain ([94.103.225.155])
        by smtp.gmail.com with ESMTPSA id w21sm1919021lfu.80.2021.07.07.11.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 11:51:13 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     christian.koenig@amd.com, ray.huang@amd.com, airlied@linux.ie
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH] gpu: ttm: fix GPF in ttm_bo_release
Date:   Wed,  7 Jul 2021 21:51:08 +0300
Message-Id: <20210707185108.3798-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My local syzbot instance hit GPF in ttm_bo_release().
Unfortunately, syzbot didn't produce a reproducer for this, but I
found out possible scenario:

drm_gem_vram_create()            <-- drm_gem_vram_object kzalloced
				     (bo embedded in this object)
  ttm_bo_init()
    ttm_bo_init_reserved()
      ttm_resource_alloc()
        man->func->alloc()       <-- allocation failure
      ttm_bo_put()
	ttm_bo_release()
	  ttm_mem_io_free()      <-- bo->resource == NULL passed
				     as second argument
	     *GPF*

So, I've added check in ttm_bo_release() to avoid passing
NULL as second argument to ttm_mem_io_free().

Fail log:

KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
CPU: 1 PID: 10419 Comm: syz-executor.3 Not tainted 5.13.0-rc7-next-20210625 #7
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
RIP: 0010:ttm_mem_io_free+0x28/0x170 drivers/gpu/drm/ttm/ttm_bo_util.c:66
Code: b1 90 41 56 41 55 41 54 55 48 89 fd 53 48 89 f3 e8 cd 19 24 fd 4c 8d 6b 20 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 <80> 3c 02 00 0f 85 2a 01 00 00 4c 8b 63 20 31 ff 4c 89 e6 e8 00 1f
RSP: 0018:ffffc900141df968 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc90010da0000
RDX: 0000000000000004 RSI: ffffffff84513ea3 RDI: ffff888041fbc010
RBP: ffff888041fbc010 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000020 R14: ffff88806b258800 R15: ffff88806b258a38
FS:  00007fa6e9845640(0000) GS:ffff88807ec00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fad61265e18 CR3: 000000005ad79000 CR4: 0000000000350ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 ttm_bo_release+0xd94/0x10a0 drivers/gpu/drm/ttm/ttm_bo.c:422
 kref_put include/linux/kref.h:65 [inline]
 ttm_bo_put drivers/gpu/drm/ttm/ttm_bo.c:470 [inline]
 ttm_bo_init_reserved+0x7cb/0x960 drivers/gpu/drm/ttm/ttm_bo.c:1050
 ttm_bo_init+0x105/0x270 drivers/gpu/drm/ttm/ttm_bo.c:1074
 drm_gem_vram_create+0x332/0x4c0 drivers/gpu/drm/drm_gem_vram_helper.c:228

Fixes: d3116756a710 ("drm/ttm: rename bo->mem and make it a pointer")
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 1b950b45cf4b..15eb97459eab 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -419,7 +419,8 @@ static void ttm_bo_release(struct kref *kref)
 			bo->bdev->funcs->release_notify(bo);
 
 		drm_vma_offset_remove(bdev->vma_manager, &bo->base.vma_node);
-		ttm_mem_io_free(bdev, bo->resource);
+		if (bo->resource)
+			ttm_mem_io_free(bdev, bo->resource);
 	}
 
 	if (!dma_resv_test_signaled(bo->base.resv, true) ||
-- 
2.32.0

