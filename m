Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3299130AE37
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 18:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhBARmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 12:42:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:49940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232415AbhBARmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 12:42:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7887F64EAA;
        Mon,  1 Feb 2021 17:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612201318;
        bh=ybs2BjLIvCtgeEHWIhH8ceHvU46UUKeRDstqhNyQg1w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uCIM1MZBWbcSRgN8jiYxb9C598chJYIn9WripQhgGRbOIIMu2dy20xxEv4gn5dbOx
         JepXGPCAOHS0XEl+VjfxfvtucEnoYkNHKRZ5i65gkrc9hvu7r23eMyWhoGkBr7d11+
         9BpMcekQSJtGFJicLklF5h6vnK1ul8rcxw2ShGd9167+INRffopnaOj2cmLPXv0N/3
         YNaFIkATuu/Holhk0AoaXupg4tPVE8+wd0UNfup5WXyTDxAdA4UBsIjxt0UjlqJz2U
         K3Ev5dpx0fjURPkwVlecF7Dv+aSMK2LmqxpuMTiLeIr/jBZ6DKtl7900q8aUQeF/Wi
         fLIvrTvP+5VGQ==
Received: by mail-ed1-f48.google.com with SMTP id z22so19843074edb.9;
        Mon, 01 Feb 2021 09:41:58 -0800 (PST)
X-Gm-Message-State: AOAM5337pMymA32CYVuz3wdrgwKmCIXoaBJLluQUriU/zxtwMsPXajns
        Gf7+56WTImixllHu/7ikIKfVzdTkmi5A8yOy4A==
X-Google-Smtp-Source: ABdhPJycVLHeIeCZoNZihSTEHGT3FA6AUQ769o3mh3xfgMC1ChbE01FdkYLJxISrpMZXi2WR89lVQXbRxEAh7XBTVII=
X-Received: by 2002:a05:6402:1b11:: with SMTP id by17mr19632838edb.373.1612201317039;
 Mon, 01 Feb 2021 09:41:57 -0800 (PST)
MIME-Version: 1.0
References: <91e3405245c89f134676449cf3822285798d2ed2.1612189652.git.michal.simek@xilinx.com>
In-Reply-To: <91e3405245c89f134676449cf3822285798d2ed2.1612189652.git.michal.simek@xilinx.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 1 Feb 2021 11:41:41 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJnu1M6ut8g_36ve-OG22jFsySHbmVHOgtDRhc-s37rpQ@mail.gmail.com>
Message-ID: <CAL_JsqJnu1M6ut8g_36ve-OG22jFsySHbmVHOgtDRhc-s37rpQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: zynq: Add address-cells property to interrupt controllers
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>,
        Andre Przywara <andre.przywara@arm.com>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 8:27 AM Michal Simek <michal.simek@xilinx.com> wrote:
>
> The commit 3eb619b2f7d8 ("scripts/dtc: Update to upstream version
> v1.6.0-11-g9d7888cbf19c") updated dtc version which also contained DTC
> commit
> "81e0919a3e21 checks: Add interrupt provider test"
> where reasons for this checking are mentioned as
> "A missing #address-cells property is less critical, but creates
> ambiguities when used in interrupt-map properties, so warn about this as
> well now."
>
> Add address-cells property to gic and gpio nodes to get rid of this warning.
> The similar change has been done for ZynqMP too.

FYI, we're going to make this check dependent on having an
interrupt-map property. So adding these isn't necessary.

>
> CC: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
>  arch/arm/boot/dts/zynq-7000.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
> index df9ad831cf05..c4810d58540b 100644
> --- a/arch/arm/boot/dts/zynq-7000.dtsi
> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> @@ -133,6 +133,7 @@ can1: can@e0009000 {
>
>                 gpio0: gpio@e000a000 {
>                         compatible = "xlnx,zynq-gpio-1.0";
> +                       #address-cells = <0>;
>                         #gpio-cells = <2>;
>                         clocks = <&clkc 42>;
>                         gpio-controller;
> @@ -168,6 +169,7 @@ i2c1: i2c@e0005000 {
>                 intc: interrupt-controller@f8f01000 {
>                         compatible = "arm,cortex-a9-gic";
>                         #interrupt-cells = <3>;
> +                       #address-cells = <0>;
>                         interrupt-controller;
>                         reg = <0xF8F01000 0x1000>,
>                               <0xF8F00100 0x100>;
> --
> 2.30.0
>
