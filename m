Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7160D330EC3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 13:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhCHM7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 07:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhCHM6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 07:58:53 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A683C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 04:58:53 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id p10so8693417ils.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 04:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8pF8uR2V8h6tExgzDgjhyhnOTS0E2IJvDkFMWJdXK5I=;
        b=N0cGRlMdBVqNyx4WDmWjwO45vvTRmDVJxaprExcasEF2xEdHGrF66N56dbABm+QBTc
         brq3nRTCBvHvKMNx8XDci0DHryI0ekJZaYC6GAFf1s1GYzzD0SCIlAcuixgcNye9dERk
         avK/tdva2YJarbrgHCsmqe0GNyKfN9Ro0lXEmqTSsbV7mO7LEZdJNoZPq7ZZ/R7ZNrMV
         AiQwi9JOV58wxravnVBHx+lyEaBwAJQbDFsohVSjf9+8rNeVf8GFTs8FvKOOChUN38Bt
         ZE/ZIx7Wk9rT4xkxNoIylYYWS5jhWQCdBryT3B5bauosehiL7M2K33cpPFS2ZJZJ7LXs
         Xo4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8pF8uR2V8h6tExgzDgjhyhnOTS0E2IJvDkFMWJdXK5I=;
        b=XnT/pFHQCRZbTuHTUplJ6WsWpyAYU76FZCC/OTs2rdrLmX47mho3NsorBFnH5fTolR
         62llcr4XFNBe/ajZnF/Ss5FgspAPDXWcr6tl8G30aYdN3fyhIlH/mGrRiMnn4K3rrDrH
         p2gM9vfAoqO/0UCa51uveEUucBH8sgLV4uy/MsulyzO0t1huwD4W0HJbRFICp076+Re4
         MFjO6WdnePmka0b92Z+h90lA5/ogto+RRdOoWHcMFkap2AkY3Qh8tqBkEQ8WNqwgTZIg
         Ss7ru6PUQMj3K8FHdbcLo1U6UWQeeNmhCNjsY1mzlh1ytYRmF4qWa0ECd+Ff4bnwbZ9+
         /N6w==
X-Gm-Message-State: AOAM531OasaEkTMvhE+O7QpZQEeRxmUSXjOXtlZ+g7293AxLMEu6XtBr
        +yYSulnkieVN23BPb2XZsO4rXsODIIImM/7Zq2k=
X-Google-Smtp-Source: ABdhPJxnOthh8rEnpOwyJbPQH1UBnpi0bSMuLHJwm5eZf8o0XOVpAd0Rjpcqq4ro01yEDaBBjzrMZr3KR1IvHTqWYOI=
X-Received: by 2002:a92:d981:: with SMTP id r1mr19348478iln.98.1615208332833;
 Mon, 08 Mar 2021 04:58:52 -0800 (PST)
MIME-Version: 1.0
References: <20210308090329.17507-1-heiko.thiery@gmail.com>
In-Reply-To: <20210308090329.17507-1-heiko.thiery@gmail.com>
From:   Heiko Thiery <heiko.thiery@gmail.com>
Date:   Mon, 8 Mar 2021 13:58:41 +0100
Message-ID: <CAEyMn7bCdzFTWpXBQ8jP-drw_ykXRUhawHMZqXHsHgy-3oD6LA@mail.gmail.com>
Subject: Re: [PATCH] arm64: configs: Enable PCIe support for imx8mq boards
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Michael Walle <michael@walle.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Am Mo., 8. M=C3=A4rz 2021 um 10:03 Uhr schrieb Heiko Thiery <heiko.thiery@g=
mail.com>:
>
> Enable PCI_IMX6 to get PCI support for imx8mq boards like imx8mq-evk,
> imx8mq-kontron-pitx-imx8m and imx8mq-zii-ultra. This increases the image
> by 64k.

The growth of 64k is not right.

Using the support script shows:

$ scripts/bloat-o-meter vmlinux vmlinux.with_pci
add/remove: 22/2 grow/shrink: 2/0 up/down: 8338/-16 (8322)
Function                                     old     new   delta
imx6_pcie_probe                                -    1804   +1804
imx6_pcie_deassert_core_reset                  -    1356   +1356
imx6_pcie_of_match                             -    1200   +1200
imx6_pcie_start_link                           -     692    +692
imx6_pcie_suspend_noirq                        -     528    +528
imx6_pcie_init_phy                             -     496    +496
imx6_pcie_host_init                            -     336    +336
imx6_pcie_assert_core_reset                    -     332    +332
pcie_phy_write                                 -     272    +272
imx6_pcie_driver                               -     200    +200
imx6_pcie_pm_ops                               -     184    +184
pcie_phy_read                                  -     168    +168
imx6_pcie_resume_noirq                         -     156    +156
pcie_phy_wait_ack                              -     140    +140
pcie_phy_poll_ack.isra                         -     124    +124
imx6_pcie_quirk                                -     124    +124
drvdata                                        -      60     +60
dw_pcie_ops                                  208     264     +56
imx6_pcie_init                                 -      40     +40
imx6_pcie_shutdown                             -      32     +32
imx6_pcie_host_ops                             -      16     +16
e843419@0d4b_0001256e_27c4                     -       8      +8
e843419@0590_00007810_4f0                      -       8      +8
vermagic                                      76      82      +6
e843419@0c2e_0001064f_80                       8       -      -8
e843419@0633_00008212_13c                      8       -      -8
Total: Before=3D21884381, After=3D21892703, chg +0.04%


> Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index d612f633b771..4b7b4a8f1860 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -225,6 +225,7 @@ CONFIG_PCI_HOST_THUNDER_PEM=3Dy
>  CONFIG_PCI_HOST_THUNDER_ECAM=3Dy
>  CONFIG_PCIE_ROCKCHIP_HOST=3Dm
>  CONFIG_PCIE_BRCMSTB=3Dm
> +CONFIG_PCI_IMX6=3Dy
>  CONFIG_PCI_LAYERSCAPE=3Dy
>  CONFIG_PCIE_LAYERSCAPE_GEN4=3Dy
>  CONFIG_PCI_HISI=3Dy
> --
> 2.30.0
>

--=20
Heiko
