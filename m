Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E020A4003B1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 18:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349771AbhICQxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 12:53:21 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:44485 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230187AbhICQxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 12:53:18 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id E3E635C0159;
        Fri,  3 Sep 2021 12:52:17 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute1.internal (MEProxy); Fri, 03 Sep 2021 12:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=Sj8qfi5acETm3P7RSRk0CRVIAUU7
        c7e1VWwIZayoXM4=; b=M1iEEUIQUrQ3xGCpyj1AD7Hq2iMJdjbZ5Sdpi/dM+1W8
        I6nCo+9/PAOFPCYWU1fBahqBTCuXUk5GEl+pSKRaHrKVFMmoa+YxoTmlz+HuJfWZ
        FgXi1WY7AtOhzuQIYsVd7j8RKDDSOgOu4Rgrn1eSCU4vUk17ZbYzm5D/yziyKIaR
        kS8abxApohC+wLmbHtUWHTUPwqSOp1Aw0poiMLAyy2fbcCTysVUP+aYPoAoibe1O
        B8i+ON1rKZtc959VZHtYe31s7eK/b4klEIiVAyfMThM0FM+SrTw4Oh0Xg4qqhEZW
        ZGZqhHLYqKBumjxYydD3oiQAXcgAW6I4dYVJZ+W0cQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Sj8qfi
        5acETm3P7RSRk0CRVIAUU7c7e1VWwIZayoXM4=; b=Qw9wzs0tFolmFiegUk9Xdi
        vQa4lpQU7PrD2dMYHu4RVureKMekgf8Wp29c+exo2RKzL8cPlasUoNQETLkaHRY1
        jKvDq9Xt/8gJDlHoKeM7YYQEod4uJh7WSPI+Zym4BlquarL3hXiMk2HLlqIqdARo
        qpvseRFUByaXriEyukIjlC1TajaQnGKIhGtE8kl50i+vI+Rxhk5oAHuJIn1i8PJ+
        ip5o2D19AhV1wNXptL6M6HSNoZBL3HR2AfjlQ+0DqIdPdsvn4xNj9cUQI1bEvwlA
        WvQNiFk0mpRxQ3SgjbB1IBUosweGsch0fgOa0y6BTPAeDX2N00W81Bu+pqyoCh5g
        ==
X-ME-Sender: <xms:wFIyYYgVPf73lq5a8WShm-9rc9wLma8ISfB0NGXCjSVKXCT5E0ev1A>
    <xme:wFIyYRB3sDJm5hcZckdLKlPP66T5oQB-zOXfmTDAsiUKAHLykveIL2BUcUuO6Y7SD
    RDqUHM7QXqU6bWi_24>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvjedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderreejnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepheejgfdttdefleefteejieefudeuheelkedtgedtjeehieetueelheeu
    hfegheegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:wFIyYQFqO7ruuuVM3hhv2glnQTZwOKf3uMZ4yCACeHVrwRHhpvSKgg>
    <xmx:wFIyYZR0WIgOEKx1kZkHAtURBvK-4H1lg1ze4si-HKZ95ahnmW3xhg>
    <xmx:wFIyYVxfGpPg-HS8fHFDgLDytByWFnmI73CK3TmWEpVhNnqrJpFwHw>
    <xmx:wVIyYUzlZSUsdHRoKO4MCASWxJIX8v7izFKjEibuxFRgvKQ-ampqSg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4842B51C0060; Fri,  3 Sep 2021 12:52:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1126-g6962059b07-fm-20210901.001-g6962059b
