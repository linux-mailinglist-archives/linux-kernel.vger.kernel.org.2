Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495403F5916
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 09:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbhHXHgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 03:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbhHXHgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 03:36:15 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5705C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 00:35:31 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id a13so25118441iol.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 00:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kdn/xtZAvZYiwKwxxhtoDSWZxutSGdv9Zf0EjwepvWk=;
        b=dFmqKGM4M8xwkez/7hO/m5icTM2376t5o0aNOCOsIxs5i4hiT5sr79kQdXWQq4TEDQ
         J/MeqGYzCjKUF5OToXwp6ZB4LNLWm37WAs1DA2MsvaACyMGlWLQz+RR81Uv9YdjMjoG2
         JqhbsZ+4S6XyrncPUOCD08O7+s+aOQbEB5RHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kdn/xtZAvZYiwKwxxhtoDSWZxutSGdv9Zf0EjwepvWk=;
        b=DKESHth+7rbqSI0/gT5GiEKm8RSAdKAgfHxXwJ5o9aIC6QDKhl8TrZMSHc+Fj3PqaD
         uO2abq4P2lGUcKMkrs9IBreX8jT5PrBZYa0s9/5G2AnKQSH5vNoC4MLcqg8ngrsu8qUb
         I3NMcjp98qrYwhdFKKBoyDaN43JzAHmaRJlpCKYL79MOSBLVwdzKDL2tTIU4kgIw13AR
         T621Hyfii+Fpcu220ty4Ucpe6PUv5l7frjs6PSnDwrwPs8ee1CNIMtk10BgWfak2YYpe
         0oSMGqXfufNP17IH+fHmaOiSgBo081JtcGpkNNyhVqUo0P/1P//Rln3dlpr9ticvtHqA
         Qcgw==
X-Gm-Message-State: AOAM53296A4qqukhHLcT/xNMdGPj8yjc2NYvLpeOPqP6Ikl8kXQT9NIS
        Phodbbjli1UlmZVUKZHQV0O4LSDv4sSSHYvyCvD4fg==
X-Google-Smtp-Source: ABdhPJzCaKQQqFiKu2GYGl51DjDrCHWW0khxqU+TJuIKD2Qiaa6IC9r0Xva1qe+ermS6tmqpaGovvcP+MP7vZ5pGN64=
X-Received: by 2002:a6b:6319:: with SMTP id p25mr30729776iog.100.1629790531099;
 Tue, 24 Aug 2021 00:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210813065324.29220-1-yong.wu@mediatek.com> <20210813065324.29220-17-yong.wu@mediatek.com>
In-Reply-To: <20210813065324.29220-17-yong.wu@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 24 Aug 2021 15:35:05 +0800
Message-ID: <CAJMQK-ir-wLy4OHkWEWZf=CZcURMhRvHnOjBLWXaezhukJh2JA@mail.gmail.com>
Subject: Re: [PATCH v2 16/29] iommu/mediatek: Adjust device link when it is sub-common
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        Tomasz Figa <tfiga@chromium.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, srv_heupstream@mediatek.com,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        chao.hao@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 3:03 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> For MM IOMMU, We always add device link between smi-common and IOMMU HW.
> In mt8195, we add smi-sub-common. Thus, if the node is sub-common, we still
> need find again to get smi-common, then do device link.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index a4479916ad33..a72241724adb 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -845,6 +845,17 @@ static int mtk_iommu_mm_dts_parse(struct device *dev,
>         if (!smicomm_node)
>                 return -EINVAL;
>
> +       /* Find smi-common again if this is smi-sub-common */
> +       if (of_property_read_bool(smicomm_node, "mediatek,smi_sub_common")) {
> +               of_node_put(smicomm_node); /* put the sub common */
> +
> +               smicomm_node = of_parse_phandle(smicomm_node, "mediatek,smi", 0);

This only checks 1 level here, and does not check if the mediatek,smi
of a sub-common node is not another sub-common node.
So maybe add a check that the updated node here doesn't have
mediatek,smi_sub_common property.

> +               if (!smicomm_node) {
> +                       dev_err(dev, "sub-comm has no common.\n");
> +                       return -EINVAL;
> +               }
> +       }
> +
>         plarbdev = of_find_device_by_node(smicomm_node);
>         of_node_put(smicomm_node);
>         data->smicomm_dev = &plarbdev->dev;
> --
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
