Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8454832BFFC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580601AbhCCSec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:34:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:50594 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242699AbhCCRPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 12:15:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614791673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q26pRxbPLPeAXKwpbYB/VBIDOB+tOVBn79NxDJnUl5g=;
        b=ulDJEW5PWSWbah35Ay3Wzr14xuwpkgj3FXThrmpCCRfgSUMued8Gv0LNVopopO5FUrIHLH
        BBJzcRQVexqqI5ctshpuqwBeBGVigHx/Ykxm6dV4E7CWvY1g/uLSmTRpyMWnIxEvgtfEMP
        CmporA3rIxsdAc8vzRKMJrU+6vTrqdk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2B89BACBC;
        Wed,  3 Mar 2021 17:14:33 +0000 (UTC)
Date:   Wed, 3 Mar 2021 18:14:30 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Andi leen <ak@linux.intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 RFC 14/14] mm: speedup page alloc for
 MPOL_PREFERRED_MANY by adding a NO_SLOWPATH gfp bit
Message-ID: <YD/D9hckPOA+41+D@dhcp22.suse.cz>
References: <1614766858-90344-1-git-send-email-feng.tang@intel.com>
 <1614766858-90344-15-git-send-email-feng.tang@intel.com>
 <YD91jTMssJUCupJm@dhcp22.suse.cz>
 <20210303120717.GA16736@shbuild999.sh.intel.com>
 <20210303121833.GB16736@shbuild999.sh.intel.com>
 <YD+BvvM/388AVnmm@dhcp22.suse.cz>
 <20210303131832.GB78458@shbuild999.sh.intel.com>
 <20210303134644.GC78458@shbuild999.sh.intel.com>
 <YD+WR5cpuWhybm2L@dhcp22.suse.cz>
 <20210303163141.v5wu2sfo2zj2qqsw@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303163141.v5wu2sfo2zj2qqsw@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 03-03-21 08:31:41, Ben Widawsky wrote:
> On 21-03-03 14:59:35, Michal Hocko wrote:
> > On Wed 03-03-21 21:46:44, Feng Tang wrote:
> > > On Wed, Mar 03, 2021 at 09:18:32PM +0800, Tang, Feng wrote:
> > > > On Wed, Mar 03, 2021 at 01:32:11PM +0100, Michal Hocko wrote:
> > > > > On Wed 03-03-21 20:18:33, Feng Tang wrote:
> > [...]
> > > > > > One thing I tried which can fix the slowness is:
> > > > > > 
> > > > > > +	gfp_mask &= ~(__GFP_DIRECT_RECLAIM | __GFP_KSWAPD_RECLAIM);
> > > > > > 
> > > > > > which explicitly clears the 2 kinds of reclaim. And I thought it's too
> > > > > > hacky and didn't mention it in the commit log.
> > > > > 
> > > > > Clearing __GFP_DIRECT_RECLAIM would be the right way to achieve
> > > > > GFP_NOWAIT semantic. Why would you want to exclude kswapd as well? 
> > > > 
> > > > When I tried gfp_mask &= ~__GFP_DIRECT_RECLAIM, the slowness couldn't
> > > > be fixed.
> > > 
> > > I just double checked by rerun the test, 'gfp_mask &= ~__GFP_DIRECT_RECLAIM'
> > > can also accelerate the allocation much! though is still a little slower than
> > > this patch. Seems I've messed some of the tries, and sorry for the confusion!
> > > 
> > > Could this be used as the solution? or the adding another fallback_nodemask way?
> > > but the latter will change the current API quite a bit.
> > 
> > I haven't got to the whole series yet. The real question is whether the
> > first attempt to enforce the preferred mask is a general win. I would
> > argue that it resembles the existing single node preferred memory policy
> > because that one doesn't push heavily on the preferred node either. So
> > dropping just the direct reclaim mode makes some sense to me.
> > 
> > IIRC this is something I was recommending in an early proposal of the
> > feature.
> 
> My assumption [FWIW] is that the usecases we've outlined for multi-preferred
> would want more heavy pushing on the preference mask. However, maybe the uapi
> could dictate how hard to try/not try.

What does that mean and what is the expectation from the kernel to be
more or less cast in stone?

-- 
Michal Hocko
SUSE Labs
