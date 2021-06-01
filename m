Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56101396B9A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 04:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbhFACuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 22:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbhFACuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 22:50:15 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E49C061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 19:48:34 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso779913pjx.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 19:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WT/3Z5F3+KrogdCPcDO5jmg/aiO0PKvvWArp+0Dl7N4=;
        b=SFhgKy5W5TkuYv2+si6888+ZtbwNwbmPPZ8paqH7ycTbB7RxZ/rRNutGRLUw7fc9r5
         4sT8144fcmFlWPSV64oboX9A70pSf069BMyEUiu7BgOJFKLjdfdCx3ttIiyNDlr+F1ME
         7PU5k+0VRWhYEZvA7PBkUp5zS6eAip44AkS4oREo5notp2AUQYN5A3ODt0e4aSbKSQax
         nw2b1NKAkVGsLfdinWCmAYnMM9hD16XL2J7lV+lIJH9ezf6sH/DysrEzLe41VdCfGfdg
         aHd+tGWaxt+qzv89rGGnv7sg4yBvxUwfoRNJqOeaxr/z+tNtUBbpiNKgL/0S6tsnd/Jx
         21Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WT/3Z5F3+KrogdCPcDO5jmg/aiO0PKvvWArp+0Dl7N4=;
        b=NHusaq8w8CfOLa24EDzQ6xp19OIjSvLKfrbV4jUfzN3m2we3syjnhuGSrw8fgJQ6Uo
         3bFdcfLrW8FnwJwsnFrL28KUOYBctjDRtm6KuCoSuZqFiT94Dpc6NBVPLSa0Bfms2LX5
         DCmNmTDnVHTpIiL9R46n00CTWJ7sVZ2Wc0CeLfQ214ucPjZDVYxMaq23HL6bujYKaZdS
         xrhUnAtG+bGHot+7Hel8dC1iXEoOXKNRd1/pnAs9mq8HUuw26wXPu+JFedkMDp3+RA00
         LB5LWNGFSOlZKVk73OePLLuU/jwg+aCUkg4jD30JKCYGhsDVTsGvAmUBxt7Tnxmctqsw
         9vXQ==
X-Gm-Message-State: AOAM532hyfKj/315wG3Q/FHFHfCxwQ+siCoYwgxAAvcazhpgEHsSDuho
        M3LhfvgOP+qGdPd4NgsXT0x2gzOiAHX9RImRzcqxKA==
X-Google-Smtp-Source: ABdhPJxEndm4+xqEXGKQHxATyTSaARptJBXAqNT1OqBoTnag1T1pYksdYDrweSEVFbdMxuEDBo7KpnUghUoHOcUfQ84=
X-Received: by 2002:a17:90b:4b0f:: with SMTP id lx15mr21579613pjb.184.1622515714118;
 Mon, 31 May 2021 19:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210528005029.88088-1-almasrymina@google.com>
 <20210531162527.caeae9545ea2843c5f62bc9c@linux-foundation.org>
 <CAHS8izMCb4Ws46X3xXGcmrvV6J36qsAPTVCA_gdcH65FU0OeUg@mail.gmail.com> <20210531173652.c21404a16a8f8542ce40afa8@linux-foundation.org>
In-Reply-To: <20210531173652.c21404a16a8f8542ce40afa8@linux-foundation.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 31 May 2021 19:48:23 -0700
Message-ID: <CAHS8izO_3QivHuGdmY79Jb_-LqOGc5j-_-1C-tf84hXoKdBDTQ@mail.gmail.com>
Subject: Re: [PATCH v4] mm, hugetlb: fix racy resv_huge_pages underflow on UFFDIO_COPY
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 5:36 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon, 31 May 2021 17:11:52 -0700 Mina Almasry <almasrymina@google.com> wrote:
>
> > On Mon, May 31, 2021 at 4:25 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Thu, 27 May 2021 17:50:29 -0700 Mina Almasry <almasrymina@google.com> wrote:
> > >
> > > > On UFFDIO_COPY, if we fail to copy the page contents while holding the
> > > > hugetlb_fault_mutex, we will drop the mutex and return to the caller
> > > > after allocating a page that consumed a reservation. In this case there
> > > > may be a fault that double consumes the reservation. To handle this, we
> > > > free the allocated page, fix the reservations, and allocate a temporary
> > > > hugetlb page and return that to the caller. When the caller does the
> > > > copy outside of the lock, we again check the cache, and allocate a page
> > > > consuming the reservation, and copy over the contents.
> > > >
> > > > Test:
> > > > Hacked the code locally such that resv_huge_pages underflows produce
> > > > a warning and the copy_huge_page_from_user() always fails, then:
> > > >
> > > > ./tools/testing/selftests/vm/userfaultfd hugetlb_shared 10
> > > >         2 /tmp/kokonut_test/huge/userfaultfd_test && echo test success
> > > > ./tools/testing/selftests/vm/userfaultfd hugetlb 10
> > > >       2 /tmp/kokonut_test/huge/userfaultfd_test && echo test success
> > > >
> > > > Both tests succeed and produce no warnings. After the
> > > > test runs number of free/resv hugepages is correct.
> > >
> > > Many conflicts here with material that is queued for 5.14-rc1.
> > >
> > > How serious is this problem?  Is a -stable backport warranted?
> > >
> >
> > I've sent 2 similar patches to the list:
> >
> > 1. "[PATCH v4] mm, hugetlb: Fix simple resv_huge_pages underflow on UFFDIO_COPY"
> >
> > This one is sent to -stable and linux-mm and is a fairly simple fix.
> >
> > 2. "[PATCH v4] mm, hugetlb: fix racy resv_huge_pages underflow on UFFDIO_COPY"
>
> Ah, OK, the title of the first patch was changed, which threw me off.
>
> I'd skipped "[PATCH v4] mm, hugetlb: Fix simple resv_huge_pages
> underflow on UFFDIO_COPY" because Mike's comments appeared to require a
> v5.  I applied it and made Mike's changelog suggestions.  Queued for
> 5.13 and -stable.
>
> And I queued "[PATCH v4] mm, hugetlb: fix racy resv_huge_pages
> underflow on UFFDIO_COPY" for 5.14.
>
>

Awesome, thanks! And sorry for the confusion!
