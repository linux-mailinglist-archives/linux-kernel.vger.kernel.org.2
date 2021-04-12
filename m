Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC0C35CF77
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 19:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242676AbhDLR3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 13:29:35 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:40174 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241741AbhDLR3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 13:29:32 -0400
Received: by mail-io1-f70.google.com with SMTP id e18so9331138iot.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 10:29:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=y/CiVUvy6uLOM42UWLMPp90pstQwtyK2EBm8RiQ9ms8=;
        b=pj/E9qEEH7QPqHF1W31bTdMNwksJZW9qZb6d5U4XUlDU2OLzqf1BpgxKbqXOBJ+wvw
         qB4Y5QUkZ/SIFAnw9o2Lz5VRYC2gvYN38xzZt0LQ/mqiov1O4pq7jEXSxEKbD3dZNje6
         gscu5LvoWyaXGuKlkYhma3UeH7jTLgsOo0L76/ej6FIgn+JEziDmROQeNGwNl9Nf+M0+
         2U/IViqLqjV+FpbpUIGCZ8+F0TWOt2SZY+Azv6IgJJB9vVxD59TGAivF0l0AueEunpkb
         4HklxFthVemndEji3FK5WkQgjcOp2i6IGSl0RpbPegWgWM+U8dXlxAq4LjZVfQwh2Pzk
         HnBQ==
X-Gm-Message-State: AOAM531Y0ukZ3pzZjpOG+Vv303ybqylwiKbQq94n1UHGwWlLxNauSFXA
        KUxoI3uFrjEZKfDA3tQp2E26I36NdYQ/5rvTN7Gdp89kJ2UJ
X-Google-Smtp-Source: ABdhPJwl0uPJms4fc1fKN9AD5w30LkTu+zTCpCPOZlJGxpr4Q4DoozZ2pu9GG2IxWRhMK0UhfsZ9uKWqP3kf9kx2gygAlkVXG3/p
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a22:: with SMTP id g2mr24554686ile.231.1618248553865;
 Mon, 12 Apr 2021 10:29:13 -0700 (PDT)
Date:   Mon, 12 Apr 2021 10:29:13 -0700
In-Reply-To: <00000000000002b41905be665238@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000036298005bfc9da23@google.com>
Subject: Re: [syzbot] possible deadlock in vmci_qp_broker_detach
From:   syzbot <syzbot+44e40ac2cfe68e8ce207@syzkaller.appspotmail.com>
To:     alex.dewar90@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        hdanton@sina.com, jhansen@vmware.com, linux-kernel@vger.kernel.org,
        snovitoll@gmail.com, syzkaller-bugs@googlegroups.com,
        vdasa@vmware.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    d434405a Linux 5.12-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1661482ed00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c3d8981d2bdb103
dashboard link: https://syzkaller.appspot.com/bug?extid=44e40ac2cfe68e8ce207
compiler:       Debian clang version 11.0.1-2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102336a6d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+44e40ac2cfe68e8ce207@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
5.12.0-rc7-syzkaller #0 Not tainted
--------------------------------------------
syz-executor.0/10571 is trying to acquire lock:
ffffffff8ce6c1f8 (qp_broker_list.mutex){+.+.}-{3:3}, at: vmci_qp_broker_detach+0xd3/0x10c0 drivers/misc/vmw_vmci/vmci_queue_pair.c:2093

but task is already holding lock:
ffffffff8ce6c1f8 (qp_broker_list.mutex){+.+.}-{3:3}, at: vmci_qp_broker_detach+0xd3/0x10c0 drivers/misc/vmw_vmci/vmci_queue_pair.c:2093

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(qp_broker_list.mutex);
  lock(qp_broker_list.mutex);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

1 lock held by syz-executor.0/10571:
 #0: ffffffff8ce6c1f8 (qp_broker_list.mutex){+.+.}-{3:3}, at: vmci_qp_broker_detach+0xd3/0x10c0 drivers/misc/vmw_vmci/vmci_queue_pair.c:2093

stack backtrace:
CPU: 1 PID: 10571 Comm: syz-executor.0 Not tainted 5.12.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x176/0x24e lib/dump_stack.c:120
 __lock_acquire+0x2303/0x5e60 kernel/locking/lockdep.c:4739
 lock_acquire+0x126/0x650 kernel/locking/lockdep.c:5511
 __mutex_lock_common+0x167/0x2eb0 kernel/locking/mutex.c:949
 __mutex_lock kernel/locking/mutex.c:1096 [inline]
 mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:1111
 vmci_qp_broker_detach+0xd3/0x10c0 drivers/misc/vmw_vmci/vmci_queue_pair.c:2093
 ctx_free_ctx drivers/misc/vmw_vmci/vmci_context.c:444 [inline]
 kref_put include/linux/kref.h:65 [inline]
 vmci_ctx_put+0x722/0xe00 drivers/misc/vmw_vmci/vmci_context.c:497
 vmci_ctx_enqueue_datagram+0x3a7/0x440 drivers/misc/vmw_vmci/vmci_context.c:360
 dg_dispatch_as_host drivers/misc/vmw_vmci/vmci_datagram.c:275 [inline]
 vmci_datagram_dispatch+0x3ec/0xb40 drivers/misc/vmw_vmci/vmci_datagram.c:339
 qp_notify_peer drivers/misc/vmw_vmci/vmci_queue_pair.c:1479 [inline]
 vmci_qp_broker_detach+0x9fa/0x10c0 drivers/misc/vmw_vmci/vmci_queue_pair.c:2186
 ctx_free_ctx drivers/misc/vmw_vmci/vmci_context.c:444 [inline]
 kref_put include/linux/kref.h:65 [inline]
 vmci_ctx_put+0x722/0xe00 drivers/misc/vmw_vmci/vmci_context.c:497
 vmci_host_close+0x96/0x160 drivers/misc/vmw_vmci/vmci_host.c:143
 __fput+0x352/0x7b0 fs/file_table.c:280
 task_work_run+0x146/0x1c0 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x10b/0x1e0 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x26/0x70 kernel/entry/common.c:301
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x41926b
Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8 63 fc ff ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 a1 fc ff ff 8b 44
RSP: 002b:00007ffee76536f0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 000000000041926b
RDX: 0000000000570698 RSI: 0000000000000001 RDI: 0000000000000003
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000001b30e200a8
R10: 00007ffee76537e0 R11: 0000000000000293 R12: 00000000000688ea
R13: 00000000000003e8 R14: 000000000056bf60 R15: 00000000000688cf

