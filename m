Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FCA3A4E1F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 12:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhFLKJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 06:09:10 -0400
Received: from outbound-smtp22.blacknight.com ([81.17.249.190]:48974 "EHLO
        outbound-smtp22.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229584AbhFLKJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 06:09:09 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp22.blacknight.com (Postfix) with ESMTPS id 9859ABAB48
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 11:07:08 +0100 (IST)
Received: (qmail 3549 invoked from network); 12 Jun 2021 10:07:08 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Jun 2021 10:07:08 -0000
Date:   Sat, 12 Jun 2021 11:07:06 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Zi Yan <ziy@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v2] mm/page_alloc: Allow high-order pages to be stored on
 the per-cpu lists
Message-ID: <20210612100706.GE30378@techsingularity.net>
References: <20210611135753.GC30378@techsingularity.net>
 <20210611162331.272f67eabffa491fc83798b4@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210611162331.272f67eabffa491fc83798b4@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 04:23:31PM -0700, Andrew Morton wrote:
> > +static inline int pindex_to_order(unsigned int pindex)
> > +{
> > +	int order = pindex / MIGRATE_PCPTYPES;
> > +
> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > +	if (order > PAGE_ALLOC_COSTLY_ORDER) {
> > +		order = pageblock_order;
> > +		VM_BUG_ON(order != pageblock_order);
> 
> Somebody has trust issues?
> 

Just a little bit :P

> > +	}
> > +#else
> > +	VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
> > +#endif
> > +
> > +	return order;
> > +}
> 
> Do we really need all these assertions, long-term?
> 

No, definitely not. Even now it's but already the patch caught me by
surprise (breaking kvm boot) so I'd like to leave them in for at least
one release given the number of changes queued in your tree for the next
merge window.

Thanks.

-- 
Mel Gorman
SUSE Labs
