Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F55C321C6B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 17:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhBVQIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 11:08:49 -0500
Received: from mout01.posteo.de ([185.67.36.65]:40545 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231213AbhBVQEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 11:04:39 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id D202A16005C
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 17:03:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1614009798; bh=LvquAM2J5zLig8UiWE7YNNTosNOEsZkwWbtbd26zOZI=;
        h=To:Cc:From:Subject:Date:From;
        b=nEFtYiWgLTqI2pE9oY4HiC/P8e+FKC2JOkaB2eSDla3UN8OPQN8IO2+k0zJ8XGWFD
         B+wR7IcgewkASzWqfYvbc25hYRIPKEBQ5+Ku2q0TxurcAtoSWivfPJLVAGtcMOTubh
         pRSBIjAURv0BCxR/0F6wlS5g15j4LyziablLUk3fbCLEui/oIBYBkkgGRgun4e87wc
         yzwaMNtavzd+Afqslh51OvxndxLwC+1y8vUwbZzWY/Ko9t1aa8KnWHXZQDBi+0B76d
         0w7JFHsWs1wpt8HplU9cvTCIKqldow8jvXYj/dyBsIVZlFfLCaTM9mHnTpFb2Wqi7o
         5w/h/Elt2zVLA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Dkn5s6W55z9rxp;
        Mon, 22 Feb 2021 17:03:13 +0100 (CET)
To:     Abel Vesa <abel.vesa@nxp.com>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Georgi Djakov <djakov@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "kernel@puri.sm" <kernel@puri.sm>
Cc:     NXP Linux Team <linux-imx@nxp.com>
References: <1613750416-11901-1-git-send-email-abel.vesa@nxp.com>
From:   Martin Kepplinger <martink@posteo.de>
Subject: Re: [RFC 00/19] Rework support for i.MX8MQ interconnect with devfreq
Message-ID: <a2b651de-77a7-2a40-7e51-d0098e4b804b@posteo.de>
Date:   Mon, 22 Feb 2021 17:03:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1613750416-11901-1-git-send-email-abel.vesa@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.02.21 16:59, Abel Vesa wrote:
> This has been on my queue for quite some time now. It is more of a
> proof-of-concept.
> 
> This rework is done with the compatibility of future i.MX platforms in
> mind. For example, the i.MX8MP platform has multiple NoCs. This
> patchsets prepares the imx interconnect and imx devfreq for that too.
> 
> As of now, none of the drivers involved are being used and there is no
> icc consumer on any off the i.MX platforms.
> 
> Basically, the steps taken here are the following:
> 
> 1. Make the dram_apb clock "reparantable" from kernel.
> This is needed in order to keep track of the actual parent of the
> dram_apb clock in the kernel clock hierarchy. Note that the actual
> switch is done EL3 (TF-A).
> 
> 2. Rework the imx-bus so the actual link between the icc and the
> NoCs or the pl301s is not tightly coupled. This allows us to have
> as many NoCs as necessary but also allows as to use the same driver
> for the pl301s. The pl301s have their own clocks too, so we need to
> reduce their rates too.
> 
> 3. Rework the imx8m-ddrc driver. Remove the support for dts defined
> OPPs. The EL3 provides those. So instead of havingi to keep the OPP table in
> both EL3 and kernel in sync, we rely on what the EL3 gives us.
> Also, when the platform suspends, the bus needs to be running at highest
> rate, otherwise there is a chance it might not resume anymore.
> By adding the late system sleep PM ops we can handle that easily.
> 
> 4. Rework the imx interconnect driver to use the fsl,icc-id instead
> of the robust imx_icc_node_adj_desc for linking with the target node.
> By adding the fsl,icc-id property to all the NoC and pl301 dts nodes,
> we can link each icc node to their corresponding NoC, pl301 or dram.
> Basically, when the imx interconnect platform specific driver probes,
> it will take each node defined for that platform and look-up the
> corresponding dts node based on the id and add that as the qos device.
> 
> 5. Added the fec and usdhc as icc consumers. This is just as an example.
> All the other consumers can be added later. Basically, each consumer
> will add a path to their device node and in the driver will have to
> handle that icc path accordingly.
> 

thanks for working on this Abel,

It looks like the icc path requests don't work for me:

when applying this onto v5.11 (without any other workaround in that 
area, but some out-of-tree icc-requests like in mxsfb) my rootfs isn't 
being mounted anymore. Since you add icc requests to the usdhc driver, 
there could be something wrong.

So I revert 19/19 ("mmc: sdhci-esdhc-imx: Add interconnect support") and 
then my imx8mq (Librem 5) rootfs system boots, but all frequencies stay 
at the minimum (despite the icc request like this: 
https://source.puri.sm/martin.kepplinger/linux-next/-/commit/1692de27d1475c53574dd7359c68ba613e0fea10 
so I can't use the display).

What could be missing? As I said I'm trying on top of v5.11, (at least I 
have the NOC node described: 
https://source.puri.sm/martin.kepplinger/linux-next/-/commit/1d74a24c9944d1bf618abdd57d24101368cc8df0 
and (with the revert from 
https://lore.kernel.org/linux-arm-kernel/20210104120512.gmi2zjz7dzhjussp@fsr-ub1664-175/ 
devfreq works without your patchset ) Is there anything I'm missing that 
is not yet merged in v5.11?

Can I test anything else that would help?

/sys/class/devfreq# cat */cur_freq
133333334
25000000
25641026
25000000
800000000
25000000
0
25000000
25000000
25000000
0

the available freqs look ok (opp table removed from device dts, but you 
don't read that anymore anyway):

cat */available_frequencies
133333333 400000000 800000000
25000000 100000000 800000000
25000000 133333333 333333333
25000000 266666666
25000000 800000000
25000000 800000000
25000000 333333333
25000000 500000000
25000000 500000000
25000000 128000000 500000000
25000000 133333333

where ls is:

32700000.noc 

3d400000.memory-controller 

soc@0:pl301@0 

soc@0:pl301@1 

soc@0:pl301@2 

soc@0:pl301@3 

soc@0:pl301@4 

soc@0:pl301@5 

soc@0:pl301@6 

soc@0:pl301@7 

soc@0:pl301@8

thanks,
                                 martin
