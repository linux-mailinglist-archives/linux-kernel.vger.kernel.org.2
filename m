Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56573B463A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 17:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhFYPED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 11:04:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231858AbhFYPD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 11:03:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C42CA6197D;
        Fri, 25 Jun 2021 15:01:35 +0000 (UTC)
Date:   Fri, 25 Jun 2021 16:01:33 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Rustam Kovhaev <rkovhaev@gmail.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: kmemleak memory scanning
Message-ID: <20210625150132.GF20835@arm.com>
References: <YMe8ktUsdtwFKHuF@nuc10>
 <CACT4Y+ZjSbioNS8oPwUcyOrLhB6-Sf-WZmadAoAm0H-JYRLo1g@mail.gmail.com>
 <YMpCEu9yM5Ppj5jj@nuc10>
 <YNTCsqQUaYnlXGbO@nuc10>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNTCsqQUaYnlXGbO@nuc10>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 10:36:50AM -0700, Rustam Kovhaev wrote:
> On Wed, Jun 16, 2021 at 11:25:22AM -0700, Rustam Kovhaev wrote:
> > On Tue, Jun 15, 2021 at 07:15:24AM +0200, Dmitry Vyukov wrote:
> > > On Mon, Jun 14, 2021 at 10:31 PM Rustam Kovhaev <rkovhaev@gmail.com> wrote:
> > > >
> > > > hello Catalin, Andrew!
> > > >
> > > > while troubleshooting a false positive syzbot kmemleak report i have
> > > > noticed an interesting behavior in kmemleak and i wonder whether it is
> > > > behavior by design and should be documented, or maybe something to
> > > > improve.
> > > > apologies if some of the questions do not make sense, i am still going
> > > > through kmemleak code..
> > > >
> > > > a) kmemleak scans struct page (kmemleak.c:1462), but it does not scan
> > > > the actual contents (page_address(page)) of the page.
> > > > if we allocate an object with kmalloc(), then allocate page with
> > > > alloc_page(), and if we put kmalloc pointer somewhere inside that page,
> > > > kmemleak will report kmalloc pointer as a false positive.
> > > > should we improve kmemleak and make it scan page contents?
> > > > or will this bring too many false negatives?
> > > 
> > > Hi Rustam,
> > > 
> > > Nice debugging!
> > > I assume lots of pages are allocated for slab and we don't want to
> > > scan the whole page if only a few slab objects are alive on the page.
> > > However alloc_pages() can be called by end kernel code as well.
> > > I grepped for any kmemleak annotations around existing calls to
> > > alloc_pages, but did not find any...
> > > Does it require an explicit kmemleak_alloc() after allocating the page
> > > and kmemleak_free () before freeing the page?
> > 
> > hi Dmitry, thank you!
> > yes, as Catalin has pointed out, there are a few places where we call
> > kmemleak_alloc()/kmemleak_free() explicitly in order for the pages to be
> > scanned, like in blk_mq_alloc_rqs()
> > 
> > > If there are more than one use case for this, I guess we could add
> > > some GFP flag for this maybe.
> > 
> > and this way kernel users won't have to use kmemleak fuctions mentioned
> > above including some or most kmemleak_not_leak() calls and basically
> > kmemleak will be kind of "transparent" to them? and they will only need
> > to use the GFP flag to instruct kmemleak to scan the page contents?
> > it sounds like a good idea to me..
> > 
> 
> i've been thinking about this and it seems like in the scenario where we
> want kmemleak to scan only some part of the page, we will have to either
> do separate alloc_page() calls with different flags or use 
> kmemleak_scan_area() to limit the memory scan area. maybe this approach
> won't simplify things and will produce more code instead of reducing it

Since page allocation is not tracked by kmemleak, you can always do an
explicit kmemleak_alloc() call with a smaller size than a full page.

-- 
Catalin
