Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E17410618
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 13:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239245AbhIRLtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 07:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhIRLtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 07:49:40 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51778C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 04:48:17 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so11879531pjc.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 04:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NfLIXi5NuL2PF6rTqaUWLiDGZ2bM9/OPvGTCBxQf/Zg=;
        b=47B5COgWWP/NtFNfOGAnx46845XseXNan5j5kLiIQ2mDLnhAe1Ri0x9AWEOU9Zc3TQ
         +o3BUUuBj36Z+f732jeBhBhult7nydYxZU7pOKcg1P0WMG0BIm4o6E+g7ML2BKAUe1tG
         oFWmll5zRPWzlTh+nvo1sNM7gtfA2z0c/ZxUl0JYmLw0VJ1TJ5fEFr7evhFF0GpQR45I
         nKcWz6oJ/krCrJas16QTQD/LdpuKLyCHri3ZSnDYsaWjmAcuRmTOY/YuFbyFw28CShIi
         TD7Gjghf2V68n6uYxVFu3mdhWOApcZnw0LclnRPoH1Q3b30eIxuzppoqmQRFWYoX1COJ
         wU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NfLIXi5NuL2PF6rTqaUWLiDGZ2bM9/OPvGTCBxQf/Zg=;
        b=2L9il57wv+XkbKDAo9cPW5gutNjk5ABspovRyByIgmtnCh7oP8bjxFLAkNm4TFensD
         yXpNviSrUOIcohB9uz8bVg+HVCG+uUFSgZGu8L3MMgK5kFIPm67Cedc8iGZeGAm2Z5m9
         X8G9DIaT8q78DcyWqy2k+KajZVFW5Uf4fFKdAmvQgfbI2ZjRLS+hV3NO3lw73+YrfaS6
         uhS5jnkP3uTLpTJhBmBUBIG4375dwI5HtSzPJBHB5/JnbsvTa+AdQ4KA7U6ZKEXTtmk+
         HpXaLwuWzVAxBioyPIOrK4/Ig9p4gkCIkHJ0mOBZcrrYeN4V+PpAv5cMp8bcVXvm/sI6
         sbEg==
X-Gm-Message-State: AOAM5312cQSPRdP9auXWqtmJYRZVZYudiAZmfZDTJDP13wt531NTobZ2
        o3TRkKppPtCEbm7QkwYYEP4IsoQsTjfzSbVkZ3n0ug==
X-Google-Smtp-Source: ABdhPJzetvZXdXg9Gt1c0+iA4OzPlw1wcIa1EoiEU4dl7DT5RDXRl8uezwWIrMiicKgsrOCUFr4UYI/AgpzQwPIdWyI=
X-Received: by 2002:a17:90b:1807:: with SMTP id lw7mr14281165pjb.217.1631965696767;
 Sat, 18 Sep 2021 04:48:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210917034815.80264-1-songmuchun@bytedance.com>
 <20210917034815.80264-3-songmuchun@bytedance.com> <CAGsJ_4ymutSL-pbWA_TykJ2vE8ZKc+JGn+w_WWy2j7Mn-q+ebA@mail.gmail.com>
 <CAMZfGtWWvDcz+JZtj0k_YZsD4j42cgaoWOCd1o8jArizqBYKgQ@mail.gmail.com> <CAGsJ_4zZfemMA9=85sgASacPqaT4OnV7RaYUwtQef=BzEfqW9w@mail.gmail.com>
In-Reply-To: <CAGsJ_4zZfemMA9=85sgASacPqaT4OnV7RaYUwtQef=BzEfqW9w@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 18 Sep 2021 19:47:38 +0800
Message-ID: <CAMZfGtV32Wya=rNw29S1suM8qGzHvYhaqvGeFEvsegy5Oxas0A@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 2/4] mm: hugetlb: replace hugetlb_free_vmemmap_enabled
 with a static_key
To:     Barry Song <21cnbao@gmail.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        Chen Huang <chenhuang5@huawei.com>,
        "Bodeddula, Balasubramaniam" <bodeddub@amazon.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com, Muchun Song <smuchun@gmail.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2021 at 7:15 PM Barry Song <21cnbao@gmail.com> wrote:
