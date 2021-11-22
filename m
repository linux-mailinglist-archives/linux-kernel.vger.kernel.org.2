Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE5E458EA1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 13:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238812AbhKVMuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 07:50:02 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:39852 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229797AbhKVMuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 07:50:01 -0500
X-UUID: 4e36668dcf5244cfa05fa69adace636f-20211122
X-UUID: 4e36668dcf5244cfa05fa69adace636f-20211122
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1208133963; Mon, 22 Nov 2021 20:46:50 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 22 Nov 2021 20:46:49 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 22 Nov
 2021 20:46:49 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 22 Nov 2021 20:46:49 +0800
Message-ID: <cc6e73ba980ee13f8ab29862140d0bfe44ed9d7f.camel@mediatek.com>
Subject: Re: [PATCH v7 2/3] arm64: dts: mediatek: add basic mt7986a support
From:   Sam Shih <sam.shih@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Enric Balletbo i Serra" <enric.balletbo@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Seiya Wang <seiya.wang@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     John Crispin <john@phrozen.org>, Ryder Lee <Ryder.Lee@mediatek.com>
Date:   Mon, 22 Nov 2021 20:46:49 +0800
In-Reply-To: <a4605e32-3af3-5636-6682-475bef8448d1@gmail.com>
References: <20211018114009.13350-1-sam.shih@mediatek.com>
         <20211018114009.13350-3-sam.shih@mediatek.com>
         <d411aec5-efa8-c71d-8179-54ff52c17039@gmail.com>
         <d299493d8fec0f34f527942f2cdedf15f2136c9a.camel@mediatek.com>
         <c5c0849d-a95a-25a0-11f8-9156770afc10@gmail.com>
         <59963509ec833009f5c10f0a1aee91670224c6c7.camel@mediatek.com>
         <a4605e32-3af3-5636-6682-475bef8448d1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2021-11-19 at 11:31 +0100, Matthias Brugger wrote:
