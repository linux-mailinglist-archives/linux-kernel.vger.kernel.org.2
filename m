Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40CF53B5282
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 10:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhF0IDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 04:03:43 -0400
Received: from m12-15.163.com ([220.181.12.15]:33173 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhF0IDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 04:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=dn2OHWnaKzUjkxfP+B
        r0ExjTZGAQz9D9C9SLtoPnw2c=; b=Oi2znL7XpqCdHeQt9vqzwmrv3SU8ouRVaj
        DveHEikK1nTJNbiJ5Lp9Eg/sEJAg6458eA9fVJRj+zOMfYH53b/FwOo/+NT8IRXH
        EzgutytcRdtqZhSBPpLnIny0ksHEr1p3c94cixtt0JwSG/ucE2VueDv30ZIO+BGd
        f0N+NNZqQ=
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (unknown [39.183.0.171])
        by smtp11 (Coremail) with SMTP id D8CowADHz_fpL9hgJ7k8Ag--.1973S4;
        Sun, 27 Jun 2021 15:59:57 +0800 (CST)
From:   Cai Huoqing <caihuoqing1990@163.com>
To:     bskeggs@redhat.com, airlied@linux.ie, daniel@ffwll.ch,
        kherbst@redhat.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        nouveau-bounces@lists.freedesktop.org,
        Cai Huoqing <caihuoqing@baidu.com>
Subject: [PATCH v2] drm/nouveau: remove unused varialble "struct device *dev"
Date:   Sun, 27 Jun 2021 15:59:35 +0800
Message-Id: <20210627075935.373-1-caihuoqing1990@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: D8CowADHz_fpL9hgJ7k8Ag--.1973S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF4kWFykJw13Kw4rKr1kuFg_yoW8Jw43pF
        48Ca47ZF4DKws2gr40yF18ZF9IyanrJFyxGFyjy3sYgw4Fyr98Xr4rJry5ArW5JFyxuay3
        tF9rKasIv3WjkaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYGQDUUUUU=
X-Originating-IP: [39.183.0.171]
X-CM-SenderInfo: xfdlx3xrtl0warzziqqrwthudrp/1tbiMB2+plWByBTxdAAAs4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cai Huoqing <caihuoqing@baidu.com>

fix the warning- variable 'dev' set but not used

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
Reviewed-by: Karol Herbst <kherbst@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_bo.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index 984721bf3ab4..cb3ff4ae203e 100644
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
2.17.1

