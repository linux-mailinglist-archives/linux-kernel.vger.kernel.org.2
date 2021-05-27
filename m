Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0827392962
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 10:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbhE0IVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 04:21:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:49074 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235169AbhE0IVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 04:21:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622103609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XB8CgP16Z2uVxIEDkdauFJUwH6W3alLpLkpuqADlG0Q=;
        b=lD05TOJlHjh9PizvGAeHx9p6vrNW0J38GgxixQkpw1wMVGOE4caz3NdYUvE0m0OWJd5KBW
        96bHjl6viBPLtiaNqGuF72MosQmk00vHmoREYzlcmKdq7z96ZYF7h5887fBcwP3ZUYS9E/
        e2pt2BMM6CTlP+6v3C/HF34G4tWaOas=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 595AEAC3A;
        Thu, 27 May 2021 08:20:09 +0000 (UTC)
Date:   Thu, 27 May 2021 10:20:08 +0200
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
Subject: Re: [PATCH v1 4/4] mm/mempolicy: kill MPOL_F_LOCAL bit
Message-ID: <YK9WOKBRsaFESPfR@dhcp22.suse.cz>
References: <1622005302-23027-1-git-send-email-feng.tang@intel.com>
 <1622005302-23027-5-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622005302-23027-5-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 26-05-21 13:01:42, Feng Tang wrote:
> Now the only remaining case of a real 'local' policy faked by
> 'prefer' policy plus MPOL_F_LOCAL bit is:
> 
> A valid 'prefer' policy with a valid 'preferred' node is 'rebind'
> to a nodemask which doesn't contains the 'preferred' node, then it
> will handle allocation with 'local' policy.
> 
> Add a new 'MPOL_F_LOCAL_TEMP' bit for this case, and kill the
> MPOL_F_LOCAL bit, which could simplify the code much.

As I've pointed out in the reply to the previous patch. It would have
been much better if most of the MPOL_F_LOCAL usage was gone by this
patch.

I also dislike a new MPOL_F_LOCAL_TEMP. This smells like sneaking the
hack back in after you have painstakingly removed it. So this looks like
a step backwards to me. I also do not understand why do we need the
rebind callback for local policy at all. There is no node mask for local
so what is going on here?

[...]
> +static void mpol_rebind_local(struct mempolicy *pol,
> +				const nodemask_t *nodes)
> +{
> +	if (unlikely(pol->flags & MPOL_F_STATIC_NODES)) {
> +		int node = first_node(pol->w.user_nodemask);
> +
> +		BUG_ON(!(pol->flags & MPOL_F_LOCAL_TEMP));
> +
> +		if (node_isset(node, *nodes)) {
> +			pol->v.preferred_node = node;
> +			pol->mode = MPOL_PREFERRED;
> +			pol->flags &= ~MPOL_F_LOCAL_TEMP;
> +		}
> +	}
> +}
> +

I have to confess I've got lost here. Could you explain why do you need
all this handling for a local policy?

>  static void mpol_rebind_preferred(struct mempolicy *pol,
>  						const nodemask_t *nodes)
>  {
> @@ -347,13 +363,19 @@ static void mpol_rebind_preferred(struct mempolicy *pol,
>  
>  		if (node_isset(node, *nodes)) {
>  			pol->v.preferred_node = node;
> -			pol->flags &= ~MPOL_F_LOCAL;
> -		} else
> -			pol->flags |= MPOL_F_LOCAL;
> +		} else {
> +			/*
> +			 * If there is no valid node, change the mode to
> +			 * MPOL_LOCAL, which will be restored back when
> +			 * next rebind() sees a valid node.
> +			 */
> +			pol->mode = MPOL_LOCAL;
> +			pol->flags |= MPOL_F_LOCAL_TEMP;
> +		}
>  	} else if (pol->flags & MPOL_F_RELATIVE_NODES) {
>  		mpol_relative_nodemask(&tmp, &pol->w.user_nodemask, nodes);
>  		pol->v.preferred_node = first_node(tmp);
> -	} else if (!(pol->flags & MPOL_F_LOCAL)) {
> +	} else {
>  		pol->v.preferred_node = node_remap(pol->v.preferred_node,
>  						   pol->w.cpuset_mems_allowed,
>  						   *nodes);
> @@ -372,7 +394,7 @@ static void mpol_rebind_policy(struct mempolicy *pol, const nodemask_t *newmask)
>  {
>  	if (!pol)
>  		return;
> -	if (!mpol_store_user_nodemask(pol) && !(pol->flags & MPOL_F_LOCAL) &&
> +	if (!mpol_store_user_nodemask(pol) &&
>  	    nodes_equal(pol->w.cpuset_mems_allowed, *newmask))
>  		return;
>  
> @@ -425,7 +447,7 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
>  	},
>  	[MPOL_LOCAL] = {
>  		.create = mpol_new_local,
> -		.rebind = mpol_rebind_default,
> +		.rebind = mpol_rebind_local,
>  	},
>  };
-- 
Michal Hocko
SUSE Labs
