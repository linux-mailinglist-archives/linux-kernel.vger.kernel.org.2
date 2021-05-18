Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1B338769D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 12:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348545AbhERKgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 06:36:25 -0400
Received: from vps5.brixit.nl ([192.81.221.234]:35656 "EHLO vps5.brixit.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347935AbhERKgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 06:36:23 -0400
X-Greylist: delayed 454 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 May 2021 06:36:23 EDT
Received: from localhost.localdomain (unknown [77.239.252.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by vps5.brixit.nl (Postfix) with ESMTPSA id 1A3F56075F;
        Tue, 18 May 2021 10:27:28 +0000 (UTC)
From:   Alexey Minnekhanov <alexeymin@postmarketos.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU),
        freedreno@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Alexey Minnekhanov <alexeymin@postmarketos.org>
Subject: [PATCH] drm/msm: Init mm_list before accessing it for use_vram path
Date:   Tue, 18 May 2021 13:26:24 +0300
Message-Id: <20210518102624.1193955-1-alexeymin@postmarketos.org>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix NULL pointer dereference caused by update_inactive()
trying to list_del() an uninitialized mm_list who's
prev/next pointers are NULL.

Signed-off-by: Alexey Minnekhanov <alexeymin@postmarketos.org>
---
 drivers/gpu/drm/msm/msm_gem.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index b199942266a26..b8c873fc63a78 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -1227,6 +1227,13 @@ static struct drm_gem_object *_msm_gem_new(struct drm_device *dev,
 
 		to_msm_bo(obj)->vram_node = &vma->node;
 
+		/* Call chain get_pages() -> update_inactive() tries to
+		 * access msm_obj->mm_list, but it is not initialized yet.
+		 * To avoid NULL pointer dereference error, initialize
+		 * mm_list to be empty.
+		 */
+		INIT_LIST_HEAD(&msm_obj->mm_list);
+
 		msm_gem_lock(obj);
 		pages = get_pages(obj);
 		msm_gem_unlock(obj);
-- 
2.26.3

