Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88746358754
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 16:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbhDHOm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 10:42:28 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:40450 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhDHOmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:42:24 -0400
Received: by mail-il1-f197.google.com with SMTP id y15so490145ill.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 07:42:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=omWXKOI+6Y8Uu1OPaxNuoex04esEAItjZ32ZmdFimmw=;
        b=WO3S/tqeJyO6DdiHLi6icIvUdMGxJUacbPjkgyh+BhSPYlozRTRctg1y3otiPClUeg
         7OUYHM2a93HroWx+xATk9h8CYKRtE9bhaVAOx9cN0woj14N/PmSTUsahsN3prR8S9iD0
         KypjC+mcN2VpN767AHnZrJQ1ogvoNlZT6brvCGXQ09tH6vA1ouS2TeBcXYHv5zKWenQy
         D7NwCHbze9DTkumAyAtUeBlrBRN1Tv3lpM5fzIjNi6VUOiYHku5sFUu2EDIvKKFQ3loT
         O/eAYyaj9EUO5Knis9ljjVM9bRuvI5108sxfD7D+jhQ66pFFmgpWtx4PQY9o2iDPXpNc
         jMUw==
X-Gm-Message-State: AOAM530zdHrCG48ujuqj8vpI0MlL4WU9wcS4MxIJBPI2UnsxCaTqNlsW
        kkZEE3SXef6NTFp/hwFD99fsHSG8QwqbUUwxtxbHDcsvuuM4
X-Google-Smtp-Source: ABdhPJxT4mVuv0smV/u0E+2/BNXePBlc2qm71w8Ei4gtIMnXhxIoO1l841fQD80v+mhg1g7hQOoSD2BRAO6vX0trzrZ2iHsUzVsX
MIME-Version: 1.0
X-Received: by 2002:a02:6654:: with SMTP id l20mr9360186jaf.55.1617892932933;
 Thu, 08 Apr 2021 07:42:12 -0700 (PDT)
Date:   Thu, 08 Apr 2021 07:42:12 -0700
In-Reply-To: <346fb87c-6fae-284d-62a0-edafde451861@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008d622905bf770dd6@google.com>
Subject: Re: [syzbot] INFO: task hung in io_ring_exit_work
From:   syzbot <syzbot+93f72b3885406bb09e0d@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in io_ring_exit_work

INFO: task kworker/u4:0:9 blocked for more than 143 seconds.
      Not tainted 5.12.0-rc2-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:0    state:D stack:26056 pid:    9 ppid:     2 flags:0x00004000
Workqueue: events_unbound io_ring_exit_work
Call Trace:
 context_switch kernel/sched/core.c:4324 [inline]
 __schedule+0x911/0x21b0 kernel/sched/core.c:5075
 schedule+0xcf/0x270 kernel/sched/core.c:5154
 schedule_timeout+0x1db/0x250 kernel/time/timer.c:1868
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x168/0x270 kernel/sched/completion.c:138
 io_ring_exit_work+0x4e8/0x12d0 fs/io_uring.c:8616
 process_one_work+0x98d/0x1600 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
INFO: task kworker/u4:1:25 blocked for more than 143 seconds.
      Not tainted 5.12.0-rc2-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:1    state:D stack:25560 pid:   25 ppid:     2 flags:0x00004000
Workqueue: events_unbound io_ring_exit_work
Call Trace:
 context_switch kernel/sched/core.c:4324 [inline]
 __schedule+0x911/0x21b0 kernel/sched/core.c:5075
 schedule+0xcf/0x270 kernel/sched/core.c:5154
 schedule_timeout+0x14a/0x250 kernel/time/timer.c:1892


Tested on:

commit:         a2a68d4c io_uring: signalling fun / syz test
git tree:       https://github.com/isilence/linux.git syz_test3
console output: https://syzkaller.appspot.com/x/log.txt?x=12eed711d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=86318203e865a02b
dashboard link: https://syzkaller.appspot.com/bug?extid=93f72b3885406bb09e0d
compiler:       

