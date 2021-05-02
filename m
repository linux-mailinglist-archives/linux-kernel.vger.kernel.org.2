Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60B3370D08
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 16:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbhEBOIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 10:08:25 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:60095 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbhEBOGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 10:06:02 -0400
X-Originating-IP: 2.7.49.219
Received: from [192.168.1.100] (lfbn-lyo-1-457-219.w2-7.abo.wanadoo.fr [2.7.49.219])
        (Authenticated sender: alex@ghiti.fr)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id BCFFF1C0003;
        Sun,  2 May 2021 14:05:05 +0000 (UTC)
Subject: Re: [PATCH v2] riscv: Only extend kernel reservation if mapped
 read-only
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <02e05df076da23fc0f52c944bbf0a5cb99e95bd6.1619708542.git.geert+renesas@glider.be>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <b346f33d-a5aa-85c5-327d-626e03f2f5de@ghiti.fr>
Date:   Sun, 2 May 2021 10:05:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <02e05df076da23fc0f52c944bbf0a5cb99e95bd6.1619708542.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 4/29/21 à 11:05 AM, Geert Uytterhoeven a écrit :
> When the kernel mapping was moved outside of the linear mapping, the
> kernel memory reservation was increased, to take into account mapping
> granularity.  However, this is done unconditionally, regardless of
> whether the kernel memory is mapped read-only or not.
> 
> If this extension is not needed, up to 2 MiB may be lost, which has a
> big impact on e.g. Canaan K210 (64-bit nommu) platforms with only 8 MiB
> of RAM.
> 
> Reclaim the lost memory by only extending the reserved region when
> needed, i.e. depending on a simplified version of the conditional logic
> around the call to protect_kernel_linear_mapping_text_rodata().
> 
> Fixes: 2bfc6cd81bd17e43 ("riscv: Move kernel mapping outside of linear mapping")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>    - Simplify the conditional, as STRICT_KERNEL_RWX depends on
>      MMU && !XIP_KERNEL.
> 
> Only tested on K210 (SiPeed MAIX BiT):
> 
>      -Memory: 5852K/8192K available (1344K kernel code, 147K rwdata, 272K rodata, 106K init, 72K bss, 2340K reserved, 0K cma-reserved)
>      +Memory: 5948K/8192K available (1344K kernel code, 147K rwdata, 272K rodata, 106K init, 72K bss, 2244K reserved, 0K cma-reserved)
> 
> Yes, I was lucky, as only 96 KiB was lost ;-)
> ---
>   arch/riscv/mm/init.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 788eb222deacf994..3ebc0f5d2b73b42b 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -136,11 +136,16 @@ void __init setup_bootmem(void)
>   
>   	/*
>   	 * Reserve from the start of the kernel to the end of the kernel
> -	 * and make sure we align the reservation on PMD_SIZE since we will
> +	 */
> +#if defined(CONFIG_64BIT) && defined(CONFIG_STRICT_KERNEL_RWX)
> +	/*
> +	 * Make sure we align the reservation on PMD_SIZE since we will
>   	 * map the kernel in the linear mapping as read-only: we do not want
>   	 * any allocation to happen between _end and the next pmd aligned page.
>   	 */
> -	memblock_reserve(vmlinux_start, (vmlinux_end - vmlinux_start + PMD_SIZE - 1) & PMD_MASK);
> +	vmlinux_end = (vmlinux_end + PMD_SIZE - 1) & PMD_MASK;
> +#endif
> +	memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
>   
>   	/*
>   	 * memblock allocator is not aware of the fact that last 4K bytes of
> 

I tested this on the following configs:

- rv32_defconfig (build and valid on qemu)
- defconfig (with and without CONFIG_STRICT_KERNEL_RWX) (build and valid 
on qemu)
- xip kernel (build and valid on qemu)
- nommu_k210_defconfig (build only)

so you can add:

Tested-by: Alexandre Ghiti <alex@ghiti.fr>

Thank you again for that,

Alex
