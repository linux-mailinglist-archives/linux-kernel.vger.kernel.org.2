Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C53396955
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 23:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhEaVkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 17:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbhEaVkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 17:40:16 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FC6C061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 14:38:36 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso12254097otu.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 14:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ojuZOBLmhzSo//gYE9XYKfbNnXjNOZfB6L6acFXXDtI=;
        b=ehmT2U5qCUbzR760Ghnnoa2rUBLdZW5RPTKyMGIRh51+D89EqMHTXUiG7iCT38WqdJ
         8Pwi3lhHehtIDM7b+LnnEgZiMMdvKmu+6ARCx7zmBJ3nnIBrcZ5edU/um2Isg41otBfu
         4O4BaJR6oP3WlamHS2pJs3vWUqpNTjkEVH4911dYn/4IaFUJm1v8+zMQ9Fqq/lGzBm2J
         XWcE1TxwnF+u68j+UYGvDIvFaNNb1uEYQVvkqtF8k3w4ld+0T5KsZyusGe6gKi66EJDH
         SsL68mTpAaHO5CxVw+hdTdr3Ak3Y4yiGoGjoyPqWfy3HjyWSsj7wfRvxv7HYC98MSfTf
         dNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ojuZOBLmhzSo//gYE9XYKfbNnXjNOZfB6L6acFXXDtI=;
        b=OxYAGnOzVsR8flp1OehDWqdR2r51+Mcusmc58KD58Co/mgbITnMKPzPHhmyKmw9h22
         gx997zklrOTF6npMiKQtFbgjrddy/77mX0f3XKXpcl3HN/6bikmHnEi1vW+8Tjdt2xyn
         ihTI1Z1iZoDYQWeHa0gPYAQaAhat7KKYdmW2yC7gbp9LoKEp7JETEjx4Sxm5TdfG/Xm9
         vDTUonY9IXegBQBAz8IqUgDY4RBNTvNEWIgyFIfncJIpBZEjaEJi+l+6+BsjKr8+Tu4K
         KIIJb8SPjtwvAcHFlQ6BMD10Sw8DdRx5hA3fkZLSqWEd3ElFuFofwruHk0s3LOmiyDJc
         s9kg==
X-Gm-Message-State: AOAM531i1WQLqspnHQ1gBHcyw2sXIfqKcBXFbfArLnWJEF46QD0WHIaC
        4BmcGeK++siY+NzT/EplwqdLOFcxnzfYHBrmRAU=
X-Google-Smtp-Source: ABdhPJwPe57FNHz5K6ZC+pA2mUTdebCSdzaroJTS7Fkr2Z+OudnnGaGDOy65ptw9Up+ut7Mi+xpiftKensAcefH7jIM=
X-Received: by 2002:a9d:27a4:: with SMTP id c33mr17606539otb.281.1622497115732;
 Mon, 31 May 2021 14:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210531043502.2702645-1-hsinyi@chromium.org>
In-Reply-To: <20210531043502.2702645-1-hsinyi@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Mon, 31 May 2021 23:38:23 +0200
Message-ID: <CAFqH_50qTKnKGeKUGYs_TzqWzmMGqpeKgGVmhYWjC90Nn_nKUw@mail.gmail.com>
Subject: Re: [PATCH 1/3] soc: mtk-pm-domains: Fix the clock prepared issue
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

Thank you for the patch.

Missatge de Hsin-Yi Wang <hsinyi@chromium.org> del dia dl., 31 de maig
2021 a les 6:35:
>
> From: Weiyi Lu <weiyi.lu@mediatek.com>
>
> In this new power domain driver, when adding one power domain
> it will prepare the depenedent clocks at the same.

Typo: s/depenedent/dependent/

> So we only do clk_bulk_enable/disable control during power ON/OFF.
> When system suspend, the pm runtime framework will forcely power off
> power domains. However, the dependent clocks are disabled but kept
> preapred.

Typo: s/preapred/prepared

>
> In MediaTek clock drivers, PLL would be turned ON when we do
> clk_bulk_prepare control.
>
> Clock hierarchy:
> PLL -->
>        DIV_CK -->
>                  CLK_MUX
>                  (may be dependent clocks)
>                          -->
>                              SUBSYS_CG
>                              (may be dependent clocks)
>
> It will lead some unexpected clock states during system suspend.
> This patch will fix by doing prepare_enable/disable_unprepare on
> dependent clocks at the same time while we are going to power on/off
> any power domain.
>

