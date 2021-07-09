Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A992C3C1FD9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 09:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbhGIHKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 03:10:42 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:10448 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhGIHKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 03:10:40 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GLkgG0bpMzcbPB;
        Fri,  9 Jul 2021 15:04:42 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 9 Jul 2021 15:07:55 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 9 Jul 2021
 15:07:55 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tj@kernel.org>, <jiangshanlai@gmail.com>, <xuqiang36@huawei.com>,
        <paskripkin@gmail.com>
Subject: [PATCH v2] workqueue: fix UAF in pwq_unbound_release_workfn()
Date:   Fri, 9 Jul 2021 15:11:00 +0800
Message-ID: <20210709071100.4057639-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

If apply_wqattrs_prepare() fails, the new pwqs are not linked, we don't need
the worker to free them, so just free the 'ctx' and its members in the error
path.

Fixes: 2d5f0764b526 ("workqueue: split apply_workqueue_attrs() into 3 stages")
Reported-by: Hulk Robot <hulkci@huawei.com>
Suggested-by: Lai Jiangshan <jiangshanlai@gmail.com>
Co-developed-by: Xu Qiang <xuqiang36@huawei.com>
Signed-off-by: Xu Qiang <xuqiang36@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
v2:
  also use free_wqattrs_ctx() in workqueue_apply_unbound_cpumask()
---
 kernel/workqueue.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 50142fc08902..a2966ff19c50 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3898,6 +3898,31 @@ struct apply_wqattrs_ctx {
 	struct pool_workqueue	*pwq_tbl[];
 };
 
+static void free_pwq(struct pool_workqueue *pwq)
+{
+	if (!pwq || --pwq->refcnt)
+		return;
+
+	put_unbound_pool(pwq->pool);
+	kmem_cache_free(pwq_cache, pwq);
+}
+
+static void free_wqattrs_ctx(struct apply_wqattrs_ctx *ctx)
+{
+	int node;
+
+	if (!ctx)
+		return;
+
+	for_each_node(node)
+		free_pwq(ctx->pwq_tbl[node]);
+	free_pwq(ctx->dfl_pwq);
+
+	free_workqueue_attrs(ctx->attrs);
+
+	kfree(ctx);
+}
+
 /* free the resources after success or abort */
 static void apply_wqattrs_cleanup(struct apply_wqattrs_ctx *ctx)
 {
@@ -3981,7 +4006,7 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
 out_free:
 	free_workqueue_attrs(tmp_attrs);
 	free_workqueue_attrs(new_attrs);
-	apply_wqattrs_cleanup(ctx);
+	free_wqattrs_ctx(ctx);
 	return NULL;
 }
 
@@ -5309,9 +5334,12 @@ static int workqueue_apply_unbound_cpumask(void)
 	}
 
 	list_for_each_entry_safe(ctx, n, &ctxs, list) {
-		if (!ret)
+		if (!ret) {
 			apply_wqattrs_commit(ctx);
-		apply_wqattrs_cleanup(ctx);
+			apply_wqattrs_cleanup(ctx);
+		} else {
+			free_wqattrs_ctx(ctx);
+		}
 	}
 
 	return ret;
-- 
2.25.1

