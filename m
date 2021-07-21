Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E783D0E38
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 13:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238983AbhGULPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 07:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239643AbhGULFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 07:05:20 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0BBC0613E7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 04:44:07 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d12so2042953pfj.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 04:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4eOE5oXt0Te/GnUqshzOeQhr7DeyqOGjYygIrkfQGGA=;
        b=KdQI6LuD8Wmsu8sCpYBmVNr4uqXouJd6KbQ3iYRLn2UXIAxs+TuEUbZye6F9L7aj1V
         ZAgxxPSOUOm+s48Q3N1vGWUj2UI5ovvKG0zNnKpAZ+Y4nQZHgOrkuO2NxaUrVYYpljXg
         lyBhu/YTGUcqASeyyy69yxEUAvWHEkFO5P9HA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4eOE5oXt0Te/GnUqshzOeQhr7DeyqOGjYygIrkfQGGA=;
        b=TQnupXIE+a/cXRuNC04PA7QlauOZ7t92nNzkWdmlpsa4qgvWjOmFmtL7yIEhFSajWQ
         UTK+kHXX6C09lu9/q98BSpTSAW4+asQ4poaTZrdRvhwIi4t3l4f4wG4T8K4oE/QBONXY
         ReRYJWkj7dqdRvfUfZLBrkIDBLPvw/SN6+xj+oQXachwd0TscxJSR7L3Xkgao2xh8ppp
         R1ivM7l7mpT0h9XQWiao6PSJtcBS4sn2OS3HyTHx+udz2N7HZotac99tTGwxmp+31Vkp
         PnaVArJK1I1XDJcyEikSrwMTKuxSDoRNW4FAojI5oD9YwUExlcyI7XNPFvRBmG1l5RfP
         yFtg==
X-Gm-Message-State: AOAM5312cjwviH9csBpL4JnAeI4bZOmWM0fj94alyhwGYxUCGkHjmF45
        APIGRXukQL0LPvfZEwWwiGSu7nL2HZJaGZMfZvy58A==
X-Google-Smtp-Source: ABdhPJwOBnuO9cyF8OBviJSYN7tjfT+V3IKi0eKLRcwtLf+HGoO48XKeVyIURCRqP1SfZkP8A4tRfzpBVnepdhLBrCI=
X-Received: by 2002:a05:6a00:2407:b029:341:185e:8674 with SMTP id
 z7-20020a056a002407b0290341185e8674mr20738643pfh.42.1626867846555; Wed, 21
 Jul 2021 04:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210715121209.31024-1-yong.wu@mediatek.com> <20210715121209.31024-8-yong.wu@mediatek.com>
In-Reply-To: <20210715121209.31024-8-yong.wu@mediatek.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Wed, 21 Jul 2021 19:43:55 +0800
Message-ID: <CAATdQgBDsPHcuPYd=a+fjjTuqwXdJ-1GuSkj47cH1Ju5geqSLg@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] memory: mtk-smi: Add smi sub common support
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, ming-fan.chen@mediatek.com,
        yi.kuo@mediatek.com, anthony.huang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 8:25 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> In mt8195, there are some larbs connect with the smi-sub-common, then
> connect with smi-common.

Not critical but I suggest to describe what is smi-sub-common.
e.g. "some larbs are not directly connected to smi-common,
they are connected to smi-sub-common which is a bridge(?) interface to..."

>
> Before we create device link between smi-larb with smi-common. If we have
> sub-common, we should use device link the smi-larb and smi-sub-common,
> then use device link between the smi-sub-common with smi-common. This is
> for enabling clock/power automatically.
>
> Move the device link code to a new interface for reusing.
>
> There is no SW extra setting for smi-sub-common.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Ikjoon Jang <ikjn@chromium.org>

