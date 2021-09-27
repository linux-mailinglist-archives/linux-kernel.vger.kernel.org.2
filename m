Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A511741927F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 12:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbhI0KvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 06:51:00 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:36397 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbhI0Ku6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 06:50:58 -0400
Received: by mail-il1-f200.google.com with SMTP id l15-20020a92700f000000b0024a1248ff32so18582641ilc.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 03:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=x4+YkpqNJDYyhaS0HcnzSkHslBSWmpwL9xY3nnPJJag=;
        b=UVPwdW/Rb2FGcS3/6VX9z3ii1BR+q5d2WX5e4pOt19hq6A6uJy+/BMwbd6LMgGdkPU
         +89kvVkgMZEgyJOWITf8DlV1iqz0cIUnybIy6cUaulhcARCHXAXxWFyVwGRRI80f4udl
         hl2LgEvbb7zu48pzllismF9pXlEgX9hZK2PUDNS2Ks4VSV3c5pWG484TdqQ03cqkUAX2
         sjBJPRzwnwkD87Dw/E7SuFzfaW5FJ3mwxqJ/oDf4ms11pR97nJqgtSO7/0sAvh4kinml
         LCrGTOL3z4dKOHViNtAFxYLoy3VyfkZ34uzrrNTpcvhjhlcAmZFSpiB94TRY894ucc2j
         4o/w==
X-Gm-Message-State: AOAM5336tQH2YBfZRqj1U+Y8JD4IeS3ieKw56+GCSOkKfzKj7yhKLMWs
        opEEd+eCLOdjm3Ru+KE/bT0mxvh/1GHQ4QJXosUMmcKGhGuz
X-Google-Smtp-Source: ABdhPJxi1ZrH8pe0eztiwLdEFI1fxbGy0UOxSK/d/9+XNLtBM+VdIN2mDc6NeNekoJRJqqX1calg7Wzj13XLxUsPDKbUuV1lU9sQ
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2168:: with SMTP id s8mr10779146ilv.85.1632739760316;
 Mon, 27 Sep 2021 03:49:20 -0700 (PDT)
Date:   Mon, 27 Sep 2021 03:49:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006ca41905ccf7d916@google.com>
Subject: [syzbot] inconsistent lock state in kmem_cache_alloc_node
From:   syzbot <syzbot+8ba4cbe1e74ba30dc91d@syzkaller.appspotmail.com>
To:     ahalaney@redhat.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    58e2cf5d7946 init: Revert accidental changes to print irqs..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=120f3780b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=83fd90919369058f
dashboard link: https://syzkaller.appspot.com/bug?extid=8ba4cbe1e74ba30dc91d
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8ba4cbe1e74ba30dc91d@syzkaller.appspotmail.com

================================
WARNING: inconsistent lock state
5.15.0-rc2-syzkaller #0 Not tainted
--------------------------------
inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
ksoftirqd/1/19 [HC0[0]:SC1[3]:HE1:SE0] takes:
ffffffff8c9dd960 (fs_reclaim){+.?.}-{0:0}, at: might_alloc include/linux/sched/mm.h:198 [inline]
ffffffff8c9dd960 (fs_reclaim){+.?.}-{0:0}, at: slab_pre_alloc_hook mm/slab.h:492 [inline]
ffffffff8c9dd960 (fs_reclaim){+.?.}-{0:0}, at: slab_alloc_node mm/slub.c:3120 [inline]
ffffffff8c9dd960 (fs_reclaim){+.?.}-{0:0}, at: kmem_cache_alloc_node+0x46/0x340 mm/slub.c:3242
{SOFTIRQ-ON-W} state was registered at:
  lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5625
  __fs_reclaim_acquire mm/page_alloc.c:4539 [inline]
  fs_reclaim_acquire+0x77/0x110 mm/page_alloc.c:4553
  might_alloc include/linux/sched/mm.h:198 [inline]
  slab_pre_alloc_hook mm/slab.h:492 [inline]
  slab_alloc_node mm/slub.c:3120 [inline]
  slab_alloc mm/slub.c:3214 [inline]
  kmem_cache_alloc_trace+0x42/0x310 mm/slub.c:3231
  kmalloc include/linux/slab.h:591 [inline]
  kzalloc include/linux/slab.h:721 [inline]
  alloc_workqueue_attrs kernel/workqueue.c:3395 [inline]
  wq_numa_init+0x122/0x49f kernel/workqueue.c:5942
  workqueue_init+0x18/0x7c7 kernel/workqueue.c:6069
  kernel_init_freeable+0x408/0x5c6 init/main.c:1598
  kernel_init+0x19/0x2a0 init/main.c:1505
  ret_from_fork+0x1f/0x30
