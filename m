Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7818A3FE0E6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 19:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345525AbhIARHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 13:07:49 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:57351 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235197AbhIARHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 13:07:48 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id D1B495C021E;
        Wed,  1 Sep 2021 13:06:50 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute1.internal (MEProxy); Wed, 01 Sep 2021 13:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=qBc6NGv+KiVi1FmpY8tiOqHwVXDU
        wzwD5WdArGVR7k4=; b=ZBzXA17kL8sZYrj4eMIefKDKQMxbniiABJt5+d1sygOn
        v3g5WdRs+C9IQT5gutisj+m1YHyl8EQkL0xFV6ZTRSLQt88X6LT6EG7RZ9uvlV3Z
        UvatcDUJ5EqW/X5rM8nwgw2zjXD8EM54zWRuCwYZlULdiOfdRyRscOP4y97igll0
        NpV2bMDGB5ipHdcKievvYZdAQVc1hBBc0Ew4jZL6u65zpN1tjulV4uxnHMjFjnOy
        bbHyULHJikH9wQ6ZkI3PxP1CXdT4rY6OZfeXS25KIeiUUwih6IloY4a88id0ACpM
        32Ncq1c1k/sKiNx17IQgkBkckAWyYdUWD4GSzjuvRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=qBc6NG
        v+KiVi1FmpY8tiOqHwVXDUwzwD5WdArGVR7k4=; b=q11xj7WilbK8LydS8jeFw2
        RlH3kPXcX1OHNwf6ZgwVuZdgCKhuy0LUtVOWceyPa3S3HAyneF0548XxnSIIxreh
        zg6vQjoQgLbNDzvgGT3+bY/JLq1PY17WW0NlHfzALRU4JfumiOcnHulKqKb+G6i4
        Ey4i6bsw574mrTWl/raawlOtWmxbx3E3oEg81eaYp+I/Q2ebrlfhF1mE6WMV/iQX
        ZakDF5vu537nMozAmAzBWTx/t/XKHbPmI9efwgi9vBu/bQhJQWGvw2+0HEhy61mw
        kEHCNhfNYxtfGvsPrJTV2OskHoEyfYDG/9puuoakPRsHetplYv0PmTcIUhFSE82A
        ==
X-ME-Sender: <xms:KLMvYcJuoHHOjuRy2UKJJ_P5kXyF_fW9gjp54yzQTP-AwsAcsGNd3w>
    <xme:KLMvYcKQnyP1TEPR2g4v3YxK5IWgcp9zYKEHx2bgquzyU7BZeil1eqwejwEn8T9rF
    bwtOAzehQXBYfeE8MA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvfedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderreejnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepheejgfdttdefleefteejieefudeuheelkedtgedtjeehieetueelheeu
    hfegheegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:KLMvYctGNy3r6qVEV8TXJ3P701l1UM7m1xfsDexnZh2drk8aAAhr8g>
    <xmx:KLMvYZbyKnzhhzCEBS7aOGmCU6QYpHPEtlSEJv7SgIAg-3Cn5lFaIQ>
    <xmx:KLMvYTbSx2ZfGL0OxKM5wJZwysDFH7oVKhfQ4RMcBAUOsRuu1oSESw>
    <xmx:KrMvYX7P9pSdgi2YImEBA8-THojxOAhnWOAd9kvVtHIp6tbKuelErg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3A6C051C0061; Wed,  1 Sep 2021 13:06:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1126-g6962059b07-fm-20210901.001-g6962059b
Mime-Version: 1.0
Message-Id: <c8bc7f77-3b46-4675-a642-76871fcec963@www.fastmail.com>
In-Reply-To: <YS6fasuqPURbmC6X@sunset>
References: <20210828153642.19396-1-sven@svenpeter.dev>
 <20210828153642.19396-4-sven@svenpeter.dev> <YS6fasuqPURbmC6X@sunset>
Date:   Wed, 01 Sep 2021 19:06:27 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Alyssa Rosenzweig" <alyssa@rosenzweig.io>
Cc:     iommu@lists.linux-foundation.org, "Joerg Roedel" <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
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



On Tue, Aug 31, 2021, at 23:30, Alyssa Rosenzweig wrote:
> I use this function for cross-device sharing on the M1 display driver.
> Arguably this is unsafe but it works on 16k kernels and if you want to
> test the function on 4k, you know where my code is.
> 

My biggest issue is that I do not understand how this function is supposed
to be used correctly. It would work fine as-is if it only ever gets passed buffers
allocated by the coherent API but there's not way to check or guarantee that.
There may also be callers making assumptions that no longer hold when
iovad->granule > PAGE_SIZE.


Regarding your case: I'm not convinced the function is meant to be used there.
If I understand it correctly, your code first allocates memory with dma_alloc_coherent
(which possibly creates a sgt internally and then maps it with iommu_map_sg),
then coerces that back into a sgt with dma_get_sgtable, and then maps that sgt to
another iommu domain with dma_map_sg while assuming that the result will be contiguous
in IOVA space. It'll work out because dma_alloc_coherent is the very thing
meant to allocate pages that can be mapped into kernel and device VA space
as a single contiguous block and because both of your IOMMUs are different
instances of the same HW block. Anything allocated by dma_alloc_coherent for the
first IOMMU will have the right shape that will allow it to be mapped as
a single contiguous block for the second IOMMU.

What could be done in your case is to instead use the IOMMU API,
allocate the pages yourself (while ensuring the sgt your create is made up
of blocks with size and physaddr aligned to max(domain_a->granule, domain_b->granule))
and then just use iommu_map_sg for both domains which actually comes with the
guarantee that the result will be a single contiguous block in IOVA space and
doesn't required the sgt roundtrip.



Sven


> On Sat, Aug 28, 2021 at 05:36:37PM +0200, Sven Peter wrote:
> > Pretend that iommu_dma_get_sgtable is not implemented when
> > granule > PAGE_SIZE since I can neither test this function right now
> > nor do I fully understand how it is used.
> > 
> > Signed-off-by: Sven Peter <sven@svenpeter.dev>
> > ---
> >  drivers/iommu/dma-iommu.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index d6e273ec3de6..64fbd9236820 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -1315,9 +1315,15 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
> >  		void *cpu_addr, dma_addr_t dma_addr, size_t size,
> >  		unsigned long attrs)
> >  {
> > +	struct iommu_domain *domain = iommu_get_dma_domain(dev);
> > +	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> > +	struct iova_domain *iovad = &cookie->iovad;
> >  	struct page *page;
> >  	int ret;
> >  
> > +	if (iovad->granule > PAGE_SIZE)
> > +		return -ENXIO;
> > +
> >  	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr)) {
> >  		struct page **pages = dma_common_find_pages(cpu_addr);
> >  
> > -- 
> > 2.25.1
> > 
> 


-- 
Sven Peter
