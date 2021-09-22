Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03628414269
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 09:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbhIVHQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 03:16:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:38510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232946AbhIVHQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 03:16:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBA5361247;
        Wed, 22 Sep 2021 07:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632294898;
        bh=+ydocpPVBLWe3OvCzCjUTeaVX170Kdpi5EiABQvJc7A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LxbL5W7sq+aw0s+oEMr+GgmgkujQ5S4FYVgdb3hR4G50nnxkxZWC7TMXavsJRzEUO
         VzaY4+23waBD0w3lVspsEKOb2Ca/ot06v7RtSW617kBGDrbkxsQ4rlmejov0ta3i/D
         W8Y9iGIaDdawRE5I/vDVMeqUwHdXoVTDjkYVXsIGpdefFlP84YVZMxg1q8mLu989WJ
         13AlD4J/9pHYdf6HFlDOcHZoBCEbeWxq6U3R90bW6wvbl4qvQ5LWHyvJubrGjVmjSx
         sOb5/lnnk3ANxBtvF/FD933huDpQN1yJD+CUIyRW2OMDPloPVKPLgZQSn76EdmENVw
         WHtV8Ej0Qx0qg==
Received: by mail-ot1-f54.google.com with SMTP id h9-20020a9d2f09000000b005453f95356cso2165732otb.11;
        Wed, 22 Sep 2021 00:14:58 -0700 (PDT)
X-Gm-Message-State: AOAM531UUAQdvOgLkKGPosbOgJei0NJ9NMv0NjW5607IEWpKGUjjOLkP
        IC3HMdCNrvDpRVv15c7tv6BM0EC/kTdq4syVbR0=
X-Google-Smtp-Source: ABdhPJwHSdKWJXExAbkKJnGirRvqqBIMaaqA37Zslhx7dDAXyqTNVLEwm50nmqLS3zUpNZVpcXOsfuxMsS7lTtT9N/Q=
X-Received: by 2002:a05:6830:3189:: with SMTP id p9mr26321111ots.147.1632294898139;
 Wed, 22 Sep 2021 00:14:58 -0700 (PDT)
MIME-Version: 1.0
References: <0de07021e49ac26a8f9386f62f3e15e947d0f6d0.1631709384.git.geert+renesas@glider.be>
In-Reply-To: <0de07021e49ac26a8f9386f62f3e15e947d0f6d0.1631709384.git.geert+renesas@glider.be>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 22 Sep 2021 09:14:46 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF_B1ggD8zdKn_hyzgaa1zMhL+ygXRJaWhhrStqWPn9vw@mail.gmail.com>
Message-ID: <CAMj1kXF_B1ggD8zdKn_hyzgaa1zMhL+ygXRJaWhhrStqWPn9vw@mail.gmail.com>
Subject: Re: [PATCH v6] ARM: uncompress: Parse "linux,usable-memory-range" DT property
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lukasz Stelmach <l.stelmach@samsung.com>,
        Simon Horman <horms@verge.net.au>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sept 2021 at 15:20, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Add support for parsing the "linux,usable-memory-range" DT property.
