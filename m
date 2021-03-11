Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718D23378F0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbhCKQOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbhCKQNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:13:36 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCE0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 08:13:36 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id k2so22509858ioh.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 08:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FqcL1Rgnmec2dt7Ge1HH6XIfpeDIZHEe5J5YJyQSwbQ=;
        b=sObyGxKKUC+sMYUqLDRBzSDwKOjtmv7SlzU9YCmYUHsYMGISfSaIVPkcvOaHJtjmzO
         +PX4PzP7DOOnUMttbf4yDC0cdBp5h6sphBhpISXd6lVp/AduWKd8BUZsC6JP437Cu2hF
         IudA9w/ffcv+LUkj4xfvLqqQIE+nY1h8ejWf43reUh8rZ9P9WyuCMEPxryCqMHChhdNw
         MnJGMKhZqblDgj4V6MurQZ1qtKQuXw2e/u2rYWWKFF8b6nzGF6uzI+/Aez0+9YBUBhLt
         9FDztcAMqOLprR/8t3bnzu3YQlNIruitg2nJg9jUDixRPDfhFithO92upgX4z4U+pJxg
         V3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FqcL1Rgnmec2dt7Ge1HH6XIfpeDIZHEe5J5YJyQSwbQ=;
        b=bvaGzbz3u+v6QpQuXbcVb+FTIprIoyfl5Wx3z/Remw9XcNeDdp7gkzSO+OB21/VVUj
         WKDu4IWNIIl39mTnsnVlKWyXPUxr1Gwyw45r4eVYSoI+T1hwJKnAU6zYzhliOv+CwEQu
         bFH3lfqF/BoZV1Pzcd5eIZYQs/FPyvmTkJCHX8vEPk0mk+7me2lGneqNqDWvQFZ8js8r
         2O0Vn6Fl749rTyFEpA00QqqKslNs5hw4WVedjvWwZmws3XohZym5LT0Z4HxTZLks+jxz
         4HEGJbhL5uB5hBh1evLAhKAQQusxj5/cCNSpxCj2xtqy0rGvlomA00hfd7/c450lIjEw
         N22Q==
X-Gm-Message-State: AOAM531LOVHGiUi2I92PUBJo0fS/DCDZLcN2sqxoBgnVrSxTobClgFaQ
        xZS66RV68SQNB/J2cKl/Jy+bIRHAEtREF+p0g9M=
X-Google-Smtp-Source: ABdhPJyAo2+H+YtUgIzOh2AWw100Gssn6rA/M5Fx2bY7jZSRwYwSG46453UXNrylYvBvnchs6yRkkKpRTgd4Tq3b2RA=
X-Received: by 2002:a05:6638:3293:: with SMTP id f19mr4632722jav.0.1615479215990;
 Thu, 11 Mar 2021 08:13:35 -0800 (PST)
MIME-Version: 1.0
References: <20210308090329.17507-1-heiko.thiery@gmail.com> <CAEyMn7bCdzFTWpXBQ8jP-drw_ykXRUhawHMZqXHsHgy-3oD6LA@mail.gmail.com>
In-Reply-To: <CAEyMn7bCdzFTWpXBQ8jP-drw_ykXRUhawHMZqXHsHgy-3oD6LA@mail.gmail.com>
From:   Heiko Thiery <heiko.thiery@gmail.com>
Date:   Thu, 11 Mar 2021 17:13:25 +0100
Message-ID: <CAEyMn7bZy0vWbrmEuEb3HAGPWitai=uBiZS_-yvD8UzcCN+aTQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: configs: Enable PCIe support for imx8mq boards
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Lucas Stach <l.stach@pengutronix.de>,
        Baruch Siach <baruch@tkos.co.il>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Added some more to the CC list since they could be interested in this.

Am Mo., 8. M=C3=A4rz 2021 um 13:58 Uhr schrieb Heiko Thiery <heiko.thiery@g=
mail.com>:
>
> Hi all,
>
> Am Mo., 8. M=C3=A4rz 2021 um 10:03 Uhr schrieb Heiko Thiery <heiko.thiery=
@gmail.com>:
> >
> > Enable PCI_IMX6 to get PCI support for imx8mq boards like imx8mq-evk,
> > imx8mq-kontron-pitx-imx8m and imx8mq-zii-ultra. This increases the imag=
e
> > by 64k.
>
> The growth of 64k is not right.
>
> Using the support script shows:
>
> $ scripts/bloat-o-meter vmlinux vmlinux.with_pci
> add/remove: 22/2 grow/shrink: 2/0 up/down: 8338/-16 (8322)
> Function                                     old     new   delta
> imx6_pcie_probe                                -    1804   +1804
> imx6_pcie_deassert_core_reset                  -    1356   +1356
> imx6_pcie_of_match                             -    1200   +1200
> imx6_pcie_start_link                           -     692    +692
> imx6_pcie_suspend_noirq                        -     528    +528
> imx6_pcie_init_phy                             -     496    +496
> imx6_pcie_host_init                            -     336    +336
> imx6_pcie_assert_core_reset                    -     332    +332
> pcie_phy_write                                 -     272    +272
> imx6_pcie_driver                               -     200    +200
> imx6_pcie_pm_ops                               -     184    +184
> pcie_phy_read                                  -     168    +168
> imx6_pcie_resume_noirq                         -     156    +156
> pcie_phy_wait_ack                              -     140    +140
> pcie_phy_poll_ack.isra                         -     124    +124
> imx6_pcie_quirk                                -     124    +124
> drvdata                                        -      60     +60
> dw_pcie_ops                                  208     264     +56
> imx6_pcie_init                                 -      40     +40
> imx6_pcie_shutdown                             -      32     +32
> imx6_pcie_host_ops                             -      16     +16
> e843419@0d4b_0001256e_27c4                     -       8      +8
> e843419@0590_00007810_4f0                      -       8      +8
> vermagic                                      76      82      +6
> e843419@0c2e_0001064f_80                       8       -      -8
> e843419@0633_00008212_13c                      8       -      -8
> Total: Before=3D21884381, After=3D21892703, chg +0.04%
>
>
> > Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
> > ---
> >  arch/arm64/configs/defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfi=
g
> > index d612f633b771..4b7b4a8f1860 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -225,6 +225,7 @@ CONFIG_PCI_HOST_THUNDER_PEM=3Dy
> >  CONFIG_PCI_HOST_THUNDER_ECAM=3Dy
> >  CONFIG_PCIE_ROCKCHIP_HOST=3Dm
> >  CONFIG_PCIE_BRCMSTB=3Dm
> > +CONFIG_PCI_IMX6=3Dy
> >  CONFIG_PCI_LAYERSCAPE=3Dy
> >  CONFIG_PCIE_LAYERSCAPE_GEN4=3Dy
> >  CONFIG_PCI_HISI=3Dy
> > --
> > 2.30.0
> >


--=20
Heiko
