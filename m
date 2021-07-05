Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E4E3BBD81
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 15:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhGENco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 09:32:44 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9469 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhGENcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 09:32:43 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GJRL556JgzZqwB;
        Mon,  5 Jul 2021 21:26:53 +0800 (CST)
Received: from dggema761-chm.china.huawei.com (10.1.198.203) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 5 Jul 2021 21:30:04 +0800
Received: from huawei.com (10.175.127.227) by dggema761-chm.china.huawei.com
 (10.1.198.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 5 Jul
 2021 21:30:03 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>, <rakesh@tuxera.com>
CC:     <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH] nvme-pci: Don't WARN_ON in nvme_reset_work if ctrl.state is not RESETTING
Date:   Mon, 5 Jul 2021 21:38:29 +0800
Message-ID: <20210705133829.349660-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema761-chm.china.huawei.com (10.1.198.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Followling process:
nvme_probe
  nvme_reset_ctrl
    nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING)
    queue_work(nvme_reset_wq, &ctrl->reset_work)

-------------->	nvme_remove
		  nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING)
worker_thread
  process_one_work
    nvme_reset_work
    WARN_ON(dev->ctrl.state != NVME_CTRL_RESETTING)

, which will trigger WARN_ON in nvme_reset_work():
[  127.534298] WARNING: CPU: 0 PID: 139 at drivers/nvme/host/pci.c:2594
[  127.536161] CPU: 0 PID: 139 Comm: kworker/u8:7 Not tainted 5.13.0
[  127.552518] Call Trace:
[  127.552840]  ? kvm_sched_clock_read+0x25/0x40
[  127.553936]  ? native_send_call_func_single_ipi+0x1c/0x30
[  127.555117]  ? send_call_function_single_ipi+0x9b/0x130
[  127.556263]  ? __smp_call_single_queue+0x48/0x60
[  127.557278]  ? ttwu_queue_wakelist+0xfa/0x1c0
[  127.558231]  ? try_to_wake_up+0x265/0x9d0
[  127.559120]  ? ext4_end_io_rsv_work+0x160/0x290
[  127.560118]  process_one_work+0x28c/0x640
[  127.561002]  worker_thread+0x39a/0x700
[  127.561833]  ? rescuer_thread+0x580/0x580
[  127.562714]  kthread+0x18c/0x1e0
[  127.563444]  ? set_kthread_struct+0x70/0x70
[  127.564347]  ret_from_fork+0x1f/0x30

The preceding problem can be easily reproduced by executing following
script (based on blktests suite):
test() {
  pdev="$(_get_pci_dev_from_blkdev)"
  sysfs="/sys/bus/pci/devices/${pdev}"
  for ((i = 0; i < 10; i++)); do
    echo 1 > "$sysfs/remove"
    echo 1 > /sys/bus/pci/rescan
  done
}

Since the device ctrl could be updated as an non-RESETTING state by
repeating probe/remove in userspace (which is a normal situation), we
can replace stack dumping WARN_ON with a warnning message.

Fixes: 82b057caefaff ("nvme-pci: fix multiple ctrl removal schedulin")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 drivers/nvme/host/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a29b170701fc..966a4c84e699 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2591,7 +2591,9 @@ static void nvme_reset_work(struct work_struct *work)
 	bool was_suspend = !!(dev->ctrl.ctrl_config & NVME_CC_SHN_NORMAL);
 	int result;
 
-	if (WARN_ON(dev->ctrl.state != NVME_CTRL_RESETTING)) {
+	if (dev->ctrl.state != NVME_CTRL_RESETTING) {
+		dev_warn(dev->ctrl.device, "ctrl state %d is not RESETTING\n",
+			 dev->ctrl.state);
 		result = -ENODEV;
 		goto out;
 	}
-- 
2.31.1

