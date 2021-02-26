Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6EA3326939
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 22:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhBZVJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 16:09:18 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:39636 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhBZVJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 16:09:02 -0500
Received: by mail-io1-f72.google.com with SMTP id k21so8220161iow.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 13:08:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=NwnN1KK3UdmJxJrpb1qBF1aXpXkcOBmPI9/iDq75Pqs=;
        b=heZsDqNYN1CBwzfQvsPck51JOHCk6YRNZeBWO8Ix8TBxvtbWa+qtaRMEvVL5mNNzR2
         7tdNIMpx09N2vbRhRourEPCHZk1LU6LZD9vYvl7uSmzgcCaEH2+tdVo57ozA03HSVrFZ
         rpy7hoj4xVKYpdiH5h8ECiy+qsKzPV+FMyk7Ryvv9OzE0ajbgY7JkqyUI+IEMGHu46L4
         Up8TY2bZVCGrOfM5apKMUKZIht9otE2bLEY17AYwA+ASToLCSxDC8C04sd5oHFNB3UNQ
         53d9JnNv4ak9sXzDlu96N2WxeBwWU5rQMXTxKM/0kCkkTn/wjN2DuTUQJN6Oj67o5ra+
         MUnw==
X-Gm-Message-State: AOAM533kKA7qwcgCwdmKF5rRs9WW3GropTI8vyU05g723c/ONuIFjN/z
        HzmaSHN4RJzWqw8AWLV11JOvyzaQN7u26P2InxZT/2bmWpYC
X-Google-Smtp-Source: ABdhPJyzDj6/jHg4ETUJuL1jKOtTp/Y4HUmc7+ww0BvWUyTfo2QTzX3aXOKeOelh7OlFGwS38fbm7vaMR6BLa3EDDszzzvPL6guD
MIME-Version: 1.0
X-Received: by 2002:a92:3312:: with SMTP id a18mr4144236ilf.297.1614373700352;
 Fri, 26 Feb 2021 13:08:20 -0800 (PST)
Date:   Fri, 26 Feb 2021 13:08:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f1c03b05bc43aadc@google.com>
Subject: possible deadlock in sk_clone_lock
From:   syzbot <syzbot+506c8a2a115201881d45@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mike.kravetz@oracle.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    577c2835 Add linux-next specific files for 20210224
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=137cef82d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e9bb3d369b3bf49
dashboard link: https://syzkaller.appspot.com/bug?extid=506c8a2a115201881d45

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+506c8a2a115201881d45@syzkaller.appspotmail.com

