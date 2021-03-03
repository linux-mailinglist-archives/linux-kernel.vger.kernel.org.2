Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B8232C084
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579605AbhCCSbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:31:39 -0500
Received: from mga18.intel.com ([134.134.136.126]:38123 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237191AbhCCQcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 11:32:36 -0500
IronPort-SDR: Tu6Ha1ASxdEbpU8QwFuSFx2LJJO3vXyeBZU+fWvsYHWnwzlSQRJQ+rz0naQBcVph8Q+ZDJG0Ew
 Vcvk81uI/zOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="174868592"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="174868592"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 08:31:43 -0800
IronPort-SDR: J1UeOUl5u6xfU8M0uMOUSh4yNCzAjMWgs2o/esffwgKbM8LsqKZwkguO6s1cM/rWwsm1BqPQj3
 TOsq5mfKhLTA==
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="369442522"
Received: from tsaijane-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.136.84])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 08:31:42 -0800
Date:   Wed, 3 Mar 2021 08:31:41 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Michal Hocko <mhocko@suse.com>
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
Message-ID: <20210303163141.v5wu2sfo2zj2qqsw@intel.com>
Mail-Followup-To: Michal Hocko <mhocko@suse.com>,
        Feng Tang <feng.tang@intel.com>,
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
References: <1614766858-90344-1-git-send-email-feng.tang@intel.com>
 <1614766858-90344-15-git-send-email-feng.tang@intel.com>
 <YD91jTMssJUCupJm@dhcp22.suse.cz>
 <20210303120717.GA16736@shbuild999.sh.intel.com>
 <20210303121833.GB16736@shbuild999.sh.intel.com>
 <YD+BvvM/388AVnmm@dhcp22.suse.cz>
 <20210303131832.GB78458@shbuild999.sh.intel.com>
 <20210303134644.GC78458@shbuild999.sh.intel.com>
 <YD+WR5cpuWhybm2L@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YD+WR5cpuWhybm2L@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-03-03 14:59:35, Michal Hocko wrote:
> On Wed 03-03-21 21:46:44, Feng Tang wrote:
> > On Wed, Mar 03, 2021 at 09:18:32PM +0800, Tang, Feng wrote:
> > > On Wed, Mar 03, 2021 at 01:32:11PM +0100, Michal Hocko wrote:
> > > > On Wed 03-03-21 20:18:33, Feng Tang wrote:
> [...]
> > > > > One thing I tried which can fix the slowness is:
> > > > > 
> > > > > +	gfp_mask &= ~(__GFP_DIRECT_RECLAIM | __GFP_KSWAPD_RECLAIM);
> > > > > 
> > > > > which explicitly clears the 2 kinds of reclaim. And I thought it's too
> > > > > hacky and didn't mention it in the commit log.
> > > > 
> > > > Clearing __GFP_DIRECT_RECLAIM would be the right way to achieve
> > > > GFP_NOWAIT semantic. Why would you want to exclude kswapd as well? 
> > > 
> > > When I tried gfp_mask &= ~__GFP_DIRECT_RECLAIM, the slowness couldn't
> > > be fixed.
> > 
> > I just double checked by rerun the test, 'gfp_mask &= ~__GFP_DIRECT_RECLAIM'
> > can also accelerate the allocation much! though is still a little slower than
> > this patch. Seems I've messed some of the tries, and sorry for the confusion!
> > 
> > Could this be used as the solution? or the adding another fallback_nodemask way?
> > but the latter will change the current API quite a bit.
> 
> I haven't got to the whole series yet. The real question is whether the
> first attempt to enforce the preferred mask is a general win. I would
> argue that it resembles the existing single node preferred memory policy
> because that one doesn't push heavily on the preferred node either. So
> dropping just the direct reclaim mode makes some sense to me.
> 
> IIRC this is something I was recommending in an early proposal of the
> feature.

My assumption [FWIW] is that the usecases we've outlined for multi-preferred
would want more heavy pushing on the preference mask. However, maybe the uapi
could dictate how hard to try/not try.
