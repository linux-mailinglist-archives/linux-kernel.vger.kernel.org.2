Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA523A045B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 21:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238318AbhFHTcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 15:32:31 -0400
Received: from mail-ej1-f51.google.com ([209.85.218.51]:37728 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236248AbhFHTQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 15:16:52 -0400
Received: by mail-ej1-f51.google.com with SMTP id ce15so34387030ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 12:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TnPZuLFfXVjs03glCG/NEJe45z/p4M5cwaRAiE/dZNE=;
        b=WjT/1t2hnc4lrL4Ov/OK3JtI3+VvdnBj7mss5S7l/BhvmXoZE1KANhdBp1KkZZzpKu
         G+uGjS9LYODYL6KBgUvGq1TTC4RIXocqoKJxDQ6SB7HgDrbqLPXQqPwOKQcpqWkOusm3
         m83//r9c1JL8PIDzzXEJfxiurG4HuvGmtwy30ze513+UgDO6ezlP13pNKZgYC6zaRlz6
         cvJjfMfTL2hNI2y3ZbW1mcbsRR/iONAwW1rqQF0iFje1gM1UpRLNn4UIq4OXg7hBW2uz
         jmuomuGQxkY+XYb9Sll8fWADSACRerwSK1BdJsFN9BZLifqWAQp+C26HCw3gE+afPZR3
         5wWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TnPZuLFfXVjs03glCG/NEJe45z/p4M5cwaRAiE/dZNE=;
        b=tkhqhfAJ0EKo/hey1re9e/yyPYw7OiEOXOzB5OP7nojWHikPKp00399Mv9NAJUKgXg
         Wp9KORgBK+Q8lVSO5SOeocMXexGJRHENsj60N/V2PXQpYs/C4vZJtLhCIsE8b68Y827E
         q9LZgehg3VcUPi/JrgYJuPkqMufhoHxUchHPw9RxY3A3PNvOc7vQLfhwuda9fzoPHjTh
         V/NYViqzWN7Z/FOXHaa+XmbPlPO9gsauP06R/qrA/EHysgpImpT+rL/WoQqMIm2A3h3o
         svYvYkEizoVUbjeMQAFattSSBT4FW0GpxBAEdeWXVsSTVozhrgb7RCWYY0KfxJPUNkvp
         dlYw==
X-Gm-Message-State: AOAM532yRc8NVDqB2yTUBY3yvfvZuBEWBgn+pIyHJxFaHP3/10hwEtk8
        TX73RfM/vr7yLpDwMbNRoBlLA/N7NqEwyYvUgGwzGw==
X-Google-Smtp-Source: ABdhPJzx1yEoxWuOvBxfGpFn/VsQvEyHafi5CLg/00k/rhXeTQuSL9yeai5MeFwcTWD34e1XDH3vIRVStp8vnYebQ7Q=
X-Received: by 2002:a17:906:9d05:: with SMTP id fn5mr24814568ejc.133.1623179638149;
 Tue, 08 Jun 2021 12:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210608175932.263480586@linuxfoundation.org> <20210608175933.214613488@linuxfoundation.org>
In-Reply-To: <20210608175933.214613488@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 9 Jun 2021 00:43:46 +0530
Message-ID: <CA+G9fYvFujaoUqbLh_gcfnPjUVVQD=VHqi6k2ruf57BO1tR5ag@mail.gmail.com>
Subject: Re: [PATCH 4.19 28/58] ARM: dts: imx6q-dhcom: Add PU,VDD1P1,VDD2P5 regulators
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Marek Vasut <marex@denx.de>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Ludwig Zenz <lzenz@dh-electronics.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jun 2021 at 00:08, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> From: Marek Vasut <marex@denx.de>
>
> commit 8967b27a6c1c19251989c7ab33c058d16e4a5f53 upstream.
>
> Per schematic, both PU and SOC regulator are supplied from LTC3676 SW1
> via VDDSOC_IN rail, add the PU input. Both VDD1P1, VDD2P5 are supplied
> from LTC3676 SW2 via VDDHIGH_IN rail, add both inputs.
>
> While no instability or problems are currently observed, the regulators
> should be fully described in DT and that description should fully match
> the hardware, else this might lead to unforseen issues later. Fix this.
>
> Fixes: 52c7a088badd ("ARM: dts: imx6q: Add support for the DHCOM iMX6 SoM and PDK2")
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Ludwig Zenz <lzenz@dh-electronics.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: stable@vger.kernel.org
> Reviewed-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/arm/boot/dts/imx6q-dhcom-som.dtsi |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> --- a/arch/arm/boot/dts/imx6q-dhcom-som.dtsi
> +++ b/arch/arm/boot/dts/imx6q-dhcom-som.dtsi
> @@ -407,6 +407,18 @@
>         vin-supply = <&sw1_reg>;
>  };
>
> +&reg_pu {
> +       vin-supply = <&sw1_reg>;
> +};
> +
> +&reg_vdd1p1 {
> +       vin-supply = <&sw2_reg>;
> +};
> +
> +&reg_vdd2p5 {
> +       vin-supply = <&sw2_reg>;
> +};
> +
>  &uart1 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_uart1>;

arm dtb build failed on stable rc 4.19

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/current ARCH=arm
CROSS_COMPILE=arm-linux-gnueabihf- 'CC=sccache
arm-linux-gnueabihf-gcc' 'HOSTCC=sccache gcc'
Error: /builds/linux/arch/arm/boot/dts/imx6q-dhcom-som.dtsi:414.1-12
Label or path reg_vdd1p1 not found
Error: /builds/linux/arch/arm/boot/dts/imx6q-dhcom-som.dtsi:418.1-12
Label or path reg_vdd2p5 not found
FATAL ERROR: Syntax error parsing input tree
make[2]: *** [scripts/Makefile.lib:294:
arch/arm/boot/dts/imx6q-dhcom-pdk2.dtb] Error 1

Reported-by:  Linux Kernel Functional Testing <lkft@linaro.org>

build url:
https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc/-/jobs/1328891505#L477

Config:
https://builds.tuxbuild.com/1tg0YjTz4ow5CkHv0bzTc05pVs5/config

--
Linaro LKFT
https://lkft.linaro.org
