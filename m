Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548523F61F3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 17:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238475AbhHXPrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 11:47:01 -0400
Received: from mail-ua1-f47.google.com ([209.85.222.47]:39705 "EHLO
        mail-ua1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238457AbhHXPq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 11:46:59 -0400
Received: by mail-ua1-f47.google.com with SMTP id a4so11862305uae.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 08:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=msURh4HPk6Cq1BimDbNhMMucXYT7U0Vcy0Sq2atJrx0=;
        b=YsGe+8tOqq4BXMRPgUsvJYXfkS0T8oZHZPNYzsniDc7GPvdhPNwO9HhWoimy2PwMn1
         HSf/sJfU6IhOIEAL4BKfKDD9FuFvl1jd3AIHewEm7mS7oLwlTWc3fCdLE72+y2f/Vn77
         pRdqisZkK5qf33K2TIilrIsPveqWNo/wtb/QoPr4IhH5YL80ZBqhzmoNWjv/8cIpjzwp
         kxMuyR3BHQnSytdnu2yfE/3GmJby1RsNsFTDtEJ8JGkoLEzI0hrStPwnEScaFEDpj8bb
         BDS/O5ZXo/2bq9Bp+b4FICjCzJ4tKIShvwbyLeugvMrXR/dkwshRG3tQdF9wgVhzUM0T
         E+6Q==
X-Gm-Message-State: AOAM533OCvBm0FMKc4f1PeMEzcIDOR9SkDgxYUu1uNCv+zl3eW8s+tcQ
        OkhYDQsK42MSserQvuahEjx+MRKpyyosM2CRxtP2hbWOI9M=
X-Google-Smtp-Source: ABdhPJwAUNvTcQx5kvQLdZtlnNgIdtvcUkBPTndf14lOrIcWLAHO225weCyrNKkIAJ0DtWEtZ71qlOnUdevBBlpY9MY=
X-Received: by 2002:ab0:545:: with SMTP id 63mr26240042uax.122.1629819974316;
 Tue, 24 Aug 2021 08:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210804123015.807929-1-bmeng.cn@gmail.com> <20210804123015.807929-2-bmeng.cn@gmail.com>
In-Reply-To: <20210804123015.807929-2-bmeng.cn@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 24 Aug 2021 17:46:03 +0200
Message-ID: <CAMuHMdVi9EccyTK7KWqb-Box3PaaMkZ0GRFOszmHP6JsyvAzAg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] riscv: dts: microchip: Add ethernet0 to the
 aliases node
To:     Bin Meng <bmeng.cn@gmail.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <Conor.Dooley@microchip.com>,
        Atish Patra <atish.patra@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Bin Meng <bin.meng@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bin,

On Wed, Aug 4, 2021 at 2:30 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> From: Bin Meng <bin.meng@windriver.com>
>
> U-Boot expects this alias to be in place in order to fix up the mac
> address of the ethernet node.
>
> Note on the Icicle Kit board, currently only emac1 is enabled so it
> becomes the 'ethernet0'.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
>
> ---
>
> Changes in v2:
> - move the aliases node to board dts

Thanks for the update!

> --- a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
> +++ b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
> @@ -14,6 +14,10 @@ / {
>         model = "Microchip PolarFire-SoC Icicle Kit";
>         compatible = "microchip,mpfs-icicle-kit";
>
> +       aliases {
> +               ethernet0 = &emac1;
> +       };
> +
>         chosen {
>                 stdout-path = &serial0;
>         };

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

BTW, is Ethernet working in Linux for you?
IP-Config is always timing out for me.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
