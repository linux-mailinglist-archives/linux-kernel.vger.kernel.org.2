Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B16945A9B9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 18:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239110AbhKWROR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 12:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239072AbhKWROQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 12:14:16 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37C3C06173E
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 09:11:07 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mpZJp-0004jt-LP; Tue, 23 Nov 2021 18:10:57 +0100
Message-ID: <f251be2a2ad9596bd11c84945747ffe68116c7cd.camel@pengutronix.de>
Subject: Re: [PATCH V3 0/9] arm64: imx8mn: Enable more imx8m Nano functions
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>
Cc:     Tim Harvey <tharvey@gateworks.com>,
        Fabio Estevam <festevam@gmail.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        open list <linux-kernel@vger.kernel.org>
Date:   Tue, 23 Nov 2021 18:10:55 +0100
In-Reply-To: <CAHCN7xKtakudWne1ZK8n3o4bVnnR02TLzsJ_Qgo8GnHed_sfTA@mail.gmail.com>
References: <20211104161804.587250-1-aford173@gmail.com>
         <CAJ+vNU2jcWyCm3UyiOnvknS0t+mSdpaB+CgGWYO3jxXTa3LhRA@mail.gmail.com>
         <CAHCN7xJrnZMQgXVMJg7MZdFMWyesf6Ph7HnfMH7-9bm1qODHFw@mail.gmail.com>
         <CAJ+vNU32GXtbKWGQXoE7pkXU8FcKh+HQJJduwRbRJ0tC-d6GoA@mail.gmail.com>
         <CAHCN7xLAm21zUJQ8s4s--+ygmeVY0qyo0WSLp7ZM9bT9R3sjxw@mail.gmail.com>
         <CAOMZO5Am4P17mOXWrPs0ns9AwOXM_ZpBdzbYTYJfv_48Ea=BHg@mail.gmail.com>
         <CAHCN7xLzR5LqqydC7uydsXQPFVn=nyqKD8ZEH3EjcPuwQky5WA@mail.gmail.com>
         <CAOMZO5AnXDV3jdR6hP_+uqyss4KftzjahcrGq1XA37nGsfQedw@mail.gmail.com>
         <CAHCN7xKJBHY1o94VDkBaXXFjMUm=5WoshddT4DVWD04aiPV8MA@mail.gmail.com>
         <CAHCN7xKpjVWiTvXpYH11kaHX=0Figh=ALQS4qnUroGCu-q3NNA@mail.gmail.com>
         <CAJ+vNU37=qPuuNaSsvRntKU5wbVZoOtS_tAx7En6EMGfKN=QLg@mail.gmail.com>
         <82c5da8862abaa430ee52b57e15d29a67106d61f.camel@pengutronix.de>
         <CAJ+vNU0ce1TTAHzT-ZE303ikmmwghutyObSQMJeHN8D0R8Gcdw@mail.gmail.com>
         <CAHCN7x+k=C=fxFZYJK6qpUFNDSddVGvfYPPLZ_LNOvhW6RNxmg@mail.gmail.com>
         <129460de1d6b02ad16fdac16a1437c5b2cbb3975.camel@pengutronix.de>
         <CAHCN7x+yt_-mQ14A+xw1-Qd2ucSniUqT_wPyp-0OedwUp8UDjA@mail.gmail.com>
         <CAHCN7xKtakudWne1ZK8n3o4bVnnR02TLzsJ_Qgo8GnHed_sfTA@mail.gmail.com>
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

