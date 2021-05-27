Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18513938E7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 01:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbhE0XFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 19:05:24 -0400
Received: from aposti.net ([89.234.176.197]:60766 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236461AbhE0XFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 19:05:23 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     list@opendingux.net, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH] drm: Fix for GEM buffers with write-combine memory
Date:   Fri, 28 May 2021 00:03:34 +0100
Message-Id: <20210527230334.151947-1-paul@crapouillou.net>
In-Reply-To: <26b5424a-ff4c-090b-a08f-0e3e32278180@ideasonboard.com>
References: <26b5424a-ff4c-090b-a08f-0e3e32278180@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous commit wrongly assumed that dma_mmap_wc() could be replaced
by pgprot_writecombine() + dma_mmap_pages(). It did work on my setup,
but did not work everywhere.

Use dma_mmap_wc() when the buffer has the write-combine cache attribute,
and dma_mmap_pages() when it has the non-coherent cache attribute.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reported-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Fixes: cf8ccbc72d61 ("drm: Add support for GEM buffers backed by non-coherent memory")
---
 drivers/gpu/drm/drm_gem_cma_helper.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_cma_helper.c b/drivers/gpu/drm/drm_gem_cma_helper.c
index 235c7a63da2b..4c3772651954 100644
--- a/drivers/gpu/drm/drm_gem_cma_helper.c
+++ b/drivers/gpu/drm/drm_gem_cma_helper.c
@@ -514,13 +514,17 @@ int drm_gem_cma_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
 
 	cma_obj = to_drm_gem_cma_obj(obj);
 
-	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
-	if (!cma_obj->map_noncoherent)
-		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+	if (cma_obj->map_noncoherent) {
+		vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
+
+		ret = dma_mmap_pages(cma_obj->base.dev->dev,
+				     vma, vma->vm_end - vma->vm_start,
+				     virt_to_page(cma_obj->vaddr));
+	} else {
+		ret = dma_mmap_wc(cma_obj->base.dev->dev, vma, cma_obj->vaddr,
+				  cma_obj->paddr, vma->vm_end - vma->vm_start);
 
-	ret = dma_mmap_pages(cma_obj->base.dev->dev,
-			     vma, vma->vm_end - vma->vm_start,
-			     virt_to_page(cma_obj->vaddr));
+	}
 	if (ret)
 		drm_gem_vm_close(vma);
 
-- 
2.30.2

