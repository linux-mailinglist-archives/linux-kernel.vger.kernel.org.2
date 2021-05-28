Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317BA3940AA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 12:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236441AbhE1KK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 06:10:58 -0400
Received: from outbound-smtp02.blacknight.com ([81.17.249.8]:44747 "EHLO
        outbound-smtp02.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236396AbhE1KKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 06:10:55 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp02.blacknight.com (Postfix) with ESMTPS id D538EBAB09
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 11:09:19 +0100 (IST)
Received: (qmail 28010 invoked from network); 28 May 2021 10:09:19 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 28 May 2021 10:09:19 -0000
Date:   Fri, 28 May 2021 11:09:18 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     David Hildenbrand <david@redhat.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, "Tang, Feng" <feng.tang@intel.com>
Subject: Re: [PATCH 0/6 v2] Calculate pcp->high based on zone sizes and
 active CPUs
Message-ID: <20210528100918.GM30378@techsingularity.net>
References: <20210525080119.5455-1-mgorman@techsingularity.net>
 <7177f59b-dc05-daff-7dc6-5815b539a790@intel.com>
 <20210528085545.GJ30378@techsingularity.net>
 <54ff0363-2f39-71d1-e26c-962c3fddedae@redhat.com>
 <e73d39cc-df2f-5000-0212-6073955fb291@redhat.com>
 <20210528094949.GL30378@techsingularity.net>
 <6c189def-11cc-80db-0fde-56aa506cfdea@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <6c189def-11cc-80db-0fde-56aa506cfdea@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 11:52:53AM +0200, David Hildenbrand wrote:
> > > "Disable pcplists so that page isolation cannot race with freeing
> > >   in a way that pages from isolated pageblock are left on pcplists."
> > > 
> > > Guess we'd then want to move the draining before start_isolate_page_range()
> > > in alloc_contig_range().
> > > 
> > 
> > Or instead of draining, validate the PFN range in alloc_contig_range
> > is within the same zone and if so, call zone_pcp_disable() before
> > start_isolate_page_range and enable after __alloc_contig_migrate_range.
> > 
> 
> We require the caller to only pass a range within a single zone, so that
> should be fine.
> 
> The only ugly thing about zone_pcp_disable() is
> mutex_lock(&pcp_batch_high_lock) which would serialize all
> alloc_contig_range() and even with offline_pages().
> 

True so it would have to be accessed if that is bad or not. If racing
against offline_pages, memory is potentially being offlined in the
target zone which may cause allocation failure. If racing with other
alloc_contig_range calls, the two callers are potentially racing to
isolate and allocate the same range. The arguement could be made that
alloc_contig_ranges should be serialised within one zone to improve the
allocation success rate at the potential cost of allocation latency.

-- 
Mel Gorman
SUSE Labs
