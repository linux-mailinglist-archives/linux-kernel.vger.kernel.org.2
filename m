Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A43B4142CD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 09:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbhIVHij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 03:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbhIVHii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 03:38:38 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75488C061574;
        Wed, 22 Sep 2021 00:37:08 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id c22so6227310edn.12;
        Wed, 22 Sep 2021 00:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f2cn46e7fvitNFgRCkYBjxUisxaYsh8StFbDqMf5MkQ=;
        b=J0+AtfxhIGge/+4pYXIl28uZDukhG3ee3PWXPWoykkg1dDrP4y7tK4ot/1mLl3Ug4x
         cjuwGU9cqlC5P5zr24tGkkPpCqxh+g5CvqaoIZxddWIVw5SpnUZoXwabMo2zqG8Non/9
         slF6l3u9tHqttffZduQ10BSgV2GSco4n5huaG9KvvspKzOqvYsgV7HgHKhAEKFyHCe7i
         5lSDSOMxtdorZx1ZOg4QODYUlC2Jwt1u3SLnsMw0PeNovAS0oYLy9mHxGKk8+V59X8kj
         PRVdOPwBWFbZU1SymN9KyVM3cD/GpOHjDwkkie0f3AcehqksSO4nXt0xYVo/gB67epYw
         j0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f2cn46e7fvitNFgRCkYBjxUisxaYsh8StFbDqMf5MkQ=;
        b=UT3FOfwSOjz8bEkZIccFegh06bthPjrjnACIcwjVREanjnDHX840ntlnRer8yonBMP
         tDf5vYw828MU3uq8K5YcTuZ8NtfTafjg6xSbmVZgXn6N0p5Za+mSNACCa/mAiqHKhWik
         Jf0t4m/wLYTYMty9rnbYEFG1ZeyotaH/lXgvWobuPYlxoi0yLgKlsCxuVTOcsmJKe+5K
         uEY2lHC7AG3nuui/L2Nu4VGb9cvF5Hk+g4JWM09oUcYXDMul9LPpZ13RXx2B59rEOf3x
         nx4Kcok5GjW1n6XPLe8z99CLYk38z8vylnlP3LhNzIqHjHpL4PRZ1Slx+Z2YUUdfr2Ht
         /vRQ==
X-Gm-Message-State: AOAM532ovnmZHBlQkUW6aqXmiLmWVrlTz6sZrrFgs6cvrSkQUD/C6ovJ
        TGswOd78LiaSFgdFR8MUI8dIlWQMPZQYZKDc9jM=
X-Google-Smtp-Source: ABdhPJxcNLrrQmHwIdONHsPEL4XpWXQ8tY6S2A+7cd0aOTnTlVdfar48HMCfxRnrMDRjpju6il59XjKcOjTPOCN6rOA=
X-Received: by 2002:a17:906:5045:: with SMTP id e5mr40992429ejk.239.1632296226866;
 Wed, 22 Sep 2021 00:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210917034815.80264-1-songmuchun@bytedance.com>
 <20210917034815.80264-2-songmuchun@bytedance.com> <CAGsJ_4y8mZh4RNaY-JQHa5Sr+Tv3HingV42jwK9KoJ+0m=w87A@mail.gmail.com>
 <CAMZfGtVmhHGNizHsdJXygigm84Z72B3wtUYxpT1XW3GpWh1AWQ@mail.gmail.com>
 <CAMZfGtVy7rh4p4bNu3GgX0hvPGupSLkJtfOtQuQRfDgf7ZqcYQ@mail.gmail.com>
 <CAGsJ_4x-pmqG08wkpty8zM19jptHCktHjbNFqdbHUQkusncAvw@mail.gmail.com>
 <CAMZfGtX7vmmO5CzcJAdxa6bRsqz6J48ZdXZ19pGmks_o-3g2bg@mail.gmail.com>
 <CAGsJ_4wC-zATatP6dvMMHUAS2eQ50oCJRrodh+1YR_zcW6ySWg@mail.gmail.com> <CAMZfGtW=FvGObQaJ5MzYhr8Ug9guVyZeE1eyEBm+2Cqjnh5jtw@mail.gmail.com>
