Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450723C205F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 10:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhGIICt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 04:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbhGIICs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 04:02:48 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76825C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 01:00:04 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id h190so11524626iof.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 01:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jxeKKZpH8g0VLt4BIsJvm3Kz5ooojk4SyCSTD8gkf4c=;
        b=gdLMz5E1Qi4ptJm5RLn7ul53NR++fF70gLhRdu6l9pYSqnfiMT2JZivjdfT1BFsNLm
         a3/LfUMo34qNFd2VMjt0S+EQeSYQjSo24rJPa2TV0qLq2B/ZlufcZXrKUrlM1Hbhw7Qb
         2Hwfu5SZgdevJCCG8fdUujt+xoL9jsMmuRTymDZC5b4IdTzKPMYuzsyWjA+zDX/LYYKN
         557cCWvjzvqsqLY9Phy9E8W+p8/GiJFOuGsiFCZP2WcpafQ5QGS4xTi7OXoMjeMgvQa1
         YaFaxwoZM8KNrMaTDEr9qbEKEsQRqLLZF4Bf3dfXj8PeUteneMuzi/DcpDT+N61MEZdJ
         SoFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jxeKKZpH8g0VLt4BIsJvm3Kz5ooojk4SyCSTD8gkf4c=;
        b=kBBneQSdy49TzVv7463O0cgvHsq5s6vJPiVFTsqaEPnK5G/qI/WPCerKwOAenD0+yf
         0Sx0VX4iES4PD++b/MNWsELvOqnVCcfwWnHMtBYo3ZYXYUBnQTlGV+6QL99RevGAqa65
         WHiZEVrKcPtLlvTW+sVdLI0ywqu9WvnI5tli+YTKUlyow1sCcYULO5OL/tiOSlEPhlv3
         cb2VOZw3KiBv36TID2CxmTxKodWQ7M5RQF9nE4UWyNiT4gbKUq8KZX2XYV0LDWLZOZjZ
         hRb8hAVpi3VdycWBXspenptnpOWgXt8AXymwy6HW7TnKOs8i2HDVhVZwAMISsc1qQrC2
         Yzqg==
X-Gm-Message-State: AOAM5314/gFJpWQUrBlDsqCyjIyOGnXhni9AIpwJSnexKU/+EHN7/sF/
        YV5lBNanAQJ5nCyrlPbw+yqeIRJ9Aczmbu91Aolrfg==
X-Google-Smtp-Source: ABdhPJz/iM1VUuaw+LgfAXMYyWsY+UGkYwPTUISY65c4SEG+BA2wd1yXCYcOUPflwPTX6QbLL3qMvB3MPSOQHZigg2s=
X-Received: by 2002:a02:c73b:: with SMTP id h27mr24131704jao.126.1625817603524;
 Fri, 09 Jul 2021 01:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210707062157.21176-1-yunfei.dong@mediatek.com> <20210707062157.21176-7-yunfei.dong@mediatek.com>
In-Reply-To: <20210707062157.21176-7-yunfei.dong@mediatek.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 9 Jul 2021 15:59:52 +0800
Message-ID: <CA+Px+wWRE0DR15GgorZnoN1xdAqoau94gkoF7-x7h2hd21ZGXg@mail.gmail.com>
Subject: Re: [PATCH v1, 06/14] media: mtk-vcodec: Add irq interface for core hardware
To:     Yunfei Dong <Yunfei.Dong@mediatek.com>
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Irui Wang <irui.wang@mediatek.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 7, 2021 at 2:22 PM Yunfei Dong <yunfei.dong@mediatek.com> wrote:
> +static int mtk_vcodec_get_hw_count(struct mtk_vcodec_dev *dev)
> +{
> +       if (dev->vdec_pdata->hw_arch == MTK_VDEC_PURE_SINGLE_CORE)
> +               return 1;
> +       else if (dev->vdec_pdata->hw_arch == MTK_VDEC_LAT_SINGLE_CORE)
> +               return 2;
> +       else
> +               return 0;
> +}
Use a switch .. case .. would be easier to read.

Would it be better to use some macro or enums for the magic numbers?

> @@ -113,8 +114,7 @@ static int mtk_vdec_comp_init_irq(struct mtk_vdec_comp_dev *dev)
>         }
>
>         ret = devm_request_irq(&pdev->dev, dev->dec_irq,
> -                               mtk_vdec_comp_irq_handler,
> -                               0, pdev->name, dev);
> +                               mtk_vdec_comp_irq_handler, 0, pdev->name, dev);
The change is irrelevant to this patch.

> @@ -154,8 +154,10 @@ static int mtk_vdec_comp_probe(struct platform_device *pdev)
>                 dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(34));
>
>         ret = mtk_vdec_comp_init_irq(dev);
> -       if (ret)
> +       if (ret) {
> +               dev_err(&pdev->dev, "Failed to register irq handler.\n");
>                 goto err;
> +       }
The change shouldn't be in this patch.  Instead, another patch that
adds the mtk_vdec_comp_init_irq() invocation.

> +int mtk_vcodec_wait_for_comp_done_ctx(struct mtk_vcodec_ctx  *ctx,
Remove the extra space before "*ctx".
