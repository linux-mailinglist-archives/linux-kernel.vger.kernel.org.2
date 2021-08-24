Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38AA03F69A0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 21:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbhHXTPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 15:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbhHXTPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 15:15:21 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E56C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 12:14:37 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u3so46513446ejz.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 12:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=hjAqUT+Fq6/TWZa/X42R0R7+2i4oUVHe3Y/7siyGu+8=;
        b=iDwJf5ecAx07otgWfeMwBbfxTlybCAZG9A/cTmWl6CVeIAkhuvdbqRqaLkEFQxOoff
         LOD6dAvAjyE6rpLGvou+zH8C7+TFg8U8DF3Ybbd8z4aSuGc2EQGeJM/XRRv8yD+oQXtY
         Ve6CLaywqobWYicpjerqkQgFLmkVdPi0gTZP27RmRrBt/1Mitiwp5FbmgNE3mkfyLlmA
         vzX/id0G2Gi1CprPJTiXtMRbW9Fu6n2bxHMlHT1xpjtt3YWFofHJzTW7pcAakbAEREl9
         k0bzKvBa1cT6F82PKiDcIkafU2vFaOUoxyaiZCq6EM4geAe6dmCyA0kebjU/mMJeoP15
         5/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=hjAqUT+Fq6/TWZa/X42R0R7+2i4oUVHe3Y/7siyGu+8=;
        b=aSH4q5B11UC47Be/M6cWEV47TMcYVTXtK03rrZGKd6SqUiQoR7H6FGx/3W0ucM5HZ/
         XBwNnms0UAtrH99uk+Ucs04Pqp2U3dZOndXxJcM6nwH26Yyq8z5yIpP1Pn/1NJutDf7E
         /NeSmZdbeSdyOISubopfQDN+TXDVitPuIIREwFKfzG2e+ED7WP9JpRaeFMbRBuwcIK2B
         qPSU6koKh/HFaREtu+TE5usvzN3d8ZY0UG1Vn9SiKSLHVZLDWpUNxSc97xr2Rps49nHd
         JrFcIxcPKcDyIq8rTYJSA8lpCLRnH3sLkCxvteaElKt4tIZo1aCPnp3tY5BiLIHBph7c
         0t6Q==
X-Gm-Message-State: AOAM532H5rY39jVbV9BIPbd9+pcLyg/fwBrZ/ewxXVrPgyZWfvQhctvK
        lr+gy4/dhVokx7+VLPha91stLiCJGGx2BwqFH1Q=
X-Google-Smtp-Source: ABdhPJzsDCTe3wfMdNxcPqfUK85GEpBMkDKxvvVqdmKhOOEfP8rZmA97McCPoPgD8BUG+rWStNL4A4O7vLlC3/EwJ7o=
X-Received: by 2002:a17:906:a399:: with SMTP id k25mr581529ejz.514.1629832475751;
 Tue, 24 Aug 2021 12:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000007510305ca5225b0@google.com> <CAHbLzkpgQtnvK6qHL1+cnHKZQgniq0wzSLTdYTDC5Bn-NbCD_g@mail.gmail.com>
In-Reply-To: <CAHbLzkpgQtnvK6qHL1+cnHKZQgniq0wzSLTdYTDC5Bn-NbCD_g@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 24 Aug 2021 12:14:23 -0700
Message-ID: <CAHbLzkrmvOeBtFu1xE9Q+ZCiafHsUg4YZLb6Vh+V6=hNdwGZaw@mail.gmail.com>
Subject: Re: [syzbot] kernel BUG in collapse_file
To:     syzbot <syzbot+f17e5ab118d29367bda9@syzkaller.appspotmail.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 12:13 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Tue, Aug 24, 2021 at 11:17 AM syzbot
> <syzbot+f17e5ab118d29367bda9@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    d6d09a694205 Merge tag 'for-5.14-rc6-tag' of git://git.ker..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=14924605300000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=f61012d0b1cd846f
> > dashboard link: https://syzkaller.appspot.com/bug?extid=f17e5ab118d29367bda9
> > compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+f17e5ab118d29367bda9@syzkaller.appspotmail.com
> >
> >  unmap_region+0x2ab/0x300 mm/mmap.c:2680
> >  __do_munmap+0x18eb/0x2050 mm/mmap.c:2911
> >  __do_sys_mremap+0x5d9/0x1390 mm/mremap.c:969
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > ------------[ cut here ]------------
> > kernel BUG at mm/khugepaged.c:1830!
>
> The BUG means the page is not fully unmapped due to some race, just
> like what https://lore.kernel.org/linux-mm/00000000000030563005ca006ffd@google.com/
> reported.
>
> But I really don't think it is worth VM_BUG since khugepaged can just back off.

