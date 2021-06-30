Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6411A3B879E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 19:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbhF3RX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 13:23:56 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:51149 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhF3RXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 13:23:55 -0400
Received: by mail-il1-f198.google.com with SMTP id f7-20020a92c7a70000b02901ee10b89a7fso2380161ilk.17
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 10:21:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0MCROCOJFuzpUd/PNOloy1xDKZzGHt5w9gFeLFd1IOM=;
        b=W0ncuMgmvhoOfXBTOWOyU0WlG+BrEKJB9QdAKPDKT4gc99p0R+aMPTLG7JorikffwX
         17hL+t1HQhQM6O9LuRG/m2mb7A5z1wnBTaTw/pTMHh+v6Hxpv755gQvIq97GsJNPPOGU
         xu5kYwcxrMIi+EIKp4IGTVs/3PzrXRQQxUMnke5/yn1lkek4jZ9VxZ7g7QkhVM19M4vS
         orE1rYoa+We9B8CF+8bgjGw1uEFabIC7iX5l3iojHZfs6Lm+F9CKgS33F0k0iz+mQyzy
         OO01hM88Y3hGUOC3LPCwTNYYOHAXqCWRGwtM/yMQ81yAKJW7hZtR46BYGN4Um6xz1OVD
         s2sQ==
X-Gm-Message-State: AOAM532n7LIMkVGCrZS/TWpb9FENMIALiW4+k8VWbVNG8JWHsoQlrkLx
        O0RdCXizT/Q4cKSXNCQK5PgreTq5TI26HM3M5SNtkMvvkfSp
X-Google-Smtp-Source: ABdhPJzYA1+QCIsIve+FBZJCBngYTJw85MK7zyuRBr8hmo/vLdtgEZv6VtqWFGgcyA+ycQqUFdC9tFWuvAbOjkcPeMgMomGcDIjq
MIME-Version: 1.0
X-Received: by 2002:a5e:8208:: with SMTP id l8mr8632803iom.197.1625073686435;
 Wed, 30 Jun 2021 10:21:26 -0700 (PDT)
Date:   Wed, 30 Jun 2021 10:21:26 -0700
In-Reply-To: <00000000000002b41905be665238@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d05b3805c5fef3ca@google.com>
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

HEAD commit:    a1f92694 Add linux-next specific files for 20210518
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14cf5118300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d612e75ffd53a6d3
dashboard link: https://syzkaller.appspot.com/bug?extid=44e40ac2cfe68e8ce207
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15dae18c300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c680e2300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+44e40ac2cfe68e8ce207@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
5.13.0-rc2-next-20210518-syzkaller #0 Not tainted
--------------------------------------------
syz-executor723/9333 is trying to acquire lock:
ffffffff8cc8b5f8 (qp_broker_list.mutex){+.+.}-{3:3}, at: vmci_qp_broker_detach+0x147/0x11b0 drivers/misc/vmw_vmci/vmci_queue_pair.c:2093

but task is already holding lock:
ffffffff8cc8b5f8 (qp_broker_list.mutex){+.+.}-{3:3}, at: vmci_qp_broker_detach+0x147/0x11b0 drivers/misc/vmw_vmci/vmci_queue_pair.c:2093

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(qp_broker_list.mutex);
  lock(qp_broker_list.mutex);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

1 lock held by syz-executor723/9333:
 #0: ffffffff8cc8b5f8 (qp_broker_list.mutex){+.+.}-{3:3}, at: vmci_qp_broker_detach+0x147/0x11b0 drivers/misc/vmw_vmci/vmci_queue_pair.c:2093

stack backtrace:
CPU: 0 PID: 9333 Comm: syz-executor723 Not tainted 5.13.0-rc2-next-20210518-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x13e/0x1d6 lib/dump_stack.c:129
 print_deadlock_bug kernel/locking/lockdep.c:2831 [inline]
 check_deadlock kernel/locking/lockdep.c:2874 [inline]
 validate_chain kernel/locking/lockdep.c:3663 [inline]
 __lock_acquire.cold+0x22f/0x3b4 kernel/locking/lockdep.c:4902
 lock_acquire kernel/locking/lockdep.c:5512 [inline]
 lock_acquire+0x1ab/0x740 kernel/locking/lockdep.c:5477
 __mutex_lock_common kernel/locking/mutex.c:949 [inline]
 __mutex_lock+0x139/0x1120 kernel/locking/mutex.c:1096
 vmci_qp_broker_detach+0x147/0x11b0 drivers/misc/vmw_vmci/vmci_queue_pair.c:2093
 ctx_free_ctx+0x4cc/0xd30 drivers/misc/vmw_vmci/vmci_context.c:444
 kref_put include/linux/kref.h:65 [inline]
 vmci_ctx_put drivers/misc/vmw_vmci/vmci_context.c:497 [inline]
 vmci_ctx_enqueue_datagram+0x4dc/0x620 drivers/misc/vmw_vmci/vmci_context.c:360
 dg_dispatch_as_host drivers/misc/vmw_vmci/vmci_datagram.c:275 [inline]
 vmci_datagram_dispatch+0x39b/0xb50 drivers/misc/vmw_vmci/vmci_datagram.c:339
 qp_notify_peer+0x182/0x260 drivers/misc/vmw_vmci/vmci_queue_pair.c:1479
 vmci_qp_broker_detach+0xa09/0x11b0 drivers/misc/vmw_vmci/vmci_queue_pair.c:2186
 ctx_free_ctx+0x4cc/0xd30 drivers/misc/vmw_vmci/vmci_context.c:444
 kref_put include/linux/kref.h:65 [inline]
 vmci_ctx_put drivers/misc/vmw_vmci/vmci_context.c:497 [inline]
 vmci_ctx_destroy+0x169/0x1d0 drivers/misc/vmw_vmci/vmci_context.c:195
 vmci_host_close+0x116/0x1a0 drivers/misc/vmw_vmci/vmci_host.c:143
 __fput+0x288/0x920 fs/file_table.c:280
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x26f/0x280 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:301
 do_syscall_64+0x3e/0xb0 arch/x86/entry/common.c:57
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x445ac9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe38cec92f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000124
RAX: 0000000000000005 RBX: 00000000004ca420 RCX: 0000000000445ac9
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000004
RBP: 00000000004ca42c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000049a074
R13: 65732f636f72702f R14: 636d762f7665642f R15: 00000000004ca428

