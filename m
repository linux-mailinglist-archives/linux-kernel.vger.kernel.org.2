Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646C3353C4B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 10:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbhDEIOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 04:14:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232041AbhDEIOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 04:14:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 30A6D6139C;
        Mon,  5 Apr 2021 08:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617610443;
        bh=a92XBC6+vQ67hke8nAq6hrsWpIpBDgHPoei6eyrljaU=;
        h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
        b=pOtsEywCGZwF0vLb6gApQRc+BRTznECgwuZqvx1mhV1u3aLV4KB3/bYPVaxAKo02c
         YLl6Tz9HZNP+UTznonbxRwWspAkH8j6P+Qk0Q25NfpxXZOvi+CQiWPXv/yxmXj3EuF
         iIsvT7dAut/IkWF6P4g3MKo6OMM1MrNobhy2FPdPkQpLpdubp4cZCl/LvSmVeZug7M
         bPCnzkySQW3g6uYhy8rQEAEtIfaUet84+yY8NITdqPghcZs+OWb6U7OzLTSEjIL3sG
         XosBM8IGc8wc3jND3L0LR3lwSwhvM1nCaIVFJa1na4RtZDf9auGcKuqxaAPg9ROk6G
         0iH1B0USB5YAA==
Received: by mail-lj1-f181.google.com with SMTP id 184so11894350ljf.9;
        Mon, 05 Apr 2021 01:14:03 -0700 (PDT)
X-Gm-Message-State: AOAM531sWkkhP/mz+0ScyVZAjDkQKXolPelMTJ3bJrXOt0Jbk8qY7qtS
        K6AOIP2Lk+p2LIEZoV0xMu+T79TAqxz2sWByD9o=
X-Google-Smtp-Source: ABdhPJw0+QWtwYYDXiy1mXyiNkRuNjehDVi+EMUMSiAzw/0A0was8kKG5w3L1MXHhXNVeSTsG/ZcIW3PS9Fr/6+o13s=
X-Received: by 2002:a2e:7d04:: with SMTP id y4mr15991236ljc.94.1617610441474;
 Mon, 05 Apr 2021 01:14:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210405074459.4217-1-cnsztl@gmail.com>
In-Reply-To: <20210405074459.4217-1-cnsztl@gmail.com>
Reply-To: wens@kernel.org
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Mon, 5 Apr 2021 16:13:49 +0800
X-Gmail-Original-Message-ID: <CAGb2v66K3SFSkm9T_D6X5o7jSYOoYpYeS_yMp1k6nMonmjiHZA@mail.gmail.com>
Message-ID: <CAGb2v66K3SFSkm9T_D6X5o7jSYOoYpYeS_yMp1k6nMonmjiHZA@mail.gmail.com>
Subject: Re: [PATCH] rockchip: enabled LAN port on NanoPi R2S
To:     Tianling Shen <cnsztl@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        David Bauer <mail@david-bauer.net>,
        Robin Murphy <robin.murphy@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 5, 2021 at 3:46 PM Tianling Shen <cnsztl@gmail.com> wrote:
>
> From: David Bauer <mail@david-bauer.net>
>
> Enable the USB3 port on the FriendlyARM NanoPi R2S.
> This is required for the USB3 attached LAN port to work.
>
> Signed-off-by: David Bauer <mail@david-bauer.net>
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> ---
>  .../boot/dts/rockchip/rk3328-nanopi-r2s.dts   | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
> index faf496d789cf..6ba9799a95c5 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
> @@ -37,6 +37,18 @@
>                 };
>         };
>
> +       vcc_rtl8153: vcc-rtl8153-regulator {
> +               compatible = "regulator-fixed";
> +               gpio = <&gpio2 RK_PC6 GPIO_ACTIVE_HIGH>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&rtl8153_en_drv>;
> +               regulator-always-on;
> +               regulator-name = "vcc_rtl8153";
> +               regulator-min-microvolt = <5000000>;
> +               regulator-max-microvolt = <5000000>;

This is just a simple switch, not an actual regulator.
It would make more sense to drop the voltage range and
instead have the implementation pass-through voltage
constraints from its parent.

> +               enable-active-high;
> +       };
> +
>         leds {
>                 compatible = "gpio-leds";
>                 pinctrl-0 = <&lan_led_pin>,  <&sys_led_pin>, <&wan_led_pin>;
> @@ -265,6 +277,12 @@
>                         };
>                 };
>         };
> +
> +       usb {
> +               rtl8153_en_drv: rtl8153-en-drv {
> +                       rockchip,pins = <2 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
> +               };
> +       };
>  };
>
>  &io_domains {
> @@ -364,6 +382,11 @@
>         dr_mode = "host";
>  };
>
> +&usbdrd3 {
> +       dr_mode = "host";
> +       status = "okay";

Please also add a device node for the actual Ethernet controller, and
set up an aliases node for it, so that the bootloader has some place
to fill in a MAC address.


ChenYu

> +};
> +
>  &usb_host0_ehci {
>         status = "okay";
>  };
> --
> 2.17.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
