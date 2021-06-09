Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8A33A0CDF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 08:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236176AbhFIHAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 03:00:04 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8106 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbhFIHAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 03:00:02 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G0HtC4rxYzYsRm;
        Wed,  9 Jun 2021 14:55:15 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 14:58:05 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 9 Jun 2021
 14:58:04 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-kernel@vger.kernel.org>, Ben Skeggs <bskeggs@redhat.com>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Lyude Paul <lyude@redhat.com>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>, <dri-devel@lists.freedesktop.org>,
        <nouveau@lists.freedesktop.org>, <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next v2] drm/nouveau/mpeg: use list_move instead of list_del/list_add in nv44.c
Date:   Wed, 9 Jun 2021 15:07:13 +0800
Message-ID: <20210609070713.1328686-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using list_move() instead of list_del() + list_add() in nv44.c.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
V1->V2:
	CC mailist

 drivers/gpu/drm/nouveau/nvkm/engine/mpeg/nv44.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/mpeg/nv44.c b/drivers/gpu/drm/nouveau/nvkm/engine/mpeg/nv44.c
index 521ce43a2871..16acd33764de 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/mpeg/nv44.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/mpeg/nv44.c
@@ -158,8 +158,7 @@ nv44_mpeg_intr(struct nvkm_engine *engine)
 	list_for_each_entry(temp, &mpeg->chan, head) {
 		if (temp->inst >> 4 == inst) {
 			chan = temp;
-			list_del(&chan->head);
-			list_add(&chan->head, &mpeg->chan);
+			list_move(&chan->head, &mpeg->chan);
 			break;
 		}
 	}