I think it would be nice to have a Fixes tag here, so this can be
backported more easily.

> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  drivers/soc/mediatek/mtk-pm-domains.c | 31 +++++++--------------------
>  1 file changed, 8 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> index 0af00efa0ef8..536d8c64b2b4 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.c
> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> @@ -211,7 +211,7 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>         if (ret)
>                 return ret;
>
> -       ret = clk_bulk_enable(pd->num_clks, pd->clks);
> +       ret = clk_bulk_prepare_enable(pd->num_clks, pd->clks);
>         if (ret)
>                 goto err_reg;
>
> @@ -229,7 +229,7 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>         regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_ISO_BIT);
>         regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
>
> -       ret = clk_bulk_enable(pd->num_subsys_clks, pd->subsys_clks);
> +       ret = clk_bulk_prepare_enable(pd->num_subsys_clks, pd->subsys_clks);
>         if (ret)
>                 goto err_pwr_ack;
>
> @@ -246,9 +246,9 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>  err_disable_sram:
>         scpsys_sram_disable(pd);
>  err_disable_subsys_clks:
> -       clk_bulk_disable(pd->num_subsys_clks, pd->subsys_clks);
> +       clk_bulk_disable_unprepare(pd->num_subsys_clks, pd->subsys_clks);
>  err_pwr_ack:
> -       clk_bulk_disable(pd->num_clks, pd->clks);
> +       clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
>  err_reg:
>         scpsys_regulator_disable(pd->supply);
>         return ret;
> @@ -269,7 +269,7 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>         if (ret < 0)
>                 return ret;
>
> -       clk_bulk_disable(pd->num_subsys_clks, pd->subsys_clks);
> +       clk_bulk_disable_unprepare(pd->num_subsys_clks, pd->subsys_clks);
>
>         /* subsys power off */
>         regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
> @@ -284,7 +284,7 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>         if (ret < 0)
>                 return ret;
>
> -       clk_bulk_disable(pd->num_clks, pd->clks);
> +       clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
>
>         scpsys_regulator_disable(pd->supply);
>
> @@ -405,14 +405,6 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
>                 pd->subsys_clks[i].clk = clk;
>         }
>
> -       ret = clk_bulk_prepare(pd->num_clks, pd->clks);
> -       if (ret)
> -               goto err_put_subsys_clocks;
> -
> -       ret = clk_bulk_prepare(pd->num_subsys_clks, pd->subsys_clks);
> -       if (ret)
> -               goto err_unprepare_clocks;
> -
>         /*
>          * Initially turn on all domains to make the domains usable
>          * with !CONFIG_PM and to get the hardware in sync with the
> @@ -427,7 +419,7 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
>                 ret = scpsys_power_on(&pd->genpd);
>                 if (ret < 0) {
>                         dev_err(scpsys->dev, "%pOF: failed to power on domain: %d\n", node, ret);
> -                       goto err_unprepare_clocks;
> +                       goto err_put_subsys_clocks;
>                 }
>         }
>
> @@ -435,7 +427,7 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
>                 ret = -EINVAL;
>                 dev_err(scpsys->dev,
>                         "power domain with id %d already exists, check your device-tree\n", id);
> -               goto err_unprepare_subsys_clocks;
> +               goto err_put_subsys_clocks;
>         }
>
>         if (!pd->data->name)
> @@ -455,10 +447,6 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
>
>         return scpsys->pd_data.domains[id];
>
> -err_unprepare_subsys_clocks:
> -       clk_bulk_unprepare(pd->num_subsys_clks, pd->subsys_clks);
> -err_unprepare_clocks:
> -       clk_bulk_unprepare(pd->num_clks, pd->clks);
>  err_put_subsys_clocks:
>         clk_bulk_put(pd->num_subsys_clks, pd->subsys_clks);
>  err_put_clocks:
> @@ -537,10 +525,7 @@ static void scpsys_remove_one_domain(struct scpsys_domain *pd)
>                         "failed to remove domain '%s' : %d - state may be inconsistent\n",
>                         pd->genpd.name, ret);
>
> -       clk_bulk_unprepare(pd->num_clks, pd->clks);
>         clk_bulk_put(pd->num_clks, pd->clks);
> -
> -       clk_bulk_unprepare(pd->num_subsys_clks, pd->subsys_clks);
>         clk_bulk_put(pd->num_subsys_clks, pd->subsys_clks);
>  }
>
> --
> 2.32.0.rc0.204.g9fa02ecfa5-goog
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
