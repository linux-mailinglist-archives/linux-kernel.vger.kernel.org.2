Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A88369730
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 18:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhDWQhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 12:37:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229957AbhDWQhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 12:37:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4448D6147D;
        Fri, 23 Apr 2021 16:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619195828;
        bh=9IS9zneuy8LMByWB8zTbcL7UU0JhQG+Ou0Dnf6+9DWI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mVgcggccvzb5Q58UbDiH1LkySMqv79Q0ezFdDHa9YV7pgIsYnxGZqfsUJcRJc6QZV
         ZYSvR6/2IFozhh+DXQhOUmILYWpfvzt4R8iyF0yZhyhulaNj6dFjiKsV8Ndd/qXLmj
         GW/zvOnb7aOdEj2ES9uE7ITO4X3CmF8RvhaVMgBShq8F4kFHln8tWv861rOgmlvt4Z
         D2Oi1UzAr1GrTcH3dR3MSQg43Qcm6PFPXoFkffi3cT9tsvVu3W36tckpvHlMHjL4se
         QV5iCqII5/U1Z/OH7pqiU7b4YNdhJm5Grt1Znz4Y1xKyi4U3GYj+xibZ95aulFox9+
         oJ9bLrvt7by5g==
Received: by mail-ej1-f41.google.com with SMTP id w3so74818008ejc.4;
        Fri, 23 Apr 2021 09:37:08 -0700 (PDT)
X-Gm-Message-State: AOAM530O961q6oIfPZzBTExEFkX1oJWLZ3GFZBTfSUHxM9kj5+tKTM+n
        ZtxxACI49NjnNZohBCZ/fkay5cd8Wgl8SHVStQ==
X-Google-Smtp-Source: ABdhPJyNr2Rj271SQjBJ1jzoPOY6Dqp88cO1kkQkphXe731CRxVMAIBAK4M/UFgprXi5ElqtV9WjSX3y7vxRK5ErxHg=
X-Received: by 2002:a17:906:2c4a:: with SMTP id f10mr5235234ejh.63.1619195826695;
 Fri, 23 Apr 2021 09:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210420132614.150242-1-jitao.shi@mediatek.com> <20210420132614.150242-3-jitao.shi@mediatek.com>
In-Reply-To: <20210420132614.150242-3-jitao.shi@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 24 Apr 2021 00:36:55 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-SKcX+4U5hKOgRaip-vk+ofEWe_g4VNUxFjN7LCprq1w@mail.gmail.com>
Message-ID: <CAAOTY_-SKcX+4U5hKOgRaip-vk+ofEWe_g4VNUxFjN7LCprq1w@mail.gmail.com>
Subject: Re: [PATCH 3/4] drm/mediatek: fine tune the dsi panel's power sequence
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        huijuan.xie@mediatek.com, stonea168@163.com,
        Cawa Cheng <cawa.cheng@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, yingjoe.chen@mediatek.com,
        eddie.huang@mediatek.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jitao:

Jitao Shi <jitao.shi@mediatek.com> =E6=96=BC 2021=E5=B9=B44=E6=9C=8820=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=889:26=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Add the drm_panel_prepare_power and drm_panel_unprepare_power control.
> Turn on panel power(drm_panel_prepare_power) and control before dsi
> enable. And then dsi enable, send dcs cmd in drm_panel_prepare, last
> turn on backlight.

Please describe WHY do you need this patch? Fix any bug?

>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index a1ff152ef468..455fe582c6b5 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -615,10 +615,13 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
>         dsi->data_rate =3D DIV_ROUND_UP_ULL(dsi->vm.pixelclock * bit_per_=
pixel,
>                                           dsi->lanes);
>
> +       if (panel_bridge_prepare_power(dsi->next_bridge))

ret =3D panel_bridge_prepare_power(dsi->next_bridge);
if (ret)

> +               DRM_INFO("can't prepare power the panel\n");

I think you should goto err_refcount;

> +
>         ret =3D clk_set_rate(dsi->hs_clk, dsi->data_rate);
>         if (ret < 0) {
>                 dev_err(dev, "Failed to set data rate: %d\n", ret);
> -               goto err_refcount;
> +               goto err_prepare_power;
>         }
>
>         phy_power_on(dsi->phy);
> @@ -661,7 +664,9 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
>         clk_disable_unprepare(dsi->engine_clk);
>  err_phy_power_off:
>         phy_power_off(dsi->phy);
> -err_refcount:
> +err_prepare_power:
> +       if (panel_bridge_unprepare_power(dsi->next_bridge))

ret =3D panel_bridge_unprepare_power(dsi->next_bridge);

> +               DRM_INFO("Can't unprepare power the panel\n");
>         dsi->refcount--;
>         return ret;
>  }
> @@ -694,6 +699,9 @@ static void mtk_dsi_poweroff(struct mtk_dsi *dsi)
>         clk_disable_unprepare(dsi->digital_clk);
>
>         phy_power_off(dsi->phy);
> +
> +       if (panel_bridge_unprepare_power(dsi->next_bridge))

ret =3D panel_bridge_unprepare_power(dsi->next_bridge);

> +               DRM_INFO("Can't unprepare power the panel\n");
>  }
>
>  static void mtk_output_dsi_enable(struct mtk_dsi *dsi)
> --
> 2.25.1
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
