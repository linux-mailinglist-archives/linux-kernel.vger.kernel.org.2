Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27BD439E557
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 19:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhFGR35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 13:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbhFGR34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 13:29:56 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6BDC061766
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 10:27:52 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 131so23317450ljj.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 10:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A8mUzQGRZzpNUGsivNlCf/NusFzUx3Nm9DVM70DlTkM=;
        b=hS7ip8pvqBOaF7jyCfZG+QFzZBt35aJRLxeLaTF/If1gBBnGbOYwh/NitX8a84dZso
         O/0EOOR1AtVhVgBv7yZ3xGIaxYdaWlIuS9NH9FMthMfygQvhHpFhuxuW/1Q9xprbHgeB
         /11gL8R5e1NVRYjVzvBr2Ly6zus4aDRZeK+1JW3REJumOqUUcaPYtHImCLKnJe0hTp2i
         4B6lhU/awJXtck+M/yw41LCqTulv9mzqkiIDtY604IKGACCO1pRQMhBT7cjosPJtQ3t9
         qBbJakNGpcBoHSzX1hN3FBG0pOcR4VGerfzLlUpYbPQz3l2FZbl1n96Ve6lC/UJio44v
         HM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A8mUzQGRZzpNUGsivNlCf/NusFzUx3Nm9DVM70DlTkM=;
        b=OzwhJCYq13UVpF9BgNoK0nacWsPqEFqNdqU7ZaWaayKKdzYhYjxsQ5AVMJ7B5SdgjF
         mu0jw0eaTwfgl0bSIsIFAMxwqlFo9ZXwrm9WJ5IuJfESxu1gJmZuUtuhW/L8u8XBVj07
         WkvVBkGGU/llsqiyVAcsNOARBf7XzPzeVXTIImKLm5JCeD/Q56s3/Tst3hNVvQqSX3Nq
         U2E4L/4kfy/Gq83p2t9HsiJgXP8asw7Lut52rt5Y0sRH71gTodOlMrINTuXN2Ld1Y+3e
         UJPEkZx4Axsk4PU9hF+aP+N7UWd1eWntrvkXLMuFAHiM4oYjUQDZJeWyxoNHEibT+rAS
         6ECw==
X-Gm-Message-State: AOAM533L1fGoeIGj+I+6YUHgrH2c8nlPdJpfi/a/luah+YeuvdYtWBDO
        g4DGRH276ZACeizp+B+/OZG+CP0u/kJchzZZGs/Inw==
X-Google-Smtp-Source: ABdhPJyYGvRfA11oDDcdXy6F+uDoLUidZNX2oGHEYgqHykDbCzzNNmHi/nC8+hKEII4m2sT3mBcJx39S0ZhwTXWHcys=
X-Received: by 2002:a05:651c:178b:: with SMTP id bn11mr15509252ljb.43.1623086870337;
 Mon, 07 Jun 2021 10:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000017977605c395a751@google.com>
In-Reply-To: <00000000000017977605c395a751@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 7 Jun 2021 19:27:23 +0200
Message-ID: <CAG48ez0M=iwJu=Q8yUQHD-+eZDg6ZF8QCF86Sb=CN1petP=Y0Q@mail.gmail.com>
Subject: split_huge_page_to_list() races with page_mapcount() on migration
 entry in smaps code? [was: Re: [syzbot] kernel BUG in __page_mapcount]
To:     Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>, Zi Yan <ziy@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        chinwen.chang@mediatek.com,
        kernel list <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michel Lespinasse <walken@google.com>,
        syzbot <syzbot+1f52b3a18d5633fa7f82@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+some folks who I think might work on THP-related stuff
-fsdevel because this doesn't have much to do with filesystem stuff

=== Short summary ===
I believe the issue here is a race between /proc/*/smaps and
split_huge_page_to_list():

The codepath for /proc/*/smaps walks the pagetables and (e.g. in
smaps_account()) calls page_mapcount() not just on pages from normal
PTEs but also on migration entries (since commit b1d4d9e0cbd0a
"proc/smaps: carefully handle migration entries", from Linux v3.5).
page_mapcount() expects compound pages to be stable.

The split_huge_page_to_list() path first protects the compound page by
locking it and replacing all its PTEs with migration entries (since
the THP rewrite in v4.5, I think?), then does the actual splitting
using __split_huge_page().

So there's a mismatch of expectations here:
The smaps code expects that migration entries point to stable compound
pages, while the THP code expects that it's okay to split a compound
page while it has migration entries.


I'm not sure what the best way to fix it is; I guess the smaps code is
at fault here, and the following options might be approaches to fixing
it?

1. skip migration entries completely in smaps?
2. let smaps assume that the mapcount is 1 for all migration entries?
3. try to be fully accurate by waiting for the migration entry to
   change back to normal?
    probably a bad idea, way too messy...

