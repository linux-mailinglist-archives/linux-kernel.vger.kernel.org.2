Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855573E8CB2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 10:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236587AbhHKI7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 04:59:17 -0400
Received: from foss.arm.com ([217.140.110.172]:45366 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236500AbhHKI7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 04:59:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4DFF106F;
        Wed, 11 Aug 2021 01:58:45 -0700 (PDT)
Received: from [10.57.13.73] (unknown [10.57.13.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CD7F3F70D;
        Wed, 11 Aug 2021 01:58:44 -0700 (PDT)
Subject: Re: [PATCH] ARM: NOMMU: Return true/false (not 1/0) from bool
 functions
To:     Huilong Deng <denghuilong@cdjrlc.com>, linux@armlinux.org.uk,
        ira.weiny@intel.com, sfr@canb.auug.org.au,
        akpm@linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210811082041.32309-1-denghuilong@cdjrlc.com>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <1e30b659-a91a-58f6-f9aa-d0f0259eb9e8@arm.com>
Date:   Wed, 11 Aug 2021 09:58:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210811082041.32309-1-denghuilong@cdjrlc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/21 9:20 AM, Huilong Deng wrote:
> ./arch/arm/mm/nommu.c:59:8-9: WARNING: return of 0/1 in function
> 'security_extensions_enabled' with return type bool
> 
> Signed-off-by: Huilong Deng <denghuilong@cdjrlc.com>
> ---
>  arch/arm/mm/nommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
> index 2658f52903da..7256ac159acb 100644
> --- a/arch/arm/mm/nommu.c
> +++ b/arch/arm/mm/nommu.c
> @@ -56,7 +56,7 @@ static inline bool security_extensions_enabled(void)
>  	if ((read_cpuid_id() & 0x000f0000) == 0x000f0000)
>  		return cpuid_feature_extract(CPUID_EXT_PFR1, 4) ||
>  			cpuid_feature_extract(CPUID_EXT_PFR1, 20);
> -	return 0;
> +	return false;
>  }
>  
>  unsigned long setup_vectors_base(void)
> 

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

Please, submit it into RMK's Patch system [1]

[1] https://www.armlinux.org.uk/developer/patches/

Cheers
Vladimir