> ---
>  drivers/memory/mtk-smi.c | 75 +++++++++++++++++++++++++++-------------
>  1 file changed, 51 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index e68cbb51dd12..ee49bb50f5f5 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -60,7 +60,8 @@
>
>  enum mtk_smi_type {
>         MTK_SMI_GEN1,
> -       MTK_SMI_GEN2
> +       MTK_SMI_GEN2,           /* gen2 smi common */
> +       MTK_SMI_GEN2_SUB_COMM,  /* gen2 smi sub common */
>  };
>
>  #define MTK_SMI_CLK_NR_MAX                     4
> @@ -90,13 +91,14 @@ struct mtk_smi {
>                 void __iomem            *smi_ao_base; /* only for gen1 */
>                 void __iomem            *base;        /* only for gen2 */
>         };
> +       struct device                   *smi_common_dev; /* for sub common */
>         const struct mtk_smi_common_plat *plat;
>  };
>
>  struct mtk_smi_larb { /* larb: local arbiter */
>         struct mtk_smi                  smi;
>         void __iomem                    *base;
> -       struct device                   *smi_common_dev;
> +       struct device                   *smi_common_dev; /* common or sub-common dev */
>         const struct mtk_smi_larb_gen   *larb_gen;
>         int                             larbid;
>         u32                             *mmu;
> @@ -259,6 +261,38 @@ static const struct of_device_id mtk_smi_larb_of_ids[] = {
>         {}
>  };
>
> +static int mtk_smi_device_link_common(struct device *dev, struct device **com_dev)
> +{
> +       struct platform_device *smi_com_pdev;
> +       struct device_node *smi_com_node;
> +       struct device *smi_com_dev;
> +       struct device_link *link;
> +
> +       smi_com_node = of_parse_phandle(dev->of_node, "mediatek,smi", 0);
> +       if (!smi_com_node)
> +               return -EINVAL;
> +
> +       smi_com_pdev = of_find_device_by_node(smi_com_node);
> +       of_node_put(smi_com_node);
> +       if (smi_com_pdev) {
> +               /* smi common is the supplier, Make sure it is ready before */
> +               if (!platform_get_drvdata(smi_com_pdev))
> +                       return -EPROBE_DEFER;
> +               smi_com_dev = &smi_com_pdev->dev;
> +               link = device_link_add(dev, smi_com_dev,
> +                                      DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
> +               if (!link) {
> +                       dev_err(dev, "Unable to link smi-common dev\n");
> +                       return -ENODEV;
> +               }
> +               *com_dev = smi_com_dev;
> +       } else {
> +               dev_err(dev, "Failed to get the smi_common device\n");
> +               return -EINVAL;
> +       }
> +       return 0;
> +}
> +
>  static int mtk_smi_dts_clk_init(struct device *dev, struct mtk_smi *smi,
>                                 unsigned int clk_nr_optional,
>                                 const char * const clk_optional[])
> @@ -285,9 +319,6 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
>         struct mtk_smi_larb *larb;
>         struct resource *res;
>         struct device *dev = &pdev->dev;
> -       struct device_node *smi_node;
> -       struct platform_device *smi_pdev;
> -       struct device_link *link;
>         int ret;
>
>         larb = devm_kzalloc(dev, sizeof(*larb), GFP_KERNEL);
> @@ -307,26 +338,10 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
>                 return ret;
>
>         larb->smi.dev = dev;
> -       smi_node = of_parse_phandle(dev->of_node, "mediatek,smi", 0);
> -       if (!smi_node)
> -               return -EINVAL;
>
> -       smi_pdev = of_find_device_by_node(smi_node);
> -       of_node_put(smi_node);
> -       if (smi_pdev) {
> -               if (!platform_get_drvdata(smi_pdev))
> -                       return -EPROBE_DEFER;
> -               larb->smi_common_dev = &smi_pdev->dev;
> -               link = device_link_add(dev, larb->smi_common_dev,
> -                                      DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
> -               if (!link) {
> -                       dev_err(dev, "Unable to link smi-common dev\n");
> -                       return -ENODEV;
> -               }
> -       } else {
> -               dev_err(dev, "Failed to get the smi_common device\n");
> -               return -EINVAL;
> -       }
> +       ret = mtk_smi_device_link_common(dev, &larb->smi_common_dev);
> +       if (ret < 0)
> +               return ret;
>
>         pm_runtime_enable(dev);
>         platform_set_drvdata(pdev, larb);
> @@ -471,6 +486,14 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
>                 if (IS_ERR(common->base))
>                         return PTR_ERR(common->base);
>         }
> +
> +       /* link its smi-common if this is smi-sub-common */
> +       if (common->plat->type == MTK_SMI_GEN2_SUB_COMM) {
> +               ret = mtk_smi_device_link_common(dev, &common->smi_common_dev);
> +               if (ret < 0)
> +                       return ret;
> +       }
> +
>         pm_runtime_enable(dev);
>         platform_set_drvdata(pdev, common);
>         return 0;
> @@ -478,6 +501,10 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
>
>  static int mtk_smi_common_remove(struct platform_device *pdev)
>  {
> +       struct mtk_smi *common = dev_get_drvdata(&pdev->dev);
> +
> +       if (common->plat->type == MTK_SMI_GEN2_SUB_COMM)
> +               device_link_remove(&pdev->dev, common->smi_common_dev);
>         pm_runtime_disable(&pdev->dev);
>         return 0;
>  }
> --
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
