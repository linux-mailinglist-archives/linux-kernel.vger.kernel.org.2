Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D34345FAC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 14:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhCWN3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 09:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbhCWN3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 09:29:06 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64D1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 06:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=N22ubGJYBatnLB0FQ3aMgIjwQpebKFwTd2aBJXaAtcE=; b=dVP8Rnruf62ZNvmbO5B0fQyBT
        kNVTyXiDJvSL4bKQGHMBP84vP5U6BrykWzRDEUlOaIcnUnnRyzFnFGnwdZxLg+nvRu5VEuSqhWXEb
        Y3WgxnWAAcanp5GhzZeJaNSy5vGfLyNnmcJahmw7BtBMQHMmV9JqOCscWhXZdJ3CZsIaiBCyBzP2h
        Bh5AO1/XjT2ZPD2wdUb5TKqX4MDwHeHCgSJEQw7CqyHIqdfwbgtbP509FD18+rBmhhRX7ng9cdiO0
        iN4vQa6p6iWFW/0sQrxU2X7u2pdxA1J47TNAQP9jm6mVfEmJTQ4E+Kiasv2FND7oXKfp4a1sBiWT3
        eKpHlITDg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51624)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lOh5a-0007la-IS; Tue, 23 Mar 2021 13:28:54 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lOh5W-0004Bp-JP; Tue, 23 Mar 2021 13:28:50 +0000
Date:   Tue, 23 Mar 2021 13:28:50 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dma-mapping: fix out of bounds access in CMA
Message-ID: <20210323132850.GB1463@shell.armlinux.org.uk>
References: <20210323131423.2581218-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323131423.2581218-1-arnd@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 02:14:13PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Dereferencing a zero-length array is always a bug, and we get a warning
> with 'make W=1' here:
> 
> arch/arm/mm/dma-mapping.c: In function 'dma_contiguous_early_fixup':
> arch/arm/mm/dma-mapping.c:395:15: error: array subscript <unknown> is outside array bounds of 'struct dma_contig_early_reserve[0]' [-Werror=array-bounds]
>   395 |  dma_mmu_remap[dma_mmu_remap_num].base = base;
>       |  ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
> arch/arm/mm/dma-mapping.c:389:40: note: while referencing 'dma_mmu_remap'
>   389 | static struct dma_contig_early_reserve dma_mmu_remap[MAX_CMA_AREAS] __initdata;
>       |                                        ^~~~~~~~~~~~~
> arch/arm/mm/dma-mapping.c:396:15: error: array subscript <unknown> is outside array bounds of 'struct dma_contig_early_reserve[0]' [-Werror=array-bounds]
> 
> Add a runtime check to prevent this from happening, while also
> avoiding the compile-time warning.
> 
> Fixes: c79095092834 ("ARM: integrate CMA with DMA-mapping subsystem")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mm/dma-mapping.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index c4b8df2ad328..af29344fb150 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -392,6 +392,11 @@ static int dma_mmu_remap_num __initdata;
>  
>  void __init dma_contiguous_early_fixup(phys_addr_t base, unsigned long size)
>  {
> +	if (!MAX_CMA_AREAS || dma_mmu_remap_num >= MAX_CMA_AREAS) {
> +		WARN_ONCE(1, "number of CMA areas\n");
> +		return;
> +	}
> +

What if dma_mmu_remap_num were negative - that condition is not checked
and will also result in an overflow of the array. If we're being fussy
enough to bounds check, we ought to do it properly.

So, I think a better solution would be to make dma_mmu_remap_num an
unsigned int, and then to use:

	if (dma_mmu_remap_num >= ARRAY_SIZE(dma_mmu_remap)) {
		...
	}

which is really the condition we're after here.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
