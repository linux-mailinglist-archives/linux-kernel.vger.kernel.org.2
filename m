Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4570533464F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 19:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbhCJSKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 13:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbhCJSJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 13:09:49 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315E8C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 10:09:45 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id jt13so40617046ejb.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 10:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gJAsZyfDCDLDzspGcP+6q6V8qY1kikL05fqsU033Nz4=;
        b=SC7BwuYMthuL7KnQIhtiddqRok9XAh9gcjM97rHzKdVXjJpoh6TkW0z0O+K8Zudu8x
         JPZTUm5toVVXQGCslw/S1cHIfiE36I8q0tGDT+YUSeqev1f6ry4L/RmPVaOTBefWmXSo
         VJ6sLW9YJ11CsRbnwn8LMwY0qDXVBCq24MmN+vSBu/GArQoA0cFoaPxoGeSRIjBDDt3v
         i7ujukCxirP5KWnulJ/he7BEN4ok063e0yjjW6fabwUtF11T98Is57KmdWXULwDKO9ba
         sMPY67YmABfaj67e/ifXPkGu86Md7n+sRzOqGMvtAmbqKBJuZWIvrW0ZabkxH7Yrh0kY
         8pEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gJAsZyfDCDLDzspGcP+6q6V8qY1kikL05fqsU033Nz4=;
        b=PwpMmVRQ4KvJjDtadRjoi041b5aPqyMycEY36RcvccLVS0Jb09yOag5lfhbOCpIN+t
         ZEwMTyYADeFhzLrFUY9if4HR35RrrRQUE4xcogJo/SK4o7Vao5ZQCgeoeF+zne3J++KC
         51IwP1X5Mj+d+MX8XEBqKBEFviflTYMU5uJfi2rYjxkmmUzg26C9t3bP2AAoQkU3FLut
         M+4ZiLiegMg6JH7R7Z+VbWOqfyfQkzTlvwQkj4ngL48KglKdzvWtB0+qAO9OQDGt+xR3
         rcWsQacg9u75ufYUW6kReLc7tbOMErqBI/Y8FUeI5xwflFFwn4A9qnjkdogVyTpCllUA
         j8Rg==
X-Gm-Message-State: AOAM531AFhqKNMhyw1cZgiFDSQ1oDNU3f6jxnXJCwGQH9F/padnD1lCU
        jar265461H5FGpiiglIdu7zzx6zwFiBWNre87edoiw==
X-Google-Smtp-Source: ABdhPJz7X8EAeavYVAMuOixYYEkGqm/ao9bUZTWDvbUa0pzwfhRvQpKr+aPzlD7TsVVjXIoYOXXFZ88PdEVAqY4wc8U=
X-Received: by 2002:a17:906:a052:: with SMTP id bg18mr5034455ejb.18.1615399783815;
 Wed, 10 Mar 2021 10:09:43 -0800 (PST)
MIME-Version: 1.0
References: <20210218230633.15028-1-peterx@redhat.com> <20210218231202.15426-1-peterx@redhat.com>
 <CA+G9fYvyQ=9cZgGDNzN_PH09WRk0yu=5CDfa1mxPQ+uzfonnkg@mail.gmail.com> <20210310165713.GB6530@xz-x1>
In-Reply-To: <20210310165713.GB6530@xz-x1>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 10 Mar 2021 23:39:32 +0530
Message-ID: <CA+G9fYs7wZ7EfOs1eB=2zf94=pYEkWig=usYF=Hfs5sM6iqYKw@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] hugetlb/userfaultfd: Forbid huge pmd sharing when
 uffd enabled
To:     Peter Xu <peterx@redhat.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        lkft-triage@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2021 at 22:27, Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Mar 10, 2021 at 01:18:42PM +0530, Naresh Kamboju wrote:
> > Hi Peter,
>
> Hi, Naresh,
>
> >
> > On Fri, 19 Feb 2021 at 04:43, Peter Xu <peterx@redhat.com> wrote:
> > >
> > > Huge pmd sharing could bring problem to userfaultfd.  The thing is that
> > > userfaultfd is running its logic based on the special bits on page table
> > > entries, however the huge pmd sharing could potentially share page table
> > > entries for different address ranges.  That could cause issues on either:
> > >
> > >   - When sharing huge pmd page tables for an uffd write protected range, the
> > >     newly mapped huge pmd range will also be write protected unexpectedly, or,
> > >
> > >   - When we try to write protect a range of huge pmd shared range, we'll first
> > >     do huge_pmd_unshare() in hugetlb_change_protection(), however that also
> > >     means the UFFDIO_WRITEPROTECT could be silently skipped for the shared
> > >     region, which could lead to data loss.
> > >
> > > Since at it, a few other things are done altogether:
> > >
> > >   - Move want_pmd_share() from mm/hugetlb.c into linux/hugetlb.h, because
> > >     that's definitely something that arch code would like to use too
> > >
> > >   - ARM64 currently directly check against CONFIG_ARCH_WANT_HUGE_PMD_SHARE when
> > >     trying to share huge pmd.  Switch to the want_pmd_share() helper.
> > >
> > > Since at it, move vma_shareable() from huge_pmd_share() into want_pmd_share().
> > >
> > > Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> > > Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  arch/arm64/mm/hugetlbpage.c   |  3 +--
> > >  include/linux/hugetlb.h       |  2 ++
> > >  include/linux/userfaultfd_k.h |  9 +++++++++
> > >  mm/hugetlb.c                  | 20 ++++++++++++++------
> > >  4 files changed, 26 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> > > index 6e3bcffe2837..58987a98e179 100644
> > > --- a/arch/arm64/mm/hugetlbpage.c
> > > +++ b/arch/arm64/mm/hugetlbpage.c
> > > @@ -284,8 +284,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
> > >                  */
> > >                 ptep = pte_alloc_map(mm, pmdp, addr);
> > >         } else if (sz == PMD_SIZE) {
> > > -               if (IS_ENABLED(CONFIG_ARCH_WANT_HUGE_PMD_SHARE) &&
> > > -                   pud_none(READ_ONCE(*pudp)))
> > > +               if (want_pmd_share(vma, addr) && pud_none(READ_ONCE(*pudp)))
> >
> > While building Linux next 20210310 tag for arm64 architecture with
> >
> >   - CONFIG_ARM64_64K_PAGES=y
> >
> > enabled the build failed due to below errors / warnings
> >
> > make --silent --keep-going --jobs=8
> > O=/home/tuxbuild/.cache/tuxmake/builds/1/tmp ARCH=arm64
> > CROSS_COMPILE=aarch64-linux-gnu- 'CC=sccache aarch64-linux-gnu-gcc'
> > 'HOSTCC=sccache gcc'
> > aarch64-linux-gnu-ld: Unexpected GOT/PLT entries detected!
> > aarch64-linux-gnu-ld: Unexpected run-time procedure linkages detected!
> > aarch64-linux-gnu-ld: arch/arm64/mm/hugetlbpage.o: in function `huge_pte_alloc':
> > hugetlbpage.c:(.text+0x7d8): undefined reference to `want_pmd_share'
> >
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>
> Sorry for the issue & thanks for the report.  Would you please check whether
> the patch attached could fix the issue?

The attached patch build tested and build pass for arm64
including 64k pages config.

 CONFIG_ARM64_64K_PAGES=y

- Naresh
