Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C1A380FBF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 20:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbhENSc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 14:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhENSc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 14:32:27 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA006C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 11:31:15 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id p8so28856827iol.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 11:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SmJasCD4M03RbqThN96F5XZ2SVb5iXBWwVT406MBh74=;
        b=ZvB0aM1P2qW/Q5g9TY/7DfmVDDAuEW2BfIavLVuI6HskR7zYC0ne/v6eTW1r3NffDM
         aeQVjFjLo8V4xUfcbdQKydmkspw+EhjDtv5QGQV1Is5h58G8DIN+LENDsOkgNMcXxtnN
         hclhatRuD4+uUyFaaJxF+/A4NM55P2U3/Ela1LZE8FB/l6x9NWg52cuzyWj+sJE9rrK8
         WZqscbD6J4WydwVFq+sbLMfhKSOxpaTuTdi/FvEk1c4ldEbAuYPjbXRpUOwjBz8jSWLA
         jmG8zHfiNESfih4cN/1i3FyHvouOyfwls1/ucXBqHjc8sfGe66D1KEW+/PaYScJiiXMn
         lIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SmJasCD4M03RbqThN96F5XZ2SVb5iXBWwVT406MBh74=;
        b=rRHiG5eVmnMbWDukKfg0cDFENHtz9Rx+DyGflgtUnJruXZwolsc5AivN52+sLoNWM0
         aTLH5suncy8acWRpTa29YomeQeV4NY/ayBOVKGDndtqR/GtwV+vGSHpIm2tEMK1xl06g
         gtBpA4hTghRMuoYyBLwBcJ7i+DAljTQC9wENyUjDeusEp5WDSXl/Uf5drPKeRSN85jqA
         jcY9ZxS3CCgspP2ChTBgrl0eBDEIu9Kcz6V2v5ouqIAnQ8oFAx7oFH0KzYfCNxQzSjSt
         LMj0YxULira+/wiX6LVHC5NHUlV+zHGe51J0QEb3tZvCWqp+ck8FAnx1Z/Ws1s6pFMGO
         o6WA==
X-Gm-Message-State: AOAM531iR9SSxz6eRb9CG09CTSKdi1hr57tn9SfvPtvm9BDbvJRwTGKQ
        vjVU8xTEraraN0IwQ4wn1xh+1hjo7fgfNA+ARDiooA==
X-Google-Smtp-Source: ABdhPJxuDhFQjQvwXfsfZotNnPUgWP7VLDTOTARGJSAuufoA2/hB6sE6jJtTAFvssvhu4xtsZy6H4x5a8Jis0d77iaY=
X-Received: by 2002:a6b:c84f:: with SMTP id y76mr35976045iof.23.1621017075019;
 Fri, 14 May 2021 11:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210513234309.366727-1-almasrymina@google.com>
 <CAHS8izNkBvS9gkSjy8FbWBOPDynwr8PXXXbMHt_2=5sZJsa6-Q@mail.gmail.com>
 <09dc0712-48e8-8ba2-f170-4c2febcfff83@oracle.com> <CAHS8izPFc+bSrKN-6gRguGefAqrj6kXaMUvgeUL5U7QxhXfWDw@mail.gmail.com>
 <f9c85756-62e1-3d5c-9fbc-f38c6e8f07f3@oracle.com> <YJ5tjWKyVZk2mvxo@t490s> <dd83c970-797e-6b7a-194d-790df5d53867@oracle.com>
In-Reply-To: <dd83c970-797e-6b7a-194d-790df5d53867@oracle.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Fri, 14 May 2021 11:30:39 -0700
Message-ID: <CAJHvVciTfZLgDCzsSdAf5FC5R5u4Og8Y72c4t0D53ACmJSdtRg@mail.gmail.com>
Subject: Re: [PATCH] mm, hugetlb: fix resv_huge_pages underflow on UFFDIO_COPY
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's complicated and would take some more time for me to be certain,
but after looking for half an hour or so this morning, I agree with
Mike that such a race is possible.

That is, we may back out into the retry path, and drop mmap_lock, and
leave a situation where a page is in the cache, but we have
!PageUptodate(). hugetlb_mcopy_atomic_pte clearly handles the
VM_SHARED case, so I don't see a reason why there can't be another
(non-userfaultfd-registered) mapping. If it were faulted at the right
time, it seems like such a fault would indeed zero the page, and then
the UFFDIO_COPY retry (once it acquired the lock again) would try to
reuse it.

On Fri, May 14, 2021 at 10:56 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 5/14/21 5:31 AM, Peter Xu wrote:
> > Hi, Mike,
> >
> > On Thu, May 13, 2021 at 09:02:15PM -0700, Mike Kravetz wrote:
> >
> > [...]
> >
> >> I am also concerned with the semantics of this approach and what happens
> >> when a fault races with the userfaultfd copy.  Previously I asked Peter
> >> if we could/should use a page found in the cache for the copy.  His
> >> answer was as follows:
> >>
> >>  AFAICT that's the expected behavior, and it need to be like that so as to avoid
> >>  silent data corruption (if the page cache existed, it means the page is not
> >>  "missing" at all, then it does not suite for a UFFDIO_COPY as it's only used
> >>  for uffd page missing case).
> >
> > I didn't follow the rest discussion in depth yet... but just to mention that
> > the above answer was for the question whether we can "update the page in the
> > page cache", rather than "use a page found in the page cache".
> >
> > I think reuse the page should be fine, however it'll definitely break existing
> > user interface (as it'll expect -EEXIST for now - we have kselftest covers
> > that), meanwhile I don't see why the -EEXIST bothers a lot: it still tells the
> > user that this page was filled in already.  Normally it was filled in by
> > another UFFDIO_COPY (as we could have multiple uffd service threads) along with
> > a valid pte, then this userspace thread can simply skip this message as it
> > means the event has been handled by some other servicing thread.
> >
> > (This also reminded me that there won't be a chance of UFFDIO_COPY race on page
> >  no page fault at least, since no page fault will always go into the uffd
> >  missing handling rather than filling in the page cache for a VM_UFFD_MISSING
> >  vma; while mmap read lock should guarantee VM_UFFD_MISSING be persistent)
>
> Perhaps I am missing something.
>
> Since this is a shared mapping, can we not have a 'regular' mapping to
> the same range that is uffd registered?  And, that regular mappings could
> fault and race with the uffd copy code?
>
> --
> Mike Kravetz
