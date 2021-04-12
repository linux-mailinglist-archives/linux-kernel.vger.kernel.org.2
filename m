Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632FE35C623
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 14:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240434AbhDLMYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 08:24:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:39708 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238378AbhDLMX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 08:23:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BF645AE5C;
        Mon, 12 Apr 2021 12:23:39 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Steve Wise <swise@opengridcomputing.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH] nvme: Drop WQ_MEM_RECLAIM flag from core workqueues
Date:   Mon, 12 Apr 2021 14:23:30 +0200
Message-Id: <20210412122330.5166-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the WQ_MEM_RECLAIM flag as it is not needed and introduces
warnings.

The documentation says "all wq which might be used in the memory
reclaim paths MUST have this flag set. The wq is guaranteed to have at
least one execution context regardless of memory pressure."

By setting WQ_MEM_RECLAIM the threads are ready be running during
early init. The claim it guarantees at least one execution context
regardless of memory pressure is not supported by the implementation.

As the nvme core does not depend on early init we can remove the
WQ_MEM_RECLAIM flag. This resolves a warning in the rdma path:

  WQ_MEM_RECLAIM nvme-wq:nvme_rdma_reconnect_ctrl_work [nvme_rdma]
  is flushing !WQ_MEM_RECLAIM ib_addr:process_one_req [ib_core]

There were several attempts to address these kind of warnings and but
it still persist:

  39baf10310e6 ("IB/core: Fix use workqueue without WQ_MEM_RECLAIM")
  cb93e597779e ("cm: Don't allocate ib_cm workqueue with WQ_MEM_RECLAIM")
  c669ccdc50c2 ("nvme: queue ns scanning and async request from nvme_wq")

Also a review of the nvme jobs shows nvme_wq and nvme_reset_wq gets
jobs posted which do memory allocation:

 - nvme_wq

   nvme_scan_work()
     nvme_scan_ns_list()
       ns_list = kzalloc(..., GFP_KERNEL);
   [...]

 - nvme_reset_wq

   nvme_reset_work()
     nvme_pci_configure_admin_queue()
       nvme_alloc_queue()
         dma_alloc_coherent(..., GFP_KERNEL)

   nvme_rdma_reset_ctrl_work()
     nvme_rdma_setup_ctrl()
       (see above)

   nvme_reset_ctrl_work()
     nvme_tcp_setup_ctrl()
       nvme_tcp_configure_admin_queue()
         nvme_tcp_alloc_queue()
           sock_create()
   [...]

nvme_delete_wq doesn't run any job which allocates memory, the system
still depends on nvme_wq/nvme_reset_wq making progress.

 - nvme_delete_wq

   nvme_fc_ctrl_connectivity_loss()
     nvme_delete_ctrl()
   nvme_fc_unregister_remoteport
     nvme_delete_ctrl()
   nvme_fc_reconnect_or_delete()
     nvme_delete_ctrl()
   nvme_rdma_reconnect_or_remove()
     nvme_delete_ctrl()
   nvme_tcp_reconnect_or_remove()
     nvme_delete_ctrl()

   nvme_delete_ctrl_work()
     flush_work(&ctrl->reset_work)
     flush_work(&ctrl->async_event_work)
     cancel_work_sync(&ctrl->fw_act_work)
     ...

That means we either have WQ_MEM_RECLAIM set on all wq or non.

Link: https://patchwork.kernel.org/project/linux-rdma/patch/5f5a1e4e90f3625cea57ffa79fc0e5bcb7efe09d.1548963371.git.swise@opengridcomputing.com/

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 11fca6459812..ab0d00ddf03f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4810,17 +4810,17 @@ static int __init nvme_core_init(void)
 	_nvme_check_size();
 
 	nvme_wq = alloc_workqueue("nvme-wq",
-			WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS, 0);
+			WQ_UNBOUND | WQ_SYSFS, 0);
 	if (!nvme_wq)
 		goto out;
 
 	nvme_reset_wq = alloc_workqueue("nvme-reset-wq",
-			WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS, 0);
+			WQ_UNBOUND | WQ_SYSFS, 0);
 	if (!nvme_reset_wq)
 		goto destroy_wq;
 
 	nvme_delete_wq = alloc_workqueue("nvme-delete-wq",
-			WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS, 0);
+			WQ_UNBOUND | WQ_SYSFS, 0);
 	if (!nvme_delete_wq)
 		goto destroy_reset_wq;
 
-- 
2.29.2

