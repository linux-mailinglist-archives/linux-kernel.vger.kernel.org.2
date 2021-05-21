Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E13E38CA48
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 17:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbhEUPjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 11:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236375AbhEUPjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 11:39:12 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5039C061574;
        Fri, 21 May 2021 08:37:47 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id df21so23807395edb.3;
        Fri, 21 May 2021 08:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0qvQXy+PeVvNfCS2NkBgMuUJWTuqlAYAn95f2gqI374=;
        b=h3B1y2uRw7NaUMbTYgYMcECB4jBNykKhVfhenQEcHy/IQE/KxCCcvjbd899sLAKpLT
         E4nSyYtFiuKn1Ls8YhZJhNT76/3Ywa/SB6Zb75ccv66WTYpQQfDizG52Wrvp4xqtL4GR
         5r7cDy/8s11aOO8qYF3Apamvp5jdmktLSKnEhVGfNJ8aSIlo/yEh5Y9u4ZnlNoPQsZdQ
         UProjBlSwx8vQEUPEfpMuse1r72ZXWOYNbj4vJjgnsTOK/ozVzr+jNNUF8ll78aZSyKV
         INCquHi5AHDyk/HgfohAhRMuC6LY9SUMZnNoK21qNkTwGBO9+c6piVDFdvwFk8WrW/qR
         bWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0qvQXy+PeVvNfCS2NkBgMuUJWTuqlAYAn95f2gqI374=;
        b=bCRj2HnvrNQqD9Gm7o3VRc9Gpng0xk1Zs/yCT1eV6QRgNUj6H8ifK+5EBkRuhN58vo
         NV8zEZ+8gBzSVhgy+XzY+2DDSQRt8XXNMF5ljTeqKVE7FtgW5S+vJ+MdAOUGCSGTZcay
         Nxmxn/bxUaI7NY9ITjd4vJFP0enPCS/utSWMbz/AE1ENUTGWliu9+a2lC1HKWZhS9jVX
         kMzFjArUxa7f99tfv7WvXiZ5cY5qv8SD3Da4fEFkvA1lcIRC2NMKYeq2e5xxm5RqV0Bj
         0HtnDk4054C8YY2rSk0SniA1ZnkW91xNZT5fQdkhiDdHYRYWSUnDpYDXSHJWzU6EvmB2
         r6sA==
X-Gm-Message-State: AOAM530KFn34ums3XMIyue38ppPt6SnRq4VSz0p5O+R1FhzhRLL+fDGE
        J/8tHzmMPdGictVz6tZrfSRm527VkaLnONW7qfw=
X-Google-Smtp-Source: ABdhPJyfrA5z0wxQVj5MwFYZ3eIPROTNB8l9W0nouQTVih9Y0Wz5EmavgCjywh94xjSA8KUSbBZW/zGQLtUxijrsK3M=
X-Received: by 2002:a05:6402:176b:: with SMTP id da11mr10771493edb.234.1621611466156;
 Fri, 21 May 2021 08:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210521105919.20167-1-peng.fan@oss.nxp.com>
In-Reply-To: <20210521105919.20167-1-peng.fan@oss.nxp.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 21 May 2021 10:37:35 -0500
Message-ID: <CAHCN7xJRN3W8pu+eALrv35rsQEDe9We9T5Ej=M0Et_ZuFe7vng@mail.gmail.com>
Subject: Re: [PATCH V5 0/4] soc: imx: add i.MX BLK-CTL support
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

