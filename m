Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51EFC3CB0B8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 04:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbhGPCTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 22:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbhGPCTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 22:19:09 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1013C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 19:16:15 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id t186so12365767ybf.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 19:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PF9YaE/2qCJ+GM4+6SKwaKx8jb/P3WMvBPxycoSWXcg=;
        b=Mi2vjKgn0+Po8CnOEJQyWtQeZu/L4mrbeqomoHO2JkbgPtkTUtR2CDkpHsmihUZHYL
         NT1AtWZLKLTxO5+3dH6W74j9vue1CTcIXX9FtLTKMrI0TRz7DHHbI0H7M/WbACkusi3d
         Y5vUT881oPxD0/hM8wBIuLHHf7kBILSka5bpQxkYpS4aIDOvziz+4e0B3NtZEeFxQWGL
         rHb9lTueCHMwWTHzaMQuqP7xDCz4GrYpk00yCBk6kgxZ/4xB86D5n2Qa3AOWJwb2jHYN
         XSVcERs33oUetVR08PsgMIbcrVIU5OFbGTNXUOTHaaJDX8gOiigyD1SO3AOasA5SpV7d
         qqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PF9YaE/2qCJ+GM4+6SKwaKx8jb/P3WMvBPxycoSWXcg=;
        b=EXpR13xA0afg4naTCIqQo/clcElhRxmcqSvn4tbn2zTMD4aHzaSrArdZpuQ35+xKsg
         nN0TbiiIEXOb84+B0ovX8+77DsCAIhc0kwqbxN/OpqPRt7p+Lfldq7Si3SmYPWy7Fn+H
         nrrt9zNOHBMR3tuuph380H/yaxuXwjCOZu3GgvMNVVsTGHEmO9l8FHz0PpIBgxxnJoQj
         G0Bms8cXp5JrarE3cVq8ioxgfhquzjxVvqyvVAtkWaNijcXxTTaSwLMFuQzgVpLEtdB+
         NhlpcL1P9IBX7dPBMrwdBg/PAYFHSYUXrk+bbOSRvlJqcXZrwCS4EWhoK/6PcGYUDgzy
         8qAg==
X-Gm-Message-State: AOAM530VCSCPoGtQvnGtR0SN9hJk7offocyYD55YXSY9sIHlnZvOSg2a
        IgNuRUGDlt7NKfOlqRI56HxSfVC5n5/X+g254As=
X-Google-Smtp-Source: ABdhPJzGpShEkG/ccS0iMJqqo0irm9p/R1hvaEoSq6NZ7Fhk14nrvxZzb+//1fGhSI4peg9Nzz79uJ/61uDNj9bnzWE=
X-Received: by 2002:a25:ac04:: with SMTP id w4mr9727770ybi.431.1626401775249;
 Thu, 15 Jul 2021 19:16:15 -0700 (PDT)
MIME-Version: 1.0
References: <98082e819007a0f22d7f0f82914b4d84aabdca6d.1626368678.git.geert@linux-m68k.org>
In-Reply-To: <98082e819007a0f22d7f0f82914b4d84aabdca6d.1626368678.git.geert@linux-m68k.org>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Fri, 16 Jul 2021 10:16:03 +0800
Message-ID: <CAEUhbmVh41mD-2N19T9CxAOZquepmXybgPPi_8ApSjT3M6PG4w@mail.gmail.com>
Subject: Re: [PATCH] riscv: dts: microchip: mpfs-icicle: Fix serial console
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 1:26 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Currently, nothing is output on the serial console, unless
> "console=ttyS0,115200n8" or "earlycon" are appended to the kernel
> command line.  Enable automatic console selection using
> chosen/stdout-path by adding a proper alias, and configure the expected
> serial rate.
>
> While at it, add aliases for the other three serial ports, which are
> provided on the same micro-USB connector as the first one.
>
> Fixes: 0fa6107eca4186ad ("RISC-V: Initial DTS for Microchip ICICLE board")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  .../boot/dts/microchip/microchip-mpfs-icicle-kit.dts     | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
> index ec79944065c98ef2..d75ea11ed043c1f0 100644
> --- a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
> +++ b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
> @@ -14,8 +14,15 @@ / {
>         model = "Microchip PolarFire-SoC Icicle Kit";
>         compatible = "microchip,mpfs-icicle-kit";
>
> +       aliases {
> +               serial0 = &serial0;
> +               serial1 = &serial1;
> +               serial2 = &serial2;
> +               serial3 = &serial3;
> +       };
> +
>         chosen {
> -               stdout-path = &serial0;
> +               stdout-path = "serial0:115200n8";
>         };
>
>         cpus {
> --

If possible, please rebase this patch on top of
https://patchwork.kernel.org/project/linux-riscv/patch/20210702014319.1265766-2-bmeng.cn@gmail.com/

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
