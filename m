Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D858E393282
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 17:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236124AbhE0Pgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 11:36:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:49616 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236083AbhE0Pgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 11:36:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622129697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=skSx5sYGBpIEBImjjBhZmKlc5nXzPfnPk6dSLZuNQd4=;
        b=SQzth1qkiCZQ0J0Gkc81V1beK0rQVIS+1iG4kPoo7bqYTsVtkCb/oTfl6wjp2GhUe2Q4IR
        33gcsj1EcTv3vIKowjbWCr35Mz544DUeUJ9bkCmJIpun/5b402Znr8XbYMXXejlC+2JTjh
        2MIPkM9QcXj0WStrB8KlEyO2eqaZ5K8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 708F2AEB3;
        Thu, 27 May 2021 15:34:57 +0000 (UTC)
Date:   Thu, 27 May 2021 17:34:56 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
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
Message-ID: <YK+8IAphFzbCweHI@dhcp22.suse.cz>
References: <1622005302-23027-1-git-send-email-feng.tang@intel.com>
 <1622005302-23027-5-git-send-email-feng.tang@intel.com>
 <YK9WOKBRsaFESPfR@dhcp22.suse.cz>
 <20210527121041.GA7743@shbuild999.sh.intel.com>
 <YK+P8GDH2kn4FDsA@dhcp22.suse.cz>
 <20210527133436.GD7743@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527133436.GD7743@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 27-05-21 21:34:36, Feng Tang wrote:
> On Thu, May 27, 2021 at 02:26:24PM +0200, Michal Hocko wrote:
> > On Thu 27-05-21 20:10:41, Feng Tang wrote:
> > > On Thu, May 27, 2021 at 10:20:08AM +0200, Michal Hocko wrote:
> > > > On Wed 26-05-21 13:01:42, Feng Tang wrote:
> > > > > Now the only remaining case of a real 'local' policy faked by
> > > > > 'prefer' policy plus MPOL_F_LOCAL bit is:
> > > > > 
> > > > > A valid 'prefer' policy with a valid 'preferred' node is 'rebind'
> > > > > to a nodemask which doesn't contains the 'preferred' node, then it
> > > > > will handle allocation with 'local' policy.
> > > > > 
> > > > > Add a new 'MPOL_F_LOCAL_TEMP' bit for this case, and kill the
> > > > > MPOL_F_LOCAL bit, which could simplify the code much.
> > > > 
> > > > As I've pointed out in the reply to the previous patch. It would have
> > > > been much better if most of the MPOL_F_LOCAL usage was gone by this
> > > > patch.
> > > > 
> > > > I also dislike a new MPOL_F_LOCAL_TEMP. This smells like sneaking the
> > > > hack back in after you have painstakingly removed it. So this looks like
> > > > a step backwards to me. I also do not understand why do we need the
> > > > rebind callback for local policy at all. There is no node mask for local
> > > > so what is going on here?
> > > 
> > > This is the special case 4 for 'perfer' policy with MPOL_F_STATIC_NODES
> > > flag set, say it prefer node 1, when it is later 'refind' to a new
> > > nodemask node 2-3, according to current code it will be add the
> > > MPOL_F_LOCAL bit and performs 'local' policy acctually. And in future
> > > it is 'rebind' again with a nodemask 1-2, it will be restored back
> > > to 'prefer' policy with preferred node 1.
> > 
> > Honestly I still do not follow the actual problem. 
> 
> I was confused too, and don't know the original thought behind it. This
> case 4 was just imagined by reading the code.
> 
> > A preferred node is a
> > _hint_. If you rebind the task to a different cpuset then why should we
> > actually care? The allocator will fallback to the closest node according
> > to the distance metric. Maybe the original code was trying to handle
> > that in some way but I really do fail to understand that code and I
> > strongly suspect it is more likely to overengineered rather than backed
> > by a real usecase. I might be wrong here but then this is an excellent
> > opportunity to clarify all those subtleties.
> 
> From the code, the original special handling may be needed in 3 cases:
>     get_policy_nodemask()
>     policy_node()
>     mempolicy_slab_node()
> to not return the preset prefer_nid.

I am sorry but I do not follow. What is actually wrong if the preferred
node is outside of the cpuset nodemask?
-- 
Michal Hocko
SUSE Labs
