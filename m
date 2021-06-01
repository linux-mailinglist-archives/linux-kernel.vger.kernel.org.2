Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B30E396EB9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 10:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbhFAIVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 04:21:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:55264 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233295AbhFAIVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 04:21:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622535566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l0j051AAXi+uzGkChemQvG7BEpNZnRrIFj2OzSLlI3Y=;
        b=cmrRZE9cjm8oKpwXCtF/3k4iwcLAKZFAziGXWMUjBo6zBfNDeVb3Gnub6dVHzBJ4s76mfo
        Z1JebDGI1ePsKrGx9/JwmJHszkB131LelEGxekAXJtIRMHpZkZcPdw5h4EbtFnzmDIenaM
        28DwnIwvUZqcm64/8Cxs1fgzHrSgJcU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ED39EACB1;
        Tue,  1 Jun 2021 08:19:25 +0000 (UTC)
Date:   Tue, 1 Jun 2021 10:19:25 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
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
Subject: Re: [v3 PATCH 1/3] mm/mempolicy: cleanup nodemask intersection check
 for oom
Message-ID: <YLXtjRYUcaXcYfua@dhcp22.suse.cz>
References: <1622469956-82897-1-git-send-email-feng.tang@intel.com>
 <1622469956-82897-2-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622469956-82897-2-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 31-05-21 22:05:54, Feng Tang wrote:
> mempolicy_nodemask_intersects() is used in oom case to check if a
> task may have memory allocated on some memory nodes.
> 
> As it's only used by OOM check, rename it to mempolicy_in_oom_domain()
> to reduce confusion.
> 
> As only for 'bind' policy, the nodemask is a force requirement for
> from where to allocate memory, only do the intesection check for it,
> and return true for all other policies.

I would slightly rephrase the above to
"
mempolicy_nodemask_intersects seem to be a general purpose mempolicy
function. In fact it is partially tailored for the OOM purpose instead.
The oom proper is the only existing user so rename the function to make
that purpose explicit.

While at it drop the MPOL_INTERLEAVE as those allocations never has a
nodemask defined (see alloc_page_interleave) so this is a dead code
and a confusing one because MPOL_INTERLEAVE is a hint rather than a hard
requirement so it shouldn't be considered during the OOM.

The final code can be reduced to a check for MPOL_BIND which is the only
memory policy that is a hard requirement and thus relevant to a
constrained OOM logic.
"

> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Feng Tang <feng.tang@intel.com>

To the change itself
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/mempolicy.h |  2 +-
>  mm/mempolicy.c            | 34 +++++++++-------------------------
>  mm/oom_kill.c             |  2 +-
>  3 files changed, 11 insertions(+), 27 deletions(-)
> 
> diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
> index 5f1c74d..8773c55 100644
> --- a/include/linux/mempolicy.h
> +++ b/include/linux/mempolicy.h
> @@ -150,7 +150,7 @@ extern int huge_node(struct vm_area_struct *vma,
>  				unsigned long addr, gfp_t gfp_flags,
>  				struct mempolicy **mpol, nodemask_t **nodemask);
>  extern bool init_nodemask_of_mempolicy(nodemask_t *mask);
> -extern bool mempolicy_nodemask_intersects(struct task_struct *tsk,
> +extern bool mempolicy_in_oom_domain(struct task_struct *tsk,
>  				const nodemask_t *mask);
>  extern nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy);
>  
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index d79fa29..6795a6a 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2094,16 +2094,16 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
>  #endif
>  
>  /*
> - * mempolicy_nodemask_intersects
> + * mempolicy_in_oom_domain
>   *
> - * If tsk's mempolicy is "default" [NULL], return 'true' to indicate default
> - * policy.  Otherwise, check for intersection between mask and the policy
> - * nodemask for 'bind' or 'interleave' policy.  For 'preferred' or 'local'
> - * policy, always return true since it may allocate elsewhere on fallback.
> + * If tsk's mempolicy is "bind", check for intersection between mask and
> + * the policy nodemask. Otherwise, return true for all other policies
> + * including "interleave", as a tsk with "interleave" policy may have
> + * memory allocated from all nodes in system.
>   *
>   * Takes task_lock(tsk) to prevent freeing of its mempolicy.
>   */
> -bool mempolicy_nodemask_intersects(struct task_struct *tsk,
> +bool mempolicy_in_oom_domain(struct task_struct *tsk,
>  					const nodemask_t *mask)
>  {
>  	struct mempolicy *mempolicy;
> @@ -2111,29 +2111,13 @@ bool mempolicy_nodemask_intersects(struct task_struct *tsk,
>  
>  	if (!mask)
>  		return ret;
> +
>  	task_lock(tsk);
>  	mempolicy = tsk->mempolicy;
> -	if (!mempolicy)
> -		goto out;
> -
> -	switch (mempolicy->mode) {
> -	case MPOL_PREFERRED:
> -		/*
> -		 * MPOL_PREFERRED and MPOL_F_LOCAL are only preferred nodes to
> -		 * allocate from, they may fallback to other nodes when oom.
> -		 * Thus, it's possible for tsk to have allocated memory from
> -		 * nodes in mask.
> -		 */
> -		break;
> -	case MPOL_BIND:
> -	case MPOL_INTERLEAVE:
> +	if (mempolicy && mempolicy->mode == MPOL_BIND)
>  		ret = nodes_intersects(mempolicy->v.nodes, *mask);
> -		break;
> -	default:
> -		BUG();
> -	}
> -out:
>  	task_unlock(tsk);
> +
>  	return ret;
>  }
>  
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index eefd3f5..fcc29e9 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -104,7 +104,7 @@ static bool oom_cpuset_eligible(struct task_struct *start,
>  			 * mempolicy intersects current, otherwise it may be
>  			 * needlessly killed.
>  			 */
> -			ret = mempolicy_nodemask_intersects(tsk, mask);
> +			ret = mempolicy_in_oom_domain(tsk, mask);
>  		} else {
>  			/*
>  			 * This is not a mempolicy constrained oom, so only
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
