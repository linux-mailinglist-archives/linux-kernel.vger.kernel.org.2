Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0C638E339
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 11:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbhEXJ1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 05:27:02 -0400
Received: from outbound-smtp46.blacknight.com ([46.22.136.58]:60141 "EHLO
        outbound-smtp46.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232318AbhEXJ1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 05:27:01 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp46.blacknight.com (Postfix) with ESMTPS id 7FF62FA8A2
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 10:25:32 +0100 (IST)
Received: (qmail 26618 invoked from network); 24 May 2021 09:25:32 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 24 May 2021 09:25:32 -0000
Date:   Mon, 24 May 2021 10:25:30 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] mm/page_alloc: Introduce
 vm.percpu_pagelist_high_fraction
Message-ID: <20210524092530.GE30378@techsingularity.net>
References: <20210521102826.28552-1-mgorman@techsingularity.net>
 <20210521102826.28552-7-mgorman@techsingularity.net>
 <ab7cbd43-7952-ca23-0a5c-379dfcfb14ba@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <ab7cbd43-7952-ca23-0a5c-379dfcfb14ba@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 03:57:20PM -0700, Dave Hansen wrote:
> On 5/21/21 3:28 AM, Mel Gorman wrote:
> > This introduces a new sysctl vm.percpu_pagelist_high_fraction. It is
> > similar to the old vm.percpu_pagelist_fraction except it only adjusts
> > pcp->high to potentially reduce zone->lock contention while preserving
> > allocation latency when PCP lists have to be refilled.
> 
> Look at me...  Five patches later and I already forgot what the old one
> did and why it stinks.  I wonder if you might do a wee bit of compare
> and contrast.  Something like:
> 
> 	The old vm.percpu_pagelist_fraction increased both the batch and
> 	high limits for the per-cpu page allocator.  Its worst feature
> 	was that it led to absurdly large batch sizes that incurred
> 	nasty worst-case allocation latency.
> 
> 	This new sysctl in comparison...
> 
> Anyway, the approach looks sound to me.  The batch size isn't important
> now, especially given the auto-scaling in patch 4.
> 
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

Thanks, I updated the changelog and hopefully it is better.

-- 
Mel Gorman
SUSE Labs
