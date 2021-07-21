Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04FA3D0E3E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 13:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238080AbhGULP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 07:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239769AbhGULGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 07:06:35 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05ED2C061787
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 04:44:34 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id b12so2023771pfv.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 04:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1e5owWDxMUbIBJfKFii6zS+/7R0v2+enWtZrIJ8w5gE=;
        b=oOMBLoLdDZUmJwKPMItYIv30/3dAnF/IjyteNCMVTgAl7Vs00+i0xC49Mg4KcYCRQH
         XDCA6ws6TiC9cYmziRd03GZESG5nW9Bi3IhSWJlzkL5ZjyknmAtZS/ryG5jgI5P56sJ0
         IAFknBfWisrvP3CVkp8BV9frTdmNt/tX2auDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1e5owWDxMUbIBJfKFii6zS+/7R0v2+enWtZrIJ8w5gE=;
        b=Q8vaeZ9bAfIgz5GstMOC8VWWC2riHWvXeGk8yPiKf6j2VVQFTNvmSKCkK6Qb80LvKu
         fS06b6qLfYzbm+9r/e8mxYauwZRuMJduUs9kVHdbeOuy+wCvW61Is3vpKJBfkawQP2WX
         HqbNBk+A10UUgikOdIKinyiy3CJAkF2jetN7eSbkqz2OP9zhSkciwBTzYVFmkW+ft5AW
         zjw+iXAyI+3IXx3AW7W9K6DrPhwGjuvI8xyVbgnj8+I3Hp7tCn//yynP93I8fVRJ8che
         xpYdfMtOCVcs9mhooJaycO6A90fjOgbZkcPnasDdi1tznoUgNnzaEMj8kuOYxhR0UXWl
         qWSA==
X-Gm-Message-State: AOAM531VboQa6hdfqZ+GcxznCpRFgIazupyFhVzNZWaFPh5zUrH7nQMW
        EulvLdFjhNk+7hqOqkoTjoHYpg9GL3N7hyvmwxciuQ==
X-Google-Smtp-Source: ABdhPJzDuuXuFsg+sEvfAF7SzXJ4MRUYLPDA9Vj5ACSar4H9upnFwBC/H+/Y7qoK7WoFI+0/zLdVgr5TPKu1KmiiWMI=
X-Received: by 2002:a63:3601:: with SMTP id d1mr6530858pga.299.1626867873570;
 Wed, 21 Jul 2021 04:44:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210715121209.31024-1-yong.wu@mediatek.com> <20210715121209.31024-9-yong.wu@mediatek.com>
In-Reply-To: <20210715121209.31024-9-yong.wu@mediatek.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Wed, 21 Jul 2021 19:44:22 +0800
Message-ID: <CAATdQgAnj2B=js44O8LQ6ALqEr9r_UhiwMnLX+wqxJkQ5Lw=Ew@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] memory: mtk-smi: Use devm_platform_ioremap_resource
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

On Thu, Jul 15, 2021 at 8:24 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> No functional change. Simplify probing code.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Ikjoon Jang <ikjn@chromium.org>

> ---
>  drivers/memory/mtk-smi.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index ee49bb50f5f5..e5a34b3952a0 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -317,7 +317,6 @@ static int mtk_smi_dts_clk_init(struct device *dev, struct mtk_smi *smi,
>  static int mtk_smi_larb_probe(struct platform_device *pdev)
>  {
>         struct mtk_smi_larb *larb;
> -       struct resource *res;
>         struct device *dev = &pdev->dev;
>         int ret;
>
> @@ -326,8 +325,7 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
>                 return -ENOMEM;
>
>         larb->larb_gen = of_device_get_match_data(dev);
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       larb->base = devm_ioremap_resource(dev, res);
> +       larb->base = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(larb->base))
>                 return PTR_ERR(larb->base);
>
> @@ -447,7 +445,6 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
>         struct mtk_smi *common;
> -       struct resource *res;
>         int ret;
>
>         common = devm_kzalloc(dev, sizeof(*common), GFP_KERNEL);
> @@ -468,8 +465,7 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
>          * base.
>          */
>         if (common->plat->type == MTK_SMI_GEN1) {
> -               res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -               common->smi_ao_base = devm_ioremap_resource(dev, res);
> +               common->smi_ao_base = devm_platform_ioremap_resource(pdev, 0);
>                 if (IS_ERR(common->smi_ao_base))
>                         return PTR_ERR(common->smi_ao_base);
>
> @@ -481,8 +477,7 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
>                 if (ret)
>                         return ret;
>         } else {
> -               res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -               common->base = devm_ioremap_resource(dev, res);
> +               common->base = devm_platform_ioremap_resource(pdev, 0);
>                 if (IS_ERR(common->base))
>                         return PTR_ERR(common->base);
>         }
> --
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
