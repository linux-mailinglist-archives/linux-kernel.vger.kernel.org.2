Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427183D7025
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 09:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbhG0HQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 03:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbhG0HQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 03:16:29 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4356AC061760
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 00:16:30 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c16so9162197plh.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 00:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bKC84XaSphQuDQX3Q4os9LEp/o8VsHBxPfbvxrdpw8g=;
        b=OwiBlgeDOlRH50jaV5RCT+PgIPPbRpsmxhBpmRsIM9fDqNi/4zgFbY9dopH8RFi0yU
         yuKdMK7KXeNB7+NGVx7NuE5X++fVjy3g5lG4gk+TUs0TOtvPhX+KhcDDlASt7yTD0BHI
         WdxyPbXPJxGuk32uxWIartQfpEtI4PQ/mgf87IgXM/mpEyZwxroIzWYBrz4RB2r9uh1y
         bfs+xBeA6rE5Jcm2+vVYDRkwN4vqNt7lbzJVWIB3CLxmh9YXhV28YakiBJKThwV2AuT9
         dERLtEs+forZ6Eo1llKBcPVc4yzXmqw6ZcofvQ+edDd6Xkud5B4xrXki85fTzKMa3KBA
         /nBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bKC84XaSphQuDQX3Q4os9LEp/o8VsHBxPfbvxrdpw8g=;
        b=kEuttWvWhl94WVw6ZvvrgtdmU8Kk89hVFIjWBxeRwRwe1IVel4v3Ch2kDMErJgg09Q
         m74mKtA+AGBQWWQ6OQ9ZpHJ2zWFTxkKxZ1XW2nwUmQT/AAM3kLYkZOZ2Ns9Qae4OiyIn
         KrfqXQZQxUZf4Gj9NEZgdlX79+/6NCI+LMJiFax+jW7xRYf1GX7joPKkfji1Hdm7Q1M3
         XblL83Luc7S6Gfj75OUU/DEWgI5s6lyzTfS4o8aAXU+5YZZIfPc9bWK4iFeRzXzGLkW9
         myL6oxUT3EzYWEmVMf52asYlgu3sKjU/WElvtBM5mVCbC/zEIv4QtD8SIND5yhku/5H3
         OWxg==
X-Gm-Message-State: AOAM5336+tfKAYWjLydHqdvy+a5GXT4Zp2w+yo9dl9hNwMAbj02eWCj3
        LmZ1L8ugxR1moGPRx/vQf/KUJtAF672fElh80xoJ/g==
X-Google-Smtp-Source: ABdhPJxF9oRwI8Oz5wbwdM8pBPWdXdq4eg1Pbto1lovz7LB3/FTv8mQ5dlcrT+l5xb7DKqmFQLNS0DDnBQUH7iy3M0Y=
X-Received: by 2002:a63:cd4b:: with SMTP id a11mr22181343pgj.273.1627370189757;
 Tue, 27 Jul 2021 00:16:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210714091800.42645-1-songmuchun@bytedance.com>
 <20210714091800.42645-4-songmuchun@bytedance.com> <YP8mKV4wTp5sPIZg@casper.infradead.org>
In-Reply-To: <YP8mKV4wTp5sPIZg@casper.infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 27 Jul 2021 15:15:52 +0800
Message-ID: <CAMZfGtUKKcduZb5w7NED53Ke8UwNtiNZRp8ttbUb=TH-K1zgPA@mail.gmail.com>
Subject: Re: [PATCH 3/5] mm: hugetlb: free the 2nd vmemmap page associated
 with each HugeTLB page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        Chen Huang <chenhuang5@huawei.com>,
        "Bodeddula, Balasubramaniam" <bodeddub@amazon.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 5:17 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Jul 14, 2021 at 05:17:58PM +0800, Muchun Song wrote:
> > +#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> > +extern bool hugetlb_free_vmemmap_enabled;
> > +
> > +/*
> > + * If the feature of freeing some vmemmap pages associated with each HugeTLB
> > + * page is enabled, the head vmemmap page frame is reused and all of the tail
> > + * vmemmap addresses map to the head vmemmap page frame (furture details can
> > + * refer to the figure at the head of the mm/hugetlb_vmemmap.c).  In other
> > + * word, there are more than one page struct with PG_head associated with each
> > + * HugeTLB page.  We __know__ that there is only one head page struct, the tail
> > + * page structs with PG_head are fake head page structs.  We need an approach
> > + * to distinguish between those two different types of page structs so that
> > + * compound_head() can return the real head page struct when the parameter is
> > + * the tail page struct but with PG_head. This is what page_head_if_fake()
> > + * does.
> > + *
> > + * The page_head_if_fake() returns the real head page struct iff the @page may
> > + * be fake, otherwise, returns NULL if the @page cannot be a fake page struct.
> > + * The following figure describes how to distinguish between real and fake head
> > + * page struct.
> > + *
> > + *   if (test_bit(PG_head, &page->flags)) {
> > + *           unsigned long head = READ_ONCE(page[1].compound_head);
> > + *
> > + *           if (head & 1) {
> > + *                   if (head == (unsigned long)page + 1)
> > + *                           ==> head page struct
> > + *                   else
> > + *                           ==> tail page struct
> > + *           } else
> > + *                   ==> head page struct
> > + *   } else
> > + *           ==> cannot be fake head page struct
>
> I'm not sure we need the pseudocode when the code is right there ...

Maybe it is redundant. I'll remove this in the next version.

>
> > + * We can safely access the field of the @page[1] with PG_head because it means
> > + * that the @page is a compound page composed with at least two contiguous
> > + * pages.
> > + */
> > +static __always_inline struct page *page_head_if_fake(const struct page *page)
> > +{
> > +     if (!hugetlb_free_vmemmap_enabled)
> > +             return NULL;
> > +
> > +     /*
> > +      * Only addresses aligned with PAGE_SIZE of struct page may be fake head
> > +      * struct page. The alignment check aims to avoid access the fields (
> > +      * e.g. compound_head) of the @page[1]. It can avoid touch a (possibly)
> > +      * cold cacheline in some cases.
> > +      */
> > +     if (IS_ALIGNED((unsigned long)page, PAGE_SIZE) &&
> > +         test_bit(PG_head, &page->flags)) {
> > +             unsigned long head = READ_ONCE(page[1].compound_head);
> > +
> > +             if (likely(head & 1))
> > +                     return (struct page *)(head - 1);
> > +     }
> > +
> > +     return NULL;
> > +}
>
> Why return 'NULL' instead of 'page'?

Returning @page is also fine. Will do in the next version.

>
> This is going to significantly increase the cost of calling
> compound_page() (by whichever spelling it has).  That will make
> the folio patchset more compelling ;-)

As Mike mentationed, do you have any recommended
benchmark (suspect you have a lot of experience on
this)?

Thanks.
