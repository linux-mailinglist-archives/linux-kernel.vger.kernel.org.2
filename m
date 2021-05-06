Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA291374F76
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 08:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbhEFGmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 02:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhEFGmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 02:42:49 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65DFC061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 23:41:50 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id c17so4402487pfn.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 23:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=tcjOW0GNebxM0lkkYwBauVKed6xLu5wjE7gUFkINsAE=;
        b=1M369Bnnqg5S80HQ72qCWHgDeHuYJ+w863PTLBD4ebwKvVk4VjzZHzL2T/glvixrNt
         8LZZqv/jCjTQ3I9ehojb+xgNHcbUmK/h216fGPzBmrCyiD8PIcHKZXPgvw5Gxz5Brsuk
         BqzFNOJpFzSpm978m18e3xl3q6HW+Z9NA7E69v453lIV9SmMntrl4iIkwcqndWwwNy3x
         es1TiG5R8P9h9cpEwQJQEWW847GdPexs1W9qoqIiiYOfsDo5tztFn5El/96as4PuThTJ
         BjmFMN3Ie32m4j+7OyI0v+X4IuvzaNcWIpJ/Zoc5hE3ZLbzr73I72ogYEDivRxTY09kQ
         LlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=tcjOW0GNebxM0lkkYwBauVKed6xLu5wjE7gUFkINsAE=;
        b=lEzaiDUXLpBIE9uhGxV+rUnDOYzkVNRIAFubPHbQvEUqvn0WMBPeiyeWlak8XESjst
         S9Mly/XIkH59Lo29KjHIcOLmTPbjd/7LRYMkKrfyyvSD4AJdtjk4NHWSMS45mvyN3CaF
         V/oFj2l63y2R1+jNF1bxuzIasyXzAGxDkJddT1G6vsiBuVbNYLsajuxXbsVT69i8OzNp
         iw/KUKHp7mcprL/tn5RYaujRlTWfvPg+UEt5nzvJUz2Q/4WuruWQ/T+yCeJMGpuO6/9d
         eCIVikLf9bBoshRIKBbPd5Z0bAetS4eYLj/0saOF8l9kt1IvH/OMAzPD5pT5P42SItxM
         hIzg==
X-Gm-Message-State: AOAM532csd/WBpWiHw+W7xr8VkaswJM09jnJFnmu7GedU4wHyAG+TIyJ
        01ybmLUtsbXQnybsIWA0T19OMA==
X-Google-Smtp-Source: ABdhPJwuMSAR+7p/akc/AnQ3NoF4xg3h4cv/q6ycf5qyVv3lOeS/uIX6uJnRIItavOOxYeh4ozDhsA==
X-Received: by 2002:a62:8208:0:b029:289:112f:d43d with SMTP id w8-20020a6282080000b0290289112fd43dmr2748978pfd.61.1620283310399;
        Wed, 05 May 2021 23:41:50 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id n27sm1165085pfv.142.2021.05.05.23.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 23:41:49 -0700 (PDT)
Date:   Wed, 05 May 2021 23:41:49 -0700 (PDT)
X-Google-Original-Date: Wed, 05 May 2021 23:41:46 PDT (-0700)
Subject:     Re: [PATCH v2] riscv: Only extend kernel reservation if mapped read-only
In-Reply-To: <02e05df076da23fc0f52c944bbf0a5cb99e95bd6.1619708542.git.geert+renesas@glider.be>
CC:     alex@ghiti.fr, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Damien Le Moal <Damien.LeMoal@wdc.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, geert+renesas@glider.be
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     geert+renesas@glider.be
Message-ID: <mhng-9100bcaa-03ab-4f62-939a-aeb911d0640d@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Apr 2021 08:05:00 PDT (-0700), geert+renesas@glider.be wrote:
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
>   - Simplify the conditional, as STRICT_KERNEL_RWX depends on
>     MMU && !XIP_KERNEL.
>
> Only tested on K210 (SiPeed MAIX BiT):
>
>     -Memory: 5852K/8192K available (1344K kernel code, 147K rwdata, 272K rodata, 106K init, 72K bss, 2340K reserved, 0K cma-reserved)
>     +Memory: 5948K/8192K available (1344K kernel code, 147K rwdata, 272K rodata, 106K init, 72K bss, 2244K reserved, 0K cma-reserved)
>
> Yes, I was lucky, as only 96 KiB was lost ;-)
> ---
>  arch/riscv/mm/init.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 788eb222deacf994..3ebc0f5d2b73b42b 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -136,11 +136,16 @@ void __init setup_bootmem(void)
>
>  	/*
>  	 * Reserve from the start of the kernel to the end of the kernel
> -	 * and make sure we align the reservation on PMD_SIZE since we will
> +	 */
> +#if defined(CONFIG_64BIT) && defined(CONFIG_STRICT_KERNEL_RWX)
> +	/*
> +	 * Make sure we align the reservation on PMD_SIZE since we will
>  	 * map the kernel in the linear mapping as read-only: we do not want
>  	 * any allocation to happen between _end and the next pmd aligned page.
>  	 */
> -	memblock_reserve(vmlinux_start, (vmlinux_end - vmlinux_start + PMD_SIZE - 1) & PMD_MASK);
> +	vmlinux_end = (vmlinux_end + PMD_SIZE - 1) & PMD_MASK;
> +#endif
> +	memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
>
>  	/*
>  	 * memblock allocator is not aware of the fact that last 4K bytes of

Thanks, this is on for-next
