Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0AB3F698E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 21:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbhHXTKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 15:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbhHXTKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 15:10:43 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EB9C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 12:09:59 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a25so19742585ejv.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 12:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VGiZpft4TGFevZ6VBGb5LQZhuit7rOqCKoP3Bomq18c=;
        b=DDHE5zeECmRZNcALFaBWPLf9sR21yu6l0PHvHNWkzzaryO1X/ttVAiGxZoLGNCd6Sn
         aPk0W0CR53XlcnYyGBqp9G6a7wJCcZYfBQUGj/RumNYCGnzmok/TeBDzaTtRuJAsmaOz
         bZ2ahDGjD5+XKJV7nb/l7NLNQ9LAc9520TNLwgacVCHUgPADZ0d9CvveHAK+4R9dogQr
         hkmxm+v4F5gxqT/+A747bThnUaLMMcRKF7v1FXdVnwmQaYiAdz1XdEkXmXsh08KHwzEw
         nfSuLWmvYAh4SRU4IZa9LjFATgGxsV11gQ5KDM3Vg8uYh4cDph8uiRzKVbMl11DkmAg1
         dFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VGiZpft4TGFevZ6VBGb5LQZhuit7rOqCKoP3Bomq18c=;
        b=VD+dKQef4FkIwFCWP+CHSof65aMcdmRRa4UKG9q8qo5j9xeZZIt1DcCHtLiKf6aLNO
         vz65HSl3rbD5R6PF5SyzEM3KnQGrK/aSjOYEg6evB34/gcWBvza6fxUcmjeE28d2DlwH
         Y56lAtYF/thOQ10PbP+4J2hmR2SSONNUOfVQb0shse/Krd55525nDX/6MRfVJeeMmbKy
         XxkYM2qdCjnnVbBhNokkQm8KqFjfCwSnoAyUTlL3sVPisOn8VisH3/E3QDE8zS8YtbNF
         A8ecat7vsY8mIBw9vPeXLVHUmok3/sY+zbCHBVzADVV9tA+xMg7zl9G0wsKJGpQabIt2
         lAOA==
X-Gm-Message-State: AOAM532SUhuT9M+R9lk/DC9ogALSJ9OjEokktE5N6o5m1nnWf4VsLC0X
        QibTAamFxDzU4ghdvahqv5PsOtrEj2F6JINzBGw=
X-Google-Smtp-Source: ABdhPJzMNULv0xUUtcBfXmHqOolWupDvJqc+H+3nNN+2EEliimKRqaOCKm6gTyzncksHHCEX13f9YBhLumL5tMZPhk4=
X-Received: by 2002:a17:906:1f82:: with SMTP id t2mr41651061ejr.499.1629832197896;
 Tue, 24 Aug 2021 12:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000030563005ca006ffd@google.com> <03606e7d-dc38-a439-cd39-3f62b5739db0@suse.cz>
In-Reply-To: <03606e7d-dc38-a439-cd39-3f62b5739db0@suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 24 Aug 2021 12:09:45 -0700
Message-ID: <CAHbLzkrKRUymXEz6EFQ4RafQByEgGxNe278o=xaqtMgbxjM7sg@mail.gmail.com>
Subject: Re: [syzbot] WARNING in split_huge_page_to_list
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     syzbot <syzbot+0c65e03871b364e714a3@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, syzkaller-bugs@googlegroups.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 4:41 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> That's VM_WARN_ON_ONCE_PAGE(page_mapped(page), page);
> CC folks involved in 504e070dc08f ("mm: thp: replace DEBUG_VM BUG with VM_WARN
> when unmap fails for split")

There might be race between THP split and page unmap, and THP split
code can handle it, so it is not worth a VM_BUG.

Hugh fixed a couple of potential races, but there might be others.

>
> On 8/20/21 18:48, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    f87d64319e6f Merge tag 'net-5.14-rc7' of git://git.kernel...
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1205bd55300000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3205625db2f96ac9
> > dashboard link: https://syzkaller.appspot.com/bug?extid=0c65e03871b364e714a3
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+0c65e03871b364e714a3@syzkaller.appspotmail.com
> >
> >  __do_munmap+0x627/0x11c0 mm/mmap.c:2911
> >  do_munmap mm/mmap.c:2922 [inline]
> >  munmap_vma_range mm/mmap.c:604 [inline]
> >  mmap_region+0x85a/0x1760 mm/mmap.c:1753
> >  do_mmap+0x86e/0x1180 mm/mmap.c:1584
> >  vm_mmap_pgoff+0x1b7/0x290 mm/util.c:519
> >  ksys_mmap_pgoff+0x4a8/0x620 mm/mmap.c:1635
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 2144 at mm/huge_memory.c:2327 unmap_page mm/huge_memory.c:2327 [inline]
> > WARNING: CPU: 0 PID: 2144 at mm/huge_memory.c:2327 split_huge_page_to_list+0x25eb/0x3e60 mm/huge_memory.c:2700
> > Modules linked in:
> > CPU: 0 PID: 2144 Comm: kswapd1 Not tainted 5.14.0-rc6-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > RIP: 0010:unmap_page mm/huge_memory.c:2327 [inline]
> > RIP: 0010:split_huge_page_to_list+0x25eb/0x3e60 mm/huge_memory.c:2700
> > Code: 89 de e8 28 e1 b6 ff 84 db 0f 85 54 e0 ff ff e8 6b d9 b6 ff 48 c7 c6 e0 d8 97 89 48 89 ef e8 9c 72 e9 ff c6 05 05 dd 99 0b 01 <0f> 0b e9 32 e0 ff ff bb 02 00 00 00 e9 64 ef ff ff e8 3f d9 b6 ff
> > RSP: 0018:ffffc900084f76d8 EFLAGS: 00010293
> > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> > RDX: ffff88801c44c000 RSI: ffffffff81be0514 RDI: 0000000000000003
> > RBP: ffffea00021c0000 R08: 0000000000000029 R09: 00000000ffffffff
> > R10: ffffffff88ea7679 R11: 00000000ffffffff R12: ffff88814018d2d8
> > R13: ffffea00021c0008 R14: ffffea00021c0000 R15: 0000000000000000
> > FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f14895d5000 CR3: 0000000017350000 CR4: 00000000001506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  split_huge_page include/linux/huge_mm.h:192 [inline]
> >  deferred_split_scan+0x5fa/0xbd0 mm/huge_memory.c:2860
> >  do_shrink_slab+0x42d/0xbd0 mm/vmscan.c:709
> >  shrink_slab+0x17c/0x6e0 mm/vmscan.c:869
> >  shrink_node_memcgs mm/vmscan.c:2868 [inline]
> >  shrink_node+0x8d1/0x1df0 mm/vmscan.c:2983
> >  kswapd_shrink_node mm/vmscan.c:3726 [inline]
> >  balance_pgdat+0x7ce/0x13b0 mm/vmscan.c:3917
> >  kswapd+0x5b6/0xdb0 mm/vmscan.c:4176
> >  kthread+0x3e5/0x4d0 kernel/kthread.c:319
> >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
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
>
