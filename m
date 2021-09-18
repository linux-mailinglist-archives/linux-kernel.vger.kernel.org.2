Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13DF74105F9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 12:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238383AbhIRKxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 06:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236901AbhIRKxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 06:53:08 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E906C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 03:51:45 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id me5-20020a17090b17c500b0019af76b7bb4so11150101pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 03:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xBFWMVLwmHIiRIbiBZy+2kXWxtuoqm6ONSYo0yLetxk=;
        b=wSs30QhbRby8deq8G74Z9mrupXOI0LHVqPjUhF7BA/lElDOz1xHJxU2OUwQDCQMNlh
         fvF2hX6tTH5AKwuwG0kHP4NgTot2e7T32S6It624AzA/V9YBszXbl0ShrCtbgnY184aO
         PHHeMGZo6u/fsaGL9rIsl13L/LDOVKVr/4A/f/3Pkn0xjoZC5nQA6jDQ/zRrBDOvkmEW
         oDtMOFBcjFAfgBI6RMHQhOomn9P4jQLiAiXLksx8sdR6m5pPiNRlljfj3SR4zHG21C2J
         c0uinWg4lus/S8aV+TFXOq3s/QldB4VIOYBh3VuK2GWuDEmbdUQmqtzVA8FgKE5c9CBm
         JOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xBFWMVLwmHIiRIbiBZy+2kXWxtuoqm6ONSYo0yLetxk=;
        b=cujFp3+LZtEatLyWAsUQZeQ74nYApRRRdPDlHlgwFA1MpMbDX9YU0AAhOu/wp7XF6m
         r40vtdmDgZ0C0IxnRCCY8eNiZL5xxilN43kM95mW98LAj2/ZIxtVZzdrs90y4AaZT2ry
         Fh+VSlcIfZByLjoVa1rH0J9V+xHR7kiz8Z9UukmkAsaD0agsPRKMfUH0wJGJEFp+Fs1W
         wMo+XqB/IvLuFRFWKFhqmolb2t16HFrggwuqa1ud8Sb3VJhEMK3rtrCLUaz1IX8tM2zG
         0yVCr6T7zblqzO3rBN6pbsSBgeflwaZ79LrP36zq+wdmhSsX4znKiTOySR4/gYWSx40v
         WBZw==
X-Gm-Message-State: AOAM531JLi33sVSm6fXAoFyg0H94WRVrj6DUGcRev1vY0TkwrU/i1R+d
        wRQojHEQTG6aKxXq1Da+X9u6tto5bw3RHvLbJZEjzg==
X-Google-Smtp-Source: ABdhPJxA0n1aW2qTA8q2EYKyRrnJdw0Nq1B3sRm0ZkNuBsUHNnADC9+jA1rOu2JCO4gYTVUHX/0OxXO6gzR+ZZT5MEA=
X-Received: by 2002:a17:90b:4f8a:: with SMTP id qe10mr16148057pjb.5.1631962304832;
 Sat, 18 Sep 2021 03:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210917034815.80264-1-songmuchun@bytedance.com>
 <20210917034815.80264-4-songmuchun@bytedance.com> <CAGsJ_4yWZTcRqnBmLrYJ3Z1Yo_7oWRgR4B3qK5m570xgpeJ-5Q@mail.gmail.com>
In-Reply-To: <CAGsJ_4yWZTcRqnBmLrYJ3Z1Yo_7oWRgR4B3qK5m570xgpeJ-5Q@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 18 Sep 2021 18:51:07 +0800
Message-ID: <CAMZfGtW1_U2d=zQFCYBEDfKWB=EkoYTGgVcCHauX-iv4VD7U8Q@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 3/4] mm: sparsemem: use page table lock to
 protect kernel pmd operations
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

On Sat, Sep 18, 2021 at 1:07 PM Barry Song <21cnbao@gmail.com> wrote:
>
> On Sat, Sep 18, 2021 at 12:09 AM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > The init_mm.page_table_lock is used to protect kernel page tables, we
> > can use it to serialize splitting vmemmap PMD mappings instead of mmap
> > write lock, which can increase the concurrency of vmemmap_remap_free().
> >
>
> Curious what is the actual benefit we get in user scenarios from this patch,
> 1. we set bootargs to reserve hugetlb statically
> 2. we "echo" some figures to sys or proc.
>
> In other words, Who is going to care about this concurrency?

Actually, It increase the concurrency between allocations of
HugeTLB pages. But it is not my first consideration. There are
a lot of users of mmap read lock of init_mm. The mmap write
lock is holding through vmemmap_remap_free(), I want to make
it does not affect other users of mmap read lock.

I suppose a lot of developers are trying to avoid using mmap write
lock. I am also one of them.

> Can we have some details on this to put in the commit log?

For sure. Those judgments above should be placed in the
commit log.

Thanks.
