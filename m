Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74B7394050
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbhE1Jv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:51:28 -0400
Received: from outbound-smtp02.blacknight.com ([81.17.249.8]:57690 "EHLO
        outbound-smtp02.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234926AbhE1Jv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:51:26 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp02.blacknight.com (Postfix) with ESMTPS id 8D3FBBAAEE
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 10:49:51 +0100 (IST)
Received: (qmail 24766 invoked from network); 28 May 2021 09:49:51 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 28 May 2021 09:49:51 -0000
Date:   Fri, 28 May 2021 10:49:49 +0100
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
Message-ID: <20210528094949.GL30378@techsingularity.net>
References: <20210525080119.5455-1-mgorman@techsingularity.net>
 <7177f59b-dc05-daff-7dc6-5815b539a790@intel.com>
 <20210528085545.GJ30378@techsingularity.net>
 <54ff0363-2f39-71d1-e26c-962c3fddedae@redhat.com>
 <e73d39cc-df2f-5000-0212-6073955fb291@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <e73d39cc-df2f-5000-0212-6073955fb291@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 11:08:01AM +0200, David Hildenbrand wrote:
> On 28.05.21 11:03, David Hildenbrand wrote:
> > On 28.05.21 10:55, Mel Gorman wrote:
> > > On Thu, May 27, 2021 at 12:36:21PM -0700, Dave Hansen wrote:
> > > > Hi Mel,
> > > > 
> > > > Feng Tang tossed these on a "Cascade Lake" system with 96 threads and
> > > > ~512G of persistent memory and 128G of DRAM.  The PMEM is in "volatile
> > > > use" mode and being managed via the buddy just like the normal RAM.
> > > > 
> > > > The PMEM zones are big ones:
> > > > 
> > > >           present  65011712 = 248 G
> > > >           high       134595 = 525 M
> > > > 
> > > > The PMEM nodes, of course, don't have any CPUs in them.
> > > > 
> > > > With your series, the pcp->high value per-cpu is 69584 pages or about
> > > > 270MB per CPU.  Scaled up by the 96 CPU threads, that's ~26GB of
> > > > worst-case memory in the pcps per zone, or roughly 10% of the size of
> > > > the zone.
> > 
> > When I read about having such big amounts of free memory theoretically
> > stuck in PCP lists, I guess we really want to start draining the PCP in
> > alloc_contig_range(), just as we do with memory hotunplug when offlining.
> > 
> 
> Correction: we already drain the pcp, we just don't temporarily disable it,
> so a race as described in offline_pages() could apply:
> 
> "Disable pcplists so that page isolation cannot race with freeing
>  in a way that pages from isolated pageblock are left on pcplists."
> 
> Guess we'd then want to move the draining before start_isolate_page_range()
> in alloc_contig_range().
> 

Or instead of draining, validate the PFN range in alloc_contig_range
is within the same zone and if so, call zone_pcp_disable() before
start_isolate_page_range and enable after __alloc_contig_migrate_range.

-- 
Mel Gorman
SUSE Labs
