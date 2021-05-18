Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82CE38788F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 14:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245743AbhERMT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 08:19:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4729 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242288AbhERMTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 08:19:25 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fkw0r5thXzqV9r;
        Tue, 18 May 2021 20:14:36 +0800 (CST)
Received: from dggemi762-chm.china.huawei.com (10.1.198.148) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 20:18:05 +0800
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 dggemi762-chm.china.huawei.com (10.1.198.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 18 May 2021 20:18:04 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <joseph.kogut@gmail.com>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] drm: Fix missing unlock and free on error in drm_legacy_addbufs_pci()
Date:   Tue, 18 May 2021 20:35:02 +0800
Message-ID: <1621341302-112089-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggemi762-chm.china.huawei.com (10.1.198.148)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing unlock and free before return from function
drm_legacy_addbufs_pci() in the error handling case.

Fixes: 70556e24e18e ("drm: remove usage of drm_pci_alloc/free")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/gpu/drm/drm_bufs.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_bufs.c b/drivers/gpu/drm/drm_bufs.c
index 4805726..c23d7f7 100644
--- a/drivers/gpu/drm/drm_bufs.c
+++ b/drivers/gpu/drm/drm_bufs.c
@@ -984,8 +984,16 @@ int drm_legacy_addbufs_pci(struct drm_device *dev,
 
 	while (entry->buf_count < count) {
 		dmah = kmalloc(sizeof(drm_dma_handle_t), GFP_KERNEL);
-		if (!dmah)
+		if (!dmah) {
+			/* Set count correctly so we free the proper amount. */
+			entry->buf_count = count;
+			entry->seg_count = count;
+			drm_cleanup_buf_error(dev, entry);
+			kfree(temp_pagelist);
+			mutex_unlock(&dev->struct_mutex);
+			atomic_dec(&dev->buf_alloc);
 			return -ENOMEM;
+		}
 
 		dmah->size = total;
 		dmah->vaddr = dma_alloc_coherent(dev->dev,
-- 
2.6.2

