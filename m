Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A424024F2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 10:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242115AbhIGIRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 04:17:51 -0400
Received: from mail-vs1-f42.google.com ([209.85.217.42]:38579 "EHLO
        mail-vs1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239550AbhIGIRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 04:17:46 -0400
Received: by mail-vs1-f42.google.com with SMTP id a25so7578108vso.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 01:16:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nlFSfoQ7SXqrtlS/FSZSEtUCAir1A7uzxwYSF0gDcQI=;
        b=byyyE82snrzXEY9ODgeemw+/uVqLX0WMLIRT5ch564aa224SdhTMzAciViXbflseKu
         3yzF7uIVouhjLzLAGgP2UI9EryawbNymDBWcQbLCcxQ0FzttDRrAkPAPW5s0JqhVhjS4
         aJe8Yjn931kw3N1d64Ie+5i9+/01u5fcuZZWd9C8+cnLzMzuea/i1Hugvc6YQSDGbXVc
         aAKtB2Rwn/imNLPE86a4n0uIu3aTdV93vdu5yynh2fGfPXV9I8w7UP/SCZqltaMrbKkp
         FZF4jfDHsDCT4a6Zj+kjJlOJ7ukme5dvlXNwvJSSJnSoEJMMx1p6xzCMdMHDIcO/lZKb
         5mJg==
X-Gm-Message-State: AOAM533LsUiUoiMNO3fgCL9LRVO1EUg1h4BRCvtkYlq6uCmR2433D56c
        Rfi7LXbOXik42dkrZxe2mG4UNb0awyXRICrEIWs=
X-Google-Smtp-Source: ABdhPJyIqfPg+bWlK++5mI/mNj91/3OCX62E73H+ngnTOIFp/L9yNDBZA/0e3DY1dortDt3Rjbkv4zqhfzYpyazfc3o=
X-Received: by 2002:a67:3289:: with SMTP id y131mr8357469vsy.37.1631002600397;
 Tue, 07 Sep 2021 01:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210906095930.4184449-1-bert@biot.com>
In-Reply-To: <20210906095930.4184449-1-bert@biot.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 7 Sep 2021 10:16:28 +0200
Message-ID: <CAMuHMdVqEw+5yM9BuCiZ3LA8OkQnKVOrb5ExREAdRBXS-2KS5Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: decompress: Use /memreserve/ DTS nodes when
 validating memory
To:     Bert Vermeulen <bert@biot.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Crispin <john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hoi Bert,

On Mon, Sep 6, 2021 at 12:00 PM Bert Vermeulen <bert@biot.com> wrote:
> If the bootloader needs the start of memory to be preserved, for example
> because it dropped the Trusted Firmware blob there, this chunk of memory
> shouldn't be used by the kernel.
>
> To avoid adding yet another SoC-specific text offset to arch/arm/Makefile,
> this patch allows for a /memreserve/ entry in the DTS to mark off the
> memory chunk instead.
>
> Signed-off-by: Bert Vermeulen <bert@biot.com>

Thanks for your patch!

> --- a/arch/arm/boot/compressed/fdt_check_mem_start.c
> +++ b/arch/arm/boot/compressed/fdt_check_mem_start.c
> @@ -64,7 +64,7 @@ uint32_t fdt_check_mem_start(uint32_t mem_start, const void *fdt)
>         uint32_t addr_cells, size_cells, base;
>         uint32_t fdt_mem_start = 0xffffffff;
>         const fdt32_t *reg, *endp;
> -       uint64_t size, end;
> +       uint64_t rsvaddr, size, end;
>         const char *type;
>         int offset, len;
>
> @@ -74,6 +74,19 @@ uint32_t fdt_check_mem_start(uint32_t mem_start, const void *fdt)
>         if (fdt_magic(fdt) != FDT_MAGIC)
>                 return mem_start;
>
> +       for (offset = fdt_off_mem_rsvmap(fdt); ; offset += 16) {
> +               rsvaddr = get_val(fdt + offset, 8);
> +               size = get_val(fdt + offset + 8, 8);

The last parameter of get_val() is the number of cells, not the number
of bytes. Hence it should be 2 for the 64-bit values in the memory
reservation block.

The rest looks good to me.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
