Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFDDD38E334
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 11:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbhEXJX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 05:23:58 -0400
Received: from outbound-smtp46.blacknight.com ([46.22.136.58]:44845 "EHLO
        outbound-smtp46.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232455AbhEXJX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 05:23:56 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp46.blacknight.com (Postfix) with ESMTPS id D8990FA898
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 10:22:27 +0100 (IST)
Received: (qmail 22945 invoked from network); 24 May 2021 09:22:27 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 24 May 2021 09:22:27 -0000
Date:   Mon, 24 May 2021 10:22:25 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] mm/page_alloc: Limit the number of pages on PCP
 lists when reclaim is active
Message-ID: <20210524092225.GD30378@techsingularity.net>
References: <20210521102826.28552-1-mgorman@techsingularity.net>
 <20210521102826.28552-6-mgorman@techsingularity.net>
 <3f0ebd90-1aca-1dfc-3b92-bdb991d0fb29@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <3f0ebd90-1aca-1dfc-3b92-bdb991d0fb29@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 03:44:49PM -0700, Dave Hansen wrote:
> On 5/21/21 3:28 AM, Mel Gorman wrote:
> > +static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone)
> > +{
> > +	int high = READ_ONCE(pcp->high);
> > +
> > +	if (unlikely(!high))
> > +		return 0;
> > +
> > +	if (!test_bit(ZONE_RECLAIM_ACTIVE, &zone->flags))
> > +		return high;
> > +
> > +	/*
> > +	 * If reclaim is active, limit the number of pages that can be
> > +	 * stored on pcp lists
> > +	 */
> > +	return READ_ONCE(pcp->batch) << 2;
> > +}
> 
> Should there be a sanity check on this?  Let's say we had one of those
> weirdo zones with tons of CPUs and a small low_wmark_pages().  Could we
> have a case where:
> 
> 	pcp->high < pcp->batch<<2
> 
> and this effectively *raises* nr_pcp_high()?
> 
> It's not possible with the current pcp->high calculation, but does
> anything prevent it now?

I don't think it would happen as pcp->batch is reduced for small zones
but a sanity check does not hurt so I added one.

-- 
Mel Gorman
SUSE Labs
