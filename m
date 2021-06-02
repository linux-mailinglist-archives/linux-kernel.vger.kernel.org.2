Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4F4399471
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 22:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhFBUVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 16:21:18 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:54615 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229467AbhFBUVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 16:21:17 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id DBCFD5C0113;
        Wed,  2 Jun 2021 16:19:33 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute3.internal (MEProxy); Wed, 02 Jun 2021 16:19:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm1; bh=01wA9S6MZOs7DE06HogddKBNYc8V
        E/C8ZpyOl0QzHAo=; b=JMBUiMOCVqIogGlSZiL/dnjV+EWeSRoOG29ec9pK/uX3
        7vTOeLT0V/JLXPmM/5G1iveLsrJXYsiTp4WBKYMBGp2nq3pZp9kWVSC1Yg6iEuUX
        xlJ+5lP5UNmRC59CK0fImmNjyHi8xHVRqqA1ouRHhBedReAau5oBDLtE6HJVKDPi
        BVajSYOoEUUjDw9N9fCY63QmQ2NtS/UBWdq5OphkmDfXynFzYVfCvmvlurKivP7r
        2F5agGqM2G2e9hU0ntqLg8X2457gUxG+ElV7X2FbRi4WuhCqCpJTWHbM1fZ02fnV
        IjqimwSCmAAgDMpmFHTyA4WFV6Md3xuKulCbkwrMmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=01wA9S
        6MZOs7DE06HogddKBNYc8VE/C8ZpyOl0QzHAo=; b=Zl4HdgRRd7VItVgDDou2zR
        ybof2PLdNR8fyogC4Z77sxp+Mzx930n2xQvF4BVGyEe0vEB2qCvoby7L7g4YdANA
        6EfSrANYxx1nQlsMLNvJrukHGGcI/cO8CBgXD4JjGDvvy5suwQ7E+UCbxi1iEv1a
        jyy6j1MSeO1yHQA9uw6gFTRArHBe0RgxS5ABg8PDXrR9tJYoYVZGnYKBX2GUi/hw
        8cuBv7UsPEkPuDxApJ1wZXTHwHLLRmpEtn+4+WrDonpsWPo8NczBCzf4KF6UGJXq
        nEUGw30K1cnla9bzMoQYsgMibpJirIt0qIdITUJHtWkqxq5jonWYqEqi7yQvicng
        ==
X-ME-Sender: <xms:1ee3YHSpEhsMXNysQrvnt0u74_aCeuziLorgXmXSv9yhhwuBM_lz9g>
    <xme:1ee3YIx6FmLWDzfYy9UR44CphG35xGp97K125_jBrVk5z8JKH3UeBmIplcQSXNP7f
    5MSai_uYTs9JO1jxiY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeljedgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnheptddujeettefggedttedvieeufffgudetgeejgffhfeduueevudffueet
    tdetfeefnecuffhomhgrihhnpehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnsehs
    vhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:1ee3YM1NHE54ttXXC5Af87-imj8Kz-mFnNUFwbIcWDInOW2bMtIl7w>
    <xmx:1ee3YHC60nNSrfxWhD5VQTLqUtxTimCQTnk3m8w3_r4_PzvFAaoYxA>
    <xmx:1ee3YAjGvd_l6g8ihEU3j-u4adC4QdoS7n3mzbX3sEyxM6_vtlJqkw>
    <xmx:1ee3YLVTDfnjEcY4MkDWlzt8KtUAtbkLPkfqI1K_JRUWdXvOdy-rPg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4AB6051C0060; Wed,  2 Jun 2021 16:19:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-519-g27a961944e-fm-20210531.001-g27a96194
Mime-Version: 1.0
Message-Id: <c72a45e4-c156-4a62-bfd7-9cf8a31ff499@www.fastmail.com>
In-Reply-To: <20200914072319.6091-1-srinath.mannam@broadcom.com>
References: <20200914072319.6091-1-srinath.mannam@broadcom.com>
Date:   Wed, 02 Jun 2021 22:18:21 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Srinath Mannam" <srinath.mannam@broadcom.com>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>, poza@codeaurora.org
Cc:     iommu <iommu@lists.linux-foundation.org>,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iommu/dma: Fix IOVA reserve dma ranges
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just ran into the exact same issue while working on the M1 DART IOMMU driver
and it was fixed by this commit. Thanks!

Would be great if this could be picked up.

Tested-by: Sven Peter <sven@svenpeter.dev>


Best,


Sven


On Mon, Sep 14, 2020, at 09:23, Srinath Mannam via iommu wrote:
> Fix IOVA reserve failure in the case when address of first memory region
> listed in dma-ranges is equal to 0x0.
> 
> Fixes: aadad097cd46f ("iommu/dma: Reserve IOVA for PCIe inaccessible 
> DMA address")
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> ---
> Changes from v2:
>    Modify error message with useful information based on Bjorn's 
> comments.
> 
> Changes from v1:
>    Removed unnecessary changes based on Robin's review comments.
> 
>  drivers/iommu/dma-iommu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 5141d49a046b..5b9791f35c5e 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -217,9 +217,11 @@ static int iova_reserve_pci_windows(struct pci_dev *dev,
>  			lo = iova_pfn(iovad, start);
>  			hi = iova_pfn(iovad, end);
>  			reserve_iova(iovad, lo, hi);
> -		} else {
> +		} else if (end < start) {
>  			/* dma_ranges list should be sorted */
> -			dev_err(&dev->dev, "Failed to reserve IOVA\n");
> +			dev_err(&dev->dev,
> +				"Failed to reserve IOVA [%#010llx-%#010llx]\n",
> +				start, end);
>  			return -EINVAL;
>  		}
>  
> -- 
> 2.17.1
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
> 