=====================================================
WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
5.11.0-next-20210224-syzkaller #0 Not tainted
-----------------------------------------------------
syz-executor.3/15411 [HC0[0]:SC0[2]:HE1:SE0] is trying to acquire:
ffffffff8c0a0e18 (hugetlb_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:354 [inline]
ffffffff8c0a0e18 (hugetlb_lock){+.+.}-{2:2}, at: __free_huge_page+0x4cd/0xc10 mm/hugetlb.c:1390

and this task is already holding:
ffff88802391c720 (slock-AF_INET){+.-.}-{2:2}, at: spin_lock include/linux/spinlock.h:354 [inline]
ffff88802391c720 (slock-AF_INET){+.-.}-{2:2}, at: __tcp_close+0x6d9/0x1170 net/ipv4/tcp.c:2788
which would create a new lock dependency:
 (slock-AF_INET){+.-.}-{2:2} -> (hugetlb_lock){+.+.}-{2:2}

but this new dependency connects a SOFTIRQ-irq-safe lock:
 (slock-AF_INET){+.-.}-{2:2}

... which became SOFTIRQ-irq-safe at:
  lock_acquire kernel/locking/lockdep.c:5510 [inline]
  lock_acquire+0x1ab/0x730 kernel/locking/lockdep.c:5475
  __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
  _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
  spin_lock include/linux/spinlock.h:354 [inline]
  sk_clone_lock+0x296/0x1070 net/core/sock.c:1913
  inet_csk_clone_lock+0x21/0x4c0 net/ipv4/inet_connection_sock.c:830
  tcp_create_openreq_child+0x30/0x16d0 net/ipv4/tcp_minisocks.c:460
  tcp_v4_syn_recv_sock+0x10c/0x1460 net/ipv4/tcp_ipv4.c:1526
  tcp_check_req+0x616/0x1860 net/ipv4/tcp_minisocks.c:772
  tcp_v4_rcv+0x221a/0x3780 net/ipv4/tcp_ipv4.c:2001
  ip_protocol_deliver_rcu+0x5c/0x8a0 net/ipv4/ip_input.c:204
  ip_local_deliver_finish+0x20a/0x370 net/ipv4/ip_input.c:231
  NF_HOOK include/linux/netfilter.h:301 [inline]
  NF_HOOK include/linux/netfilter.h:295 [inline]
  ip_local_deliver+0x1b3/0x200 net/ipv4/ip_input.c:252
  dst_input include/net/dst.h:458 [inline]
  ip_sublist_rcv_finish+0x9a/0x2c0 net/ipv4/ip_input.c:551
  ip_list_rcv_finish.constprop.0+0x514/0x6e0 net/ipv4/ip_input.c:601
  ip_sublist_rcv net/ipv4/ip_input.c:609 [inline]
  ip_list_rcv+0x34e/0x490 net/ipv4/ip_input.c:644
  __netif_receive_skb_list_ptype net/core/dev.c:5408 [inline]
  __netif_receive_skb_list_core+0x549/0x8e0 net/core/dev.c:5456
  __netif_receive_skb_list net/core/dev.c:5508 [inline]
  netif_receive_skb_list_internal+0x777/0xd70 net/core/dev.c:5618
  gro_normal_list net/core/dev.c:5772 [inline]
  gro_normal_list net/core/dev.c:5768 [inline]
  napi_complete_done+0x1f1/0x820 net/core/dev.c:6474
  virtqueue_napi_complete+0x2c/0xc0 drivers/net/virtio_net.c:334
  virtnet_poll+0xae2/0xd90 drivers/net/virtio_net.c:1455
  __napi_poll+0xaf/0x440 net/core/dev.c:6892
  napi_poll net/core/dev.c:6959 [inline]
  net_rx_action+0x801/0xb40 net/core/dev.c:7036
  __do_softirq+0x29b/0x9f6 kernel/softirq.c:345
  invoke_softirq kernel/softirq.c:221 [inline]
  __irq_exit_rcu kernel/softirq.c:422 [inline]
  irq_exit_rcu+0x134/0x200 kernel/softirq.c:434
  common_interrupt+0xa4/0xd0 arch/x86/kernel/irq.c:240
  asm_common_interrupt+0x1e/0x40 arch/x86/include/asm/idtentry.h:623
  tomoyo_domain_quota_is_ok+0x2f1/0x550 security/tomoyo/util.c:1093
  tomoyo_supervisor+0x2f2/0xf00 security/tomoyo/common.c:2089
  tomoyo_audit_path_log security/tomoyo/file.c:168 [inline]
  tomoyo_path_permission security/tomoyo/file.c:587 [inline]
  tomoyo_path_permission+0x270/0x3a0 security/tomoyo/file.c:573
  tomoyo_path_perm+0x39e/0x400 security/tomoyo/file.c:838
  tomoyo_path_symlink+0x94/0xe0 security/tomoyo/tomoyo.c:200
  security_path_symlink+0xdf/0x150 security/security.c:1119
  do_symlinkat+0x123/0x300 fs/namei.c:4201
  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
  entry_SYSCALL_64_after_hwframe+0x44/0xae

to a SOFTIRQ-irq-unsafe lock:
 (hugetlb_lock){+.+.}-{2:2}

... which became SOFTIRQ-irq-unsafe at:
...
  lock_acquire kernel/locking/lockdep.c:5510 [inline]
  lock_acquire+0x1ab/0x730 kernel/locking/lockdep.c:5475
  __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
  _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
  spin_lock include/linux/spinlock.h:354 [inline]
  hugetlb_overcommit_handler+0x260/0x3e0 mm/hugetlb.c:3448
  proc_sys_call_handler+0x336/0x610 fs/proc/proc_sysctl.c:591
  call_write_iter include/linux/fs.h:1977 [inline]
  new_sync_write+0x426/0x650 fs/read_write.c:519
  vfs_write+0x796/0xa30 fs/read_write.c:606
  ksys_write+0x12d/0x250 fs/read_write.c:659
  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
  entry_SYSCALL_64_after_hwframe+0x44/0xae

other info that might help us debug this:

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(hugetlb_lock);
                               local_irq_disable();
                               lock(slock-AF_INET);
                               lock(hugetlb_lock);
  <Interrupt>
    lock(slock-AF_INET);

 *** DEADLOCK ***

3 locks held by syz-executor.3/15411:
 #0: ffff88802a56a190 (&sb->s_type->i_mutex_key#13){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #0: ffff88802a56a190 (&sb->s_type->i_mutex_key#13){+.+.}-{3:3}, at: __sock_release+0x86/0x280 net/socket.c:598
 #1: ffff88802391c7a0 (sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1600 [inline]
 #1: ffff88802391c7a0 (sk_lock-AF_INET){+.+.}-{0:0}, at: tcp_close+0x1e/0xc0 net/ipv4/tcp.c:2866
 #2: ffff88802391c720 (slock-AF_INET){+.-.}-{2:2}, at: spin_lock include/linux/spinlock.h:354 [inline]
 #2: ffff88802391c720 (slock-AF_INET){+.-.}-{2:2}, at: __tcp_close+0x6d9/0x1170 net/ipv4/tcp.c:2788

the dependencies between SOFTIRQ-irq-safe lock and the holding lock:
-> (slock-AF_INET){+.-.}-{2:2} {
   HARDIRQ-ON-W at:
                    lock_acquire kernel/locking/lockdep.c:5510 [inline]
                    lock_acquire+0x1ab/0x730 kernel/locking/lockdep.c:5475
                    __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
                    _raw_spin_lock_bh+0x2f/0x40 kernel/locking/spinlock.c:175
                    spin_lock_bh include/linux/spinlock.h:359 [inline]
                    lock_sock_nested+0x40/0x120 net/core/sock.c:3063
                    lock_sock include/net/sock.h:1600 [inline]
                    inet_autobind+0x1a/0x190 net/ipv4/af_inet.c:180
                    inet_dgram_connect+0x1f5/0x2d0 net/ipv4/af_inet.c:578
                    __sys_connect_file+0x155/0x1a0 net/socket.c:1837
                    __sys_connect+0x161/0x190 net/socket.c:1854
                    __do_sys_connect net/socket.c:1864 [inline]
                    __se_sys_connect net/socket.c:1861 [inline]
                    __x64_sys_connect+0x6f/0xb0 net/socket.c:1861
                    do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
                    entry_SYSCALL_64_after_hwframe+0x44/0xae
   IN-SOFTIRQ-W at:
                    lock_acquire kernel/locking/lockdep.c:5510 [inline]
                    lock_acquire+0x1ab/0x730 kernel/locking/lockdep.c:5475
                    __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
                    _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
                    spin_lock include/linux/spinlock.h:354 [inline]
                    sk_clone_lock+0x296/0x1070 net/core/sock.c:1913
                    inet_csk_clone_lock+0x21/0x4c0 net/ipv4/inet_connection_sock.c:830
                    tcp_create_openreq_child+0x30/0x16d0 net/ipv4/tcp_minisocks.c:460
                    tcp_v4_syn_recv_sock+0x10c/0x1460 net/ipv4/tcp_ipv4.c:1526
                    tcp_check_req+0x616/0x1860 net/ipv4/tcp_minisocks.c:772
                    tcp_v4_rcv+0x221a/0x3780 net/ipv4/tcp_ipv4.c:2001
                    ip_protocol_deliver_rcu+0x5c/0x8a0 net/ipv4/ip_input.c:204
                    ip_local_deliver_finish+0x20a/0x370 net/ipv4/ip_input.c:231
                    NF_HOOK include/linux/netfilter.h:301 [inline]
                    NF_HOOK include/linux/netfilter.h:295 [inline]
                    ip_local_deliver+0x1b3/0x200 net/ipv4/ip_input.c:252
                    dst_input include/net/dst.h:458 [inline]
                    ip_sublist_rcv_finish+0x9a/0x2c0 net/ipv4/ip_input.c:551
                    ip_list_rcv_finish.constprop.0+0x514/0x6e0 net/ipv4/ip_input.c:601
                    ip_sublist_rcv net/ipv4/ip_input.c:609 [inline]
                    ip_list_rcv+0x34e/0x490 net/ipv4/ip_input.c:644
                    __netif_receive_skb_list_ptype net/core/dev.c:5408 [inline]
                    __netif_receive_skb_list_core+0x549/0x8e0 net/core/dev.c:5456
                    __netif_receive_skb_list net/core/dev.c:5508 [inline]
                    netif_receive_skb_list_internal+0x777/0xd70 net/core/dev.c:5618
                    gro_normal_list net/core/dev.c:5772 [inline]
                    gro_normal_list net/core/dev.c:5768 [inline]
                    napi_complete_done+0x1f1/0x820 net/core/dev.c:6474
                    virtqueue_napi_complete+0x2c/0xc0 drivers/net/virtio_net.c:334
                    virtnet_poll+0xae2/0xd90 drivers/net/virtio_net.c:1455
                    __napi_poll+0xaf/0x440 net/core/dev.c:6892
                    napi_poll net/core/dev.c:6959 [inline]
                    net_rx_action+0x801/0xb40 net/core/dev.c:7036
                    __do_softirq+0x29b/0x9f6 kernel/softirq.c:345
                    invoke_softirq kernel/softirq.c:221 [inline]
                    __irq_exit_rcu kernel/softirq.c:422 [inline]
                    irq_exit_rcu+0x134/0x200 kernel/softirq.c:434
                    common_interrupt+0xa4/0xd0 arch/x86/kernel/irq.c:240
                    asm_common_interrupt+0x1e/0x40 arch/x86/include/asm/idtentry.h:623
                    tomoyo_domain_quota_is_ok+0x2f1/0x550 security/tomoyo/util.c:1093
                    tomoyo_supervisor+0x2f2/0xf00 security/tomoyo/common.c:2089
                    tomoyo_audit_path_log security/tomoyo/file.c:168 [inline]
                    tomoyo_path_permission security/tomoyo/file.c:587 [inline]
                    tomoyo_path_permission+0x270/0x3a0 security/tomoyo/file.c:573
                    tomoyo_path_perm+0x39e/0x400 security/tomoyo/file.c:838
                    tomoyo_path_symlink+0x94/0xe0 security/tomoyo/tomoyo.c:200
                    security_path_symlink+0xdf/0x150 security/security.c:1119
                    do_symlinkat+0x123/0x300 fs/namei.c:4201
                    do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
                    entry_SYSCALL_64_after_hwframe+0x44/0xae
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5510 [inline]
                   lock_acquire+0x1ab/0x730 kernel/locking/lockdep.c:5475
                   __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
                   _raw_spin_lock_bh+0x2f/0x40 kernel/locking/spinlock.c:175
                   spin_lock_bh include/linux/spinlock.h:359 [inline]
                   lock_sock_nested+0x40/0x120 net/core/sock.c:3063
                   lock_sock include/net/sock.h:1600 [inline]
                   inet_autobind+0x1a/0x190 net/ipv4/af_inet.c:180
                   inet_dgram_connect+0x1f5/0x2d0 net/ipv4/af_inet.c:578
                   __sys_connect_file+0x155/0x1a0 net/socket.c:1837
                   __sys_connect+0x161/0x190 net/socket.c:1854
                   __do_sys_connect net/socket.c:1864 [inline]
                   __se_sys_connect net/socket.c:1861 [inline]
                   __x64_sys_connect+0x6f/0xb0 net/socket.c:1861
                   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
                   entry_SYSCALL_64_after_hwframe+0x44/0xae
 }
 ... key      at: [<ffffffff901df860>] af_family_slock_keys+0x20/0x300
 ... acquired at:
   lock_acquire kernel/locking/lockdep.c:5510 [inline]
   lock_acquire+0x1ab/0x730 kernel/locking/lockdep.c:5475
   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
   _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
   spin_lock include/linux/spinlock.h:354 [inline]
   __free_huge_page+0x4cd/0xc10 mm/hugetlb.c:1390
   free_huge_page+0x31/0xb0 mm/hugetlb.c:1461
   __put_page+0xf7/0x3e0 mm/swap.c:126
   put_page include/linux/mm.h:1219 [inline]
   __skb_frag_unref include/linux/skbuff.h:3085 [inline]
   skb_release_data+0x465/0x750 net/core/skbuff.c:666
   skb_release_all net/core/skbuff.c:725 [inline]
   __kfree_skb+0x46/0x60 net/core/skbuff.c:739
   sk_wmem_free_skb include/net/sock.h:1558 [inline]
   tcp_rtx_queue_purge net/ipv4/tcp.c:2895 [inline]
   tcp_write_queue_purge+0x44c/0x1250 net/ipv4/tcp.c:2908
   tcp_v4_destroy_sock+0xf2/0x780 net/ipv4/tcp_ipv4.c:2219
   inet_csk_destroy_sock+0x196/0x490 net/ipv4/inet_connection_sock.c:884
   __tcp_close+0xd3e/0x1170 net/ipv4/tcp.c:2855
   tcp_close+0x29/0xc0 net/ipv4/tcp.c:2867
   inet_release+0x12e/0x280 net/ipv4/af_inet.c:431
   __sock_release+0xcd/0x280 net/socket.c:599
   sock_close+0x18/0x20 net/socket.c:1258
   __fput+0x288/0x920 fs/file_table.c:280
   task_work_run+0xdd/0x1a0 kernel/task_work.c:140
   get_signal+0x1c89/0x2100 kernel/signal.c:2554
   arch_do_signal_or_restart+0x2a8/0x1eb0 arch/x86/kernel/signal.c:811
   handle_signal_work kernel/entry/common.c:147 [inline]
   exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
   exit_to_user_mode_prepare+0x148/0x250 kernel/entry/common.c:208
   __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
   syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:301
   entry_SYSCALL_64_after_hwframe+0x44/0xae


the dependencies between the lock to be acquired
 and SOFTIRQ-irq-unsafe lock:
-> (hugetlb_lock){+.+.}-{2:2} {
   HARDIRQ-ON-W at:
                    lock_acquire kernel/locking/lockdep.c:5510 [inline]
                    lock_acquire+0x1ab/0x730 kernel/locking/lockdep.c:5475
                    __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
                    _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
                    spin_lock include/linux/spinlock.h:354 [inline]
                    hugetlb_overcommit_handler+0x260/0x3e0 mm/hugetlb.c:3448
                    proc_sys_call_handler+0x336/0x610 fs/proc/proc_sysctl.c:591
                    call_write_iter include/linux/fs.h:1977 [inline]
                    new_sync_write+0x426/0x650 fs/read_write.c:519
                    vfs_write+0x796/0xa30 fs/read_write.c:606
                    ksys_write+0x12d/0x250 fs/read_write.c:659
                    do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
                    entry_SYSCALL_64_after_hwframe+0x44/0xae
   SOFTIRQ-ON-W at:
                    lock_acquire kernel/locking/lockdep.c:5510 [inline]
                    lock_acquire+0x1ab/0x730 kernel/locking/lockdep.c:5475
                    __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
                    _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
                    spin_lock include/linux/spinlock.h:354 [inline]
                    hugetlb_overcommit_handler+0x260/0x3e0 mm/hugetlb.c:3448
                    proc_sys_call_handler+0x336/0x610 fs/proc/proc_sysctl.c:591
                    call_write_iter include/linux/fs.h:1977 [inline]
                    new_sync_write+0x426/0x650 fs/read_write.c:519
                    vfs_write+0x796/0xa30 fs/read_write.c:606
                    ksys_write+0x12d/0x250 fs/read_write.c:659
                    do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
                    entry_SYSCALL_64_after_hwframe+0x44/0xae
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5510 [inline]
                   lock_acquire+0x1ab/0x730 kernel/locking/lockdep.c:5475
                   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
                   _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
                   spin_lock include/linux/spinlock.h:354 [inline]
                   hugetlb_overcommit_handler+0x260/0x3e0 mm/hugetlb.c:3448
                   proc_sys_call_handler+0x336/0x610 fs/proc/proc_sysctl.c:591
                   call_write_iter include/linux/fs.h:1977 [inline]
                   new_sync_write+0x426/0x650 fs/read_write.c:519
                   vfs_write+0x796/0xa30 fs/read_write.c:606
                   ksys_write+0x12d/0x250 fs/read_write.c:659
                   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
                   entry_SYSCALL_64_after_hwframe+0x44/0xae
 }
 ... key      at: [<ffffffff8c0a0e18>] hugetlb_lock+0x18/0x4240
 ... acquired at:
   lock_acquire kernel/locking/lockdep.c:5510 [inline]
   lock_acquire+0x1ab/0x730 kernel/locking/lockdep.c:5475
   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
   _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
   spin_lock include/linux/spinlock.h:354 [inline]
   __free_huge_page+0x4cd/0xc10 mm/hugetlb.c:1390
   free_huge_page+0x31/0xb0 mm/hugetlb.c:1461
   __put_page+0xf7/0x3e0 mm/swap.c:126
   put_page include/linux/mm.h:1219 [inline]
   __skb_frag_unref include/linux/skbuff.h:3085 [inline]
   skb_release_data+0x465/0x750 net/core/skbuff.c:666
   skb_release_all net/core/skbuff.c:725 [inline]
   __kfree_skb+0x46/0x60 net/core/skbuff.c:739
   sk_wmem_free_skb include/net/sock.h:1558 [inline]
   tcp_rtx_queue_purge net/ipv4/tcp.c:2895 [inline]
   tcp_write_queue_purge+0x44c/0x1250 net/ipv4/tcp.c:2908
   tcp_v4_destroy_sock+0xf2/0x780 net/ipv4/tcp_ipv4.c:2219
   inet_csk_destroy_sock+0x196/0x490 net/ipv4/inet_connection_sock.c:884
   __tcp_close+0xd3e/0x1170 net/ipv4/tcp.c:2855
   tcp_close+0x29/0xc0 net/ipv4/tcp.c:2867
   inet_release+0x12e/0x280 net/ipv4/af_inet.c:431
   __sock_release+0xcd/0x280 net/socket.c:599
   sock_close+0x18/0x20 net/socket.c:1258
   __fput+0x288/0x920 fs/file_table.c:280
   task_work_run+0xdd/0x1a0 kernel/task_work.c:140
   get_signal+0x1c89/0x2100 kernel/signal.c:2554
   arch_do_signal_or_restart+0x2a8/0x1eb0 arch/x86/kernel/signal.c:811
   handle_signal_work kernel/entry/common.c:147 [inline]
   exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
   exit_to_user_mode_prepare+0x148/0x250 kernel/entry/common.c:208
   __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
   syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:301
   entry_SYSCALL_64_after_hwframe+0x44/0xae


stack backtrace:
CPU: 0 PID: 15411 Comm: syz-executor.3 Not tainted 5.11.0-next-20210224-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0xfa/0x151 lib/dump_stack.c:120
 print_bad_irq_dependency kernel/locking/lockdep.c:2460 [inline]
 check_irq_usage.cold+0x50d/0x744 kernel/locking/lockdep.c:2689
 check_prev_add kernel/locking/lockdep.c:2940 [inline]
 check_prevs_add kernel/locking/lockdep.c:3059 [inline]
 validate_chain kernel/locking/lockdep.c:3674 [inline]
 __lock_acquire+0x2b2c/0x54c0 kernel/locking/lockdep.c:4900
 lock_acquire kernel/locking/lockdep.c:5510 [inline]
 lock_acquire+0x1ab/0x730 kernel/locking/lockdep.c:5475
 __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
 spin_lock include/linux/spinlock.h:354 [inline]
 __free_huge_page+0x4cd/0xc10 mm/hugetlb.c:1390
 free_huge_page+0x31/0xb0 mm/hugetlb.c:1461
 __put_page+0xf7/0x3e0 mm/swap.c:126
 put_page include/linux/mm.h:1219 [inline]
 __skb_frag_unref include/linux/skbuff.h:3085 [inline]
 skb_release_data+0x465/0x750 net/core/skbuff.c:666
 skb_release_all net/core/skbuff.c:725 [inline]
 __kfree_skb+0x46/0x60 net/core/skbuff.c:739
 sk_wmem_free_skb include/net/sock.h:1558 [inline]
 tcp_rtx_queue_purge net/ipv4/tcp.c:2895 [inline]
 tcp_write_queue_purge+0x44c/0x1250 net/ipv4/tcp.c:2908
 tcp_v4_destroy_sock+0xf2/0x780 net/ipv4/tcp_ipv4.c:2219
 inet_csk_destroy_sock+0x196/0x490 net/ipv4/inet_connection_sock.c:884
 __tcp_close+0xd3e/0x1170 net/ipv4/tcp.c:2855
 tcp_close+0x29/0xc0 net/ipv4/tcp.c:2867
 inet_release+0x12e/0x280 net/ipv4/af_inet.c:431
 __sock_release+0xcd/0x280 net/socket.c:599
 sock_close+0x18/0x20 net/socket.c:1258
 __fput+0x288/0x920 fs/file_table.c:280
 task_work_run+0xdd/0x1a0 kernel/task_work.c:140
 get_signal+0x1c89/0x2100 kernel/signal.c:2554
 arch_do_signal_or_restart+0x2a8/0x1eb0 arch/x86/kernel/signal.c:811
 handle_signal_work kernel/entry/common.c:147 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x148/0x250 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:301
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x465ef9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbfc748c188 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: 0000000000005cd9 RBX: 000000000056bf60 RCX: 0000000000465ef9
RDX: ffffffffffffffd0 RSI: 0000000020000140 RDI: 0000000000000003
RBP: 00000000004bcd1c R08: 0000000000000000 R09: ffffffffffffff36
R10: 000000000401c005 R11: 0000000000000246 R12: 000000000056bf60
R13: 00007ffde63b79bf R14: 00007fbfc748c300 R15: 0000000000022000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
