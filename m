Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA053BB6C7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 07:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhGEF2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 01:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhGEF2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 01:28:34 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2DFC061574
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 22:25:57 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id m13so3277193qvv.11
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 22:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=34I4yvT8jGjlJ0yGzVHqo1KwygZc7NYq1rsQOqZBlsg=;
        b=OV1+VXrNeeewTCYKpzVQPBuQFr8LM4OOxrUSiTvt6ichqUkORYAe92SvrKOmcXHqiw
         oXbz1SI3+rV4goaYfYdZCGRJ5xTKtSR67Jb+R6AlHFSnbl4m6o+30tvh74JrPsqjUHCE
         as6TrDkN23nouY6Ie6wlDLl/pP/VqyIH1ihOUyE0KLW/DbGxP2FJ2k+/I89twprKAjR/
         mcloh0nB2vDWiciRtyATF8cqDUMD3bjZzxw4UB1TR4L0MP2L+DvRHTj3DoIGdS9jgkMv
         063Lji3XkNLU9RCxMWQEe9u0BbENDHDDxbXdnKDnmo9Tqv+b8Bxe4rVqZlR5JV1b+jDd
         wRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=34I4yvT8jGjlJ0yGzVHqo1KwygZc7NYq1rsQOqZBlsg=;
        b=oOR5m891PGyJqc+iZniuIXKZ06K0q04SQkSXwMCXVHU7I31PtbFhlLuhhKgndxZRe8
         SFrBvFatKTzKLxaSvZhk5w9njRFXbe0zxZMaETRfnrKZGOwKmVEuazFD1oh7AQUKSS5l
         qeWHBr/HOcWV9c6nO80b33TApyhwXcG60YUOqTTNcF9ciFIodPdMhpDapOf2AbWgIBzq
         1slos/kf9U4LuQtPSn7dbULzKr24TtKogoJNHYtMhVhjLTg0KJqy6stCh84aTUWm9s4Z
         pCkN8Ckk8CE+RyjC3s7ipJr7aIOnVem2Xzavf9vmSuL35f4pVIPvL12t69CpYRYKb6/W
         SOsg==
X-Gm-Message-State: AOAM530Zo9JZ914j6mga0aejd5dSm9g0+OMvP+mK58R48quzhDPRCF3y
        Elx49y8L12D5DSM/IDehJ9ZqXLp8yvUuevjJKTTiqA==
X-Google-Smtp-Source: ABdhPJwSs0FdjeuWqtWbE4ICBNEiEGmCzMpTQQvaWeSjB8vj/axro090xQsi3I2jhOyW2w37WMCCj/nVICGkvEvLz7g=
X-Received: by 2002:a05:6214:1028:: with SMTP id k8mr11383777qvr.13.1625462756531;
 Sun, 04 Jul 2021 22:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000001562305c6598113@google.com>
In-Reply-To: <00000000000001562305c6598113@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 5 Jul 2021 07:25:45 +0200
Message-ID: <CACT4Y+Y8TPRAdhbMwqwCy+ifjKkPyUT8xfBOSxP47R-S8YGx5A@mail.gmail.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in complete_all
To:     syzbot <syzbot+33b3d0101e32bc3620fa@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 5, 2021 at 7:23 AM syzbot
<syzbot+33b3d0101e32bc3620fa@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    c54b245d Merge branch 'for-linus' of git://git.kernel.org/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17bf831c300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cf67b65fb52b173a
> dashboard link: https://syzkaller.appspot.com/bug?extid=33b3d0101e32bc3620fa
> compiler:       Debian clang version 11.0.1-2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+33b3d0101e32bc3620fa@syzkaller.appspotmail.com

There is a "KASAN: use-after-free Read in kill_pending_fw_fallback_reqs"
report which was marked as:

#syz dup: KASAN: use-after-free Read in firmware_fallback_sysfs

