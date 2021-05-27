Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73468392DAF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 14:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbhE0MMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 08:12:20 -0400
Received: from mga12.intel.com ([192.55.52.136]:27442 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234914AbhE0MMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 08:12:20 -0400
IronPort-SDR: Ys5aY3nx5fG4MFArO8nsxPoT1uppJZM+mJxwpxfkNSYTfuwfjpzXj2NbYOFmhZWBos/ziN4Kjs
 jY/TcI/Xu64g==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="182372333"
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="182372333"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 05:10:46 -0700
IronPort-SDR: j3BeS5ChWaizaWyXVOTfJ9JC6eiXr1QGHwkahv7ecwtnaJ3InzgHCJN73J/EFt+aClwmwzlr7J
 9K8WeoJ5ss+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="477457682"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by orsmga001.jf.intel.com with ESMTP; 27 May 2021 05:10:41 -0700
Date:   Thu, 27 May 2021 20:10:41 +0800
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
Subject: Re: [PATCH v1 4/4] mm/mempolicy: kill MPOL_F_LOCAL bit
Message-ID: <20210527121041.GA7743@shbuild999.sh.intel.com>
References: <1622005302-23027-1-git-send-email-feng.tang@intel.com>
 <1622005302-23027-5-git-send-email-feng.tang@intel.com>
 <YK9WOKBRsaFESPfR@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK9WOKBRsaFESPfR@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 10:20:08AM +0200, Michal Hocko wrote:
> On Wed 26-05-21 13:01:42, Feng Tang wrote:
> > Now the only remaining case of a real 'local' policy faked by
> > 'prefer' policy plus MPOL_F_LOCAL bit is:
> > 
> > A valid 'prefer' policy with a valid 'preferred' node is 'rebind'
> > to a nodemask which doesn't contains the 'preferred' node, then it
> > will handle allocation with 'local' policy.
> > 
> > Add a new 'MPOL_F_LOCAL_TEMP' bit for this case, and kill the
> > MPOL_F_LOCAL bit, which could simplify the code much.
> 
> As I've pointed out in the reply to the previous patch. It would have
> been much better if most of the MPOL_F_LOCAL usage was gone by this
> patch.
> 
> I also dislike a new MPOL_F_LOCAL_TEMP. This smells like sneaking the
> hack back in after you have painstakingly removed it. So this looks like
> a step backwards to me. I also do not understand why do we need the
> rebind callback for local policy at all. There is no node mask for local
> so what is going on here?

This is the special case 4 for 'perfer' policy with MPOL_F_STATIC_NODES
flag set, say it prefer node 1, when it is later 'refind' to a new
nodemask node 2-3, according to current code it will be add the
MPOL_F_LOCAL bit and performs 'local' policy acctually. And in future
it is 'rebind' again with a nodemask 1-2, it will be restored back
to 'prefer' policy with preferred node 1.

This patch tries to address this special case. I have struggled but 
couldn't think of a good way. Any suggestions? thanks!

- Feng

> [...]
> > +static void mpol_rebind_local(struct mempolicy *pol,
> > +				const nodemask_t *nodes)
> > +{
> > +	if (unlikely(pol->flags & MPOL_F_STATIC_NODES)) {
> > +		int node = first_node(pol->w.user_nodemask);
> > +
> > +		BUG_ON(!(pol->flags & MPOL_F_LOCAL_TEMP));
> > +
> > +		if (node_isset(node, *nodes)) {
> > +			pol->v.preferred_node = node;
> > +			pol->mode = MPOL_PREFERRED;
> > +			pol->flags &= ~MPOL_F_LOCAL_TEMP;
> > +		}
> > +	}
> > +}
> > +
> 
> I have to confess I've got lost here. Could you explain why do you need
> all this handling for a local policy?
> 
> >  static void mpol_rebind_preferred(struct mempolicy *pol,
> >  						const nodemask_t *nodes)
> >  {
> > @@ -347,13 +363,19 @@ static void mpol_rebind_preferred(struct mempolicy *pol,
> >  
> >  		if (node_isset(node, *nodes)) {
> >  			pol->v.preferred_node = node;
> > -			pol->flags &= ~MPOL_F_LOCAL;
> > -		} else
> > -			pol->flags |= MPOL_F_LOCAL;
> > +		} else {
> > +			/*
> > +			 * If there is no valid node, change the mode to
> > +			 * MPOL_LOCAL, which will be restored back when
> > +			 * next rebind() sees a valid node.
> > +			 */
> > +			pol->mode = MPOL_LOCAL;
> > +			pol->flags |= MPOL_F_LOCAL_TEMP;
> > +		}
> >  	} else if (pol->flags & MPOL_F_RELATIVE_NODES) {
> >  		mpol_relative_nodemask(&tmp, &pol->w.user_nodemask, nodes);
> >  		pol->v.preferred_node = first_node(tmp);
> > -	} else if (!(pol->flags & MPOL_F_LOCAL)) {
> > +	} else {
> >  		pol->v.preferred_node = node_remap(pol->v.preferred_node,
> >  						   pol->w.cpuset_mems_allowed,
> >  						   *nodes);
> > @@ -372,7 +394,7 @@ static void mpol_rebind_policy(struct mempolicy *pol, const nodemask_t *newmask)
> >  {
> >  	if (!pol)
> >  		return;
> > -	if (!mpol_store_user_nodemask(pol) && !(pol->flags & MPOL_F_LOCAL) &&
> > +	if (!mpol_store_user_nodemask(pol) &&
> >  	    nodes_equal(pol->w.cpuset_mems_allowed, *newmask))
> >  		return;
> >  
> > @@ -425,7 +447,7 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
> >  	},
> >  	[MPOL_LOCAL] = {
> >  		.create = mpol_new_local,
> > -		.rebind = mpol_rebind_default,
> > +		.rebind = mpol_rebind_local,
> >  	},
> >  };
> -- 
> Michal Hocko
> SUSE Labs
