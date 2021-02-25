Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F661324B87
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 08:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbhBYHvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 02:51:47 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13001 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbhBYHvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:51:44 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DmQ0b2dqbzjSKx;
        Thu, 25 Feb 2021 15:49:19 +0800 (CST)
Received: from huawei.com (10.69.192.56) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Thu, 25 Feb 2021
 15:50:48 +0800
From:   Luo Jiaxing <luojiaxing@huawei.com>
To:     <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <bskeggs@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        <luojiaxing@huawei.com>
Subject: [PATCH v1] drm/nouveau/kms: delete an useless function call in nouveau_framebuffer_new()
Date:   Thu, 25 Feb 2021 15:51:42 +0800
Message-ID: <1614239502-47072-1-git-send-email-luojiaxing@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nouveau_framebuffer_new() call drm_format_info_plane_width() to get a width
of plane, but width is not used then, so it's a useless function call here.

Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
---
 drivers/gpu/drm/nouveau/nouveau_display.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/nouveau/nouveau_display.c
index 17831ee..7d3b1f8 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -306,7 +306,7 @@ nouveau_framebuffer_new(struct drm_device *dev,
 	struct nouveau_bo *nvbo = nouveau_gem_object(gem);
 	struct drm_framebuffer *fb;
 	const struct drm_format_info *info;
-	unsigned int width, height, i;
+	unsigned int height, i;
 	uint32_t tile_mode;
 	uint8_t kind;
 	int ret;
@@ -346,9 +346,6 @@ nouveau_framebuffer_new(struct drm_device *dev,
 	info = drm_get_format_info(dev, mode_cmd);
 
 	for (i = 0; i < info->num_planes; i++) {
-		width = drm_format_info_plane_width(info,
-						    mode_cmd->width,
-						    i);
 		height = drm_format_info_plane_height(info,
 						      mode_cmd->height,
 						      i);
-- 
2.7.4

