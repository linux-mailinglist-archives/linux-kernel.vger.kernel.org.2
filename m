Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4890B3B81B3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 14:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbhF3MLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 08:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbhF3MLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 08:11:53 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E039FC061756;
        Wed, 30 Jun 2021 05:09:24 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id b2so3821947ejg.8;
        Wed, 30 Jun 2021 05:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ynVUEC0Bzycy6DAvt2jibydrAP7QWLexMJlLYkk4Nao=;
        b=trQsKH5aFHNPfDkR706HBDTloMX/1RWf3Fnp7BVAdAJOMCL5iaCi7NG3xdSTr9/tiO
         UN7GkfuvNjB3DAN/yf9O0pwYRr33RkftXYw7o0QYHiRGYFKceCVkAbUpO+EJV9KCYN7x
         bk1C1rA8Dsw+Tgn8MTpyWnswhQWJMr96b6dnvj7oEQf5EsflSMrAyxc8TRrca0V1wxtU
         G5iCcRhhdHCP3N+vUOVKjxzKmaZIfWL2dqhKWnTFVnHd1oAXMCzNU4dbe3cejk3zsGwY
         IpTZCQKPzv8Mvw91K98NVo4e+A0/kKDRA03mI8dyQ4L2Nh2/8GOUCAp3P+qNaJZSX8YV
         mctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ynVUEC0Bzycy6DAvt2jibydrAP7QWLexMJlLYkk4Nao=;
        b=kbIfKkJNFiZi2tKiFd6ZC8IYWkwrPIF/tdeEcMudJ6RfiQHbrAyUPEAZ6/U3kTcjNY
         KZwqSSuVg+97n5HDlOOSxuiECKx1FzO4segsBNPUQJNlQgUDtovCbthcAIxGWJqCnnH4
         xlmkN+AK/cdYwbzlXwcNfCbtesccHIIw6DRNensVzIcpWjCoLGralaNO3Dt0e3OeN3g0
         DNg7Uof/ZLbCxb+QKbUV1y+7dmORmiVQ6SAAxJNfTChY/N5n85R9UVop9PhTeHMBWker
         b0DxVa637dP6pn2LbAYcPPAsT9SERizU5iBz/5syaxQqbartaIGK2kBnEt/7B6zMJd5U
         i+xA==
X-Gm-Message-State: AOAM531Ty0mWSsogKwPPh/dSrBF9vVRFJWMnDMOgNKXOQhf9o+Pigzh5
        NM8UC7h/8bOeL2KHI9kDQ8F4dqD8gqJz4Loui+Q=
X-Google-Smtp-Source: ABdhPJy9ZI49E8xb/BRqaA0De8BOAXcj+CEyjJoZGTPlSnHCe2YqDHlXEibRrbDUiX2EXU2j4Bx5zjCl7g7MKIOsO6A=
X-Received: by 2002:a17:906:82cd:: with SMTP id a13mr35452532ejy.229.1625054963078;
 Wed, 30 Jun 2021 05:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210629072941.7980-1-peng.fan@oss.nxp.com> <CAHCN7xJgqRfg1sHNbcpdEFaLHUwhYxe7_r5SEMDqSaCPFXX7UQ@mail.gmail.com>
 <DB6PR0402MB2760B05081D54D775B8949CA88019@DB6PR0402MB2760.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR0402MB2760B05081D54D775B8949CA88019@DB6PR0402MB2760.eurprd04.prod.outlook.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 30 Jun 2021 07:09:11 -0500
Message-ID: <CAHCN7xL6Rr41fHaaPwi6OA5Du8x09EHcE-bWyiGpz0pVn74jeQ@mail.gmail.com>
Subject: Re: [PATCH V8 0/4] soc: imx: add i.MX BLK-CTL support
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
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
        Abel Vesa <abel.vesa@nxp.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 4:34 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> > Subject: Re: [PATCH V8 0/4] soc: imx: add i.MX BLK-CTL support
