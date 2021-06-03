Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C97B39A117
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 14:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhFCMfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 08:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbhFCMfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 08:35:52 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 653CAC061756
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 05:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=jJVbKlWw7q3kGTV3fKXd+W+D6ZhJ/foGHU
        5aZyS0C4k=; b=b+uuBvtl5pXtqsMF+r7g7ovIjidFLI/XSuG3A/gJpmokMIMUg2
        p2nJBFNPJBQ3Yp9A/cmjut2bFEZBTeO/KFYz7chgdY+PNqQnGtsJGXkhrB8HZO8N
        YEx4shIpgyrvTSNWOzqglKMT2h7BjnlpcAJC5T/67u/onRr7VE6QRBimw=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygBnXSwKzLhgW+uIAA--.11743S2;
        Thu, 03 Jun 2021 20:33:14 +0800 (CST)
Date:   Thu, 3 Jun 2021 20:27:48 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] riscv: Factorize xip and !xip kernel address
 conversion macros
Message-ID: <20210603202748.2775f739@xhacker>
In-Reply-To: <20210603082749.1256129-2-alex@ghiti.fr>
References: <20210603082749.1256129-1-alex@ghiti.fr>
        <20210603082749.1256129-2-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygBnXSwKzLhgW+uIAA--.11743S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGFykKw43Xw4fuw43uFy7GFg_yoW5Kw1fpr
        1DKr12grWSq3yY93yjvwn09r98JwnxW343KFsrKr95A3Z8tF1xWFyv9wnxWryjqFW0vFs3
        ury7Jr1j9w1jqwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUklb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8IzuJUUUU
        U==
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  3 Jun 2021 10:27:47 +0200
Alexandre Ghiti <alex@ghiti.fr> wrote:

> To simplify the kernel address conversion code, make the same definition of
> kernel_mapping_pa_to_va and kernel_mapping_va_to_pa compatible for both xip
> and !xip kernel by defining XIP_OFFSET to 0 in !xip kernel.
> 
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
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
>  	(_y >= CONFIG_PHYS_RAM_BASE) ?	

This CONFIG_PHYS_RAM_BASE is only available for XIP, could result in a
compiler error for !XIP?

I'm also concerned with the unecessary overhead of kernel_mapping_pa_to_va()
for !XIP case, there's a "if" condition branch, and extra symbol: va_kernel_xip_pa_offset

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

Similar as kernel_mapping_pa_to_va(), an overhead of "if" condition branch
for !XIP and extra va_kernel_xip_pa_offset symbol.

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


