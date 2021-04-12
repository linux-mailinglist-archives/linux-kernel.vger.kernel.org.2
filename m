Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC02B35CF4D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 19:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244026AbhDLRRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 13:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244447AbhDLRQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 13:16:58 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A93C061345;
        Mon, 12 Apr 2021 10:16:40 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h4so4704865wrt.12;
        Mon, 12 Apr 2021 10:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zBLqiX2Mn/nwKNG5q5yBzOqhdu3MQKFAhofsCCGEKWM=;
        b=ZzRRX0e1kvTx584FYT8NbEZci3qgF8cNP9O17rKhrTzNLKIxh1biZSWpkKixdR6+3+
         crYg52pTm6ifpDZz8gaGjN5YOc0g1AVH/Q3YfhOlczvnNRZb6YK7846400GIAnZ4CSOB
         yUvW3DMcBKe9txiacMzkbeuFEOh/n3gMYF8IpKP5LtFDMDzogscfaNboGyszYTyJOyRK
         dZY0tgRapkDA3wx6vFDVMwLYjnbJ4hL30xElPWYZRvEKKeVfT9/CSU99AA8U5znQt4V/
         oseAVf6W6L7U29nDORd7e7w7EUlZdyl8O3wMI3IYujbEu2vRHJ3Yl17D/Wm/Nb6fC8nG
         49Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zBLqiX2Mn/nwKNG5q5yBzOqhdu3MQKFAhofsCCGEKWM=;
        b=WXsSpIaNwKAUNvujBG/0+uRqNFkzZCexgUcBle7hdmFCIOt5jASi4Zn5YPCfaYGLmr
         kbT/V0hzjxgWLXSMBgPgvsqBEQA/BaKWyRNeLaUY6rLPnedqN99pG+NYggYC3bfVuduT
         QaGkZ0QEaK2oEtzV7GdmXYxv4+3wicywi2cCamfKMZaZ7nnUJi8lTyJVUyurtuWjyOKN
         99+JYIqGAmblYgT0dRj8w11dEfSgpnPTRsuZARGFAMQDMDMs8cUmMfzoO0CVHNztXIAq
         xwiKMfZbkyd19ZFAgEjCJLBSBxK0KipUOIIzF6KP3cr+L2tpswDb3Ty0RH7EKPlZVqmi
         HgYA==
X-Gm-Message-State: AOAM532qJkmuTDIPu/dCNitodBdkxud9RnqJMDFltE9+/gM/CCtklOYv
        PhQgmyDfAil12KEexXmQBBqjhvh1WNxBSEFJWrg=
X-Google-Smtp-Source: ABdhPJzKcsmdzgifb8/HyZIWqE8/ZkjSMdGVd33Quz100phTiOSWGLE+itPgX1ekWvfvUfc25ZwNvJcrXFWGUbRo1is=
X-Received: by 2002:a05:6000:250:: with SMTP id m16mr33695518wrz.325.1618247798616;
 Mon, 12 Apr 2021 10:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210407212122.626137-1-adrien.grassein@gmail.com> <20210407212122.626137-2-adrien.grassein@gmail.com>
In-Reply-To: <20210407212122.626137-2-adrien.grassein@gmail.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 12 Apr 2021 10:16:27 -0700
Message-ID: <CAHQ1cqEq3LBvJxNBRC-vVsB7=Uj9qTgBXzuAB5vN92qtxo=7bw@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] soc: imx: gpcv2: check for errors when r/w registers
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Anson Huang <Anson.Huang@nxp.com>, krzk@kernel.org,
        peng.fan@nxp.com, Dong Aisheng <aisheng.dong@nxp.com>,
        qiangqing.zhang@nxp.com, alice.guo@nxp.com, aford173@gmail.com,
        agx@sigxcpu.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 7, 2021 at 2:21 PM Adrien Grassein
<adrien.grassein@gmail.com> wrote:
>
> Errors were not checked after each access to registers

FWIW, I didn't write any error checking code on purpose since all of
those are memory mapped registers and I don't think there's a case for
those to error out. Don't have a strong opinion on this though.

