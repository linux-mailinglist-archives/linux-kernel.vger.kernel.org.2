Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9024E3067C1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 00:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbhA0XWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 18:22:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:40684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234265AbhA0XFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 18:05:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A84E64DCE;
        Wed, 27 Jan 2021 23:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611788661;
        bh=3Jk8U/JdRNH+EkcfRbQkniS/eY1h1c1PGw5876r0Qeo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Or6G1XJCcSY0tUxiG7eWRkWxY1zu10ldDMd2CaVn53QLTsg/SwbcQyI1MDpuviHEA
         5bNiuF9k8OvH/fuA8Tlluiuc2oUOLR3UlbehfATDgAHWmrJOjHdQp8HlHff9b7ASz+
         s4+1vB7kRlylHeB7D6Y8fQVMAOW/ooLYkq7gFQarXqrtucnWcXCK5/q33yHVLkq9n3
         f45VGFywiax2CWgR0LOB9XQByXD/OasiIuAgI2RLzcbz9qRpOa3kN+AUPs4uNLa9QD
         rPIM5KMKR+gHpL2qXG5Z0l+emdbACmeH11j/73u6/Y9936Na0Z52d9P4WtiHgM1f2I
         rhQdgxwfZu14A==
Date:   Wed, 27 Jan 2021 23:04:14 +0000
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
Subject: Re: [PATCH v2 4/4] arm64: kaslr: support randomized module area with
 KASAN_VMALLOC
Message-ID: <20210127230413.GA1016@willie-the-truck>
References: <20210109103252.812517-1-lecopzer@gmail.com>
 <20210109103252.812517-5-lecopzer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210109103252.812517-5-lecopzer@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 09, 2021 at 06:32:52PM +0800, Lecopzer Chen wrote:
> After KASAN_VMALLOC works in arm64, we can randomize module region
> into vmalloc area now.
> 
> Test:
> 	VMALLOC area ffffffc010000000 fffffffdf0000000
> 
> 	before the patch:
> 		module_alloc_base/end ffffffc008b80000 ffffffc010000000
> 	after the patch:
> 		module_alloc_base/end ffffffdcf4bed000 ffffffc010000000
> 
> 	And the function that insmod some modules is fine.
> 
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> ---
>  arch/arm64/kernel/kaslr.c  | 18 ++++++++++--------
>  arch/arm64/kernel/module.c | 16 +++++++++-------
>  2 files changed, 19 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
> index 1c74c45b9494..a2858058e724 100644
> --- a/arch/arm64/kernel/kaslr.c
> +++ b/arch/arm64/kernel/kaslr.c
> @@ -161,15 +161,17 @@ u64 __init kaslr_early_init(u64 dt_phys)
>  	/* use the top 16 bits to randomize the linear region */
>  	memstart_offset_seed = seed >> 48;
>  
> -	if (IS_ENABLED(CONFIG_KASAN_GENERIC) ||
> -	    IS_ENABLED(CONFIG_KASAN_SW_TAGS))
> +	if (!IS_ENABLED(CONFIG_KASAN_VMALLOC) &&
> +	    (IS_ENABLED(CONFIG_KASAN_GENERIC) ||

CONFIG_KASAN_VMALLOC depends on CONFIG_KASAN_GENERIC so why is this
necessary?

Will
