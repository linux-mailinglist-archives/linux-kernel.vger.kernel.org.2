Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32604391C47
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 17:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbhEZPpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 11:45:52 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:38434 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbhEZPpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 11:45:51 -0400
Received: by mail-il1-f197.google.com with SMTP id r3-20020a92cd830000b02901c085bc9f5eso1100496ilb.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 08:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=OdL20YqkAI7JJ2Wurl0dYHvUrhMz0DHPO3AdkhEoqS8=;
        b=Y0S5tCTSqRJ81sPBN4hyZ7/9eSlvzLZ7WkGhkiEJYLpWDo3b9CW2GEJcVZMwX6W1PA
         sbYZkuoG1grOYHAW7suSKCITa+Udxc2zsSqxClFBh1+zWvPQH4RkAwnNfsVfn+HwGidT
         oFU3zfoKxoFxDES1B78MTsMEf80bEyfuHea5fRRNCSHqlED1VG9l5gZgLj3lLoEpUpps
         ZsoNU/ot0ir+MbypntVhpK2GlU7YPgkd3TRSTNvzMPREz5JwWkw/XvQfvNlivYOzR5+6
         m30NJJ6MGX/PrKsNJ8vPebsECnZKG61EA6/nk1p4zlQQ2wtfPKlKxeWbRt14apEWIJnS
         vFDg==
X-Gm-Message-State: AOAM532PO7POWMShTp7Ev3Ki7TWM03rmOU34UeAxIdBudt1z7ZqI+cTg
        hTKvkfyTrtsuGCfDggxee1WyIvRAwg9DSSSvZJmIQSyTgYLT
X-Google-Smtp-Source: ABdhPJwg4V/nF+IW2KqtAB+SxTtb5cqxHI95UE+eQMXQMSI9dkKSicoQOTTt0voPm8eOjbAZCCPIWP6tVVmS/NzPyGjNGw36LDAF
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ba7:: with SMTP id n7mr22093360ili.159.1622043858212;
 Wed, 26 May 2021 08:44:18 -0700 (PDT)
Date:   Wed, 26 May 2021 08:44:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa9f7005c33d83b9@google.com>
Subject: [syzbot] KCSAN: data-race in __io_uring_cancel / io_uring_try_cancel_requests
From:   syzbot <syzbot+73554e2258b7b8bf0bbf@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a050a6d2 Merge tag 'perf-tools-fixes-for-v5.13-2021-05-24'..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13205087d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3bcc8a6b51ef8094
dashboard link: https://syzkaller.appspot.com/bug?extid=73554e2258b7b8bf0bbf
compiler:       Debian clang version 11.0.1-2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+73554e2258b7b8bf0bbf@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __io_uring_cancel / io_uring_try_cancel_requests

write to 0xffff88811d8df330 of 8 bytes by task 3709 on cpu 1:
 io_uring_clean_tctx fs/io_uring.c:9042 [inline]
 __io_uring_cancel+0x261/0x3b0 fs/io_uring.c:9136
 io_uring_files_cancel include/linux/io_uring.h:16 [inline]
 do_exit+0x185/0x1560 kernel/exit.c:781
 do_group_exit+0xce/0x1a0 kernel/exit.c:923
 get_signal+0xfc3/0x1610 kernel/signal.c:2835
 arch_do_signal_or_restart+0x2a/0x220 arch/x86/kernel/signal.c:789
 handle_signal_work kernel/entry/common.c:147 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x109/0x190 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x20/0x40 kernel/entry/common.c:301
 do_syscall_64+0x56/0x90 arch/x86/entry/common.c:57
 entry_SYSCALL_64_after_hwframe+0x44/0xae

read to 0xffff88811d8df330 of 8 bytes by task 6412 on cpu 0:
 io_uring_try_cancel_iowq fs/io_uring.c:8911 [inline]
 io_uring_try_cancel_requests+0x1ce/0x8e0 fs/io_uring.c:8933
 io_ring_exit_work+0x7c/0x1110 fs/io_uring.c:8736
 process_one_work+0x3e9/0x8f0 kernel/workqueue.c:2276
 worker_thread+0x636/0xae0 kernel/workqueue.c:2422
 kthread+0x1d0/0x1f0 kernel/kthread.c:313
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 6412 Comm: kworker/u4:9 Not tainted 5.13.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_unbound io_ring_exit_work
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
