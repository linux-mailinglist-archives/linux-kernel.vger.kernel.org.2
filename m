Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A435C365309
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 09:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbhDTHRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 03:17:02 -0400
Received: from mga14.intel.com ([192.55.52.115]:19038 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230172AbhDTHRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 03:17:01 -0400
IronPort-SDR: EbWkSYwj7Hl00wX+gSw7vRof7/gwVzF6PcjDM2JENEl15Vk8iPaarxCNmquZlOQDtKS+dZq0C9
 XrvEBfkbaEeg==
X-IronPort-AV: E=McAfee;i="6200,9189,9959"; a="195014614"
X-IronPort-AV: E=Sophos;i="5.82,236,1613462400"; 
   d="scan'208";a="195014614"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 00:16:30 -0700
IronPort-SDR: jnyeXfQYB5btCoAnbM6CI19DdZC2uYOLHK9R9+F3XDbp0EzOlso/Ob09L42UKvk/c0wPike/1I
 Q4R1njQE8kdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,236,1613462400"; 
   d="scan'208";a="420298347"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by fmsmga008.fm.intel.com with ESMTP; 20 Apr 2021 00:16:26 -0700
Date:   Tue, 20 Apr 2021 15:16:25 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 03/13] mm/mempolicy: Add MPOL_PREFERRED_MANY for
 multiple preferred nodes
Message-ID: <20210420071625.GB48282@shbuild999.sh.intel.com>
References: <1615952410-36895-1-git-send-email-feng.tang@intel.com>
 <1615952410-36895-4-git-send-email-feng.tang@intel.com>
 <YHblLevoUZ6+AvVZ@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHblLevoUZ6+AvVZ@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 02:50:53PM +0200, Michal Hocko wrote:
> On Wed 17-03-21 11:40:00, Feng Tang wrote:
> > From: Dave Hansen <dave.hansen@linux.intel.com>
> > 
> > MPOL_PREFERRED honors only a single node set in the nodemask.  Add the
> > bare define for a new mode which will allow more than one.
> > 
> > The patch does all the plumbing without actually adding the new policy
> > type.
> > 
> > v2:
> > Plumb most MPOL_PREFERRED_MANY without exposing UAPI (Ben)
> > Fixes for checkpatch (Ben)
> > 
> > Link: https://lore.kernel.org/r/20200630212517.308045-4-ben.widawsky@intel.com
> > Co-developed-by: Ben Widawsky <ben.widawsky@intel.com>
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > ---
> >  mm/mempolicy.c | 46 ++++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 40 insertions(+), 6 deletions(-)
> > 
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 2b1e0e4..1228d8e 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -31,6 +31,9 @@
> >   *                but useful to set in a VMA when you have a non default
> >   *                process policy.
> >   *
> > + * preferred many Try a set of nodes first before normal fallback. This is
> > + *                similar to preferred without the special case.
> > + *
> >   * default        Allocate on the local node first, or when on a VMA
> >   *                use the process policy. This is what Linux always did
> >   *		  in a NUMA aware kernel and still does by, ahem, default.
> > @@ -105,6 +108,8 @@
> >  
> >  #include "internal.h"
> >  
> > +#define MPOL_PREFERRED_MANY MPOL_MAX
> > +
> >  /* Internal flags */
> >  #define MPOL_MF_DISCONTIG_OK (MPOL_MF_INTERNAL << 0)	/* Skip checks for continuous vmas */
> >  #define MPOL_MF_INVERT (MPOL_MF_INTERNAL << 1)		/* Invert check for nodemask */
> > @@ -175,7 +180,7 @@ struct mempolicy *get_task_policy(struct task_struct *p)
> >  static const struct mempolicy_operations {
> >  	int (*create)(struct mempolicy *pol, const nodemask_t *nodes);
> >  	void (*rebind)(struct mempolicy *pol, const nodemask_t *nodes);
> > -} mpol_ops[MPOL_MAX];
> > +} mpol_ops[MPOL_MAX + 1];
> >  
> >  static inline int mpol_store_user_nodemask(const struct mempolicy *pol)
> >  {
> > @@ -415,7 +420,7 @@ void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new)
> >  	mmap_write_unlock(mm);
> >  }
> >  
> > -static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
> > +static const struct mempolicy_operations mpol_ops[MPOL_MAX + 1] = {
> >  	[MPOL_DEFAULT] = {
> >  		.rebind = mpol_rebind_default,
> >  	},
> > @@ -432,6 +437,10 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
> >  		.rebind = mpol_rebind_nodemask,
> >  	},
> >  	/* [MPOL_LOCAL] - see mpol_new() */
> > +	[MPOL_PREFERRED_MANY] = {
> > +		.create = NULL,
> > +		.rebind = NULL,
> > +	},
> >  };
> 
> I do get that you wanted to keep MPOL_PREFERRED_MANY unaccessible for
> the userspace but wouldn't it be much easier to simply check in two
> syscall entries rather than playing thise MAX+1 games which make the
> review more complicated than necessary?

I will check this way, and currently the user input paramter
handling are quite complex.

Also the sanity check in kernel_mbind() and kernel_set_mempolicy()
are almost identical, which can be unified.

> >  
> >  static int migrate_page_add(struct page *page, struct list_head *pagelist,
> > @@ -924,6 +933,9 @@ static void get_policy_nodemask(struct mempolicy *p, nodemask_t *nodes)
> >  	case MPOL_INTERLEAVE:
> >  		*nodes = p->v.nodes;
> >  		break;
> > +	case MPOL_PREFERRED_MANY:
> > +		*nodes = p->v.preferred_nodes;
> > +		break;
> >  	case MPOL_PREFERRED:
> >  		if (!(p->flags & MPOL_F_LOCAL))
> >  			*nodes = p->v.preferred_nodes;
> 
> Why those two do a slightly different thing? Is this because unlike
> MPOL_PREFERRED it can never have MPOL_F_LOCAL cleared? If that is the
> case I would still stick the two together and use the same code for
> both to make the code easier to follow. Now that both use the same
> nodemask it should really be just about syscall inputs sanitization and
> to keep the original behavior for MPOL_PREFERRED.
> 
> [...]

Our intention is to make MPOL_PREFERRED_MANY be similar to
MPOL_PREFERRED, except it perfers multiple nodes. So will try to
achieve this in following version.

Also for MPOL_LOCAL and MPOL_PREFERRED, current code logic is
turning 'MPOL_LOCAL' to 'MPOL_PREFERRED' with MPOL_F_LOCAL set.
I don't understand why not use the other way around, that
turning MPOL_PREFERRED with empty nodemask to MPOL_LOCAL, which
looks more logical.

Thanks,
Feng

> > @@ -2072,6 +2087,9 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
> >  	task_lock(current);
> >  	mempolicy = current->mempolicy;
> >  	switch (mempolicy->mode) {
> > +	case MPOL_PREFERRED_MANY:
> > +		*mask = mempolicy->v.preferred_nodes;
> > +		break;
> >  	case MPOL_PREFERRED:
> >  		if (mempolicy->flags & MPOL_F_LOCAL)
> >  			nid = numa_node_id();
> 
> Same here
