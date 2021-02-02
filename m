Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD22230B904
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 08:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhBBH4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 02:56:48 -0500
Received: from mail-vk1-f173.google.com ([209.85.221.173]:35382 "EHLO
        mail-vk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhBBH4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 02:56:46 -0500
Received: by mail-vk1-f173.google.com with SMTP id e10so4593906vkm.2;
        Mon, 01 Feb 2021 23:56:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cc34DaRdsY7kfkvvEyvwAlSmAaq0gSaXII9V6AsWMi0=;
        b=ONt+lZECGITXBWsqn3d3cs4/Tj87tJ5T5pDfH4wCXjaj5gf16FqP//XVjBEGc7bnPs
         m672Nc6fXi+ao05JgCTvUt+rpS+26gP2jOhCx32P7eBj8CTrlOSwlLrhyAk3qymNiFgu
         kZgWK0itfuvFMRnOWE1Cjp3y0HyTxDUtODKDImToXWHDE4JY3UF2WP5gFPTO2nrjG2/Z
         gt3nfQ5vG2fICvL2fCmpNOAQfXEkxnk8Fd5YM9b7NspGxEgqM/tiuly2Fz7EKf+100vh
         pWqi8NqDm4SNy0tprhbqino2DZ9z50j1KffKzXjhyhGKbbt4yZGFhTvUr+DHJyrPvQ5I
         iJtw==
X-Gm-Message-State: AOAM532JcZNiMaveX2uH0lxRIU4jj5rK/IsDDvNIZ4TWuR4b7PIWamic
        7bNrCCeqan8Tl+v4h8PYb9U7ZXbvv+ZDZQ==
X-Google-Smtp-Source: ABdhPJyb1hshEc5PF6aXE9/0DjNYQ8hPfVVqCBvBWi0pmkWsIv5KJH9hZDmFsUntyjPcMJT5bJ0xhg==
X-Received: by 2002:a1f:450e:: with SMTP id s14mr11932596vka.4.1612252564403;
        Mon, 01 Feb 2021 23:56:04 -0800 (PST)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id l17sm2698405uan.6.2021.02.01.23.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 23:56:03 -0800 (PST)
Received: by mail-vk1-f170.google.com with SMTP id y8so4590090vky.4;
        Mon, 01 Feb 2021 23:56:02 -0800 (PST)
X-Received: by 2002:a1f:f447:: with SMTP id s68mr11402654vkh.17.1612252562184;
 Mon, 01 Feb 2021 23:56:02 -0800 (PST)
MIME-Version: 1.0
References: <20210127172500.13356-1-andre.przywara@arm.com> <20210127172500.13356-5-andre.przywara@arm.com>
In-Reply-To: <20210127172500.13356-5-andre.przywara@arm.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 2 Feb 2021 15:55:50 +0800
X-Gmail-Original-Message-ID: <CAGb2v674jBtROBXZ7HLj9Uqa_BZxW04z9VQ1R6Cn901+ES0k6g@mail.gmail.com>
Message-ID: <CAGb2v674jBtROBXZ7HLj9Uqa_BZxW04z9VQ1R6Cn901+ES0k6g@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v5 04/20] dt-bindings: mfd: axp20x: Add
 AXP305 compatible (plus optional IRQ)
To:     =?UTF-8?Q?Andr=C3=A9_Przywara?= <andre.przywara@arm.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Samuel Holland <samuel@sholland.org>,
        Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh@kernel.org>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Lee Jones <lee.jones@linaro.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 28, 2021 at 1:26 AM Andre Przywara <andre.przywara@arm.com> wrote:
>
> The AXP305 PMIC used in AXP805 seems to be fully compatible to the
                          ^
This statement doesn't quite make sense. I assume you wanted to mention
a board or the H616 SoC here?

> AXP805 PMIC, so add the proper chain of compatible strings.
>
> Also at least on one board (Orangepi Zero2) there is no interrupt line
> connected to the CPU, so make the "interrupts" property optional.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  Documentation/devicetree/bindings/mfd/axp20x.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
> index 4991a6415796..4fd748101e3c 100644
> --- a/Documentation/devicetree/bindings/mfd/axp20x.txt
> +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
> @@ -26,10 +26,10 @@ Required properties:
>      * "x-powers,axp803"
>      * "x-powers,axp806"
>      * "x-powers,axp805", "x-powers,axp806"
> +    * "x-powers,axp803", "x-powers,axp805", "x-powers,axp806"

axp305? axp803 is used with A64 IIRC.

ChenYu

>      * "x-powers,axp809"
>      * "x-powers,axp813"
>  - reg: The I2C slave address or RSB hardware address for the AXP chip
> -- interrupts: SoC NMI / GPIO interrupt connected to the PMIC's IRQ pin
>  - interrupt-controller: The PMIC has its own internal IRQs
>  - #interrupt-cells: Should be set to 1
>
> @@ -43,6 +43,7 @@ more information:
>                         AXP20x/LDO3: software-based implementation
>
>  Optional properties:
> +- interrupts: SoC NMI / GPIO interrupt connected to the PMIC's IRQ pin
>  - x-powers,dcdc-freq: defines the work frequency of DC-DC in KHz
>                       AXP152/20X: range:  750-1875, Default: 1.5 MHz
>                       AXP22X/8XX: range: 1800-4050, Default: 3   MHz
> --
> 2.17.5
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/20210127172500.13356-5-andre.przywara%40arm.com.
