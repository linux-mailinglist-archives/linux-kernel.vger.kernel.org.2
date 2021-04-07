Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1D03566C6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 10:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237145AbhDGI1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 04:27:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:48544 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234075AbhDGI1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 04:27:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DFD5DB040;
        Wed,  7 Apr 2021 08:27:30 +0000 (UTC)
Date:   Wed, 7 Apr 2021 09:27:28 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Michel Lespinasse <walken@google.com>,
        Arjun Roy <arjunroy@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH -V2] NUMA balancing: reduce TLB flush via delaying
 mapping on hint page fault
Message-ID: <20210407082728.GA15768@suse.de>
References: <20210402082717.3525316-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210402082717.3525316-1-ying.huang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2021 at 04:27:17PM +0800, Huang Ying wrote:
> With NUMA balancing, in hint page fault handler, the faulting page
> will be migrated to the accessing node if necessary.  During the
> migration, TLB will be shot down on all CPUs that the process has run
> on recently.  Because in the hint page fault handler, the PTE will be
> made accessible before the migration is tried.  The overhead of TLB
> shooting down can be high, so it's better to be avoided if possible.
> In fact, if we delay mapping the page until migration, that can be
> avoided.  This is what this patch doing.
> 
> <SNIP>
>

Thanks, I think this is ok for Andrew to pick up to see if anything
bisects to this commit but it's a low risk.

Reviewed-by: Mel Gorman <mgorman@suse.de>

More notes;

This is not a universal win given that not all workloads exhibit the
pattern where accesses occur in parallel threads between when a page
is marked accessible and when it is migrated. The impact of the patch
appears to be neutral for those workloads. For workloads that do exhibit
the pattern, there is a small gain with a reduction in interrupts as
advertised unlike v1 of the patch. Further tests are running to confirm
the reduction is in TLB shootdown interrupts but I'm reasonably confident
that will be the case. Gains are typically small and the load described in
the changelog appears to be a best case scenario but a 1-5% gain in some
other workloads is still an improvement. There is still the possibility
that some workloads will unnecessarily stall as a result of the patch
for slightly longer periods of time but that is a relatively low risk
and will be difficult to detect. If I'm wrong, a bisection will find it.

Andrew?

-- 
Mel Gorman
SUSE Labs
