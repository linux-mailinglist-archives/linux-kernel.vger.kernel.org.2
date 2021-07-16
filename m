Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30DE13CB539
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 11:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbhGPJ0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 05:26:21 -0400
Received: from mail-vs1-f46.google.com ([209.85.217.46]:43838 "EHLO
        mail-vs1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbhGPJ0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 05:26:20 -0400
Received: by mail-vs1-f46.google.com with SMTP id a66so4598303vsd.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 02:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1OqoN0B06XByOpA3tvQ9e3EVDa9GANnN7IQYUpgh/g8=;
        b=HdEjWzERd5IYnLD+eRqCCuPJoOlt7zBaVXpbta6Inr9zIWoZI8NneG4jMhIa7rf5fT
         MOI95rcDD+wqCRbmGurD2Koy3BA/nHjD5rjcmWT+AhFyYjWRJDGR+ErQo30ilnUuENYm
         9Gahrb/7RIKGatTQZyxCcXoWMQmMmWm9QCwRAttcNGmkZYc0MoEKfnC12XqeN8ihwIFD
         fRq+hPwAeIcZV/oBXxS7DbilYXs4r82crP0XRMw/6tRxfowyL04jZ8qeRtM+1Sz858C6
         U7dvuKDMnYNAwUTxjJLlnTxESYUqBD0AHW+e78UfFTG8dxmUfPU5nQ24w/HwuDuoyfAf
         nq0w==
X-Gm-Message-State: AOAM5323KXjN8Ie+HYuQXKq8fLIQypdI2OUHMzgDoBsF9mGUw8sJfiML
        OGgLfrz8F7s1yFiGq2t3JRzl1avPqenWr1Y0A54=
X-Google-Smtp-Source: ABdhPJyZz8xamPCaCgF5o9kpuaoOkG86/tNUETDuZikOJ1wKaZ5/cu6TX3V11ted7nXi6hg4j9uW3JfatNByxpjFu0M=
X-Received: by 2002:a05:6102:321c:: with SMTP id r28mr11247074vsf.40.1626427405168;
 Fri, 16 Jul 2021 02:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210702014319.1265766-1-bmeng.cn@gmail.com> <20210702014319.1265766-2-bmeng.cn@gmail.com>
In-Reply-To: <20210702014319.1265766-2-bmeng.cn@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 16 Jul 2021 11:23:14 +0200
Message-ID: <CAMuHMdWpJ194jEnXiUhs5dfC-33rGUm7pE9aMHUTYoMCUdFxZA@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: dts: microchip: Add ethernet0 to the aliases node
To:     Bin Meng <bmeng.cn@gmail.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Lewis Hanly <lewis.hanly@microchip.com>,
        Atish Patra <atish.patra@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Bin Meng <bin.meng@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bing,

On Fri, Jul 2, 2021 at 3:44 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> From: Bin Meng <bin.meng@windriver.com>
>
> U-Boot expects this alias to be in place in order to fix up the mac
> address of the ethernet node.
>
> Note on the Icicle Kit board, currently only emac1 is enabled so it
> becomes the 'ethernet0'.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Thanks for your patch!

> --- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> +++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> @@ -9,6 +9,10 @@ / {
>         model = "Microchip MPFS Icicle Kit";
>         compatible = "microchip,mpfs-icicle-kit";
>
> +       aliases {
> +               ethernet0 = &emac1;
> +       };
> +
>         chosen {
>         };

This should be added to the board DTS (microchip-mpfs-icicle-kit.dts)
instead.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
