Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE034392DFE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 14:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbhE0Mcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 08:32:53 -0400
Received: from mga17.intel.com ([192.55.52.151]:42405 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234809AbhE0Mcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 08:32:52 -0400
IronPort-SDR: Zk/T78q+dUJ/tSzkJwKMOr2+90FsTzUMu19/i4EwUMjx3sos+HZFCv8E9mwJCEeeEFKnRXqmfw
 mrl78Qnm7JvQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="183055686"
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="183055686"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 05:31:18 -0700
IronPort-SDR: jmoxIXcIfQT0DREIICnlWr7O6I0fUXakADm4PXnDMea8QXGI/mXODP6Ov4mQl/qKfPzDPoZiBZ
 ZlfEy3ZEuihw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="443545354"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by orsmga008.jf.intel.com with ESMTP; 27 May 2021 05:31:14 -0700
Date:   Thu, 27 May 2021 20:31:13 +0800
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
Subject: Re: [PATCH v1 2/4] mm/mempolicy: unify the preprocessing for mbind
 and set_mempolicy
Message-ID: <20210527123113.GB7743@shbuild999.sh.intel.com>
References: <1622005302-23027-1-git-send-email-feng.tang@intel.com>
 <1622005302-23027-3-git-send-email-feng.tang@intel.com>
 <YK9MxT8Bwt/TnqWa@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK9MxT8Bwt/TnqWa@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 09:39:49AM +0200, Michal Hocko wrote:
> On Wed 26-05-21 13:01:40, Feng Tang wrote:
> > Currently the kernel_mbind() and kernel_set_mempolicy() do almost
> > the same operation for parameter sanity check and preprocessing.
> > 
> > Add a helper function to unify the code to reduce the redundancy,
> > and make it easier for changing the pre-processing code in future.
> > 
> > [thanks to David Rientjes for suggesting using helper function
> > instead of macro]
> 
> I appreciate removing the code duplication but I am not really convinced
> this is an improvement. You are conflating two things. One is the mpol
> flags checking and node mask copying. While abstracting the first one
> makes sense to me the later is already a single line of code that makes
> your helper unnecessarily complex. So I would go with sanitize_mpol_flags
> and put a flags handling there and leave get_nodes alone.
>  
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > ---
> >  mm/mempolicy.c | 43 ++++++++++++++++++++++++-------------------
> >  1 file changed, 24 insertions(+), 19 deletions(-)
> 
> Funny how removing code duplication adds more code than it removes ;)

Yes.

And in last verion which uses macro to unify the code: 
https://lore.kernel.org/lkml/1621499404-67756-3-git-send-email-feng.tang@intel.com/
it does save some lines :)

 mm/mempolicy.c | 46 +++++++++++++++++++---------------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

Thanks,
Feng

> > 
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 1964cca..2830bb8 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -1460,6 +1460,20 @@ static int copy_nodes_to_user(unsigned long __user *mask, unsigned long maxnode,
> >  	return copy_to_user(mask, nodes_addr(*nodes), copy) ? -EFAULT : 0;
> >  }
> >  
> > +static inline int mpol_pre_process(int *mode, const unsigned long __user *nmask, unsigned long maxnode, nodemask_t *nodes, unsigned short *flags)
> > +{
> > +	int ret;
> > +
> > +	*flags = *mode & MPOL_MODE_FLAGS;
> > +	*mode &= ~MPOL_MODE_FLAGS;
> > +	if ((unsigned int)(*mode) >= MPOL_MAX)
> > +		return -EINVAL;
> > +	if ((*flags & MPOL_F_STATIC_NODES) && (*flags & MPOL_F_RELATIVE_NODES))
> > +		return -EINVAL;
> > +	ret = get_nodes(nodes, nmask, maxnode);
> > +	return ret;
> > +}
> > +
> >  static long kernel_mbind(unsigned long start, unsigned long len,
> >  			 unsigned long mode, const unsigned long __user *nmask,
> >  			 unsigned long maxnode, unsigned int flags)
> > @@ -1467,19 +1481,14 @@ static long kernel_mbind(unsigned long start, unsigned long len,
> >  	nodemask_t nodes;
> >  	int err;
> >  	unsigned short mode_flags;
> > +	int lmode = mode;
> >  
> > -	start = untagged_addr(start);
> > -	mode_flags = mode & MPOL_MODE_FLAGS;
> > -	mode &= ~MPOL_MODE_FLAGS;
> > -	if (mode >= MPOL_MAX)
> > -		return -EINVAL;
> > -	if ((mode_flags & MPOL_F_STATIC_NODES) &&
> > -	    (mode_flags & MPOL_F_RELATIVE_NODES))
> > -		return -EINVAL;
> > -	err = get_nodes(&nodes, nmask, maxnode);
> > +	err = mpol_pre_process(&lmode, nmask, maxnode, &nodes, &mode_flags);
> >  	if (err)
> >  		return err;
> > -	return do_mbind(start, len, mode, mode_flags, &nodes, flags);
> > +
> > +	start = untagged_addr(start);
> > +	return do_mbind(start, len, lmode, mode_flags, &nodes, flags);
> >  }
> >  
> >  SYSCALL_DEFINE6(mbind, unsigned long, start, unsigned long, len,
> > @@ -1495,18 +1504,14 @@ static long kernel_set_mempolicy(int mode, const unsigned long __user *nmask,
> >  {
> >  	int err;
> >  	nodemask_t nodes;
> > -	unsigned short flags;
> > +	unsigned short mode_flags;
> > +	int lmode = mode;
> >  
> > -	flags = mode & MPOL_MODE_FLAGS;
> > -	mode &= ~MPOL_MODE_FLAGS;
> > -	if ((unsigned int)mode >= MPOL_MAX)
> > -		return -EINVAL;
> > -	if ((flags & MPOL_F_STATIC_NODES) && (flags & MPOL_F_RELATIVE_NODES))
> > -		return -EINVAL;
> > -	err = get_nodes(&nodes, nmask, maxnode);
> > +	err = mpol_pre_process(&lmode, nmask, maxnode, &nodes, &mode_flags);
> >  	if (err)
> >  		return err;
> > -	return do_set_mempolicy(mode, flags, &nodes);
> > +
> > +	return do_set_mempolicy(lmode, mode_flags, &nodes);
> >  }
> >  
> >  SYSCALL_DEFINE3(set_mempolicy, int, mode, const unsigned long __user *, nmask,
> > -- 
> > 2.7.4
> 
> -- 
> Michal Hocko
> SUSE Labs
