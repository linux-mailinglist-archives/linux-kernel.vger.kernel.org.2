Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F331363FAE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 12:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238660AbhDSKhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 06:37:02 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:38864 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhDSKgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 06:36:53 -0400
Received: by mail-io1-f69.google.com with SMTP id v1-20020a5d94810000b02903e0f4d732b4so9315159ioj.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 03:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=2x2a9idYIBZKxLcEE0QPTwaiMIrm1VbdlgTw5pxXk6U=;
        b=BZ99EBBsMLYbUitnhZEB8JMA43kLTJVHAL1whbOc+1LsF+GYzh+ZE4B27ksxuWLaXQ
         ce1lK1zAj9AK+swASjLeyQnPzjqlX0gr1TKxjtZWca+yb+RnWiN3N+mqX9DM4cZmR63w
         NdkYFJhtVGPyKKOsyZ0cBohko3S7rb8jzUr94x6WOT32Kxpb533I8YjQ+m2FBnI855Av
         F1pm09cx9iaXW/KByPmATeR1yMD0Kcr5XpAOkdAC7i8rKvX1dAlVSTjdWA1LMmnVddxE
         iChOyNUQo+7HPWhUevVZNSM96D/n1voQO6vzmdcAsQ/jT85tFXVkwefNWDDL0zlSHe2V
         wzbw==
X-Gm-Message-State: AOAM5317c5m6rb85I/HYbGBT3/fysl27yMJdLT8Nbv3B/smJWd01ltGa
        hEs4TbtzyN/LD2VUExHeEinSoK7T7VjLi4qZwps10g1Nhc1U
X-Google-Smtp-Source: ABdhPJyJfDq8mvsSpVtaw+j+hlBY9izsJOid6owoG0iNucJLB8HhH0X3WaJrW0hylYTZFLx12yEQVyHpAiiNwPVZFLdiem+e/3Ij
MIME-Version: 1.0
X-Received: by 2002:a5d:97cb:: with SMTP id k11mr14161390ios.204.1618828583115;
 Mon, 19 Apr 2021 03:36:23 -0700 (PDT)
Date:   Mon, 19 Apr 2021 03:36:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a61f7705c050e601@google.com>
Subject: [syzbot] WARNING in kthread_is_per_cpu
From:   syzbot <syzbot+9362b31a2e0cad8b749d@syzkaller.appspotmail.com>
To:     bp@alien8.de, dwmw@amazon.co.uk, hpa@zytor.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1216f02e Add linux-next specific files for 20210415
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1032ba29d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3491b04113499f81
dashboard link: https://syzkaller.appspot.com/bug?extid=9362b31a2e0cad8b749d

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9362b31a2e0cad8b749d@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 23550 at kernel/kthread.c:83 to_kthread kernel/kthread.c:83 [inline]
WARNING: CPU: 1 PID: 23550 at kernel/kthread.c:83 kthread_is_per_cpu+0xc4/0xf0 kernel/kthread.c:519
Modules linked in:
CPU: 1 PID: 23550 Comm: syz-executor.3 Not tainted 5.12.0-rc7-next-20210415-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:to_kthread kernel/kthread.c:83 [inline]
RIP: 0010:kthread_is_per_cpu+0xc4/0xf0 kernel/kthread.c:519
Code: 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 75 2e 4c 8b 23 41 83 e4 01 e8 89 d3 27 00 44 89 e0 5b 5d 41 5c c3 e8 7c d3 27 00 <0f> 0b eb 88 e8 33 90 6c 00 e9 68 ff ff ff e8 39 90 6c 00 eb 9a 48
RSP: 0018:ffffc90000dc0c08 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff88802533d580 RCX: 0000000000000100
RDX: ffff8880549bb900 RSI: ffffffff814ca4c4 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: ffff88802533d580
R10: ffffffff814ca44c R11: 00000000018a3b90 R12: 0000000000000001
R13: ffffc90000dc0d90 R14: 0000000000000001 R15: ffff88802533d580
FS:  00007f4be57d3700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2cd24000 CR3: 0000000024626000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 can_migrate_task+0x124/0x1630 kernel/sched/fair.c:7610
 detach_tasks kernel/sched/fair.c:7774 [inline]
 load_balance+0xc72/0x2730 kernel/sched/fair.c:9696
 rebalance_domains+0x668/0xda0 kernel/sched/fair.c:10075
 __do_softirq+0x29b/0x9fe kernel/softirq.c:559
 invoke_softirq kernel/softirq.c:433 [inline]
 __irq_exit_rcu+0x136/0x200 kernel/softirq.c:637
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1100
 </IRQ>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:632
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:161 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x38/0x70 kernel/locking/spinlock.c:191
Code: 74 24 10 e8 5a 05 46 f8 48 89 ef e8 f2 7d 46 f8 81 e3 00 02 00 00 75 25 9c 58 f6 c4 02 75 2d 48 85 db 74 01 fb bf 01 00 00 00 <e8> e3 83 3a f8 65 8b 05 cc e4 ed 76 85 c0 74 0a 5b 5d c3 e8 20 73
RSP: 0018:ffffc90001c0ef30 EFLAGS: 00000206
RAX: 0000000000000006 RBX: 0000000000000200 RCX: 1ffffffff1fbdad2
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000001
RBP: ffffffff8c076c20 R08: 0000000000000001 R09: ffffffff8fdeb8a7
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: 000000000000000c R14: 0000000000000002 R15: 000000000008f9b0
 spin_unlock_irqrestore include/linux/spinlock.h:414 [inline]
 pcpu_alloc+0x4f7/0x17a0 mm/percpu.c:1807
 vlan_dev_init+0x9f9/0xe70 net/8021q/vlan_dev.c:614
 register_netdevice+0x51e/0x1500 net/core/dev.c:10188
 register_vlan_dev+0x360/0x960 net/8021q/vlan.c:179
 vlan_newlink+0x477/0x700 net/8021q/vlan_netlink.c:187
 __rtnl_newlink+0x1062/0x1710 net/core/rtnetlink.c:3452
 rtnl_newlink+0x64/0xa0 net/core/rtnetlink.c:3500
 rtnetlink_rcv_msg+0x413/0xaf0 net/core/rtnetlink.c:5562
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2502
 netlink_unicast_kernel net/netlink/af_netlink.c:1312 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1338
 netlink_sendmsg+0x84c/0xd90 net/netlink/af_netlink.c:1927
 sock_sendmsg_nosec net/socket.c:654 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:674
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2350
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2404
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2433
 do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x466459
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4be57d3188 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 000000000056bf60 RCX: 0000000000466459
RDX: 0000000000000810 RSI: 0000000020000000 RDI: 0000000000000006
RBP: 00000000004bf9fb R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf60
R13: 00007ffc92da70af R14: 00007f4be57d3300 R15: 0000000000022000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
