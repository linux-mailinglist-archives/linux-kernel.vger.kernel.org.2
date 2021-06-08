Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5569B39FD62
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbhFHRSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 13:18:55 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:45033 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbhFHRSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 13:18:53 -0400
Received: by mail-ed1-f50.google.com with SMTP id u24so25392043edy.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 10:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B1dIfqDkgXsBdhz55HRrwDQBZt7DEJ/0yXgbUMEbr3c=;
        b=IyKMuYkUmSEEbCU4v7dQ30FlJGdDQHu06C9EcvufUGCqKUEKMeMv3k9cSd57vWyxR8
         lXLv4oWWLXTiNHYbHPjcA5m5BSc1rMVx1p23bcxHlA095Buw5tSpGupoqmUjUQX+D9uf
         DokQJQ8oGqlTeJ902yGKgOFOtv3FmdA5ugZR9imb6VeSJxI1KPqfKPUwq82amAzUDWuQ
         UcMHf2aoP8ijeTYe8HX7xnjZdUSt89f5Jy4kAB/KbZszuR+Rk7MU5iFl9NdFwkKMO7fQ
         vjg/gv62eF/sByMGze8QsGz1vskoebEmpLpM36kEOK1wsYErsDIIv373rOIaaYRvqdNm
         bZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B1dIfqDkgXsBdhz55HRrwDQBZt7DEJ/0yXgbUMEbr3c=;
        b=eB3WOGAdIkOOdcxyoCh2aGbHnzShuEY3A9T7nkSbWc9lyIcuUoFkRwD74Ab8xoOkr2
         3YK6ZrDQgEp+n26dqdHLkhRbbt5Ka8SNqPeN26YZS8QLVpHJcqrjrnmRmjkTaXhD4+Jp
         TNx3a6MjyjAoVTPE1SoDM+ulwKT3BbuDY60lrEzppBy5Qop4yfP25sWFUTm8LncaS1nR
         YdLow2uEoRJZLlGKU9Mq4/8SLXvsJAqnXOjtCRpAR5I0FIdP3oy+IryZOMamqWOgZEMp
         cchMon6jMP/ZUh2l3xNipD/MFK0+CTsh7+zugNDIgTXi7nM7kTfFzrEWtvRuz6minL5F
         prqw==
X-Gm-Message-State: AOAM532bmv0ALkdle7oSi/KUWeHyjDFEJFgnYGJ+C1JFXgIrSLFpuOdo
        5J5hwPKszvdim8Wm/WBI1TEP6IBXM8pbq11bpNU=
X-Google-Smtp-Source: ABdhPJyMr7TGYgZLcM9tZSTWAxlKRXN6jNTnhneXZx3ar3/lGebuCGADZsgO+2o7NGoucUfZ2TnahmLXxn+xoSfeFi4=
X-Received: by 2002:aa7:d5c6:: with SMTP id d6mr26185276eds.290.1623172548935;
 Tue, 08 Jun 2021 10:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210604203513.240709-1-shy828301@gmail.com> <YL265A86DQe5Rgon@dhcp22.suse.cz>
 <CAHbLzkowcskM=p==-q48Ca12D=h9SgqUuUB4NknRNR=64TyXCw@mail.gmail.com>
 <YL5rvdzh9dou+uAz@dhcp22.suse.cz> <CAHbLzkooYAi=Hb0=oJ+2b6G=h5Sx4jnyo5L0nPYjDcBqBHnfug@mail.gmail.com>
 <YL8RFneAmSSi2Z0I@dhcp22.suse.cz>
