Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA0140860C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 10:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237786AbhIMIFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 04:05:51 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:37778 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237722AbhIMIFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 04:05:47 -0400
Received: by mail-io1-f70.google.com with SMTP id e68-20020a6bb547000000b005d06de54ab7so2863471iof.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 01:04:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=PjwXxTwlsEf2JX6e7/eNYgkSX09JO8xcTqxRo9lighc=;
        b=Xn7lzD4BRupr1TVLyTCn/1ryTNEkGmkMDg2XezjrXefp0ZmOIqyM4C+wZgXpq9rDxk
         a15vqUHTDJFrt0C/Fh40Kl72xM7r5WScdtGk0+En2v3SJ835yleAk45jaeNETygGSa05
         gYyWZp4+F2OqCKo23MbuhBMtI8oKH+JE5H69ub1bALulQT77Ag+u6HBX6zZ4RZxiGYTJ
         d5XtU6NwQy+pwqu/oYA7qe1QOOABzCJjzMZDDKkIorb89ql/e8YdligWYSSZA7Gt4U91
         jG00mK132xjRVA1CE3w6uNngwdzS4+Ng0fRjwFVgsulanpoI0vSxVAqsz+7HWJZFsQw4
         /Hpg==
X-Gm-Message-State: AOAM532qNWagUDcx0bUVeHCmC9bcmbABJECTxMJFgYUkh8UNpoW5+B07
        OK6t/Bvd7yeUP4CTUZMTt1fPaSc9/u2IIx8h2qhf/Tr9XvYl
X-Google-Smtp-Source: ABdhPJxk/RaDiv0svCfqTaljcJw1liNNEy6x4BPZK+g0g545XlGcP0Wi2MSKVftDZIc4Ile4osYs6Kc3MZBxlVecCZmJIP23TA+4
MIME-Version: 1.0
X-Received: by 2002:a92:6904:: with SMTP id e4mr7164478ilc.311.1631520272300;
 Mon, 13 Sep 2021 01:04:32 -0700 (PDT)
Date:   Mon, 13 Sep 2021 01:04:32 -0700
In-Reply-To: <0000000000004fe6b105cb84cf1e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000463eb205cbdbea58@google.com>
Subject: Re: [syzbot] memory leak in create_io_worker
From:   syzbot <syzbot+65454c239241d3d647da@syzkaller.appspotmail.com>
To:     Qiang.Zhang@windriver.com, asml.silence@gmail.com, axboe@kernel.dk,
        io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    f306b90c69ce Merge tag 'smp-urgent-2021-09-12' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14bc2715300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb1c2ff5ae428ca6
