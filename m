Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC4233EE44
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 11:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhCQK0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 06:26:17 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13184 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhCQKZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:25:57 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F0mTC4PpSzmYjM;
        Wed, 17 Mar 2021 18:23:27 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Wed, 17 Mar 2021 18:25:41 +0800
From:   Li Huafei <lihuafei1@huawei.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>, <jolsa@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <yangjihong1@huawei.com>,
        <xukuohai@huawei.com>, <zhangjinhao2@huawei.com>,
        <lihuafei1@huawei.com>
Subject: [PATCH 2/2] perf, ftrace: Fix use-after-free in __ftrace_ops_list_func()
Date:   Wed, 17 Mar 2021 18:25:29 +0800
Message-ID: <20210317102529.226734-3-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210317102529.226734-1-lihuafei1@huawei.com>
References: <20210317102529.226734-1-lihuafei1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.174]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We got a use-after-free report when doing kernel fuzz tests with KSSAN
turned on:

[ 1367.884099] BUG: KASAN: use-after-free in ftrace_ops_list_func+0xf7/0x220
[ 1367.885153] Read of size 8 at addr ffff8884f81a47d0 by tasksyz-executor/99086
[ 1367.886517] CPU: 2 PID: 99086 Comm: syz-executor Kdump: loaded Tainted: G                 --------- -t -4.18.0-147.5.1.2.h379.kasan.eulerosv2r9.x86_64 #1
[ 1367.886522] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31 04/01/2014
[ 1367.886525] Call Trace:
[ 1367.886534]  dump_stack+0xc2/0x12e
[ 1367.886542]  ? orc_sort_cmp+0xb0/0xb0
[ 1367.886551]  print_address_description+0x70/0x360
[ 1367.886558]  ? orc_sort_cmp+0xb0/0xb0
[ 1367.886566]  ? perf_trace_buf_alloc+0x190/0x190
[ 1367.886571]  kasan_report+0x1b2/0x330
[ 1367.886578]  ? ftrace_ops_list_func+0xf7/0x220
[ 1367.886585]  ? orc_find+0x560/0x5a0
[ 1367.886597]  ? ftrace_ops_list_func+0xf7/0x220
[ 1367.886603]  ftrace_ops_list_func+0xf7/0x220
[ 1367.886609]  ? __save_stack_trace+0x92/0x100
[ 1367.886616]  ftrace_call+0x5/0x34
[ 1367.886623]  ? do_syscall_64+0x98/0x2c0
[ 1367.886629]  ? do_syscall_64+0x98/0x2c0
[ 1367.886635]  ? deref_stack_reg+0xd0/0xd0
[ 1367.886644]  ? unwind_get_return_address+0x5/0x50
[ 1367.886651]  unwind_get_return_address+0x5/0x50
[ 1367.886656]  __save_stack_trace+0x92/0x100
[ 1367.886665]  ? do_syscall_64+0x98/0x2c0
[ 1367.886673]  save_stack+0x47/0xd0
[ 1367.886680]  ? __kasan_slab_free+0x130/0x180
[ 1367.886685]  ? kfree+0xa5/0x1e0
[ 1367.886692]  ? cgroup_show_path+0x1fd/0x250
[ 1367.886699]  ? kernfs_sop_show_path+0xad/0xf0
[ 1367.886705]  ? show_mountinfo+0x169/0x4c0
[ 1367.886712]  ? seq_read+0x716/0x950
[ 1367.886718]  ? __vfs_read+0x55/0xb0
[ 1367.886723]  ? vfs_read+0xe7/0x210
[ 1367.886729]  ? ksys_pread64+0x95/0xd0
[ 1367.886734]  ? objects_show+0x10/0x10
[ 1367.886740]  ? ftrace_ops_test+0xba/0x120
[ 1367.886746]  ? ftrace_find_tramp_ops_next+0x90/0x90
[ 1367.886753]  ? ftrace_find_tramp_ops_next+0x90/0x90
[ 1367.886760]  ? ftrace_find_tramp_ops_next+0x90/0x90
[ 1367.886766]  ? objects_show+0x10/0x10
[ 1367.886772]  ? ftrace_ops_list_func+0x147/0x220
[ 1367.886778]  ? __kasan_slab_free+0xac/0x180
[ 1367.886784]  ? cgroup_show_path+0x1fd/0x250
[ 1367.886790]  ? ftrace_call+0x5/0x34
[ 1367.886796]  ? cgroup_show_path+0x1fd/0x250
[ 1367.886802]  ? cgroup_show_path+0x1fd/0x250
[ 1367.886811]  ? fixup_red_left+0x5/0x30
[ 1367.886817]  ? cgroup_show_path+0x1fd/0x250
[ 1367.886824]  __kasan_slab_free+0x130/0x180
[ 1367.886831]  ? cgroup_show_path+0x1fd/0x250
[ 1367.886835]  kfree+0xa5/0x1e0
[ 1367.886842]  cgroup_show_path+0x1fd/0x250
[ 1367.886850]  ? init_and_link_css+0x370/0x370
[ 1367.886856]  kernfs_sop_show_path+0xad/0xf0
[ 1367.886863]  show_mountinfo+0x169/0x4c0
[ 1367.886869]  ? kernfs_test_super+0x80/0x80
[ 1367.886875]  ? show_vfsmnt+0x270/0x270
[ 1367.886880]  ? m_next+0x32/0x80
[ 1367.886886]  ? show_vfsmnt+0x270/0x270
[ 1367.886891]  ? m_show+0x31/0x50
[ 1367.886900]  seq_read+0x716/0x950
[ 1367.886911]  ? seq_lseek+0x1e0/0x1e0
[ 1367.886916]  ? ftrace_call+0x5/0x34
[ 1367.886922]  ? ftrace_call+0x5/0x34
[ 1367.886931]  ? seq_lseek+0x1e0/0x1e0
[ 1367.886938]  __vfs_read+0x55/0xb0
[ 1367.886945]  vfs_read+0xe7/0x210
[ 1367.886954]  ksys_pread64+0x95/0xd0
[ 1367.886961]  do_syscall_64+0x98/0x2c0
[ 1367.886971]  entry_SYSCALL_64_after_hwframe+0x65/0xca
[ 1367.886976] RIP: 0033:0x46436d
[ 1367.886983] Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b4 ff ff ff f7 d8 64 89 01 48
[ 1367.886987] RSP: 002b:00007f83ffff4c28 EFLAGS: 00000246 ORIG_RAX: 0000000000000011
[ 1367.886999] RAX: ffffffffffffffda RBX: 000000000057cfa0 RCX: 000000000046436d
[ 1367.887002] RDX: 0000000000001000 RSI: 0000000020000140 RDI: 0000000000000003
[ 1367.887006] RBP: 000000000057cfa0 R08: 0000000000000000 R09: 0000000000000000
[ 1367.887009] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000057cfac
[ 1367.887013] R13: 00007f83ffff5700 R14: 00000000004d1e47 R15: 0000000000000fff

[ 1367.887275] Allocated by task 99101:
[ 1367.887848]  kasan_kmalloc+0xa0/0xd0
[ 1367.887853]  kmem_cache_alloc_trace+0xfc/0x220
[ 1367.887860]  perf_event_alloc.part.19+0x50/0x14d0
[ 1367.887865]  perf_event_alloc+0x67/0x90
[ 1367.887871]  __do_sys_perf_event_open+0x20e/0x14c0
[ 1367.887876]  do_syscall_64+0x98/0x2c0
[ 1367.887882]  entry_SYSCALL_64_after_hwframe+0x65/0xca

[ 1367.888133] Freed by task 99101:
[ 1367.888651]  __kasan_slab_free+0x130/0x180
[ 1367.888655]  kfree+0xa5/0x1e0
[ 1367.888661]  perf_event_alloc.part.19+0xca4/0x14d0
[ 1367.888666]  perf_event_alloc+0x67/0x90
[ 1367.888672]  __do_sys_perf_event_open+0x20e/0x14c0
[ 1367.888677]  do_syscall_64+0x98/0x2c0
[ 1367.888683]  entry_SYSCALL_64_after_hwframe+0x65/0xca

[ 1367.888935] The buggy address belongs to the object at ffff8884f81a4400
		which belongs to the cache kmalloc-2k of size 2048
