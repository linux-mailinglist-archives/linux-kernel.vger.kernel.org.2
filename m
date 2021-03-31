Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC84435012A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 15:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbhCaNVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 09:21:46 -0400
Received: from mail-m121143.qiye.163.com ([115.236.121.143]:34800 "EHLO
        mail-m121143.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235784AbhCaNVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 09:21:13 -0400
Received: from ubuntu.localdomain (unknown [36.152.145.181])
        by mail-m121143.qiye.163.com (Hmail) with ESMTPA id 383AD5404CC;
        Wed, 31 Mar 2021 21:12:11 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Guchun Chen <guchun.chen@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Dennis Li <Dennis.Li@amd.com>,
        John Clements <john.clements@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Stanley.Yang" <Stanley.Yang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] drm/amd: cleanup coding style a bit
Date:   Wed, 31 Mar 2021 06:12:03 -0700
Message-Id: <20210331131205.60710-1-bernard@vivo.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQkhJS0seHR4fSkxNVkpNSkxKQk1ISEpNSUNVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS09ISFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NSo6NSo*DT8SHjVCGSoWNEgc
        MzQaFAJVSlVKTUpMSkJNSEhKQ0JIVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlITVVK
        TklVSk9OVUpDSllXWQgBWUFJQ05KNwY+
X-HM-Tid: 0a788869b23bb038kuuu383ad5404cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix patch check warning:
WARNING: suspect code indent for conditional statements (8, 17)
+       if (obj && obj->use < 0) {
+                DRM_ERROR("RAS ERROR: Unbalance obj(%s) use\n", obj->head.name);

WARNING: braces {} are not necessary for single statement blocks
+       if (obj && obj->use < 0) {
+                DRM_ERROR("RAS ERROR: Unbalance obj(%s) use\n", obj->head.name);
+       }

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 1fb2a91ad30a..43d17b72c265 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -449,11 +449,10 @@ static ssize_t amdgpu_ras_sysfs_read(struct device *dev,
 
 static inline void put_obj(struct ras_manager *obj)
 {
-	if (obj && --obj->use == 0)
+	if (obj && (--obj->use == 0))
 		list_del(&obj->node);
-	if (obj && obj->use < 0) {
-		 DRM_ERROR("RAS ERROR: Unbalance obj(%s) use\n", obj->head.name);
-	}
+	if (obj && (obj->use < 0))
+		DRM_ERROR("RAS ERROR: Unbalance obj(%s) use\n", obj->head.name);
 }
 
 /* make one obj and return it. */
-- 
2.31.0

