Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF39446888
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 19:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbhKESkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 14:40:46 -0400
Received: from mga09.intel.com ([134.134.136.24]:56967 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232660AbhKESko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 14:40:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10159"; a="231803574"
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="231803574"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 11:38:04 -0700
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="490420361"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 11:38:03 -0700
Date:   Fri, 5 Nov 2021 11:38:03 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Prathu Baronia <prathubaronia2011@gmail.com>,
        linux-kernel@vger.kernel.org, chintan.pandya@oneplus.com,
        Prathu Baronia <prathu.baronia@oneplus.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v4 1/1] mm/highmem: Remove deprecated kmap_atomic
Message-ID: <20211105183803.GB3538886@iweiny-DESK2.sc.intel.com>
References: <20210204073255.20769-1-prathu.baronia@oneplus.com>
 <20210204073255.20769-2-prathu.baronia@oneplus.com>
 <20210211003307.GA3158182@iweiny-DESK2.sc.intel.com>
 <20210211155625.7f8dd5d53e19f88530ddf248@linux-foundation.org>
 <YYU2YSOGHJFIrzmm@casper.infradead.org>
 <YYVhHCJcm2DM2G9u@casper.infradead.org>
 <20211105165859.GA3538886@iweiny-DESK2.sc.intel.com>
 <YYVofyW3txoT9RLM@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYVofyW3txoT9RLM@casper.infradead.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 05:23:11PM +0000, Matthew Wilcox wrote:
> On Fri, Nov 05, 2021 at 09:58:59AM -0700, Ira Weiny wrote:
> > On Fri, Nov 05, 2021 at 04:51:40PM +0000, Matthew Wilcox wrote:
> > > On Fri, Nov 05, 2021 at 01:50:37PM +0000, Matthew Wilcox wrote:
> > > > On Thu, Feb 11, 2021 at 03:56:25PM -0800, Andrew Morton wrote:
> > > > > On Wed, 10 Feb 2021 16:33:07 -0800 Ira Weiny <ira.weiny@intel.com> wrote:
> > > > > 
> > > > > > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > > > > 
> > > > > > This already has my signed off by so I'm not going to 'review'.  With Prathu's
> > > > > > testing information I hope this can land.
> > > > > > 
> > > > > > Andrew did you see this patch?
> > > > > 
> > > > > I did now ;)
> > > > > 
> > > > > Tossed onto the post-rc1 pile, thanks,
> > > > 
> > > > This patch seems to have slipped through the gaps for a couple of cycles
> > > > now?  I found a missed spot in it for CONFIG_HIGHMEM:
> > > 
> > > Ugh, sorry, wrong version of the patch.
> > 
> > Check!  Yea this works for me...
> > 
> > I think this should to through as a separate patch because Prathu's has been
> > soaking for some time.  No need to complicate it with this.
> 
> This isn't "complicating Prathu's patch".  This is "fixing up the bit
> that Prathu missed with his patch".  zero_user_segments() should not
> have different rules on HIGHMEM and non-HIGHMEM kernels.
 
What do you mean by 'different rules'?

Oh I see...  Ok yea.

Well this should not be a big deal...

Ira
