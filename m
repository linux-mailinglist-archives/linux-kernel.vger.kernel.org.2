Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3403F440728
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 05:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhJ3EAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 00:00:44 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:52202 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhJ3EAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 00:00:42 -0400
Received: by mail-il1-f197.google.com with SMTP id a14-20020a927f0e000000b002597075cb35so7086245ild.18
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 20:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=NxrKfv/XUeAiqCmDWtg9RMNFjn6j9DuSj8uFrnjfaB0=;
        b=mhbtz7As0ZQ7wlA05nvjclNSC5a7ZtFn+3pV5yScNh0rSvzm6olk8qO8v+A/E6ckZ4
         MP8Dr5TeKr0wkx89zOF8Dgir8BpZ+4blO6ULuzAuynoSE9fzboH3mbq2y5UOiB7X0nWo
         /Aidqb2xRFGhDWYGLgNi8iMvZl6f+O3DGb2aQwfeKxIZ3s/J+7FvfX6FHa9vr8d22NkE
         8xSsZmbbli1iAr90jyjmXqWcD3qvlyO+rqlwqvPyr7VXeBOBXyhAyyo6DXvxTMcCAjQN
         +8PSPjv00k/V8l9c9TVHxmFuFAmyNGBPnLnfhMSsT/15xUMPh5W1exrXyR2PR0Xr9DZe
         PpBw==
X-Gm-Message-State: AOAM5301E52DoLrJdik1lxR5f3Q4Vyrm91S4qwxcQJAUrt0NQ0DRHpNS
        s2j+CdhRJA2DtWS/xwhXGNbBEZMJKEzppa0USpFb/pwoKCm5
X-Google-Smtp-Source: ABdhPJy7n2A6fdVP1NqMzxx3//B/WNmefgMySnMxpGoYktdTWi2EFnJ0i3OTadvCBVovbWDV3X5ohd8DFyzToc0wqh2tTqwg5eQX
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b43:: with SMTP id f3mr10784790ilu.194.1635566293237;
 Fri, 29 Oct 2021 20:58:13 -0700 (PDT)
Date:   Fri, 29 Oct 2021 20:58:13 -0700
In-Reply-To: <cebb75d5-076d-0b05-6c37-b880accc320e@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ea455405cf89f33d@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Write in __io_free_req
From:   syzbot <syzbot+78b76ebc91042904f34e@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: refcount bug in delayed_put_task_struct

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 1 PID: 19 at lib/refcount.c:28 refcount_warn_saturate+0x1d1/0x1e0 lib/refcount.c:28
Modules linked in:
CPU: 1 PID: 19 Comm: ksoftirqd/1 Not tainted 5.15.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:refcount_warn_saturate+0x1d1/0x1e0 lib/refcount.c:28
Code: e9 db fe ff ff 48 89 df e8 7c aa 1a fe e9 8a fe ff ff e8 92 6c d3 fd 48 c7 c7 80 bb be 89 c6 05 95 a4 8d 09 01 e8 5b 36 19 05 <0f> 0b e9 af fe ff ff 0f 1f 84 00 00 00 00 00 41 56 41 55 41 54 55
RSP: 0018:ffffc90000d97d00 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888011af5580 RSI: ffffffff815e8868 RDI: fffff520001b2f92
RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff815e260e R11: 0000000000000000 R12: ffff888071c45580
R13: ffff888071c455a8 R14: 0000000000000004 R15: ffff888071c46a50
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe200c24218 CR3: 000000006f2d8000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __refcount_sub_and_test include/linux/refcount.h:283 [inline]
 __refcount_dec_and_test include/linux/refcount.h:315 [inline]
 refcount_dec_and_test include/linux/refcount.h:333 [inline]
 put_task_struct include/linux/sched/task.h:112 [inline]
 delayed_put_task_struct+0x2e3/0x340 kernel/exit.c:172
 rcu_do_batch kernel/rcu/tree.c:2508 [inline]
 rcu_core+0x7ab/0x1470 kernel/rcu/tree.c:2743
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
 run_ksoftirqd kernel/softirq.c:920 [inline]
 run_ksoftirqd+0x2d/0x60 kernel/softirq.c:912
 smpboot_thread_fn+0x645/0x9c0 kernel/smpboot.c:164
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295


Tested on:

commit:         3ecd20a9 io-wq: remove worker to owner tw dependency
git tree:       https://github.com/isilence/linux.git syz-test-iofree
console output: https://syzkaller.appspot.com/x/log.txt?x=160209d4b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=10c050a45aafafcc
dashboard link: https://syzkaller.appspot.com/bug?extid=78b76ebc91042904f34e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

