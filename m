Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA9E38D30E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 04:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhEVCd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 22:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbhEVCd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 22:33:56 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902D9C061574;
        Fri, 21 May 2021 19:32:31 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id c20so33166942ejm.3;
        Fri, 21 May 2021 19:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bHH470bkXqJd95/yYGo/ipPVf6TM8AxakgkU87EHL6U=;
        b=gQdf//VAsShinxC/gEtaq6+VWcE96uebHoGes+gcs+wDpQKvAN/bysCDImZYFZJYBr
         HgUKFkM3ZzF9CtygsNvy1pFBoQqyfnfORSh2vCdX77ocCNJpjeQaJwVk4Pcf9bWfzPJV
         8d+F1X1eTvqspbAs0aq7KNy6wD83FjESxa31jyEiBg/SjuUBlyk1FNA7NW8d/6/MhU/q
         +PG2WLM7b+8h+aTIcQXk5nmW3Sq7du8m4LOgbZ7W9/+JnaB6N5uX+wyw13qO9mxRKuU3
         ytOZa+leZrY2+SzJtoHUTIe602puZKpVAjn1EmZTN2guWucVMDAnXU5DiEeVSb3Pf9wt
         NtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bHH470bkXqJd95/yYGo/ipPVf6TM8AxakgkU87EHL6U=;
        b=GSOH+vYYKXTh9hpot3DJdX/e2VdnCIJWmPlYUXRa4Ncn4NYz61Qiswqr7sQnfIqc57
         qr+5LC7AwqhbjZCAWrWEjeMMchh/TqSv00/6cDq9no7tjLEw9hBu3KZ2omeucVAZLJsb
         DwxABznvOJeGd4A5kWxn0zLbGlC9PhvlrAYUShcgSS26O/Zr+lAJnjXtV5kRx6HBeEdg
         G7dGquNIgRkp5ufipSRM4SxDzh8sCllo2mMwJWkFjotecB9jrYxlvBQ/JnV80Z3YjC4d
         cQwbQ3wUgGHC7xCGIJ3k7GwPyEmW0dfKbjulFwkffLDd84AR4n/s/okTcIMqk78OVitm
         LVEA==
X-Gm-Message-State: AOAM531loZp9uorfoVEUh3QTXXfN4nm+FrDut8JtEpXe01QddrHmyT+w
        hpMDywdAyzuCM9jISju1auoPxJX+c35MKdP04hE=
X-Google-Smtp-Source: ABdhPJziNsufNd1c6s8I/DiTbQXx9V7K2wIcfqmrmU1OPXr7r3/wOzV46EWNnMiZFWPPbLshDKq+w8lB46HP9LfmuF4=
X-Received: by 2002:a17:906:22c6:: with SMTP id q6mr12892230eja.275.1621650749995;
 Fri, 21 May 2021 19:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210521105919.20167-1-peng.fan@oss.nxp.com> <CAHCN7xJRN3W8pu+eALrv35rsQEDe9We9T5Ej=M0Et_ZuFe7vng@mail.gmail.com>
 <DB6PR0402MB276010E5B7C2318C8DC2685188289@DB6PR0402MB2760.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR0402MB276010E5B7C2318C8DC2685188289@DB6PR0402MB2760.eurprd04.prod.outlook.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 21 May 2021 21:32:18 -0500
Message-ID: <CAHCN7xLTjE82EnzRXW84e_Lm63+hxfOeFXSdoZmVe6ujs3F2Pw@mail.gmail.com>
Subject: Re: [PATCH V5 0/4] soc: imx: add i.MX BLK-CTL support
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
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
        Abel Vesa <abel.vesa@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 7:54 PM Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: Re: [PATCH V5 0/4] soc: imx: add i.MX BLK-CTL support