Mime-Version: 1.0
Message-Id: <16ffa27b-4769-469e-827c-129948a78a36@www.fastmail.com>
In-Reply-To: <462494ab-121e-e4dd-3811-d744f0fffa66@arm.com>
References: <20210828153642.19396-1-sven@svenpeter.dev>
 <20210828153642.19396-4-sven@svenpeter.dev> <YS6fasuqPURbmC6X@sunset>
 <c8bc7f77-3b46-4675-a642-76871fcec963@www.fastmail.com>
 <YS/sMckPUJRMYwYq@sunset>
 <ac34e920-d1b4-4044-a8fe-5172d5ebfa9c@www.fastmail.com>
 <74621c69-ef68-c12a-3770-319cb7a0db73@arm.com>
 <989af5a3-8c84-4796-adb6-af9426d68b76@www.fastmail.com>
 <462494ab-121e-e4dd-3811-d744f0fffa66@arm.com>
Date:   Fri, 03 Sep 2021 18:51:54 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Robin Murphy" <robin.murphy@arm.com>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>
Cc:     "Sven Peter" <iommu@lists.linux-foundation.org>,
        "Joerg Roedel" <joro@8bytes.org>, "Will Deacon" <will@kernel.org>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Mohamed Mediouni" <mohamed.mediouni@caramail.com>,
        "Alexander Graf" <graf@amazon.com>,
        "Hector Martin" <marcan@marcan.st>, linux-kernel@vger.kernel.org
Subject: =?UTF-8?Q?Re:_[PATCH_v2_3/8]_iommu/dma:_Disable_get=5Fsgtable_for_granul?=
 =?UTF-8?Q?e_>_PAGE=5FSIZE?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, Sep 3, 2021, at 17:45, Robin Murphy wrote:
