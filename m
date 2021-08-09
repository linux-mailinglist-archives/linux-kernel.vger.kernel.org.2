Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA3B3E4B3A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 19:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbhHIRwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 13:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbhHIRwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 13:52:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5996AC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 10:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=9CnNVCZZu2fyVetALAt1fRTPE5K8dZRhQ8cLoo/Y7cY=; b=gY7MMJfqR0ds3FjAhP37Pc+OKb
        6Ej7RGZUB69P7OPbmEIDI7o1FXMlfeGH4zq2VY9d9S6DkJcY/t9L5/oDvpZNI1neCQTpEAO0IjWRN
        CgQUeQ6WqCGnC0Ys20e++79jcbnPCssFKZYO0i1b/0gvfYOMxMIexqneRTlc2QXMGZEhFSBirc5DY
        wGUeTKQV7n0k+ZUUST9gimBhgLbEpmy5a1JJZLEN6mAHu/YFYlF0G5n4ddbCBueIUH10Da1qFm0hY
        9dsimS9/+e27yyJQ6Ba9YrSQNURUt6E8FOsgI5KW7pC0dSMQhcix3QKp1BHUnFFMWVERLY6nUpYQG
        EM6DAB4w==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mD9Qx-001bEl-Iv; Mon, 09 Aug 2021 17:51:31 +0000
Subject: Re: [PATCH v2] openrisc: Fix compiler warnings in setup
To:     Stafford Horne <shorne@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        kernel test robot <lkp@intel.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
References: <20210808135437.3640549-1-shorne@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8a830ab7-6b66-1ca9-bd73-fc1551def648@infradead.org>
Date:   Mon, 9 Aug 2021 10:51:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210808135437.3640549-1-shorne@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/21 6:54 AM, Stafford Horne wrote:
> This was pointed out with the recent name change of or32_early_setup to
> or1k_early_setup.  Investigating the file I found a few other warnings
> so cleaning them up here.
> 
>      arch/openrisc/kernel/setup.c:220:13: warning: no previous prototype for 'or1k_early_setup' [-Wmissing-prototypes]
>        220 | void __init or1k_early_setup(void *fdt)
> 	  |             ^~~~~~~~~~~~~~~~
> 
> Fix this the missing or1k_early_setup prototype warning by adding an
> asm/setup.h file to define the prototype.
> 
>      arch/openrisc/kernel/setup.c:246:13: warning: no previous prototype for 'detect_unit_config' [-Wmissing-prototypes]
>        246 | void __init detect_unit_config(unsigned long upr, unsigned long mask,
> 	  |             ^~~~~~~~~~~~~~~~~~
> 
> The function detect_unit_config is not used, just remove it.
> 
>      arch/openrisc/kernel/setup.c:221: warning: Function parameter or member 'fdt' not described in 'or1k_early_setup'
> 
> Add @fdt docs to the function comment to suppress this warning.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> 
> Changes since v1:
>   - Add #include <linux/init.h> to fix compile failure.  Pointed out by robot and
>     randy.
> 
>   arch/openrisc/include/asm/setup.h | 15 +++++++++++++++
>   arch/openrisc/kernel/setup.c      | 16 +---------------
>   2 files changed, 16 insertions(+), 15 deletions(-)
>   create mode 100644 arch/openrisc/include/asm/setup.h
> 
> diff --git a/arch/openrisc/include/asm/setup.h b/arch/openrisc/include/asm/setup.h
> new file mode 100644
> index 000000000000..9acbc5deda69
> --- /dev/null
> +++ b/arch/openrisc/include/asm/setup.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2021 Stafford Horne
> + */
> +#ifndef _ASM_OR1K_SETUP_H
> +#define _ASM_OR1K_SETUP_H
> +
> +#include <linux/init.h>
> +#include <asm-generic/setup.h>
> +
> +#ifndef __ASSEMBLY__
> +void __init or1k_early_setup(void *fdt);
> +#endif
> +
> +#endif /* _ASM_OR1K_SETUP_H */
> diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
> index 7eddcac0ef2f..0cd04d936a7a 100644
> --- a/arch/openrisc/kernel/setup.c
> +++ b/arch/openrisc/kernel/setup.c
> @@ -210,6 +210,7 @@ void __init setup_cpuinfo(void)
>   
>   /**
>    * or1k_early_setup
> + * @fdt: pointer to the start of the device tree in memory or NULL
>    *
>    * Handles the pointer to the device tree that this kernel is to use
>    * for establishing the available platform devices.
> @@ -243,21 +244,6 @@ static inline unsigned long extract_value(unsigned long reg, unsigned long mask)
>   	return mask & reg;
>   }
>   
> -void __init detect_unit_config(unsigned long upr, unsigned long mask,
> -			       char *text, void (*func) (void))
> -{
> -	if (text != NULL)
> -		printk("%s", text);
> -
> -	if (upr & mask) {
> -		if (func != NULL)
> -			func();
> -		else
> -			printk("present\n");
> -	} else
> -		printk("not present\n");
> -}
> -
>   /*
>    * calibrate_delay
>    *
> 


-- 
~Randy

