Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA22B45A995
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 18:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238124AbhKWRGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 12:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbhKWRGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 12:06:35 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1DFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 09:03:26 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mpZCM-0003y3-Qr; Tue, 23 Nov 2021 18:03:14 +0100
Message-ID: <1b5bb77bdd751052ffad43b7cccfff4a2eb5f7cd.camel@pengutronix.de>
Subject: Re: [PATCH V3 0/9] arm64: imx8mn: Enable more imx8m Nano functions
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Adam Ford <aford173@gmail.com>, Fabio Estevam <festevam@gmail.com>,
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
Date:   Tue, 23 Nov 2021 18:03:13 +0100
In-Reply-To: <CAJ+vNU0ce1TTAHzT-ZE303ikmmwghutyObSQMJeHN8D0R8Gcdw@mail.gmail.com>
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

Am Montag, dem 22.11.2021 um 13:52 -0800 schrieb Tim Harvey:
> On Mon, Nov 22, 2021 at 10:20 AM Lucas Stach <l.stach@pengutronix.de> wrote:
> > 
> > Am Montag, dem 22.11.2021 um 09:59 -0800 schrieb Tim Harvey:
> > > On Sun, Nov 21, 2021 at 7:25 AM Adam Ford <aford173@gmail.com> wrote:
> > > > 
> > > > On Sun, Nov 21, 2021 at 8:34 AM Adam Ford <aford173@gmail.com> wrote:
> > > > > 
> > > > > On Sun, Nov 21, 2021 at 8:21 AM Fabio Estevam <festevam@gmail.com> wrote:
> > > > > > 
> > > > > > Hi Adam,
> > > > > > 
> > > > > > On Sun, Nov 21, 2021 at 11:17 AM Adam Ford <aford173@gmail.com> wrote:
> > > > > > 
> > > > > > > I am using https://source.codeaurora.org/external/imx/imx-atf/log/?h=lf_v2.4
> > > > > > > 
> > > > > > > Since the driver sending SMCC commands to ATF isn't doing that, I
> > > > > > > assume it's safe to use the linux power-domain drivers with the ATF
> > > > > > > from NXP's kernel.
> > > > > > > 
> > > > > > > If you can point me to the repo you think I should be using, I'll give it a try.
> > > > > > 
> > > > > > Do you know if the mainline TF-A repo v2.5 works too?
> > > > > > https://github.com/ARM-software/arm-trusted-firmware/tree/v2.5
> > > > > 
> > > > > That's good to know.
> > > > > 
> > > > > I just built it into U-Boot:
> > > > > 
> > > > > NOTICE:  BL31: v2.5(release):v2.5
> > > > > NOTICE:  BL31: Built : 08:24:13, Nov 21 2021
> > > > > 
> > > > > The Etnaviv driver is still loading without hanging
> > > > > 
> > > > > root@beacon-imx8mn-kit:~# dmesg |grep -i etna
> > > > > [   12.393936] etnaviv etnaviv: bound 38000000.gpu (ops gpu_ops [etnaviv])
> > > > > [   12.400676] etnaviv-gpu 38000000.gpu: model: GC7000, revision: 6203
> > > > > [   12.641297] [drm] Initialized etnaviv 1.3.0 20151214 for etnaviv on minor 0
> > > > > 
> > > > > 
> > > > 
> > > > Tim,
> > > > 
> > > > Which version of Nano do you have?  Not all Nano SoC's have a GPU from
> > > > looking at the datasheet [1] .  I am using MIMX8MN2CVTIZAA (Nano Solo)
> > > > 
> > > > [1] - https://www.nxp.com/docs/en/data-sheet/IMX8MNIEC.pdf
> > > > 
> > > 
> > > Adam,
> > > 
> > > The board I have here has MIMX8MN5CVTIZAA so i.MX 8M Nano QuadLite
> > > with 'No GPU' as you expected.
> > > 
> > > So I have to add the following to keep my board from hanging after your series:
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
> > > b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
> > > index 236f425e1570..0d256a607b7c 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
> > > @@ -251,6 +251,10 @@
> > >         };
> > >  };
> > > 
> > > +&gpu {
> > > +       status = "disabled";
> > > +};
> > > +
> > >  &i2c1 {
> > >         clock-frequency = <100000>;
> > >         pinctrl-names = "default";
> > > 
> > > This situation is similar to the one I encountered with the
> > > imx8mm-venice-gw7901 where adding the GPC node caused my board (which
> > > did not power the GPU) to hang until I added disables to the
> > > device-tree with commit 7973009235e2 ("arm64: dts:
> > > imx8mm-venice-gw7901.dts: disable pgc_gpumix"). It feels painful to
> > > have to add patches to keep things from hanging after additional
> > > functionality is added to dt but perhaps that is more common than I
> > > think esp for SoC's like IMX8M which have a lot of lingering support
> > > still coming in.
> > > 
> > Yea, it's unfortunate that those patches break your board, but I guess
> > we need to accept this, while there is still a lot of feature work
> > going on.
> > 
> > > I don't mind at all submitting the above patch to fix my board after
> > > your series is accepted as I think that having an IMX8MN with 'no gpu'
> > > is perhaps less likely than having one with a GPU and thus we probably
> > > shouldn't mark the node as disabled and force everyone that has a GPU
> > > to go and enable it.
> > > 
> > > I wonder however if we should think about adding something to etnaviv
> > > to check the capability so that the same dt could be used with both
> > > CPU variants?
> > 
> > etnaviv or really the kernel at all is not the place to handle this.
> > The DT is supposed to describe the hardware and the kernel should be
> > able to trust this description.
> > 
> > If there is some way to read the chip capabilities and avoid having too
> > much DT variants in the kernel, the right place to handle this is the
> > software running before the kernel is started, i.e. your bootloader.
> > Barebox for example reads the SCU fuses on i.MX6 and removes the DT
> > nodes for the fused off CPU cores on i.MX6S and i.MX6D.
> > 
> 
> Lucas,
> 
> I agree - the boot firmware is an appropriate place for this. I
> believe the correct course of action in the case of the IMX8M Nano
> would be to do the following for no GPU:
> - disable disp_blk_ctrl node
> - disable gpu node
> - disable pgc_gpumix node
> 
> What would you propose to do for detection of this in boot firmware?
> The DIGPROG register is currently used in U-Boot to determine IMX8M
> variants including Nano
> Qad/Dual/Solo/QaudLite/DualLite/SoloLite/UltraLite Quad/UltraLite
> Dual/UltraLite Solo. It would appear all the 'Lite' and 'UltraLite'
> variants have no GPU.

According to the fusemap there are even individual fuses to indicate
disabled GPU, DSI, CSI and other peripherals (table 6-31 in the 8MN RM,
0x450 range). I would expect that those are burned correctly on the
stripped down SKUs. Maybe you can validate this on your side?

Regards,
Lucas