> >
> > On Fri, May 21, 2021 at 5:27 AM Peng Fan (OSS) <peng.fan@oss.nxp.com>
> > wrote:
> > >
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > V5:
> > >  Rework the blk-ctl driver to let sub-PGC use blk-ctl as parent power
> > > domain to fix the potential handshake issue.
> > >  I still keep R-b/A-b tag for Patch 1,2,4, since very minor changes  I
> > > only drop R-b tag for Patch 3, since it has big change.
> > >  An example, the pgc_mipi not take pgc_dispmix as parent:
> > >
> > >         pgc_dispmix: power-domain@10 {
> > >                 #power-domain-cells = <0>;
> > >                 reg = <IMX8MM_POWER_DOMAIN_DISPMIX>;
> > >                 clocks = <&clk IMX8MM_CLK_DISP_ROOT>,
> > >                          <&clk IMX8MM_CLK_DISP_AXI_ROOT>,
> > >                          <&clk IMX8MM_CLK_DISP_APB_ROOT>;
> > >         };
> > >
> > >         pgc_mipi: power-domain@11 {
> > >                 #power-domain-cells = <0>;
> > >                 reg = <IMX8MM_POWER_DOMAIN_MIPI>;
> > >                 power-domains = <&dispmix_blk_ctl
> > > IMX8MM_BLK_CTL_PD_DISPMIX_BUS>;
> >
> > With this change, I get a bunch of errors on boot.  The list of power-domains
> > appear correct on the surface, but it also has trouble waking from sleep.
> >
> > [    0.695947] imx8mm-blk-ctl imx-dispmix-blk-ctl.0: invalid resource
> > [    0.702849] imx8mm-blk-ctl: probe of imx-dispmix-blk-ctl.0 failed
> > with error -22
> > [    0.711259] imx8mm-blk-ctl imx-dispmix-blk-ctl.1: invalid resource
> > [    0.716451] imx8mm-blk-ctl: probe of imx-dispmix-blk-ctl.1 failed
> > with error -22
> > [    0.724856] imx8mm-blk-ctl imx-dispmix-blk-ctl.2: invalid resource
> > [    0.730097] imx8mm-blk-ctl: probe of imx-dispmix-blk-ctl.2 failed
> > with error -22
> > [    0.738398] imx8mm-blk-ctl imx-dispmix-blk-ctl.3: invalid resource
> > [    0.743747] imx8mm-blk-ctl: probe of imx-dispmix-blk-ctl.3 failed
> > with error -22
>
> It is just the imx8mm-blk-ctl driver matches with the new created
> child device, because the child device points the of_node of the parent
> device.
> But this error will not affect functionality.
> I'll resolve this issue and send out v6.
> >
> > If I have a wrong device tree configuration, can you please post an updated
> > device tree?  I don't think an official patch for original pgc's were pushed as
> > part of either series. I used this e-mail as the patch to enable the blk-ctl.
>
> Do you have an device tree, I could give a look.

I have a git repo where I've been collecting the various power domain
patches.  I have updated the imx8mn blk-ctl and device trees as well
in that same repo.

https://github.com/aford173/linux/blob/linux-5.13.y-aford/arch/arm64/boot/dts/freescale/imx8mm.dtsi

thanks for looking at this.

adam
>
> Regards,
> Peng.
>
> >
> > thanks,
> >
> > adam
> >
> > >         };
> > >
> > >         dispmix_blk_ctl: clock-controller@32e28000 {
> > >                 compatible = "fsl,imx8mm-dispmix-blk-ctl", "syscon";
> > >                 reg = <0x32e28000 0x100>;
> > >                 #power-domain-cells = <1>;
> > >                 power-domains = <&pgc_dispmix>, <&pgc_mipi>;
> > >                 power-domain-names = "dispmix", "mipi";
> > >                 clocks = <&clk IMX8MM_CLK_DISP_ROOT>, <&clk
> > IMX8MM_CLK_DISP_AXI_ROOT>,
> > >                          <&clk IMX8MM_CLK_DISP_APB_ROOT>;
> > >         };
> > >
> > > V4:
> > >  Add R-b tag
> > >  Typo fix
> > >  Update the power domain macro names Per Abel and Frieder
> > >
> > > V3:
> > >  Add explaination for not listing items in patch 2 commit log Per Rob.
> > >  Addressed comments from Lucas and Frieder on patch [3,4].
> > >  A few comments from Jacky was ignored, because following gpcv2
> > > coding style.
> > >
> > > V2:
> > >  Fix yaml check failure.
> > >
> > > Previously there is an effort from Abel that take BLK-CTL as clock
> > > provider, but it turns out that there is A/B lock issue and we are not
> > > able resolve that.
> > >
> > > Per discuss with Lucas and Jacky, we made an agreement that take
> > > BLK-CTL as a power domain provider and use GPC's domain as parent, the
> > > consumer node take BLK-CTL as power domain input.
> > >
> > > This patchset has been tested on i.MX8MM EVK board, but one hack is
> > > not included in the patchset is that the DISPMIX BLK-CTL
> > > MIPI_M/S_RESET not implemented. Per Lucas, we will finally have a MIPI
> > > DPHY driver, so fine to leave it.
> > >
> > > Thanks for Lucas's suggestion, Frieder Schrempf for collecting all the
> > > patches, Abel's previous BLK-CTL work, Jacky Bai on help debug issues.
> > >
> > >
> > > Peng Fan (4):
> > >   dt-bindings: power: Add defines for i.MX8MM BLK-CTL power domains
> > >   Documentation: bindings: clk: Add bindings for i.MX BLK_CTL
> > >   soc: imx: Add generic blk-ctl driver
> > >   soc: imx: Add blk-ctl driver for i.MX8MM
> > >
> > >  .../bindings/soc/imx/fsl,imx-blk-ctl.yaml     |  66 ++++
> > >  drivers/soc/imx/Makefile                      |   2 +-
> > >  drivers/soc/imx/blk-ctl-imx8mm.c              | 139 ++++++++
> > >  drivers/soc/imx/blk-ctl.c                     | 311
> > ++++++++++++++++++
> > >  drivers/soc/imx/blk-ctl.h                     |  85 +++++
> > >  include/dt-bindings/power/imx8mm-power.h      |  13 +
> > >  6 files changed, 615 insertions(+), 1 deletion(-)  create mode 100644
> > > Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml
> > >  create mode 100644 drivers/soc/imx/blk-ctl-imx8mm.c  create mode
> > > 100644 drivers/soc/imx/blk-ctl.c  create mode 100644
> > > drivers/soc/imx/blk-ctl.h
> > >
> > > --
> > > 2.30.0
> > >
