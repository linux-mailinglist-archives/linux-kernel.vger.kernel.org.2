Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC6B3A617F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 12:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbhFNKsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 06:48:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58932 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232845AbhFNKlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 06:41:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623667159;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p15eO6Q/nsyt5ogtbEhJQwSJtPnYwhYxamg50YDzj14=;
        b=ZyAsmBfzScmknqf5ZCk+I+YyTU6O3uYrOsDfbt+WJzJ5KUPi+7fz72YuICcfMtD7iFJsyX
        uTEX3YU5a/jj8z8KKv8Zl5znDSjRltmxI7O7h1hlNfqPCUhU41K3n609O7XeNc71dZ5Uk/
        u4vBurk+NIdVACEEIFrB0ex4zKonWOI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-oBXtIZYnO3aw-MJrLLE23w-1; Mon, 14 Jun 2021 06:39:16 -0400
X-MC-Unique: oBXtIZYnO3aw-MJrLLE23w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AC7D80DDE2;
        Mon, 14 Jun 2021 10:39:15 +0000 (UTC)
Received: from [10.64.54.47] (vpn2-54-47.bne.redhat.com [10.64.54.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1420860871;
        Mon, 14 Jun 2021 10:39:12 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH] arm64/mm: Drop SECTION_[SHIFT|SIZE|MASK]
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
References: <1623658706-7182-1-git-send-email-anshuman.khandual@arm.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <e1d44fda-3e3b-531e-eeff-ce061abd2487@redhat.com>
Date:   Mon, 14 Jun 2021 22:40:17 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <1623658706-7182-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/21 6:18 PM, Anshuman Khandual wrote:
> SECTION_[SHIFT|SIZE|MASK] are essentially PMD_[SHIFT|SIZE|MASK]. But these
> create confusion being similar to generic sparsemem memory sections, which
> are derived from SECTION_SIZE_BITS. Section references have always implied
> PMD level block mapping. Instead just use all PMD level macros which would
> make it explicit and also remove confusion with sparsmem memory sections.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on v5.13-rc6.
> 
>   arch/arm64/include/asm/kernel-pgtable.h | 4 ++--
>   arch/arm64/include/asm/pgtable-hwdef.h  | 7 -------
>   arch/arm64/mm/mmu.c                     | 2 +-
>   3 files changed, 3 insertions(+), 10 deletions(-)
> 

It does introduce confusion to sparsemem section. The changes look
good to me:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
> index d44df9d62fc9..88b8d681ad91 100644
> --- a/arch/arm64/include/asm/kernel-pgtable.h
> +++ b/arch/arm64/include/asm/kernel-pgtable.h
> @@ -91,8 +91,8 @@
>   
>   /* Initial memory map size */
>   #if ARM64_SWAPPER_USES_SECTION_MAPS
> -#define SWAPPER_BLOCK_SHIFT	SECTION_SHIFT
> -#define SWAPPER_BLOCK_SIZE	SECTION_SIZE
> +#define SWAPPER_BLOCK_SHIFT	PMD_SHIFT
> +#define SWAPPER_BLOCK_SIZE	PMD_SIZE
>   #define SWAPPER_TABLE_SHIFT	PUD_SHIFT
>   #else
>   #define SWAPPER_BLOCK_SHIFT	PAGE_SHIFT
> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> index b82575a33f8b..40085e53f573 100644
> --- a/arch/arm64/include/asm/pgtable-hwdef.h
> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> @@ -71,13 +71,6 @@
>   #define PGDIR_MASK		(~(PGDIR_SIZE-1))
>   #define PTRS_PER_PGD		(1 << (VA_BITS - PGDIR_SHIFT))
>   
> -/*
> - * Section address mask and size definitions.
> - */
> -#define SECTION_SHIFT		PMD_SHIFT
> -#define SECTION_SIZE		(_AC(1, UL) << SECTION_SHIFT)
> -#define SECTION_MASK		(~(SECTION_SIZE-1))
> -
>   /*
>    * Contiguous page definitions.
>    */
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 89b66ef43a0f..380771610dd2 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -228,7 +228,7 @@ static void init_pmd(pud_t *pudp, unsigned long addr, unsigned long end,
>   		next = pmd_addr_end(addr, end);
>   
>   		/* try section mapping first */
> -		if (((addr | next | phys) & ~SECTION_MASK) == 0 &&
> +		if (((addr | next | phys) & ~PMD_MASK) == 0 &&
>   		    (flags & NO_BLOCK_MAPPINGS) == 0) {
>   			pmd_set_huge(pmdp, phys, prot);
>   
> 

