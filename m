Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846AB38F3C8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 21:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbhEXTje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 15:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbhEXTjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 15:39:32 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DACFC061574;
        Mon, 24 May 2021 12:38:04 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id z12so42094672ejw.0;
        Mon, 24 May 2021 12:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8oAOXzof0N1+90KYKcnDoG7KO0XKY2BDmkA3DIOawcs=;
        b=e9L3/H+fekzU7kJQHZ6qnNscSpr2lz3gmVl+ygAMlosfr9CFdZaSsdVMyV42WXuS2Z
         vmL14YGf8Mg3UjcS3rt/rSOaIJo/suaGdX0QCkrIpAa57mIFtd+mrhHT0zgXwckRGk7i
         FpwarZaXTUf9j3XRDQBH8r0te6U//eoM+sw7ZqJZHaeNfEapcikIcv4kDwKByio+WInO
         H9a1M0wFNHXYyzawqFc89DrC2w1YN6ToLWep6XGS3kZcDNzu0y7/yZN6nqkTJ7vXwj/f
         VMvpEb7FHdPrF7JVZBwTkonOk2xMHcy9BiZW8BU1IMA/pX38JUl4sMiAv9l+ai3zrWUO
         eC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8oAOXzof0N1+90KYKcnDoG7KO0XKY2BDmkA3DIOawcs=;
        b=SCXCPS7BOmn0/QzoYeTxkZ0ehdGG8QQWvPSldTvnN/3QHHuFjoV+uwDL1Xwk/sIrzh
         jNuE55D2FL+bdbUCQu0zaBDghsBCwoGRaGcppbIV8gQ3V5iA9LRse8AqyyJYrPTTt8O1
         yJH7XrNRPKM3pt6x8WjPBNJ3kDbC4SFjt0bhY/zJx1EAlDOVbUjIirfH7cwcnd5QCE+V
         BIQPcQiPBJKFadG9bRW5KRsgUidDn9Ovv6soCiH627jwNpP9sklHKLRwayalH2FEcACE
         p6p6IJPt8jYLgaGb0Qms9kqKf4DnUDFW/s1KB/hNGlhSlkpVxAv7Fu9BDcbHbNDrLUbT
         K8Xg==
X-Gm-Message-State: AOAM530/ZVVYWGjWAzpY4GSlGf/SlSrbfLy6T3Aod8Wyiry0Gg/x7Ni3
        selLe63dJ83u7KEUJBFxGMkax32nm5MzZIerTGo=
X-Google-Smtp-Source: ABdhPJxagI/07bet2pfWu3ypCK7p/EojciJg5sT2GKagYo2DrLuKVD0kjMqRrySffxHtLw7vELKs+XMDVEt7LaMOOT8=
X-Received: by 2002:a17:906:3b92:: with SMTP id u18mr24693138ejf.450.1621885081595;
 Mon, 24 May 2021 12:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210522134249.15322-1-peng.fan@oss.nxp.com> <CAHCN7xKU=o8J5==VbjVY8E6iRXEXP7jvGP-TWKp+9BZfZaA4Dw@mail.gmail.com>
In-Reply-To: <CAHCN7xKU=o8J5==VbjVY8E6iRXEXP7jvGP-TWKp+9BZfZaA4Dw@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 24 May 2021 14:37:50 -0500
Message-ID: <CAHCN7x+YZfAk=3RumT6BAxB3gyB7-THT4ACt5PvQRGiMqB-9Sg@mail.gmail.com>
Subject: Re: [PATCH V6 0/4] soc: imx: add i.MX BLK-CTL support
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Marek Vasut <marex@denx.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Abel Vesa <abel.vesa@nxp.com>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 2:29 PM Adam Ford <aford173@gmail.com> wrote:
>
> On Sat, May 22, 2021 at 8:10 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
> >
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > V6:
> >  Thanks for Adam's report on V5.
> >  Resolve the error message dump, it is the child device reuse
> >  the parent device node and matches the parent driver.
> >  Filled the remove function for child device.
> >  A diff dts file for upstream:
> >  https://gist.github.com/MrVan/d73888d8273c43ea4a3b28fa668ca1d0
>
Peng,

> Since Shawn has merged the pgc portion [1], can you post the device
> tree to the mailing list, so he can pull that in too? Without the DT,
> the PGC's won't do anything.

On that note, you may want to double check the VPU power domain nodes.
I think they should be:

vpumix_pd: power-domain@6
vpu_g1_pd: power-domain@7
vpu_g2_pd: power-domain@8
vpu_h1_pd: power-domain@9

