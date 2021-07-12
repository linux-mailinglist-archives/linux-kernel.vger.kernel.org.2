Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4253C5A1B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379908AbhGLJbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 05:31:14 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:45780 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379872AbhGLJbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 05:31:06 -0400
Received: by mail-il1-f198.google.com with SMTP id s18-20020a92cbd20000b02901bb78581beaso11583009ilq.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 02:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=RqEuL8434mkrR62CcVotYB74q2KSRIID0fO56L4zDhw=;
        b=Vma1tBs0r+kVCn7tkHrXw7QEhMofOCRyPzNK8sFx9G/xUm98x/3KsCC1ZNUMbrz4ot
         DFX0OIOH1GlXZSQu0uaVn1t6H2HRnmU99AiIkus58iyztgwLaCrLpUOC4iFDnqAa8wjp
         tSS3eV5bIsb14x+CAluOQNjCfFLrs3GETHWRwIM700GBh/suhTVs8n6onSBiNri0NKY6
         pD51d58K2YriIZTn5zYQ701xJDYfDhKyfvdIhpH/LQ0NfQN+l/BkwNZaduH12hVk2juc
         AqO9b1Ka5pR1TverexccisZtHF+dMVVpNJqm60PcjnlB0Bk4ie17Gs02vX1zzTvO8a/p
         3O0g==
X-Gm-Message-State: AOAM533nF6nVy9+l3G17/o16/nqc+imjNkMUpDPSUWdA6+rmGwNG9kPf
        qKiMxw0o4cI3oGCASv/nsaMlVHIJTE8OD4u907xRt9/Oi/U6
X-Google-Smtp-Source: ABdhPJxYCtcbgCqEfRSlWV44wvQRTMpOBo4rvqW47TCzvOkoh35x56g7oOGFpGjzNwZX9WFCUal/e4XtYpIX7Z4Oq2lhCpU5KPd+
MIME-Version: 1.0
X-Received: by 2002:a05:6602:146:: with SMTP id v6mr38780269iot.5.1626082097781;
 Mon, 12 Jul 2021 02:28:17 -0700 (PDT)
Date:   Mon, 12 Jul 2021 02:28:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d0615505c6e9bd7f@google.com>
Subject: [syzbot] kernel BUG in io_queue_async_work
From:   syzbot <syzbot+d50e4f20cfad4510ec22@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e2f74b13 Add linux-next specific files for 20210708
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14fc6fb4300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59e1e3bbc3afca75
dashboard link: https://syzkaller.appspot.com/bug?extid=d50e4f20cfad4510ec22

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d50e4f20cfad4510ec22@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/io_uring.c:1293!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 18789 Comm: kworker/0:10 Not tainted 5.13.0-next-20210708-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events io_fallback_req_func
RIP: 0010:io_queue_async_work+0x539/0x5f0 fs/io_uring.c:1293
Code: 89 be 89 00 00 00 48 c7 c7 00 8a 9a 89 c6 05 28 5f 77 0b 01 e8 be e9 06 07 e9 6e ff ff ff e8 be 1e 95 ff 0f 0b e8 b7 1e 95 ff <0f> 0b e8 b0 1e 95 ff 0f 0b e9 1a fd ff ff e8 d4 2f db ff e9 47 fb
RSP: 0018:ffffc900032efba8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88802840c800 RCX: 0000000000000000
RDX: ffff888082e09c80 RSI: ffffffff81e07d49 RDI: ffff8880224da498
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000043736500
R10: ffffffff81e222ff R11: 0000000000000000 R12: ffff8880782e78c0
R13: 0000000000000019 R14: ffff88802840c8b0 R15: ffff8880782e7918
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe2796bd8c CR3: 000000000b68e000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __io_queue_sqe+0x913/0xf10 fs/io_uring.c:6444
 io_req_task_submit+0x100/0x120 fs/io_uring.c:2020
 io_fallback_req_func+0x81/0xb0 fs/io_uring.c:2437
 process_one_work+0x98d/0x1630 kernel/workqueue.c:2276
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2422
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Modules linked in:
---[ end trace 4d51acadba583174 ]---
RIP: 0010:io_queue_async_work+0x539/0x5f0 fs/io_uring.c:1293
Code: 89 be 89 00 00 00 48 c7 c7 00 8a 9a 89 c6 05 28 5f 77 0b 01 e8 be e9 06 07 e9 6e ff ff ff e8 be 1e 95 ff 0f 0b e8 b7 1e 95 ff <0f> 0b e8 b0 1e 95 ff 0f 0b e9 1a fd ff ff e8 d4 2f db ff e9 47 fb
RSP: 0018:ffffc900032efba8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88802840c800 RCX: 0000000000000000
RDX: ffff888082e09c80 RSI: ffffffff81e07d49 RDI: ffff8880224da498
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000043736500
R10: ffffffff81e222ff R11: 0000000000000000 R12: ffff8880782e78c0
R13: 0000000000000019 R14: ffff88802840c8b0 R15: ffff8880782e7918
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3dee45e000 CR3: 000000002dd4e000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
