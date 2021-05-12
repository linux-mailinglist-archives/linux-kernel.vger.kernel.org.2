Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6A837BC9A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbhELMf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:35:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20623 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232493AbhELMf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620822889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=plE+nL+ct6AZIIPoxz1my01jPeDymgnbPjG0iiRllwM=;
        b=eLkDWng3XltHm+v/4dek193edElz1kauXcwMAe27S25Q4hdnRPsWQrW/OZv+X8jQyE2zwz
        KnMUSCE0+W8OMC3PiC35kaOO5+EYRCova8GlVJDAzb2srF9PM4isknrOZRP5WpdLcakjwa
        cXt7/hyVcaJheyG4DXUGj1OHa4eC9B4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-YfBkDSxPOPq6jWv4bzNZMA-1; Wed, 12 May 2021 08:34:47 -0400
X-MC-Unique: YfBkDSxPOPq6jWv4bzNZMA-1
Received: by mail-qk1-f200.google.com with SMTP id 4-20020a370d040000b02902fa09aa4ad4so8676988qkn.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 05:34:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=plE+nL+ct6AZIIPoxz1my01jPeDymgnbPjG0iiRllwM=;
        b=Ycrp9hWCV+tznITQdt2zbin/ZxL516uobnTalBZ9uJE5z6BnvxtHyrp66srlccxxD8
         fD/YrOV99ijqUSsP+4uhjktNja0ddnbjl3RpEM+zdYWtc9lz+y3N5Yk3S8t0XTeBG2Hm
         Az64kLVi+zjasxohMtsTDg7n3CAJbadsK8xDpGiA3f7qpiu/CF+RVQ566G1QXZIFWgBx
         2UVu4Ct2wfFcqOvX5RtBUV/Kzf1sf1ul8TyTpt3OK98yt+WnJTU4v9hgy6J0Z1VzbOC+
         zTZE0CIe4LCZFU+qkLe6EDOVcP6A6COLRxQ6+tkNWPhdvW0KNFIZSinS96JPG3nFO1M4
         NzBg==
X-Gm-Message-State: AOAM532O/yaTj9cUKHGkxcZqCVkm4WRl/W6x6ZMBV/+k4X8VkG+tZXHU
        CEFzHq3Dg8JfORhBlnEGGF1PFMEKA6CzYP9Q46ilcPwT4Yoeo4VbFqLQQ4yyU3/bHEQBJw/SNUe
        HxSVqHON6UjuDztB+iNXsdM2N
X-Received: by 2002:a05:622a:341:: with SMTP id r1mr4583017qtw.307.1620822885103;
        Wed, 12 May 2021 05:34:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2tlaCkwmNfDKEriLu1NRRZo0A8kzyXZX8X8GFPBiFplx0v0baUwXe1hl/5JNdu3ems/5eWw==
X-Received: by 2002:a05:622a:341:: with SMTP id r1mr4582983qtw.307.1620822884723;
        Wed, 12 May 2021 05:34:44 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id o189sm15923330qkd.60.2021.05.12.05.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 05:34:44 -0700 (PDT)
Date:   Wed, 12 May 2021 08:34:42 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>, Jason Gunthorpe <jgg@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2 3/3] mm: gup: pack has_pinned in MMF_HAS_PINNED
Message-ID: <YJvLYmEunXKNHMdX@t490s>
References: <20210507150553.208763-1-peterx@redhat.com>
 <20210507150553.208763-4-peterx@redhat.com>
 <CAMuHMdUe-P=8qoUBnNa4gx2Dg4YvcfLqnBJvRqp9FNLw55fsPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdUe-P=8qoUBnNa4gx2Dg4YvcfLqnBJvRqp9FNLw55fsPQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 11:49:05AM +0200, Geert Uytterhoeven wrote:
> Hi Peter, Andrea,

Hi, Geert, Naresh,

(Adding Naresh too since Naresh reported the same issue at the meantime)

