Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADD7427AE6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 16:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbhJIOsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 10:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbhJIOso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 10:48:44 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DCAC061570;
        Sat,  9 Oct 2021 07:46:46 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id g10so46922599edj.1;
        Sat, 09 Oct 2021 07:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VFce9KNvQ028xuQX9mvQiwXombOxSqFvFxEkfZLnJmQ=;
        b=WO/vh6dTPye9X/af7m9+HlWMzRLU5plmdiianf4jkOsgYQotqqKipUIb+Rq3F4s7vO
         gEuSbT9uPCkbrHP9q3hKt2ljjSYirE8w6tkywg2EzOk+BMU0SMrBsXgwZfxRBSRwUm63
         5isOXu7BZlTtRE9YmfNA3uNv5C21B5DBCIECTscrBJ3wcX8Y/8VtrhsXy42z6qQiThXx
         hT2BKUrGd/Fgz2ltfui11kymiJRJ0DMfd5biQ3a1F8+Snu30dBZJdHUoOWyArpIW8djT
         I5mlBsvYgb/wqecnaOLnoK904ljFngZlTPtXVnqWFNKYmK/KQNhT5nQ9s3y1EdtJtS9u
         0dtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VFce9KNvQ028xuQX9mvQiwXombOxSqFvFxEkfZLnJmQ=;
        b=nLMUD2pTO7Lt1vieUivvMtrwfNx9wbPWdeWPMrQUlpNBEhYnzNQmQID2R99nFNd1aj
         U1fhrmLNmDgE5TkOumpr7rQAoeF/XQ4u/b5TGQiZDSO6dMNXnaajS49bCSZDTaYMIjQe
         bwK7WnPBMGYWZQmGeplV+d31nMnuAkmsvf2dA9onFTY7UU/OSddD/wqq+kcMzjEeKAjO
         2AsWas/5bXyNNeF+h+hQTt4qzyWXMZ9FKbhfk6rGaJUddvKKfacE8gf0/nwGG4J1eON5
         g7vqKhkqyiXH0lciAfFqPowXFcguNp504XFvcKZPD15fAwu+JfxUuDP3AiWf83XKcHfb
         0wNg==
X-Gm-Message-State: AOAM5339YdJjn2DW8tLo9kbtbwHqpXqVtj0bT44LYU3ZGAcZYSKDmpRA
        +HL+9kLLYoeIXZKnk3JBPGe6Px9usdl+eiXaCm8=
X-Google-Smtp-Source: ABdhPJw+dNvjLqP43cicqUzv01l3JY+uvmb2U0gg7fQHBOaJbC8zMu2ug/Ah/5gMcebe1Idpmw8Y6eK5ES/R3lHysqs=
X-Received: by 2002:a17:906:1510:: with SMTP id b16mr12539782ejd.332.1633790805128;
 Sat, 09 Oct 2021 07:46:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211006000505.627334-1-aford173@gmail.com> <20211006000505.627334-3-aford173@gmail.com>
 <8c1d1b836d1acb94e22a355d064a6df867d1e9e2.camel@pengutronix.de>
