Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304C434E0D5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 07:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhC3Frn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 01:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhC3Fr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 01:47:27 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F75C061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 22:47:26 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j18so14960963wra.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 22:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IlLL4fvHksCUIpTZMtr7ANhRamajd04EVg5QFhFYyZE=;
        b=pKnFLgoaj6O6ETjDMMxJbU4V7xil35gLDNmD/qX7/CtarhM57gyNt53XcrLb+ang6u
         y02MuaQ5Ndqkd8NzfzW7GFIZoVxGE1wM5zWKQDjiZ8+Vfzz5otVEJKx/YA+J2JXa+Z2n
         2rXaX/mh1lTILI27VvPtZa3WyCMSSkHq/773rs08vfHkZFGp19rBxo5aGSy54bzjn8LU
         o15gALpM46tf/EA+EQUXG7+kCw9svTo4RwWdz+gN9qsvbyKqhDVrz0ARedTOJ6i1/yAD
         RgolWQ8jjhPxC/9uUmOuV+zE1JuhcyVz5AkWk0C7M0/1gYy7bUznQP+kPcQrS4ElXxaW
         csaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IlLL4fvHksCUIpTZMtr7ANhRamajd04EVg5QFhFYyZE=;
        b=cVANTAkG5ds8R+b+PGg4I6DM80TcDPRRX7esNDuZbvJx3UNEPqaY0NWLxy/FKP73QI
         X0LRWh6xXqbEpgW7coHs2I6gvJdPGyy5eO6y7O9BGA5W3IE0GvzMnZcwd8YSyrSLJiKg
         smDRIrlG/z/cyJHweQYX4J84rYRNCBFbSGcoru5vRu5xcyigmxSaclxB2akbI5OX/1Jd
         Jd5gsCFv8DdHDxofkyKFMmks9WssLmSrzmzWLEgJ/KAT9omrF1McoGkUAxkDQU6W8+93
         rSy1m+bbUsQ3fYeufeakNqwTSUt/trWEfT+n3ug/uI04Px+taPGThpOewEJLOtzQkwPO
         utpg==
X-Gm-Message-State: AOAM531/r+EiLHy31QBFtqF8TojTNlFi3d31NdhJsPW9LnXYr6TabmpL
        tmObst9NjGa68M5nBLILI8RCl8l7gL0RKFDra1BiyQ==
X-Google-Smtp-Source: ABdhPJxzx5s7EayhUieTVgjM6x/ZvlThDc3E5x6FtchI1twpqHbTsVCBiRugkoKrA+Qa0cy9pshYvvuvzjjvxM08ZC4=
X-Received: by 2002:a5d:53c8:: with SMTP id a8mr31292925wrw.323.1617083245060;
 Mon, 29 Mar 2021 22:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <364d7ce9-ccb7-fa04-7067-44a96be87060@huawei.com>
 <8735wdbdy4.fsf@yhuang6-desk1.ccr.corp.intel.com> <0cb765aa-1783-cd62-c4a4-b3fbc620532d@huawei.com>
 <87h7kt9ufw.fsf@yhuang6-desk1.ccr.corp.intel.com>
