Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2393FA745
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 21:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhH1TBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 15:01:33 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:34347 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230014AbhH1TBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 15:01:31 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 44BE45C00AA;
        Sat, 28 Aug 2021 15:00:40 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute1.internal (MEProxy); Sat, 28 Aug 2021 15:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=Gl+heJTVLbJMFawJi7+zfifJxKLs
        eJg22LNQuV3cG2E=; b=Cl2T7cIW5T8LJ+VHDkuzXe54lnlxTkdG+2h0iZnRfthy
        anSisR+RJ14DNa7WVdU55Uz2xYyvV51L1ROd9TdcDoqAyWo6Pe2wQOhxc9E8TR3x
        Cc76bN5icGOHGI1gIIka/nIoUTz3CgUs16L+FIdSa40KF2VehDiovb4VTKXOydFG
        sYE5FWp0HffDEzUE8LjmMcxa0G/rLC4EQJ+8GrNhsE2x/V73+bJq2jq6ubHwDPrD
        1p9zxjNdPWWlDf5m7uFXQAsNYjdWGWqCwcNbRqM+zHdeZx3ta2m7gvNfsKQpWkid
        03Yraw9Rpc8w6Dz9N7onfv+aLyVIJA4+y9Nfolf0zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Gl+heJ
        TVLbJMFawJi7+zfifJxKLseJg22LNQuV3cG2E=; b=kdh5ScJ25SfEbbYFWClteN
        fTezdxVxwMATHwrrPWGPk3ipIsKCtziH+P8Hyi288AM3+9XjXpgVb+BrXiizOVUn
        ps0QiwUDnJjnDsjnszMyXQmHL1MeDXogNgjiMfJxadnnLGZl7Mn+uXomRTiKpcJV
        Dy/9YGCePTR0GKltRj4tbweqASD32JtngnoLIKFZ2LEzc1RiGibBiX5/yAzA9ZZz
        i5GBuQ4InJ95NNZAnVbS7seBaTxlxpxfzLT2xQ1TwGsFwIC8fgl591v1JZAE2gMF
        rVdDWT40IQaObXxJ0uPuJlpmXg3tShXISONcmavVO9Cn2K8RfBkcTQUgAkHEaqjA
        ==
X-ME-Sender: <xms:1ocqYYUwWDL3A7rRWCEcn-31IAJlW2wQqQ7etPUWvg1fGVCu3EtccQ>
    <xme:1ocqYclCtgOTuWVk2bQGOKqPc8z0l8C9k6AMjILbWRCKtiv0j64lenxBW_Gx79ZRg
    OSCMWmeSWHpurqLmiU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudduhedgudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderreejnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepheejgfdttdefleefteejieefudeuheelkedtgedtjeehieetueelheeu
    hfegheegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:1ocqYcZdRytyXsi9wZ0MyeMCuQN1zWk5wvoFdcWded3meQnimT-Ieg>
    <xmx:1ocqYXU9Dvc29wy9bjEtgdnokoqu6cNB-OGH_RJMA4USbx4VEgKNtg>
    <xmx:1ocqYSkNZ1ZFuK8B2Jtn1nxiZz4ay1Zdl1c29s8UHKMNJDbokJkWfg>
    <xmx:2IcqYUURSvPZrs0f9Bnc-HvGTMnZ01FNrDGQ1hZHs3eHB_3lGYj4rg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 35C0551C0060; Sat, 28 Aug 2021 15:00:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1125-g685cec594c-fm-20210825.001-g685cec59
Mime-Version: 1.0
Message-Id: <b4f0c6c4-76cd-47ae-b45c-7773cf250b5f@www.fastmail.com>
In-Reply-To: <20210828153642.19396-3-sven@svenpeter.dev>
References: <20210828153642.19396-1-sven@svenpeter.dev>
 <20210828153642.19396-3-sven@svenpeter.dev>
Date:   Sat, 28 Aug 2021 21:00:17 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     iommu@lists.linux-foundation.org
Cc:     "Joerg Roedel" <joro@8bytes.org>, "Will Deacon" <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Mohamed Mediouni" <mohamed.mediouni@caramail.com>,
        "Alexander Graf" <graf@amazon.com>,
        "Hector Martin" <marcan@marcan.st>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        linux-kernel@vger.kernel.org
Subject: =?UTF-8?Q?Re:_[PATCH_v2_2/8]_iommu/dma:_Fail_unaligned_map_requests_for_?=
 =?UTF-8?Q?untrusted_devs?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

and ofc shortly after submitting this series I realized this doesn't quite work yet:
swiotlb_tbl_map_single can return a 16KB buffer that's only aligned to a 4KB boundary. 
v3 will need at least another change to ensure that the result will be aligned to
a 16KB boundary as well.


Sven


On Sat, Aug 28, 2021, at 17:36, Sven Peter wrote:
> If swiotlb is enabled we should never try to create any mappings that
> would expose more memory than requested to the device.
> WARN_ON and refuse those mappings just in case.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  drivers/iommu/dma-iommu.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index e8eae34e9e4f..d6e273ec3de6 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -534,13 +534,20 @@ static dma_addr_t __iommu_dma_map(struct device 
> *dev, phys_addr_t phys,
>  	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>  	struct iova_domain *iovad = &cookie->iovad;
>  	size_t iova_off = iova_offset(iovad, phys);
> +	size_t size_aligned = iova_align(iovad, size + iova_off);
>  	dma_addr_t iova;
>  
>  	if (static_branch_unlikely(&iommu_deferred_attach_enabled) &&
>  	    iommu_deferred_attach(dev, domain))
>  		return DMA_MAPPING_ERROR;
>  
> -	size = iova_align(iovad, size + iova_off);
> +	if (IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev)) {
> +		if (WARN_ON(iova_off))
> +			return DMA_MAPPING_ERROR;
> +		if (WARN_ON(size_aligned != size))
> +			return DMA_MAPPING_ERROR;
> +	}
> +	size = size_aligned;
>  
>  	iova = iommu_dma_alloc_iova(domain, size, dma_mask, dev);
>  	if (!iova)
> -- 
> 2.25.1
> 
> 


-- 
Sven Peter
