Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAC044BFC1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 12:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhKJLF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 06:05:58 -0500
Received: from imap3.hz.codethink.co.uk ([176.9.8.87]:42796 "EHLO
        imap3.hz.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbhKJLFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 06:05:52 -0500
X-Greylist: delayed 1477 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Nov 2021 06:05:52 EST
Received: from cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net ([86.15.83.122] helo=[192.168.0.21])
        by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1mkkzl-0007o9-D5; Wed, 10 Nov 2021 10:38:21 +0000
Subject: Re: [PATCH v9 16/17] riscv: Fix an illegal instruction exception when
 accessing vlenb without enable vector first
To:     Greentime Hu <greentime.hu@sifive.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu
References: <cover.1636362169.git.greentime.hu@sifive.com>
 <3c0297d8335e4cac54a4397c880092c1c983e04e.1636362169.git.greentime.hu@sifive.com>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <2d08f105-64fd-a43a-1dea-24870ff7c5b0@codethink.co.uk>
Date:   Wed, 10 Nov 2021 10:38:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <3c0297d8335e4cac54a4397c880092c1c983e04e.1636362169.git.greentime.hu@sifive.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2021 09:48, Greentime Hu wrote:
> It triggered an illegal instruction exception when accessing vlenb CSR
> without enable vector first. To fix this issue, we should enable vector
> before using it and disable vector after using it.
> 
> Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> ---
>   arch/riscv/include/asm/vector.h        | 2 ++
>   arch/riscv/kernel/cpufeature.c         | 2 ++
>   arch/riscv/kernel/kernel_mode_vector.c | 6 ++++--
>   3 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
> index 5d7f14453f68..ca063c8f47f2 100644
> --- a/arch/riscv/include/asm/vector.h
> +++ b/arch/riscv/include/asm/vector.h
> @@ -8,6 +8,8 @@
>   
>   #include <linux/types.h>
>   
> +void rvv_enable(void);
> +void rvv_disable(void);
>   void kernel_rvv_begin(void);
>   void kernel_rvv_end(void);
>   
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 8e7557980faf..0139ec20adce 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -159,7 +159,9 @@ void __init riscv_fill_hwcap(void)
>   	if (elf_hwcap & COMPAT_HWCAP_ISA_V) {
>   		static_branch_enable(&cpu_hwcap_vector);
>   		/* There are 32 vector registers with vlenb length. */
> +		rvv_enable();
>   		riscv_vsize = csr_read(CSR_VLENB) * 32;
> +		rvv_disable();
>   	}
>   #endif

Would it be better to enable this here, and then restore the original
state instead of calling rvv_disable? If it was enabled then maybe
something else is going to rely on that state?

Maybe something like:

		prev = rvv_enable()
		riscv_vsize = csr_read(CSR_VLENB) * 32;
		rvv_restore(prev);


>   }
> diff --git a/arch/riscv/kernel/kernel_mode_vector.c b/arch/riscv/kernel/kernel_mode_vector.c
> index 8d2e53ea25c1..1ecb6ec5c56d 100644
> --- a/arch/riscv/kernel/kernel_mode_vector.c
> +++ b/arch/riscv/kernel/kernel_mode_vector.c
> @@ -71,15 +71,17 @@ static void put_cpu_vector_context(void)
>   	preempt_enable();
>   }
>   
> -static void rvv_enable(void)
> +void rvv_enable(void)
>   {
>   	csr_set(CSR_STATUS, SR_VS);
>   }
> +EXPORT_SYMBOL(rvv_enable);
>   
> -static void rvv_disable(void)
> +void rvv_disable(void)
>   {
>   	csr_clear(CSR_STATUS, SR_VS);
>   }
> +EXPORT_SYMBOL(rvv_disable);
>   
>   /*
>    * kernel_rvv_begin(): obtain the CPU vector registers for use by the calling
> 


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
