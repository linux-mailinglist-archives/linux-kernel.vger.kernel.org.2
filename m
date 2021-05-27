Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD06392D8F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 14:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbhE0MIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 08:08:22 -0400
Received: from mga02.intel.com ([134.134.136.20]:55173 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234473AbhE0MIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 08:08:21 -0400
IronPort-SDR: G082CGLFBMH8x+YUPvRzzmyXh82L8RgFFWmZWHLEcQ00BDYHfY/1SBvV4yGk3MoJs5QcKXitY+
 03KhggXmED5Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="189834806"
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="189834806"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 05:06:47 -0700
IronPort-SDR: 6dMBmsoiyi2tlDJUNAFJYwIR7h9/PdVjoY4FOZJFvyli6+W18HJCASDPQpKYQoKyWFTWpSMS3M
 YPRebWN414lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="477456220"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by orsmga001.jf.intel.com with ESMTP; 27 May 2021 05:06:43 -0700
Date:   Thu, 27 May 2021 20:06:42 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
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
Message-ID: <20210527120642.GA85753@shbuild999.sh.intel.com>
References: <1622005302-23027-1-git-send-email-feng.tang@intel.com>
 <1622005302-23027-4-git-send-email-feng.tang@intel.com>
 <YK9UX9WY6GSnTPoB@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK9UX9WY6GSnTPoB@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

Many thanks for the reivews!

On Thu, May 27, 2021 at 10:12:15AM +0200, Michal Hocko wrote:
> On Wed 26-05-21 13:01:41, Feng Tang wrote:
> > MPOL_LOCAL policy has been setup as a real policy, but it is still
> > handled like a faked POL_PREFERRED policy with one internal
> > MPOL_F_LOCAL flag bit set, and there are many places having to
> > judge the real 'prefer' or the 'local' policy, which are quite
> > confusing.
> > 
> > In current code, there are four cases that MPOL_LOCAL are used:
> > * user specifies 'local' policy
> > * user specifies 'prefer' policy, but with empty nodemask
> > * system 'default' policy is used
> > * 'prefer' policy + valid 'preferred' node with MPOL_F_STATIC_NODES
> >   flag set, and when it is 'rebind' to a nodemask which doesn't
> >   contains the 'preferred' node, it will add the MPOL_F_LOCAL bit
> >   and performs as 'local' policy. In future if it is 'rebind' again
> >   with valid nodemask, the policy will be restored back to 'prefer'
> > 
> > So for the first three cases, we make 'local' a real policy
> > instead of a fake 'prefer' one, this will reduce confusion for
> > reading code.
> > 
> > And next optional patch will kill the 'MPOL_F_LOCAL' bit.
> 
> I do like this approach. An additional policy should be much easier to
> grasp than a special casing. This code is quite tricky so another pair
> of eyes would be definitely good for the review.
> 
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> Just few nits.
> 
> >  static int migrate_page_add(struct page *page, struct list_head *pagelist,
> > @@ -1965,6 +1965,8 @@ unsigned int mempolicy_slab_node(void)
> >  							&policy->v.nodes);
> >  		return z->zone ? zone_to_nid(z->zone) : node;
> >  	}
> > +	case MPOL_LOCAL:
> > +		return node;
> 
> Any reason you haven't removed MPOL_F_LOCAL in this and following
> functions? It would make it much more easier to review this patch if
> there was no actual use of the flag in the code after this patch.

As in the commit log, there are 4 cases using 'prefer' + MPOL_F_LOCAL 
to represent 'local' policy. 

I'm confident in this patch which handle the case 1/2/3, while not 
sure if the solution (patch 4/4) for case 4 is the right method. So
I separte them into 3/4 and 4/4

Thanks,
Feng


> >  
> >  	default:
> >  		BUG();
> > @@ -2089,6 +2091,11 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
> >  		*mask =  mempolicy->v.nodes;
> >  		break;
> >  
> > +	case MPOL_LOCAL:
> > +		nid = numa_node_id();
> > +		init_nodemask_of_node(mask, nid);
> > +		break;
> > +
> >  	default:
> >  		BUG();
> >  	}
> > @@ -2333,6 +2340,8 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
> >  		if (a->flags & MPOL_F_LOCAL)
> >  			return true;
> >  		return a->v.preferred_node == b->v.preferred_node;
> > +	case MPOL_LOCAL:
> > +		return true;
> >  	default:
> >  		BUG();
> >  		return false;
> > @@ -2476,6 +2485,10 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
> >  			polnid = pol->v.preferred_node;
> >  		break;
> >  
> > +	case MPOL_LOCAL:
> > +		polnid = numa_node_id();
> > +		break;
> > +
> >  	case MPOL_BIND:
> >  		/* Optimize placement among multiple nodes via NUMA balancing */
> >  		if (pol->flags & MPOL_F_MORON) {
> -- 
> Michal Hocko
> SUSE Labs
