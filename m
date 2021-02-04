Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB45230F367
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 13:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbhBDMqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 07:46:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:55760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236055AbhBDMqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 07:46:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4FBF664F41;
        Thu,  4 Feb 2021 12:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612442751;
        bh=SOnQy9RxOKww3FwtcmXtlNIaVMdG5cK/YIx9GSd2M48=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dG/U0a+xaSr261uO6Sj/SU5bdTLBoZ8g1XHARG/8dEABI3D4ZPIyOFPS/QsysXGC2
         sZL7qauWqARMR6/bElBXzMasqAVx7p+ROhtZo2MKsyJaSoC74GT2fIPx3k8IoZSmyP
         YdzMr2K1eqnkENuzQNKlHpf6xx85c1+DE2elfQPasxfufiZWCbjkTDFGnGWQbqed/U
         hbVmNI6p0caFF0aecWklnKLhjQRWPEdIqf9YoOlZXmZXhmHAWttM7hnzi+q0o3JtRD
         iT67+pIC457vEjSd2+iCbh6VuUGvW/Erpqqh2Z5Euu66XtJbknR93QiqmbvasIrGvU
         EJ4ggbI1KF9rA==
Date:   Thu, 4 Feb 2021 12:45:43 +0000
From:   Will Deacon <will@kernel.org>
To:     Lecopzer Chen <lecopzer@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        dan.j.williams@intel.com, aryabinin@virtuozzo.com,
        glider@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        linux-mediatek@lists.infradead.org, yj.chiang@mediatek.com,
        catalin.marinas@arm.com, ardb@kernel.org, andreyknvl@google.com,
        broonie@kernel.org, linux@roeck-us.net, rppt@kernel.org,
        tyhicks@linux.microsoft.com, robin.murphy@arm.com,
        vincenzo.frascino@arm.com, gustavoars@kernel.org,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Subject: Re: [PATCH v2 1/4] arm64: kasan: don't populate vmalloc area for
 CONFIG_KASAN_VMALLOC
Message-ID: <20210204124543.GA20468@willie-the-truck>
References: <20210109103252.812517-1-lecopzer@gmail.com>
 <20210109103252.812517-2-lecopzer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210109103252.812517-2-lecopzer@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 09, 2021 at 06:32:49PM +0800, Lecopzer Chen wrote:
> Linux support KAsan for VMALLOC since commit 3c5c3cfb9ef4da9
> ("kasan: support backing vmalloc space with real shadow memory")
> 
> Like how the MODULES_VADDR does now, just not to early populate
> the VMALLOC_START between VMALLOC_END.
> similarly, the kernel code mapping is now in the VMALLOC area and
> should keep these area populated.
> 
> Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> ---
>  arch/arm64/mm/kasan_init.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> index d8e66c78440e..39b218a64279 100644
> --- a/arch/arm64/mm/kasan_init.c
> +++ b/arch/arm64/mm/kasan_init.c
> @@ -214,6 +214,7 @@ static void __init kasan_init_shadow(void)
>  {
>  	u64 kimg_shadow_start, kimg_shadow_end;
>  	u64 mod_shadow_start, mod_shadow_end;
> +	u64 vmalloc_shadow_start, vmalloc_shadow_end;
>  	phys_addr_t pa_start, pa_end;
>  	u64 i;
>  
> @@ -223,6 +224,9 @@ static void __init kasan_init_shadow(void)
>  	mod_shadow_start = (u64)kasan_mem_to_shadow((void *)MODULES_VADDR);
>  	mod_shadow_end = (u64)kasan_mem_to_shadow((void *)MODULES_END);
>  
> +	vmalloc_shadow_start = (u64)kasan_mem_to_shadow((void *)VMALLOC_START);
> +	vmalloc_shadow_end = (u64)kasan_mem_to_shadow((void *)VMALLOC_END);
> +
>  	/*
>  	 * We are going to perform proper setup of shadow memory.
>  	 * At first we should unmap early shadow (clear_pgds() call below).
> @@ -241,12 +245,21 @@ static void __init kasan_init_shadow(void)
>  
>  	kasan_populate_early_shadow(kasan_mem_to_shadow((void *)PAGE_END),
>  				   (void *)mod_shadow_start);
> -	kasan_populate_early_shadow((void *)kimg_shadow_end,
> -				   (void *)KASAN_SHADOW_END);
> +	if (IS_ENABLED(CONFIG_KASAN_VMALLOC)) {

Do we really need yet another CONFIG option for KASAN? What's the use-case
for *not* enabling this if you're already enabling one of the KASAN
backends?

> +		kasan_populate_early_shadow((void *)vmalloc_shadow_end,
> +					    (void *)KASAN_SHADOW_END);
> +		if (vmalloc_shadow_start > mod_shadow_end)

To echo Ard's concern: when is the above 'if' condition true?

Will