> >
> > On Tue, Jun 29, 2021 at 1:56 AM Peng Fan (OSS) <peng.fan@oss.nxp.com>
> > wrote:
> > >
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > V8:
> > > Revert one change in v7, force goto disable_clk for handshake when
> > > power on in patch 3 One minor update to use if{} else {}, not if{};
> > > if{}; in patch 3 Typo Hankshake->Handshake
> > >
> > I am using ATF, branch lf_v2.4, from the NXP code aurora repo with U-Boot
> > v2021.07-rc5
> >
> > I applied this patch against linux-next, I applied the pgc patches [1], and the
> > suggested power-domains to the otg1 and otg2 nodes.
> > I am able to boot the device and use USB, but with this applied, I cannot wake
> > from sleep.  If I revert this, the system wakes from sleep again.
>
> I just tried linux-next without this patch on iMX8MM EVK, suspend/resume
> not work. Per my last test, it works before. Not sure what changed in kernel.
>
> Which kernel are you using, any commit or git repo? I could try on imx8mm
> evk and debug the issue you see.

I used kernel-next,
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
commit 889bab4c367a0ef58208fd80fafa74bb6e2dca26 (tag: next-20210621)

I then applied the GPCv2 patch that Marek sent.  You were CC'd on the
e-mail from Marek, but I can forward the patch to you if you can't
find it.
I tested his patch and I was able to suspend-to-RAM and resume.
Once I was comfortable that it worked, I then applied your patch
series for the blk-ctl.
With the blk-ctl series applied, the suspend-resume stopped working.

