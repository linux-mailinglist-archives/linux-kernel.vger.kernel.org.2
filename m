Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73EE39B93D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 14:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhFDMzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 08:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhFDMzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 08:55:19 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C590C06174A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 05:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=gKcoTjJ2VlyckWFo3T9gNemxZ5qwlJfJiz
        9LkkbAaPE=; b=ZiqnRRR03gXYeWIR8Z+eT+3GQrG0Rt71d20E8kGKoyOKNOiq9u
        HaL05MItx+UnNL3dwC8Qbx7Fe5cyd5JTv2zKjAub/eh9cYPKYMCphTyJKKG9B3Z9
        xNk4wJSSlH9JhGQ1rQ1pvnMXBfdrb3lzXXJrNSK4cA2utnMQeS7a2ugtc=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygCHj1s5Irpg5VOQAA--.14115S2;
        Fri, 04 Jun 2021 20:53:13 +0800 (CST)
Date:   Fri, 4 Jun 2021 20:47:43 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] riscv: Simplify xip and !xip kernel address
 conversion macros
Message-ID: <20210604204743.7bdd4fbd@xhacker>
In-Reply-To: <20210604114950.1446390-3-alex@ghiti.fr>
References: <20210604114950.1446390-1-alex@ghiti.fr>
        <20210604114950.1446390-3-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygCHj1s5Irpg5VOQAA--.14115S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGFykKw43Xw4fuw43uFy7GFg_yoWrJrW7pr
        n5KryxKrWSgrW0g3yjvwn8ur98JwnxW343KFsrKr95A3Z8ta1xWa4v9wnxur1qqFW0qFs3
        ZF97Jr129w1jqwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkvb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07beAp5UUUUU=
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On Fri,  4 Jun 2021 13:49:48 +0200
Alexandre Ghiti <alex@ghiti.fr> wrote:

> To simplify the kernel address conversion code, make the same definition of
> kernel_mapping_pa_to_va and kernel_mapping_va_to_pa compatible for both xip
> and !xip kernel by defining XIP_OFFSET to 0 in !xip kernel.
> 
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> ---
>  arch/riscv/include/asm/page.h    | 14 +++-----------
>  arch/riscv/include/asm/pgtable.h |  2 ++
>  2 files changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> index 6a7761c86ec2..6e004d8fda4d 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -93,9 +93,7 @@ extern unsigned long va_pa_offset;
>  #ifdef CONFIG_64BIT
>  extern unsigned long va_kernel_pa_offset;
>  #endif
> -#ifdef CONFIG_XIP_KERNEL
>  extern unsigned long va_kernel_xip_pa_offset;
> -#endif
>  extern unsigned long pfn_base;
>  #define ARCH_PFN_OFFSET		(pfn_base)
>  #else
> @@ -103,6 +101,7 @@ extern unsigned long pfn_base;
>  #ifdef CONFIG_64BIT
>  #define va_kernel_pa_offset	0
>  #endif
> +#define va_kernel_xip_pa_offset 0
>  #define ARCH_PFN_OFFSET		(PAGE_OFFSET >> PAGE_SHIFT)
>  #endif /* CONFIG_MMU */
>  
> @@ -110,29 +109,22 @@ extern unsigned long kernel_virt_addr;
>  
>  #ifdef CONFIG_64BIT
>  #define linear_mapping_pa_to_va(x)	((void *)((unsigned long)(x) + va_pa_offset))
> -#ifdef CONFIG_XIP_KERNEL
>  #define kernel_mapping_pa_to_va(y)	({						\
>  	unsigned long _y = y;								\
>  	(_y >= CONFIG_PHYS_RAM_BASE) ?							\

For !XIP, IIRC, one rule for riscv kernel is one unified Image for all RV64GC
or RV32GC platforms. When CONFIG_PHYS_RAM_BASE is available for all
riscv platforms after patch1, I'm not sure the common unified Image is still
possible or not.

One possible solution would be forcing CONFIG_PHYS_RAM_BASE = 0 if !XIP in patch1
or remove patch1 instead define CONFIG_PHY_RAM_BASE 0 for !XIP

Thanks

>  		(void *)((unsigned long)(_y) + va_kernel_pa_offset + XIP_OFFSET) :	\
>  		(void *)((unsigned long)(_y) + va_kernel_xip_pa_offset);		\
>  	})
> -#else
> -#define kernel_mapping_pa_to_va(x)	((void *)((unsigned long)(x) + va_kernel_pa_offset))
> -#endif
>  #define __pa_to_va_nodebug(x)		linear_mapping_pa_to_va(x)
>  
>  #define linear_mapping_va_to_pa(x)	((unsigned long)(x) - va_pa_offset)
> -#ifdef CONFIG_XIP_KERNEL
>  #define kernel_mapping_va_to_pa(y) ({						\
>  	unsigned long _y = y;							\
>  	(_y < kernel_virt_addr + XIP_OFFSET) ?					\
>  		((unsigned long)(_y) - va_kernel_xip_pa_offset) :		\
>  		((unsigned long)(_y) - va_kernel_pa_offset - XIP_OFFSET);	\
>  	})
> -#else
> -#define kernel_mapping_va_to_pa(x)	((unsigned long)(x) - va_kernel_pa_offset)
> -#endif
> +
>  #define __va_to_pa_nodebug(x)	({						\
>  	unsigned long _x = x;							\
>  	(_x < kernel_virt_addr) ?						\
> @@ -141,7 +133,7 @@ extern unsigned long kernel_virt_addr;
>  #else
>  #define __pa_to_va_nodebug(x)  ((void *)((unsigned long) (x) + va_pa_offset))
>  #define __va_to_pa_nodebug(x)  ((unsigned long)(x) - va_pa_offset)
> -#endif
> +#endif /* CONFIG_64BIT */
>  
>  #ifdef CONFIG_DEBUG_VIRTUAL
>  extern phys_addr_t __virt_to_phys(unsigned long x);
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index bde8ce3bfe7c..d98e931a31e5 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -77,6 +77,8 @@
>  
>  #ifdef CONFIG_XIP_KERNEL
>  #define XIP_OFFSET		SZ_8M
> +#else
> +#define XIP_OFFSET		0
>  #endif
>  
>  #ifndef __ASSEMBLY__


