Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF0137B999
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 11:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhELJu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 05:50:27 -0400
Received: from mail-ua1-f48.google.com ([209.85.222.48]:39548 "EHLO
        mail-ua1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhELJuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 05:50:24 -0400
Received: by mail-ua1-f48.google.com with SMTP id a12so7278878uak.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 02:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HwuV0oIEoZ+EQ5+Mm5jlhwshZkWr3IhzEV/rE9T6cEw=;
        b=oWdptxaRLrgXNXV+xxVi7fmHQOUYZve/WEnh8xDzvSzYFzC2WNOG+sfkq5qKDBOmA/
         jqA2vmGXcrnEriP9LMo15oAlIDN+cZuYZyPLC5S08/Ww+h74nJJ59ngx4hVkKBHnqYpC
         p4vxtgxYtJ2v7cCJt7d9d1p8In9ICjpcAc7sJTutEB9ugttIHTgqnOwJ1iysR/xCcXRv
         5q2oj4IsoGoP2Ffp0dRU16yQZRTmGn/FJPg2JUppsigNS+qBC+kH4TYugLqhNu3vI5Zz
         PTSTNH2S8CZ/HRQ8CEFWEUksi6U4t9JLi3Pgh4qc9wL7TKWsg/3k5SH89EDb/dJSGrwf
         1lfw==
X-Gm-Message-State: AOAM533KmRUTV+5kM3PAtecKw14tdDPLCKeToNv9Qzc4D5QpYaA9x6Gx
        AsdIG+7ld0aRq5ig+Z39iMqtjFzQkMUqPGZGQXQ=
X-Google-Smtp-Source: ABdhPJzQGXZD6dgZ85APfNUlHHznrQzLksJl7I1MmQfQ/FfX780s5vYhVBREXXLKbtUN48frqg1GMbdzUXcfPyHZELY=
X-Received: by 2002:a9f:3852:: with SMTP id q18mr30989572uad.58.1620812956684;
 Wed, 12 May 2021 02:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210507150553.208763-1-peterx@redhat.com> <20210507150553.208763-4-peterx@redhat.com>
In-Reply-To: <20210507150553.208763-4-peterx@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 12 May 2021 11:49:05 +0200
Message-ID: <CAMuHMdUe-P=8qoUBnNa4gx2Dg4YvcfLqnBJvRqp9FNLw55fsPQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mm: gup: pack has_pinned in MMF_HAS_PINNED
To:     Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Cc:     Linux MM <linux-mm@kvack.org>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter, Andrea,

On Fri, May 7, 2021 at 7:26 PM Peter Xu <peterx@redhat.com> wrote:
> From: Andrea Arcangeli <aarcange@redhat.com>
>
> has_pinned 32bit can be packed in the MMF_HAS_PINNED bit as a noop
> cleanup.
>
> Any atomic_inc/dec to the mm cacheline shared by all threads in
> pin-fast would reintroduce a loss of SMP scalability to pin-fast, so
> there's no future potential usefulness to keep an atomic in the mm for
> this.
>
> set_bit(MMF_HAS_PINNED) will be theoretically a bit slower than
> WRITE_ONCE (atomic_set is equivalent to WRITE_ONCE), but the set_bit
> (just like atomic_set after this commit) has to be still issued only
> once per "mm", so the difference between the two will be lost in the
> noise.
>
> will-it-scale "mmap2" shows no change in performance with enterprise
> config as expected.
>
> will-it-scale "pin_fast" retains the > 4000% SMP scalability
> performance improvement against upstream as expected.
>
> This is a noop as far as overall performance and SMP scalability are
> concerned.
>
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> [peterx: Fix build for task_mmu.c, introduce mm_set_has_pinned_flag, fix
>  comment here and there]
> Signed-off-by: Peter Xu <peterx@redhat.com>

Thanks for your patch, which is now in linux-next.

> diff --git a/mm/gup.c b/mm/gup.c
> index 9933bc5c2eff2..bb130723a6717 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1270,6 +1270,17 @@ int fixup_user_fault(struct mm_struct *mm,
>  }
>  EXPORT_SYMBOL_GPL(fixup_user_fault);
>
> +/*
> + * Set the MMF_HAS_PINNED if not set yet; after set it'll be there for the mm's
> + * lifecycle.  Avoid setting the bit unless necessary, or it might cause write
> + * cache bouncing on large SMP machines for concurrent pinned gups.
> + */
> +static inline void mm_set_has_pinned_flag(unsigned long *mm_flags)
> +{
> +       if (!test_bit(MMF_HAS_PINNED, mm_flags))
> +               set_bit(MMF_HAS_PINNED, mm_flags);
> +}
> +
>  /*
>   * Please note that this function, unlike __get_user_pages will not
>   * return 0 for nr_pages > 0 without FOLL_NOWAIT
> @@ -1292,8 +1303,8 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
>                 BUG_ON(*locked != 1);
>         }
>
> -       if ((flags & FOLL_PIN) && !atomic_read(&mm->has_pinned))
> -               atomic_set(&mm->has_pinned, 1);
> +       if (flags & FOLL_PIN)
> +               mm_set_has_pinned_flag(&mm->flags);
>
>         /*
>          * FOLL_PIN and FOLL_GET are mutually exclusive. Traditional behavior
> @@ -2617,8 +2628,8 @@ static int internal_get_user_pages_fast(unsigned long start,
>                                        FOLL_FAST_ONLY)))
>                 return -EINVAL;
>
> -       if ((gup_flags & FOLL_PIN) && !atomic_read(&current->mm->has_pinned))
> -               atomic_set(&current->mm->has_pinned, 1);
> +       if (gup_flags & FOLL_PIN)
> +               mm_set_has_pinned_flag(&current->mm->flags);

noreply@ellerman.id.au reports:

    FAILED linux-next/m5272c3_defconfig/m68k-gcc8 Wed May 12, 19:30
    http://kisskb.ellerman.id.au/kisskb/buildresult/14543658/
    Commit:   Add linux-next specific files for 20210512
          ec85c95b0c90a17413901b018e8ade7b9eae7cad
    Compiler: m68k-linux-gcc (GCC) 8.1.0 / GNU ld (GNU Binutils) 2.30

    mm/gup.c:2698:3: error: implicit declaration of function
'mm_set_has_pinned_flag'; did you mean 'set_tsk_thread_flag'?
[-Werror=implicit-function-declaration]

It's definition is inside the #ifdef CONFIG_MMU section, but the last
user isn't.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