On Fri, May 21, 2021 at 5:27 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> V5:
>  Rework the blk-ctl driver to let sub-PGC use blk-ctl as parent power
>  domain to fix the potential handshake issue.
>  I still keep R-b/A-b tag for Patch 1,2,4, since very minor changes
>  I only drop R-b tag for Patch 3, since it has big change.
>  An example, the pgc_mipi not take pgc_dispmix as parent:
>
>         pgc_dispmix: power-domain@10 {
>                 #power-domain-cells = <0>;
>                 reg = <IMX8MM_POWER_DOMAIN_DISPMIX>;
>                 clocks = <&clk IMX8MM_CLK_DISP_ROOT>,
>                          <&clk IMX8MM_CLK_DISP_AXI_ROOT>,
>                          <&clk IMX8MM_CLK_DISP_APB_ROOT>;
>         };
>
>         pgc_mipi: power-domain@11 {
>                 #power-domain-cells = <0>;
>                 reg = <IMX8MM_POWER_DOMAIN_MIPI>;
>                 power-domains = <&dispmix_blk_ctl IMX8MM_BLK_CTL_PD_DISPMIX_BUS>;

With this change, I get a bunch of errors on boot.  The list of
power-domains appear correct on the surface, but it also has trouble
waking from sleep.

[    0.695947] imx8mm-blk-ctl imx-dispmix-blk-ctl.0: invalid resource
[    0.702849] imx8mm-blk-ctl: probe of imx-dispmix-blk-ctl.0 failed
with error -22
[    0.711259] imx8mm-blk-ctl imx-dispmix-blk-ctl.1: invalid resource
[    0.716451] imx8mm-blk-ctl: probe of imx-dispmix-blk-ctl.1 failed
with error -22
[    0.724856] imx8mm-blk-ctl imx-dispmix-blk-ctl.2: invalid resource
[    0.730097] imx8mm-blk-ctl: probe of imx-dispmix-blk-ctl.2 failed
with error -22
[    0.738398] imx8mm-blk-ctl imx-dispmix-blk-ctl.3: invalid resource
[    0.743747] imx8mm-blk-ctl: probe of imx-dispmix-blk-ctl.3 failed
with error -22

If I have a wrong device tree configuration, can you please post an
updated device tree?  I don't think an official patch for original
pgc's were pushed as part of either series. I used this e-mail as the
patch to enable the blk-ctl.

thanks,

adam

>         };
>
>         dispmix_blk_ctl: clock-controller@32e28000 {
>                 compatible = "fsl,imx8mm-dispmix-blk-ctl", "syscon";
>                 reg = <0x32e28000 0x100>;
>                 #power-domain-cells = <1>;
>                 power-domains = <&pgc_dispmix>, <&pgc_mipi>;
>                 power-domain-names = "dispmix", "mipi";
>                 clocks = <&clk IMX8MM_CLK_DISP_ROOT>, <&clk IMX8MM_CLK_DISP_AXI_ROOT>,
>                          <&clk IMX8MM_CLK_DISP_APB_ROOT>;
>         };
>
> V4:
>  Add R-b tag
>  Typo fix
>  Update the power domain macro names Per Abel and Frieder
>
> V3:
>  Add explaination for not listing items in patch 2 commit log Per Rob.
>  Addressed comments from Lucas and Frieder on patch [3,4].
>  A few comments from Jacky was ignored, because following gpcv2
>  coding style.
>
> V2:
>  Fix yaml check failure.
>
> Previously there is an effort from Abel that take BLK-CTL as clock
> provider, but it turns out that there is A/B lock issue and we are
> not able resolve that.
>
> Per discuss with Lucas and Jacky, we made an agreement that take BLK-CTL
> as a power domain provider and use GPC's domain as parent, the consumer
> node take BLK-CTL as power domain input.
>
> This patchset has been tested on i.MX8MM EVK board, but one hack
> is not included in the patchset is that the DISPMIX BLK-CTL
> MIPI_M/S_RESET not implemented. Per Lucas, we will finally have a MIPI
> DPHY driver, so fine to leave it.
>
> Thanks for Lucas's suggestion, Frieder Schrempf for collecting
> all the patches, Abel's previous BLK-CTL work, Jacky Bai on help
> debug issues.
>
>
> Peng Fan (4):
>   dt-bindings: power: Add defines for i.MX8MM BLK-CTL power domains
>   Documentation: bindings: clk: Add bindings for i.MX BLK_CTL
>   soc: imx: Add generic blk-ctl driver
>   soc: imx: Add blk-ctl driver for i.MX8MM
>
>  .../bindings/soc/imx/fsl,imx-blk-ctl.yaml     |  66 ++++
>  drivers/soc/imx/Makefile                      |   2 +-
>  drivers/soc/imx/blk-ctl-imx8mm.c              | 139 ++++++++
>  drivers/soc/imx/blk-ctl.c                     | 311 ++++++++++++++++++
>  drivers/soc/imx/blk-ctl.h                     |  85 +++++
>  include/dt-bindings/power/imx8mm-power.h      |  13 +
>  6 files changed, 615 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml
>  create mode 100644 drivers/soc/imx/blk-ctl-imx8mm.c
>  create mode 100644 drivers/soc/imx/blk-ctl.c
>  create mode 100644 drivers/soc/imx/blk-ctl.h
>
> --
> 2.30.0
>
