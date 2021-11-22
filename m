Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77457458E33
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 13:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239327AbhKVMZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 07:25:35 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:15848 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbhKVMZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 07:25:34 -0500
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HyRGd1X19z91Bh;
        Mon, 22 Nov 2021 20:22:01 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 22 Nov 2021 20:22:26 +0800
Received: from DESKTOP-27KDQMV.china.huawei.com (10.174.148.223) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 22 Nov 2021 20:22:25 +0800
From:   "Longpeng(Mike)" <longpeng2@huawei.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <sgarzare@redhat.com>, <mgurtovoy@nvidia.com>, <parav@nvidia.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <arei.gonglei@huawei.com>,
        Longpeng <longpeng2@huawei.com>
Subject: [PATCH] vdpa_sim: avoid putting an uninitialized iova_domain
Date:   Mon, 22 Nov 2021 20:22:21 +0800
Message-ID: <20211122122221.56-1-longpeng2@huawei.com>
X-Mailer: git-send-email 2.25.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.148.223]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml100016.china.huawei.com (7.185.36.216)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Longpeng <longpeng2@huawei.com>

The system will crash if we put an uninitialized iova_domain, this
could happen when an error occurs before initializing the iova_domain
in vdpasim_create().

BUG: kernel NULL pointer dereference, address: 0000000000000000
...
RIP: 0010:__cpuhp_state_remove_instance+0x96/0x1c0
...
Call Trace:
 <TASK>
 put_iova_domain+0x29/0x220
 vdpasim_free+0xd1/0x120 [vdpa_sim]
 vdpa_release_dev+0x21/0x40 [vdpa]
 device_release+0x33/0x90
 kobject_release+0x63/0x160
 vdpasim_create+0x127/0x2a0 [vdpa_sim]
 vdpasim_net_dev_add+0x7d/0xfe [vdpa_sim_net]
 vdpa_nl_cmd_dev_add_set_doit+0xe1/0x1a0 [vdpa]
 genl_family_rcv_msg_doit+0x112/0x140
 genl_rcv_msg+0xdf/0x1d0
 ...

So we must make sure the iova_domain is already initialized before
put it.

In addition, we may get the following warning in this case:
WARNING: ... drivers/iommu/iova.c:344 iova_cache_put+0x58/0x70

So we must make sure the iova_cache_put() is invoked only if the
iova_cache_get() is already invoked. Let's fix it together.

Signed-off-by: Longpeng <longpeng2@huawei.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 5f484fff8dbe..41b0cd17fcba 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -591,8 +591,11 @@ static void vdpasim_free(struct vdpa_device *vdpa)
 		vringh_kiov_cleanup(&vdpasim->vqs[i].in_iov);
 	}
 
-	put_iova_domain(&vdpasim->iova);
-	iova_cache_put();
+	if (vdpa_get_dma_dev(vdpa)) {
+		put_iova_domain(&vdpasim->iova);
+		iova_cache_put();
+	}
+
 	kvfree(vdpasim->buffer);
 	if (vdpasim->iommu)
 		vhost_iotlb_free(vdpasim->iommu);
-- 
2.27.0