Note that the mapcount of a page that is being migrated doesn't really
represent how many MMs are using the page anyway, so we wouldn't
really be making the current situation much worse by fudging the
mapcount to 1 in the smaps code...


By the way, I think the /proc/*/pagemap code (pte_to_pagemap_entry())
has the same issue?


I have asked syzkaller to test what happens if smaps_account() is
hacked up to avoid page_mapcount() for migration entries, and that
seems to fix the crash:
https://groups.google.com/g/syzkaller-bugs/c/9AZZCz4OtvE/m/WZDYXEKKAgAJ

Original syzkaller report with some more details below:

On Mon, May 31, 2021 at 2:53 AM syzbot
<syzbot+1f52b3a18d5633fa7f82@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    7ac3a1c1 Merge tag 'mtd/fixes-for-5.13-rc4' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14559d5bd00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f9f3fc7daa178986
> dashboard link: https://syzkaller.appspot.com/bug?extid=1f52b3a18d5633fa7f82
> compiler:       Debian clang version 11.0.1-2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11132d5bd00000

The "syz repro" link shows that this appears to be some kind of race
involving mmap(), madvise(..., MADV_FREE), and
/proc/$pid/smaps_rollup.
Note the '"threaded":true,"collide":true,"repeat":true' bit, which
indicates that this is some kind of race that syzbot is repeatedly
trying to hit by executing operations on multiple threads
simultaneously.

The MADV_FREE path involves split_huge_page(page); and in the linked
console output we can see the page state:

[  294.055186][T10694] page:ffffea0001328000 refcount:1 mapcount:0
mapping:0000000000000000 index:0x20000 pfn:0x4ca00
[  294.069056][T10694] memcg:ffff88814011c000
[  294.073365][T10694] anon flags:
0xfff0000008001d(locked|uptodate|dirty|lru|swapbacked|node=0|zone=1|lastcpupid=0x7ff)
[  294.084590][T10694] raw: 00fff0000008001d ffffea00013e0508
ffffea0001328048 ffff888045983e01
[  294.093279][T10694] raw: 0000000000020000 0000000000000000
00000001ffffffff ffff88814011c000
[  294.102469][T10694] page dumped because: VM_BUG_ON_PAGE(!PageHead(page))
[  294.109422][T10694] page_owner tracks the page as allocated
[  294.115444][T10694] page last allocated via order 0, migratetype
Movable, gfp_mask
0x3d20ca(GFP_TRANSHUGE_LIGHT|__GFP_NORETRY|__GFP_THISNODE), pid 10690,
ts 293625395715, free_ts 293374863045
[  294.133087][T10694]  get_page_from_freelist+0x779/0xa20
[  294.138623][T10694]  __alloc_pages+0x26c/0x5f0
[  294.143337][T10694]  alloc_pages_vma+0x9c7/0xe70
[  294.148655][T10694]  do_huge_pmd_anonymous_page+0x5b9/0xce0
[  294.155039][T10694]  handle_mm_fault+0x207e/0x2620
[  294.160759][T10694]  do_user_addr_fault+0x8ce/0x1120
[  294.165961][T10694]  exc_page_fault+0xa1/0x1e0
[  294.171144][T10694]  asm_exc_page_fault+0x1e/0x30

The message "page last allocated via order 0" is kinda misleading; as
you can see from the stacktrace and the GFP_TRANSHUGE_LIGHT flag, this
page was actually allocated as part of a hugepage, but was then later
split: __split_page_owner() fixes up the order in the page_owner
metadata, and is called from __split_huge_page() via
split_page_owner().

> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+1f52b3a18d5633fa7f82@syzkaller.appspotmail.com
[...]
> ------------[ cut here ]------------
> kernel BUG at include/linux/page-flags.h:686!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 10694 Comm: syz-executor.0 Not tainted 5.13.0-rc3-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:PageDoubleMap include/linux/page-flags.h:686 [inline]
> RIP: 0010:__page_mapcount+0x2b3/0x2d0 mm/util.c:728
> Code: e8 72 25 cf ff 4c 89 ff 48 c7 c6 40 fb 39 8a e8 03 4c 04 00 0f 0b e8 5c 25 cf ff 4c 89 ff 48 c7 c6 40 fc 39 8a e8 ed 4b 04 00 <0f> 0b e8 46 25 cf ff 4c 89 ff 48 c7 c6 80 fc 39 8a e8 d7 4b 04 00
> RSP: 0018:ffffc90001ff7460 EFLAGS: 00010246
> RAX: e8070b6faabf8b00 RBX: 00fff0000008001d RCX: ffff888047280000
> RDX: 0000000000000000 RSI: 000000000000ffff RDI: 000000000000ffff
> RBP: 0000000000000000 R08: ffffffff81ce2584 R09: ffffed1017363f24
> R10: ffffed1017363f24 R11: 0000000000000000 R12: 1ffffd4000265001
> R13: 00000000ffffffff R14: dffffc0000000000 R15: ffffea0001328000
> FS:  00007f6e83636700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000568000 CR3: 000000002b559000 CR4: 00000000001506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  page_mapcount include/linux/mm.h:873 [inline]

This is page_mapcount():

   870  static inline int page_mapcount(struct page *page)
   871  {
   872          if (unlikely(PageCompound(page)))
   873                  return __page_mapcount(page);
<===========================
   874          return atomic_read(&page->_mapcount) + 1;
   875  }

So the page that page_mapcount() was called on is/was marked as
PageCompound() at that time, but then, in __page_mapcount we crash:

   714  /* Slow path of page_mapcount() for compound pages */
   715  int __page_mapcount(struct page *page)
   716  {
   717          int ret;
   718
   719          ret = atomic_read(&page->_mapcount) + 1;
   720          /*
   721           * For file THP page->_mapcount contains total number of mapping
   722           * of the page: no need to look into compound_mapcount.
   723           */
   724          if (!PageAnon(page) && !PageHuge(page))
   725                  return ret;
   726          page = compound_head(page);
   727          ret += atomic_read(compound_mapcount_ptr(page)) + 1;
   728          if (PageDoubleMap(page))     <===========================
   729                  ret--;
   730          return ret;
   731  }

