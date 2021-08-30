Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9A63FB053
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 06:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhH3ER6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 00:17:58 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:38915 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229588AbhH3ER5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 00:17:57 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id D7CFF320079B;
        Mon, 30 Aug 2021 00:17:03 -0400 (EDT)
Received: from imap43 ([10.202.2.93])
  by compute2.internal (MEProxy); Mon, 30 Aug 2021 00:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm3; bh=ewWxf
        mI39eJVwZg5H/+URQqmEXLNSAmkl/a31Eod1gE=; b=UhODAn4NkufvXgMoN2xZF
        5Ldwo9A99kR6p2UOxRyeNt2sODf1iG8iUVs7Fi3FrOiqAFj8vPh0pzHt3ue6vh6x
        01FEDqVwj1YaHuyjlSzvFY8efj5kGcOfYS1tfgZt7ktrIZdzQleQVPjznCc86tRj
        VWWtoFHoAac0WJJt0i4HLsJIqswEq5UcxsUlExodB5ovuwTsl1jy/sNle2YWTDJu
        6YvqdoXQ1jkgWVEwRpL3gP3c8TZQW+E2Eo8lZyg4lUUJBcWFh8w/O1LfNtFqM/dJ
        XAVRVhqAW2eBZ46nQfXQCIjsCbNIvACkhwoy1jCOVGSd92PDns1oifudTVh8aB2W
        Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=ewWxfmI39eJVwZg5H/+URQqmEXLNSAmkl/a31Eod1
        gE=; b=nivjNuvFLOePa+c0LNw5Xpz8N+bEeRc1GIESAOon5CnzXc/Wh9sdVNNt3
        WxD0h4gS05lho0U8B5wIbBQTyZfvVxllWdM1zr5nCPurYRd2qSStFIqdlQTxTuUQ
        KM56pomIQn20tUP6KSG4n41yapNnCeOaqNlNzqydcrcfq4bDvZMYnrQtxoiGZTnE
        +apaEOdd3tuZmSdVreOg/u7KZ18simDI9Fw6E7IOsE3TTRbE8aaZGQdH12OL84Am
        aX32wMwhHH34MO39zYTNvic75fapAEP4ZxRY5MDCijTOOZIvh9Vnm0NoOZyjs0R1
        tC3UDbScOkl09ULcUYL3ptAUuw9lA==
X-ME-Sender: <xms:vVssYUxYWm0rODA90AAUXIyzV3CpQzP9PD961xtX-ejcOpYbkeDZ7Q>
    <xme:vVssYYT80VAtdiOOszb-tq28j8QexiOkFDfIR4x8sxUwJwuxVlHlIbZRaTYF7k0LX
    6D6cWC_zlfZ1ad2CQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddukedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtf
    frrghtthgvrhhnpedvgeekheegfedvhfethefhudetteegueeggfeiieegueehkedugedt
    kefglefgheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:vVssYWV0V0uqQ_kRZ001kopPJmxsf9guSw1QWT5IdM8in3lSC_bV4g>
    <xmx:vVssYSi5zs7snYZCMGB_0cfuXct6XFznuAOCujhrSJnTNk7lsVr4eQ>
    <xmx:vVssYWCKgmVCOU4cXeMTyF4A3VXtM2Ntk_gE7p6JE6zt4luFr4t2Xw>
    <xmx:v1ssYZ_GaeDR_F9DrUverRsPoYtbawwvHTklt78N0KKm7Ox1Wv5G9g>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4C7EEAC0362; Mon, 30 Aug 2021 00:17:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1125-g685cec594c-fm-20210825.001-g685cec59
Mime-Version: 1.0
Message-Id: <4c87cee3-2dfb-41e7-a18b-5ed4687a6f7a@www.fastmail.com>
In-Reply-To: <567a65a8-077b-7394-c8e2-dbd9f063e02c@kaod.org>
References: <20210724224424.2085404-1-linus.walleij@linaro.org>
 <20210724224424.2085404-2-linus.walleij@linaro.org>
 <20210821042010.GA1759866@roeck-us.net>
 <CACRpkdYObGTWni3sSa21iNsgikzj7t9MA6y4TNgkBTTYQt+coA@mail.gmail.com>
 <4d87c7af-d2e3-9456-130a-b35b507ff3a2@roeck-us.net>
 <567a65a8-077b-7394-c8e2-dbd9f063e02c@kaod.org>
