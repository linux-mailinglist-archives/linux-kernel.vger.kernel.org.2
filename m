Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1C93DEDEF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 14:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbhHCMgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 08:36:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235877AbhHCMgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 08:36:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB7A860EB9;
        Tue,  3 Aug 2021 12:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627994154;
        bh=M3BfNEx5IT0rbeH9S8HguBwKyx5n0nfj2QOvBxh6dfs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a/xS1WCtL1WvKPUClr+Tt60U7LD7wFszy7P/0EqgtrJH66isd+ncDa1kvgNCl9SHK
         DB87VQfSkLspaKTUsxiqxEDxPu8dZ306YBMAccLbr+MK9Bc9+lrsHBrLeEGCuRzDvs
         TF1/4ZYm7qqAAz/dJtbeSC+qnHZzSV34b2NdTHLyci/VuMdtO6XXbdWqiUE2/sy7Xf
         cLrtanB3IWDPr/hXT6xNSGBgTR2cQ9eHt4eRujYm/tB2YNaxWTAD6s1Eu2625axov2
         q3XAXVKXHu/I+1pNwOXWHe0PI5CRZPPw9Ckoju0MEPqom/L1qvFhIG4dueK/iTHsCH
         cX4/GAqHEVRlw==
Date:   Tue, 3 Aug 2021 13:35:49 +0100
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org
Subject: Re: [PATCH v2 23/24] iommu/arm-smmu: Allow non-strict in
 pgtable_quirks interface
Message-ID: <20210803123548.GA30932@willie-the-truck>
References: <cover.1627468308.git.robin.murphy@arm.com>
 <0fcd1f5225a6b435cbc697551a6247cd435c04db.1627468310.git.robin.murphy@arm.com>
 <20210802130438.GA28547@willie-the-truck>
 <3dd7cdae-7111-6ff2-6350-a0e19fe4ab66@arm.com>
 <20210803103559.GA30690@willie-the-truck>
 <529750e7-89a0-cfb7-8cef-36bb78b06340@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <529750e7-89a0-cfb7-8cef-36bb78b06340@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 01:13:12PM +0100, Robin Murphy wrote:
> On 2021-08-03 11:36, Will Deacon wrote:
> > Overall, I'm really nervous about the concurrency here and think we'd be
> > better off requiring the unbind as we have for the other domain changes.
> 
> Sure, the dynamic switch is what makes it ultimately work for Doug's
> use-case (where the unbind isn't viable), but I had every expectation that
> we might need to hold back those two patches for much deeper consideration.
> It's no accident that the first 22 patches can still be usefully applied
> without them!

Oh, the rest of the series looks great which is why I jumped on this bit!

> In all honesty I don't really like this particular patch much, mostly
> because I increasingly dislike IO_PGTABLE_QUIRK_NON_STRICT at all, but since
> the interface was there it made it super easy to prove the concept. I have a
> more significant refactoring of the io-pgtable code sketched out in my mind
> already, it's just going to be more work.

Intriguing... Move the smp_wmb() into the IOVA code instead?

> > With your changes, I think quite a few things can go wrong.
> > 
> >    * cookie->fq_domain may be observed but iovad->fq could be NULL
> 
> Good point, I guess that already technically applies (if iovad->fq sat in a
> write buffer long enough), but it certainly becomes far easier to provoke.
> However a barrier after assigning fq_domain (as mentioned above) paired with
> the control dependency around the queue_iova() call would also fix that,
> right?
> 
> >    * We can miss the smp_wmb() in the pgtable code but end up deferring the
> >      IOVA reclaim
> >    * iommu_change_dev_def_domain() only holds the group mutex afaict, so can
> >      possibly run concurrently with itself on the same domain?
> >    * iommu_dma_init_fq() can flip the domain type back from
> >      IOMMU_DOMAIN_DMA_FQ to IOMMU_DOMAIN_DMA on the error path
> >    * set_pgtable_quirks() isn't atomic, which probably is ok for now, but the
> >      moment we use it anywhere else it's dangerous
> 
> In other words, IO_PGTABLE_QUIRK_NON_STRICT is definitely the problem. I'll
> have a hack on that this afternoon, and if it starts to look rabbit-holey
> I'll split this bit off and post v3 of the rest of the series.
> 
> If all the io-pgtable and fq behaviour for a given call could be consistent
> based on a single READ_ONCE(cookie->fq_domain) in iommu_dma_unmap(), do you
> see any remaining issues other than the point above?

I'd have to see the patches, and I didn't look exhaustively at the current
stuff. But yes, I think the basic flow needs to be that there is an atomic
flag (i.e. cookie->fq_domain) which indicates which mode is being used
and if you flip that concurrently then you need to guarantee that everybody
is either using the old more or the new mode and not some halfway state in
between.

Will
