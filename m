Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBC73A7F17
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 15:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhFONVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 09:21:47 -0400
Received: from mail-ua1-f51.google.com ([209.85.222.51]:45865 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFONVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 09:21:44 -0400
Received: by mail-ua1-f51.google.com with SMTP id v17so2258750uar.12;
        Tue, 15 Jun 2021 06:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hwbhacSscetqLBTLgthyShGc1NVfqwfpItyjtKy47b4=;
        b=oB7/cUqeCoPjlotpzegS64bEK2g0W7gdwGbGoj7JLqZsNokxIJ/HajGH4iEPq2OuYj
         uifeei4qCiFD0NJMoPUyHjgEXUUUafTNZ+JkO6FmfC1vnEwkxBOnDolf8PfH7bSjl7+c
         J2UyYSiOvVxXhv0KgQAOPHpk6SqtucmOw5EG7oR6YJm3bVTKhYoIEmXim0fSoB9q6B/o
         cnp75a7F7vHz5oQEyFlWdLTf0VqRy9/ulvkCR+wF9cCgl4G1k8TYAotybtjjVYOD1lLW
         W6+v1U2XhUUQxCKm4do0Z1xhCrvBlyOb9uU9mJNG0YNlhmg5403lJgjmOL2AUwIJqDOv
         eM+g==
X-Gm-Message-State: AOAM531onW6xBrWHRP3rcwO/yTKAjDXTc5qH4rrHtGegYejzAmU5Vn3m
        SdLhvmxQSrgsh0rF4gc1oTT0sQOdvUm526PqBjU=
X-Google-Smtp-Source: ABdhPJzx0IHLF5Qs1kLRoM3ndyDSsmRQ/L3tZsFxSpTdBz/sGirmBpBGoDZABz+NRthYCP5Pg+lEcqqowARL4/piAq0=
X-Received: by 2002:ab0:63d9:: with SMTP id i25mr17823298uap.106.1623763179009;
 Tue, 15 Jun 2021 06:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210419005539.22729-1-mick@ics.forth.gr> <20210419005539.22729-6-mick@ics.forth.gr>
In-Reply-To: <20210419005539.22729-6-mick@ics.forth.gr>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 15 Jun 2021 15:19:27 +0200
Message-ID: <CAMuHMdW=23SPXwqcjD+30M_d0azdze2=ChZM-PF1brf9bCNtrA@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] RISC-V: Add crash kernel support
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

CC rob, dt

Thanks for your patch, which is now commit 5640975003d0234d ("RISC-V:
Add crash kernel support") in v5.13-rc1.

On Mon, Apr 19, 2021 at 2:56 AM Nick Kossifidis <mick@ics.forth.gr> wrote:
> This patch allows Linux to act as a crash kernel for use with
> kdump. Userspace will let the crash kernel know about the
> memory region it can use through linux,usable-memory property
> on the /memory node (overriding its reg property), and about the
> memory region where the elf core header of the previous kernel
> is saved, through a reserved-memory node with a compatible string
> of "linux,elfcorehdr". This approach is the least invasive and
> re-uses functionality already present.

This does not match
https://github.com/devicetree-org/dt-schema/blob/master/schemas/chosen.yaml#L77:

    $ref: types.yaml#/definitions/uint64-array
    maxItems: 2
    description:
      This property (currently used only on arm64) holds the memory range,
      the address and the size, of the elf core header which mainly describes
      the panicked kernel\'s memory layout as PT_LOAD segments of elf format.

Hence "linux,elfcorehdr" should be a property of the /chosen node,
instead of a memory node with a compatible value of "linux,elfcorehdr".

> I tested this on riscv64 qemu and it works as expected, you
> may test it by retrieving the dmesg of the previous kernel
> through /proc/vmcore, using the vmcore-dmesg utility from
> kexec-tools.
>
> v4:
>  * Rebase on top of "fixes" branch
>
> v3:
>  * Rebase
>
> v2:
>  * Use linux,usable-memory on /memory instead of a new binding

This part seems to have been removed in v3 and later?
Note that "linux,usable-memory-range" should be a property of the
/chosen node, too, cfr.
https://github.com/devicetree-org/dt-schema/blob/master/schemas/chosen.yaml#L85

>  * Use a reserved-memory node for ELF core header
>
> Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>


> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -653,6 +666,26 @@ static void __init reserve_crashkernel(void)
>  }
>  #endif /* CONFIG_KEXEC_CORE */
>
> +#ifdef CONFIG_CRASH_DUMP
> +/*
> + * We keep track of the ELF core header of the crashed
> + * kernel with a reserved-memory region with compatible
> + * string "linux,elfcorehdr". Here we register a callback
> + * to populate elfcorehdr_addr/size when this region is
> + * present. Note that this region will be marked as
> + * reserved once we call early_init_fdt_scan_reserved_mem()
> + * later on.
> + */
> +static int elfcore_hdr_setup(struct reserved_mem *rmem)
> +{
> +       elfcorehdr_addr = rmem->base;
> +       elfcorehdr_size = rmem->size;
> +       return 0;
> +}
> +
> +RESERVEDMEM_OF_DECLARE(elfcorehdr, "linux,elfcorehdr", elfcore_hdr_setup);
> +#endif
> +
>  void __init paging_init(void)
>  {
>         setup_vm_final();
> --
> 2.26.2

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
