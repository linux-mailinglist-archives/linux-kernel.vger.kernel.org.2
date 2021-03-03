Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEED32BDF5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385049AbhCCQkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 11:40:35 -0500
Received: from mga06.intel.com ([134.134.136.31]:61662 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233276AbhCCMI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 07:08:58 -0500
IronPort-SDR: BSUb33kdaXXbWOvoF8D9SVQB4nyCX2RiIWiPdS1HlGywuLA+LGe2hfjxSlDYbEE9TLQJmkoHYn
 W11N2ymVL3sQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="248584691"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="248584691"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 04:07:21 -0800
IronPort-SDR: I52DGwf/24g4kchq4aEhWgOB3JotnW/SMkIuBQylgh2WGK7slV5xmQhYOKNPwvFbY/XAPQ4awF
 50YHZlh8EvoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="383962001"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.165])
  by orsmga002.jf.intel.com with ESMTP; 03 Mar 2021 04:07:17 -0800
Date:   Wed, 3 Mar 2021 20:07:17 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
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
        Andi leen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 RFC 14/14] mm: speedup page alloc for
 MPOL_PREFERRED_MANY by adding a NO_SLOWPATH gfp bit
Message-ID: <20210303120717.GA16736@shbuild999.sh.intel.com>
References: <1614766858-90344-1-git-send-email-feng.tang@intel.com>
 <1614766858-90344-15-git-send-email-feng.tang@intel.com>
 <YD91jTMssJUCupJm@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YD91jTMssJUCupJm@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Wed, Mar 03, 2021 at 12:39:57PM +0100, Michal Hocko wrote:
> On Wed 03-03-21 18:20:58, Feng Tang wrote:
> > When doing broader test, we noticed allocation slowness in one test
> > case that malloc memory with size which is slightly bigger than free
> > memory of targeted nodes, but much less then the total free memory
> > of system.
> > 
> > The reason is the code enters the slowpath of __alloc_pages_nodemask(),
> > which takes quite some time. As alloc_pages_policy() will give it a 2nd
> > try with NULL nodemask, so there is no need to enter the slowpath for
> > the first try. Add a new gfp bit to skip the slowpath, so that user cases
> > like this can leverage.
> > 
> > With it, the malloc in such case is much accelerated as it never enters
> > the slowpath.
> > 
> > Adding a new gfp_mask bit is generally not liked, and another idea is to
> > add another nodemask to struct 'alloc_context', so it has 2: 'preferred-nmask'
> > and 'fallback-nmask', and they will be tried in turn if not NULL, with
> > it we can call __alloc_pages_nodemask() only once.
> 
> Yes, it is very much disliked. Is there any reason why you cannot use
> GFP_NOWAIT for that purpose?

I did try that at the first place, but it didn't obviously change the slowness.
I assumed the direct claim was still involved as GFP_NOWAIT only impact kswapd
reclaim.

Thanks,
Feng


> -- 
> Michal Hocko
> SUSE Labs
