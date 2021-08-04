Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181533DFB85
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 08:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235640AbhHDGnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 02:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235419AbhHDGm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 02:42:59 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787B6C0613D5
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 23:42:46 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 61-20020a9d0d430000b02903eabfc221a9so827770oti.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 23:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=1PrwKlsbFvx8i8dTdlftDjVHQLdl0WQZNk2V6d/nwMk=;
        b=P/oi2weF1yW60zxeYdRS5MV/4kJpp6adELKDGXG7jRzfsX6XfPy+/Mkpu3QvAkSkRv
         2B65A4wgnxqb6ndMQQ9m2qFXL/MbEMX55RUstGFexUUNI62mmIUQkI+0+evx3Sv+JJBD
         dH21GFUd0Q6zkXxch3IWJqIQto6y6b997AKxELENBkoIJ2U7RQ34EMzc7/Tk7QTfeIXr
         q22aLQ23I0lWqs0jsRRt9xgbIp64ggE7/WYeXU06TzZgb2Z2Hl3BJTq6WRBIdMobmteF
         DKc2Y+OzVEatoFqyErtcp1tGjY+kByOOyrNxvYrBRry8DXVV/yvmkIB3q3VEa3zgoNQr
         HzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=1PrwKlsbFvx8i8dTdlftDjVHQLdl0WQZNk2V6d/nwMk=;
        b=WSBO6K8FzK2fBSP2bOe30zpPTZjadePubdUxquR2JgTuEq6aAU5GJdlnf5hsT5fU9H
         q8j3ezcBZDDZqU7ItVi046YhJ4EIpwdiSaMGAB9/fc51pApIRGyFH4KBXH+TNO5AWmV3
         omP0dnCJOrP/Hy85JDyrGJtMV3GDxjn6WGPE2wJd2hjT9E+LAKyAj6bDQcpnibnJsocA
         iJA1kVTlliKRiXzfEKwb05jB6uVAiv0WxCVc1pzFS9TiYTJ6zDPu1HlxReg8NThXDR35
         nRuXDFx7m9wfI0e5Rnm7VaHroXa1gxQhIqU7L86uhDAqlvrK6ExcWrySy0NPJeEMjT/e
         qYqg==
X-Gm-Message-State: AOAM5301JWOOClrvVNORvXLlpzRU9/3H8l+Oe0tUqcpQRS7zXFogiTXB
        VhXORTBIzeYOXGEJdsDs6gQHnA==
X-Google-Smtp-Source: ABdhPJwY/nX1QsFfz6ifdTXN1zn/dgIxCxsDr4qc71TGmJexyImbnk0Nyu02XGND1eaOObehfqcDgg==
X-Received: by 2002:a9d:12e1:: with SMTP id g88mr7547600otg.36.1628059365589;
        Tue, 03 Aug 2021 23:42:45 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id q21sm39277otn.61.2021.08.03.23.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 23:42:44 -0700 (PDT)
Date:   Tue, 3 Aug 2021 23:42:41 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     huang ying <huang.ying.caritas@gmail.com>
cc:     Hugh Dickins <hughd@google.com>, Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH] mm,shmem: Fix a typo in shmem_swapin_page()
In-Reply-To: <CAC=cRTNby4GkSJ-pjs6utgHtrQYEdy3XZQ06Qsxgyf1MJSBjrw@mail.gmail.com>
Message-ID: <3f91e0a9-7ba-c165-6231-b2bb38f7f63b@google.com>
References: <20210723080000.93953-1-ying.huang@intel.com> <24187e5e-069-9f3f-cefe-39ac70783753@google.com> <CAC=cRTNby4GkSJ-pjs6utgHtrQYEdy3XZQ06Qsxgyf1MJSBjrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2021, huang ying wrote:
> On Sat, Jul 24, 2021 at 4:23 AM Hugh Dickins <hughd@google.com> wrote:
> >
> > I was wary because, if the (never observed) race to be fixed is in
> > swap_cluster_readahead(), why was shmem_swapin_page() being patched?
> 
> When we get a swap entry from the page table or shmem xarray, and no
> necessary lock is held to prevent the swap device to be swapoff (e.g.
> page table lock, page lock, etc.), it's possible that the swap device
> has been swapoff when we operate on the swap entry (e.g. swapin).

