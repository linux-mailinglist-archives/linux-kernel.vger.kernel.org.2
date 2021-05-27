Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498143928B3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 09:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbhE0HlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 03:41:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:45630 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234279AbhE0HlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 03:41:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622101190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ysXBzYpFMZ/j0HqnWY8w72Bm/ehnFceNL/rYPSTk6WI=;
        b=CPxznGk9sU8MRdsMlJGqkmEKZ6Lx9jRRvt2blsPxx9IRr/KgnYX2/Q50lPoABV46qOx9yv
        pin9N25i4XFHbSxii7XDKu3EHu2YaUgIlg7dCBPMZG75NJEz86wzjQQN+cXe8dQkdYzkb2
        X8LfYrHBORZMJ6onkLDreb70QTv8eoc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 18CF6AC46;
        Thu, 27 May 2021 07:39:50 +0000 (UTC)
Date:   Thu, 27 May 2021 09:39:49 +0200
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
Subject: Re: [PATCH v1 2/4] mm/mempolicy: unify the preprocessing for mbind
 and set_mempolicy
Message-ID: <YK9MxT8Bwt/TnqWa@dhcp22.suse.cz>
References: <1622005302-23027-1-git-send-email-feng.tang@intel.com>
 <1622005302-23027-3-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622005302-23027-3-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 26-05-21 13:01:40, Feng Tang wrote:
> Currently the kernel_mbind() and kernel_set_mempolicy() do almost
> the same operation for parameter sanity check and preprocessing.
> 
> Add a helper function to unify the code to reduce the redundancy,
> and make it easier for changing the pre-processing code in future.
> 
> [thanks to David Rientjes for suggesting using helper function
> instead of macro]

I appreciate removing the code duplication but I am not really convinced
this is an improvement. You are conflating two things. One is the mpol
flags checking and node mask copying. While abstracting the first one
makes sense to me the later is already a single line of code that makes
your helper unnecessarily complex. So I would go with sanitize_mpol_flags
and put a flags handling there and leave get_nodes alone.
 
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  mm/mempolicy.c | 43 ++++++++++++++++++++++++-------------------
>  1 file changed, 24 insertions(+), 19 deletions(-)

Funny how removing code duplication adds more code than it removes ;)

> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 1964cca..2830bb8 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1460,6 +1460,20 @@ static int copy_nodes_to_user(unsigned long __user *mask, unsigned long maxnode,
>  	return copy_to_user(mask, nodes_addr(*nodes), copy) ? -EFAULT : 0;
>  }
>  
> +static inline int mpol_pre_process(int *mode, const unsigned long __user *nmask, unsigned long maxnode, nodemask_t *nodes, unsigned short *flags)
> +{
> +	int ret;
> +
> +	*flags = *mode & MPOL_MODE_FLAGS;
> +	*mode &= ~MPOL_MODE_FLAGS;
> +	if ((unsigned int)(*mode) >= MPOL_MAX)
> +		return -EINVAL;
> +	if ((*flags & MPOL_F_STATIC_NODES) && (*flags & MPOL_F_RELATIVE_NODES))
> +		return -EINVAL;
> +	ret = get_nodes(nodes, nmask, maxnode);
> +	return ret;
> +}
> +
>  static long kernel_mbind(unsigned long start, unsigned long len,
>  			 unsigned long mode, const unsigned long __user *nmask,
>  			 unsigned long maxnode, unsigned int flags)
> @@ -1467,19 +1481,14 @@ static long kernel_mbind(unsigned long start, unsigned long len,
>  	nodemask_t nodes;
>  	int err;
>  	unsigned short mode_flags;
> +	int lmode = mode;
>  
> -	start = untagged_addr(start);
> -	mode_flags = mode & MPOL_MODE_FLAGS;
> -	mode &= ~MPOL_MODE_FLAGS;
> -	if (mode >= MPOL_MAX)
> -		return -EINVAL;
> -	if ((mode_flags & MPOL_F_STATIC_NODES) &&
> -	    (mode_flags & MPOL_F_RELATIVE_NODES))
> -		return -EINVAL;
> -	err = get_nodes(&nodes, nmask, maxnode);
> +	err = mpol_pre_process(&lmode, nmask, maxnode, &nodes, &mode_flags);
>  	if (err)
>  		return err;
> -	return do_mbind(start, len, mode, mode_flags, &nodes, flags);
> +
> +	start = untagged_addr(start);
> +	return do_mbind(start, len, lmode, mode_flags, &nodes, flags);
>  }
>  
>  SYSCALL_DEFINE6(mbind, unsigned long, start, unsigned long, len,
> @@ -1495,18 +1504,14 @@ static long kernel_set_mempolicy(int mode, const unsigned long __user *nmask,
>  {
>  	int err;
>  	nodemask_t nodes;
> -	unsigned short flags;
> +	unsigned short mode_flags;
> +	int lmode = mode;
>  
> -	flags = mode & MPOL_MODE_FLAGS;
> -	mode &= ~MPOL_MODE_FLAGS;
> -	if ((unsigned int)mode >= MPOL_MAX)
> -		return -EINVAL;
> -	if ((flags & MPOL_F_STATIC_NODES) && (flags & MPOL_F_RELATIVE_NODES))
> -		return -EINVAL;
> -	err = get_nodes(&nodes, nmask, maxnode);
> +	err = mpol_pre_process(&lmode, nmask, maxnode, &nodes, &mode_flags);
>  	if (err)
>  		return err;
> -	return do_set_mempolicy(mode, flags, &nodes);
> +
> +	return do_set_mempolicy(lmode, mode_flags, &nodes);
>  }
>  
>  SYSCALL_DEFINE3(set_mempolicy, int, mode, const unsigned long __user *, nmask,
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
