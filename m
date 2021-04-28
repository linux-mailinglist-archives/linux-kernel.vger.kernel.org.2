Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A973F36D12D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 06:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbhD1EQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 00:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhD1EQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 00:16:57 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CA0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 21:16:11 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id u21-20020a0568301195b02902a2119f7613so10403920otq.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 21:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=30dnzWh/H//3pMA+OZTUJzmMiZLLg9/1IuNp9r5Doh4=;
        b=ajdbxIcLtOc7ooJP1T6BcErHoDTu7r+XOk8IXeIAIWg48RKcmCWPzEaZSvnwN+pXcQ
         wNEt+R8jameONE+0OX6qNHclmfsoI99YUlJVx7gAGvYW8F6oaYnNquAPmHa8ouJxIJ76
         wS8HyQ8FRaXh88bCMKbAwABUbmXcEb5bPn/iP3Ta2IBJcAWA2u9wINagDzrHd8CyxEyi
         8vtBDtA7UGe8LGTUGFd0gkYRCWKByXftwhko/63z22CdJTb38I24Vw9QRnRHGvkGrRj8
         3pS+0MtBU1vzdtbDinPgV58RudWNv8OJnajYgOlOnwZYJoZwnO31kv5IfuLE+nfXFwhR
         xcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=30dnzWh/H//3pMA+OZTUJzmMiZLLg9/1IuNp9r5Doh4=;
        b=L7/dtuHuUn+9x7l5GyYXzeupMwinfo+sXdAX0SixyjITmvsY6VW9jLi+FoX1SK8tnP
         E36QVmamOSYVDNq8bHc9Zm0CLv3yp8fYoQ97K0I8v9HMRT9wLTWDQ7YZkXqYSKP4/qvo
         yZf4PSaETdSQg6oQcMNQjBS7jhnT0t+neiCO9w5wM7LYOl8go0bmmRoMT233Kj1RxIG9
         xhdhdr/SPfkO3fITldrELChUh8ctDPZ9DZlsZWXJogTP4hfzzCUspgiBzOqjDaLRUFXq
         Brojh7479uoiE2072SDr1qyDaWh36jVAj5I1ii8tDnigxAf15LWzo29chVZR8qQylzp7
         K5Ww==
X-Gm-Message-State: AOAM5311MIgg6RT83EjJbseBvRVnI9FCSrE9K6Zs238+9zRAn2DfWaSU
        68h9M+yLOLN0Rsp/qHC/3oc=
X-Google-Smtp-Source: ABdhPJy/c4SpHDoNAR37Vb176+WYflebJZskcoFCa69SDF3FQiqXGqc2TOofPFawEbA9A5ceeEdsZA==
X-Received: by 2002:a9d:7f96:: with SMTP id t22mr22333029otp.152.1619583371243;
        Tue, 27 Apr 2021 21:16:11 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 93sm443440otr.31.2021.04.27.21.16.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Apr 2021 21:16:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 27 Apr 2021 21:16:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, akpm@linux-foundation.org,
        Atish Patra <Atish.Patra@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>, wangkefeng.wang@huawei.com,
        rppt@kernel.org, vitaly.wool@konsulko.com, alex@ghiti.fr,
        greentime.hu@sifive.com, 0x7f454c46@gmail.com,
        chenhuang5@huawei.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: [PATCH] RISC-V: Always define XIP_FIXUP
Message-ID: <20210428041609.GA44281@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 08:34:15PM -0700, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmerdabbelt@google.com>
> 
> XIP depends on MMU, but XIP_FIXUP is defined throughout the kernel in
> order to avoid excessive ifdefs.  This just makes sure to always define
> XIP_FIXIP, which will fix MMU=n builds.
> 
> Fixes: 44c922572952 ("RISC-V: enable XIP")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
>  arch/riscv/include/asm/pgtable.h | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 2f1384e14e31..fd749351f432 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -73,18 +73,6 @@
>  #endif
>  #define FIXADDR_START    (FIXADDR_TOP - FIXADDR_SIZE)
>  
> -#ifdef CONFIG_XIP_KERNEL
> -#define XIP_OFFSET		SZ_8M
> -#define XIP_FIXUP(addr) ({							\
> -	uintptr_t __a = (uintptr_t)(addr);					\
> -	(__a >= CONFIG_XIP_PHYS_ADDR && __a < CONFIG_XIP_PHYS_ADDR + SZ_16M) ?	\
> -		__a - CONFIG_XIP_PHYS_ADDR + CONFIG_PHYS_RAM_BASE - XIP_OFFSET :\
> -		__a;								\
> -	})
> -#else
> -#define XIP_FIXUP(addr)		(addr)
> -#endif /* CONFIG_XIP_KERNEL */
> -
>  #endif
>  
>  #ifndef __ASSEMBLY__
> @@ -101,6 +89,18 @@
>  #include <asm/pgtable-32.h>
>  #endif /* CONFIG_64BIT */
>  
> +#ifdef CONFIG_XIP_KERNEL
> +#define XIP_OFFSET		SZ_8M
> +#define XIP_FIXUP(addr) ({							\
> +	uintptr_t __a = (uintptr_t)(addr);					\
> +	(__a >= CONFIG_XIP_PHYS_ADDR && __a < CONFIG_XIP_PHYS_ADDR + SZ_16M) ?	\
> +		__a - CONFIG_XIP_PHYS_ADDR + CONFIG_PHYS_RAM_BASE - XIP_OFFSET :\
> +		__a;								\
> +	})
> +#else
> +#define XIP_FIXUP(addr)		(addr)
> +#endif /* CONFIG_XIP_KERNEL */
> +
>  #ifdef CONFIG_MMU
>  /* Number of entries in the page global directory */
>  #define PTRS_PER_PGD    (PAGE_SIZE / sizeof(pgd_t))
> -- 
> 2.31.1.498.g6c1eba8ee3d-goog
> 