In-Reply-To: <YL8RFneAmSSi2Z0I@dhcp22.suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 8 Jun 2021 10:15:36 -0700
Message-ID: <CAHbLzkquqKOL7pH8yBdfpafeHJCUZvccNKjQBucsP7C4k83f7g@mail.gmail.com>
Subject: Re: [PATCH] mm: mempolicy: don't have to split pmd for huge zero page
To:     Michal Hocko <mhocko@suse.com>
Cc:     Zi Yan <ziy@nvidia.com>, nao.horiguchi@gmail.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 7, 2021 at 11:41 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 07-06-21 15:02:39, Yang Shi wrote:
> > On Mon, Jun 7, 2021 at 11:55 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Mon 07-06-21 10:00:01, Yang Shi wrote:
> > > > On Sun, Jun 6, 2021 at 11:21 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Fri 04-06-21 13:35:13, Yang Shi wrote:
> > > > > > When trying to migrate pages to obey mempolicy, the huge zero page is
> > > > > > split then the page table walk at PTE level just skips zero page.  So it
> > > > > > seems pointless to split huge zero page, it could be just skipped like
> > > > > > base zero page.
> > > > >
> > > > > My THP knowledge is not the best but this is incorrect AIACS. Huge zero
> > > > > page is not split. We do split the pmd which is mapping the said page. I
> > > > > suspect you refer to vm_normal_page when talking about a zero page but
> > > > > please be aware that huge zero page is not a normal zero page. It is
> > > > > allocated dynamically (see get_huge_zero_page).
> > > >
> > > > For a normal huge page, yes, split_huge_pmd() just splits pmd. But
> > > > actually the base zero pfn will be inserted to PTEs when splitting
> > > > huge zero pmd. Please check __split_huge_zero_page_pmd() out.
> > >
> > > My bad. I didn't have a look all the way down there. The naming
> > > suggested that this is purely page table operations and I have suspected
> > > that ptes just point to the offset of the THP.
> > >
> > > But I am obviously wrong here. Sorry about that.
> > >
> > > > I should make this point clearer in the commit log. Sorry for the confusion.
> > > >
> > > > >
> > > > > So in the end you patch disables mbind of zero pages to a target node
> > > > > and that is a regression.
> > > >
> > > > Do we really migrate zero page? IIUC zero page is just skipped by
> > > > vm_normal_page() check in queue_pages_pte_range(), isn't it?
> > >
> > > Yeah, normal zero pages are skipped indeed. I haven't studied why this
> > > is the case yet. It surely sounds a bit suspicious because this is an
> > > explicit request to migrate memory and if the zero page is misplaced it
> > > should be moved. On the hand this would increase RSS so maybe this is
> > > the point.
> >
> > The zero page is a global shared page, I don't think "misplace"
> > applies to it. It doesn't make too much sense to migrate a shared
> > page. Actually there is page mapcount check in migrate_page_add() to
> > skip shared normal pages as well.
>
> I didn't really mean to migrate zero page itself. What I meant was to
> instanciate a new page when the global one is on a different NUMA node
> than the bind() requests. This can be either done by having per NUMA
> zero page or simply allocate a new page for the exclusive mapping.

IMHO, isn't it too overkilling?

>
> > > > > Have you tested the patch?
> > > >
> > > > No, just build test. I thought this change was straightforward.
> > > >
> > > > >
> > > > > > Set ACTION_CONTINUE to prevent the walk_page_range() split the pmd for
> > > > > > this case.
> > > > >
> > > > > Btw. this changelog is missing a problem statement. I suspect there is
> > > > > no actual problem that it should fix and it is likely driven by reading
> > > > > the code. Right?
> > > >
> > > > The actual problem is it is pointless to split a huge zero pmd. Yes,
> > > > it is driven by visual inspection.
> > >
> > > Is there any actual workload that cares? This is quite a subtle area so
> > > I would be careful to do changes just because...
> >
> > I'm not sure whether there is measurable improvement for actual
> > workloads, but I believe this change does eliminate some unnecessary
> > work.
>
> I can see why being consistent here is a good argument. On the other
> hand it would be imho better to look for reasons why zero pages are left
> misplaced before making the code consistent. From a very quick git

Typically the zero page is created from kernel's bss section, for
example, x86. I'm supposed kernel image itself is loaded on node #0
always.

> archeology it seems that vm_normal_page has been used since MPOL_MF_MOVE
> was introduced. At the time (dc9aa5b9d65fd) vm_normal_page hasn't
> skipped through zero page AFAICS. I do not remember all the details
> about zero page (wrt. pte special) handling though so it might be hidden
> at some other place.

I did some archeology, the findings are:

The zero page has PageReserved flag set, it was skipped by the
explicit PageReserved check in mempolicy.c since commit f4598c8b3678
("[PATCH] migration: make sure there is no attempt to migrate reserved
pages."). The zero page was not used anymore by do_anonymous_page()
since 2.6.24 by commit 557ed1fa2620 ("remove ZERO_PAGE"), then
reinstated by commit a13ea5b759645 ("mm: reinstate ZERO_PAGE") and
this commit added zero page check in vm_normal_page(), so mempolicy
doesn't depend on PageReserved check to skip zero page anymore since
then.

So the zero page is skipped by mempolicy.c since 2.6.16.

>
> In any case the existing code doesn't really work properly. The question
> is whether anybody actually cares but this is definitely something worth
> looking into IMHO.
>
> > I think the test shown in the previous email gives us some confidence
> > that the change doesn't have regression.
>
> Yes, this is true.
> --
> Michal Hocko
> SUSE Labs
