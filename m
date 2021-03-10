Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFDB1333919
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 10:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbhCJJol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 04:44:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:51478 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232479AbhCJJoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 04:44:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615369452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3SsgBHW16eFWnTUrEH/77iFpVMjIm1pROOU1P8F4Mng=;
        b=Npfk496kGiHkf4as0AZ+Zg1Csp7luUcJauh0vcSnRMePUC5McZDgwhvAyoDjRmPedo9h78
        4ydozO4Se11nTVuHJ/nzYvi9WbUb7OFZkXtD1JhdIF1h0uWxv0ZIgYg7sjQGUSrvqxFJ4g
        xuYQ55aaqua7NEO1Wl9PEoSg8tccWCQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 793B2AE42;
        Wed, 10 Mar 2021 09:44:12 +0000 (UTC)
Date:   Wed, 10 Mar 2021 10:44:11 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 RFC 14/14] mm: speedup page alloc for
 MPOL_PREFERRED_MANY by adding a NO_SLOWPATH gfp bit
Message-ID: <YEiU6/5BXM7v4AOu@dhcp22.suse.cz>
References: <YD91jTMssJUCupJm@dhcp22.suse.cz>
 <20210303120717.GA16736@shbuild999.sh.intel.com>
 <20210303121833.GB16736@shbuild999.sh.intel.com>
 <YD+BvvM/388AVnmm@dhcp22.suse.cz>
 <20210303131832.GB78458@shbuild999.sh.intel.com>
 <20210303134644.GC78458@shbuild999.sh.intel.com>
 <YD+WR5cpuWhybm2L@dhcp22.suse.cz>
 <20210303163141.v5wu2sfo2zj2qqsw@intel.com>
 <d07f8675-939b-daea-c128-30ceecfac8a0@intel.com>
 <20210310051947.GA33036@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310051947.GA33036@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 10-03-21 13:19:47, Feng Tang wrote:
[...]
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index d66c1c0..00b19f7 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2205,9 +2205,13 @@ static struct page *alloc_pages_policy(struct mempolicy *pol, gfp_t gfp,
>  	 * | MPOL_PREFERRED_MANY (round 2) | local         | NULL       |
>  	 * +-------------------------------+---------------+------------+
>  	 */
> -	if (pol->mode == MPOL_PREFERRED_MANY)
> +	if (pol->mode == MPOL_PREFERRED_MANY) {
>  		gfp_mask |= __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
>  
> +		/* Skip direct reclaim, as there will be a second try */
> +		gfp_mask &= ~__GFP_DIRECT_RECLAIM;

__GFP_RETRY_MAYFAIL is a reclaim modifier which doesn't make any sense
without __GFP_DIRECT_RECLAIM. Also I think it would be better to have a
proper allocation flags in the initial patch which implements the
fallback.

> +	}
> +
>  	page = __alloc_pages_nodemask(gfp_mask, order,
>  				      policy_node(gfp, pol, preferred_nid),
>  				      policy_nodemask(gfp, pol));
> -- 
> 2.7.4
> 
> 

-- 
Michal Hocko
SUSE Labs
