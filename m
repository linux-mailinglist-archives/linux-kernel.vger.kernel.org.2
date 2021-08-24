Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0E83F61A3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 17:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238274AbhHXPaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 11:30:20 -0400
Received: from mail-ua1-f46.google.com ([209.85.222.46]:37875 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238270AbhHXPaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 11:30:16 -0400
Received: by mail-ua1-f46.google.com with SMTP id g2so5515794uad.4;
        Tue, 24 Aug 2021 08:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hAXDV2WEgT4Td3amBfmVt3dD/b8AG6VOmssivHHzP80=;
        b=a8kJKAzUpXpzLAr3teMk3oal54KWfI+2UW9v3mw4X4RGrG4iE1gAdKFssqCp7Unr+X
         lhsPWKZ1NnGoNbHNqe4oZDL08Mdb3yrRKQmzBq+BW67WCUneGrrjtjY+z0qRLPLdIteJ
         UymO0hNw32eHrbxb/24HPYdLUMS42m+lMPjSPxGBLypMS5Z+Uwu92mE9nyijU9yyB27D
         doYXbphHC14KIZVi1kDRWmpfVIy+SgMLZkBVFJEsHuVwszZ/nnmwVNtCLmwY+X5byUqx
         2eGLrufwq3wxRbt55Dk4mKR2Q1VxS7lKHp5bQWGhOUVL99sfjyfdpzYCoVydP3A2ShTm
         2Yuw==
X-Gm-Message-State: AOAM532BZjkU8EjWxJ/wCFKbmxOWev6O2jMqsf4WBeU7RSbVwz0tBdBo
        cRU08mqPav/dkbuYJwFEaQ0bIW8TJ/M+GDJhqbg=
X-Google-Smtp-Source: ABdhPJwznSbMYiskL2sEMZho2ZztXuaeoqRRaFLbXpd7v868+6eys1TK5q2wufzM+tKaq5laBy8v/raMbBKi4X+dqBE=
X-Received: by 2002:a9f:35aa:: with SMTP id t39mr134352uad.89.1629818970934;
 Tue, 24 Aug 2021 08:29:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210819154436.117798-1-krzysztof.kozlowski@canonical.com> <20210819154436.117798-4-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210819154436.117798-4-krzysztof.kozlowski@canonical.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 24 Aug 2021 17:29:19 +0200
Message-ID: <CAMuHMdX8dBiYadAN8OQpds_bMbLReJy+u6apGe=RZzfEE=BJbw@mail.gmail.com>
Subject: Re: [PATCH 4/6] riscv: microchip: mpfs: fix board compatible
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Atish Patra <atish.patra@wdc.com>,
        Yash Shah <yash.shah@sifive.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Thu, Aug 19, 2021 at 5:45 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
> According to bindings, the compatible must include microchip,mpfs.  This
> fixes dtbs_check warning:
>
>   arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: /: compatible: ['microchip,mpfs-icicle-kit'] is too short
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Thanks for your patch!

> --- a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
> +++ b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
> @@ -10,7 +10,7 @@
>
>  / {
>         model = "Microchip PolarFire-SoC Icicle Kit";
> -       compatible = "microchip,mpfs-icicle-kit";
> +       compatible = "microchip,mpfs-icicle-kit", "microchip,mpfs";

I have the same change in my local tree, but didn't get to submit it
yet, so this part is fine ;-)

>
>         chosen {
>                 stdout-path = &serial0;
> diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> index b9819570a7d1..cb54da0cc3c4 100644
> --- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> +++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> @@ -7,7 +7,7 @@ / {
>         #address-cells = <2>;
>         #size-cells = <2>;
>         model = "Microchip MPFS Icicle Kit";
> -       compatible = "microchip,mpfs-icicle-kit";
> +       compatible = "microchip,mpfs-icicle-kit", "microchip,mpfs";

As this file is the SoC .dtsi, not the board DTS for the full
Icicle Kit, the compatible value should be just "microchip,mpfs"
(to be augmented by the board DTS).
And "model" should be "Microchip PolarFire SoC".

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
