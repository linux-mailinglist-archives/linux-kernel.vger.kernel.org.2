Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7F94467E1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 18:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbhKERaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 13:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbhKERaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 13:30:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DAFC061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 10:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ikNbSJ99xr2Kr/ZTq5/YSszI1SM0FEuVfH/ttjrSQLo=; b=hHPHwwCDi4A1OwAk96TAksMKM2
        ZqchjPJyPSftWWbEOdqKrEVEKlccM5RaomqMNLwxiStRyvK6AVFu7aJ28inzhs0QmdpyRF0F0hnEX
        o1nA3A6N8QMI9NPq9tDIkbP/8a5hi2eFy5mDUMjfoiE+ZrUGebxe25xKqPikba83imP5SS6lRYbFH
        BhelNQBa9EjAvWoN9BsWwGApSc47YdG0jllKVUYHsrICmiqgQGPot/ino4mvLFiSM5gpbckdsg1SN
        17o+74uJuAEhqvexcF4yRpQp8x9NX2+TvvGz9HxPOJ8I/krbdswWGpkokHZ3J7YWFTaWFByEx67xp
        ZuA9DDBg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mj2vn-006hl8-7K; Fri, 05 Nov 2021 17:24:16 +0000
Date:   Fri, 5 Nov 2021 17:23:11 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Prathu Baronia <prathubaronia2011@gmail.com>,
        linux-kernel@vger.kernel.org, chintan.pandya@oneplus.com,
        Prathu Baronia <prathu.baronia@oneplus.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v4 1/1] mm/highmem: Remove deprecated kmap_atomic
Message-ID: <YYVofyW3txoT9RLM@casper.infradead.org>
References: <20210204073255.20769-1-prathu.baronia@oneplus.com>
 <20210204073255.20769-2-prathu.baronia@oneplus.com>
 <20210211003307.GA3158182@iweiny-DESK2.sc.intel.com>
 <20210211155625.7f8dd5d53e19f88530ddf248@linux-foundation.org>
 <YYU2YSOGHJFIrzmm@casper.infradead.org>
 <YYVhHCJcm2DM2G9u@casper.infradead.org>
 <20211105165859.GA3538886@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105165859.GA3538886@iweiny-DESK2.sc.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 09:58:59AM -0700, Ira Weiny wrote:
> On Fri, Nov 05, 2021 at 04:51:40PM +0000, Matthew Wilcox wrote:
> > On Fri, Nov 05, 2021 at 01:50:37PM +0000, Matthew Wilcox wrote:
> > > On Thu, Feb 11, 2021 at 03:56:25PM -0800, Andrew Morton wrote:
> > > > On Wed, 10 Feb 2021 16:33:07 -0800 Ira Weiny <ira.weiny@intel.com> wrote:
> > > > 
> > > > > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > > > 
> > > > > This already has my signed off by so I'm not going to 'review'.  With Prathu's
> > > > > testing information I hope this can land.
> > > > > 
> > > > > Andrew did you see this patch?
> > > > 
> > > > I did now ;)
> > > > 
> > > > Tossed onto the post-rc1 pile, thanks,
> > > 
> > > This patch seems to have slipped through the gaps for a couple of cycles
> > > now?  I found a missed spot in it for CONFIG_HIGHMEM:
> > 
> > Ugh, sorry, wrong version of the patch.
> 
> Check!  Yea this works for me...
> 
> I think this should to through as a separate patch because Prathu's has been
> soaking for some time.  No need to complicate it with this.

This isn't "complicating Prathu's patch".  This is "fixing up the bit
that Prathu missed with his patch".  zero_user_segments() should not
have different rules on HIGHMEM and non-HIGHMEM kernels.