Am Dienstag, dem 23.11.2021 um 10:40 -0600 schrieb Adam Ford:
> On Tue, Nov 23, 2021 at 8:30 AM Adam Ford <aford173@gmail.com> wrote:
> > 
> > On Tue, Nov 23, 2021 at 8:24 AM Lucas Stach <l.stach@pengutronix.de> wrote:
> > > 
> > > Am Dienstag, dem 23.11.2021 um 08:08 -0600 schrieb Adam Ford:
> > > > On Mon, Nov 22, 2021 at 3:52 PM Tim Harvey <tharvey@gateworks.com> wrote:
> > > > > 
> > > > > On Mon, Nov 22, 2021 at 10:20 AM Lucas Stach <l.stach@pengutronix.de> wrote:
> > > > > > 
> > > > > > Am Montag, dem 22.11.2021 um 09:59 -0800 schrieb Tim Harvey:
> > > > > > > On Sun, Nov 21, 2021 at 7:25 AM Adam Ford <aford173@gmail.com> wrote:
> > > > > > > > 
> > > > > > > > On Sun, Nov 21, 2021 at 8:34 AM Adam Ford <aford173@gmail.com> wrote:
> > > > > > > > > 
> > > > > > > > > On Sun, Nov 21, 2021 at 8:21 AM Fabio Estevam <festevam@gmail.com> wrote:
> > > > > > > > > > 
> > > > > > > > > > Hi Adam,
> > > > > > > > > > 
> > > > > > > > > > On Sun, Nov 21, 2021 at 11:17 AM Adam Ford <aford173@gmail.com> wrote:
> > > > > > > > > > 
> > > > > > > > > > > I am using https://source.codeaurora.org/external/imx/imx-atf/log/?h=lf_v2.4
> > > > > > > > > > > 
> > > > > > > > > > > Since the driver sending SMCC commands to ATF isn't doing that, I
> > > > > > > > > > > assume it's safe to use the linux power-domain drivers with the ATF
> > > > > > > > > > > from NXP's kernel.
> > > > > > > > > > > 
> > > > > > > > > > > If you can point me to the repo you think I should be using, I'll give it a try.
> > > > > > > > > > 
> > > > > > > > > > Do you know if the mainline TF-A repo v2.5 works too?
> > > > > > > > > > https://github.com/ARM-software/arm-trusted-firmware/tree/v2.5
> > > > > > > > > 
> > > > > > > > > That's good to know.
> > > > > > > > > 
> > > > > > > > > I just built it into U-Boot:
> > > > > > > > > 
> > > > > > > > > NOTICE:  BL31: v2.5(release):v2.5
> > > > > > > > > NOTICE:  BL31: Built : 08:24:13, Nov 21 2021
> > > > > > > > > 
> > > > > > > > > The Etnaviv driver is still loading without hanging
> > > > > > > > > 
> > > > > > > > > root@beacon-imx8mn-kit:~# dmesg |grep -i etna
> > > > > > > > > [   12.393936] etnaviv etnaviv: bound 38000000.gpu (ops gpu_ops [etnaviv])
> > > > > > > > > [   12.400676] etnaviv-gpu 38000000.gpu: model: GC7000, revision: 6203
> > > > > > > > > [   12.641297] [drm] Initialized etnaviv 1.3.0 20151214 for etnaviv on minor 0
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > 
> > > > > > > > Tim,
> > > > > > > > 
> > > > > > > > Which version of Nano do you have?  Not all Nano SoC's have a GPU from
> > > > > > > > looking at the datasheet [1] .  I am using MIMX8MN2CVTIZAA (Nano Solo)
> > > > > > > > 
> > > > > > > > [1] - https://www.nxp.com/docs/en/data-sheet/IMX8MNIEC.pdf
> > > > > > > > 
> > > > > > > 
> > > > > > > Adam,
> > > > > > > 
> > > > > > > The board I have here has MIMX8MN5CVTIZAA so i.MX 8M Nano QuadLite
> > > > > > > with 'No GPU' as you expected.
> > > > > > > 
> > > > > > > So I have to add the following to keep my board from hanging after your series:
> > > > > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
> > > > > > > b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
> > > > > > > index 236f425e1570..0d256a607b7c 100644
> > > > > > > --- a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
> > > > > > > +++ b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
> > > > > > > @@ -251,6 +251,10 @@
> > > > > > >         };
> > > > > > >  };
> > > > > > > 
> > > > > > > +&gpu {
> > > > > > > +       status = "disabled";
> > > > > > > +};
> > > > > > > +
> > > > > > >  &i2c1 {
> > > > > > >         clock-frequency = <100000>;
> > > > > > >         pinctrl-names = "default";
> > > > > > > 
> > > > > > > This situation is similar to the one I encountered with the
> > > > > > > imx8mm-venice-gw7901 where adding the GPC node caused my board (which
> > > > > > > did not power the GPU) to hang until I added disables to the
> > > > > > > device-tree with commit 7973009235e2 ("arm64: dts:
> > > > > > > imx8mm-venice-gw7901.dts: disable pgc_gpumix"). It feels painful to
> > > > > > > have to add patches to keep things from hanging after additional
> > > > > > > functionality is added to dt but perhaps that is more common than I
> > > > > > > think esp for SoC's like IMX8M which have a lot of lingering support
> > > > > > > still coming in.
> > > > > > > 
> > > > > > Yea, it's unfortunate that those patches break your board, but I guess
> > > > > > we need to accept this, while there is still a lot of feature work
> > > > > > going on.
> > > > 
> > > > There are a significant number of peripherals which are defined and
> > > > marked as 'disabled' by default, so I don't think it's unreasonable to
> > > > do that here.
> > > > I'd like to propose we keep the default disabled and people who
> > > > need/want the GPU enabled can turn it on.  Why waste the power if it's
> > > > not needed?
> > > > 
> > > Sure, if a significant number of chips has the GPU disabled, we might
> > > want to keep it disabled in the base dtsi. With those variants it's
> > > always a tradeoff, for example there are SKUs of the i.MX6 that had the
> > > VPU disabled, but very few of those were in the field, so the VPUs are
> > > enabled in the SoC base dtsi and only users of those special SKUs would
> > > need to disable them in the board DT.
> > > 
> > > The power argument isn't valid, as the kernel driver will suspend the
> > > device when not needed, so there is no wasted power (aside from the
> > > sort moment while the driver probes) with the GPU enabled.
> > > 
> > > The rule of thumb for when a device is default enabled in the SoC dsti
> > > has always been (at least for i.MX) that the peripheral must not have a
> > > board level dependency. While a i2c controller obviously needs a i2c
> > > bus connected on the board to fulfill its purpose, a GPU can be used as
> > > color space converter or something like that with no board level
> > > interaction. Now the line is a bit blurred by having multiple power
> > > rails into the SoC, so one could argue that the GPUs and VPUs now have
> > > some board level dependency on the i.MX8M*.
> > 
> > That makes sense.
> > 
> > Do we defer to Shawn as the final arbiter as to whether or not it's
> > enabled/disabled?  It would be nice to get Nano caught up in
> > functionality as much as possible.
> 
> We could add two more device trees, one for 8mnl (lite) and 8mnul (ulta-lite)
> 
> imx8mnl:
> 
> #include imx8mn.dtsi
> 
> &gpu {
>     status = "disabled";
> };
> 
> 
> imx8mnul:
> 
> #include imx8mnl
> 
> &dsi {
>     status = "disabled";
> };
> 
> Then the boards using either lite or ultralite just include their
> respective SoC.dtsi instead of imx8mn.dtsi.  This is similar to what
> we do with the plethora of i.mx6 options.
> 
Yes, that's an option but it quickly blows up in a combinatorial
explosion. As the chips are pin compatible there is a high probability
that hardware makers will start to offer boards with different feature
sets and then you need to have a number of board DTs just to include
the right dtsi for the chip.

> Just a thought.  Although, I really like the idea of the bootloader
> disabling the unavailable nodes.

Yea, it seems there are even fuses that allow to check those
capabilities, see my reply to Tim. So I think relying on the boot
firmware to fix things up would be the best option, as it allows to
keep the number of DTs small and does not place a big burden on the
boot firmware implementation.

Regards,
Lucas

