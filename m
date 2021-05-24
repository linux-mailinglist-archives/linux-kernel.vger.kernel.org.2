Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A0D38F12B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 18:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbhEXQKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 12:10:48 -0400
Received: from outbound-smtp02.blacknight.com ([81.17.249.8]:55614 "EHLO
        outbound-smtp02.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233704AbhEXQCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 12:02:33 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp02.blacknight.com (Postfix) with ESMTPS id 068C3BAA92
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 17:01:03 +0100 (IST)
Received: (qmail 432 invoked from network); 24 May 2021 16:01:02 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 24 May 2021 16:01:02 -0000
Date:   Mon, 24 May 2021 17:01:01 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] mm/page_alloc: Adjust pcp->high after CPU hotplug
 events
Message-ID: <20210524160101.GG30378@techsingularity.net>
References: <20210521102826.28552-1-mgorman@techsingularity.net>
 <20210521102826.28552-4-mgorman@techsingularity.net>
 <add15859-31e2-1688-3d8c-26e2579e9a57@intel.com>
 <20210524090726.GB30378@techsingularity.net>
 <e9061a5c-bbef-e818-94f7-95e21a73a948@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <e9061a5c-bbef-e818-94f7-95e21a73a948@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 08:52:02AM -0700, Dave Hansen wrote:
> > To address your point requires much deeper surgery.
> ...
> > There is value to doing something like this but it's beyond what this
> > series is trying to do and doing the work without introducing regressions
> > would be very difficult.
> 
> Agreed, such a solution is outside of the scope of what this set is
> trying to do.
> 
> It would be nice to touch on this counter-intuitive property in the
> changelog, and *maybe* add a WARN_ON_ONCE() if we hit an edge case.
> Maybe WARN_ON_ONCE() if pcp->high gets below pcp->batch*SOMETHING.
> 

I think it's reasonable to ensure pcp->batch is never above pcp->high so
I have this in zone_highsize now

+       /*
+        * Ensure high is at least batch*4. The multiple is based on the
+        * historical relationship between high and batch.
+        */
+       high = max(high, batch << 2);

Performance tests are running and I'll post a v2 assuming they pass.

-- 
Mel Gorman
SUSE Labs
