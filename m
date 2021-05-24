Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F0C38E0BF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 07:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbhEXGBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 02:01:13 -0400
Received: from mga18.intel.com ([134.134.136.126]:2921 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229633AbhEXGBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 02:01:11 -0400
IronPort-SDR: 32bSaxDLd4x7cF8zHkGSd9EUYybpnze77BLzKv+O0VVJYjueD9iICJKaDwOQlkNr10YZtWGgC5
 aFO+EJwq0k3g==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="189245562"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="189245562"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2021 22:59:43 -0700
IronPort-SDR: rB0cJg0zNoe7UcxKKtzFqnieMtgeEvNXAV1KYWXiZILMuNvfxJadrLmpqlhbLOo01pxRbRUcJ/
 fh6vzNWcDGLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="545735360"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by fmsmga001.fm.intel.com with ESMTP; 23 May 2021 22:59:39 -0700
Date:   Mon, 24 May 2021 13:59:39 +0800
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
Subject: Re: [RFC Patch v2 2/4] mm/mempolicy: unify the preprocessing for
 mbind and set_mempolicy
Message-ID: <20210524055939.GB48704@shbuild999.sh.intel.com>
References: <1621499404-67756-1-git-send-email-feng.tang@intel.com>
 <1621499404-67756-3-git-send-email-feng.tang@intel.com>
 <7a58082-eb68-744c-93b7-1a688b3b27a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a58082-eb68-744c-93b7-1a688b3b27a@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2021 at 10:16:11PM -0700, David Rientjes wrote:
> On Thu, 20 May 2021, Feng Tang wrote:
> 
> > Currently the kernel_mbind() and kernel_set_mempolicy() do almost
> > the same operation for parameter sanity check and preprocessing.
> > 
> > Add a macro to unify the code to reduce the redundancy, and make
> > it easier for changing the pre-processing code in future.
> > 
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > ---
> >  mm/mempolicy.c | 46 +++++++++++++++++++---------------------------
> >  1 file changed, 19 insertions(+), 27 deletions(-)
> > 
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 1964cca..0f5bf60 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -1460,25 +1460,29 @@ static int copy_nodes_to_user(unsigned long __user *mask, unsigned long maxnode,
> >  	return copy_to_user(mask, nodes_addr(*nodes), copy) ? -EFAULT : 0;
> >  }
> >  
> > +#define MPOL_PRE_PROCESS() \
> 
> This should be extracted to helper function returning bool, not a macro.

Yes, initially I did try it with an inline function, but as a function
it has quite several input parameters and several output parameters, 
which made the code still big and ugly.

But if community think it's the right direction to go, I can change it.

Thanks,
Feng

> > +	 \
> > +	nodemask_t nodes; \
> > +	int err; \
> > +	unsigned short mode_flags; \
> > +	mode_flags = mode & MPOL_MODE_FLAGS; \
> > +	mode &= ~MPOL_MODE_FLAGS; \
> > +	if (mode >= MPOL_MAX) \
> > +		return -EINVAL; \
> > +	if ((mode_flags & MPOL_F_STATIC_NODES) && \
> > +		(mode_flags & MPOL_F_RELATIVE_NODES)) \
> > +		return -EINVAL; \
> > +	err = get_nodes(&nodes, nmask, maxnode); \
> > +	if (err) \
> > +		return err;
> > +
> >  static long kernel_mbind(unsigned long start, unsigned long len,
> >  			 unsigned long mode, const unsigned long __user *nmask,
> >  			 unsigned long maxnode, unsigned int flags)
> >  {
> > -	nodemask_t nodes;
> > -	int err;
> > -	unsigned short mode_flags;
> > +	MPOL_PRE_PROCESS();
> >  
> >  	start = untagged_addr(start);
> > -	mode_flags = mode & MPOL_MODE_FLAGS;
> > -	mode &= ~MPOL_MODE_FLAGS;
> > -	if (mode >= MPOL_MAX)
> > -		return -EINVAL;
> > -	if ((mode_flags & MPOL_F_STATIC_NODES) &&
> > -	    (mode_flags & MPOL_F_RELATIVE_NODES))
> > -		return -EINVAL;
> > -	err = get_nodes(&nodes, nmask, maxnode);
> > -	if (err)
> > -		return err;
> >  	return do_mbind(start, len, mode, mode_flags, &nodes, flags);
> >  }
> >  
> > @@ -1493,20 +1497,8 @@ SYSCALL_DEFINE6(mbind, unsigned long, start, unsigned long, len,
> >  static long kernel_set_mempolicy(int mode, const unsigned long __user *nmask,
> >  				 unsigned long maxnode)
> >  {
> > -	int err;
> > -	nodemask_t nodes;
> > -	unsigned short flags;
> > -
> > -	flags = mode & MPOL_MODE_FLAGS;
> > -	mode &= ~MPOL_MODE_FLAGS;
> > -	if ((unsigned int)mode >= MPOL_MAX)
> > -		return -EINVAL;
> > -	if ((flags & MPOL_F_STATIC_NODES) && (flags & MPOL_F_RELATIVE_NODES))
> > -		return -EINVAL;
> > -	err = get_nodes(&nodes, nmask, maxnode);
> > -	if (err)
> > -		return err;
> > -	return do_set_mempolicy(mode, flags, &nodes);
> > +	MPOL_PRE_PROCESS();
> > +	return do_set_mempolicy(mode, mode_flags, &nodes);
> >  }
> >  
> >  SYSCALL_DEFINE3(set_mempolicy, int, mode, const unsigned long __user *, nmask,
> > -- 
> > 2.7.4
> > 
> > 
