Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A55C3825A2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 09:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235344AbhEQHsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 03:48:06 -0400
Received: from foss.arm.com ([217.140.110.172]:44090 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232909AbhEQHsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 03:48:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E2E51042;
        Mon, 17 May 2021 00:46:48 -0700 (PDT)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D152C3F719;
        Mon, 17 May 2021 00:46:46 -0700 (PDT)
Subject: Re: [PATCH] ARM: update __swp_entry_to_pte() to use PTE_TYPE_FAULT
To:     Russell King <rmk+kernel@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        linux-kernel@vger.kernel.org
References: <E1lh9VH-0002Lz-Pd@rmk-PC.armlinux.org.uk>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <d28673fc-14db-dfd9-6d20-049807891b2e@arm.com>
Date:   Mon, 17 May 2021 13:17:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <E1lh9VH-0002Lz-Pd@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/13/21 4:57 PM, Russell King wrote:
> Swap entries use a faulting PTE which have the least two significant
> bits as zero. Due to this, the use of PTE_TYPE_FAULT was overlooked,
> but really should have been included in __swp_entry_to_pte().
> 
> Convert this macro to use PTE_TYPE_FAULT to properly document what is
> going on here, and use __pte() to convert the swp_entry_t to a pte_t.
> 
> This results in no change to the resulting kernel text.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  arch/arm/include/asm/pgtable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
> index c02f24400369..c43e07d6046d 100644
> --- a/arch/arm/include/asm/pgtable.h
> +++ b/arch/arm/include/asm/pgtable.h
> @@ -303,7 +303,7 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>  #define __swp_entry(type,offset) ((swp_entry_t) { ((type) << __SWP_TYPE_SHIFT) | ((offset) << __SWP_OFFSET_SHIFT) })
>  
>  #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
> -#define __swp_entry_to_pte(swp)	((pte_t) { (swp).val })
> +#define __swp_entry_to_pte(swp)	__pte((swp).val | PTE_TYPE_FAULT)

LGTM and FWIW..

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

>  
>  /*
>   * It is an error for the kernel to have more swap files than we can
> 
