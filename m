Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF19637AC07
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 18:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhEKQgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 12:36:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45730 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230315AbhEKQgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 12:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620750900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=97DZTbnMB7JhbF5GRtnL6nwi+qxo43t3jJzfVOcjguQ=;
        b=AXepeEjFIl+mnMjruPLBsvl9wUhwAWUMXBJ9SUNCA37EO1v1gNPYtj0cRRxXrTSxlL5Zp/
        ykYZCj3/6IAv/rnQwGLrMXI+/cMUz9nTPtALy+Q8RVX71RNM9Tae7kO49LXC2GqJ6EetCb
        0TOX82KWy2v2kQiJyPJIt7q58LUxfdQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-or00ETLUOm6bqVr2w7mPRw-1; Tue, 11 May 2021 12:34:57 -0400
X-MC-Unique: or00ETLUOm6bqVr2w7mPRw-1
Received: by mail-wm1-f72.google.com with SMTP id g206-20020a1c39d70000b029016ac627fbe9so288714wma.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 09:34:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=97DZTbnMB7JhbF5GRtnL6nwi+qxo43t3jJzfVOcjguQ=;
        b=Dl/iVEKuQpx+CYzOJ59qTy+QEmKZR/P4pKHpPiW3dnm0xSb4XPQ9AxKc0JPCUREOYW
         Y+Y+NJ7o/KgHY+xkQ4Ikx5eldwMIjOUKMhZy637QkqBczoYGKp7UQm1NjpGOV6K43PVQ
         9n1mXYdGERfIZoOnPnuWTKjUuMkD+GqhoMkqJ86fHYI0824opc8zi6cr0KBqBzCo+JmD
         YisO0OncAcA2MlPFHpuIilE5guuyexisJI1nRRtChIAxY5A/NfKrAb08f2BRtyAg4pE/
         NWFaV3kKFIre4fpYmRxcEpN3A/IvEKIzyQL+WzBAZ/YR0Nd/vFjzGNgCnvQreDHGQmHu
         9LIA==
X-Gm-Message-State: AOAM530Ei1NhfeX+AiDd4WtAVwQ6U2hsaNe3vfidqCgk9vBMIE/26qh6
        cinWlU4k71kVElr/FR9tjFT0+B2zh+9mNXcRXjLG6gSESzWezNWFQxPsk8mcUn7sVDGDFAYW3yn
        fsPAM3mrcbwHMcnQdjWGgOqlZUJ5E5svvvsppfFJMpkIvLjOkuoVLFKuHd5b87AJjtm9vajiJki
        g=
X-Received: by 2002:a7b:cc83:: with SMTP id p3mr33259295wma.170.1620750895894;
        Tue, 11 May 2021 09:34:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnEBfeLiol6XPcV18JsNDNOCqwp441fcQ0OfKOHrAZhpv3a4iIbrRHT4ebCZ/BbQ8X+o2FyQ==
X-Received: by 2002:a7b:cc83:: with SMTP id p3mr33259263wma.170.1620750895602;
        Tue, 11 May 2021 09:34:55 -0700 (PDT)
Received: from kherbst.pingu.com (ip1f10bb48.dynamic.kabel-deutschland.de. [31.16.187.72])
        by smtp.gmail.com with ESMTPSA id m185sm3484191wme.38.2021.05.11.09.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 09:34:55 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Karol Herbst <kherbst@redhat.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH] nouveau/gem: fix user-after-free in nouveau_gem_new
Date:   Tue, 11 May 2021 18:34:53 +0200
Message-Id: <20210511163453.2343304-1-kherbst@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If ttm_bo_init fails it will already call ttm_bo_put, so we don't have to
do it through nouveau_bo_ref.

==================================================================
BUG: KFENCE: use-after-free write in ttm_bo_put+0x11/0x40 [ttm]

Use-after-free write at 0x000000004dc4663c (in kfence-#44):
 ttm_bo_put+0x11/0x40 [ttm]
 nouveau_gem_new+0xc1/0xf0 [nouveau]
 nouveau_gem_ioctl_new+0x53/0xf0 [nouveau]
 drm_ioctl_kernel+0xb2/0x100 [drm]
 drm_ioctl+0x215/0x390 [drm]
 nouveau_drm_ioctl+0x55/0xa0 [nouveau]
 __x64_sys_ioctl+0x83/0xb0
 do_syscall_64+0x33/0x40
 entry_SYSCALL_64_after_hwframe+0x44/0xae

kfence-#44 [0x00000000c0593b31-0x000000002e74122b, size=792, cache=kmalloc-1k] allocated by task 2657:
 nouveau_bo_alloc+0x63/0x4c0 [nouveau]
 nouveau_gem_new+0x38/0xf0 [nouveau]
 nouveau_gem_ioctl_new+0x53/0xf0 [nouveau]
 drm_ioctl_kernel+0xb2/0x100 [drm]
 drm_ioctl+0x215/0x390 [drm]
 nouveau_drm_ioctl+0x55/0xa0 [nouveau]
 __x64_sys_ioctl+0x83/0xb0
 do_syscall_64+0x33/0x40
 entry_SYSCALL_64_after_hwframe+0x44/0xae

freed by task 2657:
 ttm_bo_release+0x1cc/0x300 [ttm]
 ttm_bo_init_reserved+0x2ec/0x300 [ttm]
 ttm_bo_init+0x5e/0xd0 [ttm]
 nouveau_bo_init+0xaf/0xc0 [nouveau]
 nouveau_gem_new+0x7f/0xf0 [nouveau]
 nouveau_gem_ioctl_new+0x53/0xf0 [nouveau]
 drm_ioctl_kernel+0xb2/0x100 [drm]
 drm_ioctl+0x215/0x390 [drm]
 nouveau_drm_ioctl+0x55/0xa0 [nouveau]
 __x64_sys_ioctl+0x83/0xb0
 do_syscall_64+0x33/0x40
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Fixes: 019cbd4a4feb3 "drm/nouveau: Initialize GEM object before TTM object"
Cc: Thierry Reding <treding@nvidia.com>
Signed-off-by: Karol Herbst <kherbst@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_gem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
index c88cbb85f101..1165ff990fb5 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -212,7 +212,6 @@ nouveau_gem_new(struct nouveau_cli *cli, u64 size, int align, uint32_t domain,
 
 	ret = nouveau_bo_init(nvbo, size, align, domain, NULL, NULL);
 	if (ret) {
-		nouveau_bo_ref(NULL, &nvbo);
 		return ret;
 	}
 
-- 
2.31.1

