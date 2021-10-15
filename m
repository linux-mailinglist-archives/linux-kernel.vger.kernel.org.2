Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF3142F7E6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 18:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241209AbhJOQR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 12:17:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:48884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241203AbhJOQRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 12:17:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6484561090;
        Fri, 15 Oct 2021 16:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634314546;
        bh=J6lMIRppIQQR2yDU8HEFtiobkHUlT4L+X3PXR/XHp8k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fUxjpQpKZEMfW+RRIp60SX1iX/UwmX2w7X5lIZEpj7biPSsFXPDMUQafV+MRGFMmQ
         EL8HPMjTiB8NjmWVoshAD7lta4yw5ks7FQ5A97AWaT6RIcAyKWEtDQ6UK7wHLXbbG3
         Z1ztXj9KpCB5OMJzlWulfrEP66XP61txqi1cOfM0ryOvkLKJse4YDrrC9cAeT803ZX
         I1dRqcI6sM7uBu908E4buE0sgeJjzPDGbl1FQ9Mcim+RVQCz+xQivYjOcEswbqaOuG
         3L1+rjNW2B0Xd0lB3zf/uOnVZtTN0eV7Al82PBbYtkmb3ud3BZvtdUS/bkKYpz+Va3
         4TlkTUzrYEe4g==
Received: by mail-ed1-f48.google.com with SMTP id t16so40103749eds.9;
        Fri, 15 Oct 2021 09:15:46 -0700 (PDT)
X-Gm-Message-State: AOAM5330xQeEoC3oy4XV9gncJb3ptN4/iAdPOz0bILr8TYnsScTPvcPq
        iWa9BEFbV5IfNl9RR7wP8qKcXabwPAQQSon2pA==
X-Google-Smtp-Source: ABdhPJwsRQPmyqCZEJ2EspO5jNkdQ+LeDKtD0EmxJMsNFClADPbMWi8f8wb8874t+JF0p3aYra/8VjChk0VBCZZRh6M=
X-Received: by 2002:a05:6402:84d:: with SMTP id b13mr19328337edz.6.1634314544839;
 Fri, 15 Oct 2021 09:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211014224201.24027-1-agust@denx.de>
In-Reply-To: <20211014224201.24027-1-agust@denx.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 15 Oct 2021 11:15:32 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+_K9X010eKz0uwGH33h3vwwEE-+f=z9YWEdhji4yHxWg@mail.gmail.com>
Message-ID: <CAL_Jsq+_K9X010eKz0uwGH33h3vwwEE-+f=z9YWEdhji4yHxWg@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/mpc512x: dts: fix PSC node warnings
To:     Anatolij Gustschin <agust@denx.de>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 5:42 PM Anatolij Gustschin <agust@denx.de> wrote:
>
> Rework PSC node description to fix build warnings like:
> mpc5121.dtsi:397.13-406.5: Warning (spi_bus_bridge): /soc@80000000/psc@11400: node name for SPI buses should be 'spi'
> mpc5121.dtsi:409.13-418.5: Warning (spi_bus_bridge): /soc@80000000/psc@11500: node name for SPI buses should be 'spi'
> mpc5121.dtsi:457.13-466.5: Warning (spi_bus_bridge): /soc@80000000/psc@11900: node name for SPI buses should be 'spi'

Okay, I now see the block supports either spi or serial modes. I would
handle this a bit differently that doesn't create a bunch of new .dtsi
files.

