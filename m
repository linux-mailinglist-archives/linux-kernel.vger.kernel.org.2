Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364F73A5E76
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 10:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbhFNIiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 04:38:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232528AbhFNIiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 04:38:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8F7461370;
        Mon, 14 Jun 2021 08:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623659775;
        bh=gAds2DSRUgeIv4sXDXp+KcQsXS8BItWPveSU8A0iVNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GdF8d7Nc73ERCj4tKtd+EKrDaEZ8yJ+F4aspVmBPc26cxK39nB+ihm0IMhEfiv/TU
         1gVxIUDZ/DHzr4FI1RPcTRHYoY/RdE97a/vpCp2MAIcs554WO1B2fK1X0ubBbDt6Ug
         bqh/0hJVYLgGtx8gxV9sFUCXus7xfic8wZey1N0mya/hfKuuydHhT7oZTdqQXSwhK3
         3s4Y9E3px/QQPetqjhsFsJ/RVtYbfjLAqvQIoOYAA+wiNOQwAiDkiIyP848beGgwhB
         TTwaL3jiAdcG+02kBU6O5ItNZ7b77cipnHWwE25PPy7w304pYBubjq75QeXYFaT6cw
         jjy9xl4KgeLug==
Date:   Mon, 14 Jun 2021 09:36:10 +0100
From:   Will Deacon <will@kernel.org>
To:     Dong Aisheng <aisheng.dong@nxp.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, dongas86@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, catalin.marinas@arm.com
Subject: Re: [PATCH 1/1] dma: coherent: check no-map property for arm64
Message-ID: <20210614083609.GA18701@willie-the-truck>
References: <20210611131056.3731084-1-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611131056.3731084-1-aisheng.dong@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Catalin]

On Fri, Jun 11, 2021 at 09:10:56PM +0800, Dong Aisheng wrote:
> Coherent dma on ARM64 also can't work with mapped system ram,
> that means 'no-map' property must be specified in dts.
> Add the missing check for ARM64 platforms as well.
> Besides 'no-map' checking, 'linux,dma-default' feature is also
> enabled for ARM64 along with this patch.

Please can you explain _why_ it can't work? We don't need to tear down
aliases from the linear map for the streaming DMA API, so why is this
case different? Also, coherent devices wouldn't need this either way,
would they? What problem are you solving here?

Thanks,

Will

> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  kernel/dma/coherent.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
> index 5b5b6c7ec7f2..d1831da7afba 100644
> --- a/kernel/dma/coherent.c
> +++ b/kernel/dma/coherent.c
> @@ -356,7 +356,7 @@ static int __init rmem_dma_setup(struct reserved_mem *rmem)
>  	if (of_get_flat_dt_prop(node, "reusable", NULL))
>  		return -EINVAL;
>  
> -#ifdef CONFIG_ARM
> +#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
>  	if (!of_get_flat_dt_prop(node, "no-map", NULL)) {
>  		pr_err("Reserved memory: regions without no-map are not yet supported\n");
>  		return -EINVAL;
> -- 
> 2.25.1
> 
