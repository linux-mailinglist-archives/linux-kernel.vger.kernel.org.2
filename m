Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5592348584
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 00:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbhCXXtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 19:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbhCXXsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 19:48:31 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A98C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 16:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=ZJXD/N6Limea4VVe7VOWBTx+vFdyKJO0h1A/Bqz0JPM=; b=YimCoJfEn9q9hWPDvfqNN8z3bL
        iyx/rtx7cG5GX+PQYb2Pyz5Kz8VBNSabBZWA4CtG636S1rQjxXDSzGZrP0Yr1Rcu/nOT2PE4irH97
        a6AaQ5MC8GzgWSaz7e2z4+xMfFr1YVySh8luGRENKsNpQfXwqO2VduXUu6HHINxFrVhoSMKJVghQF
        WyZ4lABxpwV0jhG/viOVsa9MuarnHHtWAaqUa89dvCWKLM6Yr7V7Fvywo+KMTwh3ECXMkHOhLQ6FW
        64yUTRfuNjtza7DC9jC50/aUdZ1MuoPcx7pAzKiXxRJalDfMkZXxfBd5s7Y0/wkrThCBIlts2A34E
        czfQ991g==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPDEj-000Md7-39; Wed, 24 Mar 2021 23:48:29 +0000
Subject: Re: [PATCH V2] ARM: xen/mm.c: A mundane typo fix
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, sstabellini@kernel.org,
        linux@armlinux.org.uk, xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210325043526.16289-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e3980acb-e6d7-645a-3be0-79cea6f2fd8e@infradead.org>
Date:   Wed, 24 Mar 2021 16:48:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210325043526.16289-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/21 9:35 PM, Bhaskar Chowdhury wrote:
> s/acrros/across/
> 
> Plus some words need prural version...so did it.(page->pages)
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  Changes from V1:
>   Randy's findings incorporated.
> 
>  arch/arm/xen/mm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
> index 467fa225c3d0..8596dd32dcd5 100644
> --- a/arch/arm/xen/mm.c
> +++ b/arch/arm/xen/mm.c
> @@ -105,8 +105,8 @@ bool xen_arch_need_swiotlb(struct device *dev,
>  	 *	- The Linux page refers to foreign memory
>  	 *	- The device doesn't support coherent DMA request
>  	 *
> -	 * The Linux page may be spanned acrros multiple Xen page, although
> -	 * it's not possible to have a mix of local and foreign Xen page.
> +	 * The Linux page may be spanned across multiple Xen pages, although
> +	 * it's not possible to have a mix of local and foreign Xen pages.
>  	 * Furthermore, range_straddles_page_boundary is already checking
>  	 * if buffer is physically contiguous in the host RAM.
>  	 *
> --


-- 
~Randy