>
> On Sat, Sep 18, 2021 at 10:31 PM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > On Sat, Sep 18, 2021 at 12:55 PM Barry Song <21cnbao@gmail.com> wrote:
> > >
> > > On Sat, Sep 18, 2021 at 12:08 AM Muchun Song <songmuchun@bytedance.com> wrote:
> > > >
> > > > The page_head_if_fake() is used throughout memory management and the
> > > > conditional check requires checking a global variable, although the
> > > > overhead of this check may be small, it increases when the memory
> > > > cache comes under pressure. Also, the global variable will not be
> > > > modified after system boot, so it is very appropriate to use static
> > > > key machanism.
> > > >
> > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > > ---
> > > >  include/linux/hugetlb.h    |  6 +++++-
> > > >  include/linux/page-flags.h |  6 ++++--
> > > >  mm/hugetlb_vmemmap.c       | 10 +++++-----
> > > >  3 files changed, 14 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > > > index f7ca1a3870ea..ee3ddf3d12cf 100644
> > > > --- a/include/linux/hugetlb.h
> > > > +++ b/include/linux/hugetlb.h
> > > > @@ -1057,7 +1057,11 @@ static inline void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr
> > > >  #endif /* CONFIG_HUGETLB_PAGE */
> > > >
> > > >  #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> > > > -extern bool hugetlb_free_vmemmap_enabled;
> > > > +DECLARE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
> > > > +                        hugetlb_free_vmemmap_enabled_key);
> > > > +#define hugetlb_free_vmemmap_enabled                                    \
> > > > +       static_key_enabled(&hugetlb_free_vmemmap_enabled_key)
> > > > +
> > > >  #else
> > > >  #define hugetlb_free_vmemmap_enabled   false
> > > >  #endif
> > > > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > > > index 7b1a918ebd43..d68d2cf30d76 100644
> > > > --- a/include/linux/page-flags.h
> > > > +++ b/include/linux/page-flags.h
> > > > @@ -185,7 +185,8 @@ enum pageflags {
> > > >  #ifndef __GENERATING_BOUNDS_H
> > > >
> > > >  #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> > > > -extern bool hugetlb_free_vmemmap_enabled;
> > > > +DECLARE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
> > > > +                        hugetlb_free_vmemmap_enabled_key);
> > > >
> > > >  /*
> > > >   * If the feature of freeing some vmemmap pages associated with each HugeTLB
> > > > @@ -204,7 +205,8 @@ extern bool hugetlb_free_vmemmap_enabled;
> > > >   */
> > > >  static __always_inline const struct page *page_head_if_fake(const struct page *page)
> > > >  {
> > > > -       if (!hugetlb_free_vmemmap_enabled)
> > > > +       if (!static_branch_maybe(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
> > > > +                                &hugetlb_free_vmemmap_enabled_key))
> > >
> > > A question bothering me is that we still have hugetlb_free_vmemmap_enabled
> > > defined as static_key_enabled(&hugetlb_free_vmemmap_enabled_key).
> > > but here you are using static_branch_maybe() with the CONFIG and refer the key
> > > directly.
> > > Do we only need one of them? Or something is wrong?
> > >
> >
> > Yeah, we only need one. But my consideration is that we
> > use static_branch_maybe() for performance sensitive places.
> > So I do not change hugetlb_free_vmemmap_enabled
> > to static_branch_maybe(), this can reduce some codes
> > that need to be updated when the static key is enabled.
> > Actually, the user of hugetlb_free_vmemmap_enabled
> > is not performance sensitive.
>
> not quite sure if an unified inline API will be better, e.g.
>
> #ifdef CONFIG_SCHED_SMT
> extern struct static_key_false sched_smt_present;
>
> static __always_inline bool sched_smt_active(void)
> {
>         return static_branch_likely(&sched_smt_present);
> }
> #else
> static inline bool sched_smt_active(void) { return false; }
> #endif

Alright, I can change hugetlb_free_vmemmap_enabled to
an inline function.

>
> but in your case, CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> is always true in your page_head_if_fake(). Why do we check it
> again?

That is CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON
not CONFIG_HUGETLB_PAGE_FREE_VMEMMAP.

Thanks
