Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A85835E00B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 15:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242081AbhDMN1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 09:27:38 -0400
Received: from outbound-smtp13.blacknight.com ([46.22.139.230]:45593 "EHLO
        outbound-smtp13.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239438AbhDMN1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 09:27:32 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp13.blacknight.com (Postfix) with ESMTPS id C7FC61C399E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 14:27:11 +0100 (IST)
Received: (qmail 18223 invoked from network); 13 Apr 2021 13:27:11 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 13 Apr 2021 13:27:11 -0000
Date:   Tue, 13 Apr 2021 14:27:09 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 01/11] mm/page_alloc: Split per cpu page lists and zone
 stats
Message-ID: <20210413132708.GD3697@techsingularity.net>
References: <20210407202423.16022-1-mgorman@techsingularity.net>
 <20210407202423.16022-2-mgorman@techsingularity.net>
 <81cf880c-826e-6bbf-3af0-22d7aa2d3075@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <81cf880c-826e-6bbf-3af0-22d7aa2d3075@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 07:43:18PM +0200, Vlastimil Babka wrote:
> On 4/7/21 10:24 PM, Mel Gorman wrote:
> > @@ -6691,7 +6697,7 @@ static __meminit void zone_pcp_init(struct zone *zone)
> >  	 * relies on the ability of the linker to provide the
> >  	 * offset of a (static) per cpu variable into the per cpu area.
> >  	 */
> > -	zone->pageset = &boot_pageset;
> > +	zone->per_cpu_pageset = &boot_pageset;
> 
> I don't see any &boot_zonestats assignment here in zone_pcp_init() or its
> caller(s), which seems strange, as zone_pcp_reset() does it.
> 

Yes, it's required, well spotted!

-- 
Mel Gorman
SUSE Labs