[ 1367.890854] The buggy address is located 976 bytes inside of
		2048-byte region [ffff8884f81a4400, ffff8884f81a4c00)
[ 1367.892661] The buggy address belongs to the page:
[ 1367.893404] page:ffffea0013e06800 count:1 mapcount:0 mapping:ffff888107c0cf00 index:0x0 compound_mapcount: 0
[ 1367.894915] flags: 0x17ffffc0008100(slab|head)
[ 1367.895613] raw: 0017ffffc0008100 ffffea0014bda208 ffffea00140c4208 ffff888107c0cf00
[ 1367.896808] raw: 0000000000000000 00000000000f000f 00000001ffffffff 0000000000000000
[ 1367.898000] page dumped because: kasan: bad access detected

[ 1367.899107] Memory state around the buggy address:
[ 1367.899880]  ffff8884f81a4680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 1367.900995]  ffff8884f81a4700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 1367.902106] >ffff8884f81a4780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 1367.903218]

[ 1367.904122]  ffff8884f81a4800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 1367.905234]  ffff8884f81a4880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb

There is a race on 'event' between perf_alloc_event() and
__ftrace_ops_list_func(). When adding a perf event, if the event needs
to use the ftrace framework, it needs to register ftrace_ops with
ftrace, which is a structural member of perf event. If perf_alloc_event()
fails, it will free the allocated event directly, but if ftrace_ops has
been successfully registered, and the probe point is triggered, then
__ftrace_ops_list_func() may still reference the ftrace_ops that perf
just registered, but it has been freed with the event is freed,
so use-after-free happens.

We see the comment of ftrace_ops in include/linux/ftrace.h, which
actually mentions that for dynamically allocated ftrace_ops, after
unregistering it should be guaranteed that no user will reference that
ftrace_ops again, but the current interface unregister_ftrace_function()
does not seem to guarantee this.

We add the ftrace_function_unregister_sync() interface to give users
like perf event a chance to synchronize. The reason we don't do
synchronization directly in unregister_ftrace_function() is that for
some users whose registered ftrace_ops is static, synchronization is not
necessary for them and is performance intensive, so we add a separate
interface.

Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 include/linux/ftrace.h          | 15 +++++++++++++++
 kernel/trace/trace_event_perf.c |  7 +++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 86e5028bfa20..c87de01f792e 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -282,6 +282,20 @@ extern enum ftrace_tracing_type_t ftrace_tracing_type;
 int register_ftrace_function(struct ftrace_ops *ops);
 int unregister_ftrace_function(struct ftrace_ops *ops);
 
+/*
+ * If the ftrace_ops is dynamically allocated, the unregistering of it
+ * should call ftrace_function_unregister_sync() to make sure that there
+ * are no more users references it. Then free it should be safe for ftrace.
+ *
+ * We don't call synchronize_rcu() in unregister_ftrace_function() because
+ * some of the registered ftrace_ops are static and doing synchronize_rcu()
+ * for them is unnecessary and is a performance penalty.
+ */
+static inline void ftrace_function_unregister_sync(void)
+{
+	synchronize_rcu();
+}
+
 extern void ftrace_stub(unsigned long a0, unsigned long a1,
 			struct ftrace_ops *op, struct ftrace_regs *fregs);
 
@@ -292,6 +306,7 @@ extern void ftrace_stub(unsigned long a0, unsigned long a1,
  */
 #define register_ftrace_function(ops) ({ 0; })
 #define unregister_ftrace_function(ops) ({ 0; })
+static inline void ftrace_function_unregister_sync(void) { }
 static inline void ftrace_kill(void) { }
 static inline void ftrace_free_init_mem(void) { }
 static inline void ftrace_free_mem(struct module *mod, void *start, void *end) { }
diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index 288ad2c274fb..4749f6f6adf8 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -494,6 +494,13 @@ static int perf_ftrace_function_unregister(struct perf_event *event)
 {
 	struct ftrace_ops *ops = &event->ftrace_ops;
 	int ret = unregister_ftrace_function(ops);
+
+	/*
+	 * We may free the event later, before we free the event, make sure
+	 * no user references &event->ftrace_ops.
+	 */
+	ftrace_function_unregister_sync();
+
 	ftrace_free_filter(ops);
 	return ret;
 }
-- 
2.17.1

