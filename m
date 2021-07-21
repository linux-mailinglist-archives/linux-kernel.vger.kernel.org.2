Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF9E3D0CEC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 13:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239010AbhGUKJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 06:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239664AbhGUKGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 06:06:15 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858DEC0617A9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 03:45:35 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id me13-20020a17090b17cdb0290173bac8b9c9so3748707pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 03:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3lABi16nL4MQbRpp+EfVh/1lUieQouz0Mt1Eq3+g03o=;
        b=e1Kye+SB7N4WedVaQMXh+r+XKa4tTEZMwHQLriWWLC4r29k6eiqa6TbO3ygi1pNDw/
         KPESXu1ee6k4rudQCQ4a16OyvOBhEPMAWpvD1pwyncIeyJx+5+Q2MIyDjKLI2HAJ0DR2
         OTMAk4Hr+4D+jMX8+ll/bSXIJHTyOuqNsX2Q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3lABi16nL4MQbRpp+EfVh/1lUieQouz0Mt1Eq3+g03o=;
        b=ZJu7X2GUzLCw0KkeleRBlhwI5zKf48QYePap6mkeW6YNC6lp6M/Jrnwcm96t/Yn+4I
         QHItV7iKbO4CDPerPvQ5hHJ9Mg2e1s2/Zn5wU55wfI1DZ8iLg4n1kwb4S5beOyTxXeh4
         jQeUI3u6Z974doDimyBbe5rOuP62lmQvzQrlHjCWvbe4NhCeNXqfRghN/cKbXVp/JW7K
         +2Y7bkHdyluN38kh9zwhMTvcqhFHlpKq8mRBAf17EMJVIfSfLsI7TCajmJWd2vAowphF
         nnuCe9aJFwiAsLiYPW3HZyvP7cKqmMmtL5TUDyWabhS5+ZGmkZo+BrnrcWpLenq7n7hM
         UcXQ==
X-Gm-Message-State: AOAM531vHndGN3phrpZ7oymslTSp5DBRgYs2wbOqrz0HVwY/RR6cq+sr
        AtZLsEzYj0iwkwWtUCrubWixq4eKtTdLfdsHZjzNRA==
X-Google-Smtp-Source: ABdhPJwseMcBhtA89/xVOfkSjI8Er/1b+WzAHYlvJAI5MGItY7qPIiQanSoTGq6Tkh3CF9f6U0apmV9yj3pMNUucrsU=
X-Received: by 2002:a17:90a:f3cb:: with SMTP id ha11mr3173568pjb.144.1626864335082;
 Wed, 21 Jul 2021 03:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210715121209.31024-1-yong.wu@mediatek.com> <20210715121209.31024-7-yong.wu@mediatek.com>
In-Reply-To: <20210715121209.31024-7-yong.wu@mediatek.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Wed, 21 Jul 2021 18:45:23 +0800
Message-ID: <CAATdQgCPunSYpxCE4ZfMBtbmyGik-AbxX+yh+F4m9EYDnCMObg@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] memory: mtk-smi: Add error handle for smi_probe
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

On Thu, Jul 15, 2021 at 8:23 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> Add error handle while component_add fail.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Ikjoon Jang <ikjn@chromium.org>

> ---
> It don't have the error handle when v1. it is not a fatal error.
> thus don't add fix tags.
> ---
>  drivers/memory/mtk-smi.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index 6f8e582bace5..e68cbb51dd12 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -330,7 +330,15 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
>
>         pm_runtime_enable(dev);
>         platform_set_drvdata(pdev, larb);
> -       return component_add(dev, &mtk_smi_larb_component_ops);
> +       ret = component_add(dev, &mtk_smi_larb_component_ops);
> +       if (ret)
> +               goto err_pm_disable;
> +       return 0;
> +
> +err_pm_disable:
> +       pm_runtime_disable(dev);
> +       device_link_remove(dev, larb->smi_common_dev);
> +       return ret;
>  }
>
>  static int mtk_smi_larb_remove(struct platform_device *pdev)
> --
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