which means the supposed compound head page is not a compound page (anymore).

>  smaps_account+0x79d/0x980 fs/proc/task_mmu.c:467
>  smaps_pte_entry fs/proc/task_mmu.c:533 [inline]
>  smaps_pte_range+0x6ed/0xfc0 fs/proc/task_mmu.c:596

In here we're holding the PTE lock, so either the page of interest has
a non-zero (non-compound) mapcount, *OR* there is a migration PTE for
the page.

split_huge_page_to_list() takes a locked page and unmaps it from all
pagetables with unmap_page(), but because TTU_SPLIT_FREEZE is set,
try_to_unmap_one() will not simply clear the PTE but instead replace
it with a migration entry, so the /proc/*/smaps code can still observe
the page after that point.


>  walk_pmd_range mm/pagewalk.c:89 [inline]
>  walk_pud_range mm/pagewalk.c:160 [inline]
>  walk_p4d_range mm/pagewalk.c:193 [inline]
>  walk_pgd_range mm/pagewalk.c:229 [inline]
>  __walk_page_range+0xd64/0x1ad0 mm/pagewalk.c:331
>  walk_page_vma+0x3c2/0x500 mm/pagewalk.c:482
>  smap_gather_stats fs/proc/task_mmu.c:769 [inline]
>  show_smaps_rollup+0x49d/0xc20 fs/proc/task_mmu.c:872
>  seq_read_iter+0x43a/0xcf0 fs/seq_file.c:227
>  seq_read+0x445/0x5c0 fs/seq_file.c:159
>  do_loop_readv_writev fs/read_write.c:761 [inline]
>  do_iter_read+0x464/0x660 fs/read_write.c:803
>  vfs_readv fs/read_write.c:921 [inline]
>  do_preadv+0x1f7/0x340 fs/read_write.c:1013
>  do_syscall_64+0x3f/0xb0 arch/x86/entry/common.c:47
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x4665d9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f6e83636188 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
> RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665d9
> RDX: 0000000000000001 RSI: 0000000020000780 RDI: 0000000000000004
> RBP: 00000000004bfcb9 R08: 0000000000000003 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf80
> R13: 00007ffeb607b5df R14: 00007f6e83636300 R15: 0000000000022000
> Modules linked in:
> ---[ end trace e65a33e7d2bffb07 ]---
> RIP: 0010:PageDoubleMap include/linux/page-flags.h:686 [inline]
> RIP: 0010:__page_mapcount+0x2b3/0x2d0 mm/util.c:728
> Code: e8 72 25 cf ff 4c 89 ff 48 c7 c6 40 fb 39 8a e8 03 4c 04 00 0f 0b e8 5c 25 cf ff 4c 89 ff 48 c7 c6 40 fc 39 8a e8 ed 4b 04 00 <0f> 0b e8 46 25 cf ff 4c 89 ff 48 c7 c6 80 fc 39 8a e8 d7 4b 04 00
> RSP: 0018:ffffc90001ff7460 EFLAGS: 00010246
> RAX: e8070b6faabf8b00 RBX: 00fff0000008001d RCX: ffff888047280000
> RDX: 0000000000000000 RSI: 000000000000ffff RDI: 000000000000ffff
> RBP: 0000000000000000 R08: ffffffff81ce2584 R09: ffffed1017363f24
> R10: ffffed1017363f24 R11: 0000000000000000 R12: 1ffffd4000265001
> R13: 00000000ffffffff R14: dffffc0000000000 R15: ffffea0001328000
> FS:  00007f6e83636700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000568000 CR3: 000000002b559000 CR4: 00000000001506e0
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
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
