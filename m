Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C4D392FD4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 15:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236513AbhE0NgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 09:36:20 -0400
Received: from mga03.intel.com ([134.134.136.65]:45779 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235751AbhE0NgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 09:36:19 -0400
IronPort-SDR: sTE+1sS++b1W7JcwWOErhXmVrxnN40Eb705s010dbmnIM788Xe4rKWx1fIBInw1uNWLWK9vLvS
 QgjCpzRBH1EA==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="202767538"
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="202767538"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 06:34:42 -0700
IronPort-SDR: FWcnpGsV/3EM1TRBlZcvi/Q7p/9r0V0NT2prtrJY2JYJ2s0o+ZKZ74rmvOdF+f38llij4ZD8cu
 pRDfKlmJbEZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="480581513"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by fmsmga002.fm.intel.com with ESMTP; 27 May 2021 06:34:37 -0700
Date:   Thu, 27 May 2021 21:34:36 +0800
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
Message-ID: <20210527133436.GD7743@shbuild999.sh.intel.com>
References: <1622005302-23027-1-git-send-email-feng.tang@intel.com>
 <1622005302-23027-5-git-send-email-feng.tang@intel.com>
 <YK9WOKBRsaFESPfR@dhcp22.suse.cz>
 <20210527121041.GA7743@shbuild999.sh.intel.com>
 <YK+P8GDH2kn4FDsA@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK+P8GDH2kn4FDsA@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 02:26:24PM +0200, Michal Hocko wrote:
> On Thu 27-05-21 20:10:41, Feng Tang wrote:
> > On Thu, May 27, 2021 at 10:20:08AM +0200, Michal Hocko wrote:
> > > On Wed 26-05-21 13:01:42, Feng Tang wrote:
> > > > Now the only remaining case of a real 'local' policy faked by
> > > > 'prefer' policy plus MPOL_F_LOCAL bit is:
> > > > 
> > > > A valid 'prefer' policy with a valid 'preferred' node is 'rebind'
> > > > to a nodemask which doesn't contains the 'preferred' node, then it
> > > > will handle allocation with 'local' policy.
> > > > 
> > > > Add a new 'MPOL_F_LOCAL_TEMP' bit for this case, and kill the
> > > > MPOL_F_LOCAL bit, which could simplify the code much.
> > > 
> > > As I've pointed out in the reply to the previous patch. It would have
> > > been much better if most of the MPOL_F_LOCAL usage was gone by this
> > > patch.
> > > 
> > > I also dislike a new MPOL_F_LOCAL_TEMP. This smells like sneaking the
> > > hack back in after you have painstakingly removed it. So this looks like
> > > a step backwards to me. I also do not understand why do we need the
> > > rebind callback for local policy at all. There is no node mask for local
> > > so what is going on here?
> > 
> > This is the special case 4 for 'perfer' policy with MPOL_F_STATIC_NODES
> > flag set, say it prefer node 1, when it is later 'refind' to a new
> > nodemask node 2-3, according to current code it will be add the
> > MPOL_F_LOCAL bit and performs 'local' policy acctually. And in future
> > it is 'rebind' again with a nodemask 1-2, it will be restored back
> > to 'prefer' policy with preferred node 1.
> 
> Honestly I still do not follow the actual problem. 

I was confused too, and don't know the original thought behind it. This
case 4 was just imagined by reading the code.

> A preferred node is a
> _hint_. If you rebind the task to a different cpuset then why should we
> actually care? The allocator will fallback to the closest node according
> to the distance metric. Maybe the original code was trying to handle
> that in some way but I really do fail to understand that code and I
> strongly suspect it is more likely to overengineered rather than backed
> by a real usecase. I might be wrong here but then this is an excellent
> opportunity to clarify all those subtleties.

From the code, the original special handling may be needed in 3 cases:
    get_policy_nodemask()
    policy_node()
    mempolicy_slab_node()
to not return the preset prefer_nid.

Thanks,
Feng

> -- 
> Michal Hocko
> SUSE Labs
