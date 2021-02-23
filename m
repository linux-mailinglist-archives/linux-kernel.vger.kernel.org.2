Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA9E322F84
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 18:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbhBWRVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 12:21:07 -0500
Received: from inva020.nxp.com ([92.121.34.13]:53632 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233605AbhBWRVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 12:21:02 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 111F11A0EE8;
        Tue, 23 Feb 2021 18:20:14 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 02B3E1A07C5;
        Tue, 23 Feb 2021 18:20:14 +0100 (CET)
Received: from localhost (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id E0270203C1;
        Tue, 23 Feb 2021 18:20:13 +0100 (CET)
Date:   Tue, 23 Feb 2021 19:20:13 +0200
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
Message-ID: <20210223172013.tsip6uiuwtfnmqav@fsr-ub1664-175>
References: <1613750416-11901-1-git-send-email-abel.vesa@nxp.com>
 <a2b651de-77a7-2a40-7e51-d0098e4b804b@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2b651de-77a7-2a40-7e51-d0098e4b804b@posteo.de>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-02-22 17:03:13, Martin Kepplinger wrote:
> On 19.02.21 16:59, Abel Vesa wrote:
> > This has been on my queue for quite some time now. It is more of a
> > proof-of-concept.
> > 
> > This rework is done with the compatibility of future i.MX platforms in
> > mind. For example, the i.MX8MP platform has multiple NoCs. This
> > patchsets prepares the imx interconnect and imx devfreq for that too.
> > 
> > As of now, none of the drivers involved are being used and there is no
> > icc consumer on any off the i.MX platforms.
> > 
> > Basically, the steps taken here are the following:
> > 
> > 1. Make the dram_apb clock "reparantable" from kernel.
> > This is needed in order to keep track of the actual parent of the
> > dram_apb clock in the kernel clock hierarchy. Note that the actual
> > switch is done EL3 (TF-A).
> > 
> > 2. Rework the imx-bus so the actual link between the icc and the
> > NoCs or the pl301s is not tightly coupled. This allows us to have
> > as many NoCs as necessary but also allows as to use the same driver
> > for the pl301s. The pl301s have their own clocks too, so we need to
> > reduce their rates too.
> > 
> > 3. Rework the imx8m-ddrc driver. Remove the support for dts defined
> > OPPs. The EL3 provides those. So instead of havingi to keep the OPP table in
> > both EL3 and kernel in sync, we rely on what the EL3 gives us.
> > Also, when the platform suspends, the bus needs to be running at highest
> > rate, otherwise there is a chance it might not resume anymore.
> > By adding the late system sleep PM ops we can handle that easily.
> > 
> > 4. Rework the imx interconnect driver to use the fsl,icc-id instead
> > of the robust imx_icc_node_adj_desc for linking with the target node.
> > By adding the fsl,icc-id property to all the NoC and pl301 dts nodes,
> > we can link each icc node to their corresponding NoC, pl301 or dram.
> > Basically, when the imx interconnect platform specific driver probes,
> > it will take each node defined for that platform and look-up the
> > corresponding dts node based on the id and add that as the qos device.
> > 
> > 5. Added the fec and usdhc as icc consumers. This is just as an example.
> > All the other consumers can be added later. Basically, each consumer
> > will add a path to their device node and in the driver will have to
> > handle that icc path accordingly.
> > 
> 
> thanks for working on this Abel,
> 
> It looks like the icc path requests don't work for me:
> 
> when applying this onto v5.11 (without any other workaround in that area,
> but some out-of-tree icc-requests like in mxsfb) my rootfs isn't being
> mounted anymore. Since you add icc requests to the usdhc driver, there could
> be something wrong.
> 
> So I revert 19/19 ("mmc: sdhci-esdhc-imx: Add interconnect support") and
> then my imx8mq (Librem 5) rootfs system boots, but all frequencies stay at
> the minimum (despite the icc request like this:
> https://source.puri.sm/martin.kepplinger/linux-next/-/commit/1692de27d1475c53574dd7359c68ba613e0fea10  
> so I can't use the display).
> 
> What could be missing? As I said I'm trying on top of v5.11, (at least I
> have the NOC node described:
> https://source.puri.sm/martin.kepplinger/linux-next/-/commit/1d74a24c9944d1bf618abdd57d24101368cc8df0 
> and (with the revert from 
> https://lore.kernel.org/linux-arm-kernel/20210104120512.gmi2zjz7dzhjussp@fsr-ub1664-175/
> devfreq works without your patchset ) Is there anything I'm missing that is
> not yet merged in v5.11?
> 
> Can I test anything else that would help?
> 

Sorry about this, I messed up the usdhc change.
I tested mostly with nfs rootfs.

I'll just paste here the things that are missing in order for the USHCs to work.
I'll fold them in the next version of this patch set.

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 43760316052f..90398408b55e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1637,6 +1637,25 @@ opp-133M {
                        };
                };
 
+               pl301_per_m: pl301@9 {
+                       compatible = "fsl,imx8m-nic";
+                       clocks = <&clk IMX8MQ_CLK_NAND_USDHC_BUS>;
+                       operating-points-v2 = <&pl301_per_m_opp_table>;
+                       #interconnect-cells = <0>;
+                       fsl,icc-id = <IMX8MQ_ICN_PER_M>;
+
+                       pl301_per_m_opp_table: opp-table {
+                               compatible = "operating-points-v2";
+
+                               opp-25M {
+                                       opp-hz = /bits/ 64 <25000000>;
+                               };
+                               opp-133M {
+                                       opp-hz = /bits/ 64 <133333333>;
+                               };
+                       };
+               };
+
                icc: interconnect@0 {
                        compatible = "fsl,imx8mq-icc", "fsl,imx8m-icc";
                        #interconnect-cells = <1>;
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 65c5caf82e0c..cb8d341faf71 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1545,7 +1545,8 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 
        imx_data->bus_path = devm_of_icc_get(&pdev->dev, "path");
        if (IS_ERR(imx_data->bus_path)) {
-               return PTR_ERR(imx_data->bus_path);
+               err = PTR_ERR(imx_data->bus_path);
+               goto free_sdhci;
        } else if (imx_data->bus_path) {
                if (of_property_read_u32(pdev->dev.of_node, "fsl,icc-rate", &imx_data->bus_rate)) {
                        dev_err(&pdev->dev, "icc-rate missing\n");

> /sys/class/devfreq# cat */cur_freq
> 133333334
> 25000000
> 25641026
> 25000000
> 800000000
> 25000000
> 0
> 25000000
> 25000000
> 25000000
> 0
> 
> the available freqs look ok (opp table removed from device dts, but you
> don't read that anymore anyway):
> 
> cat */available_frequencies
> 133333333 400000000 800000000
> 25000000 100000000 800000000
> 25000000 133333333 333333333
> 25000000 266666666
> 25000000 800000000
> 25000000 800000000
> 25000000 333333333
> 25000000 500000000
> 25000000 500000000
> 25000000 128000000 500000000
> 25000000 133333333
> 
> where ls is:
> 
> 32700000.noc
> 
> 3d400000.memory-controller
> 
> soc@0:pl301@0
> 
> soc@0:pl301@1
> 
> soc@0:pl301@2
> 
> soc@0:pl301@3
> 
> soc@0:pl301@4
> 
> soc@0:pl301@5
> 
> soc@0:pl301@6
> 
> soc@0:pl301@7
> 
> soc@0:pl301@8
> 
> thanks,

Also, here is this oneliner that allows you to see the transition stats for each node:
for each in `ls -1d /sys/devices/platform/soc@0/*/devfreq/*`; do echo $each; cat $each/trans_stat; done


>                                 martin
