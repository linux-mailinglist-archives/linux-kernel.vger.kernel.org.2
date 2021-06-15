Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B71433A7777
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 09:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhFOHCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 03:02:20 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:48133 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229488AbhFOHCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 03:02:11 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UcURDlO_1623740392;
Received: from localhost(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0UcURDlO_1623740392)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 15 Jun 2021 15:00:06 +0800
From:   Hui Zhu <teawater@gmail.com>
To:     david@redhat.com, mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Hui Zhu <teawaterz@linux.alibaba.com>
Subject: [RFC] virtio-mem: virtio_mem_init: Access bb_size just in BBM mode
Date:   Tue, 15 Jun 2021 14:59:48 +0800
Message-Id: <20210615065948.23493-1-teawater@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hui Zhu <teawaterz@linux.alibaba.com>

/* In BBM, we also want at least two big blocks. */
vm->offline_threshold = max_t(uint64_t, 2 * vm->bbm.bb_size,
			      vm->offline_threshold);
This line does not modify vm->offline_threshold depending on the data in
vm->sbm that shares this address is 0 in SBM mode.
I think it might be difficult to make sure when we change this in the
future.

This commit adds an if to make sure that this line just be executed in
BBM mode.

Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
---
 drivers/virtio/virtio_mem.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 10ec60d..8185916 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2472,8 +2472,9 @@ static int virtio_mem_init(struct virtio_mem *vm)
 	vm->offline_threshold = max_t(uint64_t, 2 * memory_block_size_bytes(),
 				      VIRTIO_MEM_DEFAULT_OFFLINE_THRESHOLD);
 	/* In BBM, we also want at least two big blocks. */
-	vm->offline_threshold = max_t(uint64_t, 2 * vm->bbm.bb_size,
-				      vm->offline_threshold);
+	if (!vm->in_sbm)
+		vm->offline_threshold = max_t(uint64_t, 2 * vm->bbm.bb_size,
+					      vm->offline_threshold);
 
 	dev_info(&vm->vdev->dev, "start address: 0x%llx", vm->addr);
 	dev_info(&vm->vdev->dev, "region size: 0x%llx", vm->region_size);
-- 
1.8.3.1

