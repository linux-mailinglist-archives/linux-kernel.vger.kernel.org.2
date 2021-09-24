Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB44416A9B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 05:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244035AbhIXDtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 23:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243998AbhIXDtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 23:49:51 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1B2C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 20:48:19 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id g184so8639805pgc.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 20:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=55VtlyNz396+JpxRe5XzK9GihMZwj0h8DOxcyBHo9jA=;
        b=A+HZL0TQw0/JIx2YTueXk53aoSLBZqw7hN/Kr1yTj29DNo8lPj73nMSzTIXAQ3a4pu
         ZO7v3oRMIOvflYRwLoQPSLBvcz1Bo7qMIjaF3j9Y2mBrb738r97kk3PKLRDx8UEO8oVq
         dil5WmIKeQgytTnZDwEjuC2Hqn+53NYASfChz3pXZZ7/rVQcvcNfvuAAdpsfqTxj9Hj5
         1BFd5jlRfoNdFT4yVd2GJpSmMMOyMvwAGltfQXJeJrfEOSAuAuEG9OwNIJDBJpLVEc/G
         ubIUYIkLBYXAnf9RF+PKqFVGuqcXrBuXKOqYc/kG5zQN/gD9ve/aMREw2VQW10F6gCXR
         //mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=55VtlyNz396+JpxRe5XzK9GihMZwj0h8DOxcyBHo9jA=;
        b=yqMS2q+2h05+UrV7qMsTwdgHBIekKe4XMSob/ZesgWla0DFaUWg1MB7KECW5BcP1Iz
         bTB/UW+ACh/tQtYIDRpc6/6qxERxQMWojpl34lBUUVzbtBjml2FCi/O3H8bB0eoqxNIh
         qNESieMpsAoEBwwuy1119Q5/VKAFy6kftnywSpW54tNCreW6B+t1oEsbl2o9kcKUX+TG
         a9QkLN/MyvFaS5E05zLT8xxfIGFOBzxiYUCbriQogT/mwjITXJLq+oFhCE64/SnZtf2V
         dlXGIVV0JcE0IWeh4y6vFqQwieIjveSgNgSM0jbVTjhz6lKnAiIFjFC6HFbhFxP2qaLk
         LjLg==
X-Gm-Message-State: AOAM5335ctEUxnh7sxrRyQhA6KUv9h/8PzDgmRVEn5oGvBjoqJsgfIqt
        vOQJtRY/CJDboHCMN+Bs52j52kpBgGkTBle7Ntz9Jw==
X-Google-Smtp-Source: ABdhPJzsuvPN4esPZ5R7sb4qNFl6IeD82m5Yb/d/AMvrv/fx9r5w4olVNshH5RQ/pueHQP3Gk1bT5nko+hpNZRRqmjQ=
X-Received: by 2002:a63:1a64:: with SMTP id a36mr1923133pgm.225.1632455299009;
 Thu, 23 Sep 2021 20:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210922102411.34494-1-songmuchun@bytedance.com>
 <20210922102411.34494-3-songmuchun@bytedance.com> <CAGsJ_4zk8KfsByum89PqwNEkez=QUW9YH0tVy5nce2E0RhQ8dw@mail.gmail.com>
In-Reply-To: <CAGsJ_4zk8KfsByum89PqwNEkez=QUW9YH0tVy5nce2E0RhQ8dw@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 24 Sep 2021 11:47:39 +0800
Message-ID: <CAMZfGtXd2-CbbQeHp7qsaL0z-CviLfacoQf5ToQJQ230Lrw58w@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] mm: hugetlb: replace hugetlb_free_vmemmap_enabled
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

