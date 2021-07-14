Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A1F3C813E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 11:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238421AbhGNJTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 05:19:37 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:15011 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238250AbhGNJTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 05:19:36 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GPsHT6WvLzbcXc;
        Wed, 14 Jul 2021 17:13:25 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 14 Jul 2021 17:16:38 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 14 Jul
 2021 17:16:37 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tj@kernel.org>, <jiangshanlai@gmail.com>, <xuqiang36@huawei.com>,
        <paskripkin@gmail.com>
Subject: [PATCH v3] workqueue: fix UAF in pwq_unbound_release_workfn()
Date:   Wed, 14 Jul 2021 17:19:33 +0800
Message-ID: <20210714091934.3124170-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I got a UAF report when doing fuzz test:

[  152.880091][ T8030] ==================================================================
[  152.881240][ T8030] BUG: KASAN: use-after-free in pwq_unbound_release_workfn+0x50/0x190
[  152.882442][ T8030] Read of size 4 at addr ffff88810d31bd00 by task kworker/3:2/8030
[  152.883578][ T8030]
[  152.883932][ T8030] CPU: 3 PID: 8030 Comm: kworker/3:2 Not tainted 5.13.0+ #249
[  152.885014][ T8030] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
[  152.886442][ T8030] Workqueue: events pwq_unbound_release_workfn
[  152.887358][ T8030] Call Trace:
[  152.887837][ T8030]  dump_stack_lvl+0x75/0x9b
[  152.888525][ T8030]  ? pwq_unbound_release_workfn+0x50/0x190
[  152.889371][ T8030]  print_address_description.constprop.10+0x48/0x70
[  152.890326][ T8030]  ? pwq_unbound_release_workfn+0x50/0x190
[  152.891163][ T8030]  ? pwq_unbound_release_workfn+0x50/0x190
[  152.891999][ T8030]  kasan_report.cold.15+0x82/0xdb
[  152.892740][ T8030]  ? pwq_unbound_release_workfn+0x50/0x190
[  152.893594][ T8030]  __asan_load4+0x69/0x90
[  152.894243][ T8030]  pwq_unbound_release_workfn+0x50/0x190
[  152.895057][ T8030]  process_one_work+0x47b/0x890
[  152.895778][ T8030]  worker_thread+0x5c/0x790
[  152.896439][ T8030]  ? process_one_work+0x890/0x890
[  152.897163][ T8030]  kthread+0x223/0x250
[  152.897747][ T8030]  ? set_kthread_struct+0xb0/0xb0
[  152.898471][ T8030]  ret_from_fork+0x1f/0x30
[  152.899114][ T8030]
[  152.899446][ T8030] Allocated by task 8884:
[  152.900084][ T8030]  kasan_save_stack+0x21/0x50
[  152.900769][ T8030]  __kasan_kmalloc+0x88/0xb0
[  152.901416][ T8030]  __kmalloc+0x29c/0x460
[  152.902014][ T8030]  alloc_workqueue+0x111/0x8e0
[  152.902690][ T8030]  __btrfs_alloc_workqueue+0x11e/0x2a0
[  152.903459][ T8030]  btrfs_alloc_workqueue+0x6d/0x1d0
[  152.904198][ T8030]  scrub_workers_get+0x1e8/0x490
[  152.904929][ T8030]  btrfs_scrub_dev+0x1b9/0x9c0
[  152.905599][ T8030]  btrfs_ioctl+0x122c/0x4e50
[  152.906247][ T8030]  __x64_sys_ioctl+0x137/0x190
[  152.906916][ T8030]  do_syscall_64+0x34/0xb0
[  152.907535][ T8030]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  152.908365][ T8030]
[  152.908688][ T8030] Freed by task 8884:
[  152.909243][ T8030]  kasan_save_stack+0x21/0x50
[  152.909893][ T8030]  kasan_set_track+0x20/0x30
[  152.910541][ T8030]  kasan_set_free_info+0x24/0x40
[  152.911265][ T8030]  __kasan_slab_free+0xf7/0x140
[  152.911964][ T8030]  kfree+0x9e/0x3d0
[  152.912501][ T8030]  alloc_workqueue+0x7d7/0x8e0
[  152.913182][ T8030]  __btrfs_alloc_workqueue+0x11e/0x2a0
[  152.913949][ T8030]  btrfs_alloc_workqueue+0x6d/0x1d0
[  152.914703][ T8030]  scrub_workers_get+0x1e8/0x490
[  152.915402][ T8030]  btrfs_scrub_dev+0x1b9/0x9c0
[  152.916077][ T8030]  btrfs_ioctl+0x122c/0x4e50
[  152.916729][ T8030]  __x64_sys_ioctl+0x137/0x190
[  152.917414][ T8030]  do_syscall_64+0x34/0xb0
[  152.918034][ T8030]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  152.918872][ T8030]
[  152.919203][ T8030] The buggy address belongs to the object at ffff88810d31bc00
[  152.919203][ T8030]  which belongs to the cache kmalloc-512 of size 512
[  152.921155][ T8030] The buggy address is located 256 bytes inside of
[  152.921155][ T8030]  512-byte region [ffff88810d31bc00, ffff88810d31be00)
[  152.922993][ T8030] The buggy address belongs to the page:
[  152.923800][ T8030] page:ffffea000434c600 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10d318
[  152.925249][ T8030] head:ffffea000434c600 order:2 compound_mapcount:0 compound_pincount:0
[  152.926399][ T8030] flags: 0x57ff00000010200(slab|head|node=1|zone=2|lastcpupid=0x7ff)
[  152.927515][ T8030] raw: 057ff00000010200 dead000000000100 dead000000000122 ffff888009c42c80
[  152.928716][ T8030] raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
[  152.929890][ T8030] page dumped because: kasan: bad access detected
[  152.930759][ T8030]
[  152.931076][ T8030] Memory state around the buggy address:
[  152.931851][ T8030]  ffff88810d31bc00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  152.932967][ T8030]  ffff88810d31bc80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  152.934068][ T8030] >ffff88810d31bd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  152.935189][ T8030]                    ^
[  152.935763][ T8030]  ffff88810d31bd80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  152.936847][ T8030]  ffff88810d31be00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  152.937940][ T8030] ==================================================================