irq event stamp: 4852124
hardirqs last  enabled at (4852124): [<ffffffff81cdd884>] kasan_quarantine_put+0xd4/0x230 mm/kasan/quarantine.c:220
hardirqs last disabled at (4852123): [<ffffffff81cdd7e9>] kasan_quarantine_put+0x39/0x230 mm/kasan/quarantine.c:193
softirqs last  enabled at (4851912): [<ffffffff814f6851>] run_ksoftirqd+0xc1/0x120 kernel/softirq.c:920
softirqs last disabled at (4851919): [<ffffffff814f6851>] run_ksoftirqd+0xc1/0x120 kernel/softirq.c:920

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(fs_reclaim);
  <Interrupt>
    lock(fs_reclaim);

 *** DEADLOCK ***

6 locks held by ksoftirqd/1/19:
 #0: ffffffff8c91c200 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x9/0x30 include/linux/rcupdate.h:267
 #1: ffffffff8c91c200 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x9/0x30 include/linux/rcupdate.h:267
 #2: ffffffff8c91c200 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x5/0x30 include/linux/rcupdate.h:266
 #3: ffffffff8c91c200 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x5/0x30 include/linux/rcupdate.h:266
 #4: ffff88806f912620 (k-slock-AF_INET6/1){+.-.}-{2:2}, at: tcp_v6_rcv+0x3317/0x4470 net/ipv6/tcp_ipv6.c:1753
 #5: ffff888074db2fa0 (slock-AF_INET6){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:368 [inline]
 #5: ffff888074db2fa0 (slock-AF_INET6){+.-.}-{2:2}, at: mptcp_incoming_options+0x3a8/0x1fb0 net/mptcp/options.c:1098