> BUG: unable to handle page fault for address: fffffbfff35c9873
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 23ffe5067 P4D 23ffe5067 PUD 23ffe4067 PMD 0
> Oops: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 17267 Comm: syz-executor.0 Not tainted 5.13.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:85 [inline]
> RIP: 0010:memory_is_nonzero mm/kasan/generic.c:102 [inline]
> RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:128 [inline]
> RIP: 0010:memory_is_poisoned mm/kasan/generic.c:159 [inline]
> RIP: 0010:check_region_inline mm/kasan/generic.c:177 [inline]
> RIP: 0010:kasan_check_range+0x80/0x2f0 mm/kasan/generic.c:186
> Code: 00 00 fc ff df 4d 01 ea 4d 89 d6 4d 29 ce 49 83 fe 10 7f 30 4d 85 f6 0f 84 ae 01 00 00 4c 89 cb 4c 29 d3 0f 1f 80 00 00 00 00 <45> 0f b6 19 45 84 db 0f 85 f3 01 00 00 49 ff c1 48 ff c3 75 eb e9
> RSP: 0018:ffffc900068defd0 EFLAGS: 00010097
> RAX: 000000000157aa01 RBX: ffffffffffffffff RCX: ffffffff8162c4be
> RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff9ae4c398
> RBP: ffffc900068df390 R08: dffffc0000000000 R09: fffffbfff35c9873
> R10: fffffbfff35c9874 R11: 0000000000000000 R12: 1ffffffff35c9873
> R13: dffffc0000000001 R14: 0000000000000001 R15: ffff888024965580
> FS:  00007f1f7a0b4700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: fffffbfff35c9873 CR3: 000000002c2d2000 CR4: 00000000001506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  instrument_atomic_read include/linux/instrumented.h:71 [inline]
>  test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
>  __lock_acquire+0xdee/0x6100 kernel/locking/lockdep.c:4985
>  lock_acquire+0x182/0x4a0 kernel/locking/lockdep.c:5625
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
>  do_syscall_64+0x39/0xa0 arch/x86/entry/common.c:47
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x4665d9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f1f7a0b4188 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665d9
> RDX: 0000000000000000 RSI: 0000000020000400 RDI: ffffffffffffff9c
> RBP: 00000000004bfcb9 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf80
> R13: 00007fff6b483a3f R14: 00007f1f7a0b4300 R15: 0000000000022000
> Modules linked in:
> CR2: fffffbfff35c9873
> ---[ end trace fe0e0b7a0a00e11d ]---
> RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:85 [inline]
> RIP: 0010:memory_is_nonzero mm/kasan/generic.c:102 [inline]
> RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:128 [inline]
> RIP: 0010:memory_is_poisoned mm/kasan/generic.c:159 [inline]
> RIP: 0010:check_region_inline mm/kasan/generic.c:177 [inline]
> RIP: 0010:kasan_check_range+0x80/0x2f0 mm/kasan/generic.c:186
> Code: 00 00 fc ff df 4d 01 ea 4d 89 d6 4d 29 ce 49 83 fe 10 7f 30 4d 85 f6 0f 84 ae 01 00 00 4c 89 cb 4c 29 d3 0f 1f 80 00 00 00 00 <45> 0f b6 19 45 84 db 0f 85 f3 01 00 00 49 ff c1 48 ff c3 75 eb e9
> RSP: 0018:ffffc900068defd0 EFLAGS: 00010097
> RAX: 000000000157aa01 RBX: ffffffffffffffff RCX: ffffffff8162c4be
> RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff9ae4c398
> RBP: ffffc900068df390 R08: dffffc0000000000 R09: fffffbfff35c9873
> R10: fffffbfff35c9874 R11: 0000000000000000 R12: 1ffffffff35c9873
> R13: dffffc0000000001 R14: 0000000000000001 R15: ffff888024965580
> FS:  00007f1f7a0b4700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: fffffbfff35c9873 CR3: 000000002c2d2000 CR4: 00000000001506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000001562305c6598113%40google.com.
