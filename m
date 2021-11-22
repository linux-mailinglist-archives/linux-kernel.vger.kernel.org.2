Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E76B2458927
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 06:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhKVFy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 00:54:27 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:40598 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhKVFy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 00:54:26 -0500
Received: by mail-il1-f197.google.com with SMTP id d8-20020a928748000000b0027585828bc3so9655109ilm.7
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 21:51:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=nFOITYfIEorOXjaj5jZLYtuuKCUZHRkEB2VxdapHdLU=;
        b=pHQWSyoSaMpte6DM139wvOZaX2Lb2U4hpKC7DDQOmO7Gulr6GSjITLmNmUHSbvwSD6
         941goa3fDT7V31AVPQbscAJh5CLsS7OId+1z+OjqQtJGPPPmCMGjKIiTEgJRktpHcRTs
         3YzLmfCvehOGhy8bfkd+2YEVh0D6EbG1m12SNpwQavSHbOGPKfEJI/LbPy29UK9lx9Tt
         whk9PBM/aq6HR6TugrWjCxzVTP1hG/i7CWzdagEFwAKttJ6Yuozw+mV3JjRsvyIZ6r4h
         s+KWrU9sJRS/oz87s4K7+ABEC7TtQwgDG9iNQQ3uo6rfccKjVz0rSfnUYW4hqlS0k2bF
         Intg==
X-Gm-Message-State: AOAM531vknidd3LgUvGlgfroykXIrrAJr4pfqIEx7YeaWKkkZsGCbjkz
        H+wh9mozz4ckIf9jeoobSJ/n5JZJaSCRJmrhT9OBqDmzS0e0
X-Google-Smtp-Source: ABdhPJxicFhg4HLWknRZZ4vVOBPtdj/30My/yvGJCYdmUlV2HS06XhYKoFqfYrnHLlTGGFqvs/woyWhn6voWAiL2Tag8Xm5VHloi
MIME-Version: 1.0
X-Received: by 2002:a92:c56c:: with SMTP id b12mr14508825ilj.255.1637560280258;
 Sun, 21 Nov 2021 21:51:20 -0800 (PST)
Date:   Sun, 21 Nov 2021 21:51:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cd9ebf05d15a36ba@google.com>
Subject: [syzbot] WARNING: bad unlock balance in hub_event
From:   syzbot <syzbot+423eaf1efaa99fb8ce96@syzkaller.appspotmail.com>
To:     Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mathias.nyman@linux.intel.com, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    5191249f8803 Add linux-next specific files for 20211118
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=102c939eb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fca39774e64812b0
dashboard link: https://syzkaller.appspot.com/bug?extid=423eaf1efaa99fb8ce96
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+423eaf1efaa99fb8ce96@syzkaller.appspotmail.com

=====================================
WARNING: bad unlock balance detected!
5.16.0-rc1-next-20211118-syzkaller #0 Not tainted
-------------------------------------
kworker/1:24/10009 is trying to release lock (hcd->address0_mutex) at:
[<ffffffff856171ad>] hub_port_connect drivers/usb/core/hub.c:5402 [inline]
[<ffffffff856171ad>] hub_port_connect_change drivers/usb/core/hub.c:5493 [inline]
[<ffffffff856171ad>] port_event drivers/usb/core/hub.c:5639 [inline]
[<ffffffff856171ad>] hub_event+0x2a9d/0x4450 drivers/usb/core/hub.c:5721
but there are no more locks to release!

other info that might help us debug this:
3 locks held by kworker/1:24/10009:
 #0: ffff888012baf138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888012baf138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888012baf138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline]
 #0: ffff888012baf138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff888012baf138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff888012baf138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x896/0x1690 kernel/workqueue.c:2269
 #1: ffffc9000b9f7db0 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8ca/0x1690 kernel/workqueue.c:2273
 #2: ffff888147b82220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #2: ffff888147b82220 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4450 drivers/usb/core/hub.c:5667

stack backtrace:
CPU: 1 PID: 10009 Comm: kworker/1:24 Not tainted 5.16.0-rc1-next-20211118-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_unlock_imbalance_bug include/trace/events/lock.h:58 [inline]
 __lock_release kernel/locking/lockdep.c:5316 [inline]
 lock_release.cold+0x34/0x4e kernel/locking/lockdep.c:5657
 __mutex_unlock_slowpath+0x99/0x5e0 kernel/locking/mutex.c:900
 hub_port_connect drivers/usb/core/hub.c:5402 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5493 [inline]
 port_event drivers/usb/core/hub.c:5639 [inline]
 hub_event+0x2a9d/0x4450 drivers/usb/core/hub.c:5721
 process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
 process_scheduled_works kernel/workqueue.c:2361 [inline]
 worker_thread+0x85c/0x11f0 kernel/workqueue.c:2447
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
