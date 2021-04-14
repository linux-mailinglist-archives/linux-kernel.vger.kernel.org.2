Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D679635F45B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 14:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbhDNM4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 08:56:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:48430 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230303AbhDNM4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 08:56:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618404940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IVVFe9lVz57JQCiJGdKdxrabbFt2psVmdL+WS1cz9u0=;
        b=S5QL89mvzAHLxuE28gMdDkW7ratvQbt7wf6PzxucjX0wG64l2Z0/KUVICEJtjMD57BdyAq
        m97dquJ8tv1geZDYSJHmVRrZ/UJig1+1G43MEEbWpxLoRfw+E/z14m9lcHG8BxCJqBf8ra
        kU7pOhnXLnV9tBzhAAPm2IEBzu14sOc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 85977AFAB;
        Wed, 14 Apr 2021 12:55:40 +0000 (UTC)
Date:   Wed, 14 Apr 2021 14:55:39 +0200
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
Subject: Re: [PATCH v4 04/13] mm/mempolicy: allow preferred code to take a
 nodemask
Message-ID: <YHbmS6R+CpSDWtAD@dhcp22.suse.cz>
References: <1615952410-36895-1-git-send-email-feng.tang@intel.com>
 <1615952410-36895-5-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615952410-36895-5-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-03-21 11:40:01, Feng Tang wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> Create a helper function (mpol_new_preferred_many()) which is usable
> both by the old, single-node MPOL_PREFERRED and the new
> MPOL_PREFERRED_MANY.
> 
> Enforce the old single-node MPOL_PREFERRED behavior in the "new"
> version of mpol_new_preferred() which calls mpol_new_preferred_many().
> 
> v3:
>   * fix a stack overflow caused by emty nodemask (Feng)
> 
> Link: https://lore.kernel.org/r/20200630212517.308045-5-ben.widawsky@intel.com
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  mm/mempolicy.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 1228d8e..6fb2cab 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -203,17 +203,34 @@ static int mpol_new_interleave(struct mempolicy *pol, const nodemask_t *nodes)
>  	return 0;
>  }
>  
> -static int mpol_new_preferred(struct mempolicy *pol, const nodemask_t *nodes)
> +static int mpol_new_preferred_many(struct mempolicy *pol,
> +				   const nodemask_t *nodes)
>  {
>  	if (!nodes)
>  		pol->flags |= MPOL_F_LOCAL;	/* local allocation */

Now you have confused me. I thought that MPOL_PREFERRED_MANY for NULL
nodemask will be disallowed as it is effectively MPOL_PREFERRED aka
MPOL_F_LOCAL. Or do I misread the code?

>  	else if (nodes_empty(*nodes))
>  		return -EINVAL;			/*  no allowed nodes */
>  	else
> -		pol->v.preferred_nodes = nodemask_of_node(first_node(*nodes));
> +		pol->v.preferred_nodes = *nodes;
>  	return 0;
>  }
>  
> +static int mpol_new_preferred(struct mempolicy *pol, const nodemask_t *nodes)
> +{
> +	if (nodes) {
> +		/* MPOL_PREFERRED can only take a single node: */
> +		nodemask_t tmp;
> +
> +		if (nodes_empty(*nodes))
> +			return -EINVAL;
> +
> +		tmp = nodemask_of_node(first_node(*nodes));
> +		return mpol_new_preferred_many(pol, &tmp);
> +	}
> +
> +	return mpol_new_preferred_many(pol, NULL);
> +}
> +
>  static int mpol_new_bind(struct mempolicy *pol, const nodemask_t *nodes)
>  {
>  	if (nodes_empty(*nodes))
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
