Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7EA397D65
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 01:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbhFBAAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 20:00:05 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:53986 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235200AbhFBAAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 20:00:04 -0400
Received: by mail-il1-f200.google.com with SMTP id p11-20020a056e02104bb02901c6927c3934so258584ilj.20
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 16:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=1bUz8YuEhOiCSOWYoBXJvFGKkMXVnnucD2WG3GR0LaU=;
        b=ZVS/80x0oPiMXNVFyHD/CCi6+zHRCJUvpK7LOdp82lAHEQdf/MWuinpIU76ED6vxPP
         PsbWNA6qH4clDsM72Gu4EYypnoLwN5bkKpbGUPpS2FQSCFcWQ9vu7SQtHehktsbXFaop
         co0cNCMZJwF5WOQAwBrlYotUiZQ0OI7gDvDebnF1IrlGhN2oMD9PtTCGM2OVERARPsgL
         p4RvDg6owC/wE9mlNsRfs3bgBziZ533frDa/IjY2Qe5uASmh++S0LpbslybdXf+kGXxg
         nK7sO93TgiD2zcI7Gc/dD0VwK0i8J0DrkZSOK/zkIfvX/hNG3HV/nlCPwKHjeRcK1Z6s
         Kapw==
X-Gm-Message-State: AOAM530CFkRR1Sz1CONXqRS/Hdm1ljnkYdMu/NmLIiKtm4LK53/f+385
        cYqrplA2Aw9nVwnz6oHUsSpCJKBY7h6x+vuqnQtl20G7+BpM
X-Google-Smtp-Source: ABdhPJy8hzpSJro6cMl9g+BVdFkchFCz0amXoYys752OUloZyyPj+9iNat4yd78Xphl7/kNH2+p1EE/Xh7QvlbhT0RIRmCi00BYP
MIME-Version: 1.0
X-Received: by 2002:a92:d312:: with SMTP id x18mr1882262ila.90.1622591901356;
 Tue, 01 Jun 2021 16:58:21 -0700 (PDT)
Date:   Tue, 01 Jun 2021 16:58:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e5560e05c3bd1d63@google.com>
Subject: [syzbot] UBSAN: shift-out-of-bounds in snd_timer_user_ccallback
From:   syzbot <syzbot+d102fa5b35335a7e544e@syzkaller.appspotmail.com>
To:     allen.lkml@gmail.com, alsa-devel@alsa-project.org, joe@perches.com,
        linux-kernel@vger.kernel.org, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com, romain.perier@gmail.com,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    5ff2756a Merge tag 'nfs-for-5.13-2' of git://git.linux-nfs..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17872d5bd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=770708ea7cfd4916
dashboard link: https://syzkaller.appspot.com/bug?extid=d102fa5b35335a7e544e

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d102fa5b35335a7e544e@syzkaller.appspotmail.com

================================================================================
UBSAN: shift-out-of-bounds in sound/core/timer.c:1376:23
shift exponent 105 is too large for 32-bit type 'int'
CPU: 1 PID: 10368 Comm: syz-executor.1 Not tainted 5.13.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 ubsan_epilogue+0xb/0x5a lib/ubsan.c:148
 __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x181 lib/ubsan.c:327
 snd_timer_user_ccallback.cold+0x19/0x1e sound/core/timer.c:1376
 snd_timer_notify1+0x243/0x3b0 sound/core/timer.c:525
 snd_timer_stop1+0x641/0x890 sound/core/timer.c:656
 snd_timer_pause+0x6e/0x90 sound/core/timer.c:738
 seq_timer_stop sound/core/seq/seq_timer.c:331 [inline]
 snd_seq_timer_stop+0x93/0xd0 sound/core/seq/seq_timer.c:341
 queue_delete+0x42/0xa0 sound/core/seq/seq_queue.c:133
 snd_seq_queue_client_leave+0x37/0x1a0 sound/core/seq/seq_queue.c:552
 seq_free_client1.part.0+0x10a/0x260 sound/core/seq/seq_clientmgr.c:280
 seq_free_client1 sound/core/seq/seq_clientmgr.c:273 [inline]
 seq_free_client+0x7b/0xf0 sound/core/seq/seq_clientmgr.c:301
 snd_seq_release+0x4d/0xe0 sound/core/seq/seq_clientmgr.c:382
 __fput+0x288/0x920 fs/file_table.c:280
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x272/0x280 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:301
 do_syscall_64+0x47/0xb0 arch/x86/entry/common.c:57
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4193eb
Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8 63 fc ff ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 a1 fc ff ff 8b 44
RSP: 002b:0000000000a9fb80 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 00000000004193eb
RDX: 0000000000571b58 RSI: ffffffff89166efe RDI: 0000000000000004
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000001b2ea280a8
R10: 00000000000001d1 R11: 0000000000000293 R12: 000000000014d248
R13: 00000000000003e8 R14: 000000000056bf80 R15: 000000000014d1dd
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