stack backtrace:
CPU: 1 PID: 19 Comm: ksoftirqd/1 Not tainted 5.15.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1dc/0x2d8 lib/dump_stack.c:106
 print_usage_bug+0xa6d/0xea0 kernel/locking/lockdep.c:3921
 mark_lock+0x168c/0x1e00 kernel/locking/lockdep.c:4593
 __lock_acquire+0xc36/0x2b00 kernel/locking/lockdep.c:4969
 lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5625
 __fs_reclaim_acquire mm/page_alloc.c:4539 [inline]
 fs_reclaim_acquire+0x77/0x110 mm/page_alloc.c:4553
 might_alloc include/linux/sched/mm.h:198 [inline]
 slab_pre_alloc_hook mm/slab.h:492 [inline]
 slab_alloc_node mm/slub.c:3120 [inline]
 kmem_cache_alloc_node+0x46/0x340 mm/slub.c:3242
 __alloc_skb+0xd8/0x580 net/core/skbuff.c:414
 alloc_skb_fclone include/linux/skbuff.h:1166 [inline]
 sk_stream_alloc_skb+0x1f4/0xb40 net/ipv4/tcp.c:887
 tcp_build_frag+0x268/0x1010 net/ipv4/tcp.c:980
 mptcp_sendmsg_frag+0x6a1/0x1570 net/mptcp/protocol.c:1349
 __mptcp_subflow_push_pending+0x289/0xa10 net/mptcp/protocol.c:1607
 mptcp_incoming_options+0x497/0x1fb0 net/mptcp/options.c:1100
 tcp_data_queue+0xf4/0x8430 net/ipv4/tcp_input.c:4982
 tcp_rcv_established+0x9f7/0x22b0 net/ipv4/tcp_input.c:5928
 tcp_v6_do_rcv+0x4a9/0x12d0 net/ipv6/tcp_ipv6.c:1517
 tcp_v6_rcv+0x36dc/0x4470 net/ipv6/tcp_ipv6.c:1759
 ip6_protocol_deliver_rcu+0x9a5/0x1310 net/ipv6/ip6_input.c:422
 ip6_input_finish net/ipv6/ip6_input.c:463 [inline]
 NF_HOOK include/linux/netfilter.h:307 [inline]
 ip6_input+0x10b/0x190 net/ipv6/ip6_input.c:472
 ip_sabotage_in+0x1a1/0x220 net/bridge/br_netfilter_hooks.c:873
 nf_hook_entry_hookfn include/linux/netfilter.h:142 [inline]
 nf_hook_slow+0xb2/0x1f0 net/netfilter/core.c:589
 nf_hook+0x235/0x3a0 include/linux/netfilter.h:262
 NF_HOOK include/linux/netfilter.h:305 [inline]
 ipv6_rcv+0x87/0xd0 net/ipv6/ip6_input.c:297
 __netif_receive_skb_one_core net/core/dev.c:5436 [inline]
 __netif_receive_skb+0x1d1/0x500 net/core/dev.c:5550
 netif_receive_skb_internal+0x108/0x360 net/core/dev.c:5636
 netif_receive_skb+0x19/0x30 net/core/dev.c:5695
 br_handle_frame_finish+0x139b/0x1940
 br_nf_hook_thresh+0x3db/0x4f0 net/bridge/br_netfilter_hooks.c:1025
 br_nf_pre_routing_finish_ipv6+0x942/0xbc0
 NF_HOOK include/linux/netfilter.h:307 [inline]
 br_nf_pre_routing_ipv6+0x294/0x340 net/bridge/br_netfilter_ipv6.c:236
 nf_hook_entry_hookfn include/linux/netfilter.h:142 [inline]
 nf_hook_bridge_pre net/bridge/br_input.c:230 [inline]
 br_handle_frame+0x875/0x1050 net/bridge/br_input.c:370
 __netif_receive_skb_core+0x14d8/0x3d10 net/core/dev.c:5330
 __netif_receive_skb_one_core net/core/dev.c:5434 [inline]
 __netif_receive_skb+0x120/0x500 net/core/dev.c:5550
 process_backlog+0x518/0x9a0 net/core/dev.c:6427
 __napi_poll+0xba/0x4f0 net/core/dev.c:6982
 napi_poll net/core/dev.c:7049 [inline]
 net_rx_action+0x61c/0xf30 net/core/dev.c:7136
 __do_softirq+0x392/0x7a3 kernel/softirq.c:558
 run_ksoftirqd+0xc1/0x120 kernel/softirq.c:920
 smpboot_thread_fn+0x533/0x9d0 kernel/smpboot.c:164
 kthread+0x453/0x480 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30
