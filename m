Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC1A396F4D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 10:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbhFAIsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 04:48:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:49716 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233157AbhFAIsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 04:48:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622537200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ACL4QuiSE0koEi+rfHcLVpupQtHQPyQnD2Exg+8O9N8=;
        b=l7DLNTWaNkYKmVbZV81wMUP2kX5fCG7TXxsgnJZ99xkqBSnvM/SxiLMQ7mWOKdYT4+MCYT
        2kaUT7JmskPUmDSgDBZwaFL9VkkNDMeUOJlaWWG4hZEMVJI5FjxwPbzXdA7Vd80eqSbYlb
        feXoTKMsEyz1UlHRlj8Vkf14wXD7RDw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 58280AE78;
        Tue,  1 Jun 2021 08:46:40 +0000 (UTC)
Date:   Tue, 1 Jun 2021 10:46:39 +0200
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
Subject: Re: [v3 PATCH 3/3] mm/mempolicy: unify the parameter sanity check
 for mbind and set_mempolicy
Message-ID: <YLXz76e5bXR1d/cN@dhcp22.suse.cz>
References: <1622469956-82897-1-git-send-email-feng.tang@intel.com>
 <1622469956-82897-4-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622469956-82897-4-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 31-05-21 22:05:56, Feng Tang wrote:
> Currently the kernel_mbind() and kernel_set_mempolicy() do almost
> the same operation for parameter sanity check.
> 
> Add a helper function to unify the code to reduce the redundancy,
> and make it easier for changing the pre-processing code in future.
> 
> [thanks to David Rientjes for suggesting using helper function
> instead of macro]
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>

sanitize_mpol_flags would benefit from some high level comments
explaining those modifications but this can be done on top. This looks
like a useful cleanup on its own

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/mempolicy.c | 47 +++++++++++++++++++++++++++++------------------
>  1 file changed, 29 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index c337bd7..85ef512 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1444,26 +1444,37 @@ static int copy_nodes_to_user(unsigned long __user *mask, unsigned long maxnode,
>  	return copy_to_user(mask, nodes_addr(*nodes), copy) ? -EFAULT : 0;
>  }
>  
> +static inline int sanitize_mpol_flags(int *mode, unsigned short *flags)
> +{
> +	*flags = *mode & MPOL_MODE_FLAGS;
> +	*mode &= ~MPOL_MODE_FLAGS;
> +	if ((unsigned int)(*mode) >= MPOL_MAX)
> +		return -EINVAL;
> +	if ((*flags & MPOL_F_STATIC_NODES) && (*flags & MPOL_F_RELATIVE_NODES))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  static long kernel_mbind(unsigned long start, unsigned long len,
>  			 unsigned long mode, const unsigned long __user *nmask,
>  			 unsigned long maxnode, unsigned int flags)
>  {
> +	unsigned short mode_flags;
>  	nodemask_t nodes;
> +	int lmode = mode;
>  	int err;
> -	unsigned short mode_flags;
>  
>  	start = untagged_addr(start);
> -	mode_flags = mode & MPOL_MODE_FLAGS;
> -	mode &= ~MPOL_MODE_FLAGS;
> -	if (mode >= MPOL_MAX)
> -		return -EINVAL;
> -	if ((mode_flags & MPOL_F_STATIC_NODES) &&
> -	    (mode_flags & MPOL_F_RELATIVE_NODES))
> -		return -EINVAL;
> +	err = sanitize_mpol_flags(&lmode, &mode_flags);
> +	if (err)
> +		return err;
> +
>  	err = get_nodes(&nodes, nmask, maxnode);
>  	if (err)
>  		return err;
> -	return do_mbind(start, len, mode, mode_flags, &nodes, flags);
> +
> +	return do_mbind(start, len, lmode, mode_flags, &nodes, flags);
>  }
>  
>  SYSCALL_DEFINE6(mbind, unsigned long, start, unsigned long, len,
> @@ -1477,20 +1488,20 @@ SYSCALL_DEFINE6(mbind, unsigned long, start, unsigned long, len,
>  static long kernel_set_mempolicy(int mode, const unsigned long __user *nmask,
>  				 unsigned long maxnode)
>  {
> -	int err;
> +	unsigned short mode_flags;
>  	nodemask_t nodes;
> -	unsigned short flags;
> +	int lmode = mode;
> +	int err;
> +
> +	err = sanitize_mpol_flags(&lmode, &mode_flags);
> +	if (err)
> +		return err;
>  
> -	flags = mode & MPOL_MODE_FLAGS;
> -	mode &= ~MPOL_MODE_FLAGS;
> -	if ((unsigned int)mode >= MPOL_MAX)
> -		return -EINVAL;
> -	if ((flags & MPOL_F_STATIC_NODES) && (flags & MPOL_F_RELATIVE_NODES))
> -		return -EINVAL;
>  	err = get_nodes(&nodes, nmask, maxnode);
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