In-Reply-To: <87h7kt9ufw.fsf@yhuang6-desk1.ccr.corp.intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 29 Mar 2021 23:47:13 -0600
Message-ID: <CAOUHufYMjhQagKfdjekxr62bsB83UJvArddUsuwTXoo-5jA45A@mail.gmail.com>
Subject: Re: [Question] Is there a race window between swapoff vs synchronous swap_readpage
To:     "Huang, Ying" <ying.huang@intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Minchan Kim <minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 9:44 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> Miaohe Lin <linmiaohe@huawei.com> writes:
>
> > On 2021/3/30 9:57, Huang, Ying wrote:
> >> Hi, Miaohe,
> >>
> >> Miaohe Lin <linmiaohe@huawei.com> writes:
> >>
> >>> Hi all,
> >>> I am investigating the swap code, and I found the below possible race window:
> >>>
> >>> CPU 1                                                       CPU 2
> >>> -----                                                       -----
> >>> do_swap_page
> >>>   skip swapcache case (synchronous swap_readpage)
> >>>     alloc_page_vma
> >>>                                                     swapoff
> >>>                                                       release swap_file, bdev, or ...
> >>>       swap_readpage
> >>>     check sis->flags is ok
> >>>       access swap_file, bdev or ...[oops!]
> >>>                                                         si->flags = 0
> >>>
> >>> The swapcache case is ok because swapoff will wait on the page_lock of swapcache page.
> >>> Is this will really happen or Am I miss something ?
> >>> Any reply would be really grateful. Thanks! :)
> >>
> >> This appears possible.  Even for swapcache case, we can't guarantee the
> >
> > Many thanks for reply!
> >
> >> swap entry gotten from the page table is always valid too.  The
> >
> > The page table may change at any time. And we may thus do some useless work.
> > But the pte_same() check could handle these races correctly if these do not
> > result in oops.
> >
> >> underlying swap device can be swapped off at the same time.  So we use
> >> get/put_swap_device() for that.  Maybe we need similar stuff here.
> >
> > Using get/put_swap_device() to guard against swapoff for swap_readpage() sounds
> > really bad as swap_readpage() may take really long time. Also such race may not be
> > really hurtful because swapoff is usually done when system shutdown only.
> > I can not figure some simple and stable stuff out to fix this. Any suggestions or
> > could anyone help get rid of such race?
>
> Some reference counting on the swap device can prevent swap device from
> swapping-off.  To reduce the performance overhead on the hot-path as
> much as possible, it appears we can use the percpu_ref.

Hi,

I've been seeing crashes when testing the latest kernels with
  stress-ng --class vm -a 20 -t 600s --temp-path /tmp

I haven't had time to look into them yet:

DEBUG_VM:
  BUG: unable to handle page fault for address: ffff905c33c9a000
  Call Trace:
   get_swap_pages+0x278/0x590
   get_swap_page+0x1ab/0x280
   add_to_swap+0x7d/0x130
   shrink_page_list+0xf84/0x25f0
   reclaim_pages+0x313/0x430
   madvise_cold_or_pageout_pte_range+0x95c/0xaa0

KASAN:
  ==================================================================
  BUG: KASAN: slab-out-of-bounds in __frontswap_store+0xc9/0x2e0
  Read of size 8 at addr ffff88901f646f18 by task stress-ng-mrema/31329
  CPU: 2 PID: 31329 Comm: stress-ng-mrema Tainted: G S        I  L
5.12.0-smp-DEV #2
  Call Trace:
   dump_stack+0xff/0x165
   print_address_description+0x81/0x390
   __kasan_report+0x154/0x1b0
   ? __frontswap_store+0xc9/0x2e0
   ? __frontswap_store+0xc9/0x2e0
   kasan_report+0x47/0x60
   kasan_check_range+0x2f3/0x340
   __kasan_check_read+0x11/0x20
   __frontswap_store+0xc9/0x2e0
   swap_writepage+0x52/0x80
   pageout+0x489/0x7f0
   shrink_page_list+0x1b11/0x2c90
   reclaim_pages+0x6ca/0x930
   madvise_cold_or_pageout_pte_range+0x1260/0x13a0

  Allocated by task 16813:
   ____kasan_kmalloc+0xb0/0xe0
   __kasan_kmalloc+0x9/0x10
   __kmalloc_node+0x52/0x70
   kvmalloc_node+0x50/0x90
   __se_sys_swapon+0x353a/0x4860
   __x64_sys_swapon+0x5b/0x70

  The buggy address belongs to the object at ffff88901f640000
   which belongs to the cache kmalloc-32k of size 32768
  The buggy address is located 28440 bytes inside of
   32768-byte region [ffff88901f640000, ffff88901f648000)
  The buggy address belongs to the page:
  page:0000000032d23e33 refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x101f640
  head:0000000032d23e33 order:4 compound_mapcount:0 compound_pincount:0
  flags: 0x400000000010200(slab|head)
  raw: 0400000000010200 ffffea00062b8408 ffffea000a6e9008 ffff888100040300
  raw: 0000000000000000 ffff88901f640000 0000000100000001 000000000000000
  page dumped because: kasan: bad access detected

Memory state around the buggy address:
   ffff88901f646e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   ffff88901f646e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  >ffff88901f646f00: 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc
                              ^
   ffff88901f646f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
   ffff88901f647000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ==================================================================

Relevant config options I could think of:

CONFIG_MEMCG_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_ZSWAP=y
