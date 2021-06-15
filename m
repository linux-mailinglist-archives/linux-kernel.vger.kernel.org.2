Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1803A7BDF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 12:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbhFOKb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 06:31:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231538AbhFOKb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 06:31:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5EF4F61443;
        Tue, 15 Jun 2021 10:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623752992;
        bh=37hVSbyeuLGiLfoCe6jAMxyuGxvuaW5ZN4LcqohlOI4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TQBHdPJsVBmJJIMkoRrJsu7fO7YG5XyErKt70kFxjlZailSmnD7XXPvBz5m2dDbVY
         Hzo7DrD3jtCNiY+WWr/KSp72PvVbsDgMBCg63vkT5pS9Zn4/zBuLnDtybZ/Tva0Yao
         siOvNtJ04C4ylkNKTHYHUSDR7lYWBFp9AdRp8GpozL7Z4rDZwVLiA27wPfZNfApHTe
         EW59F0B2TLXs8A/6dGhsYGsQ69ICJKv0G5DA3tTqeSUw9ZnGF8yiEap85V4Dbjp2MA
         6zf7FfA+ML9UPp/GV1F10kwX1ZvmQN9m4krJPmpXC6oDNeBLRMJpbqZfcFNMAoATxz
         gxkcmIXenKXXQ==
Date:   Tue, 15 Jun 2021 11:29:48 +0100
From:   Will Deacon <will@kernel.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Jiajun Cao <caojiajun@vmware.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] iommu: Factor iommu_iotlb_gather_is_disjoint() out
Message-ID: <20210615102947.GB20225@willie-the-truck>
References: <20210607182541.119756-1-namit@vmware.com>
 <20210607182541.119756-5-namit@vmware.com>
 <20210611135746.GC15776@willie-the-truck>
 <D76DA59C-023F-43D1-B4ED-BFA65D9D064F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D76DA59C-023F-43D1-B4ED-BFA65D9D064F@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 09:50:31AM -0700, Nadav Amit wrote:
> 
> 
> > On Jun 11, 2021, at 6:57 AM, Will Deacon <will@kernel.org> wrote:
> > 
> > On Mon, Jun 07, 2021 at 11:25:39AM -0700, Nadav Amit wrote:
> >> From: Nadav Amit <namit@vmware.com>
> >> 
> >> Refactor iommu_iotlb_gather_add_page() and factor out the logic that
> >> detects whether IOTLB gather range and a new range are disjoint. To be
> >> used by the next patch that implements different gathering logic for
> >> AMD.
> >> 
> >> Cc: Joerg Roedel <joro@8bytes.org>
> >> Cc: Will Deacon <will@kernel.org>
> >> Cc: Jiajun Cao <caojiajun@vmware.com>
> >> Cc: Robin Murphy <robin.murphy@arm.com>
> >> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> >> Cc: iommu@lists.linux-foundation.org
> >> Cc: linux-kernel@vger.kernel.org>
> >> Signed-off-by: Nadav Amit <namit@vmware.com>
> >> ---
> >> include/linux/iommu.h | 41 +++++++++++++++++++++++++++++++++--------
> >> 1 file changed, 33 insertions(+), 8 deletions(-)
> > 
> > [...]
> > 
> >> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> >> index f254c62f3720..b5a2bfc68fb0 100644
> >> --- a/include/linux/iommu.h
> >> +++ b/include/linux/iommu.h
> >> @@ -497,6 +497,28 @@ static inline void iommu_iotlb_sync(struct iommu_domain *domain,
> >> 	iommu_iotlb_gather_init(iotlb_gather);
> >> }
> >> 
> >> +/**
> >> + * iommu_iotlb_gather_is_disjoint - Checks whether a new range is disjoint
> >> + *
> >> + * @gather: TLB gather data
> >> + * @iova: start of page to invalidate
> >> + * @size: size of page to invalidate
> >> + *
> >> + * Helper for IOMMU drivers to check whether a new range is and the gathered
> >> + * range are disjoint.
> > 
> > I can't quite parse this. Delete the "is"?
> 
> Indeed. Will do (I mean I will do ;-) )
> 
> > 
> >>    For many IOMMUs, flushing the IOMMU in this case is
> >> + * better than merging the two, which might lead to unnecessary invalidations.
> >> + */
> >> +static inline
> >> +bool iommu_iotlb_gather_is_disjoint(struct iommu_iotlb_gather *gather,
> >> +				    unsigned long iova, size_t size)
> >> +{
> >> +	unsigned long start = iova, end = start + size - 1;
> >> +
> >> +	return gather->end != 0 &&
> >> +		(end + 1 < gather->start || start > gather->end + 1);
> >> +}
> >> +
> >> +
> >> /**
> >>  * iommu_iotlb_gather_add_range - Gather for address-based TLB invalidation
> >>  * @gather: TLB gather data
> >> @@ -533,20 +555,16 @@ static inline void iommu_iotlb_gather_add_page(struct iommu_domain *domain,
> >> 					       struct iommu_iotlb_gather *gather,
> >> 					       unsigned long iova, size_t size)
> >> {
> >> -	unsigned long start = iova, end = start + size - 1;
> >> -
> >> 	/*
> >> 	 * If the new page is disjoint from the current range or is mapped at
> >> 	 * a different granularity, then sync the TLB so that the gather
> >> 	 * structure can be rewritten.
> >> 	 */
> >> -	if (gather->pgsize != size ||
> >> -	    end + 1 < gather->start || start > gather->end + 1) {
> >> -		if (gather->pgsize)
> >> -			iommu_iotlb_sync(domain, gather);
> >> -		gather->pgsize = size;
> >> -	}
> >> +	if ((gather->pgsize && gather->pgsize != size) ||
> >> +	    iommu_iotlb_gather_is_disjoint(gather, iova, size))
> >> +		iommu_iotlb_sync(domain, gather);
> >> 
> >> +	gather->pgsize = size;
> > 
> > Why have you made this unconditional? I think it's ok, but just not sure
> > if it's necessary or not.
> 
> In regard to gather->pgsize, this function had (and has) an
> invariant, in which gather->pgsize always represents the flushing
> granularity of its range. Arguably, “size" should never be
> zero, but lets assume for the matter of discussion that it might.
> 
> If “size” equals to “gather->pgsize”, then the assignment in
> question has no impact.
> 
> Otherwise, if “size” is non-zero, then iommu_iotlb_sync() would
> initialize the size and range (see iommu_iotlb_gather_init()),
> and the invariant is kept.
> 
> Otherwise, “size” is zero, and “gather” already holds a range,
> so gather->pgsize is non-zero and
> (gather->pgsize && gather->pgsize != size) is true. Therefore,
> again, iommu_iotlb_sync() would be called and initialize the
> size.
> 
> I think that this change makes the code much simpler to read.
> It probably has no performance impact as “gather” is probably
> cached and anyhow accessed shortly after.

Thanks. I was just interested in whether it had a functional impact (I don't
think it does) or whether it was just cleanup.

With the updated comment:

Acked-by: Will Deacon <will@kernel.org>

Will
