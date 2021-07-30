Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03983DBD08
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 18:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhG3QYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 12:24:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:52928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229479AbhG3QYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 12:24:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39D7A61052;
        Fri, 30 Jul 2021 16:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627662283;
        bh=rJGnm55O1tNTXXwwxOhfbNirfLkXYq7zue02n7Tdz6g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oiGzBHlg862uFecdCPxiopLytEgtT9H1q/AcThot49jQjIX0/d5bVk+dLn37KqRGH
         BEJyH+6mdVrVF0tRLmWiO7o1PbM8jL0YVqZBN0Q4rgb8dRbSi6L1bRLPH1ocjzoirT
         cp4r77MxFGSCqexTnykNH+UpxKj1SWzfg2c9j4wGfiHUB1Zsgm0+hrqZHFv/k3w0EC
         brPZJ9F45MuY4VagEY4q4F5W3wJwcH4JZaEQn+s4lzkoQYAkZNpNUCoRGdaKecfPhc
         mB7/zX7jbSUiVl6llFHL6nxGTUpZIzevCYu5z12RyOwZTDTUa7hkbcCp+FiAIJlPj0
         rjsgnSxSRyVKg==
Received: by mail-ed1-f49.google.com with SMTP id p21so13939817edi.9;
        Fri, 30 Jul 2021 09:24:43 -0700 (PDT)
X-Gm-Message-State: AOAM533ZtSQ8DHD9bHr7ylSgjQjBQVoiJlz9XUWiKEgFFeEfINwQOhuf
        O9j3XOYrDDpe1M/PaXPhYPMOnfVzgKSRaS6i2Q==
X-Google-Smtp-Source: ABdhPJyA06qzYSh+f7EEVqAUfFRLkrZuqD1G+Hvft9QlGEOSN9ieg2X5H3Hxms9/ORgFt0VU+fGNT3l+kVqqUAMyCdw=
X-Received: by 2002:a50:d71e:: with SMTP id t30mr3917906edi.72.1627662281812;
 Fri, 30 Jul 2021 09:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <1627459111-2907-1-git-send-email-chunfeng.yun@mediatek.com> <1627459111-2907-8-git-send-email-chunfeng.yun@mediatek.com>
In-Reply-To: <1627459111-2907-8-git-send-email-chunfeng.yun@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 31 Jul 2021 00:24:31 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8XCeWbiHziB9=2EdUFmOg1m6eOi1qTN1QppqRKaS07xA@mail.gmail.com>
Message-ID: <CAAOTY_8XCeWbiHziB9=2EdUFmOg1m6eOi1qTN1QppqRKaS07xA@mail.gmail.com>
Subject: Re: [PATCH 8/9] phy: phy-mtk-mipi-dsi: remove dummy assignment of
 error number
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
> Return the error number directly without assignment

Acked-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  drivers/phy/mediatek/phy-mtk-mipi-dsi.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi.c b/drivers/phy/mediat=
ek/phy-mtk-mipi-dsi.c
> index 01cf31633019..61c942fbf4a1 100644
> --- a/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
> +++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
> @@ -203,10 +203,8 @@ static int mtk_mipi_tx_probe(struct platform_device =
*pdev)
>         phy_set_drvdata(phy, mipi_tx);
>
>         phy_provider =3D devm_of_phy_provider_register(dev, of_phy_simple=
_xlate);
> -       if (IS_ERR(phy_provider)) {
> -               ret =3D PTR_ERR(phy_provider);
> -               return ret;
> -       }
> +       if (IS_ERR(phy_provider))
> +               return PTR_ERR(phy_provider);
>
>         mipi_tx->dev =3D dev;
>
> --
> 2.18.0
>
