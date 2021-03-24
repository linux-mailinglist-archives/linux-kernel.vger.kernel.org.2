Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9ECA34732C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 09:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236029AbhCXIEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 04:04:34 -0400
Received: from mout01.posteo.de ([185.67.36.65]:52138 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235974AbhCXID7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 04:03:59 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 92D431600B7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 09:03:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1616573027; bh=3t45fxXQ6ntD0W/R8JAOK2aQTN8DtZF2aaK1kmZTb7Q=;
        h=Subject:From:To:Cc:Date:From;
        b=YYz8//pAQhnpbbtCuBO9juwQTN1dccEB7SWpNYVfmCzxGJuUze7Czztz5+IjlehCJ
         RaK2SzBm6p2keP6kieWu4eIeW84Bdv5pZgpQdNhaIaLPsvZLWc8LBvMDnts/MOVw39
         hvDVZuQL4+ySoaasTY3QtoQLPFFMmIPmvofo3kB//UpzKwjB20WRPlH2H8M55QvMfp
         MCJu/XGp5q+a/HvPKwL7+tGio0I62rSDugIqNDrZBwxYnmsBOC9JIbgDqhW+JW+GZ6
         o018JqTi9HKv3drXmgz/qkuW6/8ojR/OUUzxGGePVoZ/WBPEYLHBxjFVPHT6w4YN/9
         qiAt2Su15o/cg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4F512l2CBSz6tmT;
        Wed, 24 Mar 2021 09:03:43 +0100 (CET)
Message-ID: <ffc95063330a3ede480d444aea4aae9a22e1018e.camel@posteo.de>
Subject: Re: [RFC 00/19] Rework support for i.MX8MQ interconnect with devfreq
From:   Martin Kepplinger <martink@posteo.de>
To:     Abel Vesa <abel.vesa@nxp.com>
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
Date:   Wed, 24 Mar 2021 09:03:42 +0100
In-Reply-To: <20210309114332.5ozhjgoiz7a3xcut@fsr-ub1664-175>
References: <1613750416-11901-1-git-send-email-abel.vesa@nxp.com>
         <a2b651de-77a7-2a40-7e51-d0098e4b804b@posteo.de>
         <20210223172013.tsip6uiuwtfnmqav@fsr-ub1664-175>
         <315c1ad8-6274-3654-a410-5d78e35a90fe@posteo.de>
         <20210309114332.5ozhjgoiz7a3xcut@fsr-ub1664-175>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, dem 09.03.2021 um 13:43 +0200 schrieb Abel Vesa:
> On 21-02-25 13:13:17, Martin Kepplinger wrote:
> > On 23.02.21 18:20, Abel Vesa wrote:
> > > On 21-02-22 17:03:13, Martin Kepplinger wrote:
> > > > On 19.02.21 16:59, Abel Vesa wrote:
> > > > > This has been on my queue for quite some time now. It is more
> > > > > of a
> > > > > proof-of-concept.
> > > > > 
> > > > > This rework is done with the compatibility of future i.MX
> > > > > platforms in
> > > > > mind. For example, the i.MX8MP platform has multiple NoCs.
> > > > > This
> > > > > patchsets prepares the imx interconnect and imx devfreq for
> > > > > that too.
> > > > > 
> > > > > As of now, none of the drivers involved are being used and
> > > > > there is no
> > > > > icc consumer on any off the i.MX platforms.
> > > > > 
> > > > > Basically, the steps taken here are the following:
> > > > > 
> > > > > 1. Make the dram_apb clock "reparantable" from kernel.
> > > > > This is needed in order to keep track of the actual parent of
> > > > > the
> > > > > dram_apb clock in the kernel clock hierarchy. Note that the
> > > > > actual
> > > > > switch is done EL3 (TF-A).
> > > > > 
> > > > > 2. Rework the imx-bus so the actual link between the icc and
> > > > > the
> > > > > NoCs or the pl301s is not tightly coupled. This allows us to
> > > > > have
> > > > > as many NoCs as necessary but also allows as to use the same
> > > > > driver
> > > > > for the pl301s. The pl301s have their own clocks too, so we
> > > > > need to
> > > > > reduce their rates too.
> > > > > 
> > > > > 3. Rework the imx8m-ddrc driver. Remove the support for dts
> > > > > defined
> > > > > OPPs. The EL3 provides those. So instead of havingi to keep
> > > > > the OPP table in
> > > > > both EL3 and kernel in sync, we rely on what the EL3 gives
> > > > > us.
> > > > > Also, when the platform suspends, the bus needs to be running
> > > > > at highest
> > > > > rate, otherwise there is a chance it might not resume
> > > > > anymore.
> > > > > By adding the late system sleep PM ops we can handle that
> > > > > easily.
> > > > > 
> > > > > 4. Rework the imx interconnect driver to use the fsl,icc-id
> > > > > instead
> > > > > of the robust imx_icc_node_adj_desc for linking with the
> > > > > target node.
> > > > > By adding the fsl,icc-id property to all the NoC and pl301
> > > > > dts nodes,
> > > > > we can link each icc node to their corresponding NoC, pl301
> > > > > or dram.
> > > > > Basically, when the imx interconnect platform specific driver
> > > > > probes,
> > > > > it will take each node defined for that platform and look-up
> > > > > the
> > > > > corresponding dts node based on the id and add that as the
> > > > > qos device.
> > > > > 
> > > > > 5. Added the fec and usdhc as icc consumers. This is just as
> > > > > an example.
> > > > > All the other consumers can be added later. Basically, each
> > > > > consumer
> > > > > will add a path to their device node and in the driver will
> > > > > have to
> > > > > handle that icc path accordingly.
> > > > > 
> > > > 
> > > > thanks for working on this Abel,
> > > > 
> > > > It looks like the icc path requests don't work for me:
> > > > 
> > > > when applying this onto v5.11 (without any other workaround in
> > > > that area,
> > > > but some out-of-tree icc-requests like in mxsfb) my rootfs
> > > > isn't being
> > > > mounted anymore. Since you add icc requests to the usdhc
> > > > driver, there could
> > > > be something wrong.
> > > > 
> > > > So I revert 19/19 ("mmc: sdhci-esdhc-imx: Add interconnect
> > > > support") and
> > > > then my imx8mq (Librem 5) rootfs system boots, but all
> > > > frequencies stay at
> > > > the minimum (despite the icc request like this:
> > > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fsource.puri.sm%2Fmartin.kepplinger%2Flinux-next%2F-%2Fcommit%2F1692de27d1475c53574dd7359c68ba613e0fea10&amp;data=04%7C01%7Cabel.vesa%40nxp.com%7C9e5a3fe7a3af4aabb84f08d8d986c042%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637498520072719555%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=9ItFarG22Tr%2Bj5MPmZU5xnMc%2B1Sx0o3563L5gdceIi4%3D&amp;reserved=0
> > > > so I can't use the display).
> > > > 
> > > > What could be missing? As I said I'm trying on top of v5.11,
> > > > (at least I
> > > > have the NOC node described:
> > > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fsource.puri.sm%2Fmartin.kepplinger%2Flinux-next%2F-%2Fcommit%2F1d74a24c9944d1bf618abdd57d24101368cc8df0&amp;data=04%7C01%7Cabel.vesa%40nxp.com%7C9e5a3fe7a3af4aabb84f08d8d986c042%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637498520072719555%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=dX%2BM7jyyg3SzhtE3Q1QUfVkmbbzg70A57DHndDQ4KcI%3D&amp;reserved=0
> > > > and (with the revert from
> > > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-arm-kernel%2F20210104120512.gmi2zjz7dzhjussp%40fsr-ub1664-175%2F&amp;data=04%7C01%7Cabel.vesa%40nxp.com%7C9e5a3fe7a3af4aabb84f08d8d986c042%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637498520072719555%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=HBVSYJHqLEheNckGyNRf2kDVfVCRoX9zs%2BXO9si8WMw%3D&amp;reserved=0
> > > > devfreq works without your patchset ) Is there anything I'm
> > > > missing that is
> > > > not yet merged in v5.11?
> > > > 
> > > > Can I test anything else that would help?
> > > > 
> > > 
> > > Sorry about this, I messed up the usdhc change.
> > > I tested mostly with nfs rootfs.
> > > 
> > > I'll just paste here the things that are missing in order for the
> > > USHCs to work.
> > > I'll fold them in the next version of this patch set.
> > > 
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > > b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > > index 43760316052f..90398408b55e 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > > @@ -1637,6 +1637,25 @@ opp-133M {
> > >                          };
> > >                  };
> > > +               pl301_per_m: pl301@9 {
> > > +                       compatible = "fsl,imx8m-nic";
> > > +                       clocks = <&clk
> > > IMX8MQ_CLK_NAND_USDHC_BUS>;
> > > +                       operating-points-v2 =
> > > <&pl301_per_m_opp_table>;
> > > +                       #interconnect-cells = <0>;
> > > +                       fsl,icc-id = <IMX8MQ_ICN_PER_M>;
> > > +
> > > +                       pl301_per_m_opp_table: opp-table {
> > > +                               compatible = "operating-points-
> > > v2";
> > > +
> > > +                               opp-25M {
> > > +                                       opp-hz = /bits/ 64
> > > <25000000>;
> > > +                               };
> > > +                               opp-133M {
> > > +                                       opp-hz = /bits/ 64
> > > <133333333>;
> > > +                               };
> > > +                       };
> > > +               };
> > > +
> > >                  icc: interconnect@0 {
> > >                          compatible = "fsl,imx8mq-icc",
> > > "fsl,imx8m-icc";
> > >                          #interconnect-cells = <1>;
> > > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
> > > b/drivers/mmc/host/sdhci-esdhc-imx.c
> > > index 65c5caf82e0c..cb8d341faf71 100644
> > > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > > @@ -1545,7 +1545,8 @@ static int sdhci_esdhc_imx_probe(struct
> > > platform_device *pdev)
> > >          imx_data->bus_path = devm_of_icc_get(&pdev->dev,
> > > "path");
> > >          if (IS_ERR(imx_data->bus_path)) {
> > > -               return PTR_ERR(imx_data->bus_path);
> > > +               err = PTR_ERR(imx_data->bus_path);
> > > +               goto free_sdhci;
> > >          } else if (imx_data->bus_path) {
> > >                  if (of_property_read_u32(pdev->dev.of_node,
> > > "fsl,icc-rate", &imx_data->bus_rate)) {
> > >                          dev_err(&pdev->dev, "icc-rate
> > > missing\n");
> > > 
> > 
> > when simply booting with this instead of my revert, turning on
> > *all* kernel
> > debug output, startup stops here:
> > 
> > [  191.157686] devices_kset: Moving 30b50000.mmc to end of list
> > [  191.163388] PM: Moving platform:30b50000.mmc to end of list
> > [  191.169003] platform 30b50000.mmc: Retrying from deferred list
> > [  191.175305] platform 30b50000.mmc: scheduling asynchronous probe
> > [  191.181394] devices_kset: Moving 30b40000.mmc to end of list
> > [  191.181493] bus: 'platform': driver_probe_device: matched device
> > 30b50000.mmc with driver sdhci-esdhc-imx
> > [  191.187096] PM: Moving platform:30b40000.mmc to end of list
> > [  191.196706] bus: 'platform': really_probe: probing driver sdhci-
> > esdhc-imx
> > with device 30b50000.mmc
> > [  191.202270] platform 30b40000.mmc: Retrying from deferred list
> > [  191.211361] imx8mq-pinctrl 30330000.pinctrl: maps: function
> > pinctrl group
> > usdhc2grp num 9
> > [  191.217169] platform 30b40000.mmc: scheduling asynchronous probe
> > [  191.225259] pinctrl core: add 9 pinctrl maps
> > 
> > or here:
> > 
> > [  185.726775] devices_kset: Moving 30b40000.mmc to end of list
> > [  185.732476] PM: Moving platform:30b40000.mmc to end of list
> > [  185.738090] platform 30b40000.mmc: Retrying from deferred list
> > [  185.744453] platform 30b40000.mmc: scheduling asynchronous probe
> > [  185.750541] devices_kset: Moving leds to end of list
> > [  185.750660] bus: 'platform': driver_probe_device: matched device
> > 30b40000.mmc with driver sdhci-esdhc-imx
> > [  185.755556] PM: Moving platform:leds to end of list
> > [  185.755575] platform leds: Retrying from deferred list
> > [  185.765180] bus: 'platform': really_probe: probing driver sdhci-
> > esdhc-imx
> > with device 30b40000.mmc
> > [  185.770120] bus: 'platform': driver_probe_device: matched device
> > leds
> > with driver leds-gpio
> > [  185.775525] imx8mq-pinctrl 30330000.pinctrl: maps: function
> > pinctrl group
> > usdhc1grp num 13
> > [  185.784200] bus: 'platform': really_probe: probing driver leds-
> > gpio with
> > device leds
> > [  185.792619] pinctrl core: add 13 pinctrl maps
> > [  185.800915] imx8mq-pinctrl 30330000.pinctrl: maps: function
> > pinctrl group
> > hubnresetgrp num 2
> > [  185.808672] imx8mq-pinctrl 30330000.pinctrl: maps: function
> > pinctrl group
> > usdhc1grp100mhz num 13
> > [  185.813001] pinctrl core: add 2 pinctrl maps
> > [  185.821471] pinctrl core: add 13 pinctrl maps
> > [  185.830275] imx8mq-pinctrl 30330000.pinctrl: maps: function
> > pinctrl group
> > sdpwrgrp num 2
> > [  185.834578] imx8mq-pinctrl 30330000.pinctrl: maps: function
> > pinctrl group
> > usdhc1grp200mhz num 13
> > [  185.838942] pinctrl core: add 2 pinctrl maps
> > [  185.847080] pinctrl core: add 13 pinctrl maps
> > [  185.855854] imx8mq-pinctrl 30330000.pinctrl: maps: function
> > pinctrl group
> > chargergrp num 2
> > [  185.860154] imx8mq-pinctrl 30330000.pinctrl: found group
> > selector 50 for
> > usdhc1grp
> > [  185.864480] pinctrl core: add 2 pinctrl maps
> > [  185.872864] imx8mq-pinctrl 30330000.pinctrl: found group
> > selector 51 for
> > usdhc1grp100mhz
> > [  185.887696] thermal thermal_zone0:
> > Trip0[type=1,temp=50000]:trend=0,throttle=1
> > [  185.892835] imx8mq-pinctrl 30330000.pinctrl: found group
> > selector 52 for
> > usdhc1grp200mhz
> > [  185.899966] thermal cooling_device5: cur_state=1
> > [  185.908180] sdhci-esdhc-imx 30b40000.mmc: no init pinctrl state
> > [  185.908208] imx8mq-pinctrl 30330000.pinctrl: maps: function
> > pinctrl group
> > smcgrp num 2
> > 
> 
> Give this one a try:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/log/?h=imx8mq/icc_devfreq
> 

sorry this took a while. with this patchset booting still stops here
for me:

[    1.360301] i2c i2c-1: IMX I2C adapter registered
[    1.382796] i2c i2c-2: IMX I2C adapter registered
[    1.403487] i2c i2c-3: IMX I2C adapter registered
[    1.420996] led-backlight backlight-dsi: Not enough levels defined
[    1.442857] etnaviv etnaviv: bound 38000000.gpu (ops gpu_ops)
[    1.448713] etnaviv-gpu 38000000.gpu: model: GC7000, revision: 6214
[    1.457320] [drm] Initialized etnaviv 1.3.0 20151214 for etnaviv on
minor 0
[    1.471080] imx-cpufreq-dt imx-cpufreq-dt: cpu speed grade 3 mkt
segment 0 supported-hw 0x8 0x1

and *all* output enabled:



[  191.116154] thermal thermal_zone0:
Trip0[type=1,temp=50000]:trend=0,throttle=1
[  191.116164] thermal cooling_device5: cur_state=0
[  191.116171] thermal cooling_device5: old_target=-1, target=1
[  191.116182] thermal cooling_device5: zone0->target=1
[  191.116210] thermal cooling_device5: set to state 1
[  191.116228] thermal thermal_zone0:
Trip1[type=1,temp=60000]:trend=0,throttle=0
[  191.116241] thermal cooling_device0: cur_state=0
[  191.116249] thermal cooling_device0: old_target=-1, target=-1
[  191.116263] thermal cooling_device1: cur_state=0
[  191.116268] thermal cooling_device1: old_target=-1, target=-1
[  191.116281] thermal cooling_device2: cur_state=0
[  191.116290] thermal cooling_device2: old_target=-1, target=-1
[  191.116302] thermal cooling_device3: cur_state=0
[  191.116310] thermal cooling_device3: old_target=-1, target=-1
[  191.116322] cpufreq: initialization complete
[  191.116343] cpu cpu1: cpufreq_add_dev: adding CPU1
[  191.116353] cpufreq: cpufreq_online: bringing CPU1 online
[  191.116373] cpu cpu2: cpufreq_add_dev: adding CPU2
[  191.116382] cpufreq: cpufreq_online: bringing CPU2 online
[  191.116396] cpu cpu3: cpufreq_add_dev: adding CPU3
[  191.116405] cpufreq: cpufreq_online: bringing CPU3 online
[  191.116433] cpufreq: driver cpufreq-dt up and running
[  191.116447] driver: 'cpufreq-dt': driver_bound: bound to device
'cpufreq-dt'
[  191.116479] kobject: 'cpufreq-dt' ((____ptrval____)):
kobject_uevent_env
[  191.116497] kobject: 'cpufreq-dt' ((____ptrval____)):
fill_kobj_path: path = '/devices/platform/imx-cpufreq-dt/cpufreq-dt'
[  191.116518] bus: 'platform': really_probe: bound device cpufreq-dt
to driver cpufreq-dt
[  191.116558] driver: 'imx-cpufreq-dt': driver_bound: bound to device
'imx-cpufreq-dt'
[  191.116573] kobject: 'imx-cpufreq-dt' ((____ptrval____)):
kobject_uevent_env
[  191.116585] kobject: 'imx-cpufreq-dt' ((____ptrval____)):
fill_kobj_path: path = '/devices/platform/imx-cpufreq-dt'
[  191.116603] bus: 'platform': really_probe: bound device imx-cpufreq-
dt to driver imx-cpufreq-dt
[  191.116624] devices_kset: Moving leds to end of list
[  191.116637] PM: Moving platform:leds to end of list
[  191.116650] platform leds: Retrying from deferred list
[  191.116997] bus: 'platform': driver_probe_device: matched device
leds with driver leds-gpio
[  191.117022] bus: 'platform': really_probe: probing driver leds-gpio
with device leds
[  191.117146] imx8mq-pinctrl 30330000.pinctrl: maps: function pinctrl
group hubnresetgrp num 2
[  191.117164] pinctrl core: add 2 pinctrl maps
[  191.117247] imx8mq-pinctrl 30330000.pinctrl: maps: function pinctrl
group sdpwrgrp num 2
[  191.117261] pinctrl core: add 2 pinctrl maps
[  191.117283] imx8mq-pinctrl 30330000.pinctrl: maps: function pinctrl
group chargergrp num 2
[  191.117299] pinctrl core: add 2 pinctrl maps
[  191.117321] imx8mq-pinctrl 30330000.pinctrl: maps: function pinctrl
group smcgrp num 2
[  191.117337] pinctrl core: add 2 pinctrl maps
[  191.117362] imx8mq-pinctrl 30330000.pinctrl: maps: function pinctrl
group gnssgrp num 2
[  191.117383] pinctrl core: add 2 pinctrl maps
[  191.117445] imx8mq-pinctrl 30330000.pinctrl: maps: function pinctrl
group wwanpwrgrp num 2
[  191.117459] pinctrl core: add 2 pinctrl maps
[  191.117486] imx8mq-pinctrl 30330000.pinctrl: maps: function pinctrl
group wwangrp num 4
[  191.117497] pinctrl core: add 4 pinctrl maps
[  191.117562] imx8mq-pinctrl 30330000.pinctrl: found group selector 22
for hubnresetgrp
[  191.117604] imx8mq-pinctrl 30330000.pinctrl: found group selector 41
for sdpwrgrp
[  191.117617] imx8mq-pinctrl 30330000.pinctrl: found group selector 4
for chargergrp
[  191.117658] imx8mq-pinctrl 30330000.pinctrl: found group selector 42
for smcgrp
[  191.117671] imx8mq-pinctrl 30330000.pinctrl: found group selector 16
for gnssgrp
[  191.117707] imx8mq-pinctrl 30330000.pinctrl: found group selector 59
for wwanpwrgrp
[  191.117747] imx8mq-pinctrl 30330000.pinctrl: found group selector 58
for wwangrp
[  191.117789] leds-gpio leds: no init pinctrl state
[  191.117799] imx8mq-pinctrl 30330000.pinctrl: request pin 22
(MX8MQ_IOMUXC_GPIO1_IO12) for leds
[  191.117814] imx8mq-pinctrl 30330000.pinctrl: enable function pinctrl
group hubnresetgrp
[  191.117831] imx8mq-pinctrl 30330000.pinctrl: write: offset 0x58 val
0x0
[  191.117843] imx8mq-pinctrl 30330000.pinctrl: pinconf set pin
MX8MQ_IOMUXC_GPIO1_IO12
[  191.117852] imx8mq-pinctrl 30330000.pinctrl: write: offset 0x2c0 val
0x83
[  191.117860] imx8mq-pinctrl 30330000.pinctrl: request pin 13
(MX8MQ_IOMUXC_GPIO1_IO03) for leds
[  191.117871] imx8mq-pinctrl 30330000.pinctrl: enable function pinctrl
group sdpwrgrp
[  191.117881] imx8mq-pinctrl 30330000.pinctrl: write: offset 0x34 val
0x0
[  191.117888] imx8mq-pinctrl 30330000.pinctrl: pinconf set pin
MX8MQ_IOMUXC_GPIO1_IO03
[  191.117899] imx8mq-pinctrl 30330000.pinctrl: write: offset 0x29c val
0x83
[  191.117910] imx8mq-pinctrl 30330000.pinctrl: request pin 63
(MX8MQ_IOMUXC_NAND_CE1_B) for leds
[  191.117921] imx8mq-pinctrl 30330000.pinctrl: enable function pinctrl
group chargergrp
[  191.117930] imx8mq-pinctrl 30330000.pinctrl: write: offset 0xfc val
0x5
[  191.117936] imx8mq-pinctrl 30330000.pinctrl: pinconf set pin
MX8MQ_IOMUXC_NAND_CE1_B
[  191.117947] imx8mq-pinctrl 30330000.pinctrl: write: offset 0x364 val
0x3
[  191.117955] imx8mq-pinctrl 30330000.pinctrl: request pin 16
(MX8MQ_IOMUXC_GPIO1_IO06) for leds
[  191.117964] imx8mq-pinctrl 30330000.pinctrl: enable function pinctrl
group smcgrp
[  191.117976] imx8mq-pinctrl 30330000.pinctrl: write: offset 0x40 val
0x0
[  191.117984] imx8mq-pinctrl 30330000.pinctrl: pinconf set pin
MX8MQ_IOMUXC_GPIO1_IO06
[  191.117992] imx8mq-pinctrl 30330000.pinctrl: write: offset 0x2a8 val
0x83
[  191.118001] imx8mq-pinctrl 30330000.pinctrl: request pin 18
(MX8MQ_IOMUXC_GPIO1_IO08) for leds
[  191.118011] imx8mq-pinctrl 30330000.pinctrl: enable function pinctrl
group gnssgrp
[  191.118021] imx8mq-pinctrl 30330000.pinctrl: write: offset 0x48 val
0x0
[  191.118029] imx8mq-pinctrl 30330000.pinctrl: pinconf set pin
MX8MQ_IOMUXC_GPIO1_IO08
[  191.118037] imx8mq-pinctrl 30330000.pinctrl: write: offset 0x2b0 val
0x83
[  191.118048] imx8mq-pinctrl 30330000.pinctrl: request pin 79
(MX8MQ_IOMUXC_NAND_WP_B) for leds
[  191.118059] imx8mq-pinctrl 30330000.pinctrl: enable function pinctrl
group wwanpwrgrp
[  191.118070] imx8mq-pinctrl 30330000.pinctrl: write: offset 0x13c val
0x5
[  191.118078] imx8mq-pinctrl 30330000.pinctrl: pinconf set pin
MX8MQ_IOMUXC_NAND_WP_B
[  191.118084] imx8mq-pinctrl 30330000.pinctrl: write: offset 0x3a4 val
0x83
[  191.118096] imx8mq-pinctrl 30330000.pinctrl: request pin 62
(MX8MQ_IOMUXC_NAND_CE0_B) for leds
[  191.118106] imx8mq-pinctrl 30330000.pinctrl: request pin 77
(MX8MQ_IOMUXC_NAND_READY_B) for leds
[  191.118113] imx8mq-pinctrl 30330000.pinctrl: request pin 74
(MX8MQ_IOMUXC_NAND_DATA07) for leds
[  191.118125] imx8mq-pinctrl 30330000.pinctrl: enable function pinctrl
group wwangrp
[  191.118134] imx8mq-pinctrl 30330000.pinctrl: write: offset 0xf8 val
0x5
[  191.118144] imx8mq-pinctrl 30330000.pinctrl: write: offset 0x134 val
0x5
[  191.118154] imx8mq-pinctrl 30330000.pinctrl: write: offset 0x128 val
0x5
[  191.118160] imx8mq-pinctrl 30330000.pinctrl: pinconf set pin
MX8MQ_IOMUXC_NAND_CE0_B
[  191.118170] imx8mq-pinctrl 30330000.pinctrl: write: offset 0x360 val
0x83
[  191.118178] imx8mq-pinctrl 30330000.pinctrl: pinconf set pin
MX8MQ_IOMUXC_NAND_READY_B
[  191.118185] imx8mq-pinctrl 30330000.pinctrl: write: offset 0x39c val
0x83
[  191.118194] imx8mq-pinctrl 30330000.pinctrl: pinconf set pin
MX8MQ_IOMUXC_NAND_DATA07
[  191.118205] imx8mq-pinctrl 30330000.pinctrl: write: offset 0x390 val
0x83
[  191.118217] leds-gpio leds: no sleep pinctrl state
[  191.118226] leds-gpio leds: no idle pinctrl state
[  191.118252] leds-gpio leds: device is not dma coherent
[  191.118265] leds-gpio leds: device is not behind an iommu
[  191.118515] of_get_named_gpiod_flags: parsed 'gpios' property of
node '/leds/chg-en[0]' - status (0)
[  191.118599] imx8mq-pinctrl 30330000.pinctrl: request pin 63
(MX8MQ_IOMUXC_NAND_CE1_B) for 30220000.gpio:66
[  191.118654] gpio gpiochip2: Persistence not supported for GPIO 2
[  191.118674] gpio-66 (?): no flags found for gpios
[  191.118827] device: 'chg_en': device_add
[  191.118846] kobject: 'leds' ((____ptrval____)):
kobject_add_internal: parent: 'leds', set: '(null)'
[  191.118870] kobject: 'chg_en' ((____ptrval____)):
kobject_add_internal: parent: 'leds', set: 'devices'
[  191.118963] PM: Adding info for No Bus:chg_en
[  191.118972] kobject: 'chg_en' ((____ptrval____)): kobject_uevent_env
[  191.118992] kobject: 'chg_en' ((____ptrval____)): fill_kobj_path:
path = '/devices/platform/leds/leds/chg_en'
[  191.119049] leds-gpio leds: Registered led device: (null)
[  191.119098] of_get_named_gpiod_flags: parsed 'gpios' property of
node '/leds/flash-strobe[0]' - status (0)
[  191.119125] imx8mq-pinctrl 30330000.pinctrl: request pin 31
(MX8MQ_IOMUXC_ENET_TD0) for 30200000.gpio:21
[  191.119144] gpio gpiochip0: Persistence not supported for GPIO 21
[  191.119154] gpio-21 (?): no flags found for gpios
[  191.119215] device: 'flash_strobe': device_add
[  191.119223] kobject: 'flash_strobe' ((____ptrval____)):
kobject_add_internal: parent: 'leds', set: 'devices'
[  191.119286] PM: Adding info for No Bus:flash_strobe
[  191.119296] kobject: 'flash_strobe' ((____ptrval____)):
kobject_uevent_env
[  191.119314] kobject: 'flash_strobe' ((____ptrval____)):
fill_kobj_path: path = '/devices/platform/leds/leds/flash_strobe'
[  191.119412] leds-gpio leds: Registered led device: (null)
[  191.119433] of_get_named_gpiod_flags: parsed 'gpios' property of
node '/leds/hub-nreset[0]' - status (0)
[  191.119452] imx8mq-pinctrl 30330000.pinctrl: request pin 22
(MX8MQ_IOMUXC_GPIO1_IO12) for 30200000.gpio:12
[  191.119465] gpio gpiochip0: Persistence not supported for GPIO 12
[  191.119472] gpio-12 (?): no flags found for gpios
[  191.119507] device: 'hub_nreset': device_add
[  191.119515] kobject: 'hub_nreset' ((____ptrval____)):
kobject_add_internal: parent: 'leds', set: 'devices'
[  191.119560] PM: Adding info for No Bus:hub_nreset
[  191.119568] kobject: 'hub_nreset' ((____ptrval____)):
kobject_uevent_env
[  191.119591] kobject: 'hub_nreset' ((____ptrval____)):
fill_kobj_path: path = '/devices/platform/leds/leds/hub_nreset'
[  191.119609] leds-gpio leds: Registered led device: (null)
[  191.119638] of_get_named_gpiod_flags: parsed 'gpios' property of
node '/leds/sd-en[0]' - status (0)
[  191.119657] imx8mq-pinctrl 30330000.pinctrl: request pin 13
(MX8MQ_IOMUXC_GPIO1_IO03) for 30200000.gpio:3
[  191.119667] gpio gpiochip0: Persistence not supported for GPIO 3
[  191.119675] gpio-3 (?): no flags found for gpios
[  191.119715] device: 'sd_en': device_add
[  191.119723] kobject: 'sd_en' ((____ptrval____)):
kobject_add_internal: parent: 'leds', set: 'devices'
[  191.119787] PM: Adding info for No Bus:sd_en
[  191.119794] kobject: 'sd_en' ((____ptrval____)): kobject_uevent_env
[  191.119822] kobject: 'sd_en' ((____ptrval____)): fill_kobj_path:
path = '/devices/platform/leds/leds/sd_en'
[  191.119838] leds-gpio leds: Registered led device: (null)
[  191.119861] of_get_named_gpiod_flags: parsed 'gpios' property of
node '/leds/gnss-nreset[0]' - status (0)
[  191.119882] imx8mq-pinctrl 30330000.pinctrl: request pin 18
(MX8MQ_IOMUXC_GPIO1_IO08) for 30200000.gpio:8
[  191.119893] gpio gpiochip0: Persistence not supported for GPIO 8
[  191.119903] gpio-8 (?): no flags found for gpios
[  191.119941] device: 'gnss_nreset': device_add
[  191.119947] kobject: 'gnss_nreset' ((____ptrval____)):
kobject_add_internal: parent: 'leds', set: 'devices'
[  191.120017] PM: Adding info for No Bus:gnss_nreset
[  191.120023] kobject: 'gnss_nreset' ((____ptrval____)):
kobject_uevent_env
[  191.120067] kobject: 'gnss_nreset' ((____ptrval____)):
fill_kobj_path: path = '/devices/platform/leds/leds/gnss_nreset'
[  191.120084] leds-gpio leds: Registered led device: (null)
[  191.120108] of_get_named_gpiod_flags: parsed 'gpios' property of
node '/leds/smc-en[0]' - status (0)
[  191.120131] imx8mq-pinctrl 30330000.pinctrl: request pin 16
(MX8MQ_IOMUXC_GPIO1_IO06) for 30200000.gpio:6
[  191.120142] gpio gpiochip0: Persistence not supported for GPIO 6
[  191.120148] gpio-6 (?): no flags found for gpios
[  191.120185] device: 'smc_en': device_add
[  191.120191] kobject: 'smc_en' ((____ptrval____)):
kobject_add_internal: parent: 'leds', set: 'devices'
[  191.120289] PM: Adding info for No Bus:smc_en
[  191.120298] kobject: 'smc_en' ((____ptrval____)): kobject_uevent_env
[  191.120316] kobject: 'smc_en' ((____ptrval____)): fill_kobj_path:
path = '/devices/platform/leds/leds/smc_en'
[  191.120337] leds-gpio leds: Registered led device: (null)
[  191.120359] of_get_named_gpiod_flags: parsed 'gpios' property of
node '/leds/wwan-en[0]' - status (0)
[  191.120377] imx8mq-pinctrl 30330000.pinctrl: request pin 79
(MX8MQ_IOMUXC_NAND_WP_B) for 30220000.gpio:82
[  191.120390] gpio gpiochip2: Persistence not supported for GPIO 18
[  191.120398] gpio-82 (?): no flags found for gpios
[  191.120433] device: 'wwan_en': device_add
[  191.120443] kobject: 'wwan_en' ((____ptrval____)):
kobject_add_internal: parent: 'leds', set: 'devices'
[  191.120491] PM: Adding info for No Bus:wwan_en
[  191.120500] kobject: 'wwan_en' ((____ptrval____)):
kobject_uevent_env
[  191.120516] kobject: 'wwan_en' ((____ptrval____)): fill_kobj_path:
path = '/devices/platform/leds/leds/wwan_en'
[  191.120534] leds-gpio leds: Registered led device: (null)
[  191.120566] of_get_named_gpiod_flags: parsed 'gpios' property of
node '/leds/wwan-nreset[0]' - status (0)
[  191.120584] imx8mq-pinctrl 30330000.pinctrl: request pin 62
(MX8MQ_IOMUXC_NAND_CE0_B) for 30220000.gpio:65
[  191.120596] gpio gpiochip2: Persistence not supported for GPIO 1
[  191.120603] gpio-65 (?): no flags found for gpios
[  191.120644] device: 'wwan_nreset': device_add
[  191.120652] kobject: 'wwan_nreset' ((____ptrval____)):
kobject_add_internal: parent: 'leds', set: 'devices'
[  191.120702] PM: Adding info for No Bus:wwan_nreset
[  191.120708] kobject: 'wwan_nreset' ((____ptrval____)):
kobject_uevent_env
[  191.120732] kobject: 'wwan_nreset' ((____ptrval____)):
fill_kobj_path: path = '/devices/platform/leds/leds/wwan_nreset'
[  191.120749] leds-gpio leds: Registered led device: (null)
[  191.120771] of_get_named_gpiod_flags: parsed 'gpios' property of
node '/leds/wwan-disable[0]' - status (0)
[  191.120789] imx8mq-pinctrl 30330000.pinctrl: request pin 77
(MX8MQ_IOMUXC_NAND_READY_B) for 30220000.gpio:80
[  191.120803] gpio gpiochip2: Persistence not supported for GPIO 16
[  191.120812] gpio-80 (?): no flags found for gpios
[  191.120855] device: 'wwan_disable': device_add
[  191.120861] kobject: 'wwan_disable' ((____ptrval____)):
kobject_add_internal: parent: 'leds', set: 'devices'
[  191.120928] PM: Adding info for No Bus:wwan_disable
[  191.120935] kobject: 'wwan_disable' ((____ptrval____)):
kobject_uevent_env
[  191.120949] kobject: 'wwan_disable' ((____ptrval____)):
fill_kobj_path: path = '/devices/platform/leds/leds/wwan_disable'
[  191.120973] leds-gpio leds: Registered led device: (null)
[  191.120992] of_get_named_gpiod_flags: parsed 'gpios' property of
node '/leds/wwan-dis2[0]' - status (0)
[  191.121012] imx8mq-pinctrl 30330000.pinctrl: request pin 74
(MX8MQ_IOMUXC_NAND_DATA07) for 30220000.gpio:77
[  191.121024] gpio gpiochip2: Persistence not supported for GPIO 13
[  191.121031] gpio-77 (?): no flags found for gpios
[  191.121073] device: 'wwan_dis2': device_add
[  191.121079] kobject: 'wwan_dis2' ((____ptrval____)):
kobject_add_internal: parent: 'leds', set: 'devices'
[  191.121124] PM: Adding info for No Bus:wwan_dis2
[  191.121132] kobject: 'wwan_dis2' ((____ptrval____)):
kobject_uevent_env
[  191.121149] kobject: 'wwan_dis2' ((____ptrval____)): fill_kobj_path:
path = '/devices/platform/leds/leds/wwan_dis2'
[  191.121172] leds-gpio leds: Registered led device: (null)
[  191.121187] driver: 'leds-gpio': driver_bound: bound to device
'leds'
[  191.121233] leds-gpio leds: Dropping the link to 30330000.pinctrl
[  191.121255] device: 'platform:30330000.pinctrl--platform:leds':
device_unregister
[  191.121287] kernfs subsystem: removing
[  191.121359] kernfs platform:30330000.pinctrl--platform:leds:
removing
[  191.121385] kernfs consumer: removing
[  191.121397] kernfs supplier: removing
[  191.121423] kernfs supplier:platform:30330000.pinctrl: removing
[  191.121446] kernfs consumer:platform:leds: removing
[  191.121475] kernfs uevent: removing
[  191.121492] kernfs status: removing
[  191.121502] kernfs auto_remove_on: removing
[  191.121512] kernfs runtime_pm: removing
[  191.121524] kernfs sync_state_only: removing
[  191.131697] i2c i2c-3: <i2c_imx_acked> ACK received
[  191.137259] kobject: 'platform:30330000.pinctrl--platform:leds'
((____ptrval____)): kobject_uevent_env
[  191.144497] i2c i2c-3: <i2c_imx_write> write data
[  191.149398] kobject: 'platform:30330000.pinctrl--platform:leds'
((____ptrval____)): fill_kobj_path: path =
'/devices/virtual/devlink/platform:30330000.pinctrl--platform:leds'
[  191.154111] i2c i2c-3: <i2c_imx_write> write byte: B0=0x0
[  191.157842] kernfs platform:30330000.pinctrl--platform:leds:
removing
[  191.164227] i2c i2c-3: <i2c_imx_trx_complete> TRX complete
[  191.168240] kobject: 'platform:30330000.pinctrl--platform:leds'
((____ptrval____)): kobject_cleanup, parent 0000000000000000
[  191.178594] i2c i2c-3: <i2c_imx_acked> ACK received
[  191.185118] kobject: 'platform:30330000.pinctrl--platform:leds'
((____ptrval____)): calling ktype release
[  191.189332] i2c i2c-3: <i2c_imx_xfer_common> repeated start
[  191.195319] kobject: 'platform:30330000.pinctrl--platform:leds':
free name
[  191.200506] i2c i2c-3: <i2c_imx_bus_busy>
[  191.200536] i2c i2c-3: <i2c_imx_xfer_common> transfer message: 1
[  191.206919] leds-gpio leds: Dropping the link to 30220000.gpio
[  191.212056] i2c i2c-3: <i2c_imx_read> write slave address: addr=0x6d
[  191.219768] device: 'platform:30220000.gpio--platform:leds':
device_unregister
[  191.226918] i2c i2c-3: <i2c_imx_trx_complete> TRX complete
[  191.234771] kernfs subsystem: removing
[  191.241527] i2c i2c-3: <i2c_imx_acked> ACK received




