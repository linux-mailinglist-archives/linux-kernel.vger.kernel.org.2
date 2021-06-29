Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B523B732C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 15:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbhF2N3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 09:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233740AbhF2N3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 09:29:00 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34655C061760;
        Tue, 29 Jun 2021 06:26:33 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id hc16so36241643ejc.12;
        Tue, 29 Jun 2021 06:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=alp5Rs6ufuMB+U+q2SiDjHhgcKxmZ6MRG5/l4Oncua8=;
        b=KiTmyj7dltLgKJch4dIu77FSDgIH2jK7FtjNer3diKDEml/9SSC+5zlBiIyW0h+x8A
         wfGFpTvH4j5M3KaeV81EWZvOErp62XwKp5LdKoDVTSkmnthG73pSF6fflgyFDDDHdi3X
         3ho/9VaE1jnKavAmyGtxhNNm5Pib+tjuksjuK9sfksp81+HwfYtXy+QIaZOEBss7ccWq
         hyx87Zd9WkFwke//d1PxBUiSSz1jhzvfFg2eYymCeAzVpbTNSr2k51YWj9dGdQGrhksu
         UrWQGPUGIrk7eUYqmpYyUAN0RBewI4Ln/kesaAjsiN2qx2vsLeLsWmrV9YlXzSORBgqL
         17mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=alp5Rs6ufuMB+U+q2SiDjHhgcKxmZ6MRG5/l4Oncua8=;
        b=SKw8ZVJ1kVi37AvzA5PLzqfsOUpV0iuDMhEZQCFEFPW505vBxmwcBQ1JD+RdG4DSui
         7ge9E9bO8ENEoScUTBQIbFURU9eQsPrm4WaSH+hP5XHpw+IJxJjfC5+Ce5tBJdmRCCI9
         vlGZzzId3lL10Bn9UocS2JI4szzatGwmK+5sBrctTz+wKJGS/0afG4mSNjd68vWI/prF
         JvAaLodhCA/LAVgF3IqtjomQCwSnQ9+i5dRwZfOHvcOcGJMcOQhOLoCRmRo3OpJnuIHT
         aal7IzzikfTUcADgm1y+Q2j67CXuUIdNPQu9JcH2zzVw8CZd58glqOWfSSvCcdb1xHP1
         q0Ng==
X-Gm-Message-State: AOAM532ES2mlSQztXQbgZEeBluST0B0xUr3v98dq562gPXXBBPB0JTXb
        F3EbXGYnqTV+EVoHh6bd+mMHAPQPDZ9Mc3KcSj0=
X-Google-Smtp-Source: ABdhPJxJK1GbpBP3klx9fAw+c/VEhMUYXYvvM/+S/lUY66qwmjXOlSyXhqy2byp3/17mDevfWrTj0JAa1h5Kz6JA+qU=
X-Received: by 2002:a17:906:1c5b:: with SMTP id l27mr6113804ejg.40.1624973191360;
 Tue, 29 Jun 2021 06:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210629072941.7980-1-peng.fan@oss.nxp.com>
In-Reply-To: <20210629072941.7980-1-peng.fan@oss.nxp.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 29 Jun 2021 08:26:20 -0500
Message-ID: <CAHCN7xJgqRfg1sHNbcpdEFaLHUwhYxe7_r5SEMDqSaCPFXX7UQ@mail.gmail.com>
Subject: Re: [PATCH V8 0/4] soc: imx: add i.MX BLK-CTL support
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
        Abel Vesa <abel.vesa@nxp.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 1:56 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> V8:
> Revert one change in v7, force goto disable_clk for handshake when power on in patch 3
> One minor update to use if{} else {}, not if{}; if{}; in patch 3
> Typo Hankshake->Handshake
>
I am using ATF, branch lf_v2.4, from the NXP code aurora repo with
U-Boot v2021.07-rc5

I applied this patch against linux-next, I applied the pgc patches
[1], and the suggested power-domains to the otg1 and otg2 nodes.
I am able to boot the device and use USB, but with this applied, I
cannot wake from sleep.  If I revert this, the system wakes from sleep
again.

[1] - https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210604111005.6804-1-peng.fan@oss.nxp.com/

I have not enabled video, GPU, VPU nor CSI.

Just in case there might be a power-domain dependency missing, here is
my power-domain dump:

root@beacon-imx8mm-kit:~# cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
domain                          status          children
            performance
    /device                                             runtime status
