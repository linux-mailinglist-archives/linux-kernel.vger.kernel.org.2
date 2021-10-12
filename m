Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325F2429F96
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 10:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbhJLIRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 04:17:49 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:13725 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234368AbhJLIRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 04:17:48 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HT7jX5tjCzWlHR;
        Tue, 12 Oct 2021 16:14:08 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 12 Oct 2021 16:15:44 +0800
Received: from huawei.com (10.175.124.27) by dggpemm500004.china.huawei.com
 (7.185.36.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 12 Oct
 2021 16:15:44 +0800
From:   Laibin Qiu <qiulaibin@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lijinlin3@huawei.com>
Subject: [PATCH -next] block: fix UAF from race of ioc_release_fn() and __ioc_clear_queue()
Date:   Tue, 12 Oct 2021 16:30:44 +0800
Message-ID: <20211012083044.2409495-1-qiulaibin@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN reports a use-after-free report when doing block test:

[293762.535116]
==================================================================
[293762.535129] BUG: KASAN: use-after-free in
queued_spin_lock_slowpath+0x78/0x4c8
[293762.535133] Write of size 2 at addr ffff8000d5f12bc8 by task sh/9148
[293762.535135]
[293762.535145] CPU: 1 PID: 9148 Comm: sh Kdump: loaded Tainted: G W
4.19.90-vhulk2108.6.0.h824.kasan.eulerosv2r10.aarch64 #1
[293762.535148] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0
02/06/2015
[293762.535150] Call trace:
[293762.535154] dump_backtrace+0x0/0x310
[293762.535158] show_stack+0x28/0x38
[293762.535165] dump_stack+0xec/0x15c
[293762.535172] print_address_description+0x68/0x2d0
[293762.535177] kasan_report+0x130/0x2f0
[293762.535182] __asan_store2+0x80/0xa8
[293762.535189] queued_spin_lock_slowpath+0x78/0x4c8
[293762.535194] __ioc_clear_queue+0x158/0x160
[293762.535198] ioc_clear_queue+0x194/0x258
[293762.535202] elevator_switch_mq+0x64/0x170
[293762.535206] elevator_switch+0x140/0x270
[293762.535211] elv_iosched_store+0x1a4/0x2a0
[293762.535215] queue_attr_store+0x90/0xe0
[293762.535219] sysfs_kf_write+0xa8/0xe8
[293762.535222] kernfs_fop_write+0x1f8/0x378
[293762.535227] __vfs_write+0xe0/0x360
[293762.535233] vfs_write+0xf0/0x270
[293762.535237] ksys_write+0xdc/0x1b8
[293762.535241] __arm64_sys_write+0x50/0x60
[293762.535245] el0_svc_common+0xc8/0x320
[293762.535250] el0_svc_handler+0xf8/0x160
[293762.535253] el0_svc+0x10/0x218
[293762.535254]
[293762.535258] Allocated by task 3466763:
[293762.535264] kasan_kmalloc+0xe0/0x190
[293762.535269] kasan_slab_alloc+0x14/0x20
[293762.535276] kmem_cache_alloc_node+0x1b4/0x420
[293762.535280] create_task_io_context+0x40/0x210
[293762.535284] generic_make_request_checks+0xc78/0xe38
[293762.535288] generic_make_request+0xf8/0x640
[293762.535394] generic_file_direct_write+0x100/0x268
[293762.535401] __generic_file_write_iter+0x128/0x370
[293762.535467] vfs_iter_write+0x64/0x90
[293762.535489] ovl_write_iter+0x2f8/0x458 [overlay]
[293762.535493] __vfs_write+0x264/0x360
[293762.535497] vfs_write+0xf0/0x270
[293762.535501] ksys_write+0xdc/0x1b8
[293762.535505] __arm64_sys_write+0x50/0x60
[293762.535509] el0_svc_common+0xc8/0x320
[293762.535387] ext4_direct_IO+0x3c8/0xe80 [ext4]
[293762.535394] generic_file_direct_write+0x100/0x268
[293762.535401] __generic_file_write_iter+0x128/0x370
[293762.535452] ext4_file_write_iter+0x610/0xa80 [ext4]
[293762.535457] do_iter_readv_writev+0x28c/0x390
[293762.535463] do_iter_write+0xfc/0x360
[293762.535467] vfs_iter_write+0x64/0x90
[293762.535489] ovl_write_iter+0x2f8/0x458 [overlay]
[293762.535493] __vfs_write+0x264/0x360
[293762.535497] vfs_write+0xf0/0x270
[293762.535501] ksys_write+0xdc/0x1b8
[293762.535505] __arm64_sys_write+0x50/0x60
[293762.535509] el0_svc_common+0xc8/0x320
[293762.535513] el0_svc_handler+0xf8/0x160
[293762.535517] el0_svc+0x10/0x218
[293762.535521]
[293762.535523] Freed by task 3466763:
[293762.535528] __kasan_slab_free+0x120/0x228
[293762.535532] kasan_slab_free+0x10/0x18
[293762.535536] kmem_cache_free+0x68/0x248
[293762.535540] put_io_context+0x104/0x190
[293762.535545] put_io_context_active+0x204/0x2c8
[293762.535549] exit_io_context+0x74/0xa0
[293762.535553] do_exit+0x658/0xae0
[293762.535557] do_group_exit+0x74/0x1a8
[293762.535561] get_signal+0x21c/0xf38
[293762.535564] do_signal+0x10c/0x450
[293762.535568] do_notify_resume+0x224/0x4b0
[293762.535573] work_pending+0x8/0x10
[293762.535574]
[293762.535578] The buggy address belongs to the object at
ffff8000d5f12bb8
which belongs to the cache blkdev_ioc of size 136
[293762.535582] The buggy address is located 16 bytes inside of
136-byte region [ffff8000d5f12bb8, ffff8000d5f12c40)
[293762.535583] The buggy address belongs to the page:
[293762.535588] page:ffff7e000357c480 count:1 mapcount:0
mapping:ffff8000d8563c00 index:0x0
[293762.536201] flags: 0x7ffff0000000100(slab)
[293762.536540] raw: 07ffff0000000100 ffff7e0003118588 ffff8000d8adb530
ffff8000d8563c00
[293762.536546] raw: 0000000000000000 0000000000140014 00000001ffffffff
0000000000000000
[293762.536551] page dumped because: kasan: bad access detected
[293762.536552]
[293762.536554] Memory state around the buggy address:
[293762.536558] ffff8000d5f12a80: 00 00 00 00 00 00 fc fc fc fc fc fc fc
fc fb fb
[293762.536562] ffff8000d5f12b00: fb fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fc
[293762.536566] >ffff8000d5f12b80: fc fc fc fc fc fc fc fb fb fb fb fb
fb fb fb fb
[293762.536568] ^
[293762.536572] ffff8000d5f12c00: fb fb fb fb fb fb fb fb fc fc fc fc fc
fc fc fc
[293762.536576] ffff8000d5f12c80: 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00

[293762.536577]
==================================================================

ioc_release_fn() will destroy icq from ioc->icq_list and
__ioc_clear_queue() will destroy icq from request_queue->icq_list.
However, the ioc_release_fn() will hold ioc_lock firstly, and
free ioc finally. Then __ioc_clear_queue() will get ioc from icq
and hold ioc_lock, but ioc has been released, which will result
in a use-after-free.

CPU0                                    CPU1
put_io_context                          elevator_switch_mq
queue_work &ioc->release_work            ioc_clear_queue
                                           ^^^ splice q->icq_list
                                         __ioc_clear_queue
                                           ^^^get icq from icq_list
                                              get ioc from icq->ioc
  ioc_release_fn
   spin_lock(ioc->lock)
   ioc_destroy_icq(icq)
   spin_unlock(ioc->lock)
   free(ioc)
                                         spin_lock(ioc->lock) <= UAF

Fix by grabbing the request_queue->queue_lock in ioc_clear_queue() to
avoid this race scene.

Signed-off-by: Laibin Qiu <qiulaibin@huawei.com>
---
 block/blk-ioc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 57299f860d41..1d6ba8ff5a66 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -242,9 +242,9 @@ void ioc_clear_queue(struct request_queue *q)
 
 	spin_lock_irq(&q->queue_lock);
 	list_splice_init(&q->icq_list, &icq_list);
-	spin_unlock_irq(&q->queue_lock);
 
 	__ioc_clear_queue(&icq_list);
+	spin_unlock_irq(&q->queue_lock);
 }
 
 int create_task_io_context(struct task_struct *task, gfp_t gfp_flags, int node)
-- 
2.22.0