> and clocks initialisation.
>
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  drivers/soc/imx/gpcv2.c | 62 ++++++++++++++++++++++++++++++-----------
>  1 file changed, 45 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> index db7e7fc321b1..8ec5b1b817c7 100644
> --- a/drivers/soc/imx/gpcv2.c
> +++ b/drivers/soc/imx/gpcv2.c
> @@ -140,8 +140,12 @@ static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
>         int i, ret = 0;
>         u32 pxx_req;
>
> -       regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
> -                          domain->bits.map, domain->bits.map);
> +       ret = regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
> +                                domain->bits.map, domain->bits.map);
> +       if (ret) {
> +               dev_err(domain->dev, "failed to map GPC PGC domain\n");
> +               return ret;
> +       }
>
>         if (has_regulator && on) {
>                 ret = regulator_enable(domain->regulator);
> @@ -152,19 +156,39 @@ static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
>         }
>
>         /* Enable reset clocks for all devices in the domain */
> -       for (i = 0; i < domain->num_clks; i++)
> -               clk_prepare_enable(domain->clk[i]);
> +       for (i = 0; i < domain->num_clks; i++) {
> +               ret = clk_prepare_enable(domain->clk[i]);
> +               if (ret) {
> +                       dev_err(domain->dev, "failed to enable clocks\n");
> +                       goto disable_clocks;
> +               }
> +       }
>
> -       if (enable_power_control)
> -               regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
> -                                  GPC_PGC_CTRL_PCR, GPC_PGC_CTRL_PCR);
> +       if (enable_power_control) {
> +               ret = regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
> +                                        GPC_PGC_CTRL_PCR, GPC_PGC_CTRL_PCR);
> +               if (ret) {
> +                       dev_err(domain->dev, "failed to enable power control\n");
> +                       goto disable_clocks;
> +               }
> +       }
>
> -       if (domain->bits.hsk)
> -               regmap_update_bits(domain->regmap, GPC_PU_PWRHSK,
> -                                  domain->bits.hsk, on ? domain->bits.hsk : 0);
> +       if (domain->bits.hsk) {
> +               ret = regmap_update_bits(domain->regmap, GPC_PU_PWRHSK,
> +                                        domain->bits.hsk,
> +                                        on ? domain->bits.hsk : 0);
> +               if (ret) {
> +                       dev_err(domain->dev, "Failed to initiate handshake\n");
> +                       goto disable_power_control;
> +               }
> +       }
>
> -       regmap_update_bits(domain->regmap, offset,
> -                          domain->bits.pxx, domain->bits.pxx);
> +       ret = regmap_update_bits(domain->regmap, offset,
> +                                domain->bits.pxx, domain->bits.pxx);
> +       if (ret) {
> +               dev_err(domain->dev, "failed to command PGC\n");
> +               goto disable_power_control;
> +       }
>
>         /*
>          * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
> @@ -173,8 +197,15 @@ static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
>         ret = regmap_read_poll_timeout(domain->regmap, offset, pxx_req,
>                                        !(pxx_req & domain->bits.pxx),
>                                        0, USEC_PER_MSEC);
> -       if (ret) {
> +       if (ret)
>                 dev_err(domain->dev, "failed to command PGC\n");
> +
> +disable_power_control:
> +       if (enable_power_control)
> +               regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
> +                                  GPC_PGC_CTRL_PCR, 0);
> +
> +       if (ret) {
>                 /*
>                  * If we were in a process of enabling a
>                  * domain and failed we might as well disable
> @@ -185,10 +216,7 @@ static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
>                 on = !on;
>         }
>
> -       if (enable_power_control)
> -               regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
> -                                  GPC_PGC_CTRL_PCR, 0);
> -
> +disable_clocks:
>         /* Disable reset clocks for all devices in the domain */
>         for (i = 0; i < domain->num_clks; i++)
>                 clk_disable_unprepare(domain->clk[i]);
> --
> 2.25.1
>
