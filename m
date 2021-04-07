Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3EEA356846
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350241AbhDGJoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 05:44:19 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15156 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbhDGJoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:44:18 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FFfXw0Zz8zpVwS;
        Wed,  7 Apr 2021 17:41:20 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.179.202) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Wed, 7 Apr 2021 17:43:56 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        James Jones <jajones@nvidia.com>
Subject: [PATCH 1/1] drm/nouveau/kms: remove unused local variable 'width'
Date:   Wed, 7 Apr 2021 17:43:44 +0800
Message-ID: <20210407094344.2924-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.202]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning:

drivers/gpu/drm/nouveau/nouveau_display.c: In function ‘nouveau_framebuffer_new’:
drivers/gpu/drm/nouveau/nouveau_display.c:309:15: warning: variable ‘width’ set but not used [-Wunused-but-set-variable]

Fixes: 4f5746c863db ("drm/nouveau/kms: Check framebuffer size against bo")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/gpu/drm/nouveau/nouveau_display.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/nouveau/nouveau_display.c
index 17831ee897ea46d..7d3b1f8de300784 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -306,7 +306,7 @@
 	struct nouveau_bo *nvbo = nouveau_gem_object(gem);
 	struct drm_framebuffer *fb;
 	const struct drm_format_info *info;
-	unsigned int width, height, i;
+	unsigned int height, i;
 	uint32_t tile_mode;
 	uint8_t kind;
 	int ret;
@@ -346,9 +346,6 @@
 	info = drm_get_format_info(dev, mode_cmd);
 
 	for (i = 0; i < info->num_planes; i++) {
-		width = drm_format_info_plane_width(info,
-						    mode_cmd->width,
-						    i);
 		height = drm_format_info_plane_height(info,
 						      mode_cmd->height,
 						      i);
-- 
1.8.3


