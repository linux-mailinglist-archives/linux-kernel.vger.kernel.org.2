Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6E6410603
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 13:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238898AbhIRLQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 07:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235543AbhIRLQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 07:16:32 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA155C061574;
        Sat, 18 Sep 2021 04:15:08 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id c22so40018548edn.12;
        Sat, 18 Sep 2021 04:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hhBkqFl9K1TvuEPZxNRIrEeIc4UVq6Zdqs07eDkUW5Y=;
        b=DMe+5i2O8BkVUhUwEcr5rpW2w02cGac1v9nLYWXMVnF6r9GjHW8xTD31282esI9/F5
         hahlmbR4IfxLKWBMqDYMPC1TR+I5qCQZFLM+AMDMcM2jfFM0zJnX+AVT1JfGCINA6213
         LbrWCkIGVM67C3+M2Emiv/2wuI9KCs4G8G8lRwzYgz8jK7evDExt592lTkLp8RrmJ7wH
         rjFS9Q7OiTmJQKG5HHnJ83BNYMw8vmxCgEJS8oujAlAzJPehErDJP8ONYIKyOPvmhMIb
         9Ck/CDOpfScZ2ZRIDlMYCyJ4tIJbsawt0MsFpIpE/lxWeTYG0tVE94pJstBvRrfbD/LI
         QUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hhBkqFl9K1TvuEPZxNRIrEeIc4UVq6Zdqs07eDkUW5Y=;
        b=oH9AbNTJAy4SP5q7daXx9T7w1OcMjOVFZtT6wjPDAr8NlxJsdlZCLMwCOOQXFn7as3
         NMvfGOJEtQxTSlRt+qL6e2ZCCruPl6cdDZU/VMg6UIq//cze/hAovxzRZK6TplcMn2ct
         OOuKrC6MIZ8KKkcwyM0BoAW9cWrpwi9nmjmajvBpi1/goT3Le3RsbF03coKHRBP+euOE
         K5aXrAon2OJnyXW1icJcWLDCF4NWSmz6FX2N1BMUP2WkAukDkS69/aImBUhJkLGDQECw
         KP4+OkcrEHp8oPdp4KidUd7etm3obPt/MhjQgQ7mnv5OLVD9XQlLrKvLkIS3kN/oV96J
         U6Gw==
X-Gm-Message-State: AOAM531ZyJJqvFRxq30IYJbomV3JT1NAiyun0XKhgSfJUeSS/MNfQdWM
        xdsf1w2nnFNtoW6HcQQbLW/01evxHpD2MSJhfII=
X-Google-Smtp-Source: ABdhPJwKdMhl8Jf4wHEUO3SuwBmvjG+48GphqJaicwEstAJlhgICwp/s15WSokVWIyN0XFwO7fmUKYXaOx2EWvgiUu0=
X-Received: by 2002:a17:906:dbe5:: with SMTP id yd5mr17297002ejb.134.1631963707450;
 Sat, 18 Sep 2021 04:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210917034815.80264-1-songmuchun@bytedance.com>
 <20210917034815.80264-3-songmuchun@bytedance.com> <CAGsJ_4ymutSL-pbWA_TykJ2vE8ZKc+JGn+w_WWy2j7Mn-q+ebA@mail.gmail.com>
 <CAMZfGtWWvDcz+JZtj0k_YZsD4j42cgaoWOCd1o8jArizqBYKgQ@mail.gmail.com>
In-Reply-To: <CAMZfGtWWvDcz+JZtj0k_YZsD4j42cgaoWOCd1o8jArizqBYKgQ@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Sat, 18 Sep 2021 23:14:56 +1200
Message-ID: <CAGsJ_4zZfemMA9=85sgASacPqaT4OnV7RaYUwtQef=BzEfqW9w@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 2/4] mm: hugetlb: replace hugetlb_free_vmemmap_enabled
 with a static_key
To:     Muchun Song <songmuchun@bytedance.com>
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

On Sat, Sep 18, 2021 at 10:31 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Sat, Sep 18, 2021 at 12:55 PM Barry Song <21cnbao@gmail.com> wrote:
> >
> > On Sat, Sep 18, 2021 at 12:08 AM Muchun Song <songmuchun@bytedance.com> wrote:
> > >
> > > The page_head_if_fake() is used throughout memory management and the
> > > conditional check requires checking a global variable, although the
> > > overhead of this check may be small, it increases when the memory
> > > cache comes under pressure. Also, the global variable will not be
> > > modified after system boot, so it is very appropriate to use static
> > > key machanism.
> > >
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > ---
> > >  include/linux/hugetlb.h    |  6 +++++-
> > >  include/linux/page-flags.h |  6 ++++--
> > >  mm/hugetlb_vmemmap.c       | 10 +++++-----
> > >  3 files changed, 14 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > > index f7ca1a3870ea..ee3ddf3d12cf 100644
> > > --- a/include/linux/hugetlb.h
> > > +++ b/include/linux/hugetlb.h
> > > @@ -1057,7 +1057,11 @@ static inline void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr
> > >  #endif /* CONFIG_HUGETLB_PAGE */
> > >
> > >  #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> > > -extern bool hugetlb_free_vmemmap_enabled;
> > > +DECLARE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
> > > +                        hugetlb_free_vmemmap_enabled_key);
> > > +#define hugetlb_free_vmemmap_enabled                                    \
> > > +       static_key_enabled(&hugetlb_free_vmemmap_enabled_key)
> > > +
> > >  #else
> > >  #define hugetlb_free_vmemmap_enabled   false
> > >  #endif
> > > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > > index 7b1a918ebd43..d68d2cf30d76 100644
> > > --- a/include/linux/page-flags.h
> > > +++ b/include/linux/page-flags.h
> > > @@ -185,7 +185,8 @@ enum pageflags {
> > >  #ifndef __GENERATING_BOUNDS_H
> > >
> > >  #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> > > -extern bool hugetlb_free_vmemmap_enabled;
> > > +DECLARE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
> > > +                        hugetlb_free_vmemmap_enabled_key);
> > >
> > >  /*
> > >   * If the feature of freeing some vmemmap pages associated with each HugeTLB
> > > @@ -204,7 +205,8 @@ extern bool hugetlb_free_vmemmap_enabled;
> > >   */
> > >  static __always_inline const struct page *page_head_if_fake(const struct page *page)
> > >  {
> > > -       if (!hugetlb_free_vmemmap_enabled)
> > > +       if (!static_branch_maybe(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
> > > +                                &hugetlb_free_vmemmap_enabled_key))
> >
> > A question bothering me is that we still have hugetlb_free_vmemmap_enabled
> > defined as static_key_enabled(&hugetlb_free_vmemmap_enabled_key).
> > but here you are using static_branch_maybe() with the CONFIG and refer the key
> > directly.
> > Do we only need one of them? Or something is wrong?
> >
>
> Yeah, we only need one. But my consideration is that we
> use static_branch_maybe() for performance sensitive places.
> So I do not change hugetlb_free_vmemmap_enabled
> to static_branch_maybe(), this can reduce some codes
> that need to be updated when the static key is enabled.
> Actually, the user of hugetlb_free_vmemmap_enabled
> is not performance sensitive.

not quite sure if an unified inline API will be better, e.g.

#ifdef CONFIG_SCHED_SMT
extern struct static_key_false sched_smt_present;

static __always_inline bool sched_smt_active(void)
{
        return static_branch_likely(&sched_smt_present);
}
#else
static inline bool sched_smt_active(void) { return false; }
#endif

but in your case, CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
is always true in your page_head_if_fake(). Why do we check it
again?

>
> Thanks.

Thanks
barry