BUG: sleeping function called from invalid context at include/linux/sched/mm.h:201
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 19, name: ksoftirqd/1
INFO: lockdep is turned off.
Preemption disabled at:
[<ffffffff8a200113>] softirq_handle_begin kernel/softirq.c:396 [inline]
[<ffffffff8a200113>] __do_softirq+0x113/0x7a3 kernel/softirq.c:534
CPU: 1 PID: 19 Comm: ksoftirqd/1 Not tainted 5.15.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x201/0x2d8 lib/dump_stack.c:106
 ___might_sleep+0x533/0x690 kernel/sched/core.c:9538
 might_alloc include/linux/sched/mm.h:201 [inline]
 slab_pre_alloc_hook mm/slab.h:492 [inline]
 slab_alloc_node mm/slub.c:3120 [inline]
 kmem_cache_alloc_node+0x68/0x340 mm/slub.c:3242
 __alloc_skb+0xd8/0x580 net/core/skbuff.c:414
 alloc_skb_fclone include/linux/skbuff.h:1166 [inline]
 sk_stream_alloc_skb+0x1f4/0xb40 net/ipv4/tcp.c:887
 tcp_build_frag+0x268/0x1010 net/ipv4/tcp.c:980
 mptcp_sendmsg_frag+0x6a1/0x1570 net/mptcp/protocol.c:1349
 __mptcp_subflow_push_pending+0x289/0xa10 net/mptcp/protocol.c:1607
 mptcp_incoming_options+0x497/0x1fb0 net/mptcp/options.c:1100
 tcp_data_queue+0xf4/0x8430 net/ipv4/tcp_input.c:4982
 tcp_rcv_established+0x9f7/0x22b0 net/ipv4/tcp_input.c:5928
 tcp_v6_do_rcv+0x4a9/0x12d0 net/ipv6/tcp_ipv6.c:1517
 tcp_v6_rcv+0x36dc/0x4470 net/ipv6/tcp_ipv6.c:1759
 ip6_protocol_deliver_rcu+0x9a5/0x1310 net/ipv6/ip6_input.c:422
 ip6_input_finish net/ipv6/ip6_input.c:463 [inline]
 NF_HOOK include/linux/netfilter.h:307 [inline]
 ip6_input+0x10b/0x190 net/ipv6/ip6_input.c:472
 ip_sabotage_in+0x1a1/0x220 net/bridge/br_netfilter_hooks.c:873
 nf_hook_entry_hookfn include/linux/netfilter.h:142 [inline]
 nf_hook_slow+0xb2/0x1f0 net/netfilter/core.c:589
 nf_hook+0x235/0x3a0 include/linux/netfilter.h:262
 NF_HOOK include/linux/netfilter.h:305 [inline]
 ipv6_rcv+0x87/0xd0 net/ipv6/ip6_input.c:297
 __netif_receive_skb_one_core net/core/dev.c:5436 [inline]
 __netif_receive_skb+0x1d1/0x500 net/core/dev.c:5550
 netif_receive_skb_internal+0x108/0x360 net/core/dev.c:5636
 netif_receive_skb+0x19/0x30 net/core/dev.c:5695
 br_handle_frame_finish+0x139b/0x1940
 br_nf_hook_thresh+0x3db/0x4f0 net/bridge/br_netfilter_hooks.c:1025
 br_nf_pre_routing_finish_ipv6+0x942/0xbc0
 NF_HOOK include/linux/netfilter.h:307 [inline]
 br_nf_pre_routing_ipv6+0x294/0x340 net/bridge/br_netfilter_ipv6.c:236
 nf_hook_entry_hookfn include/linux/netfilter.h:142 [inline]
 nf_hook_bridge_pre net/bridge/br_input.c:230 [inline]
 br_handle_frame+0x875/0x1050 net/bridge/br_input.c:370
 __netif_receive_skb_core+0x14d8/0x3d10 net/core/dev.c:5330
 __netif_receive_skb_one_core net/core/dev.c:5434 [inline]
 __netif_receive_skb+0x120/0x500 net/core/dev.c:5550
 process_backlog+0x518/0x9a0 net/core/dev.c:6427
 __napi_poll+0xba/0x4f0 net/core/dev.c:6982
 napi_poll net/core/dev.c:7049 [inline]
 net_rx_action+0x61c/0xf30 net/core/dev.c:7136
 __do_softirq+0x392/0x7a3 kernel/softirq.c:558
 run_ksoftirqd+0xc1/0x120 kernel/softirq.c:920
 smpboot_thread_fn+0x533/0x9d0 kernel/smpboot.c:164
 kthread+0x453/0x480 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30
