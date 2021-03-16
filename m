Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47A133CFFE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 09:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbhCPIgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 04:36:36 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:59075 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbhCPIgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 04:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1615883772; x=1647419772;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZAb2QZBNc9gZgwRbjqXLpn0mCs+bbSoKJvvznqLvH68=;
  b=TrQitV+bDHalrRMAmaPikaODpsPjA7kYsGRTp+3PqKFeaLzUa94bYFEn
   F5vqob7NkipJwcOXYYsRqrSpGZ7ojdZvv6xDEXsMzXkMjylMDdY2w4frt
   KZ0+J8TfDyrSUPAHm5AEGh1fAdMuOevRL4h7Gdun9Sp2jgPYqf8CjdPE3
   g1mvOr4Gs+rrRepCGHwYw7ULmfQWenxq7C7bRy2DlGP0mnjsx1HNV3FdJ
   ZCGMkGQdvagODw0+9l8e4fOxOquerJ6+3ajq74Mm7hw3sBWOJ7yt8ZTlw
   7z1lG/RU4JQig//3lWZSMRvjJgmoK6k8IeEr7XY7z5ErT0au2+GDA426Y
   Q==;
IronPort-SDR: 9mj46EXfq7cn3qxr9/Q7OUPQjgBDlYTLpGOwyleVBIZmz9ZCtv/XK7R3GV1Wk8mDbxhlXoxfRA
 nzfQIv51J5aIyYxmQZykqkUXETLW7qTFeLo96XvaFd9OvFiz4VqGXo+mcX5scAwpZLnvuyrw2n
 Ez3IUHH5fAwdHIb4BFvvfusD9eVa+O55LwPLGSYDvbFvP397sO00D1Kziz20PTjOna6KD/iMYX
 ieL3srx17xKRF0H/pNzpFp/KdpuTI5oAyYqSzGrqfAXy88jb2yxSE4xArO7nOPZVB37fPruaNL
 PEI=
X-IronPort-AV: E=Sophos;i="5.81,251,1610434800"; 
   d="scan'208";a="112895607"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Mar 2021 01:36:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 16 Mar 2021 01:36:10 -0700
Received: from tyr.hegelund-hansen.dk (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 16 Mar 2021 01:36:08 -0700
Message-ID: <319ae8336916458f416f8ed973feafcbed701b48.camel@microchip.com>
Subject: Re: [PATCH v7 3/3] arm64: dts: reset: add microchip sparx5 switch
 reset driver
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Rob Herring <robh@kernel.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Date:   Tue, 16 Mar 2021 09:36:07 +0100
In-Reply-To: <20210308195934.GA2855503@robh.at.kernel.org>
References: <20210303081158.684532-1-steen.hegelund@microchip.com>
         <20210303081158.684532-4-steen.hegelund@microchip.com>
         <20210308195934.GA2855503@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, 2021-03-08 at 12:59 -0700, Rob Herring wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you
> know the content is safe
> 
> On Wed, Mar 03, 2021 at 09:11:58AM +0100, Steen Hegelund wrote:
> > This provides reset driver support for the Microchip Sparx5 PCB134
> > and
> > PCB135 reference boards.
> 
> This still looks like an incompatible change with no explanation.
> 
> What happens on an old kernel that expects "microchip,sparx5-chip-
> reset"
> and doesn't understand "microchip,sparx5-switch-reset"?

Sorry about forgetting that item.
I will add a note to say that this is an incompatible change.
In practice, I do not think the reset driver has really been taken into
use yet.

> 
> > 
> > Signed-off-by: Steen Hegelund <steen.hegelund@microchip.com>
> > ---
> >  arch/arm64/boot/dts/microchip/sparx5.dtsi | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi
> > b/arch/arm64/boot/dts/microchip/sparx5.dtsi
> > index 380281f312d8..dc3ada5cf9fc 100644
> > --- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
> > +++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
> > @@ -132,9 +132,12 @@ mux: mux-controller {
> >                       };
> >               };
> > 
> > -             reset@611010008 {
> > -                     compatible = "microchip,sparx5-chip-reset";
> > +             reset: reset-controller@611010008 {
> > +                     compatible = "microchip,sparx5-switch-reset";
> >                       reg = <0x6 0x11010008 0x4>;
> > +                     reg-names = "gcb";
> > +                     #reset-cells = <1>;
> > +                     cpu-syscon = <&cpu_ctrl>;
> >               };
> > 
> >               uart0: serial@600100000 {
> > --
> > 2.30.1
> > 


-- 
BR
Steen

-=-=-=-=-=-=-=-=-=-=-=-=-=-=
steen.hegelund@microchip.com

