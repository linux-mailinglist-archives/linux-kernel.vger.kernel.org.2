Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F45B3E168A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 16:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241891AbhHEOKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 10:10:39 -0400
Received: from gloria.sntech.de ([185.11.138.130]:56452 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237597AbhHEOKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 10:10:38 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mBe4f-0007Cv-Qb; Thu, 05 Aug 2021 16:10:17 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Jianqun Xu <jay.xu@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Johan Jonker <jbx6244@gmail.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] soc: rockchip: io-domain: add rk3568 support
Date:   Thu, 05 Aug 2021 16:10:17 +0200
Message-ID: <2984191.q0ZmV6gNhb@diego>
In-Reply-To: <CAMdYzYpxvEbc-gAk6xEkec-bXaqe7wNM0awRVAPV64v0OVcGSg@mail.gmail.com>
References: <20210527082905.1447591-1-jay.xu@rock-chips.com> <20210527082905.1447591-3-jay.xu@rock-chips.com> <CAMdYzYpxvEbc-gAk6xEkec-bXaqe7wNM0awRVAPV64v0OVcGSg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 5. August 2021, 15:02:21 CEST schrieb Peter Geis:
> On Thu, May 27, 2021 at 4:31 AM Jianqun Xu <jay.xu@rock-chips.com> wrote:
> >
> > The io-domain registers on RK3568 SoCs have three separated bits to
> > enable/disable the 1.8v/2.5v/3.3v power.
> >
> > This patch make the write to be a operation, allow rk3568 uses a private
> > register set function.
> >
> > Since the 2.5v is not used on RK3568, so the driver only set
> > 1.8v [enable] + 3.3v [disable] for 1.8v mode
> > 1.8v [disable] + 3.3v [enable] for 3.3v mode
> 
> Good Morning,
> 
> I see this still hasn't landed, but for what it's worth I've been
> running it for months and it seems to work well.
> (Also it's necessary for sdio support)
> 
> Tested on Quartz64 Model A, Quartz64 Model B.
> So - Tested-by: Peter Geis <pgwipeout@gmail.com>

Just for people reading along, Michael has picked this up and adapted
the binding addition to the already landed yaml conversion, see

https://lore.kernel.org/r/20210805120107.27007-1-michael.riesch@wolfvision.net


Heiko

> 
> >
> > There is not register order requirement which has been cleared by our IC
> > team.
> >
> > Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
> > ---
> > v2:
> > - none
> >  drivers/soc/rockchip/io-domain.c | 88 +++++++++++++++++++++++++++++---
> >  1 file changed, 80 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/soc/rockchip/io-domain.c b/drivers/soc/rockchip/io-domain.c
> > index cf8182fc3642..13c446fd33a9 100644
> > --- a/drivers/soc/rockchip/io-domain.c
> > +++ b/drivers/soc/rockchip/io-domain.c
> > @@ -51,13 +51,11 @@
> >  #define RK3399_PMUGRF_CON0_VSEL                BIT(8)
> >  #define RK3399_PMUGRF_VSEL_SUPPLY_NUM  9
> >
> > -struct rockchip_iodomain;
> > +#define RK3568_PMU_GRF_IO_VSEL0                (0x0140)
> > +#define RK3568_PMU_GRF_IO_VSEL1                (0x0144)
> > +#define RK3568_PMU_GRF_IO_VSEL2                (0x0148)
> >
> > -struct rockchip_iodomain_soc_data {
> > -       int grf_offset;
> > -       const char *supply_names[MAX_SUPPLIES];
> > -       void (*init)(struct rockchip_iodomain *iod);
> > -};
> > +struct rockchip_iodomain;
> >
> >  struct rockchip_iodomain_supply {
> >         struct rockchip_iodomain *iod;
> > @@ -66,13 +64,62 @@ struct rockchip_iodomain_supply {
> >         int idx;
> >  };
> >
> > +struct rockchip_iodomain_soc_data {
> > +       int grf_offset;
> > +       const char *supply_names[MAX_SUPPLIES];
> > +       void (*init)(struct rockchip_iodomain *iod);
> > +       int (*write)(struct rockchip_iodomain_supply *supply, int uV);
> > +};
> > +
> >  struct rockchip_iodomain {
> >         struct device *dev;
> >         struct regmap *grf;
> >         const struct rockchip_iodomain_soc_data *soc_data;
> >         struct rockchip_iodomain_supply supplies[MAX_SUPPLIES];
> > +       int (*write)(struct rockchip_iodomain_supply *supply, int uV);
> >  };
> >
> > +static int rk3568_iodomain_write(struct rockchip_iodomain_supply *supply, int uV)
> > +{
> > +       struct rockchip_iodomain *iod = supply->iod;
> > +       u32 is_3v3 = uV > MAX_VOLTAGE_1_8;
> > +       u32 val0, val1;
> > +       int b;
> > +
> > +       switch (supply->idx) {
> > +       case 0: /* pmuio1 */
> > +               break;
> > +       case 1: /* pmuio2 */
> > +               b = supply->idx;
> > +               val0 = BIT(16 + b) | (is_3v3 ? 0 : BIT(b));
> > +               b = supply->idx + 4;
> > +               val1 = BIT(16 + b) | (is_3v3 ? BIT(b) : 0);
> > +
> > +               regmap_write(iod->grf, RK3568_PMU_GRF_IO_VSEL2, val0);
> > +               regmap_write(iod->grf, RK3568_PMU_GRF_IO_VSEL2, val1);
> > +               break;
> > +       case 3: /* vccio2 */
> > +               break;
> > +       case 2: /* vccio1 */
> > +       case 4: /* vccio3 */
> > +       case 5: /* vccio4 */
> > +       case 6: /* vccio5 */
> > +       case 7: /* vccio6 */
> > +       case 8: /* vccio7 */
> > +               b = supply->idx - 1;
> > +               val0 = BIT(16 + b) | (is_3v3 ? 0 : BIT(b));
> > +               val1 = BIT(16 + b) | (is_3v3 ? BIT(b) : 0);
> > +
> > +               regmap_write(iod->grf, RK3568_PMU_GRF_IO_VSEL0, val0);
> > +               regmap_write(iod->grf, RK3568_PMU_GRF_IO_VSEL1, val1);
> > +               break;
> > +       default:
> > +               return -EINVAL;
> > +       };
> > +
> > +       return 0;
> > +}
> > +
> >  static int rockchip_iodomain_write(struct rockchip_iodomain_supply *supply,
> >                                    int uV)
> >  {
> > @@ -136,7 +183,7 @@ static int rockchip_iodomain_notify(struct notifier_block *nb,
> >                         return NOTIFY_BAD;
> >         }
> >
> > -       ret = rockchip_iodomain_write(supply, uV);
> > +       ret = supply->iod->write(supply, uV);
> >         if (ret && event == REGULATOR_EVENT_PRE_VOLTAGE_CHANGE)
> >                 return NOTIFY_BAD;
> >
> > @@ -398,6 +445,22 @@ static const struct rockchip_iodomain_soc_data soc_data_rk3399_pmu = {
> >         .init = rk3399_pmu_iodomain_init,
> >  };
> >
> > +static const struct rockchip_iodomain_soc_data soc_data_rk3568_pmu = {
> > +       .grf_offset = 0x140,
> > +       .supply_names = {
> > +               "pmuio1",
> > +               "pmuio2",
> > +               "vccio1",
> > +               "vccio2",
> > +               "vccio3",
> > +               "vccio4",
> > +               "vccio5",
> > +               "vccio6",
> > +               "vccio7",
> > +       },
> > +       .write = rk3568_iodomain_write,
> > +};
> > +
> >  static const struct rockchip_iodomain_soc_data soc_data_rv1108 = {
> >         .grf_offset = 0x404,
> >         .supply_names = {
> > @@ -469,6 +532,10 @@ static const struct of_device_id rockchip_iodomain_match[] = {
> >                 .compatible = "rockchip,rk3399-pmu-io-voltage-domain",
> >                 .data = &soc_data_rk3399_pmu
> >         },
> > +       {
> > +               .compatible = "rockchip,rk3568-pmu-io-voltage-domain",
> > +               .data = &soc_data_rk3568_pmu
> > +       },
> >         {
> >                 .compatible = "rockchip,rv1108-io-voltage-domain",
> >                 .data = &soc_data_rv1108
> > @@ -502,6 +569,11 @@ static int rockchip_iodomain_probe(struct platform_device *pdev)
> >         match = of_match_node(rockchip_iodomain_match, np);
> >         iod->soc_data = match->data;
> >
> > +       if (iod->soc_data->write)
> > +               iod->write = iod->soc_data->write;
> > +       else
> > +               iod->write = rockchip_iodomain_write;
> > +
> >         parent = pdev->dev.parent;
> >         if (parent && parent->of_node) {
> >                 iod->grf = syscon_node_to_regmap(parent->of_node);
> > @@ -562,7 +634,7 @@ static int rockchip_iodomain_probe(struct platform_device *pdev)
> >                 supply->reg = reg;
> >                 supply->nb.notifier_call = rockchip_iodomain_notify;
> >
> > -               ret = rockchip_iodomain_write(supply, uV);
> > +               ret = iod->write(supply, uV);
> >                 if (ret) {
> >                         supply->reg = NULL;
> >                         goto unreg_notify;
> > --
> > 2.25.1
> >
> >
> >
> >
> > _______________________________________________
> > Linux-rockchip mailing list
> > Linux-rockchip@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 




