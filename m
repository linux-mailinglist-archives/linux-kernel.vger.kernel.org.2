Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804FA372974
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 13:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhEDLO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 07:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhEDLOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 07:14:54 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382F9C061574;
        Tue,  4 May 2021 04:13:51 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id n138so12733905lfa.3;
        Tue, 04 May 2021 04:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pB5B5vGNh7JfHcktCPrIN1oKnZroXbXhhazB4fhfugs=;
        b=oNSPNdRDAz8qH2TjdHNrrOZBUXHAk1AW+N8S5H5ogqryWPMQi9KOocAneEwqXpTVXs
         ylKiI0NgwCfGfIoXSWwQdH4/AOTIOkG100mic0aTxvilePSoeJN+/tqw33mqhTyqhLWr
         pUexxleUqI4xWy9RMKG0S2uYGTthjNBPanajP/2M4fW96bUFRAtz+Rjr68oh8jc0+pt5
         8GmTHFMcqtxZ43bdxsjmrIZYmXc4i2gyZrND40eG3FqwmI/m5l1lX+OYHNv8RK7HTqB+
         C2QIafQceFabyo4Qh8nP1M+aTYm9WIZiL3QaA6EL6rkPIGen1YyNWFWhTXZTppFMas3/
         l99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pB5B5vGNh7JfHcktCPrIN1oKnZroXbXhhazB4fhfugs=;
        b=cKQYisWozTlupnipSQHDh761ubUMlw81F/v25IdZhs5d9imzmXVy37FuiJGtLpxahX
         Dp/Lwp5Wf67NxpYhkmlJzKs56YXkbF2P+C35HcmvlsO47xPEidKZwBCkUSsxZwUyrYM6
         SxFuVhGLKKeM7Rltj7kWieqwjzyLLY1Kxp/KIZwFA9l7AHjiLKHbKymZA0VALBspYYEk
         rm0wLBntzVqP4CTXn16mcz6Ys8eYrafLXmzItw/ZdZkyxRfiyEX2V6hzetAFuIYua93T
         je81Px1NPqgy4NsD3qFcbupQkTKj0R7k40JasaQvIiILJ+qmMoDzcYUDedvaaawBHw3b
         KzWw==
X-Gm-Message-State: AOAM530yLQxObyndB/uhpOpa2odtuH5lbp1OcqTa0TrzlcJ0O/aky9JF
        nQIFklRJZcgUPHou4Z2SII5sbLl5InYTVU0a1pY=
X-Google-Smtp-Source: ABdhPJwino+fPpYKDcNU5mJ2NOppWmanyJi54pdQ9f4VBW0ZqjvyHhzOM6wB4bkRrL+B73I+G1rGBG1feXbg2jYRiMQ=
X-Received: by 2002:ac2:4308:: with SMTP id l8mr15510685lfh.223.1620126829233;
 Tue, 04 May 2021 04:13:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210430052746.10815-1-peng.fan@oss.nxp.com> <20210430052746.10815-5-peng.fan@oss.nxp.com>
In-Reply-To: <20210430052746.10815-5-peng.fan@oss.nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 4 May 2021 08:13:37 -0300
Message-ID: <CAOMZO5A4JOP0zST75bO9Ww7pxJjJSYHE9HmWCJb7DjYYd-Y80Q@mail.gmail.com>
Subject: Re: [PATCH V2 4/4] soc: imx: Add blk-ctl driver for i.MX8MM
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Marek Vasut <marex@denx.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ping Bai <ping.bai@nxp.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Adam Ford <aford173@gmail.com>, Abel Vesa <abel.vesa@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On Fri, Apr 30, 2021 at 1:56 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:

> +static int imx8mm_blk_ctl_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       const struct imx_blk_ctl_dev_data *dev_data = of_device_get_match_data(dev);
> +       struct regmap *regmap;
> +       struct resource *res;
> +       struct imx_blk_ctl *ctl;
> +       void __iomem *base;
> +
> +       ctl = devm_kzalloc(dev, sizeof(*ctl), GFP_KERNEL);
> +       if (!ctl)
> +               return -ENOMEM;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       base = devm_ioremap_resource(dev, res);
> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
> +
> +       regmap = devm_regmap_init_mmio(dev, base, &dev_data->config);
> +       if (IS_ERR(regmap))
> +               return PTR_ERR(regmap);
> +
> +       ctl->regmap = regmap;
> +       ctl->dev = dev;
> +       atomic_set(&ctl->power_count, 0);
> +
> +       ctl->num_clks = devm_clk_bulk_get_all(dev, &ctl->clks);
> +       if (ctl->num_clks < 0)
> +               return ctl->num_clks;
> +
> +       dev_set_drvdata(dev, ctl);
> +       ctl->dev_data = of_device_get_match_data(dev);

No need to call of_device_get_match_data() twice. You could do:

ctl->dev_data = dev_data;