> If you want me to do it, can I do it, but you've done all the work.
>
> [1] - https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git/log/?h=for-next
>
> thanks
>
> adam
>
> >
> > V5:
> >  Rework the blk-ctl driver to let sub-PGC use blk-ctl as parent power
> >  domain to fix the potential handshake issue.
> >  I still keep R-b/A-b tag for Patch 1,2,4, since very minor changes
> >  I only drop R-b tag for Patch 3, since it has big change.
> >  An example, the pgc_mipi not take pgc_dispmix as parent:
> >
> >         pgc_dispmix: power-domain@10 {
> >                 #power-domain-cells = <0>;
> >                 reg = <IMX8MM_POWER_DOMAIN_DISPMIX>;
> >                 clocks = <&clk IMX8MM_CLK_DISP_ROOT>,
> >                          <&clk IMX8MM_CLK_DISP_AXI_ROOT>,
> >                          <&clk IMX8MM_CLK_DISP_APB_ROOT>;
> >         };
> >
> >         pgc_mipi: power-domain@11 {
> >                 #power-domain-cells = <0>;
> >                 reg = <IMX8MM_POWER_DOMAIN_MIPI>;
> >                 power-domains = <&dispmix_blk_ctl IMX8MM_BLK_CTL_PD_DISPMIX_BUS>;
> >         };
> >
> >         dispmix_blk_ctl: clock-controller@32e28000 {
> >                 compatible = "fsl,imx8mm-dispmix-blk-ctl", "syscon";
> >                 reg = <0x32e28000 0x100>;
> >                 #power-domain-cells = <1>;
> >                 power-domains = <&pgc_dispmix>, <&pgc_mipi>;
> >                 power-domain-names = "dispmix", "mipi";
> >                 clocks = <&clk IMX8MM_CLK_DISP_ROOT>, <&clk IMX8MM_CLK_DISP_AXI_ROOT>,
> >                          <&clk IMX8MM_CLK_DISP_APB_ROOT>;
> >         };
> >
> > V4:
> >  Add R-b tag
> >  Typo fix
> >  Update the power domain macro names Per Abel and Frieder
> >
> > V3:
> >  Add explaination for not listing items in patch 2 commit log Per Rob.
> >  Addressed comments from Lucas and Frieder on patch [3,4].
> >  A few comments from Jacky was ignored, because following gpcv2
> >  coding style.
> >
> > V2:
> >  Fix yaml check failure.
> >
> > Previously there is an effort from Abel that take BLK-CTL as clock
> > provider, but it turns out that there is A/B lock issue and we are
> > not able resolve that.
> >
> > Per discuss with Lucas and Jacky, we made an agreement that take BLK-CTL
> > as a power domain provider and use GPC's domain as parent, the consumer
> > node take BLK-CTL as power domain input.
> >
> > This patchset has been tested on i.MX8MM EVK board, but one hack
> > is not included in the patchset is that the DISPMIX BLK-CTL
> > MIPI_M/S_RESET not implemented. Per Lucas, we will finally have a MIPI
> > DPHY driver, so fine to leave it.
> >
> > Thanks for Lucas's suggestion, Frieder Schrempf for collecting
> > all the patches, Abel's previous BLK-CTL work, Jacky Bai on help
> > debug issues.
> >
> >
> > Peng Fan (4):
> >   dt-bindings: power: Add defines for i.MX8MM BLK-CTL power domains
> >   Documentation: bindings: clk: Add bindings for i.MX BLK_CTL
> >   soc: imx: Add generic blk-ctl driver
> >   soc: imx: Add blk-ctl driver for i.MX8MM
> >
> >  .../bindings/soc/imx/fsl,imx-blk-ctl.yaml     |  66 ++++
> >  drivers/soc/imx/Makefile                      |   2 +-
> >  drivers/soc/imx/blk-ctl-imx8mm.c              | 139 ++++++++
> >  drivers/soc/imx/blk-ctl.c                     | 334 ++++++++++++++++++
> >  drivers/soc/imx/blk-ctl.h                     |  85 +++++
> >  include/dt-bindings/power/imx8mm-power.h      |  13 +
> >  6 files changed, 638 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml
> >  create mode 100644 drivers/soc/imx/blk-ctl-imx8mm.c
> >  create mode 100644 drivers/soc/imx/blk-ctl.c
> >  create mode 100644 drivers/soc/imx/blk-ctl.h
> >
> > --
> > 2.30.0
> >
