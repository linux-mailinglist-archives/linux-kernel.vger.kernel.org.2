Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0D3392946
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 10:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbhE0INz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 04:13:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:42556 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233100AbhE0INt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 04:13:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622103135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P6im+gNxoUBGcFFEHfCjWc2a/Q9RwBi4/nRagfgx0Zk=;
        b=r9dkQ8D1Z6nbRybHXWlvmo307dGKEluRXmFQUnx5fcBzToQPC+zxWtYpgDOFFFZjw9tNF8
        F/xkdI3d8/qEgPHs0cxs0Xu8YN7saJ4wrgOxvpMCJbZRrCEoI2VTZ8HUFkwn/wb1z3tuHR
        PSwY6o7ak6fgjy681avetvNRfzZvb1U=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CE73BAC3A;
        Thu, 27 May 2021 08:12:15 +0000 (UTC)
Date:   Thu, 27 May 2021 10:12:15 +0200
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
Subject: Re: [PATCH v1 3/4] mm/mempolicy: don't handle MPOL_LOCAL like a fake
 MPOL_PREFERRED policy
Message-ID: <YK9UX9WY6GSnTPoB@dhcp22.suse.cz>
References: <1622005302-23027-1-git-send-email-feng.tang@intel.com>
 <1622005302-23027-4-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622005302-23027-4-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 26-05-21 13:01:41, Feng Tang wrote:
> MPOL_LOCAL policy has been setup as a real policy, but it is still
> handled like a faked POL_PREFERRED policy with one internal
> MPOL_F_LOCAL flag bit set, and there are many places having to
> judge the real 'prefer' or the 'local' policy, which are quite
> confusing.
> 
> In current code, there are four cases that MPOL_LOCAL are used:
> * user specifies 'local' policy
> * user specifies 'prefer' policy, but with empty nodemask
> * system 'default' policy is used
> * 'prefer' policy + valid 'preferred' node with MPOL_F_STATIC_NODES
>   flag set, and when it is 'rebind' to a nodemask which doesn't
>   contains the 'preferred' node, it will add the MPOL_F_LOCAL bit
>   and performs as 'local' policy. In future if it is 'rebind' again
>   with valid nodemask, the policy will be restored back to 'prefer'
> 
> So for the first three cases, we make 'local' a real policy
> instead of a fake 'prefer' one, this will reduce confusion for
> reading code.
> 
> And next optional patch will kill the 'MPOL_F_LOCAL' bit.

I do like this approach. An additional policy should be much easier to
grasp than a special casing. This code is quite tricky so another pair
of eyes would be definitely good for the review.

> Signed-off-by: Feng Tang <feng.tang@intel.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Just few nits.

>  static int migrate_page_add(struct page *page, struct list_head *pagelist,
> @@ -1965,6 +1965,8 @@ unsigned int mempolicy_slab_node(void)
>  							&policy->v.nodes);
>  		return z->zone ? zone_to_nid(z->zone) : node;
>  	}
> +	case MPOL_LOCAL:
> +		return node;

Any reason you haven't removed MPOL_F_LOCAL in this and following
functions? It would make it much more easier to review this patch if
there was no actual use of the flag in the code after this patch.

>  
>  	default:
>  		BUG();
> @@ -2089,6 +2091,11 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
>  		*mask =  mempolicy->v.nodes;
>  		break;
>  
> +	case MPOL_LOCAL:
> +		nid = numa_node_id();
> +		init_nodemask_of_node(mask, nid);
> +		break;
> +
>  	default:
>  		BUG();
>  	}
> @@ -2333,6 +2340,8 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
>  		if (a->flags & MPOL_F_LOCAL)
>  			return true;
>  		return a->v.preferred_node == b->v.preferred_node;
> +	case MPOL_LOCAL:
> +		return true;
>  	default:
>  		BUG();
>  		return false;
> @@ -2476,6 +2485,10 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
>  			polnid = pol->v.preferred_node;
>  		break;
>  
> +	case MPOL_LOCAL:
> +		polnid = numa_node_id();
> +		break;
> +
>  	case MPOL_BIND:
>  		/* Optimize placement among multiple nodes via NUMA balancing */
>  		if (pol->flags & MPOL_F_MORON) {
-- 
Michal Hocko
SUSE Labs
