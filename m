Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961063942B3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 14:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbhE1Mjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 08:39:37 -0400
Received: from outbound-smtp63.blacknight.com ([46.22.136.252]:33843 "EHLO
        outbound-smtp63.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235513AbhE1Mi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 08:38:59 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp63.blacknight.com (Postfix) with ESMTPS id A7934FA8D1
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 13:37:23 +0100 (IST)
Received: (qmail 8040 invoked from network); 28 May 2021 12:37:23 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 28 May 2021 12:37:23 -0000
Date:   Fri, 28 May 2021 13:37:22 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, "Tang, Feng" <feng.tang@intel.com>
Subject: Re: [PATCH 0/6 v2] Calculate pcp->high based on zone sizes and
 active CPUs
Message-ID: <20210528123721.GO30378@techsingularity.net>
References: <20210525080119.5455-1-mgorman@techsingularity.net>
 <7177f59b-dc05-daff-7dc6-5815b539a790@intel.com>
 <20210528085545.GJ30378@techsingularity.net>
 <416f39e7-704a-86d0-8261-dc27366336ab@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <416f39e7-704a-86d0-8261-dc27366336ab@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 02:12:09PM +0200, Vlastimil Babka wrote:
> > mm/page_alloc: Split pcp->high across all online CPUs for cpuless nodes
> > 
> > Dave Hansen reported the following about Feng Tang's tests on a machine
> > with persistent memory onlined as a DRAM-like device.
> > 
> >   Feng Tang tossed these on a "Cascade Lake" system with 96 threads and
> >   ~512G of persistent memory and 128G of DRAM.  The PMEM is in "volatile
> >   use" mode and being managed via the buddy just like the normal RAM.
> > 
> >   The PMEM zones are big ones:
> > 
> >         present  65011712 = 248 G
> >         high       134595 = 525 M
> > 
> >   The PMEM nodes, of course, don't have any CPUs in them.
> > 
> >   With your series, the pcp->high value per-cpu is 69584 pages or about
> >   270MB per CPU.  Scaled up by the 96 CPU threads, that's ~26GB of
> >   worst-case memory in the pcps per zone, or roughly 10% of the size of
> >   the zone.
> > 
> > This should not cause a problem as such although it could trigger reclaim
> > due to pages being stored on per-cpu lists for CPUs remote to a node. It
> > is not possible to treat cpuless nodes exactly the same as normal nodes
> > but the worst-case scenario can be mitigated by splitting pcp->high across
> > all online CPUs for cpuless memory nodes.
> > 
> > Suggested-by: Dave Hansen <dave.hansen@intel.com>
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 

Thanks.

> Maybe we should even consider distinguishing high limits for local-to-cpu zones
> vs remote, for example for the local-to-cpu zones we would divide by the number
> of local cpus, for remote-to-cpu zones we would divide by all cpus.
> 
> Because we can expect cpus to allocate mostly from local zones, so leaving more
> pages on percpu for those zones can be beneficial.
> 

I did think about whether the ratios should be different but failed to
conclude that it was necessary or useful so I kept it simple.

> But as the motivation here was to reduce lock contention on freeing, that's less
> clear. We probably can't expect the cpu to be freeing mostly local pages (in
> case of e.g. a large process exiting), because no mechanism works towards that,
> or does it? In case of cpu freeing to remote zone, the lower high limit could hurt.
> 

This is the major issue. Even if an application was NUMA aware and heavily
threaded, the process exiting is potentially freeing remote memory and
there is nothing wrong about that. The remote memory will be partially
drained by pcp->high being reached and the remaining memory will be
cleaned up by vmstat. It's a similar problem if a process is truncating
a large file with page cache allocated on a remote node.

Hence I decided to do nothing fancy with the ratios until a practical
problem was identified that could be alleviated by adjusting pcp->high
based on whether the CPU is remote or local to memory.

-- 
Mel Gorman
SUSE Labs
