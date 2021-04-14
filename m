Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF5135F4A0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 15:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351235AbhDNNPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 09:15:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:60454 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351227AbhDNNOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 09:14:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618406072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dE+HWKb+16i6cRgLpfVdufOcDPpR5dEzXtyzGBs68p8=;
        b=sYJkBtwBbUESpFpC95xC7R7I1ecRJEQ3oLvALnvVMQE6yV8vugBtpY9DsE5+5VOmyPMZhs
        nIzEITXIa1x0nEaI75a+wvD+lybZ1wEPe4XasG7MTpzRuVxP8DDmzAcGNeBPdyZj/jeA1d
        mCpaeUp+Hrb7a3N8ojq0DQD82ynWCsM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5B364AEF8;
        Wed, 14 Apr 2021 13:14:32 +0000 (UTC)
Date:   Wed, 14 Apr 2021 15:14:31 +0200
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
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 10/13] mm/mempolicy: VMA allocation for many preferred
Message-ID: <YHbqt0fdhFpVZAz5@dhcp22.suse.cz>
References: <1615952410-36895-1-git-send-email-feng.tang@intel.com>
 <1615952410-36895-11-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615952410-36895-11-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-03-21 11:40:07, Feng Tang wrote:
[...]
> @@ -2301,10 +2300,26 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
>  		 * does not allow the current node in its nodemask, we allocate
>  		 * the standard way.
>  		 */
> -		if ((pol->mode == MPOL_PREFERRED ||
> -		     pol->mode == MPOL_PREFERRED_MANY) &&
> -		    !(pol->flags & MPOL_F_LOCAL))
> +		if (pol->mode == MPOL_PREFERRED || !(pol->flags & MPOL_F_LOCAL)) {
>  			hpage_node = first_node(pol->nodes);
> +		} else if (pol->mode == MPOL_PREFERRED_MANY) {
> +			struct zoneref *z;
> +
> +			/*
> +			 * In this policy, with direct reclaim, the normal
> +			 * policy based allocation will do the right thing - try
> +			 * twice using the preferred nodes first, and all nodes
> +			 * second.
> +			 */
> +			if (gfp & __GFP_DIRECT_RECLAIM) {
> +				page = alloc_pages_policy(pol, gfp, order, NUMA_NO_NODE);
> +				goto out;
> +			}
> +
> +			z = first_zones_zonelist(node_zonelist(numa_node_id(), GFP_HIGHUSER),
> +						 gfp_zone(GFP_HIGHUSER), &pol->nodes);
> +			hpage_node = zone_to_nid(z->zone);
> +		}
>  
>  		nmask = policy_nodemask(gfp, pol);
>  		if (!nmask || node_isset(hpage_node, *nmask)) {
> @@ -2330,9 +2345,7 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
>  		}
>  	}
>  
> -	nmask = policy_nodemask(gfp, pol);
> -	preferred_nid = policy_node(gfp, pol, node);
> -	page = __alloc_pages_nodemask(gfp, order, preferred_nid, nmask);
> +	page = alloc_pages_policy(pol, gfp, order, NUMA_NO_NODE);
>  	mpol_cond_put(pol);
>  out:
>  	return page;

OK, it took me a while to grasp this but the code is a mess I have to
say. Not that it was an act of beauty before but this just makes it much
harder to follow. And alloc_pages_policy doesn't really help I have to
say. I would have expected that a dedicated alloc_pages_preferred and a
general fallback to __alloc_pages_nodemask would have been much easier
to follow.
-- 
Michal Hocko
SUSE Labs
