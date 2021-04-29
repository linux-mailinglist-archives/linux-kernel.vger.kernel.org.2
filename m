Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7AD36EC89
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 16:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240260AbhD2OmW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Apr 2021 10:42:22 -0400
Received: from mail-vs1-f44.google.com ([209.85.217.44]:37780 "EHLO
        mail-vs1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240076AbhD2OmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:42:20 -0400
Received: by mail-vs1-f44.google.com with SMTP id 2so33799471vsh.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 07:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1duNQ45gysbugwXrktBTo31sNNlK9JvBYcuHKmnWwBs=;
        b=kN05W98+kWlE/llJgCStxTTakex0C15tXtxf7Jyuh5oef17kflAi6lxU4VX586Oe+y
         dJdbbZHC9SK3cXI6UQ4XVGfEUaeN1NS7UF3noUJcZfDTjTFCH8PvGocZg2IJfgqke/3i
         9Aq+0QSzK+TZm6h3ukvHYCopFWreuNO4rmbePEiKCtizia0JBhoRrZT1bdr0duCVrDem
         ZGBczP2ajLbDt2MPbvGdAV/aJr3LIFg9izGcMsNnIFZolB+E/Q+8FhytizhAxFSK4C17
         thYZo5l/q745gL48CYfUs0GXPdaqfgygAmp5oGIFrJQQ+00ciSejZ4bdFSMvUjU65OOs
         3xtA==
X-Gm-Message-State: AOAM533/xZHmoEgOcWnNDZc6rF9M5PAiNBC4/fZDwbUfIU5mnC+3D5xw
        HnFbXpGJ7zysDiVeFWwL/gKr18r8wvQlqKgooFJVLj2E
X-Google-Smtp-Source: ABdhPJxaE0d5lgxiwnQ9Nvnc2pxVgy9FTuxI8ZPVZwlv5na3rF4773vo6jNMOeXIgB+ks1yo26uXkSWjR8QDiUmyku8=
X-Received: by 2002:a67:8745:: with SMTP id j66mr366840vsd.18.1619707293304;
 Thu, 29 Apr 2021 07:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <1a7660125046b94db9c6a7d62aa0ce88c8cd2f1d.1619617340.git.geert+renesas@glider.be>
 <605dc5e8-0a41-7458-6037-d6263b0ffd59@ghiti.fr>
In-Reply-To: <605dc5e8-0a41-7458-6037-d6263b0ffd59@ghiti.fr>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 29 Apr 2021 16:41:21 +0200
Message-ID: <CAMuHMdWV69hjaja=8YyjuvTUDwrO_oryJzhwgoR4Kfz0esUhZg@mail.gmail.com>
Subject: Re: [PATCH] riscv: Only extend kernel reservation if mapped read-only
To:     alex@ghiti.fr
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Thu, Apr 29, 2021 at 4:09 PM Alex Ghiti <alex@ghiti.fr> wrote:
> Le 4/28/21 à 9:45 AM, Geert Uytterhoeven a écrit :
> > When the kernel mapping was moved outside of the linear mapping, the
> > kernel memory reservation was increased, to take into account mapping
> > granularity.  However, this is done unconditionally, regardless of
> > whether the kernel memory is mapped read-only or not.
> >
> > If this extension is not needed, up to 2 MiB may be lost, which has a
> > big impact on e.g. Canaan K210 (64-bit nommu) platforms with only 8 MiB
> > of RAM.
> >
> > Reclaim the lost memory by only extending the reserved region when
> > needed, i.e. matching the conditional logic around the call to
> > protect_kernel_linear_mapping_text_rodata().
> >
> > Fixes: 2bfc6cd81bd17e43 ("riscv: Move kernel mapping outside of linear mapping")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Only tested on K210 (SiPeed MAIX BiT):
> >
> >      -Memory: 5852K/8192K available (1344K kernel code, 147K rwdata, 272K rodata, 106K init, 72K bss, 2340K reserved, 0K cma-reserved)
> >      +Memory: 5948K/8192K available (1344K kernel code, 147K rwdata, 272K rodata, 106K init, 72K bss, 2244K reserved, 0K cma-reserved)
> >
> > Yes, I was lucky, as only 96 KiB was lost ;-)
> > ---
> >   arch/riscv/mm/init.c | 10 ++++++++--
> >   1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index 788eb222deacf994..3439783f26abc488 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -136,11 +136,17 @@ void __init setup_bootmem(void)
> >
> >       /*
> >        * Reserve from the start of the kernel to the end of the kernel
> > -      * and make sure we align the reservation on PMD_SIZE since we will
> > +      */
> > +#if defined(CONFIG_STRICT_KERNEL_RWX) && defined(CONFIG_64BIT) && \
> > +    defined(CONFIG_MMU) && !defined(CONFIG_XIP_KERNEL)
>
> ARCH_HAS_STRICT_KERNEL_RWX depends on MMU and !XIP_KERNEL so I think you
> can get rid of those checks.

Thanks, you're right.  Will simplify in v2.

I'll also clean up the other location where this was copied from.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
