Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2703B89BF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 22:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbhF3Uf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 16:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbhF3UfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 16:35:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DACBC061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 13:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=xTIvq7JeERaP44xmsJM3Rl+J9yNC0I1vFHCkU0Gk1ls=; b=ZAk/0tshkV3bIKnweqX8zlrT5B
        6qqMrqdo+EG92wpGBZ3aOmd0tq5oHvXAW/rirIH/pAD13jDZZ59nxGvdmcLJhmwuBW/lRqohfWlWa
        b2JwaCb4QlvURfGocqQ4ZuE9DFC/BM90pGzhPPMITeYjg6un4Z8c1BqvY9+CedgxxDLE7EsNTahxA
        cpEEud7AVAeOLakhN9Li2qCzJhCEHeCzPxWzWrUlF/H6GVwA/f66A4kySze/4gbBJm7h11aHzfQ10
        1Jq1I9ODqY+OSxW+gzVRC8ALYavtYjJyJ7YL8iToAsT6V1StyPRBKIJxxIDE0jcBcxxEQObGIHc5P
        RT4Wlv4Q==;
Received: from [2601:1c0:6280:3f0::aefb] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lygtB-00FDiE-NU; Wed, 30 Jun 2021 20:32:53 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "VMware Graphics" <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>, dri-devel@lists.freedesktop.org,
        Dave Airlie <airlied@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH -next] drm: vmwgfx: add header file for ttm_range_manager
Date:   Wed, 30 Jun 2021 13:32:52 -0700
Message-Id: <20210630203252.32471-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a header file for ttm_range_manager function prototypes to
eliminate build errors:

../drivers/gpu/drm/vmwgfx/vmwgfx_drv.c: In function ‘vmw_vram_manager_init’:
../drivers/gpu/drm/vmwgfx/vmwgfx_drv.c:678:8: error: implicit declaration of function ‘ttm_range_man_init’; did you mean ‘ttm_tt_mgr_init’? [-Werror=implicit-function-declaration]
  ret = ttm_range_man_init(&dev_priv->bdev, TTM_PL_VRAM, false,
../drivers/gpu/drm/vmwgfx/vmwgfx_drv.c: In function ‘vmw_vram_manager_fini’:
../drivers/gpu/drm/vmwgfx/vmwgfx_drv.c:690:2: error: implicit declaration of function ‘ttm_range_man_fini’; did you mean ‘ttm_pool_mgr_fini’? [-Werror=implicit-function-declaration]
  ttm_range_man_fini(&dev_priv->bdev, TTM_PL_VRAM);

Fixes: 9c3006a4cc1b ("drm/ttm: remove available_caching")
Fixes: a343160235f5 ("drm/vmwgfx/ttm: fix the non-THP cleanup path.")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "VMware Graphics" <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: Zack Rusin <zackr@vmware.com>
Cc: dri-devel@lists.freedesktop.org
Cc: Dave Airlie <airlied@redhat.com>
Cc: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20210630.orig/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ linux-next-20210630/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -37,6 +37,7 @@
 #include <drm/drm_sysfs.h>
 #include <drm/ttm/ttm_bo_driver.h>
 #include <drm/ttm/ttm_placement.h>
+#include <drm/ttm/ttm_range_manager.h>
 #include <generated/utsrelease.h>
 
 #include "ttm_object.h"
