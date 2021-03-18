Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447E83403E2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 11:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhCRKvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 06:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbhCRKu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 06:50:59 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46905C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 03:50:59 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id f12so3680147qtq.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 03:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c0bBuJXJtSVD2VRbXXGWuUifU0x3U/uJ3IIhVzj5yUg=;
        b=dJN4orhv3ohTJhEfLDveu0DoPVS5X52Ojuodmr7kgiBVlW186n7r4QvM05tNl6+Azi
         QnKxwYW+SgS+0+FKCM2jCSRDnHt93vLOYjZxQauB68/AHjDNNEevng2kQ7+SPEUhKB0n
         z/jcJ81FFZwLp6I4b16YG8M+WHZEw75W27LX0CKcZlyfsig4nIUcBlgVnnM9eyfzaL4A
         ywX/jEzOJzo7BSoejH0elx1icbZf/wc2phEcw6OXIxV4X2CnZIT9eohMCaj5fIBx7ebF
         FSPOx3PuHvwtyx7m91L/VMdW3lvGAPCs3mbLmzyh0r8q6wGB8gZcF+0ru97ENaBoGOuZ
         bOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c0bBuJXJtSVD2VRbXXGWuUifU0x3U/uJ3IIhVzj5yUg=;
        b=DMJHqJ6f+0G9oTCJ7Vj93IL8goUDsXu7b0+U6f/EH4+xHENQW1tBFVjxVXQ2kIY0v9
         vuA95hwmNvKKbFt5wg/HysBB9f0ZmO542hvyGEuaNvraZISLB0Sv47eglK20edCUlaj/
         kQApr81dlhg/x/FAF0f2btmk/Kmbds/HT6rHIhignVUE2eXPi/a0OOz5KTzFvW4h1pXC
         ngVcfsnRSs577ljOLq5lfckX9RXc3jLjpYSpMMQFugiL8VVkDhZMpmCE5GsN6QWo1FUD
         rY+2HH9NhS/4XdxaX2rMg384kl7+jZ31NUE5JHjOV2tM6qjf68vqJNRf9HKcXuM+d8Zs
         btiA==
X-Gm-Message-State: AOAM532EIaLFKBUqbjxsBMutx+ETDVvnOGHYdkWVzJBJAzc9zjsa0MEB
        8ogixUIpSMs4WkbbgDvOuUGcWI3Yp2zyxtohtm5VwA==
X-Google-Smtp-Source: ABdhPJyUrzwkoEI85Y/T0RisRyUiYMYkNYDVsDe7Il/4gVbHkmO731Bqul6Z9mZsAmTOA+MmG7DNE/j2+l6ssQXx6Lg=
X-Received: by 2002:a05:622a:c3:: with SMTP id p3mr2989066qtw.43.1616064658229;
 Thu, 18 Mar 2021 03:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000067e37805b5623d10@google.com>
In-Reply-To: <00000000000067e37805b5623d10@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 18 Mar 2021 11:50:47 +0100
Message-ID: <CACT4Y+bRJBE8YXXp4m82AQPDHFWDtx78z=S+ePiUnw9mOdGyWw@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel paging request in workingset_age_nonresident
To:     syzbot <syzbot+a59e7ceb87a83c5233df@syzkaller.appspotmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 8:40 AM syzbot
<syzbot+a59e7ceb87a83c5233df@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    c6b11acc Add linux-next specific files for 20201130
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=114b94e9500000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b5e03844e9b34d37
> dashboard link: https://syzkaller.appspot.com/bug?extid=a59e7ceb87a83c5233df
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=150fed8b500000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1726291d500000
>
> The issue was bisected to:
>
> commit 76761ffa9ea1ddca78e817bf7eec5fcb0378a00c
> Author: Alex Shi <alex.shi@linux.alibaba.com>
> Date:   Sun Nov 29 23:58:06 2020 +0000
>
>     mm/memcg: bail out early when !memcg in mem_cgroup_lruvec

This patch was removed from linux-next, so let's close the report:

#syz invalid


> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=122ff445500000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=112ff445500000
> console output: https://syzkaller.appspot.com/x/log.txt?x=162ff445500000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+a59e7ceb87a83c5233df@syzkaller.appspotmail.com
> Fixes: 76761ffa9ea1 ("mm/memcg: bail out early when !memcg in mem_cgroup_lruvec")
>
> BUG: unable to handle page fault for address: ffffffff81417c79
> #PF: supervisor write access in kernel mode
> #PF: error_code(0x0003) - permissions violation
> PGD b08f067 P4D b08f067 PUD b090063 PMD 14001e1
> Oops: 0003 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 8503 Comm: syz-executor118 Not tainted 5.10.0-rc5-next-20201130-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:mem_cgroup_lruvec include/linux/memcontrol.h:630 [inline]
> RIP: 0010:parent_lruvec include/linux/memcontrol.h:1560 [inline]
> RIP: 0010:workingset_age_nonresident+0x179/0x1c0 mm/workingset.c:242
> Code: 85 db 0f 85 c8 fe ff ff 5b 5d 41 5c 41 5d 41 5e 41 5f e9 6a 67 cf ff e8 65 67 cf ff 49 8d 9d 18 4d 00 00 eb b3 e8 57 67 cf ff <4c> 89 ab c0 00 00 00 eb c7 e8 69 35 12 00 e9 d3 fe ff ff e8 5f 35
> RSP: 0018:ffffc9000112f4c0 EFLAGS: 00010093
> RAX: 0000000000000000 RBX: ffffffff81417bb9 RCX: 0000000000000000
> RDX: ffff88801eee5040 RSI: ffffffff81a159f9 RDI: ffffffff81417c79
> RBP: dffffc0000000000 R08: 0000000000000001 R09: ffff88813ffffdbf
> R10: ffffed1027ffffb7 R11: 0000000000000000 R12: ffffffff8e7911d0
> R13: ffff88813fffb000 R14: 0000000000000001 R15: ffffffff8e7910b0
> FS:  0000000002581880(0000) GS:ffff8880b9f00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffff81417c79 CR3: 0000000013a2f000 CR4: 00000000001506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  workingset_eviction+0x452/0x9b0 mm/workingset.c:266
>  __remove_mapping+0x867/0xd20 mm/vmscan.c:927
>  shrink_page_list+0x246a/0x5e80 mm/vmscan.c:1431
>  reclaim_pages+0x3e2/0xcd0 mm/vmscan.c:2148
>  madvise_cold_or_pageout_pte_range+0x1615/0x2880 mm/madvise.c:473
>  walk_pmd_range mm/pagewalk.c:89 [inline]
>  walk_pud_range mm/pagewalk.c:160 [inline]
>  walk_p4d_range mm/pagewalk.c:193 [inline]
>  walk_pgd_range mm/pagewalk.c:229 [inline]
>  __walk_page_range+0xda4/0x1e20 mm/pagewalk.c:331
>  walk_page_range+0x1be/0x450 mm/pagewalk.c:427
>  madvise_pageout_page_range mm/madvise.c:526 [inline]
>  madvise_pageout+0x21b/0x390 mm/madvise.c:562
>  madvise_vma mm/madvise.c:943 [inline]
>  do_madvise.part.0+0x9f2/0x1ed0 mm/madvise.c:1142
>  do_madvise mm/madvise.c:1168 [inline]
>  __do_sys_madvise mm/madvise.c:1168 [inline]
>  __se_sys_madvise mm/madvise.c:1166 [inline]
>  __x64_sys_madvise+0x113/0x150 mm/madvise.c:1166
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x440279
> Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffe7c1ab298 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
> RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440279
> RDX: 0000000000000015 RSI: 0000000000600003 RDI: 0000000020000000
> RBP: 00000000006ca018 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000401a80
> R13: 0000000000401b10 R14: 0000000000000000 R15: 0000000000000000
> Modules linked in:
> CR2: ffffffff81417c79
> ---[ end trace 89bcebda47215cf6 ]---
> RIP: 0010:mem_cgroup_lruvec include/linux/memcontrol.h:630 [inline]
> RIP: 0010:parent_lruvec include/linux/memcontrol.h:1560 [inline]
> RIP: 0010:workingset_age_nonresident+0x179/0x1c0 mm/workingset.c:242
> Code: 85 db 0f 85 c8 fe ff ff 5b 5d 41 5c 41 5d 41 5e 41 5f e9 6a 67 cf ff e8 65 67 cf ff 49 8d 9d 18 4d 00 00 eb b3 e8 57 67 cf ff <4c> 89 ab c0 00 00 00 eb c7 e8 69 35 12 00 e9 d3 fe ff ff e8 5f 35
> RSP: 0018:ffffc9000112f4c0 EFLAGS: 00010093
> RAX: 0000000000000000 RBX: ffffffff81417bb9 RCX: 0000000000000000
> RDX: ffff88801eee5040 RSI: ffffffff81a159f9 RDI: ffffffff81417c79
> RBP: dffffc0000000000 R08: 0000000000000001 R09: ffff88813ffffdbf
> R10: ffffed1027ffffb7 R11: 0000000000000000 R12: ffffffff8e7911d0
> R13: ffff88813fffb000 R14: 0000000000000001 R15: ffffffff8e7910b0
> FS:  0000000002581880(0000) GS:ffff8880b9f00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffff81417c79 CR3: 0000000013a2f000 CR4: 00000000001506e0
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
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000067e37805b5623d10%40google.com.
