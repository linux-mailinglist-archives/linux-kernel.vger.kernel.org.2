Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1EDB392F09
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 15:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbhE0NGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 09:06:43 -0400
Received: from mga14.intel.com ([192.55.52.115]:3662 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236306AbhE0NGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 09:06:40 -0400
IronPort-SDR: y1gOM+kwcTfwoMxEr2oeTlVsUgvVGdw9uxvYLtm6FUT+NFgKluAbD1/mUoBkcfzP6Lx5+RLouI
 IKt0ZfpVqjTQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="202489671"
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="202489671"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 06:05:06 -0700
IronPort-SDR: oDhBTO787SEsUd0BvLCjqWH/I/4+4Pv2FXxOSirzI2Vy5xJVKQOMGWbXBrD1LyiPaqFjbOkq9v
 sS7KCVK3f/vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="477476320"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by orsmga001.jf.intel.com with ESMTP; 27 May 2021 06:05:01 -0700
Date:   Thu, 27 May 2021 21:05:01 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, ying.huang@intel.com
Subject: Re: [PATCH v1 1/4] mm/mempolicy: skip nodemask intersect check for
 'interleave' when oom
Message-ID: <20210527130501.GC7743@shbuild999.sh.intel.com>
References: <1622005302-23027-1-git-send-email-feng.tang@intel.com>
 <1622005302-23027-2-git-send-email-feng.tang@intel.com>
 <YK9KeOmXhuuZMEHy@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK9KeOmXhuuZMEHy@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 09:30:00AM +0200, Michal Hocko wrote:
> On Wed 26-05-21 13:01:39, Feng Tang wrote:
> > mempolicy_nodemask_intersects() is used in oom case to check if a
> > task may have memory allocated on some memory nodes.
> > 
> > Currently, the nodes_intersects() is run for both 'bind' and 'interleave'
> > policies. But they are different regarding memory allocation, the nodemask
> > is a forced requirement for 'bind', while just a hint for 'interleave'.
> > Like in alloc_pages_vma():
> > 
> > 	nmask = policy_nodemask(gfp, pol);
> >         preferred_nid = policy_node(gfp, pol, node);
> >         page = __alloc_pages(gfp, order, preferred_nid, nmask);
> > 
> > in plicy_nodemask(), only 'bind' policy may return its desired nodemask,
> > while others return NULL.  And this 'NULL' enables the 'interleave' policy
> > can get memory from other nodes than its nodemask.
> > 
> > So skip the nodemask intersect check for 'interleave' policy.
> 
> The changelog is not really clear on the actual effect of the
> patch and the above reference to alloc_pages_vma looks misleading to me
> because that path is never called for interleaved policy.

You are right. thanks for pointing it out.

Only the 'bind' policy calls policy_nodemask() and gets its preset
nodemask, while for 'interleave', alloc_page_interleave() calls
__alloc_pages() with NULL nodemask, so the conclusion is the same
that 'bind' policy can only get memory from its preset nodemask,
while 'interleave' can get memory from all nodes.

> This is very likely my fault because I was rather vague. The existing
> code in its current form is confusing but it _works_ properly. The
> problem is that it sounds like a general helper and in that regards
> the function is correct for the interleaved policy and your proposed
> preferred-many. But its only existing caller wants a different semantic.
> 
> Until now this was not a real problem even for OOM context because
> alloc_page_interleave is always used for the interleaving policy
> and that one doesn't use any node mask so the code is not really
> exercised. With your MPOL_PREFERRED this would no longer be the case.
 
Given the 'interleave' task may have memory allocated from all nodes,
shouldn't the mempolicy_nodemask_intersects() return true for 'interleave'?
or I'm still missing something?

> Your patch makes the code more robust for the oom context but it can
> confuse other users who really want to do an intersect logic. So I think
> it would really be best to rename the function and make it oom specific.
> E.g. mempolicy_in_oom_domain(tsk, mask) this would make it clear that
> this is not a general purpose function.

Ok, will rename like this.

Thanks,
Feng

> The changelog should be clear that this is just a code cleanup rather
> than fix.
> 
> -- 
> Michal Hocko
> SUSE Labs
