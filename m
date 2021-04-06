Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCE8354DB3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 09:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244236AbhDFHUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 03:20:17 -0400
Received: from mail-vs1-f43.google.com ([209.85.217.43]:41981 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbhDFHUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 03:20:12 -0400
Received: by mail-vs1-f43.google.com with SMTP id h23so7263943vsj.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 00:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WfE4/UxR9aMUAyVI/W893Z6O1V5sOJWf9p5n5uxKnHc=;
        b=PBbPG2pgG5pZ678QPjbMjJsm+hurbEp493tCy8wvM3qOdZq1qb1iUoBscJ5m6UYcpd
         K9+nXrrwRVxIyWIcghItuIdgKZ7Hj6Xg8lrACnlHevdtLHPUREWArOymjGpD9fayjChc
         D/ecu3/TYnTupZL7lIDtoj7f6OAt+JYRtlyLuyZX5ex6qx8+yDqJbq4rsRDhJT6nOZYz
         f3/QzpPqnxnd5hipUGH+Zg2ADynC2Le5jFH3JvFwy9Hq+/N5GsNJR1PJCJsloheieQYr
         Rej27d8gJvhGhW3O3+dZEJ06QPNj8+LCNMNSKpo1FKr8fvS5FMvC7QRThSvYy+0a+XiF
         s9Gw==
X-Gm-Message-State: AOAM532VK7cTV7be2rY+v2041062OZYQAW0BBSHIqL4zLctG+f99IsiM
        hUqH8XmXux4nsCqixIXXuR+dvF3MQSCPffTfX4g=
X-Google-Smtp-Source: ABdhPJz5iGk9TYXXhbRbt8SfpyWATxxhwF3T6eZB/PEOC74t/cVwJX7WeRFS1pweG5WpuYrw9WstMrMcrIB5u0W04bg=
X-Received: by 2002:a67:f5ca:: with SMTP id t10mr9234571vso.40.1617693604829;
 Tue, 06 Apr 2021 00:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210405085712.1953848-1-mick@ics.forth.gr> <20210405085712.1953848-4-mick@ics.forth.gr>
In-Reply-To: <20210405085712.1953848-4-mick@ics.forth.gr>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 6 Apr 2021 09:19:52 +0200
Message-ID: <CAMuHMdWi+wo0+PCR6B1wyXVesG-kL9NQt8XFBuWhZ3SdVUaLZg@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] RISC-V: Improve init_resources
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

Thanks for your patch!

On Mon, Apr 5, 2021 at 10:57 AM Nick Kossifidis <mick@ics.forth.gr> wrote:
> * Kernel region is always present and we know where it is, no
> need to look for it inside the loop, just ignore it like the
> rest of the reserved regions within system's memory.
>
> * Don't call memblock_free inside the loop, if called it'll split
> the region of pre-allocated resources in two parts, messing things
> up, just re-use the previous pre-allocated resource and free any
> unused resources after both loops finish.
>
> * memblock_alloc may add a region when called, so increase the
> number of pre-allocated regions by one to be on the safe side
> (reported and patched by Geert Uytterhoeven)
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Where does this SoB come from?

> Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>

> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c

> @@ -129,53 +139,42 @@ static void __init init_resources(void)
>         struct resource *res = NULL;
>         struct resource *mem_res = NULL;
>         size_t mem_res_sz = 0;
> -       int ret = 0, i = 0;
> -
> -       code_res.start = __pa_symbol(_text);
> -       code_res.end = __pa_symbol(_etext) - 1;
> -       code_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> -
> -       rodata_res.start = __pa_symbol(__start_rodata);
> -       rodata_res.end = __pa_symbol(__end_rodata) - 1;
> -       rodata_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> -
> -       data_res.start = __pa_symbol(_data);
> -       data_res.end = __pa_symbol(_edata) - 1;
> -       data_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> +       int num_resources = 0, res_idx = 0;
> +       int ret = 0;
>
> -       bss_res.start = __pa_symbol(__bss_start);
> -       bss_res.end = __pa_symbol(__bss_stop) - 1;
> -       bss_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> +       /* + 1 as memblock_alloc() might increase memblock.reserved.cnt */
> +       num_resources = memblock.memory.cnt + memblock.reserved.cnt + 1;
> +       res_idx = num_resources - 1;
>
> -       mem_res_sz = (memblock.memory.cnt + memblock.reserved.cnt) * sizeof(*mem_res);

Oh, you incorporated my commit ce989f1472ae350e ("RISC-V: Fix out-of-bounds
accesses in init_resources()") (from v5.12-rc4) into your patch.
Why? This means your patch does not apply against upstream.

> +       mem_res_sz = num_resources * sizeof(*mem_res);
>         mem_res = memblock_alloc(mem_res_sz, SMP_CACHE_BYTES);
>         if (!mem_res)
>                 panic("%s: Failed to allocate %zu bytes\n", __func__, mem_res_sz);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
