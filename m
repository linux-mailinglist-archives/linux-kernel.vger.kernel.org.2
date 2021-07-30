Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A3E3DBD0C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 18:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhG3QZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 12:25:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:53254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229477AbhG3QZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 12:25:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2706A60FE7;
        Fri, 30 Jul 2021 16:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627662336;
        bh=sA63E+oqJJ7UWdv9uF5sfRhQ4j6Gx9VX+xOpdEdo6h0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jS9BFccOPTpKkCjJFTCBO88F3DMk2jMCRhK5QLV98IdkyJEYmWlVu2687SC1u+k/Y
         fjZbpEiAHibvKnttArOqEu2LzesWS7xeTlvTq4jNS30COCDt8qjQzLOSTtSWv/Aa0x
         XtwrqpL6Kx+8m3x1IBYfsNOo256Uu5JRBU6r8bgZcjlC/rk7Nf+qlKOb9EobGPA1Gb
         S6NAsJnD9lbiirauTk8rFXJIlvRXyXNDo1Ch4G+ZeHoLIaesAidiGp91wZIGcDdtde
         Nn4tjlBX4lTDcO5FVG8L4+Tpa1FKXmGqpH6Cwyh07jM2tNIcwbkQqjLVrYEITzrOer
         GxNFMn8eJKapQ==
Received: by mail-ej1-f50.google.com with SMTP id hw6so3864477ejc.10;
        Fri, 30 Jul 2021 09:25:36 -0700 (PDT)
X-Gm-Message-State: AOAM533HeBdzAp/MShK/nmxJaApIEHjBwcvf5Ncv4cKzvxPQL8cUXuKq
        p1rSTVmKu08YCognvln93Nmnene78uWgB08a/w==
X-Google-Smtp-Source: ABdhPJzUHXufwkXoss/77m4sQYQ/EZIV/apB3ArXywXGuhy8awJUzO6fvBpnf0vnZmbGVPevzW+1OUX0QTzvPondd38=
X-Received: by 2002:a17:906:2497:: with SMTP id e23mr3371194ejb.194.1627662334694;
 Fri, 30 Jul 2021 09:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <1627459111-2907-1-git-send-email-chunfeng.yun@mediatek.com> <1627459111-2907-9-git-send-email-chunfeng.yun@mediatek.com>
In-Reply-To: <1627459111-2907-9-git-send-email-chunfeng.yun@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 31 Jul 2021 00:25:23 +0800
X-Gmail-Original-Message-ID: <CAAOTY__fG3Q9RGfONw4kmgdAnxuZ4bAbD9PaggPSPyfB+5p==A@mail.gmail.com>
Message-ID: <CAAOTY__fG3Q9RGfONw4kmgdAnxuZ4bAbD9PaggPSPyfB+5p==A@mail.gmail.com>
Subject: Re: [PATCH 9/9] phy: phy-mtk-mipi-dsi: convert to devm_platform_ioremap_resource
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-phy@lists.infradead.org, DTML <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Chunfeng:

Chunfeng Yun <chunfeng.yun@mediatek.com> =E6=96=BC 2021=E5=B9=B47=E6=9C=882=
8=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=883:59=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Use devm_platform_ioremap_resource to simplify code

Acked-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  drivers/phy/mediatek/phy-mtk-mipi-dsi.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi.c b/drivers/phy/mediat=
ek/phy-mtk-mipi-dsi.c
> index 61c942fbf4a1..28ad9403c441 100644
> --- a/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
> +++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
> @@ -130,7 +130,6 @@ static int mtk_mipi_tx_probe(struct platform_device *=
pdev)
>  {
>         struct device *dev =3D &pdev->dev;
>         struct mtk_mipi_tx *mipi_tx;
> -       struct resource *mem;
>         const char *ref_clk_name;
>         struct clk *ref_clk;
>         struct clk_init_data clk_init =3D {
> @@ -148,11 +147,9 @@ static int mtk_mipi_tx_probe(struct platform_device =
*pdev)
>
>         mipi_tx->driver_data =3D of_device_get_match_data(dev);
>
> -       mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       mipi_tx->regs =3D devm_ioremap_resource(dev, mem);
> -       if (IS_ERR(mipi_tx->regs)) {
> +       mipi_tx->regs =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(mipi_tx->regs))
>                 return PTR_ERR(mipi_tx->regs);
> -       }
>
>         ref_clk =3D devm_clk_get(dev, NULL);
>         if (IS_ERR(ref_clk)) {
> --
> 2.18.0
>
