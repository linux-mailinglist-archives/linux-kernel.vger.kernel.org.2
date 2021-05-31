Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A33396952
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 23:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbhEaViD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 17:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhEaViA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 17:38:00 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0F3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 14:36:19 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id a13so8072696oid.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 14:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aMtcDguE8YDTale07cSMPpefpj+DlHJ0KoYhVMD5L80=;
        b=M0OsHNKzHvX9kahydNMpioIAmig3QZQ41zfG2b3MLBL2wE4hv7Pdd/3WQ96Flu//Tp
         S3VrjLJRnqbSIyrJO11g8c9Xaa4f2rd1nwqjygUGDD1+mb3awXrm6or5RhlITFsxRg6V
         PH2mqGNt40KoKrMgBzfdAAathNHw+G9CtjgAKSPSCx8E/ipevWOhbk2CSv7zOcIN1bAw
         g7LihQUfhAX3tTb3beU/UCltrrMsOm6aXLXxSWcKqah2KvzFF8Bk7kNzhN/rXGHyAqAE
         6g5J5oAyN3XC/tUCO0Ki+wDVC0qLWGjIYMM3+WLyQYG1i6j/tPU84RKUzu4FUUjbX7Hq
         aE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aMtcDguE8YDTale07cSMPpefpj+DlHJ0KoYhVMD5L80=;
        b=TfMUTG+PypsaWXW6hxg1+u/H2u3AVQDPdkREzzd0lDYHcJo2dWk2eZsTbGfmpBKSGQ
         abcSOtb5BnaFokJNXf8uy3ba6O7GxBkD1euwQUTA3nSLqwLRNy3Va2E/3KqW9B6YYtup
         1z+l5M7Kz6GgyuBxjCV58SSfoDxtvU9mMb6Zg1muGipJ0471+dxnLiv2ijAJF0E1t1+d
         59bejFeYwamR3cqBrpXw8kxtpMqL5VX7jpgtijeewFbQZkrYRJeGUrRP0WfVwl4nue+X
         GQAv0nuLy7wPweiVXy721QR269r61orC9DgCuoJ7A6GxCJVOFijV2nIB/jl00X8h2+0U
         twvQ==
X-Gm-Message-State: AOAM533xvS9AxC4yq22GUNp3JuyAMu8rzRJBVn/nPKo6bWE54CwY4EaE
        s4L3bS78JxFXzxoj46QRPoymn9ei0y3sJkIz+xc=
X-Google-Smtp-Source: ABdhPJyoTQpB2iTv+37/sgEJHnO47tYP0raUCEPiRUXGrrgiJZx7g6Di6Q1zvS3z9SJ69+luGSrsExAS0m0Avm4IpqI=
X-Received: by 2002:aca:4b09:: with SMTP id y9mr673633oia.39.1622496979005;
 Mon, 31 May 2021 14:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210531043502.2702645-1-hsinyi@chromium.org> <20210531043502.2702645-2-hsinyi@chromium.org>
In-Reply-To: <20210531043502.2702645-2-hsinyi@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Mon, 31 May 2021 23:36:07 +0200
Message-ID: <CAFqH_53nNca8VG=09djYseJBWWg5j=YFTfPjxJL5w-aTyBmCng@mail.gmail.com>
Subject: Re: [PATCH 2/3] soc: mtk-pm-domains: do not register smi node as syscon
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        chun-jie.chen@mediatek.corp-partner.google.com,
        Yong Wu <yong.wu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

(again without html, sorry for the noise)

Thank you for the patch.

Missatge de Hsin-Yi Wang <hsinyi@chromium.org> del dia dl., 31 de maig
2021 a les 6:35:
>
> Mediatek requires mmsys clocks to be unprepared during suspend,
> otherwise system has chances to hang.
>
> syscon_regmap_lookup_by_phandle_optional() will attach and prepare the
> first clock in smi node, leading to additional prepare to the clock
> which is not balanced with the prepare/unprepare pair in resume/suspend
> callbacks.
>
> If a power domain node requests an smi node and the smi node's first
> clock is an mmsys clock, it will results in an unstabke suspend resume.

Typo s/unstabke/unstable/

I think it would be nice to have a Fixes tag for that patch. So can be
picked for the stable kernel more easily.

>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

I have a nit below but the patch looks good to me. So

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  drivers/soc/mediatek/mtk-pm-domains.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> index 536d8c64b2b4..a9ba71eee4bb 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.c
> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> @@ -296,7 +296,7 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
>  {
>         const struct scpsys_domain_data *domain_data;
>         struct scpsys_domain *pd;
> -       struct device_node *root_node = scpsys->dev->of_node;
> +       struct device_node *root_node = scpsys->dev->of_node, *smi_node;

nit: Personal preference, but I'd prefer to add the smi_node in a new
line, so it's really clear that the only thing you are doing here is
adding a new variable.

>         struct property *prop;
>         const char *clk_name;
>         int i, ret, num_clks;
> @@ -352,9 +352,13 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
>         if (IS_ERR(pd->infracfg))
>                 return ERR_CAST(pd->infracfg);
>
> -       pd->smi = syscon_regmap_lookup_by_phandle_optional(node, "mediatek,smi");
> -       if (IS_ERR(pd->smi))
> -               return ERR_CAST(pd->smi);
> +       smi_node = of_parse_phandle(node, "mediatek,smi", 0);
> +       if (smi_node) {
> +               pd->smi = device_node_to_regmap(smi_node);
> +               of_node_put(smi_node);
> +               if (IS_ERR(pd->smi))
> +                       return ERR_CAST(pd->smi);
> +       }
>
>         num_clks = of_clk_get_parent_count(node);
>         if (num_clks > 0) {
> --
> 2.32.0.rc0.204.g9fa02ecfa5-goog
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
