Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195FE332452
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 12:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhCILoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 06:44:02 -0500
Received: from inva020.nxp.com ([92.121.34.13]:44138 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229691AbhCILne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 06:43:34 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 372851A0FB9;
        Tue,  9 Mar 2021 12:43:33 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1EAB91A00E2;
        Tue,  9 Mar 2021 12:43:33 +0100 (CET)
Received: from localhost (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 07708203C5;
        Tue,  9 Mar 2021 12:43:32 +0100 (CET)
Date:   Tue, 9 Mar 2021 13:43:32 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Martin Kepplinger <martink@posteo.de>
Cc:     Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Georgi Djakov <djakov@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "kernel@puri.sm" <kernel@puri.sm>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [RFC 00/19] Rework support for i.MX8MQ interconnect with devfreq
Message-ID: <20210309114332.5ozhjgoiz7a3xcut@fsr-ub1664-175>
References: <1613750416-11901-1-git-send-email-abel.vesa@nxp.com>
 <a2b651de-77a7-2a40-7e51-d0098e4b804b@posteo.de>
 <20210223172013.tsip6uiuwtfnmqav@fsr-ub1664-175>
 <315c1ad8-6274-3654-a410-5d78e35a90fe@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <315c1ad8-6274-3654-a410-5d78e35a90fe@posteo.de>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-02-25 13:13:17, Martin Kepplinger wrote:
> On 23.02.21 18:20, Abel Vesa wrote:
> > On 21-02-22 17:03:13, Martin Kepplinger wrote:
> > > On 19.02.21 16:59, Abel Vesa wrote:
> > > > This has been on my queue for quite some time now. It is more of a
> > > > proof-of-concept.
> > > > 
> > > > This rework is done with the compatibility of future i.MX platforms in
> > > > mind. For example, the i.MX8MP platform has multiple NoCs. This
> > > > patchsets prepares the imx interconnect and imx devfreq for that too.
> > > > 
> > > > As of now, none of the drivers involved are being used and there is no
> > > > icc consumer on any off the i.MX platforms.
> > > > 
> > > > Basically, the steps taken here are the following:
> > > > 
> > > > 1. Make the dram_apb clock "reparantable" from kernel.
> > > > This is needed in order to keep track of the actual parent of the
> > > > dram_apb clock in the kernel clock hierarchy. Note that the actual
> > > > switch is done EL3 (TF-A).
> > > > 
> > > > 2. Rework the imx-bus so the actual link between the icc and the
> > > > NoCs or the pl301s is not tightly coupled. This allows us to have
> > > > as many NoCs as necessary but also allows as to use the same driver
> > > > for the pl301s. The pl301s have their own clocks too, so we need to
> > > > reduce their rates too.
> > > > 
> > > > 3. Rework the imx8m-ddrc driver. Remove the support for dts defined
> > > > OPPs. The EL3 provides those. So instead of havingi to keep the OPP table in
> > > > both EL3 and kernel in sync, we rely on what the EL3 gives us.
> > > > Also, when the platform suspends, the bus needs to be running at highest
> > > > rate, otherwise there is a chance it might not resume anymore.
> > > > By adding the late system sleep PM ops we can handle that easily.
> > > > 
> > > > 4. Rework the imx interconnect driver to use the fsl,icc-id instead
> > > > of the robust imx_icc_node_adj_desc for linking with the target node.
> > > > By adding the fsl,icc-id property to all the NoC and pl301 dts nodes,
> > > > we can link each icc node to their corresponding NoC, pl301 or dram.
> > > > Basically, when the imx interconnect platform specific driver probes,
> > > > it will take each node defined for that platform and look-up the
> > > > corresponding dts node based on the id and add that as the qos device.
> > > > 
> > > > 5. Added the fec and usdhc as icc consumers. This is just as an example.
> > > > All the other consumers can be added later. Basically, each consumer
> > > > will add a path to their device node and in the driver will have to
> > > > handle that icc path accordingly.
> > > > 
> > > 
> > > thanks for working on this Abel,
> > > 
> > > It looks like the icc path requests don't work for me:
> > > 
> > > when applying this onto v5.11 (without any other workaround in that area,
> > > but some out-of-tree icc-requests like in mxsfb) my rootfs isn't being
> > > mounted anymore. Since you add icc requests to the usdhc driver, there could
> > > be something wrong.
> > > 
> > > So I revert 19/19 ("mmc: sdhci-esdhc-imx: Add interconnect support") and
> > > then my imx8mq (Librem 5) rootfs system boots, but all frequencies stay at
> > > the minimum (despite the icc request like this:
> > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fsource.puri.sm%2Fmartin.kepplinger%2Flinux-next%2F-%2Fcommit%2F1692de27d1475c53574dd7359c68ba613e0fea10&amp;data=04%7C01%7Cabel.vesa%40nxp.com%7C9e5a3fe7a3af4aabb84f08d8d986c042%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637498520072719555%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=9ItFarG22Tr%2Bj5MPmZU5xnMc%2B1Sx0o3563L5gdceIi4%3D&amp;reserved=0
> > > so I can't use the display).
> > > 
> > > What could be missing? As I said I'm trying on top of v5.11, (at least I
> > > have the NOC node described:
> > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fsource.puri.sm%2Fmartin.kepplinger%2Flinux-next%2F-%2Fcommit%2F1d74a24c9944d1bf618abdd57d24101368cc8df0&amp;data=04%7C01%7Cabel.vesa%40nxp.com%7C9e5a3fe7a3af4aabb84f08d8d986c042%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637498520072719555%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=dX%2BM7jyyg3SzhtE3Q1QUfVkmbbzg70A57DHndDQ4KcI%3D&amp;reserved=0
> > > and (with the revert from
> > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-arm-kernel%2F20210104120512.gmi2zjz7dzhjussp%40fsr-ub1664-175%2F&amp;data=04%7C01%7Cabel.vesa%40nxp.com%7C9e5a3fe7a3af4aabb84f08d8d986c042%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637498520072719555%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=HBVSYJHqLEheNckGyNRf2kDVfVCRoX9zs%2BXO9si8WMw%3D&amp;reserved=0
> > > devfreq works without your patchset ) Is there anything I'm missing that is
> > > not yet merged in v5.11?
> > > 
> > > Can I test anything else that would help?
> > > 
> > 
> > Sorry about this, I messed up the usdhc change.
> > I tested mostly with nfs rootfs.
> > 
> > I'll just paste here the things that are missing in order for the USHCs to work.
> > I'll fold them in the next version of this patch set.
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > index 43760316052f..90398408b55e 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > @@ -1637,6 +1637,25 @@ opp-133M {
> >                          };
> >                  };
> > +               pl301_per_m: pl301@9 {
> > +                       compatible = "fsl,imx8m-nic";
> > +                       clocks = <&clk IMX8MQ_CLK_NAND_USDHC_BUS>;
> > +                       operating-points-v2 = <&pl301_per_m_opp_table>;
> > +                       #interconnect-cells = <0>;
> > +                       fsl,icc-id = <IMX8MQ_ICN_PER_M>;
> > +
> > +                       pl301_per_m_opp_table: opp-table {
> > +                               compatible = "operating-points-v2";
> > +
> > +                               opp-25M {
> > +                                       opp-hz = /bits/ 64 <25000000>;
> > +                               };
> > +                               opp-133M {
> > +                                       opp-hz = /bits/ 64 <133333333>;
> > +                               };
> > +                       };
> > +               };
> > +
> >                  icc: interconnect@0 {
> >                          compatible = "fsl,imx8mq-icc", "fsl,imx8m-icc";
> >                          #interconnect-cells = <1>;
> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> > index 65c5caf82e0c..cb8d341faf71 100644
> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > @@ -1545,7 +1545,8 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
> >          imx_data->bus_path = devm_of_icc_get(&pdev->dev, "path");
> >          if (IS_ERR(imx_data->bus_path)) {
> > -               return PTR_ERR(imx_data->bus_path);
> > +               err = PTR_ERR(imx_data->bus_path);
> > +               goto free_sdhci;
> >          } else if (imx_data->bus_path) {
> >                  if (of_property_read_u32(pdev->dev.of_node, "fsl,icc-rate", &imx_data->bus_rate)) {
> >                          dev_err(&pdev->dev, "icc-rate missing\n");
> > 
> 
> when simply booting with this instead of my revert, turning on *all* kernel
> debug output, startup stops here:
> 
> [  191.157686] devices_kset: Moving 30b50000.mmc to end of list
> [  191.163388] PM: Moving platform:30b50000.mmc to end of list
> [  191.169003] platform 30b50000.mmc: Retrying from deferred list
> [  191.175305] platform 30b50000.mmc: scheduling asynchronous probe
> [  191.181394] devices_kset: Moving 30b40000.mmc to end of list
> [  191.181493] bus: 'platform': driver_probe_device: matched device
> 30b50000.mmc with driver sdhci-esdhc-imx
> [  191.187096] PM: Moving platform:30b40000.mmc to end of list
> [  191.196706] bus: 'platform': really_probe: probing driver sdhci-esdhc-imx
> with device 30b50000.mmc
> [  191.202270] platform 30b40000.mmc: Retrying from deferred list
> [  191.211361] imx8mq-pinctrl 30330000.pinctrl: maps: function pinctrl group
> usdhc2grp num 9
> [  191.217169] platform 30b40000.mmc: scheduling asynchronous probe
> [  191.225259] pinctrl core: add 9 pinctrl maps
> 
> or here:
> 
> [  185.726775] devices_kset: Moving 30b40000.mmc to end of list
> [  185.732476] PM: Moving platform:30b40000.mmc to end of list
> [  185.738090] platform 30b40000.mmc: Retrying from deferred list
> [  185.744453] platform 30b40000.mmc: scheduling asynchronous probe
> [  185.750541] devices_kset: Moving leds to end of list
> [  185.750660] bus: 'platform': driver_probe_device: matched device
> 30b40000.mmc with driver sdhci-esdhc-imx
> [  185.755556] PM: Moving platform:leds to end of list
> [  185.755575] platform leds: Retrying from deferred list
> [  185.765180] bus: 'platform': really_probe: probing driver sdhci-esdhc-imx
> with device 30b40000.mmc
> [  185.770120] bus: 'platform': driver_probe_device: matched device leds
> with driver leds-gpio
> [  185.775525] imx8mq-pinctrl 30330000.pinctrl: maps: function pinctrl group
> usdhc1grp num 13
> [  185.784200] bus: 'platform': really_probe: probing driver leds-gpio with
> device leds
> [  185.792619] pinctrl core: add 13 pinctrl maps
> [  185.800915] imx8mq-pinctrl 30330000.pinctrl: maps: function pinctrl group
> hubnresetgrp num 2
> [  185.808672] imx8mq-pinctrl 30330000.pinctrl: maps: function pinctrl group
> usdhc1grp100mhz num 13
> [  185.813001] pinctrl core: add 2 pinctrl maps
> [  185.821471] pinctrl core: add 13 pinctrl maps
> [  185.830275] imx8mq-pinctrl 30330000.pinctrl: maps: function pinctrl group
> sdpwrgrp num 2
> [  185.834578] imx8mq-pinctrl 30330000.pinctrl: maps: function pinctrl group
> usdhc1grp200mhz num 13
> [  185.838942] pinctrl core: add 2 pinctrl maps
> [  185.847080] pinctrl core: add 13 pinctrl maps
> [  185.855854] imx8mq-pinctrl 30330000.pinctrl: maps: function pinctrl group
> chargergrp num 2
> [  185.860154] imx8mq-pinctrl 30330000.pinctrl: found group selector 50 for
> usdhc1grp
> [  185.864480] pinctrl core: add 2 pinctrl maps
> [  185.872864] imx8mq-pinctrl 30330000.pinctrl: found group selector 51 for
> usdhc1grp100mhz
> [  185.887696] thermal thermal_zone0:
> Trip0[type=1,temp=50000]:trend=0,throttle=1
> [  185.892835] imx8mq-pinctrl 30330000.pinctrl: found group selector 52 for
> usdhc1grp200mhz
> [  185.899966] thermal cooling_device5: cur_state=1
> [  185.908180] sdhci-esdhc-imx 30b40000.mmc: no init pinctrl state
> [  185.908208] imx8mq-pinctrl 30330000.pinctrl: maps: function pinctrl group
> smcgrp num 2
> 

Give this one a try:

https://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/log/?h=imx8mq/icc_devfreq

