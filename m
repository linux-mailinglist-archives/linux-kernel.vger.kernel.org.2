Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4287D321DC5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 18:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhBVRNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 12:13:04 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:41390 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbhBVRNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 12:13:02 -0500
Received: by mail-il1-f200.google.com with SMTP id d11so8270685ilu.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 09:12:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=fSqpsrPKqTlmAum6ca5ws/+HsbhJRU2P1eLs1C3vaH0=;
        b=JW3pCQOE/FBXQQnPXqDrSwWkHyI4l+AoBb5JVYgcJ2mU6RF/jFijH6LzvCq/98Z9CW
         h4uykeXk05JXrPnPkfqbV1AthTZtaxYuVL31wb7gOWdNd3koOMpHxbX94UjQIZV4EC14
         A6XvXGM4oJ0sHVet5yS7XJzAw2BHwHBiu/PlCmK5D6DaoMfgyIvq7sAEiBD1rMO3Vcp7
         VwpAicodJse2LBI1aPBguf9/PuRbvzxtSPD7TPJi+rALskN9ZgjeYgL6bWtHvAVnfOtN
         0Lv7YdR566Ck0QaeFHKaJfm9nc5fhRsqH1cuKwGKaA+nBDP6E4syRWtCqgFDVcSxB3Iy
         +dUA==
X-Gm-Message-State: AOAM531fKJQHxE868YCy/+VGqrxSNMVST2CzEsNyvjzuNkhlDNgcxAza
        ypaEeA/4oB6OP7s+Qe8r3aU6/NzgThH9cfNVoi0if/c4Jm1T
X-Google-Smtp-Source: ABdhPJxcd089wvTabE6b6MvFLQtS60t2W4KEv5s7SnUcrZ5Z4TKhRdsFUt8DohviM493lC3A+kCctsYFYLM8I0g0Dbyb3UR7WGwm
MIME-Version: 1.0
X-Received: by 2002:a5d:9c88:: with SMTP id p8mr8412192iop.23.1614013941430;
 Mon, 22 Feb 2021 09:12:21 -0800 (PST)
Date:   Mon, 22 Feb 2021 09:12:21 -0800
In-Reply-To: <000000000000ffac1205b9a2112f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a43f1f05bbefe703@google.com>
Subject: Re: UBSAN: shift-out-of-bounds in load_balance
From:   syzbot <syzbot+d7581744d5fd27c9fbe1@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bp@alien8.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, valentin.schneider@arm.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    31caf8b2 Merge branch 'linus' of git://git.kernel.org/pub/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16ab2682d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b81388f0b32761d4
dashboard link: https://syzkaller.appspot.com/bug?extid=d7581744d5fd27c9fbe1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1277457f500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d7581744d5fd27c9fbe1@syzkaller.appspotmail.com

================================================================================
UBSAN: shift-out-of-bounds in kernel/sched/fair.c:7712:14
shift exponent 149 is too large for 64-bit type 'long unsigned int'
CPU: 0 PID: 12 Comm: ksoftirqd/0 Not tainted 5.11.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0xfa/0x151 lib/dump_stack.c:120
 ubsan_epilogue+0xb/0x5a lib/ubsan.c:148
 __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x181 lib/ubsan.c:395
 detach_tasks kernel/sched/fair.c:7712 [inline]
 load_balance.cold+0x1d/0x2e kernel/sched/fair.c:9641
 rebalance_domains+0x5cc/0xdb0 kernel/sched/fair.c:10029
 __do_softirq+0x29b/0x9f6 kernel/softirq.c:343
 run_ksoftirqd kernel/softirq.c:650 [inline]
 run_ksoftirqd+0x2d/0x60 kernel/softirq.c:642
 smpboot_thread_fn+0x655/0x9e0 kernel/smpboot.c:165
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
================================================================================
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 12 Comm: ksoftirqd/0 Not tainted 5.11.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0xfa/0x151 lib/dump_stack.c:120
 panic+0x306/0x73d kernel/panic.c:231
 ubsan_epilogue+0x54/0x5a lib/ubsan.c:162
 __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x181 lib/ubsan.c:395
 detach_tasks kernel/sched/fair.c:7712 [inline]
 load_balance.cold+0x1d/0x2e kernel/sched/fair.c:9641
 rebalance_domains+0x5cc/0xdb0 kernel/sched/fair.c:10029
 __do_softirq+0x29b/0x9f6 kernel/softirq.c:343
 run_ksoftirqd kernel/softirq.c:650 [inline]
 run_ksoftirqd+0x2d/0x60 kernel/softirq.c:642
 smpboot_thread_fn+0x655/0x9e0 kernel/smpboot.c:165
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

======================================================

