Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F6F349E91
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 02:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhCZBTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 21:19:49 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:51331 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbhCZBTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 21:19:16 -0400
Received: by mail-il1-f199.google.com with SMTP id y11so5496536ilc.18
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 18:19:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Zj9VqWYlHWYCAdnWdfr1VnprQzYkLclGm9/U8yFm5AM=;
        b=XD1DvC5CxHJZS1L5BzSbfqeiTXq8XqXl0Eph0D9mwSKgt87HHsepE0jwYGhqFEKGzo
         Cba3y9LNlboooT7tj51+2ShPisdMXxK92emMjioOjhACBf+0dOUCukJGwxsMoySoYCnA
         O1GEbBDlEn3UrNQEkwvRG+Mx4QLWbOkPcGazZBlo17N/hZcK9gOfX0CPOgA5MCzwJpci
         pR9k+nMRZUb+yckNCtjXsiL9EmaKymq6hB4H4rIAFFq9s78b/Wl6MYN6b0p0epqGTDqM
         qjvy5IYlRq2e/CeYcmrFM6fdx3lwkFQ3T6zpJCZ4K5lxm/WCm2s3Vs4uQokSdP3/w2bG
         RcKQ==
X-Gm-Message-State: AOAM5311za8NaCRO/5t9LFVpoqrVDyu4ge13HQNNlHUHuOtQuhsaQpvT
        2zsXajJoKsezyFeeVbkZotD41Gk0O75pttBYPo5+Oq8vxwD0
X-Google-Smtp-Source: ABdhPJwB5P5L/WCjtpAozNZ3mYqWAuRnRI4pHD4m80AVM4h32zpC538c32CMhMVYXIw4qEroQBdlWICW38stsOeqphxf/aIS4QpU
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:eaf:: with SMTP id u15mr8315522ilj.45.1616721555401;
 Thu, 25 Mar 2021 18:19:15 -0700 (PDT)
Date:   Thu, 25 Mar 2021 18:19:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000002b41905be665238@google.com>
Subject: [syzbot] possible deadlock in vmci_qp_broker_detach
From:   syzbot <syzbot+44e40ac2cfe68e8ce207@syzkaller.appspotmail.com>
To:     alex.dewar90@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        jhansen@vmware.com, linux-kernel@vger.kernel.org,
        snovitoll@gmail.com, syzkaller-bugs@googlegroups.com,
        vdasa@vmware.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    5ee96fa9 Merge tag 'irq-urgent-2021-03-21' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15466edcd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6abda3336c698a07
dashboard link: https://syzkaller.appspot.com/bug?extid=44e40ac2cfe68e8ce207

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+44e40ac2cfe68e8ce207@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
5.12.0-rc3-syzkaller #0 Not tainted
--------------------------------------------
syz-executor.2/24589 is trying to acquire lock:
ffffffff8ca63f38 (qp_broker_list.mutex){+.+.}-{3:3}, at: vmci_qp_broker_detach+0x147/0x11b0 drivers/misc/vmw_vmci/vmci_queue_pair.c:2093

but task is already holding lock:
ffffffff8ca63f38 (qp_broker_list.mutex){+.+.}-{3:3}, at: vmci_qp_broker_detach+0x147/0x11b0 drivers/misc/vmw_vmci/vmci_queue_pair.c:2093

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(qp_broker_list.mutex);
  lock(qp_broker_list.mutex);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

1 lock held by syz-executor.2/24589:
 #0: ffffffff8ca63f38 (qp_broker_list.mutex){+.+.}-{3:3}, at: vmci_qp_broker_detach+0x147/0x11b0 drivers/misc/vmw_vmci/vmci_queue_pair.c:2093

stack backtrace:
CPU: 0 PID: 24589 Comm: syz-executor.2 Not tainted 5.12.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 print_deadlock_bug kernel/locking/lockdep.c:2829 [inline]
 check_deadlock kernel/locking/lockdep.c:2872 [inline]
 validate_chain kernel/locking/lockdep.c:3661 [inline]
 __lock_acquire.cold+0x14c/0x3b4 kernel/locking/lockdep.c:4900
 lock_acquire kernel/locking/lockdep.c:5510 [inline]
 lock_acquire+0x1ab/0x740 kernel/locking/lockdep.c:5475
 __mutex_lock_common kernel/locking/mutex.c:949 [inline]
 __mutex_lock+0x139/0x1120 kernel/locking/mutex.c:1096
 vmci_qp_broker_detach+0x147/0x11b0 drivers/misc/vmw_vmci/vmci_queue_pair.c:2093
 ctx_free_ctx+0x4e5/0xd30 drivers/misc/vmw_vmci/vmci_context.c:444
 kref_put include/linux/kref.h:65 [inline]
 vmci_ctx_put drivers/misc/vmw_vmci/vmci_context.c:497 [inline]
 vmci_ctx_enqueue_datagram+0x4dc/0x620 drivers/misc/vmw_vmci/vmci_context.c:360
 dg_dispatch_as_host drivers/misc/vmw_vmci/vmci_datagram.c:275 [inline]
 vmci_datagram_dispatch+0x39b/0xb50 drivers/misc/vmw_vmci/vmci_datagram.c:339
 qp_notify_peer+0x182/0x260 drivers/misc/vmw_vmci/vmci_queue_pair.c:1479
 vmci_qp_broker_detach+0xa09/0x11b0 drivers/misc/vmw_vmci/vmci_queue_pair.c:2186
 ctx_free_ctx+0x4e5/0xd30 drivers/misc/vmw_vmci/vmci_context.c:444
 kref_put include/linux/kref.h:65 [inline]
 vmci_ctx_put drivers/misc/vmw_vmci/vmci_context.c:497 [inline]
 vmci_ctx_destroy+0x169/0x1d0 drivers/misc/vmw_vmci/vmci_context.c:195
 vmci_host_close+0x116/0x1a0 drivers/misc/vmw_vmci/vmci_host.c:143
 __fput+0x288/0x920 fs/file_table.c:280
 task_work_run+0xdd/0x1a0 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x249/0x250 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:301
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x41926b
Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8 63 fc ff ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 a1 fc ff ff 8b 44
RSP: 002b:0000000000a9fb80 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 000000000041926b
RDX: 0000001b32f25054 RSI: 0000001b32f24cec RDI: 0000000000000004
RBP: 0000000000000001 R08: 0000000000000000 R09: 000000000000165e
R10: 000000008afb7662 R11: 0000000000000293 R12: 000000000056c9e0
R13: 000000000056c9e0 R14: 000000000056bf60 R15: 0000000000212216


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
