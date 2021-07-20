Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8CE3CFDF7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 17:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbhGTPA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 11:00:29 -0400
Received: from mga12.intel.com ([192.55.52.136]:15550 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241911AbhGTO5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 10:57:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="190846215"
X-IronPort-AV: E=Sophos;i="5.84,255,1620716400"; 
   d="scan'208";a="190846215"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 08:37:05 -0700
X-IronPort-AV: E=Sophos;i="5.84,255,1620716400"; 
   d="scan'208";a="469799017"
Received: from lesliemu-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.136.56])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 08:37:04 -0700
Date:   Tue, 20 Jul 2021 08:37:00 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Feng Tang <feng.tang@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Yanfei Xu <yanfei.xu@windriver.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        yuanxzhang@fudan.edu.cn, Xin Tan <tanxin.ctf@gmail.com>
Subject: Re: [PATCH] mm/mempolicy: Convert from atomic_t to refcount_t on
 mempolicy->refcnt
Message-ID: <20210720153700.tqq4d7fronda42ro@intel.com>
Mail-Followup-To: Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        Feng Tang <feng.tang@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Yanfei Xu <yanfei.xu@windriver.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, yuanxzhang@fudan.edu.cn,
        Xin Tan <tanxin.ctf@gmail.com>
References: <1626683671-64407-1-git-send-email-xiyuyang19@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626683671-64407-1-git-send-email-xiyuyang19@fudan.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-07-19 16:34:28, Xiyu Yang wrote:
> refcount_t type and corresponding API can protect refcounters from
> accidental underflow and overflow and further use-after-free situations.
> 
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>

lgtm

Acked-by: Ben Widawsky <ben.widawsky@intel.com>

> ---
>  include/linux/mempolicy.h | 5 +++--
>  mm/mempolicy.c            | 8 ++++----
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
> index 0aaf91b496e2..faec94994eb7 100644
> --- a/include/linux/mempolicy.h
> +++ b/include/linux/mempolicy.h
> @@ -6,6 +6,7 @@
>  #ifndef _LINUX_MEMPOLICY_H
>  #define _LINUX_MEMPOLICY_H 1
>  
> +#include <linux/refcount.h>
>  #include <linux/sched.h>
>  #include <linux/mmzone.h>
>  #include <linux/dax.h>
> @@ -43,7 +44,7 @@ struct mm_struct;
>   * to 1, representing the caller of mpol_dup().
>   */
>  struct mempolicy {
> -	atomic_t refcnt;
> +	refcount_t refcnt;
>  	unsigned short mode; 	/* See MPOL_* above */
>  	unsigned short flags;	/* See set_mempolicy() MPOL_F_* above */
>  	nodemask_t nodes;	/* interleave/bind/perfer */
> @@ -94,7 +95,7 @@ static inline struct mempolicy *mpol_dup(struct mempolicy *pol)
>  static inline void mpol_get(struct mempolicy *pol)
>  {
>  	if (pol)
> -		atomic_inc(&pol->refcnt);
> +		refcount_inc(&pol->refcnt);
>  }
>  
>  extern bool __mpol_equal(struct mempolicy *a, struct mempolicy *b);
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index e32360e90274..829a14f34b43 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -298,7 +298,7 @@ static struct mempolicy *mpol_new(unsigned short mode, unsigned short flags,
>  	policy = kmem_cache_alloc(policy_cache, GFP_KERNEL);
>  	if (!policy)
>  		return ERR_PTR(-ENOMEM);
> -	atomic_set(&policy->refcnt, 1);
> +	refcount_set(&policy->refcnt, 1);
>  	policy->mode = mode;
>  	policy->flags = flags;
>  
> @@ -308,7 +308,7 @@ static struct mempolicy *mpol_new(unsigned short mode, unsigned short flags,
>  /* Slow path of a mpol destructor. */
>  void __mpol_put(struct mempolicy *p)
>  {
> -	if (!atomic_dec_and_test(&p->refcnt))
> +	if (!refcount_dec_and_test(&p->refcnt))
>  		return;
>  	kmem_cache_free(policy_cache, p);
>  }
> @@ -2290,7 +2290,7 @@ struct mempolicy *__mpol_dup(struct mempolicy *old)
>  		nodemask_t mems = cpuset_mems_allowed(current);
>  		mpol_rebind_policy(new, &mems);
>  	}
> -	atomic_set(&new->refcnt, 1);
> +	refcount_set(&new->refcnt, 1);
>  	return new;
>  }
>  
> @@ -2581,7 +2581,7 @@ static int shared_policy_replace(struct shared_policy *sp, unsigned long start,
>  					goto alloc_new;
>  
>  				*mpol_new = *n->policy;
> -				atomic_set(&mpol_new->refcnt, 1);
> +				refcount_set(&mpol_new->refcnt, 1);
>  				sp_node_init(n_new, end, n->end, mpol_new);
>  				n->end = start;
>  				sp_insert(sp, n_new);
> -- 
> 2.7.4
> 