If apply_wqattrs_prepare() fails in alloc_workqueue(), it will call put_pwq()
which invoke a work queue to call pwq_unbound_release_workfn() and use the 'wq'.
The 'wq' allocated in alloc_workqueue() will be freed in error path when
apply_wqattrs_prepare() fails. So it will lead a UAF.

CPU0                                          CPU1
alloc_workqueue()
alloc_and_link_pwqs()
apply_wqattrs_prepare() fails
apply_wqattrs_cleanup()
schedule_work(&pwq->unbound_release_work)
kfree(wq)
                                              worker_thread()
                                              pwq_unbound_release_workfn() <- trigger uaf here

If apply_wqattrs_prepare() fails, the new pwq are not linked, it doesn't
hold any reference to the 'wq', 'wq' is invalid to access in the worker,
so add check pwq if linked to fix this.

Fixes: 2d5f0764b526 ("workqueue: split apply_workqueue_attrs() into 3 stages")
Reported-by: Hulk Robot <hulkci@huawei.com>
Suggested-by: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
v3:
  drop the v2 and v1 changes, add check pwq in pwq_unbound_release_workfn()
v2:
  also use free_wqattrs_ctx() in workqueue_apply_unbound_cpumask()
---
 kernel/workqueue.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 50142fc08902..f148eacda55a 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3676,15 +3676,21 @@ static void pwq_unbound_release_workfn(struct work_struct *work)
 						  unbound_release_work);
 	struct workqueue_struct *wq = pwq->wq;
 	struct worker_pool *pool = pwq->pool;
-	bool is_last;
+	bool is_last = false;
 
-	if (WARN_ON_ONCE(!(wq->flags & WQ_UNBOUND)))
-		return;
+	/*
+	 * when @pwq is not linked, it doesn't hold any reference to the
+	 * @wq, and @wq is invalid to access.
+	 */
+	if (!list_empty(&pwq->pwqs_node)) {
+		if (WARN_ON_ONCE(!(wq->flags & WQ_UNBOUND)))
+			return;
 
-	mutex_lock(&wq->mutex);
-	list_del_rcu(&pwq->pwqs_node);
-	is_last = list_empty(&wq->pwqs);
-	mutex_unlock(&wq->mutex);
+		mutex_lock(&wq->mutex);
+		list_del_rcu(&pwq->pwqs_node);
+		is_last = list_empty(&wq->pwqs);
+		mutex_unlock(&wq->mutex);
+	}
 
 	mutex_lock(&wq_pool_mutex);
 	put_unbound_pool(pool);
-- 
2.25.1

