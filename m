Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3C338F4C5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 23:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbhEXVOj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 May 2021 17:14:39 -0400
Received: from gloria.sntech.de ([185.11.138.130]:43672 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233278AbhEXVOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 17:14:37 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1llHsk-0008Me-To; Mon, 24 May 2021 23:13:02 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/9] arm64: dts: rockchip: Prepare Rockchip RK1808
Date:   Mon, 24 May 2021 23:13:03 +0200
Message-ID: <3998020.X9hSmTKtgW@diego>
In-Reply-To: <87fsycw41m.wl-maz@kernel.org>
References: <20210516230551.12469-1-afaerber@suse.de> <7ef183f1-00f8-13c4-1fd3-eae9e0bbf74c@suse.de> <87fsycw41m.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 24. Mai 2021, 17:21:41 CEST schrieb Marc Zyngier:
> On Mon, 24 May 2021 14:32:41 +0100,
> Andreas Färber <afaerber@suse.de> wrote:
> > 
> > On 17.05.21 11:21, Marc Zyngier wrote:
> > > On Mon, 17 May 2021 00:05:45 +0100,
> > > Andreas Färber <afaerber@suse.de> wrote:
> > >>
> > >> Add an initial Device Tree for Rockchip RK1808 SoC.
> > >> Based on shipping TB-RK1808M0 DTB.
> > >>
> > >> Signed-off-by: Andreas Färber <afaerber@suse.de>
> > >> ---
> > >>  arch/arm64/boot/dts/rockchip/rk1808.dtsi | 203 +++++++++++++++++++++++
> > >>  1 file changed, 203 insertions(+)
> > >>  create mode 100644 arch/arm64/boot/dts/rockchip/rk1808.dtsi
> > >>
> > >> diff --git a/arch/arm64/boot/dts/rockchip/rk1808.dtsi b/arch/arm64/boot/dts/rockchip/rk1808.dtsi
> > >> new file mode 100644
> > >> index 000000000000..af2b51afda7d
> > >> --- /dev/null
> > >> +++ b/arch/arm64/boot/dts/rockchip/rk1808.dtsi
> > [...]
> > >> +		gic: interrupt-controller@ff100000 {
> > >> +			compatible = "arm,gic-v3";
> > >> +			reg = <0xff100000 0x10000>, /* GICD */
> > >> +			      <0xff140000 0xc0000>, /* GICR */
> > > 
> > > This is obviously wrong. You have two CPUs, and yet describe a range
> > > that spans 6. I guess this is a copy paste from rk3399 again?
> > 
> > Not on my part at least. As indicated, these numbers are what ships in
> > the DTB on the RK1808 card, as per dtc -I dtb -O dts. Could be a mistake
> > by Rockchip, of course.
> > 
> > Are you suggesting 0xc0000/6*2 = 0x40000 for two CPUs here?  Works
> > as bad as before - investigation still ongoing with latest next.
> > 
> > As for "obviously": The GICv3 YAML binding has no description for me to
> > validate those numbers: "GIC Redistributors (GICR), one range per
> > redistributor region" - says nothing about correlation to number of CPUs
> > or size per CPU, and the examples are not explaining either: 0x200000
> > has no number of CPUs associated, and by my calculation 0x800000 for 32
> > CPUs results in 0x40000 per CPU; but then again the examples also have
> > GICC etc. at diverging 0x2000 size.
> 
> The GICv3/v4 architecture spec does apply, and you should really have
> a look at what these sizes mean. What is the value of copy-pasting
> things without understanding it the first place?
> 
> > 
> > >> +			      <0xff300000 0x10000>, /* GICC */
> > >> +			      <0xff310000 0x10000>, /* GICH */
> > >> +			      <0xff320000 0x10000>; /* GICV */
> > >> +			interrupt-controller;
> > >> +			#interrupt-cells = <3>;
> > >> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> > >> +			#address-cells = <1>;
> > >> +			#size-cells = <1>;
> > >> +			ranges;
> > >> +
> > >> +			gic_its: msi-controller@ff120000 {
> > >> +				compatible = "arm,gic-v3-its";
> > >> +				reg = <0xff120000 0x20000>;
> > >> +				msi-controller;
> > >> +				#msi-cells = <1>;
> > >> +			};
> > > 
> > > What uses the ITS?
> > 
> > DT-wise seemingly only the __symbols__ table (named just "its" there, I
> > notice), so we could drop (or rename) the label if you prefer.
> 
> No, I am asking *what* uses the ITS. Is it just dangling without any
> user? No PCI bus making use of it?

just 2ct, as far as I remember the rk1808 does have a PCIe controller.
And the datasheet [0] does agree with my memory it seems


Heiko

[0] http://opensource.rock-chips.com/images/4/43/Rockchip_RK1808_Datasheet_V1.2_20190527.pdf