> This property is used to describe the usable memory reserved for the
> crash dump kernel, and thus makes the memory reservation explicit.
> If present, Linux no longer needs to mask the program counter, and rely
> on the "mem=" kernel parameter to obtain the start and size of usable
> memory.
>
> For backwards compatibility, the traditional method to derive the start
> of memory is still used if "linux,usable-memory-range" is absent.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
> KernelVersion: v5.15-rc1
> ---
> The corresponding patch for kexec-tools is "[PATCH] arm: kdump: Add DT
> properties to crash dump kernel's DTB", which is still valid:
> https://lore.kernel.org/r/20200902154129.6358-1-geert+renesas@glider.be/
>
> v6:
>   - All dependencies are in v5.15-rc1,
>
> v5:
>   - Remove the addition of "linux,elfcorehdr" and
>     "linux,usable-memory-range" handling to arch/arm/mm/init.c,
>
> v4:
>   - Remove references to architectures in chosen.txt, to avoid having to
>     change this again when more architectures copy kdump support,
>   - Remove the architecture-specific code for parsing
>     "linux,usable-memory-range" and "linux,elfcorehdr", as the FDT core
>     code now takes care of this,
>   - Move chosen.txt change to patch changing the FDT core,
>   - Use IS_ENABLED(CONFIG_CRASH_DUMP) instead of #ifdef,
>
> v3:
>   - Rebase on top of accepted solution for DTB memory information
>     handling, which is part of v5.12-rc1,
>
> v2:
>   - Rebase on top of reworked DTB memory information handling.
> ---
>  .../arm/boot/compressed/fdt_check_mem_start.c | 48 ++++++++++++++++---
>  1 file changed, 42 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/boot/compressed/fdt_check_mem_start.c b/arch/arm/boot/compressed/fdt_check_mem_start.c
> index 62450d824c3ca180..9291a2661bdfe57f 100644
> --- a/arch/arm/boot/compressed/fdt_check_mem_start.c
> +++ b/arch/arm/boot/compressed/fdt_check_mem_start.c
> @@ -55,16 +55,17 @@ static uint64_t get_val(const fdt32_t *cells, uint32_t ncells)
>   * DTB, and, if out-of-range, replace it by the real start address.
>   * To preserve backwards compatibility (systems reserving a block of memory
>   * at the start of physical memory, kdump, ...), the traditional method is
> - * always used if it yields a valid address.
> + * used if it yields a valid address, unless the "linux,usable-memory-range"
> + * property is present.
>   *
>   * Return value: start address of physical memory to use
>   */
>  uint32_t fdt_check_mem_start(uint32_t mem_start, const void *fdt)
>  {
> -       uint32_t addr_cells, size_cells, base;
> +       uint32_t addr_cells, size_cells, usable_base, base;
>         uint32_t fdt_mem_start = 0xffffffff;
> -       const fdt32_t *reg, *endp;
> -       uint64_t size, end;
> +       const fdt32_t *usable, *reg, *endp;
> +       uint64_t size, usable_end, end;
>         const char *type;
>         int offset, len;
>
> @@ -80,6 +81,27 @@ uint32_t fdt_check_mem_start(uint32_t mem_start, const void *fdt)
>         if (addr_cells > 2 || size_cells > 2)
>                 return mem_start;
>
> +       /*
> +        * Usable memory in case of a crash dump kernel
> +        * This property describes a limitation: memory within this range is
> +        * only valid when also described through another mechanism
> +        */
> +       usable = get_prop(fdt, "/chosen", "linux,usable-memory-range",
> +                         (addr_cells + size_cells) * sizeof(fdt32_t));
> +       if (usable) {
> +               size = get_val(usable + addr_cells, size_cells);
> +               if (!size)
> +                       return mem_start;
> +
> +               if (addr_cells > 1 && fdt32_ld(usable)) {
> +                       /* Outside 32-bit address space */
> +                       return mem_start;
> +               }
> +
> +               usable_base = fdt32_ld(usable + addr_cells - 1);
> +               usable_end = usable_base + size;
> +       }
> +
>         /* Walk all memory nodes and regions */
>         for (offset = fdt_next_node(fdt, -1, NULL); offset >= 0;
>              offset = fdt_next_node(fdt, offset, NULL)) {
> @@ -107,7 +129,20 @@ uint32_t fdt_check_mem_start(uint32_t mem_start, const void *fdt)
>
>                         base = fdt32_ld(reg + addr_cells - 1);
>                         end = base + size;
> -                       if (mem_start >= base && mem_start < end) {
> +                       if (usable) {
> +                               /*
> +                                * Clip to usable range, which takes precedence
> +                                * over mem_start
> +                                */
> +                               if (base < usable_base)
> +                                       base = usable_base;
> +
> +                               if (end > usable_end)
> +                                       end = usable_end;
> +
> +                               if (end <= base)
> +                                       continue;
> +                       } else if (mem_start >= base && mem_start < end) {
>                                 /* Calculated address is valid, use it */
>                                 return mem_start;
>                         }
> @@ -123,7 +158,8 @@ uint32_t fdt_check_mem_start(uint32_t mem_start, const void *fdt)
>         }
>
>         /*
> -        * The calculated address is not usable.
> +        * The calculated address is not usable, or was overridden by the
> +        * "linux,usable-memory-range" property.
>          * Use the lowest usable physical memory address from the DTB instead,
>          * and make sure this is a multiple of 2 MiB for phys/virt patching.
>          */
> --
> 2.25.1
>
