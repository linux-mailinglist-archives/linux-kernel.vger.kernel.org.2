Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D06735F443
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 14:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347447AbhDNMvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 08:51:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:45928 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233219AbhDNMvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 08:51:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618404655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/JIpZsgUYXXJQRMWe7xG0sP2YALTAzzdJLwv1OqA5SE=;
        b=ssMHyoCtj/abwTu7VPH7eiUYTTRETpXMImP7nzx+E2OzrRiZA6Xmjl6RX0U/dA8qGn+uGu
        GiBsds0oj7+toaXiRDNInLPOG72nHqXEdwiN/pgro4OvRv/3y7aeh9k0gJynXVHeZaZ9OC
        xppiBxhIyJ4CZZ/tsXKEX1tvEvMZZdE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F196FAFC8;
        Wed, 14 Apr 2021 12:50:54 +0000 (UTC)
Date:   Wed, 14 Apr 2021 14:50:53 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
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
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v4 03/13] mm/mempolicy: Add MPOL_PREFERRED_MANY for
 multiple preferred nodes
Message-ID: <YHblLevoUZ6+AvVZ@dhcp22.suse.cz>
References: <1615952410-36895-1-git-send-email-feng.tang@intel.com>
 <1615952410-36895-4-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615952410-36895-4-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-03-21 11:40:00, Feng Tang wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> MPOL_PREFERRED honors only a single node set in the nodemask.  Add the
> bare define for a new mode which will allow more than one.
> 
> The patch does all the plumbing without actually adding the new policy
> type.
> 
> v2:
> Plumb most MPOL_PREFERRED_MANY without exposing UAPI (Ben)
> Fixes for checkpatch (Ben)
> 
> Link: https://lore.kernel.org/r/20200630212517.308045-4-ben.widawsky@intel.com
> Co-developed-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  mm/mempolicy.c | 46 ++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 40 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 2b1e0e4..1228d8e 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -31,6 +31,9 @@
>   *                but useful to set in a VMA when you have a non default
>   *                process policy.
>   *
> + * preferred many Try a set of nodes first before normal fallback. This is
> + *                similar to preferred without the special case.
> + *
>   * default        Allocate on the local node first, or when on a VMA
>   *                use the process policy. This is what Linux always did
>   *		  in a NUMA aware kernel and still does by, ahem, default.
> @@ -105,6 +108,8 @@
>  
>  #include "internal.h"
>  
> +#define MPOL_PREFERRED_MANY MPOL_MAX
> +
>  /* Internal flags */
>  #define MPOL_MF_DISCONTIG_OK (MPOL_MF_INTERNAL << 0)	/* Skip checks for continuous vmas */
>  #define MPOL_MF_INVERT (MPOL_MF_INTERNAL << 1)		/* Invert check for nodemask */
> @@ -175,7 +180,7 @@ struct mempolicy *get_task_policy(struct task_struct *p)
>  static const struct mempolicy_operations {
>  	int (*create)(struct mempolicy *pol, const nodemask_t *nodes);
>  	void (*rebind)(struct mempolicy *pol, const nodemask_t *nodes);
> -} mpol_ops[MPOL_MAX];
> +} mpol_ops[MPOL_MAX + 1];
>  
>  static inline int mpol_store_user_nodemask(const struct mempolicy *pol)
>  {
> @@ -415,7 +420,7 @@ void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new)
>  	mmap_write_unlock(mm);
>  }
>  
> -static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
> +static const struct mempolicy_operations mpol_ops[MPOL_MAX + 1] = {
>  	[MPOL_DEFAULT] = {
>  		.rebind = mpol_rebind_default,
>  	},
> @@ -432,6 +437,10 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
>  		.rebind = mpol_rebind_nodemask,
>  	},
>  	/* [MPOL_LOCAL] - see mpol_new() */
> +	[MPOL_PREFERRED_MANY] = {
> +		.create = NULL,
> +		.rebind = NULL,
> +	},
>  };

