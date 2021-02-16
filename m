Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6B131CF15
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 18:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhBPRbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 12:31:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:34250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231136AbhBPR3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 12:29:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BC6B64DA1;
        Tue, 16 Feb 2021 17:28:20 +0000 (UTC)
Date:   Tue, 16 Feb 2021 17:28:17 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     syzbot <syzbot+95c862be69e37145543f@syzkaller.appspotmail.com>
Cc:     broonie@kernel.org, keescook@chromium.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mbenes@suse.cz,
        syzkaller-bugs@googlegroups.com, will@kernel.org, Jason@zx2c4.com,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: KASAN: invalid-access Write in enqueue_timer
Message-ID: <20210216172817.GA14978@arm.com>
References: <0000000000000be4d705bb68dfa7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000000be4d705bb68dfa7@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Jason and Ard. It may be a use-after-free in the wireguard
driver.

Catalin

On Mon, Feb 15, 2021 at 04:06:16PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f40ddce8 Linux 5.11
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1395db28d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=494a8e2d9bf09818
> dashboard link: https://syzkaller.appspot.com/bug?extid=95c862be69e37145543f
> userspace arch: arm64
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+95c862be69e37145543f@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: invalid-access in hlist_add_head include/linux/list.h:883 [inline]
> BUG: KASAN: invalid-access in enqueue_timer+0x18/0xc0 kernel/time/timer.c:581
> Write at addr f4ff0000275dcda0 by task kworker/u4:6/2919
> Pointer tag: [f4], memory tag: [fe]
> 
> CPU: 1 PID: 2919 Comm: kworker/u4:6 Not tainted 5.11.0-syzkaller #0
> Hardware name: linux,dummy-virt (DT)
> Workqueue: wg-kex-wg1 wg_packet_handshake_send_worker
> Call trace:
>  dump_backtrace+0x0/0x1b0 arch/arm64/kernel/stacktrace.c:117
>  show_stack+0x18/0x70 arch/arm64/kernel/stacktrace.c:196
>  __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack+0xd0/0x12c lib/dump_stack.c:120
>  print_address_description+0x70/0x29c mm/kasan/report.c:230
>  __kasan_report mm/kasan/report.c:396 [inline]
>  kasan_report+0x134/0x380 mm/kasan/report.c:413
>  report_tag_fault arch/arm64/mm/fault.c:311 [inline]
>  do_tag_recovery arch/arm64/mm/fault.c:325 [inline]
>  __do_kernel_fault+0x178/0x1bc arch/arm64/mm/fault.c:369
>  do_bad_area arch/arm64/mm/fault.c:462 [inline]
>  do_tag_check_fault+0x74/0x90 arch/arm64/mm/fault.c:717
>  do_mem_abort+0x44/0xbc arch/arm64/mm/fault.c:793
>  el1_abort+0x40/0x6c arch/arm64/kernel/entry-common.c:118
>  el1_sync_handler+0xac/0xd0 arch/arm64/kernel/entry-common.c:209
>  el1_sync+0x70/0x100 arch/arm64/kernel/entry.S:656
>  hlist_add_head include/linux/list.h:883 [inline]
>  enqueue_timer+0x18/0xc0 kernel/time/timer.c:581
>  mod_timer+0x14/0x20 kernel/time/timer.c:1106
>  mod_peer_timer drivers/net/wireguard/timers.c:37 [inline]
>  wg_timers_any_authenticated_packet_traversal+0x68/0x90 drivers/net/wireguard/timers.c:215
>  wg_packet_send_handshake_initiation+0xa8/0xe0 drivers/net/wireguard/send.c:36
>  wg_packet_handshake_send_worker+0x1c/0x34 drivers/net/wireguard/send.c:51
>  process_one_work+0x1d8/0x360 kernel/workqueue.c:2275
>  worker_thread+0x70/0x434 kernel/workqueue.c:2421
>  kthread+0x174/0x180 kernel/kthread.c:292
>  ret_from_fork+0x10/0x34 arch/arm64/kernel/entry.S:958
> 
> Allocated by task 6247:
>  stack_trace_save+0x50/0x80 kernel/stacktrace.c:121
>  kasan_save_stack+0x28/0x60 mm/kasan/common.c:38
>  kasan_set_track mm/kasan/common.c:46 [inline]
>  set_alloc_info mm/kasan/common.c:401 [inline]
>  ____kasan_kmalloc+0xe8/0x160 mm/kasan/common.c:429
>  __kasan_kmalloc+0x14/0x20 mm/kasan/common.c:443
>  kasan_kmalloc include/linux/kasan.h:219 [inline]
>  __kmalloc_node+0x1d0/0x3ac mm/slub.c:4033
>  kmalloc_node include/linux/slab.h:575 [inline]
>  kvmalloc_node+0x40/0xe0 mm/util.c:587
>  kvmalloc include/linux/mm.h:781 [inline]
>  kvzalloc include/linux/mm.h:789 [inline]
>  alloc_netdev_mqs+0x5c/0x3bc net/core/dev.c:10546
>  rtnl_create_link+0xc8/0x2b0 net/core/rtnetlink.c:3171
>  __rtnl_newlink+0x5bc/0x800 net/core/rtnetlink.c:3433
>  rtnl_newlink+0x70/0xa0 net/core/rtnetlink.c:3491
>  rtnetlink_rcv_msg+0x118/0x334 net/core/rtnetlink.c:5553
>  netlink_rcv_skb+0x5c/0x130 net/netlink/af_netlink.c:2494
>  rtnetlink_rcv+0x18/0x2c net/core/rtnetlink.c:5571
>  netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
>  netlink_unicast+0x25c/0x320 net/netlink/af_netlink.c:1330
>  netlink_sendmsg+0x1d4/0x3e4 net/netlink/af_netlink.c:1919
>  sock_sendmsg_nosec net/socket.c:652 [inline]
>  sock_sendmsg+0x54/0x60 net/socket.c:672
>  __sys_sendto+0x118/0x14c net/socket.c:1975
>  __do_sys_sendto net/socket.c:1987 [inline]
>  __se_sys_sendto net/socket.c:1983 [inline]
>  __arm64_sys_sendto+0x2c/0x40 net/socket.c:1983
>  __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
>  invoke_syscall arch/arm64/kernel/syscall.c:49 [inline]
>  el0_svc_common.constprop.0+0x74/0x190 arch/arm64/kernel/syscall.c:159
>  do_el0_svc+0x74/0x90 arch/arm64/kernel/syscall.c:198
>  el0_svc+0x14/0x20 arch/arm64/kernel/entry-common.c:365
>  el0_sync_handler+0x1a4/0x1b0 arch/arm64/kernel/entry-common.c:381
>  el0_sync+0x190/0x1c0 arch/arm64/kernel/entry.S:699
> 
> Freed by task 24:
>  stack_trace_save+0x50/0x80 kernel/stacktrace.c:121
>  kasan_save_stack+0x28/0x60 mm/kasan/common.c:38
>  kasan_set_track+0x28/0x40 mm/kasan/common.c:46
>  kasan_set_free_info+0x20/0x30 mm/kasan/hw_tags.c:174
>  ____kasan_slab_free.constprop.0+0x184/0x1c0 mm/kasan/common.c:362
>  __kasan_slab_free+0x10/0x20 mm/kasan/common.c:369
>  kasan_slab_free include/linux/kasan.h:192 [inline]
>  slab_free_hook mm/slub.c:1547 [inline]
>  slab_free_freelist_hook+0x98/0x18c mm/slub.c:1580
>  slab_free mm/slub.c:3143 [inline]
>  kfree+0x324/0x4a0 mm/slub.c:4139
>  kvfree+0x3c/0x50 mm/util.c:616
>  netdev_freemem+0x18/0x2c net/core/dev.c:10500
>  netdev_release+0x30/0x44 net/core/net-sysfs.c:1828
>  device_release+0x34/0x90 drivers/base/core.c:1980
>  kobject_cleanup lib/kobject.c:705 [inline]
>  kobject_release lib/kobject.c:736 [inline]
>  kref_put include/linux/kref.h:65 [inline]
>  kobject_put+0x74/0x120 lib/kobject.c:753
>  netdev_run_todo+0x2d0/0x37c net/core/dev.c:10356
>  rtnl_unlock+0x10/0x20 net/core/rtnetlink.c:112
>  default_device_exit_batch+0x168/0x1a0 net/core/dev.c:11220
>  ops_exit_list+0x64/0x80 net/core/net_namespace.c:190
>  cleanup_net+0x23c/0x410 net/core/net_namespace.c:604
>  process_one_work+0x1d8/0x360 kernel/workqueue.c:2275
>  worker_thread+0x70/0x434 kernel/workqueue.c:2421
>  kthread+0x174/0x180 kernel/kthread.c:292
>  ret_from_fork+0x10/0x34 arch/arm64/kernel/entry.S:958
> 
> The buggy address belongs to the object at ffff0000275dc000
>  which belongs to the cache kmalloc-4k of size 4096
> The buggy address is located 3488 bytes inside of
>  4096-byte region [ffff0000275dc000, ffff0000275dd000)
> The buggy address belongs to the page:
> page:0000000040a3fc39 refcount:1 mapcount:0 mapping:0000000000000000 index:0xf4ff0000275dc000 pfn:0x675d8
> head:0000000040a3fc39 order:3 compound_mapcount:0 compound_pincount:0
> flags: 0x1ffffc000010200(slab|head)
> raw: 01ffffc000010200 fffffc00009cb208 fffffc00009ce808 f5ff000004801900
> raw: f4ff0000275dc000 0000000000040001 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff0000275dcb00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>  ffff0000275dcc00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> >ffff0000275dcd00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>                                                  ^
>  ffff0000275dce00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>  ffff0000275dcf00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> ==================================================================
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

