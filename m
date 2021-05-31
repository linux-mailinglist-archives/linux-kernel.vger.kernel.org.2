Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69C83953E3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 04:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbhEaCas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 22:30:48 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2794 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhEaCah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 22:30:37 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FtfHh5flZzWq73;
        Mon, 31 May 2021 10:24:16 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 10:28:56 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 31 May
 2021 10:28:56 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <bskeggs@redhat.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH -next] drm/nouveau/svm: Remove set but not used variable 'ret'
Date:   Mon, 31 May 2021 10:38:11 +0800
Message-ID: <20210531023811.477542-1-libaokun1@huawei.com>
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

drivers/gpu/drm/nouveau/nouveau_svm.c: In function 'nouveau_pfns_map':
drivers/gpu/drm/nouveau/nouveau_svm.c:814:6: warning:
 variable ‘ret’ set but not used [-Wunused-but-set-variable]

It never used since introduction.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index 84726a89e665..16fbf90f9f31 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -921,7 +921,6 @@ nouveau_pfns_map(struct nouveau_svmm *svmm, struct mm_struct *mm,
 		 unsigned long addr, u64 *pfns, unsigned long npages)
 {
 	struct nouveau_pfnmap_args *args = nouveau_pfns_to_args(pfns);
-	int ret;
 
 	args->p.addr = addr;
 	args->p.size = npages << PAGE_SHIFT;
@@ -929,7 +928,7 @@ nouveau_pfns_map(struct nouveau_svmm *svmm, struct mm_struct *mm,
 	mutex_lock(&svmm->mutex);
 
 	svmm->vmm->vmm.object.client->super = true;
-	ret = nvif_object_ioctl(&svmm->vmm->vmm.object, args, sizeof(*args) +
+	nvif_object_ioctl(&svmm->vmm->vmm.object, args, sizeof(*args) +
 				npages * sizeof(args->p.phys[0]), NULL);
 	svmm->vmm->vmm.object.client->super = false;
 
-- 
2.25.4

