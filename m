Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9739839721A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 13:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbhFALK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 07:10:28 -0400
Received: from mga11.intel.com ([192.55.52.93]:16518 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231219AbhFALK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 07:10:26 -0400
IronPort-SDR: iv4FKoFhV9tIbPibXAFs3a+IQAHlE6WS5KWUTo8IU6Dc5j0xqBbS/wfTKSyfDgA/jcXZ1cuJlx
 JxfdxvJwmkTg==
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="200510080"
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; 
   d="scan'208";a="200510080"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 04:08:44 -0700
IronPort-SDR: kuBULUmzQxRZZ6m5fV2NZo++ODvobELojOZ+fB0orlkmkw812jg+hIZDBoH9idXMRIy4o56jnt
 br+KsKLRVftQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; 
   d="scan'208";a="479239314"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by orsmga001.jf.intel.com with ESMTP; 01 Jun 2021 04:08:40 -0700
Date:   Tue, 1 Jun 2021 19:08:40 +0800
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
Subject: Re: [v3 PATCH 1/3] mm/mempolicy: cleanup nodemask intersection check
 for oom
Message-ID: <20210601110840.GA80730@shbuild999.sh.intel.com>
References: <1622469956-82897-1-git-send-email-feng.tang@intel.com>
 <1622469956-82897-2-git-send-email-feng.tang@intel.com>
 <YLXtjRYUcaXcYfua@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLXtjRYUcaXcYfua@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 10:19:25AM +0200, Michal Hocko wrote:
> On Mon 31-05-21 22:05:54, Feng Tang wrote:
> > mempolicy_nodemask_intersects() is used in oom case to check if a
> > task may have memory allocated on some memory nodes.
> > 
> > As it's only used by OOM check, rename it to mempolicy_in_oom_domain()
> > to reduce confusion.
> > 
> > As only for 'bind' policy, the nodemask is a force requirement for
> > from where to allocate memory, only do the intesection check for it,
> > and return true for all other policies.
> 
> I would slightly rephrase the above to
> "
> mempolicy_nodemask_intersects seem to be a general purpose mempolicy
> function. In fact it is partially tailored for the OOM purpose instead.
> The oom proper is the only existing user so rename the function to make
> that purpose explicit.
> 
> While at it drop the MPOL_INTERLEAVE as those allocations never has a
> nodemask defined (see alloc_page_interleave) so this is a dead code
> and a confusing one because MPOL_INTERLEAVE is a hint rather than a hard
> requirement so it shouldn't be considered during the OOM.
> 
> The final code can be reduced to a check for MPOL_BIND which is the only
> memory policy that is a hard requirement and thus relevant to a
> constrained OOM logic.
> "

This is much clearer, thanks!

Will change this and the descrition in over-letter.

> > Suggested-by: Michal Hocko <mhocko@suse.com>
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> 
> To the change itself
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

- Feng
