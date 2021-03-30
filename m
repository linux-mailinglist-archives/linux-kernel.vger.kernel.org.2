Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A7F34E1AE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 09:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhC3HDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 03:03:17 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:45747 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhC3HCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 03:02:55 -0400
X-Originating-IP: 2.7.49.219
Received: from [192.168.1.12] (lfbn-lyo-1-457-219.w2-7.abo.wanadoo.fr [2.7.49.219])
        (Authenticated sender: alex@ghiti.fr)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id C643820002;
        Tue, 30 Mar 2021 07:02:50 +0000 (UTC)
Subject: Re: [PATCH] implement flush_cache_vmap and flush_cache_vunmap for
 RISC-V
To:     Jiuyang Liu <liu@jiuyang.me>
Cc:     Andrew Waterman <waterman@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210329015510.44110-1-liu@jiuyang.me>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <9749165b-32d4-94a2-7c8a-e219fdf1b102@ghiti.fr>
Date:   Tue, 30 Mar 2021 03:02:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210329015510.44110-1-liu@jiuyang.me>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiuyang,

Le 3/28/21 à 9:55 PM, Jiuyang Liu a écrit :
> This patch implements flush_cache_vmap and flush_cache_vunmap for
> RISC-V, since these functions might modify PTE. Without this patch,
> SFENCE.VMA won't be added to related codes, which might introduce a bug
> in some out-of-order micro-architecture implementations.
> 
> Signed-off-by: Jiuyang Liu <liu@jiuyang.me>
> ---
>   arch/riscv/include/asm/cacheflush.h | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
> index 23ff70350992..4adf25248c43 100644
> --- a/arch/riscv/include/asm/cacheflush.h
> +++ b/arch/riscv/include/asm/cacheflush.h
> @@ -8,6 +8,14 @@
>   
>   #include <linux/mm.h>
>   
> +/*
> + * flush_cache_vmap and flush_cache_vunmap might modify PTE, needs SFENCE.VMA.

"might modify PTE" is not entirely true I think, this is what happens 
before using this function that might modify PTE, those functions ensure 
those modifications are made visible.

> + * - flush_cache_vmap is invoked after map_kernel_range() has installed the page table entries.
> + * - flush_cache_vunmap is invoked before unmap_kernel_range() deletes the page table entries
> + */
> +#define flush_cache_vmap(start, end) flush_tlb_all()
> +#define flush_cache_vunmap(start, end) flush_tlb_all()
> +
>   static inline void local_flush_icache_all(void)
>   {
>   	asm volatile ("fence.i" ::: "memory");
> 

FWIW, you can add:

Reviewed-by: Alexandre Ghiti <alex@ghiti.fr>

Thanks,

Alex
