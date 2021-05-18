Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3CF5387C6F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 17:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350208AbhERP2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 11:28:17 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:45129 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350164AbhERP2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 11:28:16 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id CB2CC100005;
        Tue, 18 May 2021 15:26:53 +0000 (UTC)
Subject: Re: [PATCH] riscv: mm: Fix W+X mappings at boot
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210516170038.7de9c866@xhacker>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <35618c9a-acae-bc4f-e403-d06c0476166c@ghiti.fr>
Date:   Tue, 18 May 2021 17:26:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210516170038.7de9c866@xhacker>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

On 16/05/2021 11:00, Jisheng Zhang wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
> 
> When the kernel mapping was moved the last 2GB of the address space,
> (__va(PFN_PHYS(max_low_pfn))) is much smaller than the .data section
> start address, the last set_memory_nx() in protect_kernel_text_data()
> will fail, thus the .data section is still mapped as W+X. This results
> in below W+X mapping waring at boot. Fix it by passing the correct
> .data section page num to the set_memory_nx().
> 
> [    0.396516] ------------[ cut here ]------------
> [    0.396889] riscv/mm: Found insecure W+X mapping at address (____ptrval____)/0xffffffff80c00000
> [    0.398347] WARNING: CPU: 0 PID: 1 at arch/riscv/mm/ptdump.c:258 note_page+0x244/0x24a
> [    0.398964] Modules linked in:
> [    0.399459] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.13.0-rc1+ #14
> [    0.400003] Hardware name: riscv-virtio,qemu (DT)
> [    0.400591] epc : note_page+0x244/0x24a
> [    0.401368]  ra : note_page+0x244/0x24a
> [    0.401772] epc : ffffffff80007c86 ra : ffffffff80007c86 sp : ffffffe000e7bc30
> [    0.402304]  gp : ffffffff80caae88 tp : ffffffe000e70000 t0 : ffffffff80cb80cf
> [    0.402800]  t1 : ffffffff80cb80c0 t2 : 0000000000000000 s0 : ffffffe000e7bc80
> [    0.403310]  s1 : ffffffe000e7bde8 a0 : 0000000000000053 a1 : ffffffff80c83ff0
> [    0.403805]  a2 : 0000000000000010 a3 : 0000000000000000 a4 : 6c7e7a5137233100
> [    0.404298]  a5 : 6c7e7a5137233100 a6 : 0000000000000030 a7 : ffffffffffffffff
> [    0.404849]  s2 : ffffffff80e00000 s3 : 0000000040000000 s4 : 0000000000000000
> [    0.405393]  s5 : 0000000000000000 s6 : 0000000000000003 s7 : ffffffe000e7bd48
> [    0.405935]  s8 : ffffffff81000000 s9 : ffffffffc0000000 s10: ffffffe000e7bd48
> [    0.406476]  s11: 0000000000001000 t3 : 0000000000000072 t4 : ffffffffffffffff
> [    0.407016]  t5 : 0000000000000002 t6 : ffffffe000e7b978
> [    0.407435] status: 0000000000000120 badaddr: 0000000000000000 cause: 0000000000000003
> [    0.408052] Call Trace:
> [    0.408343] [<ffffffff80007c86>] note_page+0x244/0x24a
> [    0.408855] [<ffffffff8010c5a6>] ptdump_hole+0x14/0x1e
> [    0.409263] [<ffffffff800f65c6>] walk_pgd_range+0x2a0/0x376
> [    0.409690] [<ffffffff800f6828>] walk_page_range_novma+0x4e/0x6e
> [    0.410146] [<ffffffff8010c5f8>] ptdump_walk_pgd+0x48/0x78
> [    0.410570] [<ffffffff80007d66>] ptdump_check_wx+0xb4/0xf8
> [    0.410990] [<ffffffff80006738>] mark_rodata_ro+0x26/0x2e
> [    0.411407] [<ffffffff8031961e>] kernel_init+0x44/0x108
> [    0.411814] [<ffffffff80002312>] ret_from_exception+0x0/0xc
> [    0.412309] ---[ end trace 7ec3459f2547ea83 ]---
> [    0.413141] Checked W+X mappings: failed, 512 W+X pages found
> 
> Fixes: 2bfc6cd81bd17e43 ("riscv: Move kernel mapping outside of linear mapping")
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>   arch/riscv/mm/init.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 4faf8bd157ea..4c4c92ce0bb8 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -746,14 +746,18 @@ void __init protect_kernel_text_data(void)
>   	unsigned long init_data_start = (unsigned long)__init_data_begin;
>   	unsigned long rodata_start = (unsigned long)__start_rodata;
>   	unsigned long data_start = (unsigned long)_data;
> -	unsigned long max_low = (unsigned long)(__va(PFN_PHYS(max_low_pfn)));
> +#if defined(CONFIG_64BIT) && defined(CONFIG_MMU)
> +	unsigned long end_va = kernel_virt_addr + load_sz;
> +#else
> +	unsigned long end_va = (unsigned long)(__va(PFN_PHYS(max_low_pfn)));
> +#endif
>   
>   	set_memory_ro(text_start, (init_text_start - text_start) >> PAGE_SHIFT);
>   	set_memory_ro(init_text_start, (init_data_start - init_text_start) >> PAGE_SHIFT);
>   	set_memory_nx(init_data_start, (rodata_start - init_data_start) >> PAGE_SHIFT);
>   	/* rodata section is marked readonly in mark_rodata_ro */
>   	set_memory_nx(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT);
> -	set_memory_nx(data_start, (max_low - data_start) >> PAGE_SHIFT);
> +	set_memory_nx(data_start, (end_va - data_start) >> PAGE_SHIFT);
>   }
>   
>   void mark_rodata_ro(void)
> 

Thank you for taking the time to fix this, I had read a report here 
https://github.com/starfive-tech/linux/issues/17 but had no time yet to 
track this down.

Your fix seems good to me, but it intrigued me to see that for 32b 
kernels, the whole linear mapping is mapped as executable and then here, 
we remove this attribute. So I came up with a patch to map the kernel 
correctly once at first time and avoid fixing this mapping afterwards. I 
added you in cc of this patch, any comment is welcome.

Thanks,

Alex
