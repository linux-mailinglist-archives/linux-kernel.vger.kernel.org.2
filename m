Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83DA8454709
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 14:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237125AbhKQNVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 08:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbhKQNV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 08:21:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BE2C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 05:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EZ7LImR146Ihj6AK9fKpOunzwWf1qPHV91wm5HsdWUw=; b=UIEYg54tyCeZh8T9S/BYb68gRw
        /Y91kgIdNN5U5b4ZxiHLTLeEXaxTMDOSpt2jyXTAcxSsmiwQ0nXWbOK8z/y84jk2P5UNGyJ7pdr4R
        I3kiCGox88D9VUi99OUmBn8P1CceoDaazrSSEMIzgG8B74u9SO/psSb/4zwR5a3GsGzchQ+RAX2HB
        0GSzsU5I1vtb1hnp4pW4yHCdI1fJCkq7K+vHKaxelj2vIFy7UXgnZge3WEh5yA71s8UJ1fD4L9WLY
        snfo/TC4j/4YcCz/jGngxkEwCtNpUQ8rWZ8TQsdDwIADnHQ3akLkhcMcbG4YyFI7Vg4u32fjDpUew
        TITpK6Ag==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mnKpV-007cmn-Ao; Wed, 17 Nov 2021 13:18:25 +0000
Date:   Wed, 17 Nov 2021 13:18:25 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MM: discard __GFP_ATOMIC
Message-ID: <YZUBIbALcSHn4Rub@casper.infradead.org>
References: <163712397076.13692.4727608274002939094@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163712397076.13692.4727608274002939094@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 03:39:30PM +1100, NeilBrown wrote:
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -676,12 +676,12 @@ static struct page *as_get_pde_page(struct tegra_smmu_as *as,
>  	 * allocate page in a sleeping context if GFP flags permit. Hence
>  	 * spinlock needs to be unlocked and re-locked after allocation.
>  	 */
> -	if (!(gfp & __GFP_ATOMIC))
> +	if (gfp & __GFP_DIRECT_RECLAIM)
>  		spin_unlock_irqrestore(&as->lock, *flags);
>  
>  	page = alloc_page(gfp | __GFP_DMA | __GFP_ZERO);
>  
> -	if (!(gfp & __GFP_ATOMIC))
> +	if (gfp & __GFP_DIRECT_RECLAIM)
>  		spin_lock_irqsave(&as->lock, *flags);
>  
>  	/*

Surely this should be gfpflags_allow_blocking() instead of poking about
in the innards of gfp flags?

This patch seems like a good simplification to me.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
