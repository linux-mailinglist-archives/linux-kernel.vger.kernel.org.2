Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C215B3E1A52
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 19:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239801AbhHER0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 13:26:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:52636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230004AbhHER0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 13:26:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E6AD61104;
        Thu,  5 Aug 2021 17:25:57 +0000 (UTC)
Date:   Thu, 5 Aug 2021 18:25:50 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        suzuki.poulose@arm.com, mark.rutland@arm.com, will@kernel.org,
        maz@kernel.org, james.morse@arm.com, steven.price@arm.com
Subject: Re: [RFC V2 05/10] arm64/mm: Add CONFIG_ARM64_PA_BITS_52_[LPA|LPA2]
Message-ID: <20210805172550.GG6719@arm.com>
References: <1627281445-12445-1-git-send-email-anshuman.khandual@arm.com>
 <1627281445-12445-6-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627281445-12445-6-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 12:07:20PM +0530, Anshuman Khandual wrote:
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b5b13a9..1999ac6 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -934,6 +934,12 @@ config ARM64_VA_BITS
>  	default 48 if ARM64_VA_BITS_48
>  	default 52 if ARM64_VA_BITS_52
>  
> +config ARM64_PA_BITS_52_LPA
> +	bool
> +
> +config ARM64_PA_BITS_52_LPA2
> +	bool
> +
>  choice
>  	prompt "Physical address space size"
>  	default ARM64_PA_BITS_48
> @@ -948,6 +954,7 @@ config ARM64_PA_BITS_52
>  	bool "52-bit (ARMv8.2)"
>  	depends on ARM64_64K_PAGES
>  	depends on ARM64_PAN || !ARM64_SW_TTBR0_PAN
> +	select ARM64_PA_BITS_52_LPA if ARM64_64K_PAGES
>  	help
>  	  Enable support for a 52-bit physical address space, introduced as
>  	  part of the ARMv8.2-LPA extension.

Do we actually need to bother with LPA, LPA2 options? We could just add
an extra defined(ARM64_64K_PAGES) in places, it may be easier to follow
in a few years time when we won't remember what LPA or LPA2 was. I
haven't got to the rest of the patches but it may just be simpler to
define the shifts separately for 52-bit based on 4K/16K/64K and ignore
the LPA/LPA2 distinction altogether (we'll still keep it for CPUID
checking though).

-- 
Catalin