> On 2021-09-03 16:16, Sven Peter wrote:
> > 
> > 
> > On Thu, Sep 2, 2021, at 21:42, Robin Murphy wrote:
> >> On 2021-09-02 19:19, Sven Peter wrote:
> >>>
> >>>
> >>> On Wed, Sep 1, 2021, at 23:10, Alyssa Rosenzweig wrote:
> >>>>> My biggest issue is that I do not understand how this function is supposed
> >>>>> to be used correctly. It would work fine as-is if it only ever gets passed buffers
> >>>>> allocated by the coherent API but there's not way to check or guarantee that.
> >>>>> There may also be callers making assumptions that no longer hold when
> >>>>> iovad->granule > PAGE_SIZE.
> >>>>>
> >>>>> Regarding your case: I'm not convinced the function is meant to be used there.
> >>>>> If I understand it correctly, your code first allocates memory with dma_alloc_coherent
> >>>>> (which possibly creates a sgt internally and then maps it with iommu_map_sg),
> >>>>> then coerces that back into a sgt with dma_get_sgtable, and then maps that sgt to
> >>>>> another iommu domain with dma_map_sg while assuming that the result will be contiguous
> >>>>> in IOVA space. It'll work out because dma_alloc_coherent is the very thing
> >>>>> meant to allocate pages that can be mapped into kernel and device VA space
> >>>>> as a single contiguous block and because both of your IOMMUs are different
> >>>>> instances of the same HW block. Anything allocated by dma_alloc_coherent for the
> >>>>> first IOMMU will have the right shape that will allow it to be mapped as
> >>>>> a single contiguous block for the second IOMMU.
> >>>>>
> >>>>> What could be done in your case is to instead use the IOMMU API,
> >>>>> allocate the pages yourself (while ensuring the sgt your create is made up
> >>>>> of blocks with size and physaddr aligned to max(domain_a->granule, domain_b->granule))
> >>>>> and then just use iommu_map_sg for both domains which actually comes with the
> >>>>> guarantee that the result will be a single contiguous block in IOVA space and
> >>>>> doesn't required the sgt roundtrip.
> >>>>
> >>>> In principle I agree. I am getting the sense this function can't be used
> >>>> correctly in general, and yet is the function that's meant to be used.
> >>>> If my interpretation of prior LKML discussion holds, the problems are
> >>>> far deeper than my code or indeed page size problems...
> >>>
> >>> Right, which makes reasoning about this function and its behavior if the
> >>> IOMMU pages size is unexpected very hard for me. I'm not opposed to just
> >>> keeping this function as-is when there's a mismatch between PAGE_SIZE and
> >>> the IOMMU page size (and it will probably work that way) but I'd like to
> >>> be sure that won't introduce unexpected behavior.
> >>>
> >>>>
> >>>> If the right way to handle this is with the IOMMU and IOVA APIs, I really wish
> >>>> that dance were wrapped up in a safe helper function instead of open
> >>>> coding it in every driver that does cross device sharing.
> >>>>
> >>>> We might even call that helper... hmm... dma_map_sg.... *ducks*
> >>>>
> >>>
> >>> There might be another way to do this correctly. I'm likely just a little
> >>> bit biased because I've spent the past weeks wrapping my head around the
> >>> IOMMU and DMA APIs and when all you have is a hammer everything looks like
> >>> a nail.
> >>>
> >>> But dma_map_sg operates at the DMA API level and at that point the dma-ops
> >>> for two different devices could be vastly different.
> >>> In the worst case one of them could be behind an IOMMU that can easily map
> >>> non-contiguous pages while the other one is directly connected to the bus and
> >>> can't even access >4G pages without swiotlb support.
> >>> It's really only possible to guarantee that it will map N buffers to <= N
> >>> DMA-addressable buffers (possibly by using an IOMMU or swiotlb internally) at
> >>> that point.
> >>>
> >>> On the IOMMU API level you have much more information available about the actual
> >>> hardware and can prepare the buffers in a way that makes both devices happy.
> >>> That's why iommu_map_sgtable combined with iovad->granule aligned sgt entries
> >>> can actually guarantee to map the entire list to a single contiguous IOVA block.
> >>
> >> Essentially there are two reasonable options, and doing pretend dma-buf
> >> export/import between two devices effectively owned by the same driver
> >> is neither of them. Handily, DRM happens to be exactly where all the
> >> precedent is, too; unsurprisingly this is not a new concern.
> >>
> >> One is to go full IOMMU API, like rockchip or tegra, attaching the
> >> relevant devices to your own unmanaged domain(s) and mapping pages
> >> exactly where you choose. You still make dma_map/dma_unmap calls for the
> >> sake of cache maintenance and other housekeeping on the underlying
> >> memory, but you ignore the provided DMA addresses in favour of your own
> >> IOVAs when it comes to programming the devices.
> >>
> >> The lazier option if you can rely on all relevant devices having equal
> >> DMA and IOMMU capabilities is to follow exynos, and herd the devices
> >> into a common default domain. Instead of allocating you own domain, you
> >> grab the current domain for one device (which will be its default
> >> domain) and manually attach the other devices to that. Then you forget
> >> all about IOMMUs but make sure to do all your regular DMA API calls
> >> using that first device, and the DMA addresses which come back should be
> >> magically valid for the other devices too. It was a bit of a cheeky hack
> >> TBH, but I'd still much prefer more of that over any usage of
> >> get_sgtable outside of actual dma-buf...
> >>
> >> Note that where multiple IOMMU instances are involved, the latter
> >> approach does depend on the IOMMU driver being able to support sharing a
> >> single domain across them; I think that might sort-of-work for DART
> >> already, but may need a little more attention.
> > 
> > It'll work for two streams inside the same DART but needs some
> > attention for streams from two separate DARTs.
> > 
> > Then there's also this amazing "feature" that the display controller DART
> > pagetable pointer register is read-only so that we have to reuse the memory
> > Apple configured for first level table. That needs some changes anyway
> > but might make adding multiple devices from different groups more complex.
> 
> OK, I was thinking the dual-DART accommodation is already at least some 
> of the way there, but I guess it's still tied to a single device's cfg. 

Pretty much. I think "needing a little more attention" describes it pretty
well :)


> One upside to generalising further might be that the dual-DART case 
> stops being particularly special :)
> 
> Not being able to physically share pagetables shouldn't be too big a 
> deal, just a bit more work to sync iommu_map/iommu_unmap calls across 
> all the relevant instances for the given domain.

True, it's just a bit more bookkeeping in the end.



Sven
