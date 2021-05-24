Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B8638E0BB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 07:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbhEXF5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 01:57:20 -0400
Received: from mga01.intel.com ([192.55.52.88]:33767 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229733AbhEXF5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 01:57:19 -0400
IronPort-SDR: 9+g1tvz6dvq4X3VziN0G8KhqOTs5hxzie4jEERQ+RoUy0AxB7SOopgSncvz/V9mFmTN8+tdpkd
 rT+ot8egapDQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="223013736"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="223013736"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2021 22:55:51 -0700
IronPort-SDR: PivyM5cGpVb+S3bGUvM+XALFFw+T7T+dYvtAtW5DbYVR3y7Br3ZLPQWg3C/JhxmYWWkBd93oRX
 YnoJwNpk1CNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="475690932"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by orsmga001.jf.intel.com with ESMTP; 23 May 2021 22:55:48 -0700
Date:   Mon, 24 May 2021 13:55:47 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     David Rientjes <rientjes@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, ying.huang@intel.com
Subject: Re: [RFC Patch v2 1/4] mm/mempolicy: skip nodemask intersect check
 for 'interleave' when oom
Message-ID: <20210524055547.GA48704@shbuild999.sh.intel.com>
References: <1621499404-67756-1-git-send-email-feng.tang@intel.com>
 <1621499404-67756-2-git-send-email-feng.tang@intel.com>
 <682c92e5-ccb3-4b76-1f56-617f8e6e8f2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <682c92e5-ccb3-4b76-1f56-617f8e6e8f2@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Thanks for the review!

On Sun, May 23, 2021 at 10:15:00PM -0700, David Rientjes wrote:
> On Thu, 20 May 2021, Feng Tang wrote:
> 
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index d79fa29..1964cca 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -2098,7 +2098,7 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
> >   *
> >   * If tsk's mempolicy is "default" [NULL], return 'true' to indicate default
> >   * policy.  Otherwise, check for intersection between mask and the policy
> > - * nodemask for 'bind' or 'interleave' policy.  For 'preferred' or 'local'
> > + * nodemask for 'bind' policy.  For 'interleave', 'preferred' or 'local'
> >   * policy, always return true since it may allocate elsewhere on fallback.
> >   *
> >   * Takes task_lock(tsk) to prevent freeing of its mempolicy.
> > @@ -2111,29 +2111,13 @@ bool mempolicy_nodemask_intersects(struct task_struct *tsk,
> >  
> >  	if (!mask)
> >  		return ret;
> > +
> >  	task_lock(tsk);
> >  	mempolicy = tsk->mempolicy;
> > -	if (!mempolicy)
> > -		goto out;
> > -
> > -	switch (mempolicy->mode) {
> > -	case MPOL_PREFERRED:
> > -		/*
> > -		 * MPOL_PREFERRED and MPOL_F_LOCAL are only preferred nodes to
> > -		 * allocate from, they may fallback to other nodes when oom.
> > -		 * Thus, it's possible for tsk to have allocated memory from
> > -		 * nodes in mask.
> > -		 */
> > -		break;
> > -	case MPOL_BIND:
> > -	case MPOL_INTERLEAVE:
> > +	if (mempolicy && mempolicy->mode == MPOL_BIND)
> >  		ret = nodes_intersects(mempolicy->v.nodes, *mask);
> 
> If MPOL_INTERLEAVE is deemed only a suggestion, the same could be 
> considered true of MPOL_BIND intersection as well, no?

IIUC, 'bind' and 'interleave' are different regarding memory allocation. In 
alloc_pages_vma(), there are:

	nmask = policy_nodemask(gfp, pol);
	preferred_nid = policy_node(gfp, pol, node);
	page = __alloc_pages(gfp, order, preferred_nid, nmask);
		mpol_cond_put(pol);

and in plicy_nodemask(), only 'bind' policy may return its desired nodemask,
while all other returns NULL including 'interleave'. And this 'NULL' enables
the 'interleave' policy can get memory from other nodes than its nodemask.

So when allocating memory, 'interleave' can get memory from all nodes. I did
some experements which also confirm this.

Thanks,
Feng


> 
> > -		break;
> > -	default:
> > -		BUG();
> > -	}
> > -out:
> >  	task_unlock(tsk);
> > +
> >  	return ret;
> >  }
> >  
> > -- 
> > 2.7.4
> > 
> > 