> 	
> 
> On 18/11/2021 04:48, Sam Shih wrote:
> > Hi
> > 
> > On Tue, 2021-11-16 at 12:18 +0100, Matthias Brugger wrote:
> > > 
> > > On 16/11/2021 02:39, Sam Shih wrote:
> > > > Hi,
> > > > 
> > > > On Mon, 2021-11-15 at 17:27 +0100, Matthias Brugger wrote:
> > > > > Hi,
> > > > > 
> > > > > On 18/10/2021 13:40, Sam Shih wrote:
> > > > > > Add basic chip support for Mediatek mt7986a, include
> > > > > > basic uart nodes, rng node and watchdog node.
> > > > > > 
> > > > > > Add cpu node, timer node, gic node, psci and reserved-
> > > > > > memory
> > > > > > node
> > > > > > for ARM Trusted Firmware.
> > > > > > 
> > > > > 
> > > > > What is the exact difference between mt7986a and mt7986b?
> > > > > Right
> > > > > now,
> > > > > it's only
> > > > > the compatible, for that it makes no sense to split them.
> > > > > 
> > > > 
> > > > The difference between mt7986a and mt7986b is pinout which
> > > > described
> > > > in our pinctrl patch series
> > > > 
> > 
> > 
https://urldefense.com/v3/__https://lore.kernel.org/all/20211022124036.5291-3-sam.shih@mediatek.com/__;!!CTRNKA9wMg0ARbw!0kseU8x1KnHHXDErh6Yj6MKqecufPEfGyeumtTBism47e99UFO2Gs-HfWjL1_jUv$
> > > >   
> > > > 
> > > > You are right, in this "basic SoC support" patch series, only
> > > > show
> > > > compatible differences
> > > > 
> > > > > It would be good to see what the exact differences are, so
> > > > > that
> > > > > we
> > > > > can see if it
> > > > > makes sense to have one of the alternatives:
> > > > > 1) use a common mt7986.dtsi which get included by
> > > > > mt7986[a,b].dtsi
> > > > > 2) Use on mt7986.dtsi and only add one mt7986a.dtsi or
> > > > > mt7986b.dtsi
> > > > > which has
> > > > > add-ons.
> > > > > 
> > > > 
> > > > In this case, can we use solution (1) to create a generic
> > > > mt7986.dtsi
> > > > in this patch series, and add mt7986[a,b].dtsi to the dts part
> > > > of
> > > > the
> > > > pinctrl patch series to separate the difference nodes?
> > > > 
> > > 
> > > If the only difference is the GPIO controller then why not go
> > > with
> > > solution 2.
> > > Create a mt7986.dtsi which holds e.g. the node for pincontroller
> > > mt7986a and
> > > then create a mt7986b.dtsi that just changes compatible and gpio-
> > > ranges:
> > > 
> > > &pio {
> > >      compatible = "mediatek,mt7986b-pinctrl";
> > >      gpio-ranges = <&pio 0 0 41>, <&pio 66 66 35>;
> > > }
> > > 
> > > What do you think?
> > 
> > Ok,
> > 
> > For this basic patch series DTS, I will send the next version:
> > - Use "mt7986.dtsi" instead of "mt7986[a,b].dtsi",
> >    And make"mt7986.dtsi" get included by "mt7986[a,b]-rfb.dts"
> >    (No dedicated uart1/uart2 pinout for mt7986b-rfb, status of dts
> > node
> > shoud be set to "disabled")
> > 
> > 
> > For the pinctrl patch series DTS, I will send th next version:
> > - Add "mt7986b.dtsi" according to your suggestion,
> >    the new include
> > chain will be:
> >    mt7986a-rfb.dts <-- mt7986.dtsi (mt7986a pinctrl)
> >   
> > mt7986b-rfb.dts <-- mt7986b.dtsi (mt7986b pinctrl) <-- mt7986.dtsi
> > (mt7986a pinctrl)
> > 
> > Do you agree above proposal?
> > 
> 
> I mean something like this:
> mt7986a.dtsi:
> pio: pinctrl@1001f000 {
> 	compatible = "mediatek,mt7986a-pinctrl";
> 	reg = <0 0x1001f000 0 0x1000>,
> 	      <0 0x11c30000 0 0x1000>,
> 	      <0 0x11c40000 0 0x1000>,
> 	      <0 0x11e20000 0 0x1000>,
> 	      <0 0x11e30000 0 0x1000>,
> 	      <0 0x11f00000 0 0x1000>,
> 	      <0 0x11f10000 0 0x1000>,
> 	      <0 0x1000b000 0 0x1000>;
> 	reg-names = "gpio", "iocfg_rt", "iocfg_rb", "iocfg_lt",
> 		    "iocfg_lb", "iocfg_tr", "iocfg_tl", "eint";
> 	gpio-controller;
> 	#gpio-cells = <2>;
> 	gpio-ranges = <&pio 0 0 100>;
> 	interrupt-controller;
> 	interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
> 	interrupt-parent = <&gic>;
> 	#interrupt-cells = <2>;
> };
> 
> mt7986b.dtsi:
> #include "mt7986a.dtsi"
> 
> &pio {
>       compatible = "mediatek,mt7986b-pinctrl";
>       gpio-ranges = <&pio 0 0 41>, <&pio 66 66 35>;
> }
> 
> mt7986b-rfb.dts:
> #include "mt7986b.dtsi"
> 
> &pio {
> 	uart1_pins: uart1-pins {
> 		mux { [...]
> 
> 
> mt7986a-rfb.dts:
> #include "mt7986a.dtsi"
> 
> &pio {
> 	uart1_pins: uart1-pins {
> 		mux { [...]
> 
> 
> Makes sense?
> 

Okay,

I have sent new patch set based on your suggestion,

Basic Part:

https://lore.kernel.org/all/20211122123222.8016-1-sam.shih@mediatek.com/

Pinctrl:

https://lore.kernel.org/all/20211122123552.8218-1-sam.shih@mediatek.com/

Please take a look at those patches when you are free.

Regards,
Sam

> Regards,
> Matthias
> 

