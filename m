Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA91392F61
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 15:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbhE0NYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 09:24:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:1977 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236268AbhE0NYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 09:24:31 -0400
IronPort-SDR: 32llE6JAEmgZLaVgkGuoHz6LEIxF0vCw6siuo1ZOPi8KgvXqir+U5jBNt1aSOfed9aQrUqz9eh
 Lca6h4XwABmw==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="288318936"
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="288318936"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 06:22:56 -0700
IronPort-SDR: kCrSAePdirl8WUUcA3KxO+WRkWMqXM3aqQaAYg3nO21XpAdwopT6A42VX9PV3/L2pT9cP3cjLO
 ih1+dsndgZoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="445012012"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by fmsmga008.fm.intel.com with ESMTP; 27 May 2021 06:22:53 -0700
Date:   Thu, 27 May 2021 21:22:52 +0800
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
Subject: Re: [PATCH v1 1/4] mm/mempolicy: skip nodemask intersect check for
 'interleave' when oom
Message-ID: <20210527132252.GA43221@shbuild999.sh.intel.com>
References: <1622005302-23027-1-git-send-email-feng.tang@intel.com>
 <1622005302-23027-2-git-send-email-feng.tang@intel.com>
 <YK9KeOmXhuuZMEHy@dhcp22.suse.cz>
 <20210527130501.GC7743@shbuild999.sh.intel.com>
 <YK+bWP5TalB50v0S@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK+bWP5TalB50v0S@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 03:15:04PM +0200, Michal Hocko wrote:
> On Thu 27-05-21 21:05:01, Feng Tang wrote:
> > On Thu, May 27, 2021 at 09:30:00AM +0200, Michal Hocko wrote:
> [...]
> > > Until now this was not a real problem even for OOM context because
> > > alloc_page_interleave is always used for the interleaving policy
> > > and that one doesn't use any node mask so the code is not really
> > > exercised. With your MPOL_PREFERRED this would no longer be the case.
> >  
> > Given the 'interleave' task may have memory allocated from all nodes,
> > shouldn't the mempolicy_nodemask_intersects() return true for 'interleave'?
> > or I'm still missing something?
> 
> Well, if you go with the renaming then it should be quite obvious that
> any policies which are not a hard binding should return true. 

Ok, will do the rename. thanks for clarifying!

- Feng

> -- 
> Michal Hocko
> SUSE Labs