Date:   Mon, 30 Aug 2021 13:46:16 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        "Guenter Roeck" <linux@roeck-us.net>,
        "Linus Walleij" <linus.walleij@linaro.org>
Cc:     "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Joel Stanley" <joel@jms.id.au>
Subject: Re: [PATCH 2/2] clocksource/drivers/fttmr010: Be stricter on IRQs
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 28 Aug 2021, at 17:38, C=C3=A9dric Le Goater wrote:
> Hello,
>=20
> On 8/28/21 5:37 AM, Guenter Roeck wrote:
> > On 8/27/21 3:01 PM, Linus Walleij wrote:
> >> On Sat, Aug 21, 2021 at 6:20 AM Guenter Roeck <linux@roeck-us.net> =
wrote:
> >>> On Sun, Jul 25, 2021 at 12:44:24AM +0200, Linus Walleij wrote:
> >>
> >>>> Make sure we check that the right interrupt occurred before
> >>>> calling the event handler for timer 1. Report spurious IRQs
> >>>> as IRQ_NONE.
> >>>>
> >>>> Cc: C=C3=A9dric Le Goater <clg@kaod.org>
> >>>> Cc: Joel Stanley <joel@jms.id.au>
> >>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> >>>
> >>> This patch results in boot stalls with several qemu aspeed emulati=
ons
> >>> (quanta-q71l-bmc, palmetto-bmc, witherspoon-bmc, ast2500-evb,
> >>> romulus-bmc, g220a-bmc). Reverting this patch together with
> >>> "clocksource/drivers/fttmr010: Clear also overflow bit on AST2600"
> >>> fixes the problem. Bisect log is attached.
> >>
> >> Has it been tested on real hardware?
>=20
> It breaks the AST2500 EVB.
> =20
> >>
> >> We are reading register 0x34 TIMER_INTR_STATE for this.
> >> So this should reflect the state of raw interrupts from the timers.
> >>
> >> I looked in qemu/hw/timer/aspeed_timer.c
> >> and the aspeed_timer_read() looks dubious.
> >> It rather looks like this falls down to returning whatever
> >> was written to this register and not reflect which IRQ
> >> was fired at all.
> >>
> >=20
> > Actually, no. Turns out the qemu code is just a bit difficult to und=
erstand.
> > The code in question is:
> >=20
> > =C2=A0=C2=A0=C2=A0 default:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value =3D ASPEED_TIMER_GE=
T_CLASS(s)->read(s, offset);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> >=20
> > For ast2500-evb, that translates to a call to aspeed_2500_timer_read=
().
> > Here is a trace example (after adding some more tracing):
> >=20
> > aspeed_2500_timer_read From 0x34: 0x0
> > aspeed_timer_read From 0x34: of size 4: 0x0
> >=20
> > Problem is that - at least in qemu - only the 2600 uses register 0x34
> > for the interrupt status. On the 2500, 0x34 is the ctrl2 register.
> >=20
> > Indeed, the patch works fine on, for example, ast2600-evb.
> > It only fails on ast2400 and ast2500 boards.
>=20
> The QEMU modelling is doing a good job ! I agree that the timer model=20
> is not the most obvious one to read.=20

I'll buy a drink for whoever refactors it and improves readability :)

>=20
> > I don't have the manuals, so I can't say what the correct behavior i=
s,
> > but at least there is some evidence that TIMER_INTR_STATE may not ex=
ist
> > on ast2400 and ast2500 SOCs.=20
>=20
> On Aspeed SoCs AST2400 and AST2500, the TMC[34] register is a
> "control register #2" whereas on the AST2600 it is an "interrupt
> status register" with bits [0-7] holding the timers status.
>=20
> I would say that the patch simply should handle the "is_aspeed" case. =20

Well, is_aspeed is set true in the driver for all of the 2400, 2500 and=20
2600. 0x34 behaves the way this patch expects on the 2600. So I think=20
we need something less coarse than is_aspeed?

Andrew