adam
>
> Thanks,
> Peng.
>
> >
> > [1] -
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatch
> > work.kernel.org%2Fproject%2Flinux-arm-kernel%2Fpatch%2F202106041110
> > 05.6804-1-peng.fan%40oss.nxp.com%2F&amp;data=04%7C01%7Cpeng.fan%
> > 40nxp.com%7Caccded5458c049d67fa308d93b0182d9%7C686ea1d3bc2b4c6
> > fa92cd99c5c301635%7C0%7C0%7C637605699944911752%7CUnknown%7C
> > TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiL
> > CJXVCI6Mn0%3D%7C1000&amp;sdata=Kf6orRXmScWHDTgD2FOV8OBsgG0p
> > GVs1byVZTHT0gVI%3D&amp;reserved=0
> >
> > I have not enabled video, GPU, VPU nor CSI.
> >
> > Just in case there might be a power-domain dependency missing, here is my
> > power-domain dump:
> >
> > root@beacon-imx8mm-kit:~# cat
> > /sys/kernel/debug/pm_genpd/pm_genpd_summary
> > domain                          status          children
> >             performance
> >     /device                                             runtime
> > status
> > ---------------------------------------------------------------------------------------------
> > -
> > vpu-h1                          off-0
> >             0
> >
> > VPU_BLK_CTL_H1
> >     /devices/genpd:3:imx-vpumix-blk-ctl.2               suspended
> >             0
> > vpu-g2                          off-0
> >             0
> >
> > VPU_BLK_CTL_G2
> >     /devices/genpd:2:imx-vpumix-blk-ctl.0               suspended
> >             0
> > vpu-g1                          off-0
> >             0
> >
> > VPU_BLK_CTL_G1
> >     /devices/genpd:1:imx-vpumix-blk-ctl.1               suspended
> >             0
> > mipi                            off-0
> >             0
> >                                                 MIPI_DSI,
> > MIPI_CSI
> >     /devices/genpd:1:imx-dispmix-blk-ctl.2              suspended
> >             0
> >     /devices/genpd:1:imx-dispmix-blk-ctl.3              suspended
> >             0
> > vpumix                          off-0
> >             0
> >
> > VPU_BLK_CTL_BUS
> >     /devices/genpd:0:imx-vpumix-blk-ctl.3               suspended
> >             0
> > gpu                             off-0
> >             0
> > VPU_BLK_CTL_BUS                 off-0
> >             0
> >
> > /devices/platform/soc@0/30000000.bus/303a0000.gpc/imx-pgc-domain.7
> >  suspended                  0
> >
> > /devices/platform/soc@0/30000000.bus/303a0000.gpc/imx-pgc-domain.8
> >  suspended                  0
> >
> > /devices/platform/soc@0/30000000.bus/303a0000.gpc/imx-pgc-domain.9
> >  suspended                  0
> > VPU_BLK_CTL_H1                  off-0
> >             0
> > VPU_BLK_CTL_G1                  off-0
> >             0
> > VPU_BLK_CTL_G2                  off-0
> >             0
> > DISPMIX_BUS                     off-0
> >             0
> >                                                 CSI_BRIDGE,
> > LCDIF
> >
> > /devices/platform/soc@0/30000000.bus/303a0000.gpc/imx-pgc-domain.11
> >  suspended                  0
> > MIPI_CSI                        off-0
> >             0
> > MIPI_DSI                        off-0
> >             0
> > LCDIF                           off-0
> >             0
> > CSI_BRIDGE                      off-0
> >             0
> > dispmix                         off-0
> >             0
> >                                                 DISPMIX_BUS
> >     /devices/genpd:0:imx-dispmix-blk-ctl.4              suspended
> >             0
> > gpumix                          off-0
> >             0
> >
> > /devices/platform/soc@0/30000000.bus/303a0000.gpc/imx-pgc-domain.5
> >  suspended                  0
> > usb-otg2                        on
> >             0
> >     /devices/platform/soc@0/32c00000.bus/32e50000.usb   active
> >             0
> > usb-otg1                        on
> >             0
> >     /devices/platform/soc@0/32c00000.bus/32e40000.usb   active
> >             0
> > pcie                            off-0
> >             0
> > hsiomix                         on
> >             0
> >
> > /devices/platform/soc@0/30000000.bus/303a0000.gpc/imx-pgc-domain.1
> >  suspended                  0
> >
> > /devices/platform/soc@0/30000000.bus/303a0000.gpc/imx-pgc-domain.2
> >  active                     0
> >
> > /devices/platform/soc@0/30000000.bus/303a0000.gpc/imx-pgc-domain.3
> >  active                     0
> >
> >
> >
> > > V7:
> > >  patch 2: update patch title per Shawn  Patch 3: Addressed several
> > > comments from Shawn
> > >
> > > V6:
> > >  Thanks for Adam's report on V5.
> > >  Resolve the error message dump, it is the child device reuse  the
> > > parent device node and matches the parent driver.
> > >  Filled the remove function for child device.
> > >  A diff dts file for upstream:
> > >
> > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgist
> > > .github.com%2FMrVan%2Fd73888d8273c43ea4a3b28fa668ca1d0&amp;dat
> > a=04%7C0
> > >
> > 1%7Cpeng.fan%40nxp.com%7Caccded5458c049d67fa308d93b0182d9%7C68
> > 6ea1d3bc
> > >
> > 2b4c6fa92cd99c5c301635%7C0%7C0%7C637605699944911752%7CUnknow
> > n%7CTWFpbG
> > >
> > Zsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> > Mn0%
> > >
> > 3D%7C1000&amp;sdata=9FcnPd4nwmdjOqrQCTz0YNgUmVQ9UzTHpfh33LKI
> > 7cs%3D&amp
> > > ;reserved=0
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
> > IMX8MM_BLK_CTL_PD_DISPMIX_BUS>;
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
> > >   dt-bindings: soc: imx: Add bindings for i.MX BLK_CTL
> > >   soc: imx: Add generic blk-ctl driver
> > >   soc: imx: Add blk-ctl driver for i.MX8MM
> > >
> > >  .../bindings/soc/imx/fsl,imx-blk-ctl.yaml     |  66 ++++
> > >  drivers/soc/imx/Makefile                      |   2 +-
> > >  drivers/soc/imx/blk-ctl-imx8mm.c              | 139 ++++++++
> > >  drivers/soc/imx/blk-ctl.c                     | 324
> > ++++++++++++++++++
> > >  drivers/soc/imx/blk-ctl.h                     |  85 +++++
> > >  include/dt-bindings/power/imx8mm-power.h      |  13 +
> > >  6 files changed, 628 insertions(+), 1 deletion(-)  create mode 100644
> > > Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml
> > >  create mode 100644 drivers/soc/imx/blk-ctl-imx8mm.c  create mode
> > > 100644 drivers/soc/imx/blk-ctl.c  create mode 100644
> > > drivers/soc/imx/blk-ctl.h
> > >
> > > --
> > > 2.30.0
> > >