----------------------------------------------------------------------------------------------
vpu-h1                          off-0
            0
                                                VPU_BLK_CTL_H1
    /devices/genpd:3:imx-vpumix-blk-ctl.2               suspended
            0
vpu-g2                          off-0
            0
                                                VPU_BLK_CTL_G2
    /devices/genpd:2:imx-vpumix-blk-ctl.0               suspended
            0
vpu-g1                          off-0
            0
                                                VPU_BLK_CTL_G1
    /devices/genpd:1:imx-vpumix-blk-ctl.1               suspended
            0
mipi                            off-0
            0
                                                MIPI_DSI, MIPI_CSI
    /devices/genpd:1:imx-dispmix-blk-ctl.2              suspended
            0
    /devices/genpd:1:imx-dispmix-blk-ctl.3              suspended
            0
vpumix                          off-0
            0
                                                VPU_BLK_CTL_BUS
    /devices/genpd:0:imx-vpumix-blk-ctl.3               suspended
            0
gpu                             off-0
            0
VPU_BLK_CTL_BUS                 off-0
            0
    /devices/platform/soc@0/30000000.bus/303a0000.gpc/imx-pgc-domain.7
 suspended                  0
    /devices/platform/soc@0/30000000.bus/303a0000.gpc/imx-pgc-domain.8
 suspended                  0
    /devices/platform/soc@0/30000000.bus/303a0000.gpc/imx-pgc-domain.9
 suspended                  0
VPU_BLK_CTL_H1                  off-0
            0
VPU_BLK_CTL_G1                  off-0
            0
VPU_BLK_CTL_G2                  off-0
            0
DISPMIX_BUS                     off-0
            0
                                                CSI_BRIDGE, LCDIF
    /devices/platform/soc@0/30000000.bus/303a0000.gpc/imx-pgc-domain.11
 suspended                  0
MIPI_CSI                        off-0
            0
MIPI_DSI                        off-0
            0
LCDIF                           off-0
            0
CSI_BRIDGE                      off-0
            0
dispmix                         off-0
            0
                                                DISPMIX_BUS
    /devices/genpd:0:imx-dispmix-blk-ctl.4              suspended
            0
gpumix                          off-0
            0
    /devices/platform/soc@0/30000000.bus/303a0000.gpc/imx-pgc-domain.5
 suspended                  0
usb-otg2                        on
            0
    /devices/platform/soc@0/32c00000.bus/32e50000.usb   active
            0
usb-otg1                        on
            0
    /devices/platform/soc@0/32c00000.bus/32e40000.usb   active
            0
pcie                            off-0
            0
hsiomix                         on
            0
    /devices/platform/soc@0/30000000.bus/303a0000.gpc/imx-pgc-domain.1
 suspended                  0
    /devices/platform/soc@0/30000000.bus/303a0000.gpc/imx-pgc-domain.2
 active                     0
    /devices/platform/soc@0/30000000.bus/303a0000.gpc/imx-pgc-domain.3
 active                     0



> V7:
>  patch 2: update patch title per Shawn
>  Patch 3: Addressed several comments from Shawn
>
> V6:
>  Thanks for Adam's report on V5.
>  Resolve the error message dump, it is the child device reuse
>  the parent device node and matches the parent driver.
>  Filled the remove function for child device.
>  A diff dts file for upstream:
>  https://gist.github.com/MrVan/d73888d8273c43ea4a3b28fa668ca1d0
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
>   dt-bindings: soc: imx: Add bindings for i.MX BLK_CTL
>   soc: imx: Add generic blk-ctl driver
>   soc: imx: Add blk-ctl driver for i.MX8MM
>
>  .../bindings/soc/imx/fsl,imx-blk-ctl.yaml     |  66 ++++
>  drivers/soc/imx/Makefile                      |   2 +-
>  drivers/soc/imx/blk-ctl-imx8mm.c              | 139 ++++++++
>  drivers/soc/imx/blk-ctl.c                     | 324 ++++++++++++++++++
>  drivers/soc/imx/blk-ctl.h                     |  85 +++++
>  include/dt-bindings/power/imx8mm-power.h      |  13 +
>  6 files changed, 628 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml
>  create mode 100644 drivers/soc/imx/blk-ctl-imx8mm.c
>  create mode 100644 drivers/soc/imx/blk-ctl.c
>  create mode 100644 drivers/soc/imx/blk-ctl.h
>
> --
> 2.30.0
>
