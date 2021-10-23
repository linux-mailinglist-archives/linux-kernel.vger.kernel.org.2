Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D58438503
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 21:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbhJWTho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 15:37:44 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:45747 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhJWThj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 15:37:39 -0400
Received: by mail-io1-f71.google.com with SMTP id k9-20020a5d91c9000000b005dc4a740599so5721695ior.12
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 12:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=o4rd6Mkpq1AQ9on8hbgP8TELF/6kZHRbq1idq5wO+Cg=;
        b=Mh2fvKFNhSJkyMQ5OkuxkOE8iudi8DfcAuDUIMEoh8p67XCrQg6gf1a6C0Zg0uKbTV
         S8lsG+1q8X0XbDzMbIX356mQ7MTJC9p6z8GA0BX2YsOpm2agNfXt6wlCTDpbwX2HgJKk
         jlg0U4wp7Mg6h+voPdBC5IDRznWerAy+wUTkOy5DH0mAcT7KfztJWD/RGZ8nVuuhNqMd
         Tbke/7F/jppbG+1DRHYTkDrWR7qvU4wKyYWk6DUUCqa91044hYAsXg3mDk33dtXQWqMN
         jQwYFpYWrRnsp/7k8deTUPTqDHFGXYUfOZ05NpxISfyUSOpBOJR4xd8d8agGWwF6ja64
         gQRw==
X-Gm-Message-State: AOAM532O/WzlGtQAO+hoy8nbGSEw7GvWiER3oTvLQv/DCIjVF5RDbCKB
        ZB2lw7PUmQh631pxOXRmJ4I3LmNPtJHMtKe6DiAREVj2Owuy
X-Google-Smtp-Source: ABdhPJxqeaA8sqy0hYo/N8XZ/mP7Bmwj6PvbQPnGG8m5GoXOyi3MUdxVMrBtjvxiL4mT0sqR6GdRN//I5PYwMHdxniP/22qBpYQS
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14d2:: with SMTP id b18mr4688430iow.123.1635017720046;
 Sat, 23 Oct 2021 12:35:20 -0700 (PDT)
Date:   Sat, 23 Oct 2021 12:35:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000067a98805cf0a3a98@google.com>
Subject: [syzbot] possible deadlock in snd_mixer_oss_ioctl1
From:   syzbot <syzbot+ace149a75a9a0a399ac7@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, broonie@kernel.org, joe@perches.com,
        lars@metafoo.de, linux-kernel@vger.kernel.org, perex@perex.cz,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com, tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    cf6c9d12750c Add linux-next specific files for 20211022
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15d3d4c4b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e694204255ade3a3
dashboard link: https://syzkaller.appspot.com/bug?extid=ace149a75a9a0a399ac7
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17c0530cb00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1129c952b00000

The issue was bisected to:

commit 411cef6adfb38a5bb6bd9af3941b28198e7fb680
Author: Takashi Iwai <tiwai@suse.de>
Date:   Wed Oct 20 16:48:46 2021 +0000

    ALSA: mixer: oss: Fix racy access to slots

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=167f6454b00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=157f6454b00000
console output: https://syzkaller.appspot.com/x/log.txt?x=117f6454b00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ace149a75a9a0a399ac7@syzkaller.appspotmail.com
Fixes: 411cef6adfb3 ("ALSA: mixer: oss: Fix racy access to slots")

============================================
WARNING: possible recursive locking detected
5.15.0-rc6-next-20211022-syzkaller #0 Not tainted
--------------------------------------------
syz-executor206/6529 is trying to acquire lock:
ffff888021ff09c8 (&mixer->reg_mutex){+.+.}-{3:3}, at: snd_mixer_oss_set_volume sound/core/oss/mixer_oss.c:316 [inline]
ffff888021ff09c8 (&mixer->reg_mutex){+.+.}-{3:3}, at: snd_mixer_oss_ioctl1+0x630/0x19a0 sound/core/oss/mixer_oss.c:375

but task is already holding lock:
ffff888021ff09c8 (&mixer->reg_mutex){+.+.}-{3:3}, at: snd_mixer_oss_set_volume sound/core/oss/mixer_oss.c:300 [inline]
ffff888021ff09c8 (&mixer->reg_mutex){+.+.}-{3:3}, at: snd_mixer_oss_ioctl1+0x4b1/0x19a0 sound/core/oss/mixer_oss.c:375

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&mixer->reg_mutex);
  lock(&mixer->reg_mutex);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

1 lock held by syz-executor206/6529:
 #0: ffff888021ff09c8 (&mixer->reg_mutex){+.+.}-{3:3}, at: snd_mixer_oss_set_volume sound/core/oss/mixer_oss.c:300 [inline]
 #0: ffff888021ff09c8 (&mixer->reg_mutex){+.+.}-{3:3}, at: snd_mixer_oss_ioctl1+0x4b1/0x19a0 sound/core/oss/mixer_oss.c:375

stack backtrace:
CPU: 0 PID: 6529 Comm: syz-executor206 Not tainted 5.15.0-rc6-next-20211022-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_deadlock_bug kernel/locking/lockdep.c:2956 [inline]
 check_deadlock kernel/locking/lockdep.c:2999 [inline]
 validate_chain kernel/locking/lockdep.c:3788 [inline]
 __lock_acquire.cold+0x149/0x3ab kernel/locking/lockdep.c:5027
 lock_acquire kernel/locking/lockdep.c:5637 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
 __mutex_lock_common kernel/locking/mutex.c:607 [inline]
 __mutex_lock+0x12f/0x12f0 kernel/locking/mutex.c:740
 snd_mixer_oss_set_volume sound/core/oss/mixer_oss.c:316 [inline]
 snd_mixer_oss_ioctl1+0x630/0x19a0 sound/core/oss/mixer_oss.c:375
 snd_mixer_oss_ioctl+0x40/0x50 sound/core/oss/mixer_oss.c:390
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f0c06979fe9
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffea97dd558 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0c06979fe9
RDX: 0000000020000080 RSI: 00000000c0044d00 RDI: 0000000000000003
RBP: 00007f0c0693dfd0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f0c0693e060
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
