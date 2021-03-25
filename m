Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD19348A19
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 08:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhCYHZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 03:25:25 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:39216 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbhCYHZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 03:25:15 -0400
Received: by mail-il1-f199.google.com with SMTP id v20so3471485ile.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 00:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=So5/HS+w20D75eiboyDvMPhoEiAMrMmhq6lTs1vJhCE=;
        b=V4yBawo42O/uMNH/ynZofU1KTcwM4UUPmXPovnboBsPKA14/X6EZ51QLPyphS3ayw9
         Y+tt6jTD0qg8ZiQLD+g1Fw38riRr7+SEu7y5Omd6iSxpGm8YNW5Do4XIWjwSd3eX1U0q
         Ip/Q9BHqWxNrQdJIaItPMOhWC4uAK0qk3fhx6rxEtzzF1NlbAEy1ocPU3hQX58Utfweg
         k/tkqyKcPjnMGCjH36WXVk7/OecVVnSo2jgTKjynIXpNZE7nK8Ai/waF5KYsMnyiiT6v
         2mMZKlOJfUjTyo1u0+oUMzihyr7ObDxPvzO8Zn8zpQ57Lx/MoWOv27kpKBUa5WzK6KfH
         Ps2A==
X-Gm-Message-State: AOAM531RegDTUph0FCBF+832avQ4LjRkf3qCoZfgfTnZO0CgE8Rs3+c/
        nqWbMu8HKtmOqk/pjzsbmiWt0G5PA66I2wD4eQ+frSe2uMgC
X-Google-Smtp-Source: ABdhPJzxlc5eX52Mok68Xre4bkOeuEDhvZwvjnxUPWv33ibhzWCdHCWvRBnq133g6P6ViXDRhemv5OOttrv3ZJadsChzyMQxXHj8
MIME-Version: 1.0
X-Received: by 2002:a6b:fd07:: with SMTP id c7mr5393815ioi.198.1616657115004;
 Thu, 25 Mar 2021 00:25:15 -0700 (PDT)
Date:   Thu, 25 Mar 2021 00:25:15 -0700
In-Reply-To: <000000000000a63c5f05ac118b29@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000010453005be5751e9@google.com>
Subject: Re: [syzbot] WARNING: ODEBUG bug in netdev_run_todo
From:   syzbot <syzbot+f9484b345f41843fc9a9@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    4ee998b0 Merge tag 'clk-fixes-for-linus' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=100e7bb2d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a2f679991921995
dashboard link: https://syzkaller.appspot.com/bug?extid=f9484b345f41843fc9a9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1192d621d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1071301cd00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f9484b345f41843fc9a9@syzkaller.appspotmail.com

bond0 (unregistering): (slave bond_slave_1): Releasing backup interface
bond0 (unregistering): (slave bond_slave_0): Releasing backup interface
bond0 (unregistering): Released all slaves
------------[ cut here ]------------
ODEBUG: free active (active state 0) object type: timer_list hint: delayed_work_timer_fn+0x0/0x90 kernel/workqueue.c:1601
WARNING: CPU: 0 PID: 25 at lib/debugobjects.c:505 debug_print_object+0x16e/0x250 lib/debugobjects.c:505
Modules linked in:
CPU: 0 PID: 25 Comm: kworker/u4:1 Not tainted 5.12.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: netns cleanup_net
RIP: 0010:debug_print_object+0x16e/0x250 lib/debugobjects.c:505
Code: ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 af 00 00 00 48 8b 14 dd 60 97 c1 89 4c 89 ee 48 c7 c7 60 8b c1 89 e8 68 c4 f8 04 <0f> 0b 83 05 45 f1 f9 09 01 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e c3
RSP: 0018:ffffc90000e17898 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: ffff8880118b22c0 RSI: ffffffff815b80e5 RDI: fffff520001c2f05
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff815b0e4e R11: 0000000000000000 R12: ffffffff896d69a0
R13: ffffffff89c191a0 R14: ffffffff81621150 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000562596db1338 CR3: 000000000bc8e000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __debug_check_no_obj_freed lib/debugobjects.c:987 [inline]
 debug_check_no_obj_freed+0x301/0x420 lib/debugobjects.c:1018
 kfree+0xd1/0x2b0 mm/slab.c:3795
 kvfree+0x42/0x50 mm/util.c:616
 device_release+0x9f/0x240 drivers/base/core.c:2108
 kobject_cleanup lib/kobject.c:705 [inline]
 kobject_release lib/kobject.c:736 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c8/0x540 lib/kobject.c:753
 netdev_run_todo+0x96a/0xdd0 net/core/dev.c:10475
 default_device_exit_batch+0x2ff/0x3c0 net/core/dev.c:11426
 ops_exit_list+0x10d/0x160 net/core/net_namespace.c:178
 cleanup_net+0x4ea/0xb10 net/core/net_namespace.c:595
 process_one_work+0x98d/0x1600 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

