Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C5F410600
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 13:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238856AbhIRLDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 07:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238803AbhIRLDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 07:03:22 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CF8C061574;
        Sat, 18 Sep 2021 04:01:58 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id q3so40037593edt.5;
        Sat, 18 Sep 2021 04:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tgwWxXw9qWF2mVmQmH8HomBdLaqa+aeD+D207S0R8ng=;
        b=lN6I6aPUKmTKLDI68h3zBHjMSSGs872bSN081mM5Hgxr9QKqBGUbcbrvl1T8xbqNrE
         No0TnssdKr0M12kaVlsMUlSn1Ejf583f9lzeCVudQ37+pOtA3vuiw0J3afTyEx+NSZg0
         YVybYMTtQNkjXHBMokgfidQnvbjHIN9rHgHBdjeEJWHTjd5mNZaBQh5MFnEmExLxqj8D
         qgHq2fFREKQBI9jtGlPTlbP2sLfa1Duzo+8bv1q67U2yfmIe92XnMGvjraxTRJTQBUD0
         PeyVpGGhGNWkq8Yn2htEHAa1syQ9LyiH/KWgT9QXxTv5N880wvo3EOLDnWuHiXmDwCwR
         aKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tgwWxXw9qWF2mVmQmH8HomBdLaqa+aeD+D207S0R8ng=;
        b=npSsgFWPilyrVUwI9bgCHcJ6siuiaUBmoT9SAhH2I4twPhL0Vdk0+glVMjgDEY8+QN
         nlFSZT6JimnvQsMiQWFw143vmxJ7Wf84c/nAe+QT8bhO+aLLRVVmiPfvEQ6bAmHciVNo
         vUPLsiM3PjvO2F6ulMYoiQ6/S+PHq24wTzdLxSRwLzLmykviMBf2exEleKVGvgSWZQuC
         HcnoUASCy6MQSfNpZkvA1/c9tc8ZG+tQ5d9BYW3vlUa7xbjX5FZNYlT+7VQnf8FwhYow
         U1QglJqQr5aLJDznjT1i5GMljGKKnC4KVy9E64HghY7Spel1jsT0oMp734W+H6BdCvRS
         I9cg==
X-Gm-Message-State: AOAM530Hg8qmcjh16DDbnK/BeQjNv32dmhHRe/zU++/T5JKZc7m8aAGQ
        CEKFBW9/7Zwm7G80T8s6YxLxjInohCN3u4fRvsM=
X-Google-Smtp-Source: ABdhPJxjPMJGz7fysVmvyYs/Qt49TE0aDl7xo4okt8Q49xuOgw86nnNYix5jG4r11bj/73Ba0CidOtG9WTvEsezTgpE=
X-Received: by 2002:a17:907:75ed:: with SMTP id jz13mr17217421ejc.506.1631962917396;
 Sat, 18 Sep 2021 04:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210917034815.80264-1-songmuchun@bytedance.com>
 <20210917034815.80264-4-songmuchun@bytedance.com> <CAGsJ_4yWZTcRqnBmLrYJ3Z1Yo_7oWRgR4B3qK5m570xgpeJ-5Q@mail.gmail.com>
 <CAMZfGtW1_U2d=zQFCYBEDfKWB=EkoYTGgVcCHauX-iv4VD7U8Q@mail.gmail.com>
In-Reply-To: <CAMZfGtW1_U2d=zQFCYBEDfKWB=EkoYTGgVcCHauX-iv4VD7U8Q@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Sat, 18 Sep 2021 23:01:46 +1200
Message-ID: <CAGsJ_4wPDxq=wK8zny-G+H9wV9ebouojfdwcoYNb6-_AJHMLdw@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 3/4] mm: sparsemem: use page table lock to
 protect kernel pmd operations
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

On Sat, Sep 18, 2021 at 10:51 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Sat, Sep 18, 2021 at 1:07 PM Barry Song <21cnbao@gmail.com> wrote:
> >
> > On Sat, Sep 18, 2021 at 12:09 AM Muchun Song <songmuchun@bytedance.com> wrote:
> > >
> > > The init_mm.page_table_lock is used to protect kernel page tables, we
> > > can use it to serialize splitting vmemmap PMD mappings instead of mmap
> > > write lock, which can increase the concurrency of vmemmap_remap_free().
> > >
> >
> > Curious what is the actual benefit we get in user scenarios from this patch,
> > 1. we set bootargs to reserve hugetlb statically
> > 2. we "echo" some figures to sys or proc.
> >
> > In other words, Who is going to care about this concurrency?
>
> Actually, It increase the concurrency between allocations of
> HugeTLB pages. But it is not my first consideration. There are
> a lot of users of mmap read lock of init_mm. The mmap write
> lock is holding through vmemmap_remap_free(), I want to make
> it does not affect other users of mmap read lock.

generically makes sense. I guess it wouldn't be critical at all for hugetlb
allocation as practically we are not going to reserve and release hugtlb
often as they are not THP.

anyway, it is not making anything worse and always a win to move.

>
> I suppose a lot of developers are trying to avoid using mmap write
> lock. I am also one of them.
>
> > Can we have some details on this to put in the commit log?
>
> For sure. Those judgments above should be placed in the
> commit log.
>
> Thanks.

Thanks
barry
