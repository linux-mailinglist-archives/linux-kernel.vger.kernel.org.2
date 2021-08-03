Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668303DEAD9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 12:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbhHCK1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 06:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235296AbhHCK1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 06:27:33 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1432C06175F;
        Tue,  3 Aug 2021 03:27:22 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id f20-20020a9d6c140000b02904bb9756274cso8322987otq.6;
        Tue, 03 Aug 2021 03:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CD6neHzHPjoDd8dxdauboHpEOxJG+rtfwmy3RnpVYAU=;
        b=uKUH4atrDaR/JLojmmlOzgdhs3uX7Xv1tWVjAphKOQTwBs1kRHG6w6vQ3s2Dy4fEUr
         pbGynpcDWghu7obBLK4CxNguJbd5M12Ru8nwqerBvZwZ0x8QlJMHCR+JiWboOLFCRwEj
         DkCb49Ctv6zeaHbqugStnotGm9JAoouNVa0zrQHDRTS2NZT/YB8Nl4IF2XJY/LxjZtxp
         lxhaopguCHFv0VGbhRXa9GPtb22/fridJfBe/JzlVjIWgqSmoJ1mnvFQBFFpFRvxlfJI
         cP41oz3ynRNhVSuqcOEZG7MQBGu8olId15ykPWeDBKp2EZQvQCbXkpW1yHtV0pUFrz7Q
         ml2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CD6neHzHPjoDd8dxdauboHpEOxJG+rtfwmy3RnpVYAU=;
        b=sHUI6y2umeUO67qO2+0bNGMx11xS9DTX02wbxQrZ0c/83i6O5MPl8AUpfipmuhkx13
         Nr90xsvGlIXIo1/ym/jVToLlYT3ZVxZz6vtP3AyWRt0QhitjDrz7zgokTe5qR1F0l13k
         85kRJw7MixJuFT9zAs0lYObf9CnWnzMz2Ig3dP2KRXcdIEXuCdeTjQsq7nVOVvUPQdec
         xFGoc+m7W7my6VK3QB645CoQdRclo9Flp/DkhYGXhDd+T2cC+TVWbY9CkvUIinNr8j1p
         sjILMSHVED+HuLufjs6J4Y8H+oI3MkAPE62Qhfc3lQRNPb1R8MZbGOCHSkQ9v0Rsdxw0
         ciVw==
X-Gm-Message-State: AOAM533iXjUF/k4+CpDHkrPeBBhH7umMFBl8yiRZsAq+jdF1+4wYL1tT
        xHNf1oVcbLXeWXUPjZtXJKanFAhAq8APMxjN1WM=
X-Google-Smtp-Source: ABdhPJzSf7Z3GXEQbh0IMHTfaFgu9OXz6HWXN6vP8pmf4x9H4XgdAHEeJ9E76OyLEBAAectp3pUCaIqOxX3fnlWsOr4=
X-Received: by 2002:a9d:6490:: with SMTP id g16mr14922669otl.184.1627986441719;
 Tue, 03 Aug 2021 03:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210802121215.703023-1-eizan@chromium.org> <20210802220943.v6.6.Ie4214d2cc73ab276dd7c41d4f63c98e011fb42d4@changeid>
In-Reply-To: <20210802220943.v6.6.Ie4214d2cc73ab276dd7c41d4f63c98e011fb42d4@changeid>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Tue, 3 Aug 2021 12:27:07 +0200
Message-ID: <CAFqH_51Vn1VSbL8BU=J0gpOm9c7zevX2o6qWf=-hFp1tbeN-Aw@mail.gmail.com>
Subject: Re: [PATCH v6 6/9] soc: mediatek: mmsys: instantiate mdp virtual
 device from mmsys
To:     Eizan Miyamoto <eizan@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        devicetree <devicetree@vger.kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eizan,

Thank you for your patch.

Missatge de Eizan Miyamoto <eizan@chromium.org> del dia dl., 2 d=E2=80=99ag=
.
2021 a les 14:14:
>
> A virtual device that is probed by the mtk_mdp_core driver is
> instantiated by the mtk_mmsys driver.
>
> This better reflects the logical organization of the hardware and
> driver: there are a number of hardware blocks that are used by the MDP
> that have no strict hierarchy, and the software driver is responsible
> for driving them properly.
>
> Signed-off-by: Eizan Miyamoto <eizan@chromium.org>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>


> ---
>
> (no changes since v1)
>
>  drivers/soc/mediatek/mtk-mmsys.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-=
mmsys.c
> index 080660ef11bf..e681029fe804 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -97,6 +97,7 @@ static int mtk_mmsys_probe(struct platform_device *pdev=
)
>         struct platform_device *clks;
>         struct platform_device *drm;
>         struct mtk_mmsys *mmsys;
> +       struct platform_device *mdp;
>         int ret;
>
>         mmsys =3D devm_kzalloc(dev, sizeof(*mmsys), GFP_KERNEL);
> @@ -122,10 +123,27 @@ static int mtk_mmsys_probe(struct platform_device *=
pdev)
>                                             PLATFORM_DEVID_AUTO, NULL, 0)=
;
>         if (IS_ERR(drm)) {
>                 platform_device_unregister(clks);
> -               return PTR_ERR(drm);
> +               ret =3D PTR_ERR(drm);
> +               goto err_drm;
> +       }
> +
> +       mdp =3D platform_device_register_data(&pdev->dev, "mtk-mdp",
> +                                           PLATFORM_DEVID_AUTO, NULL, 0)=
;
> +       if (IS_ERR(mdp)) {
> +               ret =3D PTR_ERR(mdp);
> +               dev_err(dev, "Failed to register mdp: %d\n", ret);
> +               goto err_mdp;
>         }
>
>         return 0;
> +
> +err_mdp:
> +       platform_device_unregister(drm);
> +
> +err_drm:
> +       platform_device_unregister(clks);
> +
> +       return ret;
>  }
>
>  static const struct of_device_id of_match_mtk_mmsys[] =3D {
> --
> 2.32.0.554.ge1b32706d8-goog
>
