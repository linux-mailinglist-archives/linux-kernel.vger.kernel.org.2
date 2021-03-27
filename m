Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B2B34B60F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 11:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhC0KUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 06:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhC0KUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 06:20:37 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13717C0613B1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 03:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DVjYSyWQdbWu0/nbG+Yl381iPzwCZZyDqilArg4nupU=; b=RWob4ATBhI0omzHwVpSZz+5rJ
        PvShLfpkCXTTYHLmGnvRsSXA3voEtP4FgpJXYv2PekHAr/Yfe+aeZY19xJ+atsVLlzU/LNYtaFz8x
        KuR39CKrY6gHyr886ECyy74TXcZBHAadfN/GPWfM6GXo9LqmXtTTrsS1vqrvvRYY18yrqPEBTJL9H
        png8xT0eNBhQ7ETjTWk8Odqwn1d8n0Qm8tcMKwhsY2AjYkYT00Mk2toronqDhmirBYt+8IKlbJhdH
        L/c+EfeYhAIjyMuuFMIZWN+GclekFfxR/tzssc1YHqupY71wCFd3Rt8I1aWSCFMBA+PB6/oITQbC0
        rPHVGSsBA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51866)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lQ63B-0006Pg-TG; Sat, 27 Mar 2021 10:20:13 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lQ63A-0007xU-VS; Sat, 27 Mar 2021 10:20:12 +0000
Date:   Sat, 27 Mar 2021 10:20:12 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Shixin Liu <liushixin2@huawei.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: 9016/2: Make symbol 'tmp_pmd_table' static
Message-ID: <20210327102012.GT1463@shell.armlinux.org.uk>
References: <20210327083018.1922539-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210327083018.1922539-1-liushixin2@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Why do you have 9016/2 in the subject line? That's an identifier from
the patch system which shouldn't be in the subject line.

If you want to refer to something already committed, please do so via
the sha1 git hash and quote the first line of the commit description
within ("...") in the body of your commit description.

Thanks.

On Sat, Mar 27, 2021 at 04:30:18PM +0800, Shixin Liu wrote:
> Symbol 'tmp_pmd_table' is not used outside of kasan_init.c and only used
> when CONFIG_ARM_LPAE enabled. So marks it static and add it into CONFIG_ARM_LPAE.
> 
> Signed-off-by: Shixin Liu <liushixin2@huawei.com>
> ---
>  arch/arm/mm/kasan_init.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/kasan_init.c b/arch/arm/mm/kasan_init.c
> index 9c348042a724..3a06d3b51f97 100644
> --- a/arch/arm/mm/kasan_init.c
> +++ b/arch/arm/mm/kasan_init.c
> @@ -27,7 +27,9 @@
>  
>  static pgd_t tmp_pgd_table[PTRS_PER_PGD] __initdata __aligned(PGD_SIZE);
>  
> -pmd_t tmp_pmd_table[PTRS_PER_PMD] __page_aligned_bss;
> +#ifdef CONFIG_ARM_LPAE
> +static pmd_t tmp_pmd_table[PTRS_PER_PMD] __page_aligned_bss;
> +#endif
>  
>  static __init void *kasan_alloc_block(size_t size)
>  {
> -- 
> 2.25.1
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
