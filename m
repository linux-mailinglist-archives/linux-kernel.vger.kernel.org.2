Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE99A39E6EC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 20:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhFGS5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 14:57:51 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49466 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhFGS5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 14:57:50 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8B6DB219A2;
        Mon,  7 Jun 2021 18:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623092158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xTTNvN2IGVmRB+Hi3pIM5/gMVmzfroo2fQlotpvh6qI=;
        b=opAvG0UKd+EYVEXI97H4xHDjF9j+W/HwIM8XO09eMwyAeacv2iTxx7PdRTqucKA+SxAH7Z
        2x59C7aIdrBZyQM96tMHZ6d9d+AFTTLF3JO1gi1ncHnwqzwdorHX3VT+2LfPjuXRa3qn6T
        eAETwTAHTR/H04Fqawnq4IAwdF3XVfU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2D988A3B8E;
        Mon,  7 Jun 2021 18:55:58 +0000 (UTC)
Date:   Mon, 7 Jun 2021 20:55:57 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Zi Yan <ziy@nvidia.com>, nao.horiguchi@gmail.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: mempolicy: don't have to split pmd for huge zero page
Message-ID: <YL5rvdzh9dou+uAz@dhcp22.suse.cz>
References: <20210604203513.240709-1-shy828301@gmail.com>
 <YL265A86DQe5Rgon@dhcp22.suse.cz>
 <CAHbLzkowcskM=p==-q48Ca12D=h9SgqUuUB4NknRNR=64TyXCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkowcskM=p==-q48Ca12D=h9SgqUuUB4NknRNR=64TyXCw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 07-06-21 10:00:01, Yang Shi wrote:
> On Sun, Jun 6, 2021 at 11:21 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Fri 04-06-21 13:35:13, Yang Shi wrote:
> > > When trying to migrate pages to obey mempolicy, the huge zero page is
> > > split then the page table walk at PTE level just skips zero page.  So it
> > > seems pointless to split huge zero page, it could be just skipped like
> > > base zero page.
> >
> > My THP knowledge is not the best but this is incorrect AIACS. Huge zero
> > page is not split. We do split the pmd which is mapping the said page. I
> > suspect you refer to vm_normal_page when talking about a zero page but
> > please be aware that huge zero page is not a normal zero page. It is
> > allocated dynamically (see get_huge_zero_page).
> 
> For a normal huge page, yes, split_huge_pmd() just splits pmd. But
> actually the base zero pfn will be inserted to PTEs when splitting
> huge zero pmd. Please check __split_huge_zero_page_pmd() out.

My bad. I didn't have a look all the way down there. The naming
suggested that this is purely page table operations and I have suspected
that ptes just point to the offset of the THP.

But I am obviously wrong here. Sorry about that.

> I should make this point clearer in the commit log. Sorry for the confusion.
> 
> >
> > So in the end you patch disables mbind of zero pages to a target node
> > and that is a regression.
> 
> Do we really migrate zero page? IIUC zero page is just skipped by
> vm_normal_page() check in queue_pages_pte_range(), isn't it?

Yeah, normal zero pages are skipped indeed. I haven't studied why this
is the case yet. It surely sounds a bit suspicious because this is an
explicit request to migrate memory and if the zero page is misplaced it
should be moved. On the hand this would increase RSS so maybe this is
the point.

> > Have you tested the patch?
> 
> No, just build test. I thought this change was straightforward.
> 
> >
> > > Set ACTION_CONTINUE to prevent the walk_page_range() split the pmd for
> > > this case.
> >
> > Btw. this changelog is missing a problem statement. I suspect there is
> > no actual problem that it should fix and it is likely driven by reading
> > the code. Right?
> 
> The actual problem is it is pointless to split a huge zero pmd. Yes,
> it is driven by visual inspection.

Is there any actual workload that cares? This is quite a subtle area so
I would be careful to do changes just because...
-- 
Michal Hocko
SUSE Labs
