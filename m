Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21C03C3734
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 00:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhGJXA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 19:00:56 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:52908 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhGJXAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 19:00:55 -0400
Received: by mail-io1-f71.google.com with SMTP id p21-20020a6b8d150000b029050e9f519782so9004485iod.19
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 15:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0wWgh8WDnJgLadErj8DWSwgmkIyzT68Is8EEUbs0ddQ=;
        b=g6DbCIsAWraUQ10lNEMiTC0EPumzvXWCacVDgjeDwENSB+i7riw44CBZ6NOoH2x9m3
         gqMaDAz95GqDD2aJRzAXkDbLsoCB9eLybrpZ0+PU/hVP0SwDJ9lDBnF7gCwKsR1PUU54
         Uf9tRL7hCDeKKPiFYksfitvnXF0z170zH3LG8LJgnpbNrnKAwp4UJ0ZTqit7bwIkqrtC
         dm18XNfWI3ztJjIbSRIqOu+K3WPO4PzsZnklO9ZCPoVQXBV2ndnYGQtp74O9GmUz1Rqr
         daiNX/oFYqOAo6TeCLIuzcysTYqdJglvC30l0xo3v3f5XRrXx+muB5++ABqnqBBGaa0Y
         k8lg==
X-Gm-Message-State: AOAM532GzGgBBkUkVnrtrYGg4nc9Ovk39yejG/NQxEKUkR1UaZ2ShEM1
        RnylDJ3IwYVyUvED1I/D9zOagUUuHXqkIkBkNSP7RHWxcyKL
X-Google-Smtp-Source: ABdhPJwAk7j/AxYEQqJarBacdXTmM+yZUFZf9Fpye5npVWKkm6ieOMuaia0W7pJz+2O4hR6RcS/69icRLZzQItgboi+DNUlOEIOM
MIME-Version: 1.0
X-Received: by 2002:a92:bf0b:: with SMTP id z11mr33610032ilh.60.1625957890058;
 Sat, 10 Jul 2021 15:58:10 -0700 (PDT)
Date:   Sat, 10 Jul 2021 15:58:10 -0700
In-Reply-To: <20210710145003.GA271154@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000074f06705c6ccd2a4@google.com>
Subject: Re: [syzbot] WARNING in do_proc_control/usb_submit_urb
From:   syzbot <syzbot+72af3105289dcb4c055b@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mathias.nyman@linux.intel.com, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: sleeping function called from invalid context in lock_sock_nested

BUG: sleeping function called from invalid context at net/core/sock.c:3159
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 8829, name: syz-executor.5
1 lock held by syz-executor.5/8829:
 #0: ffffffff8d2ecee0 (hci_sk_list.lock){++++}-{2:2}, at: hci_sock_dev_event+0x3db/0x660 net/bluetooth/hci_sock.c:763
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 PID: 8829 Comm: syz-executor.5 Not tainted 5.13.0-next-20210707-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
 ___might_sleep.cold+0x1f1/0x237 kernel/sched/core.c:9171
 lock_sock_nested+0x25/0x120 net/core/sock.c:3159
 lock_sock include/net/sock.h:1613 [inline]
 hci_sock_dev_event+0x465/0x660 net/bluetooth/hci_sock.c:765
 hci_unregister_dev+0x2fd/0x1130 net/bluetooth/hci_core.c:4033
 vhci_release+0x70/0xe0 drivers/bluetooth/hci_vhci.c:340
 __fput+0x288/0x920 fs/file_table.c:280
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 exit_task_work include/linux/task_work.h:32 [inline]
 do_exit+0xbd4/0x2a60 kernel/exit.c:825
 do_group_exit+0x125/0x310 kernel/exit.c:922
 __do_sys_exit_group kernel/exit.c:933 [inline]
 __se_sys_exit_group kernel/exit.c:931 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:931
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665d9
Code: Unable to access opcode bytes at RIP 0x4665af.
RSP: 002b:00007ffd31aadb08 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007ffd31aae2c8 RCX: 00000000004665d9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000043
RBP: 0000000000000000 R08: 0000000000000025 R09: 00007ffd31aae2c8
R10: 00000000ffffffff R11: 0000000000000246 R12: 00000000004bef54
R13: 0000000000000010 R14: 0000000000000000 R15: 0000000000400538

======================================================


Tested on:

commit:         ee268dee Add linux-next specific files for 20210707
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=159cf1e2300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59e1e3bbc3afca75
dashboard link: https://syzkaller.appspot.com/bug?extid=72af3105289dcb4c055b
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=163fd772300000

