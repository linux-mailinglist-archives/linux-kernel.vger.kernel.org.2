Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02B539EED5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 08:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhFHGnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 02:43:22 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50994 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhFHGnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 02:43:21 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9900B219BE;
        Tue,  8 Jun 2021 06:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623134487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LuL40cuMBibz7ZQQ1srfQNbk5qVCLt4Pr82LmYmyub4=;
        b=on9ecdXXsvc5iHQa6orqhYTFGmeRr1FT0I5DxM0ICAbccYZuglOidtfaZPa5/obGxBx4Vs
        9DEm6PWxLeLKsJEVZuWEOTLkcokOG+CwpbsKF1F0DVq+R8r12+rlchEnZirfvvGBBVfHlP
        RxV9j2P7025c1LlfYM09K5/YzhUAe5o=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 67F93A3B81;
        Tue,  8 Jun 2021 06:41:27 +0000 (UTC)
Date:   Tue, 8 Jun 2021 08:41:26 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Zi Yan <ziy@nvidia.com>, nao.horiguchi@gmail.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: mempolicy: don't have to split pmd for huge zero page
Message-ID: <YL8RFneAmSSi2Z0I@dhcp22.suse.cz>
References: <20210604203513.240709-1-shy828301@gmail.com>
 <YL265A86DQe5Rgon@dhcp22.suse.cz>
 <CAHbLzkowcskM=p==-q48Ca12D=h9SgqUuUB4NknRNR=64TyXCw@mail.gmail.com>
 <YL5rvdzh9dou+uAz@dhcp22.suse.cz>
 <CAHbLzkooYAi=Hb0=oJ+2b6G=h5Sx4jnyo5L0nPYjDcBqBHnfug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkooYAi=Hb0=oJ+2b6G=h5Sx4jnyo5L0nPYjDcBqBHnfug@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 07-06-21 15:02:39, Yang Shi wrote:
> On Mon, Jun 7, 2021 at 11:55 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 07-06-21 10:00:01, Yang Shi wrote:
> > > On Sun, Jun 6, 2021 at 11:21 PM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Fri 04-06-21 13:35:13, Yang Shi wrote:
> > > > > When trying to migrate pages to obey mempolicy, the huge zero page is
> > > > > split then the page table walk at PTE level just skips zero page.  So it
> > > > > seems pointless to split huge zero page, it could be just skipped like
> > > > > base zero page.
> > > >
> > > > My THP knowledge is not the best but this is incorrect AIACS. Huge zero
> > > > page is not split. We do split the pmd which is mapping the said page. I
> > > > suspect you refer to vm_normal_page when talking about a zero page but
> > > > please be aware that huge zero page is not a normal zero page. It is
> > > > allocated dynamically (see get_huge_zero_page).
> > >
> > > For a normal huge page, yes, split_huge_pmd() just splits pmd. But
> > > actually the base zero pfn will be inserted to PTEs when splitting
> > > huge zero pmd. Please check __split_huge_zero_page_pmd() out.
> >
> > My bad. I didn't have a look all the way down there. The naming
> > suggested that this is purely page table operations and I have suspected
> > that ptes just point to the offset of the THP.
> >
> > But I am obviously wrong here. Sorry about that.
> >
> > > I should make this point clearer in the commit log. Sorry for the confusion.
> > >
> > > >
> > > > So in the end you patch disables mbind of zero pages to a target node
> > > > and that is a regression.
> > >
> > > Do we really migrate zero page? IIUC zero page is just skipped by
> > > vm_normal_page() check in queue_pages_pte_range(), isn't it?
> >
> > Yeah, normal zero pages are skipped indeed. I haven't studied why this
> > is the case yet. It surely sounds a bit suspicious because this is an
> > explicit request to migrate memory and if the zero page is misplaced it
> > should be moved. On the hand this would increase RSS so maybe this is
> > the point.
> 
> The zero page is a global shared page, I don't think "misplace"
> applies to it. It doesn't make too much sense to migrate a shared
> page. Actually there is page mapcount check in migrate_page_add() to
> skip shared normal pages as well.

I didn't really mean to migrate zero page itself. What I meant was to
instanciate a new page when the global one is on a different NUMA node
than the bind() requests. This can be either done by having per NUMA
zero page or simply allocate a new page for the exclusive mapping.

> > > > Have you tested the patch?
> > >
> > > No, just build test. I thought this change was straightforward.
> > >
> > > >
> > > > > Set ACTION_CONTINUE to prevent the walk_page_range() split the pmd for
> > > > > this case.
> > > >
> > > > Btw. this changelog is missing a problem statement. I suspect there is
> > > > no actual problem that it should fix and it is likely driven by reading
> > > > the code. Right?
> > >
> > > The actual problem is it is pointless to split a huge zero pmd. Yes,
> > > it is driven by visual inspection.
> >
> > Is there any actual workload that cares? This is quite a subtle area so
> > I would be careful to do changes just because...
> 
> I'm not sure whether there is measurable improvement for actual
> workloads, but I believe this change does eliminate some unnecessary
> work.

I can see why being consistent here is a good argument. On the other
hand it would be imho better to look for reasons why zero pages are left
misplaced before making the code consistent. From a very quick git
archeology it seems that vm_normal_page has been used since MPOL_MF_MOVE
was introduced. At the time (dc9aa5b9d65fd) vm_normal_page hasn't
skipped through zero page AFAICS. I do not remember all the details
about zero page (wrt. pte special) handling though so it might be hidden
at some other place.

In any case the existing code doesn't really work properly. The question
is whether anybody actually cares but this is definitely something worth
looking into IMHO.
 
> I think the test shown in the previous email gives us some confidence
> that the change doesn't have regression.

Yes, this is true.
-- 
Michal Hocko
SUSE Labs
