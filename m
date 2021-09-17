Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D1D40F6CF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 13:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241998AbhIQLph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 07:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241976AbhIQLpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 07:45:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4DAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 04:44:14 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mRCHo-0008GX-7t; Fri, 17 Sep 2021 13:44:08 +0200
Message-ID: <9bcf7b749dca57d42aa2e7afd88b5a26f3eeff2a.camel@pengutronix.de>
Subject: Re: [PATCH] arm64: dts: imx8mm-kontron-n801x-som: do not allow to
 switch off buck2
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Heiko Thiery <heiko.thiery@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     devicetree@vger.kernel.org,
        Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Date:   Fri, 17 Sep 2021 13:44:04 +0200
In-Reply-To: <CAEyMn7ZbJr0_2Phc2rW7sDYQu4AABWPZ1F7xDgaS5U7ha7iqzA@mail.gmail.com>
References: <20210915120325.20248-1-heiko.thiery@gmail.com>
         <7e7ee4244ababc0a46e0875222c7e37d@walle.cc>
         <898fd5e0-2073-3689-89b6-2c5071773786@kontron.de>
         <CAEyMn7ZbJr0_2Phc2rW7sDYQu4AABWPZ1F7xDgaS5U7ha7iqzA@mail.gmail.com>
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

Am Freitag, dem 17.09.2021 um 09:28 +0200 schrieb Heiko Thiery:
> Hi Frieder,
> 
> Am Mi., 15. Sept. 2021 um 14:09 Uhr schrieb Frieder Schrempf
> <frieder.schrempf@kontron.de>:
> > 
> > On 15.09.21 14:05, Michael Walle wrote:
> > > Am 2021-09-15 14:03, schrieb Heiko Thiery:
> > > > The buck2 output of the PMIC is the VDD core voltage of the cpu.
> > > > Switching off this will poweroff the CPU. Add the 'regulator-always-on'
> > > > property to avoid this.
> > > 
> > > Mh, have this ever worked? Is there a commit which introduced a regression?
> > 
> > Yes, this did work before, even without 'regulator-always-on'. I
> > currently don't understand why this is needed. The regulator is
> > referenced in the CPU nodes as 'cpu-supply'. This should be enough to
> > not disable it as long as the CPU is up.
> 
> I rechecked that with 5.11, 5.10 and 5.9 and I see on all of them the
> same issue:
> 
> [ 31.716031] vdd-5v: disabling
> [ 31.719032] rst-usb-eth2: disabling
> [ 31.722553] buck2: disabling
> 
> While on that I tried to compare with other boards and see that they
> also have the cpu-voltage marked as "regulator-always-on". The only
> exception in dts/freescale is in imx8mq-librem5-devkit.dts [1] that
> has not set this property.
> 
> I agree with you and don't understand why this is happening. Has
> anyone else an explanation?
> 
> [1] https://elixir.bootlin.com/linux/latest/source/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts#L319
> 
Maybe your kernel config is missing the cpufreq driver, so you don't
have a consumer of the regulator?

Marking the regulator as always-on seems like the right thing to do,
you don't want to depend on a consumer showing up to make sure that
your CPU voltage isn't cut...

Regards,
Lucas

