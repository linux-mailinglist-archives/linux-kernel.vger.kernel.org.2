Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1193A0D45
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 09:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237004AbhFIHLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 03:11:13 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:5303 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbhFIHKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 03:10:50 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G0J4M2ccYz1BJhn;
        Wed,  9 Jun 2021 15:04:03 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 15:08:55 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 9 Jun 2021
 15:08:54 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>, <dri-devel@lists.freedesktop.org>,
        <kernel-janitors@vger.kernel.org>, "Hulk Robot" <hulkci@huawei.com>
Subject: [PATCH -next v2] drm/vmwgfx: Use list_move_tail instead of list_del/list_add_tail in vmwgfx_cmdbuf.c
Date:   Wed, 9 Jun 2021 15:18:03 +0800
Message-ID: <20210609071803.1347254-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using list_move_tail() instead of list_del() + list_add_tail() in vmwgfx_cmdbuf.c.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
V1->V2:
	CC mailist

 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c
index 6bb4961e64a5..58417d972b69 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c
@@ -358,8 +358,7 @@ static void vmw_cmdbuf_ctx_submit(struct vmw_cmdbuf_man *man,
 			break;
 		}
 
-		list_del(&entry->list);
-		list_add_tail(&entry->list, &ctx->hw_submitted);
+		list_move_tail(&entry->list, &ctx->hw_submitted);
 		ctx->num_hw_submitted++;
 	}
 

