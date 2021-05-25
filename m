Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95DE838FC4B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 10:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbhEYILv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 04:11:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3657 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbhEYIJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 04:09:41 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fq67600zYzQsR8;
        Tue, 25 May 2021 16:04:33 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 16:08:02 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 25 May
 2021 16:08:01 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <bskeggs@redhat.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH -next] drm/nouveau: Remove set but not used variable 'width'
Date:   Tue, 25 May 2021 16:17:33 +0800
Message-ID: <20210525081733.571257-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/nouveau/nouveau_display.c: In function 'nouveau_framebuffer_new':
drivers/gpu/drm/nouveau/nouveau_display.c:309:15: warning:
 variable ‘width’ set but not used [-Wunused-but-set-variable]

It never used since introduction.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 drivers/gpu/drm/nouveau/nouveau_display.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/nouveau/nouveau_display.c
index 929de41c281f..2b460835a438 100644
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
@@ -343,9 +343,6 @@ nouveau_framebuffer_new(struct drm_device *dev,
 	info = drm_get_format_info(dev, mode_cmd);
 
 	for (i = 0; i < info->num_planes; i++) {
-		width = drm_format_info_plane_width(info,
-						    mode_cmd->width,
-						    i);
 		height = drm_format_info_plane_height(info,
 						      mode_cmd->height,
 						      i);
-- 
2.25.4