dashboard link: https://syzkaller.appspot.com/bug?extid=65454c239241d3d647da
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=171d8963300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15b9ccdd300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+65454c239241d3d647da@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88811953fa80 (size 192):
  comm "syz-executor248", pid 6847, jiffies 4294979550 (age 31.120s)
  hex dump (first 32 bytes):
    01 00 00 00 08 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8162fbb1>] kmalloc_node include/linux/slab.h:609 [inline]
    [<ffffffff8162fbb1>] kzalloc_node include/linux/slab.h:732 [inline]
    [<ffffffff8162fbb1>] create_io_worker+0x41/0x1f0 fs/io-wq.c:741
    [<ffffffff81630067>] io_wqe_create_worker fs/io-wq.c:267 [inline]
    [<ffffffff81630067>] io_wqe_enqueue+0x217/0x3a0 fs/io-wq.c:873
    [<ffffffff8161e3a4>] io_queue_async_work+0xc4/0x200 fs/io_uring.c:1473
    [<ffffffff8162944c>] __io_queue_sqe+0x34c/0x510 fs/io_uring.c:6940
    [<ffffffff8162a6e6>] io_queue_sqe fs/io_uring.c:6958 [inline]
    [<ffffffff8162a6e6>] io_submit_sqe fs/io_uring.c:7134 [inline]
    [<ffffffff8162a6e6>] io_submit_sqes+0xc36/0x2ec0 fs/io_uring.c:7240
    [<ffffffff8162cf6f>] __do_sys_io_uring_enter+0x5ff/0xf80 fs/io_uring.c:9882
    [<ffffffff843faa25>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff843faa25>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff88811953fa80 (size 192):
  comm "syz-executor248", pid 6847, jiffies 4294979550 (age 31.180s)
  hex dump (first 32 bytes):
    01 00 00 00 08 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8162fbb1>] kmalloc_node include/linux/slab.h:609 [inline]
    [<ffffffff8162fbb1>] kzalloc_node include/linux/slab.h:732 [inline]
    [<ffffffff8162fbb1>] create_io_worker+0x41/0x1f0 fs/io-wq.c:741
    [<ffffffff81630067>] io_wqe_create_worker fs/io-wq.c:267 [inline]
    [<ffffffff81630067>] io_wqe_enqueue+0x217/0x3a0 fs/io-wq.c:873
    [<ffffffff8161e3a4>] io_queue_async_work+0xc4/0x200 fs/io_uring.c:1473
    [<ffffffff8162944c>] __io_queue_sqe+0x34c/0x510 fs/io_uring.c:6940
    [<ffffffff8162a6e6>] io_queue_sqe fs/io_uring.c:6958 [inline]
    [<ffffffff8162a6e6>] io_submit_sqe fs/io_uring.c:7134 [inline]
    [<ffffffff8162a6e6>] io_submit_sqes+0xc36/0x2ec0 fs/io_uring.c:7240
    [<ffffffff8162cf6f>] __do_sys_io_uring_enter+0x5ff/0xf80 fs/io_uring.c:9882
    [<ffffffff843faa25>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff843faa25>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff88811953fa80 (size 192):
  comm "syz-executor248", pid 6847, jiffies 4294979550 (age 31.230s)
  hex dump (first 32 bytes):
    01 00 00 00 08 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8162fbb1>] kmalloc_node include/linux/slab.h:609 [inline]
    [<ffffffff8162fbb1>] kzalloc_node include/linux/slab.h:732 [inline]
    [<ffffffff8162fbb1>] create_io_worker+0x41/0x1f0 fs/io-wq.c:741
    [<ffffffff81630067>] io_wqe_create_worker fs/io-wq.c:267 [inline]
    [<ffffffff81630067>] io_wqe_enqueue+0x217/0x3a0 fs/io-wq.c:873
    [<ffffffff8161e3a4>] io_queue_async_work+0xc4/0x200 fs/io_uring.c:1473
    [<ffffffff8162944c>] __io_queue_sqe+0x34c/0x510 fs/io_uring.c:6940
    [<ffffffff8162a6e6>] io_queue_sqe fs/io_uring.c:6958 [inline]
    [<ffffffff8162a6e6>] io_submit_sqe fs/io_uring.c:7134 [inline]
    [<ffffffff8162a6e6>] io_submit_sqes+0xc36/0x2ec0 fs/io_uring.c:7240
    [<ffffffff8162cf6f>] __do_sys_io_uring_enter+0x5ff/0xf80 fs/io_uring.c:9882
    [<ffffffff843faa25>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff843faa25>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff88811953fa80 (size 192):
  comm "syz-executor248", pid 6847, jiffies 4294979550 (age 31.290s)
  hex dump (first 32 bytes):
    01 00 00 00 08 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8162fbb1>] kmalloc_node include/linux/slab.h:609 [inline]
    [<ffffffff8162fbb1>] kzalloc_node include/linux/slab.h:732 [inline]
    [<ffffffff8162fbb1>] create_io_worker+0x41/0x1f0 fs/io-wq.c:741
    [<ffffffff81630067>] io_wqe_create_worker fs/io-wq.c:267 [inline]
    [<ffffffff81630067>] io_wqe_enqueue+0x217/0x3a0 fs/io-wq.c:873
    [<ffffffff8161e3a4>] io_queue_async_work+0xc4/0x200 fs/io_uring.c:1473
    [<ffffffff8162944c>] __io_queue_sqe+0x34c/0x510 fs/io_uring.c:6940
    [<ffffffff8162a6e6>] io_queue_sqe fs/io_uring.c:6958 [inline]
    [<ffffffff8162a6e6>] io_submit_sqe fs/io_uring.c:7134 [inline]
    [<ffffffff8162a6e6>] io_submit_sqes+0xc36/0x2ec0 fs/io_uring.c:7240
    [<ffffffff8162cf6f>] __do_sys_io_uring_enter+0x5ff/0xf80 fs/io_uring.c:9882
    [<ffffffff843faa25>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff843faa25>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff88811953fa80 (size 192):
  comm "syz-executor248", pid 6847, jiffies 4294979550 (age 31.340s)
  hex dump (first 32 bytes):
    01 00 00 00 08 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8162fbb1>] kmalloc_node include/linux/slab.h:609 [inline]
    [<ffffffff8162fbb1>] kzalloc_node include/linux/slab.h:732 [inline]
    [<ffffffff8162fbb1>] create_io_worker+0x41/0x1f0 fs/io-wq.c:741
    [<ffffffff81630067>] io_wqe_create_worker fs/io-wq.c:267 [inline]
    [<ffffffff81630067>] io_wqe_enqueue+0x217/0x3a0 fs/io-wq.c:873
    [<ffffffff8161e3a4>] io_queue_async_work+0xc4/0x200 fs/io_uring.c:1473
    [<ffffffff8162944c>] __io_queue_sqe+0x34c/0x510 fs/io_uring.c:6940
    [<ffffffff8162a6e6>] io_queue_sqe fs/io_uring.c:6958 [inline]
    [<ffffffff8162a6e6>] io_submit_sqe fs/io_uring.c:7134 [inline]
    [<ffffffff8162a6e6>] io_submit_sqes+0xc36/0x2ec0 fs/io_uring.c:7240
    [<ffffffff8162cf6f>] __do_sys_io_uring_enter+0x5ff/0xf80 fs/io_uring.c:9882
    [<ffffffff843faa25>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff843faa25>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff88811953fa80 (size 192):
  comm "syz-executor248", pid 6847, jiffies 4294979550 (age 31.400s)
  hex dump (first 32 bytes):
    01 00 00 00 08 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8162fbb1>] kmalloc_node include/linux/slab.h:609 [inline]
    [<ffffffff8162fbb1>] kzalloc_node include/linux/slab.h:732 [inline]
    [<ffffffff8162fbb1>] create_io_worker+0x41/0x1f0 fs/io-wq.c:741
    [<ffffffff81630067>] io_wqe_create_worker fs/io-wq.c:267 [inline]
    [<ffffffff81630067>] io_wqe_enqueue+0x217/0x3a0 fs/io-wq.c:873
    [<ffffffff8161e3a4>] io_queue_async_work+0xc4/0x200 fs/io_uring.c:1473
    [<ffffffff8162944c>] __io_queue_sqe+0x34c/0x510 fs/io_uring.c:6940
    [<ffffffff8162a6e6>] io_queue_sqe fs/io_uring.c:6958 [inline]
    [<ffffffff8162a6e6>] io_submit_sqe fs/io_uring.c:7134 [inline]
    [<ffffffff8162a6e6>] io_submit_sqes+0xc36/0x2ec0 fs/io_uring.c:7240
    [<ffffffff8162cf6f>] __do_sys_io_uring_enter+0x5ff/0xf80 fs/io_uring.c:9882
    [<ffffffff843faa25>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff843faa25>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff88811953fa80 (size 192):
  comm "syz-executor248", pid 6847, jiffies 4294979550 (age 31.450s)
  hex dump (first 32 bytes):
    01 00 00 00 08 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8162fbb1>] kmalloc_node include/linux/slab.h:609 [inline]
    [<ffffffff8162fbb1>] kzalloc_node include/linux/slab.h:732 [inline]
    [<ffffffff8162fbb1>] create_io_worker+0x41/0x1f0 fs/io-wq.c:741
    [<ffffffff81630067>] io_wqe_create_worker fs/io-wq.c:267 [inline]
    [<ffffffff81630067>] io_wqe_enqueue+0x217/0x3a0 fs/io-wq.c:873
    [<ffffffff8161e3a4>] io_queue_async_work+0xc4/0x200 fs/io_uring.c:1473
    [<ffffffff8162944c>] __io_queue_sqe+0x34c/0x510 fs/io_uring.c:6940
    [<ffffffff8162a6e6>] io_queue_sqe fs/io_uring.c:6958 [inline]
    [<ffffffff8162a6e6>] io_submit_sqe fs/io_uring.c:7134 [inline]
    [<ffffffff8162a6e6>] io_submit_sqes+0xc36/0x2ec0 fs/io_uring.c:7240
    [<ffffffff8162cf6f>] __do_sys_io_uring_enter+0x5ff/0xf80 fs/io_uring.c:9882
    [<ffffffff843faa25>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff843faa25>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff88811953fa80 (size 192):
  comm "syz-executor248", pid 6847, jiffies 4294979550 (age 31.500s)
  hex dump (first 32 bytes):
    01 00 00 00 08 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8162fbb1>] kmalloc_node include/linux/slab.h:609 [inline]
    [<ffffffff8162fbb1>] kzalloc_node include/linux/slab.h:732 [inline]
    [<ffffffff8162fbb1>] create_io_worker+0x41/0x1f0 fs/io-wq.c:741
    [<ffffffff81630067>] io_wqe_create_worker fs/io-wq.c:267 [inline]
    [<ffffffff81630067>] io_wqe_enqueue+0x217/0x3a0 fs/io-wq.c:873
    [<ffffffff8161e3a4>] io_queue_async_work+0xc4/0x200 fs/io_uring.c:1473
    [<ffffffff8162944c>] __io_queue_sqe+0x34c/0x510 fs/io_uring.c:6940
    [<ffffffff8162a6e6>] io_queue_sqe fs/io_uring.c:6958 [inline]
    [<ffffffff8162a6e6>] io_submit_sqe fs/io_uring.c:7134 [inline]
    [<ffffffff8162a6e6>] io_submit_sqes+0xc36/0x2ec0 fs/io_uring.c:7240
    [<ffffffff8162cf6f>] __do_sys_io_uring_enter+0x5ff/0xf80 fs/io_uring.c:9882
    [<ffffffff843faa25>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff843faa25>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory

