Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270433BB6C6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 07:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbhGEF2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 01:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhGEF2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 01:28:10 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF28C061574
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 22:25:33 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id z12so6409059qtj.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 22:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=29D4N2OjqFiSu0N2V1LYXiKGOIL3UBzAUhg1hHXRCxc=;
        b=IsPmMLi2ui8KWus+2ECGnSEKu5fsonIhZqI0W+pfhhfbusligAsF8OXTlLSNBTtIOE
         qSlgQKnkbkg7z9IV+JEmitmoChxb3yWCry6Qcvyd9/VxYbVVlsfRAsbOKGbkhXVZVBt2
         +IQ1cmi/0Nulp7FnDa19fc49CViJ6uiUSB8gfHkbpLSAg5gFm7pIsBHa5g8OmIzrS5UR
         BRyF0NEW6A4JSdotnqhgyJFvFiggZdQkrq2GEST4nljm8QO8KDn9Fr7YO5dkHPVRFbAW
         KyvlquJPPaRoSKdi2ZIveh1edtOd5DK29IadLbyn0TZeYyjK4HRtecEZwVoCC/mgDRTA
         gvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=29D4N2OjqFiSu0N2V1LYXiKGOIL3UBzAUhg1hHXRCxc=;
        b=XnDpF3UFGiZIPXoLrZ8P3Dzx9qyEq9AQT3Qv/48PG1X3yS9P+HZZoUtXOh1DiGVYoX
         O3JZiEakHfAMeCGBmJ7WQx4C1CuMND10NGOKuxscCsSUCsUcfGfa4iCuNyGBz67SUcUN
         xPzJsM+jMbsX4NMBNN4tHdtFy3egTEavCtcTJZRO8RjHxX0xYFe/Uhf6D+kLkBRxSdMo
         CUyiIzaG/rCD5OHOMlNqJvxB5tx+BNCwxg2NO8+c0oO7kSLc+RiM8iLiMDYnhZZbj8Dw
         gJiCzUseEBFIerc07nokG7wBRj1k3PpDALUj5VmWPSd/JB2JbqO6nBDjJPR06h2RaMK2
         Quuw==
X-Gm-Message-State: AOAM530briSQtld4Xoqh3JMVFlQy56lG+PTumRaBryB0bqatK10XU3Gk
        ZXP9MxvE9ohayltzQPwhkOv7hVHNwDOuHfR2+gLyuw==
X-Google-Smtp-Source: ABdhPJwvdwGBqRP5krtM3opYb32zkzmMo/IQPmCOV/FO7PCmCIQRJNF1MUeisETNMyePGhNxzyj04eeMOoUVjygfEq0=
X-Received: by 2002:ac8:7d90:: with SMTP id c16mr11038817qtd.337.1625462730690;
 Sun, 04 Jul 2021 22:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000002aad2505c2af46c2@google.com>
In-Reply-To: <0000000000002aad2505c2af46c2@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 5 Jul 2021 07:25:19 +0200
Message-ID: <CACT4Y+YAbLFX4DY7FxD3yjZfmOuos0x=psoeFHmOKQBVoxvvPg@mail.gmail.com>
Subject: Re: [syzbot] WARNING: locking bug in complete_all
To:     syzbot <syzbot+0a94f55b21945de250e6@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 4:02 PM syzbot
<syzbot+0a94f55b21945de250e6@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    25a12987 Merge tag 'trace-v5.13-rc1' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16b425fdd00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ec0e727d62342a37
> dashboard link: https://syzkaller.appspot.com/bug?extid=0a94f55b21945de250e6
> compiler:       Debian clang version 11.0.1-2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+0a94f55b21945de250e6@syzkaller.appspotmail.com

There is a "KASAN: use-after-free Read in kill_pending_fw_fallback_reqs"
report which was marked as:

#syz dup: KASAN: use-after-free Read in firmware_fallback_sysfs


> ------------[ cut here ]------------
> DEBUG_LOCKS_WARN_ON(!test_bit(class_idx, lock_classes_in_use))
> WARNING: CPU: 1 PID: 14609 at kernel/locking/lockdep.c:4872 __lock_acquire+0x2741/0x6040 kernel/locking/lockdep.c:4872
> Modules linked in:
> CPU: 1 PID: 14609 Comm: syz-executor.1 Not tainted 5.13.0-rc1-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:__lock_acquire+0x2741/0x6040 kernel/locking/lockdep.c:4872
> Code: 1c 00 00 c7 44 24 28 00 00 00 00 48 c7 c7 20 94 2e 8a 48 c7 c6 00 c5 2e 8a 31 c0 e8 29 16 ea ff 49 b8 00 00 00 00 00 fc ff df <0f> 0b e9 d5 1b 00 00 0f 0b e9 e4 ec ff ff e8 2c 8c 5e 08 c7 44 24
> RSP: 0018:ffffc9000217efe0 EFLAGS: 00010046
> RAX: 81e596e45e282400 RBX: ffffffffab400119 RCX: 0000000000040000
> RDX: ffffc900095c9000 RSI: 0000000000002fee RDI: 0000000000002fef
> RBP: ffffc9000217f370 R08: dffffc0000000000 R09: ffffed1017363f24
> R10: ffffed1017363f24 R11: 0000000000000000 R12: ffff88802ab6df58
> R13: ffffc9000217f300 R14: ffff88802ab6d4c0 R15: ffff88802ab6df78
> FS:  00007fd2642f3700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000568000 CR3: 0000000099e41000 CR4: 00000000001526e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  lock_acquire+0x17f/0x720 kernel/locking/lockdep.c:5512
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>  _raw_spin_lock_irqsave+0xb3/0x100 kernel/locking/spinlock.c:159
>  complete_all+0x14/0x70 kernel/sched/completion.c:63
>  __fw_state_set drivers/base/firmware_loader/firmware.h:121 [inline]
>  fw_state_aborted drivers/base/firmware_loader/firmware.h:126 [inline]
>  __fw_load_abort drivers/base/firmware_loader/fallback.c:98 [inline]
>  kill_pending_fw_fallback_reqs+0x1e8/0x290 drivers/base/firmware_loader/fallback.c:119
>  fw_pm_notify+0x5d/0xe0 drivers/base/firmware_loader/main.c:1450
>  notifier_call_chain kernel/notifier.c:83 [inline]
>  notifier_call_chain_robust kernel/notifier.c:118 [inline]
>  blocking_notifier_call_chain_robust+0x13b/0x380 kernel/notifier.c:302
>  pm_notifier_call_chain_robust+0x27/0x50 kernel/power/main.c:87
>  snapshot_open+0x18a/0x260 kernel/power/user.c:75
>  misc_open+0x346/0x3c0 drivers/char/misc.c:141
>  chrdev_open+0x53b/0x5f0 fs/char_dev.c:414
>  do_dentry_open+0x7cb/0x1010 fs/open.c:826
>  do_open fs/namei.c:3361 [inline]
>  path_openat+0x28e6/0x39b0 fs/namei.c:3494
>  do_filp_open+0x221/0x460 fs/namei.c:3521
>  do_sys_openat2+0x124/0x460 fs/open.c:1187
>  do_sys_open fs/open.c:1203 [inline]
>  __do_sys_openat fs/open.c:1219 [inline]
>  __se_sys_openat fs/open.c:1214 [inline]
>  __x64_sys_openat+0x243/0x290 fs/open.c:1214
>  do_syscall_64+0x3f/0xb0 arch/x86/entry/common.c:47
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x4665d9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fd2642f3188 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: 000000000056bf60 RCX: 00000000004665d9
> RDX: 0000000000000000 RSI: 00000000200000c0 RDI: ffffffffffffff9c
> RBP: 00000000004bfcb9 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf60
> R13: 00007ffcd0d0c31f R14: 00007fd2642f3300 R15: 0000000000022000
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000002aad2505c2af46c2%40google.com.
