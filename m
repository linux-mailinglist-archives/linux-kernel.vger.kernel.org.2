Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0AE8394300
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 14:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbhE1MzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 08:55:13 -0400
Received: from outbound-smtp29.blacknight.com ([81.17.249.32]:38706 "EHLO
        outbound-smtp29.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229552AbhE1MzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 08:55:12 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp29.blacknight.com (Postfix) with ESMTPS id 8FF7ABEBBC
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 13:53:36 +0100 (IST)
Received: (qmail 15377 invoked from network); 28 May 2021 12:53:36 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 28 May 2021 12:53:36 -0000
Date:   Fri, 28 May 2021 13:53:35 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 6/6] mm/page_alloc: Introduce
 vm.percpu_pagelist_high_fraction
Message-ID: <20210528125334.GP30378@techsingularity.net>
References: <20210525080119.5455-1-mgorman@techsingularity.net>
 <20210525080119.5455-7-mgorman@techsingularity.net>
 <018c4b99-81a5-bc12-03cd-662a938ef05a@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <018c4b99-81a5-bc12-03cd-662a938ef05a@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 01:59:37PM +0200, Vlastimil Babka wrote:
> On 5/25/21 10:01 AM, Mel Gorman wrote:
> > This introduces a new sysctl vm.percpu_pagelist_high_fraction. It is
> > similar to the old vm.percpu_pagelist_fraction. The old sysctl increased
> > both pcp->batch and pcp->high with the higher pcp->high potentially
> > reducing zone->lock contention. However, the higher pcp->batch value also
> > potentially increased allocation latency while the PCP was refilled.
> > This sysctl only adjusts pcp->high so that zone->lock contention is
> > potentially reduced but allocation latency during a PCP refill remains
> > the same.
> > 
> >   # grep -E "high:|batch" /proc/zoneinfo | tail -2
> >               high:  649
> >               batch: 63
> > 
> >   # sysctl vm.percpu_pagelist_high_fraction=8
> >   # grep -E "high:|batch" /proc/zoneinfo | tail -2
> >               high:  35071
> >               batch: 63
> > 
> >   # sysctl vm.percpu_pagelist_high_fraction=64
> >               high:  4383
> >               batch: 63
> > 
> >   # sysctl vm.percpu_pagelist_high_fraction=0
> >               high:  649
> >               batch: 63
> > 
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 

Thanks.

> Documentation nit below:
> 
> > @@ -789,6 +790,25 @@ panic_on_oom=2+kdump gives you very strong tool to investigate
> >  why oom happens. You can get snapshot.
> >  
> >  
> > +percpu_pagelist_high_fraction
> > +=============================
> > +
> > +This is the fraction of pages in each zone that are allocated for each
> > +per cpu page list.  The min value for this is 8.  It means that we do
> > +not allow more than 1/8th of pages in each zone to be allocated in any
> > +single per_cpu_pagelist.
> 
> This, while technically correct (as an upper limit) is somewhat misleading as
> the limit for a single per_cpu_pagelist also considers the number of local cpus.
> 
> >  This entry only changes the value of hot per
> > +cpu pagelists. User can specify a number like 100 to allocate 1/100th
> > +of each zone to each per cpu page list.
> 
> This is worse. Anyone trying to reproduce this example on a system with multiple
> cpus per node and checking the result will be puzzled.
> So I think the part about number of local cpus should be mentioned to avoid
> confusion.
> 

Is this any better?

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index e85c2f21d209..2da25735a629 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -793,15 +793,16 @@ why oom happens. You can get snapshot.
 percpu_pagelist_high_fraction
 =============================
 
-This is the fraction of pages in each zone that are allocated for each
-per cpu page list.  The min value for this is 8.  It means that we do
-not allow more than 1/8th of pages in each zone to be allocated in any
-single per_cpu_pagelist.  This entry only changes the value of hot per
-cpu pagelists. User can specify a number like 100 to allocate 1/100th
-of each zone to each per cpu page list.
-
-The batch value of each per cpu pagelist remains the same regardless of the
-value of the high fraction so allocation latencies are unaffected.
+This is the fraction of pages in each zone that are can be stored to
+per-cpu page lists. It is an upper boundary that is divided depending
+on the number of online CPUs. The min value for this is 8 which means
+that we do not allow more than 1/8th of pages in each zone to be stored
+on per-cpu page lists. This entry only changes the value of hot per-cpu
+page lists. A user can specify a number like 100 to allocate 1/100th of
+each zone between per-cpu lists.
+
+The batch value of each per-cpu page list remains the same regardless of
+the value of the high fraction so allocation latencies are unaffected.
 
 The initial value is zero. Kernel uses this value to set the high pcp->high
 mark based on the low watermark for the zone and the number of local
-- 
Mel Gorman
SUSE Labs
