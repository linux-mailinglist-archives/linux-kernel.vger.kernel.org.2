Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEC9324FBC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 13:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhBYMOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 07:14:49 -0500
Received: from mout01.posteo.de ([185.67.36.65]:37729 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229596AbhBYMOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 07:14:24 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 3B576160065
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 13:13:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1614255204; bh=ofuwOPdGLQUX+yxDjv2AuophkBsdATeFfPLESr3tZ5A=;
        h=To:Cc:From:Subject:Date:From;
        b=BPIOIsmohr4bCs2cl9N7QEqiXdqhcxI9aSC/dEK1R3huyt1RVNbZE4hSrVTCCk/XU
         8vpY62VuSqoHY9HOOc2iFAemaybjD8pb3vz+vaU9JxC6R2AyT1sn7JJCdxDTUVvWBJ
         1+AOG3+zUz8cyhcFNHHAeFEgCvmSAxuvmDKEt+nqrPw0Qm+t+U2llmRp20niFEqAWp
         hjEHKw/a8kS8H3nlziqkrxSBD0YICpsRqX/FsIgDs4wpiZKVouTt/f0Ig3WL8V3loZ
         jUiMwe457774csWqKx0hU6F8BwlhjkoojffcfWCwnfaAcfC8uyc9goX1MQUo+xmpIo
         ii5GlAfg2SwhA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4DmWsB68Grz6tmV;
        Thu, 25 Feb 2021 13:13:18 +0100 (CET)
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
References: <1613750416-11901-1-git-send-email-abel.vesa@nxp.com>
 <a2b651de-77a7-2a40-7e51-d0098e4b804b@posteo.de>
 <20210223172013.tsip6uiuwtfnmqav@fsr-ub1664-175>
From:   Martin Kepplinger <martink@posteo.de>
Subject: Re: [RFC 00/19] Rework support for i.MX8MQ interconnect with devfreq
Message-ID: <315c1ad8-6274-3654-a410-5d78e35a90fe@posteo.de>
Date:   Thu, 25 Feb 2021 13:13:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210223172013.tsip6uiuwtfnmqav@fsr-ub1664-175>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.02.21 18:20, Abel Vesa wrote:
> On 21-02-22 17:03:13, Martin Kepplinger wrote:
>> On 19.02.21 16:59, Abel Vesa wrote:
>>> This has been on my queue for quite some time now. It is more of a
>>> proof-of-concept.
>>>
>>> This rework is done with the compatibility of future i.MX platforms in
>>> mind. For example, the i.MX8MP platform has multiple NoCs. This
>>> patchsets prepares the imx interconnect and imx devfreq for that too.
>>>
>>> As of now, none of the drivers involved are being used and there is no
>>> icc consumer on any off the i.MX platforms.
>>>
>>> Basically, the steps taken here are the following:
>>>
>>> 1. Make the dram_apb clock "reparantable" from kernel.
>>> This is needed in order to keep track of the actual parent of the
>>> dram_apb clock in the kernel clock hierarchy. Note that the actual
>>> switch is done EL3 (TF-A).
>>>
>>> 2. Rework the imx-bus so the actual link between the icc and the
>>> NoCs or the pl301s is not tightly coupled. This allows us to have
>>> as many NoCs as necessary but also allows as to use the same driver
>>> for the pl301s. The pl301s have their own clocks too, so we need to
>>> reduce their rates too.
>>>
>>> 3. Rework the imx8m-ddrc driver. Remove the support for dts defined
>>> OPPs. The EL3 provides those. So instead of havingi to keep the OPP table in
>>> both EL3 and kernel in sync, we rely on what the EL3 gives us.
>>> Also, when the platform suspends, the bus needs to be running at highest
>>> rate, otherwise there is a chance it might not resume anymore.
>>> By adding the late system sleep PM ops we can handle that easily.
>>>
>>> 4. Rework the imx interconnect driver to use the fsl,icc-id instead
>>> of the robust imx_icc_node_adj_desc for linking with the target node.
>>> By adding the fsl,icc-id property to all the NoC and pl301 dts nodes,
>>> we can link each icc node to their corresponding NoC, pl301 or dram.
>>> Basically, when the imx interconnect platform specific driver probes,
>>> it will take each node defined for that platform and look-up the
>>> corresponding dts node based on the id and add that as the qos device.
>>>
>>> 5. Added the fec and usdhc as icc consumers. This is just as an example.
>>> All the other consumers can be added later. Basically, each consumer
>>> will add a path to their device node and in the driver will have to
>>> handle that icc path accordingly.
>>>
>>
>> thanks for working on this Abel,
>>
>> It looks like the icc path requests don't work for me:
>>
>> when applying this onto v5.11 (without any other workaround in that area,
>> but some out-of-tree icc-requests like in mxsfb) my rootfs isn't being
>> mounted anymore. Since you add icc requests to the usdhc driver, there could
>> be something wrong.
>>
>> So I revert 19/19 ("mmc: sdhci-esdhc-imx: Add interconnect support") and
>> then my imx8mq (Librem 5) rootfs system boots, but all frequencies stay at
>> the minimum (despite the icc request like this:
>> https://source.puri.sm/martin.kepplinger/linux-next/-/commit/1692de27d1475c53574dd7359c68ba613e0fea10
>> so I can't use the display).
>>
>> What could be missing? As I said I'm trying on top of v5.11, (at least I
>> have the NOC node described:
>> https://source.puri.sm/martin.kepplinger/linux-next/-/commit/1d74a24c9944d1bf618abdd57d24101368cc8df0
>> and (with the revert from
>> https://lore.kernel.org/linux-arm-kernel/20210104120512.gmi2zjz7dzhjussp@fsr-ub1664-175/
>> devfreq works without your patchset ) Is there anything I'm missing that is
>> not yet merged in v5.11?
>>
>> Can I test anything else that would help?
>>
> 
> Sorry about this, I messed up the usdhc change.
> I tested mostly with nfs rootfs.
> 
> I'll just paste here the things that are missing in order for the USHCs to work.
> I'll fold them in the next version of this patch set.
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 43760316052f..90398408b55e 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -1637,6 +1637,25 @@ opp-133M {
>                          };
>                  };
>   
> +               pl301_per_m: pl301@9 {
> +                       compatible = "fsl,imx8m-nic";
> +                       clocks = <&clk IMX8MQ_CLK_NAND_USDHC_BUS>;
> +                       operating-points-v2 = <&pl301_per_m_opp_table>;
> +                       #interconnect-cells = <0>;
> +                       fsl,icc-id = <IMX8MQ_ICN_PER_M>;
> +
> +                       pl301_per_m_opp_table: opp-table {
> +                               compatible = "operating-points-v2";
> +
> +                               opp-25M {
> +                                       opp-hz = /bits/ 64 <25000000>;
> +                               };
> +                               opp-133M {
> +                                       opp-hz = /bits/ 64 <133333333>;
> +                               };
> +                       };
> +               };
> +
>                  icc: interconnect@0 {
>                          compatible = "fsl,imx8mq-icc", "fsl,imx8m-icc";
>                          #interconnect-cells = <1>;
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 65c5caf82e0c..cb8d341faf71 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1545,7 +1545,8 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>   
>          imx_data->bus_path = devm_of_icc_get(&pdev->dev, "path");
>          if (IS_ERR(imx_data->bus_path)) {
> -               return PTR_ERR(imx_data->bus_path);
> +               err = PTR_ERR(imx_data->bus_path);
> +               goto free_sdhci;
>          } else if (imx_data->bus_path) {
>                  if (of_property_read_u32(pdev->dev.of_node, "fsl,icc-rate", &imx_data->bus_rate)) {
>                          dev_err(&pdev->dev, "icc-rate missing\n");
> 

when simply booting with this instead of my revert, turning on *all* 
kernel debug output, startup stops here:

[  191.157686] devices_kset: Moving 30b50000.mmc to end of list
[  191.163388] PM: Moving platform:30b50000.mmc to end of list
[  191.169003] platform 30b50000.mmc: Retrying from deferred list
[  191.175305] platform 30b50000.mmc: scheduling asynchronous probe
[  191.181394] devices_kset: Moving 30b40000.mmc to end of list
[  191.181493] bus: 'platform': driver_probe_device: matched device 
30b50000.mmc with driver sdhci-esdhc-imx
[  191.187096] PM: Moving platform:30b40000.mmc to end of list
[  191.196706] bus: 'platform': really_probe: probing driver 
sdhci-esdhc-imx with device 30b50000.mmc
[  191.202270] platform 30b40000.mmc: Retrying from deferred list
[  191.211361] imx8mq-pinctrl 30330000.pinctrl: maps: function pinctrl 
group usdhc2grp num 9
[  191.217169] platform 30b40000.mmc: scheduling asynchronous probe
[  191.225259] pinctrl core: add 9 pinctrl maps

or here:

[  185.726775] devices_kset: Moving 30b40000.mmc to end of list
[  185.732476] PM: Moving platform:30b40000.mmc to end of list
[  185.738090] platform 30b40000.mmc: Retrying from deferred list
[  185.744453] platform 30b40000.mmc: scheduling asynchronous probe
[  185.750541] devices_kset: Moving leds to end of list
[  185.750660] bus: 'platform': driver_probe_device: matched device 
30b40000.mmc with driver sdhci-esdhc-imx
[  185.755556] PM: Moving platform:leds to end of list
[  185.755575] platform leds: Retrying from deferred list
[  185.765180] bus: 'platform': really_probe: probing driver 
sdhci-esdhc-imx with device 30b40000.mmc
[  185.770120] bus: 'platform': driver_probe_device: matched device leds 
with driver leds-gpio
[  185.775525] imx8mq-pinctrl 30330000.pinctrl: maps: function pinctrl 
group usdhc1grp num 13
[  185.784200] bus: 'platform': really_probe: probing driver leds-gpio 
with device leds
[  185.792619] pinctrl core: add 13 pinctrl maps
[  185.800915] imx8mq-pinctrl 30330000.pinctrl: maps: function pinctrl 
group hubnresetgrp num 2
[  185.808672] imx8mq-pinctrl 30330000.pinctrl: maps: function pinctrl 
group usdhc1grp100mhz num 13
[  185.813001] pinctrl core: add 2 pinctrl maps
[  185.821471] pinctrl core: add 13 pinctrl maps
[  185.830275] imx8mq-pinctrl 30330000.pinctrl: maps: function pinctrl 
group sdpwrgrp num 2
[  185.834578] imx8mq-pinctrl 30330000.pinctrl: maps: function pinctrl 
group usdhc1grp200mhz num 13
[  185.838942] pinctrl core: add 2 pinctrl maps
[  185.847080] pinctrl core: add 13 pinctrl maps
[  185.855854] imx8mq-pinctrl 30330000.pinctrl: maps: function pinctrl 
group chargergrp num 2
[  185.860154] imx8mq-pinctrl 30330000.pinctrl: found group selector 50 
for usdhc1grp
[  185.864480] pinctrl core: add 2 pinctrl maps
[  185.872864] imx8mq-pinctrl 30330000.pinctrl: found group selector 51 
for usdhc1grp100mhz
[  185.887696] thermal thermal_zone0: 
Trip0[type=1,temp=50000]:trend=0,throttle=1
[  185.892835] imx8mq-pinctrl 30330000.pinctrl: found group selector 52 
for usdhc1grp200mhz
[  185.899966] thermal cooling_device5: cur_state=1
[  185.908180] sdhci-esdhc-imx 30b40000.mmc: no init pinctrl state
[  185.908208] imx8mq-pinctrl 30330000.pinctrl: maps: function pinctrl 
group smcgrp num 2