>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> ---
> Changes in v2:
>  - extract PSC nodes to files which can be included
>    separately and extended as needed
>
>  arch/powerpc/boot/dts/ac14xx.dts            | 118 ++++++++--------
>  arch/powerpc/boot/dts/mpc5121-psc0.dtsi     |  16 +++
>  arch/powerpc/boot/dts/mpc5121-psc1.dtsi     |  15 ++
>  arch/powerpc/boot/dts/mpc5121-psc10.dtsi    |  15 ++
>  arch/powerpc/boot/dts/mpc5121-psc11.dtsi    |  15 ++
>  arch/powerpc/boot/dts/mpc5121-psc2.dtsi     |  15 ++
>  arch/powerpc/boot/dts/mpc5121-psc3.dtsi     |  15 ++
>  arch/powerpc/boot/dts/mpc5121-psc4-spi.dtsi |  17 +++
>  arch/powerpc/boot/dts/mpc5121-psc4.dtsi     |  15 ++
>  arch/powerpc/boot/dts/mpc5121-psc5-spi.dtsi |  17 +++
>  arch/powerpc/boot/dts/mpc5121-psc5.dtsi     |  15 ++
>  arch/powerpc/boot/dts/mpc5121-psc6.dtsi     |  15 ++
>  arch/powerpc/boot/dts/mpc5121-psc7.dtsi     |  15 ++
>  arch/powerpc/boot/dts/mpc5121-psc8.dtsi     |  15 ++
>  arch/powerpc/boot/dts/mpc5121-psc9-spi.dtsi |  17 +++
>  arch/powerpc/boot/dts/mpc5121-psc9.dtsi     |  15 ++
>  arch/powerpc/boot/dts/mpc5121.dtsi          | 148 +-------------------
>  arch/powerpc/boot/dts/mpc5121ads.dts        |  42 +++---
>  arch/powerpc/boot/dts/pdm360ng.dts          | 104 +++++++-------
>  19 files changed, 371 insertions(+), 273 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/mpc5121-psc0.dtsi
>  create mode 100644 arch/powerpc/boot/dts/mpc5121-psc1.dtsi
>  create mode 100644 arch/powerpc/boot/dts/mpc5121-psc10.dtsi
>  create mode 100644 arch/powerpc/boot/dts/mpc5121-psc11.dtsi
>  create mode 100644 arch/powerpc/boot/dts/mpc5121-psc2.dtsi
>  create mode 100644 arch/powerpc/boot/dts/mpc5121-psc3.dtsi
>  create mode 100644 arch/powerpc/boot/dts/mpc5121-psc4-spi.dtsi
>  create mode 100644 arch/powerpc/boot/dts/mpc5121-psc4.dtsi
>  create mode 100644 arch/powerpc/boot/dts/mpc5121-psc5-spi.dtsi
>  create mode 100644 arch/powerpc/boot/dts/mpc5121-psc5.dtsi
>  create mode 100644 arch/powerpc/boot/dts/mpc5121-psc6.dtsi
>  create mode 100644 arch/powerpc/boot/dts/mpc5121-psc7.dtsi
>  create mode 100644 arch/powerpc/boot/dts/mpc5121-psc8.dtsi
>  create mode 100644 arch/powerpc/boot/dts/mpc5121-psc9-spi.dtsi
>  create mode 100644 arch/powerpc/boot/dts/mpc5121-psc9.dtsi

[...]

> diff --git a/arch/powerpc/boot/dts/mpc5121.dtsi b/arch/powerpc/boot/dts/mpc5121.dtsi
> index 3f66b91a8e3c..21674da8beb1 100644
> --- a/arch/powerpc/boot/dts/mpc5121.dtsi
> +++ b/arch/powerpc/boot/dts/mpc5121.dtsi
> @@ -87,7 +87,7 @@
>                 };
>         };
>
> -       soc@80000000 {
> +       soc: soc@80000000 {
>                 compatible = "fsl,mpc5121-immr";
>                 #address-cells = <1>;
>                 #size-cells = <1>;
> @@ -343,152 +343,6 @@
>                         clock-names = "ipg";
>                 };
>
> -               /* 512x PSCs are not 52xx PSC compatible */
> -
> -               /* PSC0 */
> -               psc@11000 {

I would just put here 'serial@11000' and 'spi@11000' nodes with both
nodes set to disabled. Then the board dts just has to change status of
the the nodes it wants to enable (and add child nodes for spi).
Overlapping addresses are okay if nodes are disabled.

> -                       compatible = "fsl,mpc5121-psc";
> -                       reg = <0x11000 0x100>;
> -                       interrupts = <40 0x8>;
> -                       fsl,rx-fifo-size = <16>;
> -                       fsl,tx-fifo-size = <16>;
> -                       clocks = <&clks MPC512x_CLK_PSC0>,
> -                                <&clks MPC512x_CLK_PSC0_MCLK>;
> -                       clock-names = "ipg", "mclk";
> -               };