> 
> On Fri, May 7, 2021 at 7:26 PM Peter Xu <peterx@redhat.com> wrote:
> > From: Andrea Arcangeli <aarcange@redhat.com>
> >
> > has_pinned 32bit can be packed in the MMF_HAS_PINNED bit as a noop
> > cleanup.
> >
> > Any atomic_inc/dec to the mm cacheline shared by all threads in
> > pin-fast would reintroduce a loss of SMP scalability to pin-fast, so
> > there's no future potential usefulness to keep an atomic in the mm for
> > this.
> >
> > set_bit(MMF_HAS_PINNED) will be theoretically a bit slower than
> > WRITE_ONCE (atomic_set is equivalent to WRITE_ONCE), but the set_bit
> > (just like atomic_set after this commit) has to be still issued only
> > once per "mm", so the difference between the two will be lost in the
> > noise.
> >
> > will-it-scale "mmap2" shows no change in performance with enterprise
> > config as expected.
> >
> > will-it-scale "pin_fast" retains the > 4000% SMP scalability
> > performance improvement against upstream as expected.
> >
> > This is a noop as far as overall performance and SMP scalability are
> > concerned.
> >
> > Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> > [peterx: Fix build for task_mmu.c, introduce mm_set_has_pinned_flag, fix
> >  comment here and there]
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Thanks for your patch, which is now in linux-next.
> 
> > diff --git a/mm/gup.c b/mm/gup.c
> > index 9933bc5c2eff2..bb130723a6717 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -1270,6 +1270,17 @@ int fixup_user_fault(struct mm_struct *mm,
> >  }
> >  EXPORT_SYMBOL_GPL(fixup_user_fault);
> >
> > +/*
> > + * Set the MMF_HAS_PINNED if not set yet; after set it'll be there for the mm's
> > + * lifecycle.  Avoid setting the bit unless necessary, or it might cause write
> > + * cache bouncing on large SMP machines for concurrent pinned gups.
> > + */
> > +static inline void mm_set_has_pinned_flag(unsigned long *mm_flags)
> > +{
> > +       if (!test_bit(MMF_HAS_PINNED, mm_flags))
> > +               set_bit(MMF_HAS_PINNED, mm_flags);
> > +}
> > +
> >  /*
> >   * Please note that this function, unlike __get_user_pages will not
> >   * return 0 for nr_pages > 0 without FOLL_NOWAIT
> > @@ -1292,8 +1303,8 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
> >                 BUG_ON(*locked != 1);
> >         }
> >
> > -       if ((flags & FOLL_PIN) && !atomic_read(&mm->has_pinned))
> > -               atomic_set(&mm->has_pinned, 1);
> > +       if (flags & FOLL_PIN)
> > +               mm_set_has_pinned_flag(&mm->flags);
> >
> >         /*
> >          * FOLL_PIN and FOLL_GET are mutually exclusive. Traditional behavior
> > @@ -2617,8 +2628,8 @@ static int internal_get_user_pages_fast(unsigned long start,
> >                                        FOLL_FAST_ONLY)))
> >                 return -EINVAL;
> >
> > -       if ((gup_flags & FOLL_PIN) && !atomic_read(&current->mm->has_pinned))
> > -               atomic_set(&current->mm->has_pinned, 1);
> > +       if (gup_flags & FOLL_PIN)
> > +               mm_set_has_pinned_flag(&current->mm->flags);
> 
> noreply@ellerman.id.au reports:
> 
>     FAILED linux-next/m5272c3_defconfig/m68k-gcc8 Wed May 12, 19:30
>     http://kisskb.ellerman.id.au/kisskb/buildresult/14543658/
>     Commit:   Add linux-next specific files for 20210512
>           ec85c95b0c90a17413901b018e8ade7b9eae7cad
>     Compiler: m68k-linux-gcc (GCC) 8.1.0 / GNU ld (GNU Binutils) 2.30
> 
>     mm/gup.c:2698:3: error: implicit declaration of function
> 'mm_set_has_pinned_flag'; did you mean 'set_tsk_thread_flag'?
> [-Werror=implicit-function-declaration]
> 
> It's definition is inside the #ifdef CONFIG_MMU section, but the last
> user isn't.

Indeed that's wrong and I replied to the mm-commit email but not here to fix
this up yesterday:

https://lore.kernel.org/mm-commits/20210511220029.m6tGcxUIw%25akpm@linux-foundation.org/

I'll remember to reply to the thread next time. Sorry for that!

-- 
Peter Xu