I do get that you wanted to keep MPOL_PREFERRED_MANY unaccessible for
the userspace but wouldn't it be much easier to simply check in two
syscall entries rather than playing thise MAX+1 games which make the
review more complicated than necessary?

>  
>  static int migrate_page_add(struct page *page, struct list_head *pagelist,
> @@ -924,6 +933,9 @@ static void get_policy_nodemask(struct mempolicy *p, nodemask_t *nodes)
>  	case MPOL_INTERLEAVE:
>  		*nodes = p->v.nodes;
>  		break;
> +	case MPOL_PREFERRED_MANY:
> +		*nodes = p->v.preferred_nodes;
> +		break;
>  	case MPOL_PREFERRED:
>  		if (!(p->flags & MPOL_F_LOCAL))
>  			*nodes = p->v.preferred_nodes;

Why those two do a slightly different thing? Is this because unlike
MPOL_PREFERRED it can never have MPOL_F_LOCAL cleared? If that is the
case I would still stick the two together and use the same code for
both to make the code easier to follow. Now that both use the same
nodemask it should really be just about syscall inputs sanitization and
to keep the original behavior for MPOL_PREFERRED.

[...]
> @@ -2072,6 +2087,9 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
>  	task_lock(current);
>  	mempolicy = current->mempolicy;
>  	switch (mempolicy->mode) {
> +	case MPOL_PREFERRED_MANY:
> +		*mask = mempolicy->v.preferred_nodes;
> +		break;
>  	case MPOL_PREFERRED:
>  		if (mempolicy->flags & MPOL_F_LOCAL)
>  			nid = numa_node_id();

Same here

> @@ -2126,6 +2144,9 @@ bool mempolicy_nodemask_intersects(struct task_struct *tsk,
>  		 * nodes in mask.
>  		 */
>  		break;
> +	case MPOL_PREFERRED_MANY:
> +		ret = nodes_intersects(mempolicy->v.preferred_nodes, *mask);
> +		break;

I do not think this is a correct behavior. Preferred policy, whether it
is a single node or a nodemask, is a hint not a requirement. So we
should always treat it as intersecting. I do understand that the naming
can be confusing because intersect operation should indeed check
nodemaska but this is yet another trap of the mempolicy code. It is
only used for the OOM selection.

Btw. the code is wrong for INTERLEAVE as well because it uses the
interleaving node as a hint as well. It is not bound by the interleave
nodemask. Sigh...

>  	case MPOL_BIND:
>  	case MPOL_INTERLEAVE:
>  		ret = nodes_intersects(mempolicy->v.nodes, *mask);
[...]

> @@ -2349,6 +2373,9 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
>  	case MPOL_BIND:
>  	case MPOL_INTERLEAVE:
>  		return !!nodes_equal(a->v.nodes, b->v.nodes);
> +	case MPOL_PREFERRED_MANY:
> +		return !!nodes_equal(a->v.preferred_nodes,
> +				     b->v.preferred_nodes);

Again different from MPOL_PREFERRED...

>  	case MPOL_PREFERRED:
>  		/* a's ->flags is the same as b's */
>  		if (a->flags & MPOL_F_LOCAL)
> @@ -2523,6 +2550,8 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
>  		polnid = zone_to_nid(z->zone);
>  		break;
>  
> +		/* case MPOL_PREFERRED_MANY: */
> +

I hope a follow up patch will make this not panic but as you are already
plumbing everything in it should really be as simple as node_isset
check.

>  	default:
>  		BUG();

Besides that, this should really go!

> @@ -3035,6 +3066,9 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
>  	switch (mode) {
>  	case MPOL_DEFAULT:
>  		break;
> +	case MPOL_PREFERRED_MANY:
> +		WARN_ON(flags & MPOL_F_LOCAL);

Why WARN_ON here?

> +		fallthrough;
>  	case MPOL_PREFERRED:
>  		if (flags & MPOL_F_LOCAL)
>  			mode = MPOL_LOCAL;
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