------------[ cut here ]------------
WARNING: CPU: 1 PID: 19 at net/mptcp/protocol.c:1366 mptcp_sendmsg_frag+0x707/0x1570
Modules linked in:
CPU: 1 PID: 19 Comm: ksoftirqd/1 Tainted: G        W         5.15.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:mptcp_sendmsg_frag+0x707/0x1570 net/mptcp/protocol.c:1366
Code: c0 0f 85 c3 07 00 00 41 0f b6 1c 24 83 e3 08 31 ff 89 de e8 3b d8 90 f7 84 db 0f 85 82 01 00 00 e8 5e d5 90 f7 4c 8b 64 24 30 <0f> 0b 41 bf ea ff ff ff e9 f6 0c 00 00 48 8b 4c 24 20 48 8d 99 50
RSP: 0018:ffffc90000d96160 EFLAGS: 00010246
RAX: ffffffff89f1a022 RBX: 0000000000000000 RCX: ffff888012475580
RDX: 0000000000000302 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90000d96290 R08: ffffffff89f1a015 R09: fffff940004482c7
R10: fffff940004482c7 R11: 0000000000000000 R12: 1ffff920001b2c40
R13: dffffc0000000000 R14: ffff88806c25a000 R15: ffff88806c25a000
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002001f000 CR3: 00000000147d3000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __mptcp_subflow_push_pending+0x289/0xa10 net/mptcp/protocol.c:1607
 mptcp_incoming_options+0x497/0x1fb0 net/mptcp/options.c:1100
 tcp_data_queue+0xf4/0x8430 net/ipv4/tcp_input.c:4982
 tcp_rcv_established+0x9f7/0x22b0 net/ipv4/tcp_input.c:5928
 tcp_v6_do_rcv+0x4a9/0x12d0 net/ipv6/tcp_ipv6.c:1517
 tcp_v6_rcv+0x36dc/0x4470 net/ipv6/tcp_ipv6.c:1759
 ip6_protocol_deliver_rcu+0x9a5/0x1310 net/ipv6/ip6_input.c:422
 ip6_input_finish net/ipv6/ip6_input.c:463 [inline]
 NF_HOOK include/linux/netfilter.h:307 [inline]
 ip6_input+0x10b/0x190 net/ipv6/ip6_input.c:472
 ip_sabotage_in+0x1a1/0x220 net/bridge/br_netfilter_hooks.c:873
 nf_hook_entry_hookfn include/linux/netfilter.h:142 [inline]
 nf_hook_slow+0xb2/0x1f0 net/netfilter/core.c:589
 nf_hook+0x235/0x3a0 include/linux/netfilter.h:262
 NF_HOOK include/linux/netfilter.h:305 [inline]
 ipv6_rcv+0x87/0xd0 net/ipv6/ip6_input.c:297
 __netif_receive_skb_one_core net/core/dev.c:5436 [inline]
 __netif_receive_skb+0x1d1/0x500 net/core/dev.c:5550
 netif_receive_skb_internal+0x108/0x360 net/core/dev.c:5636
 netif_receive_skb+0x19/0x30 net/core/dev.c:5695
 br_handle_frame_finish+0x139b/0x1940
 br_nf_hook_thresh+0x3db/0x4f0 net/bridge/br_netfilter_hooks.c:1025
 br_nf_pre_routing_finish_ipv6+0x942/0xbc0
 NF_HOOK include/linux/netfilter.h:307 [inline]
 br_nf_pre_routing_ipv6+0x294/0x340 net/bridge/br_netfilter_ipv6.c:236
 nf_hook_entry_hookfn include/linux/netfilter.h:142 [inline]
 nf_hook_bridge_pre net/bridge/br_input.c:230 [inline]
 br_handle_frame+0x875/0x1050 net/bridge/br_input.c:370
 __netif_receive_skb_core+0x14d8/0x3d10 net/core/dev.c:5330
 __netif_receive_skb_one_core net/core/dev.c:5434 [inline]
 __netif_receive_skb+0x120/0x500 net/core/dev.c:5550
 process_backlog+0x518/0x9a0 net/core/dev.c:6427
 __napi_poll+0xba/0x4f0 net/core/dev.c:6982
 napi_poll net/core/dev.c:7049 [inline]
 net_rx_action+0x61c/0xf30 net/core/dev.c:7136
 __do_softirq+0x392/0x7a3 kernel/softirq.c:558
 run_ksoftirqd+0xc1/0x120 kernel/softirq.c:920
 smpboot_thread_fn+0x533/0x9d0 kernel/smpboot.c:164
 kthread+0x453/0x480 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
