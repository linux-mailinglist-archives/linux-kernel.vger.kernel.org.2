Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C007737EEDF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 01:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443539AbhELWUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 18:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348055AbhELVz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 17:55:27 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D94C06138B
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 14:53:05 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id x188so19739803pfd.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 14:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=31Caylk6NgplyOdEHmBs90YF+DyIdObUGOQdNgbTVPU=;
        b=khNY1wUPCnx6s/b1o0E8dyvbVcj5ruewQNunqDgsQAd+jlQeIkT4piAjt5QNFwxvnp
         BbIhTImXu1OkMhFGW++qgklR8ei2F4E5faPIekzMSxQx8mU+/ky0EJAuOG1V3NuA06u8
         uuAcR5NbTxEzyOzGjgxj8jexzp0Ov6f8HrZwhdVnfu7jFF0TyjF1djzyut3U41mCC1Ny
         U/ZWYaI2SI/FnalW+MWF1sfWNH1IoJadHWQVWnbkPyDJvQM/UDFxUq74yCoceZKH+zH/
         UkomqvAv+2DvOmYSRnD+qysQI1/7KDT+ekUbgYgzyiDmBqUwc9YpbfCkv1wDufeIG19E
         07xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=31Caylk6NgplyOdEHmBs90YF+DyIdObUGOQdNgbTVPU=;
        b=NcvTJDlPa6rwby7H3Oke0mdOSx8aRp5KmVluqk9GN77X9fPGF2tE+jtmvV6NV/Qlib
         k9Ph5NGbeFN2gxq3up4WpQnmvny5o9tjMuXyKtLgHY1qV2/8oC3LzIp1wK1yml635z9q
         jBL4GH6ygIwVKQUCrbMchq/GMJBP2ZiVfvEgFSUDfJXBnEvRI8C1ihQFTsIHPxy3zxVE
         iOF9SHH+n2mN1JeaRWLq5HmMjPePve0mVfZ+ACaaKiDydfOAkROwUyzIibo43qXOsnOF
         NITWVovs9td0pqTZrOMSlXG0m+8Nae8b/ZtKOdXo6C2j1kBbKhSxX9KvF64ntpO2ieCA
         oJbA==
X-Gm-Message-State: AOAM531qlPfduYJfCw56OozRqHJn9NbiERkfpi3xEWN+/Nl2VdsbV8fk
        ce+377oo68lrQGgGrIvnLjxiS6rhGQCfitkCUgsPNg==
X-Google-Smtp-Source: ABdhPJyYMdgdxgQl4RO7FDyTSI8sljhmYktWge1iSEPO0dv6Q3L3L3hfZpTE078xVY4h180yyGL6FjvVnrXGrRocj4o=
X-Received: by 2002:a17:90b:2393:: with SMTP id mr19mr728085pjb.24.1620856385292;
 Wed, 12 May 2021 14:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <e134d74d-c218-a01d-a315-82b909c84051@oracle.com>
 <20210512065813.89270-1-almasrymina@google.com> <CAJHvVch0ZMapPVEc0Ge5V4KDgNDNhECbqwDi0y9XxsxFXQZ-gg@mail.gmail.com>
 <c455d241-11f6-95a6-eb29-0ddd94eedbd7@oracle.com> <CAHS8izM8G948ziJToaNKgqaMQ9_CB+anksGQQHSbTY1a+yGSjg@mail.gmail.com>
 <YJw3MH2kTftwvlGa@t490s> <6a4678a2-c6d1-cf27-cd69-1b49349a3271@oracle.com>
In-Reply-To: <6a4678a2-c6d1-cf27-cd69-1b49349a3271@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 12 May 2021 14:52:54 -0700
Message-ID: <CAHS8izO_YAsYxxrCpSMNe2V5cV-zfsW=Xu4-suEHVPetkGSuBA@mail.gmail.com>
Subject: Re: [PATCH] mm, hugetlb: fix resv_huge_pages underflow on UFFDIO_COPY
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 2:31 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 5/12/21 1:14 PM, Peter Xu wrote:
> > On Wed, May 12, 2021 at 12:42:32PM -0700, Mina Almasry wrote:
> >>>>> @@ -4868,30 +4869,39 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
> >>>>> +       WARN_ON(*pagep);
> >>>>
> >>>> I don't think this warning works, because we do set *pagep, in the
> >>>> copy_huge_page_from_user failure case. In that case, the following
> >>>> happens:
> >>>>
> >>>> 1. We set *pagep, and return immediately.
> >>>> 2. Our caller notices this particular error, drops mmap_lock, and then
> >>>> calls us again with *pagep set.
> >>>>
> >>>> In this path, we're supposed to just re-use this existing *pagep
> >>>> instead of allocating a second new page.
> >>>>
> >>>> I think this also means we need to keep the "else" case where *pagep
> >>>> is set below.
> >>>>
> >>>
> >>> +1 to Peter's comment.
> >>>
>
> Apologies to Axel (and Peter) as that comment was from Axel.
>
> >>
> >> Gah, sorry about that. I'll fix in v2.
> >
> > I have a question regarding v1: how do you guarantee huge_add_to_page_cache()
> > won't fail again even if checked before page alloc?  Say, what if the page
> > cache got inserted after hugetlbfs_pagecache_present() (which is newly added in
> > your v1) but before huge_add_to_page_cache()?
>
> In the caller (__mcopy_atomic_hugetlb) we obtain the hugetlb fault mutex
> before calling this routine.  This should prevent changes to the cache
> while in the routine.
>
> However, things get complicated in the case where copy_huge_page_from_user
> fails.  In this case, we will return to the caller which will drop mmap_lock
> and the hugetlb fault mutex before doing the copy.  After dropping the
> mutex, someone could populate the cache.  This would result in the same
> situation where two reserves are 'temporarily' consumed for the same
> mapping offset.  By the time we get to the second call to
> hugetlb_mcopy_atomic_pte where the previously allocated page is passed
> in, it is too late.
>

Thanks. I tried locally to allocate a page, then add it into the
cache, *then* copy its contents (dropping that lock if that fails).
That also has the test passing, but I'm not sure if I'm causing a fire
somewhere else by having a page in the cache that has uninitialized
contents. The only other code that checks the cache seems to be the
hugetlb_fault/hugetlb_cow code. I'm reading that code to try to
understand if I'm breaking that code doing this.

> --
> Mike Kravetz
