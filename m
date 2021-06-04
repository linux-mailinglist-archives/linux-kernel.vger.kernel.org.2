Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864C739B60B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 11:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhFDJg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 05:36:27 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4473 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhFDJg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 05:36:26 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FxHbD4yJCzZcP5;
        Fri,  4 Jun 2021 17:31:52 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 17:34:38 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 17:34:35 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] virtio_mmio: Use DEFINE_RES_MEM() and DEFINE_RES_IRQ() helper macros
Date:   Fri, 4 Jun 2021 17:34:24 +0800
Message-ID: <20210604093424.12310-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_RES_MEM() and DEFINE_RES_IRQ() helper macros to void some
numbers appearing twice, such as the IRQ number. It makes the code a bit
shorter and easier to read, although the code is completely in the
comments.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/virtio/virtio_mmio.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 56128b9c46eb..3248ce46f99f 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -16,15 +16,8 @@
  *		.id = -1,
  *		.num_resources = 2,
  *		.resource = (struct resource []) {
- *			{
- *				.start = 0x1001e000,
- *				.end = 0x1001e0ff,
- *				.flags = IORESOURCE_MEM,
- *			}, {
- *				.start = 42 + 32,
- *				.end = 42 + 32,
- *				.flags = IORESOURCE_IRQ,
- *			},
+ *			DEFINE_RES_MEM(0x1001e000, 0x100),
+ *			DEFINE_RES_IRQ(42 + 32),
  *		}
  *	};
  *
-- 
2.25.1