In-Reply-To: <CAMZfGtW=FvGObQaJ5MzYhr8Ug9guVyZeE1eyEBm+2Cqjnh5jtw@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 22 Sep 2021 19:36:55 +1200
Message-ID: <CAGsJ_4zGngnjpr3UGx8CqZpD9+ifu4a7i2AayzQ9n9gFsj2BnQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 1/4] mm: hugetlb: free the 2nd vmemmap page
 associated with each HugeTLB page
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

On Wed, Sep 22, 2021 at 2:39 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Wed, Sep 22, 2021 at 4:43 AM Barry Song <21cnbao@gmail.com> wrote:
> >
> > On Wed, Sep 22, 2021 at 1:46 AM Muchun Song <songmuchun@bytedance.com> wrote:
> > >
> > > On Tue, Sep 21, 2021 at 8:11 PM Barry Song <21cnbao@gmail.com> wrote:
> > > >
> > > > On Tue, Sep 21, 2021 at 10:23 PM Muchun Song <songmuchun@bytedance.com> wrote:
> > > > >
> > > > > On Sat, Sep 18, 2021 at 6:06 PM Muchun Song <songmuchun@bytedance.com> wrote:
> > > > > >
> > > > > > On Sat, Sep 18, 2021 at 12:39 PM Barry Song <21cnbao@gmail.com> wrote:
> > > > > > >
> > > > > > > On Sat, Sep 18, 2021 at 12:08 AM Muchun Song <songmuchun@bytedance.com> wrote:
> > > > > > > >
> > > > > > > > Currently, we only free 6 vmemmap pages associated with a 2MB HugeTLB
> > > > > > > > page. However, we can remap all tail vmemmap pages to the page frame
> > > > > > > > mapped to with the head vmemmap page. Finally, we can free 7 vmemmap
> > > > > > > > pages for a 2MB HugeTLB page. It is a fine gain (e.g. we can save
> > > > > > > > extra 2GB memory when there is 1TB HugeTLB pages in the system
> > > > > > > > compared with the current implementation).
> > > > > > > >
> > > > > > > > But the head vmemmap page is not freed to the buddy allocator and all
> > > > > > > > tail vmemmap pages are mapped to the head vmemmap page frame. So we
> > > > > > > > can see more than one struct page struct with PG_head (e.g. 8 per 2 MB
> > > > > > > > HugeTLB page) associated with each HugeTLB page. We should adjust
> > > > > > > > compound_head() to make it returns the real head struct page when the
> > > > > > > > parameter is the tail struct page but with PG_head flag.
> > > > > > > >
> > > > > > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > > > > > > ---
> > > > > > > >  Documentation/admin-guide/kernel-parameters.txt |  2 +-
> > > > > > > >  include/linux/page-flags.h                      | 75 +++++++++++++++++++++++--
> > > > > > > >  mm/hugetlb_vmemmap.c                            | 60 +++++++++++---------
> > > > > > > >  mm/sparse-vmemmap.c                             | 21 +++++++
> > > > > > > >  4 files changed, 126 insertions(+), 32 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > > > > > > index bdb22006f713..a154a7b3b9a5 100644
> > > > > > > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > > > > > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > > > > > > @@ -1606,7 +1606,7 @@
> > > > > > > >                         [KNL] Reguires CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> > > > > > > >                         enabled.
> > > > > > > >                         Allows heavy hugetlb users to free up some more
> > > > > > > > -                       memory (6 * PAGE_SIZE for each 2MB hugetlb page).
> > > > > > > > +                       memory (7 * PAGE_SIZE for each 2MB hugetlb page).
> > > > > > > >                         Format: { on | off (default) }
> > > > > > > >
> > > > > > > >                         on:  enable the feature
> > > > > > > > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > > > > > > > index 8e1d97d8f3bd..7b1a918ebd43 100644
> > > > > > > > --- a/include/linux/page-flags.h
> > > > > > > > +++ b/include/linux/page-flags.h
> > > > > > > > @@ -184,13 +184,64 @@ enum pageflags {
> > > > > > > >
> > > > > > > >  #ifndef __GENERATING_BOUNDS_H
> > > > > > > >
> > > > > > > > +#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> > > > > > > > +extern bool hugetlb_free_vmemmap_enabled;
> > > > > > > > +
> > > > > > > > +/*
> > > > > > > > + * If the feature of freeing some vmemmap pages associated with each HugeTLB
> > > > > > > > + * page is enabled, the head vmemmap page frame is reused and all of the tail
> > > > > > > > + * vmemmap addresses map to the head vmemmap page frame (furture details can
> > > > > > > > + * refer to the figure at the head of the mm/hugetlb_vmemmap.c).  In other
> > > > > > > > + * word, there are more than one page struct with PG_head associated with each
> > > > > > > > + * HugeTLB page.  We __know__ that there is only one head page struct, the tail
> > > > > > > > + * page structs with PG_head are fake head page structs.  We need an approach
> > > > > > > > + * to distinguish between those two different types of page structs so that
> > > > > > > > + * compound_head() can return the real head page struct when the parameter is
> > > > > > > > + * the tail page struct but with PG_head.
> > > > > > > > + *
> > > > > > > > + * The page_head_if_fake() returns the real head page struct iff the @page may
> > > > > > > > + * be fake, otherwise, returns the @page if it cannot be a fake page struct.
> > > > > > > > + */
> > > > > > > > +static __always_inline const struct page *page_head_if_fake(const struct page *page)
> > > > > > > > +{
> > > > > > > > +       if (!hugetlb_free_vmemmap_enabled)
> > > > > > > > +               return page;
> > > > > > > > +
> > > > > > > > +       /*
> > > > > > > > +        * Only addresses aligned with PAGE_SIZE of struct page may be fake head
> > > > > > > > +        * struct page. The alignment check aims to avoid access the fields (
> > > > > > > > +        * e.g. compound_head) of the @page[1]. It can avoid touch a (possibly)
> > > > > > > > +        * cold cacheline in some cases.
> > > > > > > > +        */
> > > > > > > > +       if (IS_ALIGNED((unsigned long)page, PAGE_SIZE) &&
> > > > > > > > +           test_bit(PG_head, &page->flags)) {
> > > > > > > > +               /*
> > > > > > > > +                * We can safely access the field of the @page[1] with PG_head
> > > > > > > > +                * because the @page is a compound page composed with at least
> > > > > > > > +                * two contiguous pages.
> > > > > > > > +                */
> > > > > > > > +               unsigned long head = READ_ONCE(page[1].compound_head);
> > > > > > > > +
> > > > > > > > +               if (likely(head & 1))
> > > > > > > > +                       return (const struct page *)(head - 1);
> > > > > > > > +       }
> > > > > > > > +
> > > > > > > > +       return page;
> > > > > > > > +}
> > > > > > > > +#else
> > > > > > > > +static __always_inline const struct page *page_head_if_fake(const struct page *page)
> > > > > > > > +{
> > > > > > > > +       return page;
> > > > > > > > +}
> > > > > > > > +#endif
> > > > > > > > +
> > > > > > > >  static inline unsigned long _compound_head(const struct page *page)
> > > > > > > >  {
> > > > > > > >         unsigned long head = READ_ONCE(page->compound_head);
> > > > > > > >
> > > > > > > >         if (unlikely(head & 1))
> > > > > > > >                 return head - 1;
> > > > > > > > -       return (unsigned long)page;
> > > > > > > > +       return (unsigned long)page_head_if_fake(page);
> > > > > > >
> > > > > > > hard to read. page_head_if_fake,  what is the other side of
> > > > > > > page_head_if_not_fake?
> > > > > >
> > > > > > 1) return itself if the @page is not a fake head page.
> > > > > > 2) return head page if @page is a fake head page.
> > > > > >
> > > > > > So I want to express that page_head_if_fake returns a
> > > > > > head page only and only if the parameter of @page is a
> > > > > > fake head page. Otherwise, it returns itself.
> > > > > >
> > > > > > > I would expect something like
> > > > > > > page_to_page_head()
> > > > > > > or
> > > > > > > get_page_head()
> > > > > > >
> > > > > >
> > > > > > Those names seem to be not appropriate as well, because
> > > > > > its functionality does not make sure it can return a head
> > > > > > page. If the parameter is a head page, it definitely
> > > > > > returns a head page, otherwise, it may return itself which
> > > > > > may be a tail page.
> > > > > >
> > > > > > From this point of view, I still prefer page_head_if_fake.
> > > > > >
> > > > > > > Anyway, I am not quite sure what is the best name. but page_head_if_fake(page)
> > > > > > > sounds odd to me. just like the things have two sides, but if_fake  presents
> > > > > > > one side only.
> > > > > >
> > > > > > If others have any ideas, comments are welcome.
> > > > > >
> > > > > > >
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  #define compound_head(page)    ((typeof(page))_compound_head(page))
> > > > > > > > @@ -225,12 +276,14 @@ static inline unsigned long _compound_head(const struct page *page)
> > > > > > > >
> > > > > > > >  static __always_inline int PageTail(struct page *page)
> > > > > > > >  {
> > > > > > > > -       return READ_ONCE(page->compound_head) & 1;
> > > > > > > > +       return READ_ONCE(page->compound_head) & 1 ||
> > > > > > > > +              page_head_if_fake(page) != page;
> > > > > > >
> > > > > > > i would expect a wrapper like:
> > > > > > > page_is_fake_head()
> > > > > >
> > > > > > Good point. Will do.
> > > > > >
> > > > > > >
> > > > > > > and the above page_to_page_head() can leverage the wrapper.
> > > > > > > here too.
> > > > > > >
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  static __always_inline int PageCompound(struct page *page)
> > > > > > > >  {
> > > > > > > > -       return test_bit(PG_head, &page->flags) || PageTail(page);
> > > > > > > > +       return test_bit(PG_head, &page->flags) ||
> > > > > > > > +              READ_ONCE(page->compound_head) & 1;
> > > > > > >
> > > > > > > hard to read. could it be something like the below?
> > > > > > > return PageHead(page) || PageTail(page);
> > > > > > >
> > > > > > > or do we really need to change this function? even a fake head still has
> > > > > > > the true test_bit(PG_head, &page->flags), though it is not a real head, it
> > > > > > > is still a pagecompound, right?
> > > > > >
> > > > > > Right. PageCompound() can not be changed.  It is odd but
> > > > > > efficient because calling page_head_if_fake is eliminated.
> > > > > > So I select performance not readability. I'm not sure if it's
> > > > > > worth it.
> > > > >
> > > > > In order to improve readability, I'll introduce 3 helpers as follows.
> > > > >
> > > > > 1) page_head_or_fake(), which returns true for the head page
> > > > >    or fake head page.
> > > > > 2) page_head_is_fake(), which returns true for fake head page.
> > > > > 3) page_tail_not_fake_head(), which returns true for the tail page
> > > > >    except the fake head page.
> > > > >
> > > > > In the end, PageHead(), PageTail() and PageCompound() become
> > > > > the following.
> > > > >
> > > > > static __always_inline int PageHead(struct page *page)
> > > > > {
> > > > >     return page_head_or_fake(page) && !page_head_is_fake(page);
> > > > > }
> > > > >
> > > > > static __always_inline int PageTail(struct page *page)
> > > > > {
> > > > >     return page_tail_not_fake_head(page) || page_head_is_fake(page);
> > > > > }
> > > > >
> > > > > static __always_inline int PageCompound(struct page *page)
> > > > > {
> > > > >     return page_head_or_fake(page) || page_tail_not_fake_head(page);
> > > > > }
> > > > >
> > > > > Do those look more readable?
> > > > >
> > > >
> > > > still not good enough. After a second thought, page_head_if_fake seems
> > > > to have the best performance though this function returns an odd value.
> > > > i just made a little bit refine on your code in doc:
> > >
> > > Right. page_head_if_fake is the choice for performance.
> > >
> > > >
> > > > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > > > index 2c0d11e71e26..240c2fca13c7 100644
> > > > --- a/include/linux/page-flags.h
> > > > +++ b/include/linux/page-flags.h
> > > > @@ -197,8 +197,9 @@ extern bool hugetlb_free_vmemmap_enabled;
> > > >   * compound_head() can return the real head page struct when the parameter is
> > > >   * the tail page struct but with PG_head.
> > > >   *
> > > > - * The page_head_if_fake() returns the real head page struct iff the @page may
> > > > - * be fake, otherwise, returns the @page if it cannot be a fake page struct.
> > > > + * The page_head_if_fake() returns the real head page struct if the @page is
> > > > + * fake page_head, otherwise, returns @page which can either be a true page_
> > > > + * head or tail.
> > > >   */
> > >
> > > Good annotation.
> > >
> > > >  static __always_inline const struct page *page_head_if_fake(const
> > > > struct page *page)
> > > >  {
> > > > @@ -226,6 +227,12 @@ static __always_inline const struct page
> > > > *page_head_if_fake(const struct page *p
> > > >
> > > >         return page;
> > > >  }
> > > > +
> > > > +static __always_inline const struct page *page_is_fake_head(const
> > > > struct page *page)
> > > > +{
> > > > +       return page_head_if_fake(page) != page;
> > > > +}
> > > > +
> > > >  #else
> > > >  static __always_inline const struct page *page_head_if_fake(const
> > > > struct page *page)
> > > >  {
> > > > @@ -247,7 +254,7 @@ static inline unsigned long _compound_head(const
> > > > struct page *page)
> > > >  static __always_inline int PageTail(struct page *page)
> > > >  {
> > > >         return READ_ONCE(page->compound_head) & 1 ||
> > > > -              page_head_if_fake(page) != page;
> > > > +              page_is_fake_head(page);
> > > >  }
> > >
> > > Yeah, this makes PageTail more readable. In your previous thread,
> > > you proposed that why not use PageTail in PageCompound directly
> > > to improve code readability. So I want to introduce 2 more helpers
> > > besides page_is_fake_head().
> > >
> > > static __always_inline int page_tail_not_fake_head(struct page *page)
> > > {
> > >     return READ_ONCE(page->compound_head) & 1;
> > > }
> > >
> > > static __always_inline int page_head_or_fake(struct page *page)
> > > {
> > >     return test_bit(PG_head, &page->flags);
> > > }
> > >
> > > Then PageTail() and PageCompound() change to the following.
> > >
> > > static __always_inline int PageTail(struct page *page)
> > > {
> > >     return page_tail_not_fake_head(page) || page_is_fake_head(page);
> > > }
> > >
> > > static __always_inline int PageCompound(struct page *page)
> > > {
> > >     return page_head_or_fake(page) || page_tail_not_fake_head(page);
> > > }
> > >
> > > From the point of names of helpers, they act as self-annotation.
> > > So I think PageTail and PageCompound become readable
> > > as well. But you said "still not good enough". Is it because of
> > > the names of helpers or introducing more complexity?
> >
> > I really don't think it is worth this complexity. If there is anything to make
>
> Got it.
>
> > the code more readable, I would rename page_head_if_fake() to
> > page_fixed_dup_head().
>
> Here means page_fixed_up_head, right? Is it a typo?

I actually meant "duplicated", but in your case, it is "fake".
It doesn't matter too much. Both are ok.

>
> Thanks.
>
> >
> > this function fixes up the page:
> > 1. if the page is a fake head, we need to return its true head (things
> > get fixed.)
> > 2. if the page is not a fake head, in other words, it is either true
> > head or tail, no need to fix anything.
> >
> > >
> > > Thanks.

Thanks
barry