Forgot cc to other stakeholders.

>
> > invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> > CPU: 0 PID: 1651 Comm: khugepaged Not tainted 5.14.0-rc6-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > RIP: 0010:collapse_file+0x3537/0x36e0 mm/khugepaged.c:1830
> > Code: e8 1e 7a b2 ff 48 89 df 48 c7 c6 40 7b 3d 8a e8 ef 02 e8 ff 0f 0b e8 08 7a b2 ff 48 89 df 48 c7 c6 a0 7b 3d 8a e8 d9 02 e8 ff <0f> 0b e8 f2 79 b2 ff 4c 89 e7 48 c7 c6 a0 7e 3d 8a e8 c3 02 e8 ff
> > RSP: 0018:ffffc900066df820 EFLAGS: 00010046
> > RAX: 8601299b4ae62f00 RBX: ffffea0000e4e240 RCX: ffff888018fed4c0
> > RDX: 0000000000000000 RSI: 000000000000ffff RDI: 000000000000ffff
> > RBP: ffffc900066dfa90 R08: ffffffff81d08764 R09: ffffed1017383f2c
> > R10: ffffed1017383f2c R11: 0000000000000000 R12: ffffc900066df9d8
> > R13: dffffc0000000000 R14: ffffc900066dfa20 R15: 0000000000000001
> > FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000100000000 CR3: 000000000c48e000 CR4: 00000000001506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  khugepaged_scan_file mm/khugepaged.c:2051 [inline]
> >  khugepaged_scan_mm_slot+0x27be/0x2ad0 mm/khugepaged.c:2146
> >  khugepaged_do_scan+0x2b1/0x640 mm/khugepaged.c:2230
> >  khugepaged+0x105/0x890 mm/khugepaged.c:2275
> >  kthread+0x453/0x480 kernel/kthread.c:319
> >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> > Modules linked in:
> > ---[ end trace 8de2a60ea4ac5483 ]---
> > RIP: 0010:collapse_file+0x3537/0x36e0 mm/khugepaged.c:1830
> > Code: e8 1e 7a b2 ff 48 89 df 48 c7 c6 40 7b 3d 8a e8 ef 02 e8 ff 0f 0b e8 08 7a b2 ff 48 89 df 48 c7 c6 a0 7b 3d 8a e8 d9 02 e8 ff <0f> 0b e8 f2 79 b2 ff 4c 89 e7 48 c7 c6 a0 7e 3d 8a e8 c3 02 e8 ff
> > RSP: 0018:ffffc900066df820 EFLAGS: 00010046
> > RAX: 8601299b4ae62f00 RBX: ffffea0000e4e240 RCX: ffff888018fed4c0
> > RDX: 0000000000000000 RSI: 000000000000ffff RDI: 000000000000ffff
> > RBP: ffffc900066dfa90 R08: ffffffff81d08764 R09: ffffed1017383f2c
> > R10: ffffed1017383f2c R11: 0000000000000000 R12: ffffc900066df9d8
> > R13: dffffc0000000000 R14: ffffc900066dfa20 R15: 0000000000000001
> > FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000100000000 CR3: 000000000c48e000 CR4: 00000000001506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > ----------------
> > Code disassembly (best guess):
> >    0:   e8 1e 7a b2 ff          callq  0xffb27a23
> >    5:   48 89 df                mov    %rbx,%rdi
> >    8:   48 c7 c6 40 7b 3d 8a    mov    $0xffffffff8a3d7b40,%rsi
> >    f:   e8 ef 02 e8 ff          callq  0xffe80303
> >   14:   0f 0b                   ud2
> >   16:   e8 08 7a b2 ff          callq  0xffb27a23
> >   1b:   48 89 df                mov    %rbx,%rdi
> >   1e:   48 c7 c6 a0 7b 3d 8a    mov    $0xffffffff8a3d7ba0,%rsi
> >   25:   e8 d9 02 e8 ff          callq  0xffe80303
> >   2a:   0f 0b                   ud2     <-- trapping instruction
> >   2c:   e8 f2 79 b2 ff          callq  0xffb27a23
> >   31:   4c 89 e7                mov    %r12,%rdi
> >   34:   48 c7 c6 a0 7e 3d 8a    mov    $0xffffffff8a3d7ea0,%rsi
> >   3b:   e8 c3 02 e8 ff          callq  0xffe80303
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