On Fri, Sep 24, 2021 at 6:24 AM Barry Song <21cnbao@gmail.com> wrote:
>
> On Wed, Sep 22, 2021 at 10:27 PM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > The page_head_if_fake() is used throughout memory management and the
> > conditional check requires checking a global variable, although the
> > overhead of this check may be small, it increases when the memory
> > cache comes under pressure. Also, the global variable will not be
> > modified after system boot, so it is very appropriate to use static
> > key machanism.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  include/linux/hugetlb.h    | 10 ++++++++--
> >  include/linux/page-flags.h |  6 ++++--
> >  mm/hugetlb_vmemmap.c       | 12 ++++++------
> >  mm/memory_hotplug.c        |  2 +-
> >  4 files changed, 19 insertions(+), 11 deletions(-)
> >
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index 1faebe1cd0ed..4cc647a5dbf8 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -1066,9 +1066,15 @@ static inline void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr
> >  #endif /* CONFIG_HUGETLB_PAGE */
> >
> >  #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> > -extern bool hugetlb_free_vmemmap_enabled;
> > +static inline bool hugetlb_free_vmemmap_enabled(void)
> > +{
> > +       return static_key_enabled(&hugetlb_free_vmemmap_enabled_key);
>
> could it be
>        if (static_branch_maybe(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
>                                 &hugetlb_free_vmemmap_enabled_key))
>
> then we are able to remove the duplication in page_fixed_fake_head()?

Definitely. I'll update in the next version.

Thanks.

>
> > +}
> >  #else
> > -#define hugetlb_free_vmemmap_enabled   false
> > +static inline bool hugetlb_free_vmemmap_enabled(void)
> > +{
> > +       return false;
> > +}
> >  #endif
> >
> >  static inline spinlock_t *huge_pte_lock(struct hstate *h,
> > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > index b47a7f51d2c3..54e119e44496 100644
> > --- a/include/linux/page-flags.h
> > +++ b/include/linux/page-flags.h
> > @@ -185,7 +185,8 @@ enum pageflags {
> >  #ifndef __GENERATING_BOUNDS_H
> >
> >  #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> > -extern bool hugetlb_free_vmemmap_enabled;
> > +DECLARE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
> > +                        hugetlb_free_vmemmap_enabled_key);
> >
> >  /*
> >   * If the feature of freeing some vmemmap pages associated with each HugeTLB
> > @@ -205,7 +206,8 @@ extern bool hugetlb_free_vmemmap_enabled;
> >   */
> >  static __always_inline const struct page *page_fixed_fake_head(const struct page *page)
> >  {
> > -       if (!hugetlb_free_vmemmap_enabled)
> > +       if (!static_branch_maybe(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
> > +                                &hugetlb_free_vmemmap_enabled_key))
> >                 return page;
> >         /*
> >          * Only addresses aligned with PAGE_SIZE of struct page may be fake head
> > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > index 527bcaa44a48..47517e878ed5 100644
> > --- a/mm/hugetlb_vmemmap.c
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -188,9 +188,9 @@
> >  #define RESERVE_VMEMMAP_NR             1U
> >  #define RESERVE_VMEMMAP_SIZE           (RESERVE_VMEMMAP_NR << PAGE_SHIFT)
> >
> > -bool hugetlb_free_vmemmap_enabled __read_mostly =
> > -       IS_ENABLED(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON);
> > -EXPORT_SYMBOL(hugetlb_free_vmemmap_enabled);
> > +DEFINE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
> > +                       hugetlb_free_vmemmap_enabled_key);
> > +EXPORT_SYMBOL(hugetlb_free_vmemmap_enabled_key);
> >
> >  static int __init early_hugetlb_free_vmemmap_param(char *buf)
> >  {
> > @@ -204,9 +204,9 @@ static int __init early_hugetlb_free_vmemmap_param(char *buf)
> >                 return -EINVAL;
> >
> >         if (!strcmp(buf, "on"))
> > -               hugetlb_free_vmemmap_enabled = true;
> > +               static_branch_enable(&hugetlb_free_vmemmap_enabled_key);
> >         else if (!strcmp(buf, "off"))
> > -               hugetlb_free_vmemmap_enabled = false;
> > +               static_branch_disable(&hugetlb_free_vmemmap_enabled_key);
> >         else
> >                 return -EINVAL;
> >
> > @@ -284,7 +284,7 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
> >         BUILD_BUG_ON(__NR_USED_SUBPAGE >=
> >                      RESERVE_VMEMMAP_SIZE / sizeof(struct page));
> >
> > -       if (!hugetlb_free_vmemmap_enabled)
> > +       if (!hugetlb_free_vmemmap_enabled())
> >                 return;
> >
> >         vmemmap_pages = (nr_pages * sizeof(struct page)) >> PAGE_SHIFT;
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index 0488eed3327c..89c1fde02162 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -1341,7 +1341,7 @@ bool mhp_supports_memmap_on_memory(unsigned long size)
> >          *       populate a single PMD.
> >          */
> >         return memmap_on_memory &&
> > -              !hugetlb_free_vmemmap_enabled &&
> > +              !hugetlb_free_vmemmap_enabled() &&
> >                IS_ENABLED(CONFIG_MHP_MEMMAP_ON_MEMORY) &&
> >                size == memory_block_size_bytes() &&
> >                IS_ALIGNED(vmemmap_size, PMD_SIZE) &&
> > --
> > 2.11.0
> >
>
> Thanks
> barry
