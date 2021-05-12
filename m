Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73EE37B8FC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 11:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhELJVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 05:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbhELJVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 05:21:37 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25262C061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 02:20:30 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id n40so5185100ioz.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 02:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rw5bi1SAPL1hZNfoVXmGUyA3xV1P1F1OYsNK09HU+a0=;
        b=gqYpnE/lrAatuhlH0xLuX+Ye+d+UxsP6NP14t+2gblbyF65xPmr1mYDmqPtUIsIL8Z
         NGqT2siml8zsT/+GjnMinVr2ht+4InfIycF46nZ481jEqCxSMP3FE3k8hVRTkZ2fA2Ih
         Zpp3c+EoX6nY//nNe6CT2pzwKdFA+JivEzM40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rw5bi1SAPL1hZNfoVXmGUyA3xV1P1F1OYsNK09HU+a0=;
        b=dt7ejOaRGbwf1OloUtXIay5uqlMN/KSgDdWNh3hZnf5OHqKMDLkhVhwR0akExzPou1
         gk4+w/7oRVhDn5ewlYu/cvs7P6uo1qPb/0Ul3BpbPd0Dx3fFCOFMOM/n2VFU+qfg7qlN
         tH8XBkUQP1aPcrS8a/hpFKh8+XQOYRwUq3fItkCzKl/rPIK1zc8cr9RioJDX2/GQb4Qe
         /XYs2WL+4mYblQajl8H4Yi96nzDw74WrTAbqszWeJStvrme1yxkLaoHbNyAlaeBy76Zy
         P9Q6GjH2y+WQZNUKG6KTRgX44Yjn6p2/5Q3qjNLsWkQLh3lo6jOQmVRPHdVJ8vgC6hEv
         49+w==
X-Gm-Message-State: AOAM530cyfM5887/sgS8AUttbytcKnjhSx0b0lbM2cGhlhYtZz7G4WtJ
        vAY1VfOQ5PYMs56fy5G1qWRY8F1iSiNOkQNrTrH/GVXf9A0ARg==
X-Google-Smtp-Source: ABdhPJz4D4taavm63iD2SKLxbMnILL72N/Np1EaOYKVanFw2BuKIj5CwmD6/ksD8F9i292URXw+KTxWjgrqcMFmbXfE=
X-Received: by 2002:a6b:f815:: with SMTP id o21mr24594979ioh.0.1620811229435;
 Wed, 12 May 2021 02:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210410091128.31823-1-yong.wu@mediatek.com> <20210410091128.31823-14-yong.wu@mediatek.com>
In-Reply-To: <20210410091128.31823-14-yong.wu@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 12 May 2021 17:20:03 +0800
Message-ID: <CAJMQK-iTrQRDDm_=LNqSpvXFd431LYRxXMasJHUpN+K8rJ=Qpg@mail.gmail.com>
Subject: Re: [PATCH v5 13/16] media: mtk-vcodec: Get rid of mtk_smi_larb_get/put
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, srv_heupstream@mediatek.com,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, anan.sun@mediatek.com,
        chao.hao@mediatek.com, ming-fan.chen@mediatek.com,
        yi.kuo@mediatek.com, eizan@chromium.org,
        Alexandre Courbot <acourbot@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Irui Wang <irui.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 5:14 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> MediaTek IOMMU has already added the device_link between the consumer