Yes.  And even without any swapoff, the swap entry may no longer be
right by the time we go to swap it in, or after it has been swapped in.

Both mm/memory.c and mm/shmem.c have done an unlocked lookup to get
the swap entry, and have to do a pte_same() or shmem_confirm_swap()
later, to ensure that what they've got is still right.  That lockless
lookup and raciness is intentional, and has been working for years.

> So we need to find a way to prevent the swap device to be swapoff,
> get_swap_device() based on percpu_ref is used for that.

To prevent swapoff, no, it would be bad if swapoff could be prevented
indefinitely.  But I think you're saying to prevent swapoff from
completing - reaching the point of freeing structures which might
still be being examined.

Yes, though I thought that was already prevented.  But I may well have
missed the inode_read_congested() case which came in two years ago
(affecting shmem swapin only).  And I'll admit now to never(?) having
studied or tested the SWP_SYNCHRONOUS_IO case in do_swap_page() (with
suspiciously no equivalent in shmem swapin): I'd better start.

I do dislike the way SWP_SYNCHRONOUS_IO imported low-level swap business
into do_swap_page(): I'd love to try to move that into swap_state.c, and
in doing so hopefully get to appreciate it better (and the suggested
swapoff race: I presume it comes from skipping swapcache_prepare()).
But I have no time for that at present.

> To avoid to
> call get_swap_device() here and there (e.g. now it is called in many
> different places), I think it's better to call get_swap_device() when
> we just get a swap entry without holding the necessary lock, that is,
> in do_swap_page() and shmem_swapin_page(), etc.  So that we can delete
> the get_swap_device() call in lookup_swap_cache(),
> __read_swap_cache_async(), etc.  This will make it easier to
> understand when to use get_swap_device() and clean up the code.  Do
> you agree?

Offhand I'd say that I do not agree: but I can easily imagine coming to
agree with you, once I have tried to do better and discovered I cannot.

I dislike the way swap internals are being pushed out to the higher
levels.  Particularly since those higher levels already have to deal
with similar races which are not protected by get_swap_device().

I'd forgotten how earlier you found you had to add get_swap_device()
into lookup_swap_cache(), and friends: and can see the attraction of
doing it once instead of here and there.  But it is still there in
lookup_swap_cache() etc, so that's a poor argument for these commits.

> 
> > Not explained in its commit message, probably a misunderstanding of
> > how mm/shmem.c already manages races (and prefers not to be involved
> > in swap_info_struct stuff).
> 
> Yes.  The commit message isn't clean enough about why we do that.

Thanks for clearing that up.  In intervening days I did read about 50
of the ~100 mails on these commits, April and later (yes, I was Cc'ed
throughout, thanks, but that didn't give me the time).  I've not yet
reached any that explain the get_swap_device() placement, perhaps
I'll change my mind when eventually I read those.

> 
> > But why do I now say it's bad?  Because even if you correct the EINVAL
> > to -EINVAL, that's an unexpected error: -EEXIST is common, -ENOMEM is
> > not surprising, -ENOSPC can need consideration, but -EIO and anything
> > else just end up as SIGBUS when faulting (or as error from syscall).
> 
> Yes.  -EINVAL isn't a good choice.  If it's the swapoff race, then
> retrying can fix the race, so -EAGAIN may be a choice.  But if the
> swap entry is really invalid (almost impossible in theory), we may
> need something else, for example, WARN_ON_ONCE() and SIGBUS?  This
> reminds me that we may need to distinguish the two possibilities in
> get_swap_device()?

Ah, I guess in that last sentence you're thinking of what I realized
in writing previous mail, behaviour when given a corrupted swap entry.

Hugh
