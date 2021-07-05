Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2E33BBC36
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 13:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbhGELeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 07:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbhGELeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 07:34:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169BFC061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 04:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9H9iODckS8PBbsws9LA6I5LZlHEGdw0o674VvV8kLRs=; b=FGpqr1A6YBOCL02f5RRUG+huXe
        vpAGxPy4bZDYxWiR44oNHCRksfdwfkza6aU7ji6DEXT18xGp/KZ9KMdlqYgqnj0cul79jXB9nt9Zx
        G/j6u67yJotZ2tSufB18/lTFitF2zkDES7fxwmgY+T+gIrYHy1bp6FzkBZT5RPTyta7BDot+W4AFN
        XKgqAIUtD63lzKTn3qXi2PThpsea+ClssZJBDUNSU462auqbn3UG6DhiVCZIMiOskrGYod2Igz7Ad
        wtloiOMyhMXnQ0MvfXyi1atVsjrApX292d2C1R7YJiCbHVFj5mPv9uE5geMpmxN2Q6WzGDUnuV/Ss
        XJPDS6DA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0MoV-00ACJ5-Mg; Mon, 05 Jul 2021 11:31:04 +0000
Date:   Mon, 5 Jul 2021 12:30:59 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm/thp: Make ALLOC_SPLIT_PTLOCKS dependent on
 USE_SPLIT_PTE_PTLOCKS
Message-ID: <YOLtc+QwIETSqAI/@casper.infradead.org>
References: <1621409586-5555-1-git-send-email-anshuman.khandual@arm.com>
 <YKZFRPqg4wKjOdVg@casper.infradead.org>
 <9d1ce685-e0fd-febd-5ff2-179f7fa6e3fa@arm.com>
 <YN27uc64s/yllfQR@casper.infradead.org>
 <45c1feaa-4bab-91d1-6962-81549d2b6d00@arm.com>
 <YOJ8YR8wWkiHsRTp@casper.infradead.org>
 <67a7c36d-a040-b58a-ab8b-d67ba4341369@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67a7c36d-a040-b58a-ab8b-d67ba4341369@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2021 at 09:09:22AM +0530, Anshuman Khandual wrote:
> 
> 
> On 7/5/21 8:58 AM, Matthew Wilcox wrote:
> > On Mon, Jul 05, 2021 at 08:57:54AM +0530, Anshuman Khandual wrote:
> >>
> >> On 7/1/21 6:27 PM, Matthew Wilcox wrote:
> >>> On Thu, Jul 01, 2021 at 10:51:27AM +0530, Anshuman Khandual wrote:
> >>>>
> >>>>
> >>>> On 5/20/21 4:47 PM, Matthew Wilcox wrote:
> >>>>> On Wed, May 19, 2021 at 01:03:06PM +0530, Anshuman Khandual wrote:
> >>>>>> Split ptlocks need not be defined and allocated unless they are being used.
> >>>>>> ALLOC_SPLIT_PTLOCKS is inherently dependent on USE_SPLIT_PTE_PTLOCKS. This
> >>>>>> just makes it explicit and clear. While here drop the spinlock_t element
> >>>>>> from the struct page when USE_SPLIT_PTE_PTLOCKS is not enabled.
> >>>>>
> >>>>> I didn't spot this email yesterday.  I'm not a fan.  Isn't struct page
> >>>>> already complicated enough without adding another ifdef to it?  Surely
> >>>>> there's a better way than this.
> >>>>
> >>>> This discussion thread just got dropped off the radar, sorry about it.
> >>>> None of the spinlock_t elements are required unless split ptlocks are
> >>>> in use. I understand your concern regarding yet another #ifdef in the
> >>>> struct page definition. But this change is simple and minimal. Do you
> >>>> have any other particular alternative in mind which I could explore ?
> >>>
> >>> Do nothing?  I don't understand what problem you're trying to solve.
> >>
> >> Currently there is an element (spinlock_t ptl) in the struct page for page
> >> table lock. Although a struct page based spinlock is not even required in
> >> case USE_SPLIT_PTE_PTLOCKS evaluates to be false. Is not that something to
> >> be fixed here i.e drop the splinlock_t element if not required ?
> > 
> > No?  It doesn't actually cause any problems, does it?
> 
> No but should an unnecessary element in a struct is dropped only if there
> is a reported problem ?

In this case, yes.  It's not just a struct member; it's a member of a
union in the struct.  You don't save any memory by getting rid of it.
There's no benefit to getting rid of it.
