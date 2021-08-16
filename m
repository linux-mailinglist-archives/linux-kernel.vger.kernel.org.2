Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920D73EDDF7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 21:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhHPTiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 15:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhHPTiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 15:38:13 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A1AC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 12:37:41 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id i6so28153381edu.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 12:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7cTn4xUKq7ggDw5LSNLiSgGeEvqiiXIyLWI0JChtlHs=;
        b=JZiorZuELNFlgjTFJgYIIplcBC9XFYGsDgteKoH1S+V5cWvrj7xhZSNrwMkG2ZF8r1
         HkTN3QVq0k+9qBgJnjlETkzyF4O55EVRzZjulZDNRckYcp5KcaOj7zIiQmbJUOa/uRAz
         km5uyVnMlWGbur5qoPCQPtYVFCl9ZDto7kHIOT1JKCP40h3b7gXNYqNFt8JBB0a1JaGU
         BJQ/F6CJC5xbRwmk6p4DQabB43PGJghGxy5qpNfcBC186Bq6niF2x0PWyBbPHZXatA0t
         VjT7VRse1TbQ/IXetKO80d7swOk64FYmTe1FvRcuaWHOh3FMu7orO9WoXtxPWFhtCGjr
         ygpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7cTn4xUKq7ggDw5LSNLiSgGeEvqiiXIyLWI0JChtlHs=;
        b=feKIzuwQ6Gxps4YZCVqb8OtlxPxGcKd96KVtRbAnM6fSEf3NQw9qy6u7I0Qat2b+Xt
         fIq6EuH+riFDMgL1CUxEhBSc9PBB5vTmE7jqqxpCLUn+2LDh9pUXh7Xew6rRU694DNPq
         RZqxhliYUuCptWgVg75j4sB956bIrT8cdIRaje07GpOizpDbU856xu6eQ6CHBx1v/9wC
         WkteG+uzd0gHyKvDJwiroevGgzgqVkU6/ZoE82mMPwptpfNI0nj9lwrxoWX3793pHmc0
         UtMja/BOp8o+C9Vz9homEjf/T9/C6MM80NXpIcpGcNVTunohD3jqZspeRrhf0KRK9d6I
         giqw==
X-Gm-Message-State: AOAM530UJzXaDrNVV7WN6eXBeNyH3G40J/jk6k2m8xHbxchEfm5nKIHa
        RQF3er+IWG6gJkOv8B/M/KhRggiczqHdWaNd9wI=
X-Google-Smtp-Source: ABdhPJyLaaOjReYuHdUmOmkH5QQLl26+EHM3hM2/CpfclOFfdDu1HRKiY8hvH5qxZ4xBQplBE0YuYxUQwVu07T1dBYg=
X-Received: by 2002:a50:954c:: with SMTP id v12mr198023eda.313.1629142659999;
 Mon, 16 Aug 2021 12:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210816180909.3603-1-shy828301@gmail.com> <08a5ad43-7922-8cf8-31ed-4f6e0c346516@redhat.com>
In-Reply-To: <08a5ad43-7922-8cf8-31ed-4f6e0c346516@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 16 Aug 2021 12:37:27 -0700
Message-ID: <CAHbLzkoyYwvGPaoxPKU1dG_riPPqvP+L5QUz38AVvXbD1y3c8g@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: hwpoison: don't drop slab caches for offlining
 non-LRU page
To:     David Hildenbrand <david@redhat.com>
Cc:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Oscar Salvador <osalvador@suse.de>,
        tdmackey@twitter.com, Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 12:15 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 16.08.21 20:09, Yang Shi wrote:
> > In the current implementation of soft offline, if non-LRU page is met,
> > all the slab caches will be dropped to free the page then offline.  But
> > if the page is not slab page all the effort is wasted in vain.  Even
> > though it is a slab page, it is not guaranteed the page could be freed
> > at all.
>
> ... but there is a chance it could be and the current behavior is
> actually helpful in some setups.

I don't disagree it is kind of helpful for some cases, but the
question is how likely it is helpful and if the cost is worth it or
not. For non-slab page (of course, non-lru too), dropping slab doesn't
make any sense. Even though it is slab page, it must be a reclaimable
slab. Even though it is a reclaimable slab, dropping slab can't
guarantee all objects on the same page are dropped.

IMHO the likelihood is not worth the cost and side effect, for example
the unsuable system.

>
> [...]
>
> > The lockup made the machine is quite unusable.  And it also made the
> > most workingset gone, the reclaimabled slab caches were reduced from 12G
> > to 300MB, the page caches were decreased from 17G to 4G.
> >
> > But the most disappointing thing is all the effort doesn't make the page
> > offline, it just returns:
> >
> > soft_offline: 0x1469f2: unknown non LRU page type 5ffff0000000000 ()
> >
>
> In your example, yes. I had a look at the introducing commit:
> facb6011f399 ("HWPOISON: Add soft page offline support")
>
> "
>      When the page is not free or LRU we try to free pages
>      from slab and other caches. The slab freeing is currently
>      quite dumb and does not try to focus on the specific slab
>      cache which might own the page. This could be potentially
>      improved later.
> "
>
> I wonder, if instead of removing it altogether, we could actually
> improve it as envisioned.
>
> To be precise, for alloc_contig_range() it would also make sense to be
> able to shrink only in a specific physical memory range; this here seems
> to be a similar thing. (actually, alloc_contig_range(), actual memory
> offlining and hw poisoning/soft-offlining have a lot in common)
>
> Unfortunately, the last time I took a brief look at teaching shrinkers
> to be range-aware, it turned out to be a lot of work ... so maybe this
> is really a long term goal to be mitigated in the meantime by disabling
> it, if it turns out to be more of a problem than actually help.

Do you mean physical page range? Yes, it would need a lot of work.
TBH, I don't think it is quite feasible for the time being.

The problem is slabs for shrinker are managed by objects rather than
pages. For example, dentry and inode objects (the most consumed
reclaimable slabs) are linked to lru, and shrinkers traverse the lru
to shrink the objects. The objects in a certain range can not be
guaranteed in the same range of physical pages.

>
> --
> Thanks,
>
> David / dhildenb
>