> and smi-larb device. If the vcodec device call the pm_runtime_get_sync,
> the smi-larb's pm_runtime_get_sync also be called automatically.
>
> CC: Tiffany Lin <tiffany.lin@mediatek.com>
> CC: Irui Wang <irui.wang@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Evan Green <evgreen@chromium.org>
> Acked-by: Tiffany Lin <tiffany.lin@mediatek.com>
> ---
>  .../platform/mtk-vcodec/mtk_vcodec_dec_pm.c   | 37 ++-------------
>  .../platform/mtk-vcodec/mtk_vcodec_drv.h      |  3 --
>  .../platform/mtk-vcodec/mtk_vcodec_enc.c      |  1 -
>  .../platform/mtk-vcodec/mtk_vcodec_enc_pm.c   | 46 ++-----------------
>  4 files changed, 10 insertions(+), 77 deletions(-)
>
> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c
> index 32e1858e9f1d..2b3562e47f4f 100644
> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c
> @@ -8,14 +8,12 @@
>  #include <linux/of_address.h>
>  #include <linux/of_platform.h>
>  #include <linux/pm_runtime.h>
> -#include <soc/mediatek/smi.h>
>
>  #include "mtk_vcodec_dec_pm.h"
>  #include "mtk_vcodec_util.h"
>
>  int mtk_vcodec_init_dec_pm(struct mtk_vcodec_dev *mtkdev)
>  {
> -       struct device_node *node;
>         struct platform_device *pdev;
>         struct mtk_vcodec_pm *pm;
>         struct mtk_vcodec_clk *dec_clk;
> @@ -26,18 +24,7 @@ int mtk_vcodec_init_dec_pm(struct mtk_vcodec_dev *mtkdev)
>         pm = &mtkdev->pm;
>         pm->mtkdev = mtkdev;
>         dec_clk = &pm->vdec_clk;
> -       node = of_parse_phandle(pdev->dev.of_node, "mediatek,larb", 0);
> -       if (!node) {
> -               mtk_v4l2_err("of_parse_phandle mediatek,larb fail!");
> -               return -1;
> -       }
>
> -       pdev = of_find_device_by_node(node);
> -       of_node_put(node);
> -       if (WARN_ON(!pdev)) {
> -               return -1;
> -       }
> -       pm->larbvdec = &pdev->dev;
>         pdev = mtkdev->plat_dev;
>         pm->dev = &pdev->dev;
>
> @@ -47,14 +34,11 @@ int mtk_vcodec_init_dec_pm(struct mtk_vcodec_dev *mtkdev)
>                 dec_clk->clk_info = devm_kcalloc(&pdev->dev,
>                         dec_clk->clk_num, sizeof(*clk_info),
>                         GFP_KERNEL);
> -               if (!dec_clk->clk_info) {
> -                       ret = -ENOMEM;
> -                       goto put_device;
> -               }
> +               if (!dec_clk->clk_info)
> +                       return -ENOMEM;
>         } else {
>                 mtk_v4l2_err("Failed to get vdec clock count");
> -               ret = -EINVAL;
> -               goto put_device;
> +               return -EINVAL;
>         }
>
>         for (i = 0; i < dec_clk->clk_num; i++) {
> @@ -63,29 +47,24 @@ int mtk_vcodec_init_dec_pm(struct mtk_vcodec_dev *mtkdev)
>                         "clock-names", i, &clk_info->clk_name);
>                 if (ret) {
>                         mtk_v4l2_err("Failed to get clock name id = %d", i);
> -                       goto put_device;
> +                       return ret;
>                 }
>                 clk_info->vcodec_clk = devm_clk_get(&pdev->dev,
>                         clk_info->clk_name);
>                 if (IS_ERR(clk_info->vcodec_clk)) {
>                         mtk_v4l2_err("devm_clk_get (%d)%s fail", i,
>                                 clk_info->clk_name);
> -                       ret = PTR_ERR(clk_info->vcodec_clk);
> -                       goto put_device;
> +                       return PTR_ERR(clk_info->vcodec_clk);
>                 }
>         }
>
>         pm_runtime_enable(&pdev->dev);
>         return 0;
> -put_device:
> -       put_device(pm->larbvdec);
> -       return ret;
>  }
>
>  void mtk_vcodec_release_dec_pm(struct mtk_vcodec_dev *dev)
>  {
>         pm_runtime_disable(dev->pm.dev);
> -       put_device(dev->pm.larbvdec);
>  }
>
>  void mtk_vcodec_dec_pw_on(struct mtk_vcodec_pm *pm)
> @@ -121,11 +100,6 @@ void mtk_vcodec_dec_clock_on(struct mtk_vcodec_pm *pm)
>                 }
>         }
>
> -       ret = mtk_smi_larb_get(pm->larbvdec);
> -       if (ret) {
> -               mtk_v4l2_err("mtk_smi_larb_get larbvdec fail %d", ret);
> -               goto error;
> -       }
>         return;
>
>  error:
> @@ -138,7 +112,6 @@ void mtk_vcodec_dec_clock_off(struct mtk_vcodec_pm *pm)
>         struct mtk_vcodec_clk *dec_clk = &pm->vdec_clk;
>         int i = 0;
>
> -       mtk_smi_larb_put(pm->larbvdec);
>         for (i = dec_clk->clk_num - 1; i >= 0; i--)
>                 clk_disable_unprepare(dec_clk->clk_info[i].vcodec_clk);
>  }
> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
> index 869d958d2b99..659790398809 100644
> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
> @@ -189,10 +189,7 @@ struct mtk_vcodec_clk {
>   */
>  struct mtk_vcodec_pm {
>         struct mtk_vcodec_clk   vdec_clk;
> -       struct device   *larbvdec;
> -
>         struct mtk_vcodec_clk   venc_clk;
> -       struct device   *larbvenc;
>         struct device   *dev;
>         struct mtk_vcodec_dev   *mtkdev;
>  };
> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
> index 4831052f475d..59816981735b 100644
> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
> @@ -8,7 +8,6 @@
>  #include <media/v4l2-event.h>
>  #include <media/v4l2-mem2mem.h>
>  #include <media/videobuf2-dma-contig.h>
> -#include <soc/mediatek/smi.h>
>  #include <linux/pm_runtime.h>
>
>  #include "mtk_vcodec_drv.h"
> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
> index 1b2e4930ed27..78b99ff882ae 100644
> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
> @@ -8,58 +8,36 @@
>  #include <linux/of_address.h>
>  #include <linux/of_platform.h>
>  #include <linux/pm_runtime.h>
> -#include <soc/mediatek/smi.h>
>
>  #include "mtk_vcodec_enc_pm.h"
>  #include "mtk_vcodec_util.h"
>
>  int mtk_vcodec_init_enc_pm(struct mtk_vcodec_dev *mtkdev)
>  {
> -       struct device_node *node;
>         struct platform_device *pdev;
>         struct mtk_vcodec_pm *pm;
>         struct mtk_vcodec_clk *enc_clk;
>         struct mtk_vcodec_clk_info *clk_info;
>         int ret = 0, i = 0;
> -       struct device *dev;
>
>         pdev = mtkdev->plat_dev;
>         pm = &mtkdev->pm;
>         memset(pm, 0, sizeof(struct mtk_vcodec_pm));
>         pm->mtkdev = mtkdev;
>         pm->dev = &pdev->dev;
> -       dev = &pdev->dev;
>         enc_clk = &pm->venc_clk;
>
> -       node = of_parse_phandle(dev->of_node, "mediatek,larb", 0);
> -       if (!node) {
> -               mtk_v4l2_err("no mediatek,larb found");
> -               return -ENODEV;
> -       }
> -       pdev = of_find_device_by_node(node);
> -       of_node_put(node);
> -       if (!pdev) {
> -               mtk_v4l2_err("no mediatek,larb device found");
> -               return -ENODEV;
> -       }
> -       pm->larbvenc = &pdev->dev;
> -       pdev = mtkdev->plat_dev;
> -       pm->dev = &pdev->dev;
> -
>         enc_clk->clk_num = of_property_count_strings(pdev->dev.of_node,
>                 "clock-names");
>         if (enc_clk->clk_num > 0) {
>                 enc_clk->clk_info = devm_kcalloc(&pdev->dev,
>                         enc_clk->clk_num, sizeof(*clk_info),
>                         GFP_KERNEL);
> -               if (!enc_clk->clk_info) {
> -                       ret = -ENOMEM;
> -                       goto put_larbvenc;
> -               }
> +               if (!enc_clk->clk_info)
> +                       return -ENOMEM;
>         } else {
>                 mtk_v4l2_err("Failed to get venc clock count");
> -               ret = -EINVAL;
> -               goto put_larbvenc;
> +               return -EINVAL;
>         }
>
>         for (i = 0; i < enc_clk->clk_num; i++) {
> @@ -68,29 +46,23 @@ int mtk_vcodec_init_enc_pm(struct mtk_vcodec_dev *mtkdev)
>                         "clock-names", i, &clk_info->clk_name);
>                 if (ret) {
>                         mtk_v4l2_err("venc failed to get clk name %d", i);
> -                       goto put_larbvenc;
> +                       return ret;
>                 }
>                 clk_info->vcodec_clk = devm_clk_get(&pdev->dev,
>                         clk_info->clk_name);
>                 if (IS_ERR(clk_info->vcodec_clk)) {
>                         mtk_v4l2_err("venc devm_clk_get (%d)%s fail", i,
>                                 clk_info->clk_name);
> -                       ret = PTR_ERR(clk_info->vcodec_clk);
> -                       goto put_larbvenc;
> +                       return PTR_ERR(clk_info->vcodec_clk);
>                 }
>         }
>
>         return 0;
> -
> -put_larbvenc:
> -       put_device(pm->larbvenc);
> -       return ret;
>  }
>
>  void mtk_vcodec_release_enc_pm(struct mtk_vcodec_dev *mtkdev)
>  {
>         pm_runtime_disable(mtkdev->pm.dev);
> -       put_device(mtkdev->pm.larbvenc);
>  }
>
>
> @@ -108,13 +80,6 @@ void mtk_vcodec_enc_clock_on(struct mtk_vcodec_pm *pm)
>                 }
>         }
>
> -       ret = mtk_smi_larb_get(pm->larbvenc);
> -       if (ret) {
> -               mtk_v4l2_err("mtk_smi_larb_get larb3 fail %d", ret);
> -               goto clkerr;
> -       }
> -       return;

You can't delete the return; here, otherwise vcodec_clk will be turned
off immediately after they are turned on.

> -
>  clkerr:
>         for (i -= 1; i >= 0; i--)
>                 clk_disable_unprepare(enc_clk->clk_info[i].vcodec_clk);
> @@ -125,7 +90,6 @@ void mtk_vcodec_enc_clock_off(struct mtk_vcodec_pm *pm)
>         struct mtk_vcodec_clk *enc_clk = &pm->venc_clk;
>         int i = 0;
>
> -       mtk_smi_larb_put(pm->larbvenc);
>         for (i = enc_clk->clk_num - 1; i >= 0; i--)
>                 clk_disable_unprepare(enc_clk->clk_info[i].vcodec_clk);
>  }
> --
> 2.18.0
>
