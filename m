Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4B742A27D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 12:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbhJLKnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 06:43:52 -0400
Received: from foss.arm.com ([217.140.110.172]:34298 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235981AbhJLKnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 06:43:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BBC61063;
        Tue, 12 Oct 2021 03:41:50 -0700 (PDT)
Received: from [10.57.25.70] (unknown [10.57.25.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0A883F694;
        Tue, 12 Oct 2021 03:41:48 -0700 (PDT)
Subject: Re: [RFC V3 07/13] arm64/mm: Add FEAT_LPA2 specific encoding
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com,
        maz@kernel.org, james.morse@arm.com, steven.price@arm.com
References: <1632998116-11552-1-git-send-email-anshuman.khandual@arm.com>
 <1632998116-11552-8-git-send-email-anshuman.khandual@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <e78741a0-8a45-5460-3a95-5eb42c63d055@arm.com>
Date:   Tue, 12 Oct 2021 11:41:47 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1632998116-11552-8-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/2021 11:35, Anshuman Khandual wrote:
> FEAT_LPA2 requires different PTE representation formats for both 4K and 16K
> page size config. This adds FEAT_LPA2 specific new PTE encodings as per ARM
> ARM (0487G.A) which updates [pte|phys]_to_[phys|pte](). The updated helpers
> would be used when FEAT_LPA2 gets enabled via CONFIG_ARM64_PA_BITS_52 on 4K
> and 16K page size. Although TTBR encoding and phys_to_ttbr() helper remains
> the same as FEAT_LPA for FEAT_LPA2 as well. It updates 'phys_to_pte' helper
> to accept a temporary variable and changes impacted call sites.
> 
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>   arch/arm64/include/asm/assembler.h     | 14 +++++++++++---
>   arch/arm64/include/asm/pgtable-hwdef.h |  4 ++++
>   arch/arm64/include/asm/pgtable.h       |  4 ++++
>   3 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index 3fbe04a..c1543067 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -628,6 +628,10 @@ alternative_endif
>   	 */
>   	orr	\pte, \phys, \phys, lsr #36
>   	and	\pte, \pte, #PTE_ADDR_MASK
> +#elif defined(CONFIG_ARM64_PA_BITS_52_LPA2)
> +	orr	\pte, \phys, \phys, lsr #42
> +	and	\pte, \pte, #PTE_ADDR_MASK | GENMASK(PAGE_SHIFT - 1, 10)
> +	and	\pte, \pte, #~GENMASK(PAGE_SHIFT - 1, 10)
>   #else  /* !CONFIG_ARM64_PA_BITS_52_LPA */
>   	mov	\pte, \phys
>   #endif /* CONFIG_ARM64_PA_BITS_52_LPA */
> @@ -635,9 +639,13 @@ alternative_endif
>   
>   	.macro	pte_to_phys, phys, pte
>   #ifdef CONFIG_ARM64_PA_BITS_52_LPA
> -	ubfiz	\phys, \pte, #(48 - 16 - 12), #16
> -	bfxil	\phys, \pte, #16, #32
> -	lsl	\phys, \phys, #16
> +	ubfiz	\phys, \pte, #(48 - PAGE_SHIFT - 12), #16
> +	bfxil	\phys, \pte, #PAGE_SHIFT, #(48 - PAGE_SHIFT)

nit: This looks like an unrelated change and is better suited for the 
previous patch.


Suzuki