In-Reply-To: <8c1d1b836d1acb94e22a355d064a6df867d1e9e2.camel@pengutronix.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Sat, 9 Oct 2021 09:46:33 -0500
Message-ID: <CAHCN7x+81JrpA8MenzDby8OjjCJqu9nt0JbtE7opsLxO1+RbfQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] soc: imx: imx8m-blk-ctrl: add i.MX8MN DISP blk-ctrl
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 6, 2021 at 2:45 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Am Dienstag, dem 05.10.2021 um 19:05 -0500 schrieb Adam Ford:
> > This adds the description for the i.MX8MN disp blk-ctrl.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> >  drivers/soc/imx/imx8m-blk-ctrl.c | 70 ++++++++++++++++++++++++++++++++
> >  1 file changed, 70 insertions(+)
> >
> > diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
> > index e172d295c441..8fcd5ed62f50 100644
> > --- a/drivers/soc/imx/imx8m-blk-ctrl.c
> > +++ b/drivers/soc/imx/imx8m-blk-ctrl.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/clk.h>
> >
> >  #include <dt-bindings/power/imx8mm-power.h>
> > +#include <dt-bindings/power/imx8mn-power.h>
> >
> >  #define BLK_SFT_RSTN 0x0
> >  #define BLK_CLK_EN   0x4
> > @@ -498,6 +499,75 @@ static const struct imx8m_blk_ctrl_data imx8mm_disp_blk_ctl_dev_data = {
> >       .num_domains = ARRAY_SIZE(imx8mm_disp_blk_ctl_domain_data),
> >  };
> >
> > +
> > +static int imx8mn_disp_power_notifier(struct notifier_block *nb,
> > +                                   unsigned long action, void *data)
> > +{
> > +     struct imx8m_blk_ctrl *bc = container_of(nb, struct imx8m_blk_ctrl,
> > +                                              power_nb);
> > +
> > +     if (action != GENPD_NOTIFY_ON && action != GENPD_NOTIFY_PRE_OFF)
> > +             return NOTIFY_OK;
> > +
> > +     /* Enable bus clock and deassert bus reset */
> > +     regmap_set_bits(bc->regmap, BLK_CLK_EN, BIT(8));
> > +     regmap_set_bits(bc->regmap, BLK_SFT_RSTN, BIT(8));
> > +
> > +     /*
> > +      * On power up we have no software backchannel to the GPC to
> > +      * wait for the ADB handshake to happen, so we just delay for a
> > +      * bit. On power down the GPC driver waits for the handshake.
> > +      */
> > +     if (action == GENPD_NOTIFY_ON)
> > +             udelay(5);
> > +
> > +
> > +     return NOTIFY_OK;
> > +}
> > +
> > +static const struct imx8m_blk_ctrl_domain_data imx8mn_disp_blk_ctl_domain_data[] = {
> > +     [IMX8MN_DISPBLK_PD_MIPI_DSI] = {
> > +             .name = "dispblk-mipi-dsi",
> > +             .clk_names = (const char *[]){ "dsi-pclk", "dsi-ref", },
> > +             .num_clks = 2,
> > +             .gpc_name = "mipi-dsi",
> > +             .rst_mask = BIT(0) | BIT(1),
> > +             .clk_mask = BIT(0) | BIT(1),
> > +     },
> > +     [IMX8MN_DISPBLK_PD_MIPI_CSI] = {
> > +             .name = "dispblk-mipi-csi",
> > +             .clk_names = (const char *[]){ "csi-aclk", "csi-pclk" },
> > +             .num_clks = 2,
> > +             .gpc_name = "mipi-csi",
> > +             .rst_mask = BIT(2) | BIT(3),
> > +             .clk_mask = BIT(2) | BIT(3),
> > +     },
> > +     [IMX8MN_DISPBLK_PD_LCDIF] = {
> > +             .name = "dispblk-lcdif",
> > +             .clk_names = (const char *[]){ "lcdif-axi", "lcdif-apb", "lcdif-pix", },
> > +             .num_clks = 3,
> > +             .gpc_name = "lcdif",
> > +             .rst_mask = BIT(4) | BIT(5),
> > +             .clk_mask = BIT(4) | BIT(5),
> > +     },
> > +     [IMX8MN_DISPBLK_PD_ISI] = {
> > +             .name = "dispblk-isi",
> > +             .clk_names = (const char *[]){ "disp_axi", "disp_apb", "disp_axi_root",
> > +                                             "disp_apb_root"},
> > +             .num_clks = 2,
>
> I think those are wrong. At least the num_clks and the number of clock
> names is inconsistent.

The NXP tree shows 4 clocks on the ISI node are enabled before the ISI
can be pulled out of reset.  I'll make the num_clks = 4.

>
> > +             .gpc_name = "isi",
> > +             .rst_mask = BIT(6) | BIT(7),
> > +             .clk_mask = BIT(6) | BIT(7),
> > +     },
> > +};
> > +
> > +static const struct imx8m_blk_ctrl_data imx8mn_disp_blk_ctl_dev_data = {
> > +     .max_reg = 0x84,
> > +     .power_notifier_fn = imx8mn_disp_power_notifier,
> > +     .domains = imx8mn_disp_blk_ctl_domain_data,
> > +     .num_domains = ARRAY_SIZE(imx8mn_disp_blk_ctl_domain_data),
> > +};
> > +
> You need to hook this up in imx8m_blk_ctrl_of_match, otherwise this is
> all just dead code.

Oops.  I had that, but i forgot to commit after the save.  It'll be
fixed shortly.
>
> Regards,
> Lucas
>
thanks for the review.

adam
> >  static const struct of_device_id imx8m_blk_ctrl_of_match[] = {
> >       {
> >               .compatible = "fsl,imx8mm-vpu-blk-ctrl",
>
>
