Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959DB3F61D9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 17:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238390AbhHXPmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 11:42:09 -0400
Received: from mail-ua1-f48.google.com ([209.85.222.48]:35617 "EHLO
        mail-ua1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238383AbhHXPmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 11:42:07 -0400
Received: by mail-ua1-f48.google.com with SMTP id r20so5915812uat.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 08:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BpalmFczsKrzSZmLbopzpftY8pBp3iweKYlzoS1maaY=;
        b=k9VDozFMHGIRAv0M35KzI22SL+apqn3c+OkgFXUOBjl08ROK6IvLNGxrJs/fJ1lBFs
         j3qSvyDt325LmG3CEPF+ETc2Wek1kJUwwQ4CcCrMtzJA2JLO3wNHdT6ikIhTQ9nF9VSV
         67WnESFCIPe3+/YcKbloeqW5CdS5VcyBhzkK+6UnTEZAPLkm7O4OajlKR/Lywt6pnXhV
         17nxEC31mqdvkU4Lnbb+YuwUsc6yaFEBkJqzER/8G+yDVYtcCAgdd0G3CP7PZYGOeJUT
         3E4aHe9gFjA4Pwo6DamBkBQB0m+mLxTiRG8w7qxZfeEbqHwBfa44xPlF8Jy9aWcVLB/9
         UOGA==
X-Gm-Message-State: AOAM531/oeiEUvWvjlkap9TYx23100H0a1LLpSvx93dfu8LB2Qj63coD
        z/OTtDcmrjsQ/kjjWzkEcyUytRIgoTb5SDMRLUc=
X-Google-Smtp-Source: ABdhPJw1io8JEw5E317P/UDRY+Xnlg5WgVCTEbkuiJg8bWOm2OF8M2PQDBox+yiYfddi4T96nWlJDH8h/bkB+7j4L5U=
X-Received: by 2002:a67:cb0a:: with SMTP id b10mr28549281vsl.9.1629819683118;
 Tue, 24 Aug 2021 08:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210804123015.807929-1-bmeng.cn@gmail.com>
In-Reply-To: <20210804123015.807929-1-bmeng.cn@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 24 Aug 2021 17:41:11 +0200
Message-ID: <CAMuHMdV3DJTii41Q4dy9XSL2zD2rd2ND6rrMwBLNiFsJz+jP3Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] riscv: dts: microchip: Use 'local-mac-address' for emac1
To:     Bin Meng <bmeng.cn@gmail.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <Conor.Dooley@microchip.com>,
        Atish Patra <atish.patra@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Bin Meng <bin.meng@windriver.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bin,

On Wed, Aug 4, 2021 at 2:30 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> From: Bin Meng <bin.meng@windriver.com>
>
> Per the DT spec, 'local-mac-address' is used to specify MAC address
> that was assigned to the network device, while 'mac-address' is used
> to specify the MAC address that was last used by the boot program,
> and shall be used only if the value differs from 'local-mac-address'
> property value.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> Reviewed-by: conor dooley <conor.dooley@microchip.com>

Thanks for your patch!

> ---
>
> (no changes since v1)
>
>  arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> index 0659068b62f7..a9c558366d61 100644
> --- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> +++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> @@ -317,7 +317,7 @@ emac1: ethernet@20112000 {
>                         reg = <0x0 0x20112000 0x0 0x2000>;
>                         interrupt-parent = <&plic>;
>                         interrupts = <70 71 72 73>;
> -                       mac-address = [00 00 00 00 00 00];
> +                       local-mac-address = [00 00 00 00 00 00];

Is there any point in providing an all-zeros MAC address at all?
Can't it just be removed?

>                         clocks = <&clkcfg 5>, <&clkcfg 2>;
>                         status = "disabled";
>                         clock-names = "pclk", "hclk";

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
