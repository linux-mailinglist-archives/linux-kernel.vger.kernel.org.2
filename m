Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACF13BB9D6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 11:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhGEJIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 05:08:07 -0400
Received: from usmx01.baidu.com ([12.0.243.41]:39506 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230194AbhGEJIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 05:08:06 -0400
X-Greylist: delayed 927 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Jul 2021 05:08:06 EDT
Received: from BJHW-Mail-Ex14.internal.baidu.com (unknown [10.127.64.37])
        by Forcepoint Email with ESMTPS id 870992DBA41C14F17D9D;
        Mon,  5 Jul 2021 01:49:59 -0700 (PDT)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex14.internal.baidu.com (10.127.64.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.10; Mon, 5 Jul 2021 16:49:57 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.4; Mon, 5 Jul 2021 16:49:57 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <lyude@redhat.com>, <christian.koenig@amd.com>,
        <tzimmermann@suse.de>, <bskeggs@redhat.com>, <airlied@linux.ie>,
        <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>,
        <nouveau-bounces@lists.freedesktop.org>,
        "Cai Huoqing" <caihuoqing@baidu.com>
Subject: [PATCH] drm/nouveau: remove unused varialble "struct device *dev"
Date:   Mon, 5 Jul 2021 16:49:48 +0800
Message-ID: <20210705084948.796-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex21.internal.baidu.com (172.31.51.15) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex14_2021-07-05 16:49:57:760
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
Reviewed-by: Karol Herbst <kherbst@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_bo.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index 4f3a5357dd56..c5624048de5e 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -1242,7 +1242,6 @@ nouveau_ttm_tt_populate(struct ttm_device *bdev,
 {
        struct ttm_tt *ttm_dma = (void *)ttm;
        struct nouveau_drm *drm;
-       struct device *dev;
        bool slave = !!(ttm->page_flags & TTM_PAGE_FLAG_SG);

        if (ttm_tt_is_populated(ttm))
@@ -1255,7 +1254,6 @@ nouveau_ttm_tt_populate(struct ttm_device *bdev,
        }

        drm = nouveau_bdev(bdev);
-       dev = drm->dev->dev;

        return ttm_pool_alloc(&drm->ttm.bdev.pool, ttm, ctx);
 }
@@ -1265,14 +1263,12 @@ nouveau_ttm_tt_unpopulate(struct ttm_device *bdev,
                          struct ttm_tt *ttm)
 {
        struct nouveau_drm *drm;
-       struct device *dev;
        bool slave = !!(ttm->page_flags & TTM_PAGE_FLAG_SG);

        if (slave)
                return;

        drm = nouveau_bdev(bdev);
-       dev = drm->dev->dev;

        return ttm_pool_free(&drm->ttm.bdev.pool, ttm);
 }
--
2.25.1
