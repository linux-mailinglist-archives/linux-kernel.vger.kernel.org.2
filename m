Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352833988B8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 13:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbhFBMAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 08:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhFBMAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 08:00:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8EFC061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 04:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mQopZOGEyPUPV5G5APHCEl13iaIRug2yhfkIsJePiyA=; b=vZjiGz3Ipz7NThkF9NAxLmGyFJ
        OIDbNdzRaAE8h3S4YUTFg4S+S59Mii3RlwzclKY4d4ymOwGAacIATCpxbSQ3nqybDFI0SgXGWvlDd
        jAfyp4JGoQXBCaEJZROGMzT9ueJSAemseIuoK7g4S+hIFHbBqGSN5E7tR59Cb+ZWqumHt9MErBMcw
        yhF9Qr+By+jiAjcH+qvqjWsLSDPStYCd9KihSd8ruMslDRLS2dWzZ/9fluxUIcx102xm4gHIHOtas
        nYKdXX/5LGznaeevWjJlPW2CGV7b/zg86PV5E9YujhcT2cXJu4xjPhhFymmrGNyH6E6Wkvp3qO5lL
        YHdvjQ4g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1loPVk-00B40Q-Nv; Wed, 02 Jun 2021 11:58:19 +0000
Date:   Wed, 2 Jun 2021 12:58:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yu Xu <xuyu@linux.alibaba.com>
Cc:     Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        gavin.dg@linux.alibaba.com, Greg Thelen <gthelen@google.com>,
        Wei Xu <weixugc@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm, thp: relax migration wait when failed to get tail
 page
Message-ID: <YLdyVEbPs+Gwf3G4@casper.infradead.org>
References: <bc8567d7a2c08ab6fdbb8e94008157265d5d28a3.1622564942.git.xuyu@linux.alibaba.com>
 <alpine.LSU.2.11.2106010947370.1090@eggly.anvils>
 <YLZqKJ4anEGpAZfp@casper.infradead.org>
 <alpine.LSU.2.11.2106011114580.1045@eggly.anvils>
 <71c320bf-3fcb-f8c0-65e4-ff706af05607@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71c320bf-3fcb-f8c0-65e4-ff706af05607@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 11:27:47AM +0800, Yu Xu wrote:
> On 6/2/21 3:10 AM, Hugh Dickins wrote:
> > On Tue, 1 Jun 2021, Matthew Wilcox wrote:
> > > On Tue, Jun 01, 2021 at 09:55:56AM -0700, Hugh Dickins wrote:
> > > > 
> > > > Well caught: you're absolutely right that there's a bug there.
> > > > But isn't cond_resched() just papering over the real bug, and
> > > > what it should do is a "page = compound_head(page);" before the
> > > > get_page_unless_zero()? How does that work out in your testing?
> > > 
> > > You do realise you're strengthening my case for folios by suggesting
> > > that, don't you?  ;-)
> > 
> > Hah! Well, I do realize that I'm offering you a marketing opportunity.
> > And you won't believe how many patches I dread to post for fear of that ;-)
> > 
> > But I'm not so sure that it strengthens your case: apparently folios
> > had not detected this?  Or do you have a hoard of folio-detected fixes
> > waiting for the day, and a folio-kit for each of the stable releases?
> > 
> > > 
> > > I was going to suggest that it won't make any difference because the
> > > page reference count is frozen, but the freezing happens after the call
> > > to unmap_page(), so it may make a difference.
> > 
> > I think that's a good point: I may have just jumped on the missing
> > compound_head(), without thinking it through as far as you have.
> > 
> > I'm having trouble remembering the dynamics now; but I think there
> > are cond_resched()s in the unmap_page() part, so the splitter may
> > get preempted even on a non-preempt kernel; whereas the frozen
> > part is all done expeditiously, with interrupts disabled.
> > 
> > Greg discovered the same issue recently, but we all got sidetracked,
> > and I don't know where his investigation ended up.  He was in favour
> > of cond_resched(), I was in favour of compound_head(); and I think I
> 
> I ever considered about using compound_head, but isn't there another
> race that, the following put_and_wait_on_page_locked operates on the
> "tail page" which has been split and is now a single page?

No, having your own reference on a page prevents the page from being
split.  But that's a good question to ask.

