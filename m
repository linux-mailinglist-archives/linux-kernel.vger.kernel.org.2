Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8293E153D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 15:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239339AbhHENCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 09:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbhHENCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 09:02:49 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECD1C061765;
        Thu,  5 Aug 2021 06:02:33 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id s48so8813302ybi.7;
        Thu, 05 Aug 2021 06:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k/SW0jT6wSJBaYFm6P4xqY8rSckS6wlmdeNG9tc9hKU=;
        b=VfGm00bkQAnHpDptX5frFdxF99RwF0aAXCTj4vVJJOk+xPjSa4F8qs3LHx+C6RC5AM
         /0KBAQoXb51c/iHpbzP69sDWMfI9gV7/8s3bUgmKlwplbJuvcGTD7xfVmRQ1D+JLbZAz
         8zAAgsF/tfD6M29p/EMKbsk/cT7cnvU33F6YfuWYeaXvE7rhpMJEKaz2oBqnT2RjrvCm
         ibb8FGKgmKSbCGJLQUZDwndmpWbxDRGDpWkLXMsckNBEh4cj+Aw780G4Oj3Fvm2qtpaE
         flziK2gQ/Zt2MA04YbwVKXU7dBsk9wEnOnBIf0bnSM2kAes612NaXvO8xehztXYtx11/
         hpsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k/SW0jT6wSJBaYFm6P4xqY8rSckS6wlmdeNG9tc9hKU=;
        b=aEtS0SGYX2amIEnS+CLaHr2Fb7+gi1+/rcQ+aLIERyPjzlxt9YqQTJLXknpDej/WqV
         NjqafJVIcVGc5TJ5isPFYUHIrYbKwrX+ogYPdwB3fvfLh5wvYGGTgDFaFhWVOElBCnbg
         IEOHWgm9QI73oH/SU/eGCpbr6uTUQ9VkmSX6EUCDJRENiik6h8KJaPSvX0+ANzIWzxqO
         76SZhIjfr5S02Mrll6yeogFI2TpdXxxHE2eEaNUp2catfnDlXis3idISek5KjuMcbJ7Q
         znRyaaxCtaXjsCLMLOtKK29EyjqmZART5uqYf8Qo0VoKzjuUTrZrXlYEtrshuob7kIHM
         hMHQ==
X-Gm-Message-State: AOAM531Ad+ToFkb/6dnj8If1RvS+J3zwNKKFYec+6zKGYpHOQj0BUDti
        64RMp+e414rRlMxZ3tL8qVl4rMGitwCYuXZUGtU=
X-Google-Smtp-Source: ABdhPJy4wibB5neuDDeiv4z8apqDeZ4SkMstAanwZFLBBi6Aj5M6WO5fWhdWLudssjvtaB4gLLiv8ij9Bx8JVykrNcY=
X-Received: by 2002:a5b:48f:: with SMTP id n15mr5953372ybp.457.1628168552519;
 Thu, 05 Aug 2021 06:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210527082905.1447591-1-jay.xu@rock-chips.com> <20210527082905.1447591-3-jay.xu@rock-chips.com>
In-Reply-To: <20210527082905.1447591-3-jay.xu@rock-chips.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Thu, 5 Aug 2021 09:02:21 -0400
Message-ID: <CAMdYzYpxvEbc-gAk6xEkec-bXaqe7wNM0awRVAPV64v0OVcGSg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] soc: rockchip: io-domain: add rk3568 support
To:     Jianqun Xu <jay.xu@rock-chips.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Lee Jones <lee.jones@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Johan Jonker <jbx6244@gmail.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 4:31 AM Jianqun Xu <jay.xu@rock-chips.com> wrote:
>
> The io-domain registers on RK3568 SoCs have three separated bits to
> enable/disable the 1.8v/2.5v/3.3v power.
>
> This patch make the write to be a operation, allow rk3568 uses a private
> register set function.
>
> Since the 2.5v is not used on RK3568, so the driver only set
> 1.8v [enable] + 3.3v [disable] for 1.8v mode
> 1.8v [disable] + 3.3v [enable] for 3.3v mode

Good Morning,

