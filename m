Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA9C3FCAA0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 17:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238733AbhHaPSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 11:18:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233369AbhHaPSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 11:18:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5432360724;
        Tue, 31 Aug 2021 15:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630423071;
        bh=Gze4tbWximZZAQoREaDEMclW35VaWPdDTv5B4j6qHX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OeyrkZc+CBDZ1kqmQ9WpxRHA7iBGHgRCtg6iJhsdEAhaiG4ZStFXL2Mm7pDluNsMW
         gXi28iVYXOjEXS6s7DOi5h5kKTD/9rtqErELDvWJeFP4UPF8ork8X80pXNeYQherK0
         fBJ4Q0fnA8wPw5gk+eSwWOzoiERQJ0ajAU2SnFwkXBUE268P0zkU0ktzj2X9dO9w2b
         zZKGAIdeyAcEQYoua1Ivq2uteKDRRhzi8E9eou4/LhVp0G7tVUBJGr6X62tNOHv+vQ
         gsk4f71fg6bpdbge4+rkUO5SPdD65cUbgo9yQBI6qS58/xse/Q1Huo+ts5ZUxZ6mIN
         w6QIz/QPOaUPA==
Date:   Tue, 31 Aug 2021 16:17:47 +0100
From:   Will Deacon <will@kernel.org>
To:     Claire Chang <tientzu@chromium.org>
Cc:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        konrad.wilk@oracle.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux@roeck-us.net
Subject: Re: [PATCH] swiotlb: use depends on for DMA_RESTRICTED_POOL
Message-ID: <20210831151746.GB32001@willie-the-truck>
References: <20210827034802.1065294-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827034802.1065294-1-tientzu@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 11:48:02AM +0800, Claire Chang wrote:
> Use depends on instead of select for DMA_RESTRICTED_POOL; otherwise it
> will make SWIOTLB user configurable and cause compile errors for some
> arch (e.g. mips).
> 
> Fixes: 0b84e4f8b793 ("swiotlb: Add restricted DMA pool initialization")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> ---
>  kernel/dma/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index fd4db714d86b..1b02179758cb 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -82,8 +82,7 @@ config SWIOTLB
>  
>  config DMA_RESTRICTED_POOL
>  	bool "DMA Restricted Pool"
> -	depends on OF && OF_RESERVED_MEM
> -	select SWIOTLB
> +	depends on OF && OF_RESERVED_MEM && SWIOTLB
>  	help
>  	  This enables support for restricted DMA pools which provide a level of
>  	  DMA memory protection on systems with limited hardware protection

Acked-by: Will Deacon <will@kernel.org>

Will
