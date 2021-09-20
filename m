Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCA34110B0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 10:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235387AbhITILt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 04:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235380AbhITILp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 04:11:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A79C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 01:10:17 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mSENM-0008In-7n; Mon, 20 Sep 2021 10:10:08 +0200
Message-ID: <9fae7a66f4d9c709897586fcf8f26e5863d01bf4.camel@pengutronix.de>
Subject: Re: [PATCH] arm64: dts: imx8mm-kontron-n801x-som: do not allow to
 switch off buck2
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Michael Walle <michael@walle.cc>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Heiko Thiery <heiko.thiery@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Date:   Mon, 20 Sep 2021 10:10:05 +0200
In-Reply-To: <447B96FA-2B75-4C72-A72B-1C1D29137B2C@walle.cc>
References: <20210915120325.20248-1-heiko.thiery@gmail.com>
         <7e7ee4244ababc0a46e0875222c7e37d@walle.cc>
         <898fd5e0-2073-3689-89b6-2c5071773786@kontron.de>
         <CAEyMn7ZbJr0_2Phc2rW7sDYQu4AABWPZ1F7xDgaS5U7ha7iqzA@mail.gmail.com>
         <9bcf7b749dca57d42aa2e7afd88b5a26f3eeff2a.camel@pengutronix.de>
         <CAEyMn7aa=-UKvUz4pWOWZJbPh7TTgzmDpmNKOTYM5g0G54xU2Q@mail.gmail.com>
         <d618c505-43e6-01a7-4d2a-847dad33b43e@kontron.de>
         <447B96FA-2B75-4C72-A72B-1C1D29137B2C@walle.cc>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, dem 20.09.2021 um 09:43 +0200 schrieb Michael Walle:
> Am 20. September 2021 09:31:20 MESZ schrieb Frieder Schrempf <frieder.schrempf@kontron.de>:
> > On 17.09.21 18:10, Heiko Thiery wrote:
> > > Hi Lucas,
> > > 
> > > Am Fr., 17. Sept. 2021 um 13:44 Uhr schrieb Lucas Stach
> > > <l.stach@pengutronix.de>:
> > > > 
> > > > Am Freitag, dem 17.09.2021 um 09:28 +0200 schrieb Heiko Thiery:
> > > > > Hi Frieder,
> > > > > 
> > > > > Am Mi., 15. Sept. 2021 um 14:09 Uhr schrieb Frieder Schrempf
> > > > > <frieder.schrempf@kontron.de>:
> > > > > > 
> > > > > > On 15.09.21 14:05, Michael Walle wrote:
> > > > > > > Am 2021-09-15 14:03, schrieb Heiko Thiery:
> > > > > > > > The buck2 output of the PMIC is the VDD core voltage of the cpu.
> > > > > > > > Switching off this will poweroff the CPU. Add the 'regulator-always-on'
> > > > > > > > property to avoid this.
> > > > > > > 
> > > > > > > Mh, have this ever worked? Is there a commit which introduced a regression?
> > > > > > 
> > > > > > Yes, this did work before, even without 'regulator-always-on'. I
> > > > > > currently don't understand why this is needed. The regulator is
> > > > > > referenced in the CPU nodes as 'cpu-supply'. This should be enough to
> > > > > > not disable it as long as the CPU is up.
> > > > > 
> > > > > I rechecked that with 5.11, 5.10 and 5.9 and I see on all of them the
> > > > > same issue:
> > > > > 
> > > > > [ 31.716031] vdd-5v: disabling
> > > > > [ 31.719032] rst-usb-eth2: disabling
> > > > > [ 31.722553] buck2: disabling
> > > > > 
> > > > > While on that I tried to compare with other boards and see that they
> > > > > also have the cpu-voltage marked as "regulator-always-on". The only
> > > > > exception in dts/freescale is in imx8mq-librem5-devkit.dts [1] that
> > > > > has not set this property.
> > > > > 
> > > > > I agree with you and don't understand why this is happening. Has
> > > > > anyone else an explanation?
> > > > > 
> > > > > [1] https://eur04.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Flatest%2Fsource%2Farch%2Farm64%2Fboot%2Fdts%2Ffreescale%2Fimx8mq-librem5-devkit.dts%23L319&amp;data=04%7C01%7Cfrieder.schrempf%40kontron.de%7Cce9d266ad78a4d06721008d979f5aeed%7C8c9d3c973fd941c8a2b1646f3942daf1%7C0%7C0%7C637674918380815550%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=PsTKX4MXGwvvP6WxmQ1OWc8e32YI6Nsu%2FEkcNR4V8is%3D&amp;reserved=0
> > > > > 
> > > > Maybe your kernel config is missing the cpufreq driver, so you don't
> > > > have a consumer of the regulator?
> > > > 
> > > > Marking the regulator as always-on seems like the right thing to do,
> > > > you don't want to depend on a consumer showing up to make sure that
> > > > your CPU voltage isn't cut...
> > > 
> > > shouldn't it be that the node cpu-supply here is a consumer of the
> > > referenced voltage?
> > 
> > Yes, but as Michael and Lucas noted, the consumer is only active if the
> > cpufreq driver is loaded and we don't want to depend on this. In my
> > config I always had this compiled into the kernel so I didn't notice
> > that the always-on property is missing.
> 
> Hm. So any cpu core voltage has to have the "always-on" property? On
> any SoC? Shouldn't there be some code to prevent the disabling of the
> voltage if the cpu nodes have a cpu-supply phandle?

Yes, all regulators that must not be shut down for proper system
operation must be marked as always-on. Just because it is a CPU supply
doesn't make it special in any way. Otherwise where would you stop with
adding special code to keep supplies enabled without a consumer? Have
code to keep the DDR memory regulators on when no DDR controller driver
is loaded? Code to keep 3.3V for the board level peripherals enabled?
Just mark those as always-on.

Regards,
Lucas

