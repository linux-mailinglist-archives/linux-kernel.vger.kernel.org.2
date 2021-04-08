Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1603358515
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbhDHNq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:46:28 -0400
Received: from mga12.intel.com ([192.55.52.136]:16989 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231621AbhDHNq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:46:27 -0400
IronPort-SDR: tiJHfpoaO+pQMYY2NPJu1vig1BALs31A4KS71HT4wGCqxT/I27PE2EaM5Xu8SzWpmBLLiAstWI
 Rq8ucFToCDcw==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="173019084"
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="scan'208";a="173019084"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 06:46:16 -0700
IronPort-SDR: PFuqVYXQVDMRqvIwcoIv55qr11MROY/k3kS/4SijUECqUDT5YvCwG7rd5losMtsAnji4W+GcuE
 /P1/Sjzi0x5A==
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="scan'208";a="415776505"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 06:46:13 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Peter Xu" <peterx@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Michel Lespinasse <walken@google.com>,
        Arjun Roy <arjunroy@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH -V2] NUMA balancing: reduce TLB flush via delaying
 mapping on hint page fault
References: <20210402082717.3525316-1-ying.huang@intel.com>
        <20210407082728.GA15768@suse.de>
Date:   Thu, 08 Apr 2021 21:46:11 +0800
In-Reply-To: <20210407082728.GA15768@suse.de> (Mel Gorman's message of "Wed, 7
        Apr 2021 09:27:28 +0100")
Message-ID: <87lf9syjmk.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman <mgorman@suse.de> writes:

> On Fri, Apr 02, 2021 at 04:27:17PM +0800, Huang Ying wrote:
>> With NUMA balancing, in hint page fault handler, the faulting page
>> will be migrated to the accessing node if necessary.  During the
>> migration, TLB will be shot down on all CPUs that the process has run
>> on recently.  Because in the hint page fault handler, the PTE will be
>> made accessible before the migration is tried.  The overhead of TLB
>> shooting down can be high, so it's better to be avoided if possible.
>> In fact, if we delay mapping the page until migration, that can be
>> avoided.  This is what this patch doing.
>> 
>> <SNIP>
>>
>
> Thanks, I think this is ok for Andrew to pick up to see if anything
> bisects to this commit but it's a low risk.
>
> Reviewed-by: Mel Gorman <mgorman@suse.de>
>
> More notes;
>
> This is not a universal win given that not all workloads exhibit the
> pattern where accesses occur in parallel threads between when a page
> is marked accessible and when it is migrated. The impact of the patch
> appears to be neutral for those workloads. For workloads that do exhibit
> the pattern, there is a small gain with a reduction in interrupts as
> advertised unlike v1 of the patch. Further tests are running to confirm
> the reduction is in TLB shootdown interrupts but I'm reasonably confident
> that will be the case. Gains are typically small and the load described in
> the changelog appears to be a best case scenario but a 1-5% gain in some
> other workloads is still an improvement. There is still the possibility
> that some workloads will unnecessarily stall as a result of the patch
> for slightly longer periods of time but that is a relatively low risk
> and will be difficult to detect. If I'm wrong, a bisection will find it.

Hi, Mel,

Thanks!

Hi, Andrew,

I found that V2 cannot apply on top of latest mmotm, so I send V3 as
follows.  In case you need it.

https://lore.kernel.org/lkml/20210408132236.1175607-1-ying.huang@intel.com/

Best Regards,
Huang, Ying
