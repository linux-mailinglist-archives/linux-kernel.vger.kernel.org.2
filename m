Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E093142DF3C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 18:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbhJNQgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 12:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbhJNQgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 12:36:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2931AC061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 09:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B5Ne9PwyaPKNZsA4nfALs8ysb+j2MUAWcASB0gSVPg8=; b=MbGq3u2CTyKdZTtigfOZBK7Lki
        3Ga0B05uSgD+BBKke0F9DUEDGVHlDrqGNzSnicVILFTQDWhwRKyGik/tMgvbgBxN6aL24fKCWKBEA
        BGU/2r5xhjqtcjVuUD2vZw+Xdh8NjgrBTs+pk9wK+4SysW1KgtRpnjHq3vZ1oXysbM1p9Xwa6I1j/
        TiedRIInv8urTwouhihFJ6rlEA59ohqMPlgEiQ0EGFskVauow5XCNGVKCZ7a8ZPSF8QqPZLG4XL3d
        cn2fujCbqnQdTHFS4zdRh7wrQI2q7TrQsirZ3lU1svdErLODsyOnLt2VfYqq+kHbm2PhNr6Oi6wn2
        Dt0+v1cg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mb3eT-008Sme-Qz; Thu, 14 Oct 2021 16:32:36 +0000
Date:   Thu, 14 Oct 2021 17:32:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     John Garry <john.garry@huawei.com>, Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] iommu: Use put_pages_list
Message-ID: <YWhbkaWpAJgdM1b5@casper.infradead.org>
References: <20210930162043.3111119-1-willy@infradead.org>
 <YV85dvlyj5LBdsro@casper.infradead.org>
 <YWgShKtp+89f1a/J@casper.infradead.org>
 <5e147b84-f048-b5ff-09d6-ceffe4c2364a@huawei.com>
 <93425cf4-3027-940f-3bee-29c4ee61105f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93425cf4-3027-940f-3bee-29c4ee61105f@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 05:17:18PM +0100, Robin Murphy wrote:
> On 2021-10-14 12:52, John Garry wrote:
> > On 14/10/2021 12:20, Matthew Wilcox wrote:
> > > I'm going to keep pinging this patch weekly.
> > > 
> > > On Thu, Oct 07, 2021 at 07:17:02PM +0100, Matthew Wilcox wrote:
> > > > ping?
> > 
> > Robin, Were you checking this? You mentioned "I got
> > side-tracked trying to make io-pgtable use that freelist properly" in
> > another thread, which seems related.
> 
> Ooh, thanks for the heads-up John - I'm still only just starting to catch up
> on my mailing list folders since I got back off holiday.
> 
> Indeed I already started untangling the freelist handling in the flush queue
> code (to make the move into iommu-dma smaller). Once I'd figured out how it
> worked I did wonder whether there was any more "standard" field to borrow,
> since page->freelist did seem very much in the minority. If page->lru is it
> then great! From a quick skim of the patch I think I'd only have a few
> trivial review comments to make - certainly no objection to the fundamental
> change itself (indeed I hit a point in io-pgtable-arm where adding to the
> pointer chain got rather awkward, so having proper lists to splice would be
> lovely).

Great to hear!

> Matthew - is this something getting in the way of mm development, or just a
> nice cleanup? I'd be happy either to pursue merging it on its own, or to
> pick it up and work it into a series with my stuff.

This is probably going to get in the way of MM development in ~6 months
time.  I'm happy for you to pick it up and put it in a series of your own!
BTW, the optimisation of the implementation of put_pages_list() is sitting
in akpm's tree, so if you see a performance problem, please give that
a try.
