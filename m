Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10EA9452A5A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 07:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236739AbhKPGLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 01:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbhKPGLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 01:11:04 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660EBC061570;
        Mon, 15 Nov 2021 22:08:08 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id i9so19493849qki.3;
        Mon, 15 Nov 2021 22:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I3oQyh1i67EI9sCW3pQlUFVmFFrrPdE1dpx1lb+xR2U=;
        b=E9OjszSmwpNQ1taXDWq1P1iNQZBuIsSmoMRgF0L3fgDwV+ydKR63vsHfTocvsPlpHU
         DYTeHToo4XaVlAnMH9jqGnJNBI6qDg9pxEbGd8Z7noiXjXn3jsqqBNKljPRI1Y1YkaXE
         t0+1CZ0sZ42qgvHtea/vCOFqvA+ArkYy9zFPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I3oQyh1i67EI9sCW3pQlUFVmFFrrPdE1dpx1lb+xR2U=;
        b=Lhbm02PxaYf55F3jXND8L9GCdBowbk+otX/KVkBXb36SJhU7kqXr7bcOJjdKiuQi8g
         szUMaf07FdiLOM2NmQO278djIStD1j1vg620ZDQBU4CfsoVy8DVe0WxS7NosnJY9x0r+
         EzkzKlRcbMwdX7s7Mi+aLZhBZjU/7B7YIt+JN9hT+nm2Y+UnCwu+TazL6ORE8/vdq9Fq
         YbwtvGQnTKiut6oUeCEfwOn+Ytdf/wapfByb7B8DVbqCKK9HhWPGjvpjapqYqkhRUdrU
         synKUY7Q5jVKBD2RgcrSK5K4S9mJJEHinmyNi/MbdwQIDukbCdM9iD7A4BO/VNIMjSkv
         H7MA==
X-Gm-Message-State: AOAM531s+cOE356G7g46iE32F4Gr6wJBZouAK9tByCWLTS0gbcZz+ERO
        Fmy4A+7Sa4uJoK+q9Wj4vba4EYMB5MIQShi4NNc=
X-Google-Smtp-Source: ABdhPJxg2WkPIsuOSay/GYggygOyktUFgy0Tfd4Ccq6kw0J8FhevHPTHEN5D5sp3cEHRxaqlDRsubd6rTcg2+5hU1BQ=
X-Received: by 2002:a37:a8e:: with SMTP id 136mr4211384qkk.395.1637042887509;
 Mon, 15 Nov 2021 22:08:07 -0800 (PST)
MIME-Version: 1.0
References: <20211026200058.2183-1-aladyshev22@gmail.com> <CACPK8Xd5eYpsFNw1jEjv3NaShgzE3zC_Ct29pJM34TfrqRTNtQ@mail.gmail.com>
 <CACSj6VVTFa0t9WK=R2TucG7eFqUzBsWYFzvsaRt6eXOiFuQORA@mail.gmail.com>
In-Reply-To: <CACSj6VVTFa0t9WK=R2TucG7eFqUzBsWYFzvsaRt6eXOiFuQORA@mail.gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 16 Nov 2021 06:07:55 +0000
Message-ID: <CACPK8Xcc6Nem00zZdGmHF=U4T2O90aL+_vKO4YmAqSW9wKeegA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: Add AMD DaytonaX BMC
To:     Konstantin Aladyshev <aladyshev22@gmail.com>,
        Patrick Williams <patrick@stwcx.xyz>
Cc:     Supreeth Venkatesh <supreeth.venkatesh@amd.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Andrew Geissler <geissonator@yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2021 at 10:59, Konstantin Aladyshev
<aladyshev22@gmail.com> wrote:
>
> Thanks for the comments. Can I ask you some questions about this
> `device-tree-gpio-naming.md`?
>
> 1) First of all in my naming I've tried to use naming scheme the same
> as the EthanolX CRB DTS currently has
> (https://github.com/torvalds/linux/blob/d25f27432f80a800a3592db128254c8140bd71bf/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts#L102).
> Do you want me to change GPIO naming in the EthanolX CRB as well?

Yeah, that would make sense.

> 2) Also this naming comes from the signal names in the board
> schematics. This way it is clear to check schematics vs DTS. If we use
> this OpenBMC naming style, we will lose that correspondence. Is it
> really good?

This is a good point. The preference is to use human readable names
over the schematic net. I can see cases where this would be worse, but
hopefully on balance it results in consistent naming between machines.

> 3) In the initial version of the DTS file I've supplied only a minimal
> set of GPIO, that are used by OpenBMC. GPIOs for x86-power-control app
> and led id/fault gpios. With renaming these GPIOs I'm only sure about
> these GPIOs:
>
> FAULT_LED                  - led-fault
> CHASSIS_ID_BTN        - led-identify
>
> What about the rest? For example the document doesn't really state
> what the *-button postfix states? Is it for asserting or monitoring
> buttons? How should I name these signals?
>
> ASSERT_BMC_READY
> ASSERT_RST_BTN
> ASSERT_PWR_BTN
>
> MON_P0_RST_BTN
> MON_P0_PWR_BTN
> MON_P0_PWR_GOOD
> MON_PWROK
>
> Can you help me with those?

Patrick, do you have thoughts here?

>
> 4) And what should I do to the board GPIO signals that OpenBMC doesn't
> use? If you look at the EthanolX CRB DTS
> (https://github.com/torvalds/linux/blob/d25f27432f80a800a3592db128254c8140bd71bf/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts#L102)
> it has a ton of GPIOs. Should they be renamed to this OpenBMC style as
> well? Or can they be named exactly like in the schematics?

That's up to you.

>
> I've also CCed original author of the `device-tree-gpio-naming.md`
> document Andrew Geissler. Andrew, can you please provide your opinion
> on the subject?

I've also added Patrick, who is helping review this document.

Cheers,

Joel

>
> Best regards,
> Konstantin Aladyshev
>
> On Wed, Oct 27, 2021 at 12:03 AM Joel Stanley <joel@jms.id.au> wrote:
> >
> > Hello Konstantin,
> >
> > On Tue, 26 Oct 2021 at 20:01, Konstantin Aladyshev
> > <aladyshev22@gmail.com> wrote:
> > >
> > > Add initial version of device tree for the BMC in the AMD DaytonaX
> > > platform.
> > >
> > > AMD DaytonaX platform is a customer reference board (CRB) with an
> > > Aspeed ast2500 BMC manufactured by AMD.
> > >
> > > Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
> >
> > This looks good. I have one comment about the GPIOs below.
> >
> > > +&gpio {
> > > +       status = "okay";
> > > +       gpio-line-names =
> > > +       /*A0-A7*/       "","","FAULT_LED","","","","","",
> > > +       /*B0-B7*/       "","","","","","","","",
> > > +       /*C0-C7*/       "CHASSIS_ID_BTN","","","","","","","",
> > > +       /*D0-D7*/       "","","ASSERT_BMC_READY","","","","","",
> > > +       /*E0-E7*/       "MON_P0_RST_BTN","ASSERT_RST_BTN","MON_P0_PWR_BTN","ASSERT_PWR_BTN","",
> > > +                       "MON_P0_PWR_GOOD","MON_PWROK","",
> >
> > For systems that will run openbmc, we try to use naming conventions
> > from this document:
> >
> > https://github.com/openbmc/docs/blob/master/designs/device-tree-gpio-naming.md
> >
> > If a GPIO is missing from that doc I encourage you to add it.