I see this still hasn't landed, but for what it's worth I've been
running it for months and it seems to work well.
(Also it's necessary for sdio support)

Tested on Quartz64 Model A, Quartz64 Model B.
So - Tested-by: Peter Geis <pgwipeout@gmail.com>

>
> There is not register order requirement which has been cleared by our IC
> team.
>
> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
> ---
> v2:
> - none
>  drivers/soc/rockchip/io-domain.c | 88 +++++++++++++++++++++++++++++---
>  1 file changed, 80 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/soc/rockchip/io-domain.c b/drivers/soc/rockchip/io-domain.c
> index cf8182fc3642..13c446fd33a9 100644
> --- a/drivers/soc/rockchip/io-domain.c
> +++ b/drivers/soc/rockchip/io-domain.c
> @@ -51,13 +51,11 @@
>  #define RK3399_PMUGRF_CON0_VSEL                BIT(8)
>  #define RK3399_PMUGRF_VSEL_SUPPLY_NUM  9
>
> -struct rockchip_iodomain;
> +#define RK3568_PMU_GRF_IO_VSEL0                (0x0140)
> +#define RK3568_PMU_GRF_IO_VSEL1                (0x0144)
> +#define RK3568_PMU_GRF_IO_VSEL2                (0x0148)
>
> -struct rockchip_iodomain_soc_data {
> -       int grf_offset;
> -       const char *supply_names[MAX_SUPPLIES];
> -       void (*init)(struct rockchip_iodomain *iod);
> -};
> +struct rockchip_iodomain;
>
>  struct rockchip_iodomain_supply {
>         struct rockchip_iodomain *iod;
> @@ -66,13 +64,62 @@ struct rockchip_iodomain_supply {
>         int idx;
>  };
>
> +struct rockchip_iodomain_soc_data {
> +       int grf_offset;
> +       const char *supply_names[MAX_SUPPLIES];
> +       void (*init)(struct rockchip_iodomain *iod);
> +       int (*write)(struct rockchip_iodomain_supply *supply, int uV);
> +};
> +
>  struct rockchip_iodomain {
>         struct device *dev;
>         struct regmap *grf;
>         const struct rockchip_iodomain_soc_data *soc_data;
>         struct rockchip_iodomain_supply supplies[MAX_SUPPLIES];
> +       int (*write)(struct rockchip_iodomain_supply *supply, int uV);
>  };
>
> +static int rk3568_iodomain_write(struct rockchip_iodomain_supply *supply, int uV)
> +{
> +       struct rockchip_iodomain *iod = supply->iod;
> +       u32 is_3v3 = uV > MAX_VOLTAGE_1_8;
> +       u32 val0, val1;
> +       int b;
> +
> +       switch (supply->idx) {
> +       case 0: /* pmuio1 */
> +               break;
> +       case 1: /* pmuio2 */
> +               b = supply->idx;
> +               val0 = BIT(16 + b) | (is_3v3 ? 0 : BIT(b));
> +               b = supply->idx + 4;
> +               val1 = BIT(16 + b) | (is_3v3 ? BIT(b) : 0);
> +
> +               regmap_write(iod->grf, RK3568_PMU_GRF_IO_VSEL2, val0);
> +               regmap_write(iod->grf, RK3568_PMU_GRF_IO_VSEL2, val1);
> +               break;
> +       case 3: /* vccio2 */
> +               break;
> +       case 2: /* vccio1 */
> +       case 4: /* vccio3 */
> +       case 5: /* vccio4 */
> +       case 6: /* vccio5 */
> +       case 7: /* vccio6 */
> +       case 8: /* vccio7 */
> +               b = supply->idx - 1;
> +               val0 = BIT(16 + b) | (is_3v3 ? 0 : BIT(b));
> +               val1 = BIT(16 + b) | (is_3v3 ? BIT(b) : 0);
> +
> +               regmap_write(iod->grf, RK3568_PMU_GRF_IO_VSEL0, val0);
> +               regmap_write(iod->grf, RK3568_PMU_GRF_IO_VSEL1, val1);
> +               break;
> +       default:
> +               return -EINVAL;
> +       };
> +
> +       return 0;
> +}
> +
>  static int rockchip_iodomain_write(struct rockchip_iodomain_supply *supply,
>                                    int uV)
>  {
> @@ -136,7 +183,7 @@ static int rockchip_iodomain_notify(struct notifier_block *nb,
>                         return NOTIFY_BAD;
>         }
>
> -       ret = rockchip_iodomain_write(supply, uV);
> +       ret = supply->iod->write(supply, uV);
>         if (ret && event == REGULATOR_EVENT_PRE_VOLTAGE_CHANGE)
>                 return NOTIFY_BAD;
>
> @@ -398,6 +445,22 @@ static const struct rockchip_iodomain_soc_data soc_data_rk3399_pmu = {
>         .init = rk3399_pmu_iodomain_init,
>  };
>
> +static const struct rockchip_iodomain_soc_data soc_data_rk3568_pmu = {
> +       .grf_offset = 0x140,
> +       .supply_names = {
> +               "pmuio1",
> +               "pmuio2",
> +               "vccio1",
> +               "vccio2",
> +               "vccio3",
> +               "vccio4",
> +               "vccio5",
> +               "vccio6",
> +               "vccio7",
> +       },
> +       .write = rk3568_iodomain_write,
> +};
> +
>  static const struct rockchip_iodomain_soc_data soc_data_rv1108 = {
>         .grf_offset = 0x404,
>         .supply_names = {
> @@ -469,6 +532,10 @@ static const struct of_device_id rockchip_iodomain_match[] = {
>                 .compatible = "rockchip,rk3399-pmu-io-voltage-domain",
>                 .data = &soc_data_rk3399_pmu
>         },
> +       {
> +               .compatible = "rockchip,rk3568-pmu-io-voltage-domain",
> +               .data = &soc_data_rk3568_pmu
> +       },
>         {
>                 .compatible = "rockchip,rv1108-io-voltage-domain",
>                 .data = &soc_data_rv1108
> @@ -502,6 +569,11 @@ static int rockchip_iodomain_probe(struct platform_device *pdev)
>         match = of_match_node(rockchip_iodomain_match, np);
>         iod->soc_data = match->data;
>
> +       if (iod->soc_data->write)
> +               iod->write = iod->soc_data->write;
> +       else
> +               iod->write = rockchip_iodomain_write;
> +
>         parent = pdev->dev.parent;
>         if (parent && parent->of_node) {
>                 iod->grf = syscon_node_to_regmap(parent->of_node);
> @@ -562,7 +634,7 @@ static int rockchip_iodomain_probe(struct platform_device *pdev)
>                 supply->reg = reg;
>                 supply->nb.notifier_call = rockchip_iodomain_notify;
>
> -               ret = rockchip_iodomain_write(supply, uV);
> +               ret = iod->write(supply, uV);
>                 if (ret) {
>                         supply->reg = NULL;
>                         goto unreg_notify;
> --
> 2.25.1
>
>
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
