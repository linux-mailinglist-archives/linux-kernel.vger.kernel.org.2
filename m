Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99013877AF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 13:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244881AbhERLbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 07:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348223AbhERLbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 07:31:10 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13B5C06138B
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 04:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RVUhSCgd6iQAK0YSfHil0g0540QhJdzDOaZHYw4efBo=; b=tl66YL0JYskY6r9w4wyuz1msm
        2nN5acglOY9mroY2uRDEigtHcNw/lxmbReo/GR0Wt8VyC5ni7zKmpRaOJLOCpfgK/dxHXOUIL5tCq
        aGcRVwrUs7lIyjwTfFnao1fs88QDm9YEdiHycchb9PR+GFUC1YH2UDApAY2ZT8SvG/z9PncAvC6Zp
        kZIL+XLsXuZroU2QD/0o93SjzghJ1ilf3PGOjpTy4b7OIhJYnRvzicYZQqZMJcjfL32lzzLH9ul/p
        otEiCDS+/fseB8D12RJcshFcL8vwUt2lQD8UdU5aY2WC3ZoQ7Ebs/yDoK5aYREWJ3OA6nFBvVCdEq
        QYEjvkmBw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44130)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lixuq-0004B6-8m; Tue, 18 May 2021 12:29:36 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lixum-0007r3-6a; Tue, 18 May 2021 12:29:32 +0100
Date:   Tue, 18 May 2021 12:29:32 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Yanfei Xu <yanfei.xu@windriver.com>
Cc:     rppt@kernel.org, ardb@kernel.org, linus.walleij@linaro.org,
        akpm@linux-foundation.org, carver4lio@163.com,
        tiantao6@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: make the size of vmalloc in cmdline and meminfo
 uniform
Message-ID: <20210518112932.GV12395@shell.armlinux.org.uk>
References: <20210518111254.3820480-1-yanfei.xu@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518111254.3820480-1-yanfei.xu@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 07:12:54PM +0800, Yanfei Xu wrote:
> The value of "vmalloc=" set in cmdline is always 8M more than the value
> of "VmallocTotal" in meminfo. When use the "vmalloc=" parameter, user
> expect to get the size what they input, and no need to consider the 8M
> "hole" hided in codes. This commit make real vmalloc size equal to value
> of "vmalloc=" in cmdline.
> 
> Also, the commit will reduce the size of vmalloc printed in boot message
> by 8M when the size set in cmdline is irrational.

Hi,

I think I'd like to do several cleanups with this:

1. change vmalloc_min to be an unsigned long.
2. exclude VMALLOC_OFFSET from vmalloc_min, moving it into
   adjust_lowmem_bounds where vmalloc_min is used.
3. rename vmalloc_min to be vmalloc_start
4. enforce vmalloc_start to be a multiple of 2MiB
5. in early_vmalloc(), calculate vmalloc_max as:
	VMALLOC_END - (PAGE_OFFSET + SZ_32M + VMALLOC_OFFSET)
   and use that to set the upper bound of vmalloc_reserve (which is
   something your patch doesn't do, which I think is a bug.

Thoughts?

> 
> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
> ---
>  arch/arm/mm/mmu.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index c1e12aab67b8..287c5115af4d 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -1133,19 +1133,20 @@ static int __init early_vmalloc(char *arg)
>  {
>  	unsigned long vmalloc_reserve = memparse(arg, NULL);
>  
> -	if (vmalloc_reserve < SZ_16M) {
> -		vmalloc_reserve = SZ_16M;
> +	vmalloc_reserve = ALIGN_DOWN(vmalloc_reserve, SZ_8M);
> +	if (vmalloc_reserve < SZ_8M) {
> +		vmalloc_reserve = SZ_8M;
>  		pr_warn("vmalloc area too small, limiting to %luMB\n",
>  			vmalloc_reserve >> 20);
>  	}
>  
>  	if (vmalloc_reserve > VMALLOC_END - (PAGE_OFFSET + SZ_32M)) {
> -		vmalloc_reserve = VMALLOC_END - (PAGE_OFFSET + SZ_32M);
> +		vmalloc_reserve = VMALLOC_END - (PAGE_OFFSET + SZ_32M + VMALLOC_OFFSET);
>  		pr_warn("vmalloc area is too big, limiting to %luMB\n",
>  			vmalloc_reserve >> 20);
>  	}
>  
> -	vmalloc_min = (void *)(VMALLOC_END - vmalloc_reserve);
> +	vmalloc_min = (void *)(VMALLOC_END - vmalloc_reserve - VMALLOC_OFFSET);
>  	return 0;
>  }
>  early_param("vmalloc", early_vmalloc);
> -- 
> 2.27.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
