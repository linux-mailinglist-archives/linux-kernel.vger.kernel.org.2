Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFE043C834
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 12:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241524AbhJ0LCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 07:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbhJ0LCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 07:02:16 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF003C061570;
        Wed, 27 Oct 2021 03:59:50 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id u21so5262129lff.8;
        Wed, 27 Oct 2021 03:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zsf5W6YqowSseyvuTUMml4+bgTU62PWsyrp4oNO1xMk=;
        b=HVlZRtxATzTeW9s77vFDU1/2HETT9Vc8F/2vUCf47K4QJbtvN1amTS5v97H6uQ9m5L
         hVgobVhWgmmJNor2lCPhE1GX6grKq6E1GRGsCSxIBo1iXLAyZ6ARA3n5JLWgohMWhcvn
         qz+kuyYksI8LPtBnpJXcZ37BHI7XjlHMUaJJepBjIHmNhUkeOdY23NYCq9VtJ5CzCpFQ
         2swWDx+TQ9eEQpc4yTEEh4+FODH9EPqQofcacFdqEIIwKmbcCgi8EovuLA/DqGoxtHIm
         m/bhGdtcz50fA2UdUVqIjZwUXV8cOt1K4IXtmGwlnVrPJH1UVhUFneEdi4qKsnTodh81
         OIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zsf5W6YqowSseyvuTUMml4+bgTU62PWsyrp4oNO1xMk=;
        b=r3nYNIxlIHmSd50CY9UeP1gL6J+L61H0lAehtgmMwow8yVopavYowZHuVkVYqA7Bjv
         /gty2SVdVPpBNtL5BYlPniFN2cDQYTgEt5JegSAaLBaVpjIbGBnJeLTglWb8AZ12xWWi
         n6J9JSbEHdwDuWbS2BKx8BfrqXf230U/QOt/L1yOU8dOnnjLojLB8qIKuF5ZF9PnNE5j
         Fs2b+p0dmTT1IenaDCwN0fKnigHg7YPPgk695JeP6btf1gbjqKhgGKHLHE/2CndZWBow
         tT95m2px9Vzlu3qumlyjhKfOKz8fkh+/9vGPL+y4WebVCWGTiSF9XnTODkGfhfQVBNeD
         nLCQ==
X-Gm-Message-State: AOAM531Emp1FTXvFhNakLW2tJrlM5VfcHzSJg4nlCNS1Oi7sqsOlpXXy
        JMXXXVe5TzG7qVNhjqPe48e+ij1Rru2Bd2ZVVuM=
X-Google-Smtp-Source: ABdhPJw2RtAnvTTu8eKJ1Gu5xdiQKMCSymgMHX2aBMj3kskaGPm2Lg7bnH1qL2p+8Qq1exiko2TgCjBz58gOBrLcDXs=
X-Received: by 2002:ac2:5d4b:: with SMTP id w11mr29074118lfd.676.1635332388998;
 Wed, 27 Oct 2021 03:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <20211026200058.2183-1-aladyshev22@gmail.com> <CACPK8Xd5eYpsFNw1jEjv3NaShgzE3zC_Ct29pJM34TfrqRTNtQ@mail.gmail.com>
In-Reply-To: <CACPK8Xd5eYpsFNw1jEjv3NaShgzE3zC_Ct29pJM34TfrqRTNtQ@mail.gmail.com>
From:   Konstantin Aladyshev <aladyshev22@gmail.com>
Date:   Wed, 27 Oct 2021 14:05:45 +0300
Message-ID: <CACSj6VVTFa0t9WK=R2TucG7eFqUzBsWYFzvsaRt6eXOiFuQORA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: Add AMD DaytonaX BMC
To:     Joel Stanley <joel@jms.id.au>
Cc:     Supreeth Venkatesh <supreeth.venkatesh@amd.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        geissonator@yahoo.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the comments. Can I ask you some questions about this
`device-tree-gpio-naming.md`?

1) First of all in my naming I've tried to use naming scheme the same
as the EthanolX CRB DTS currently has
(https://github.com/torvalds/linux/blob/d25f27432f80a800a3592db128254c8140bd71bf/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts#L102).
Do you want me to change GPIO naming in the EthanolX CRB as well?
2) Also this naming comes from the signal names in the board
schematics. This way it is clear to check schematics vs DTS. If we use
this OpenBMC naming style, we will lose that correspondence. Is it
really good?
3) In the initial version of the DTS file I've supplied only a minimal
set of GPIO, that are used by OpenBMC. GPIOs for x86-power-control app
and led id/fault gpios. With renaming these GPIOs I'm only sure about
these GPIOs:

FAULT_LED                  - led-fault
CHASSIS_ID_BTN        - led-identify

What about the rest? For example the document doesn't really state
what the *-button postfix states? Is it for asserting or monitoring
buttons? How should I name these signals?

ASSERT_BMC_READY
ASSERT_RST_BTN
ASSERT_PWR_BTN

MON_P0_RST_BTN
MON_P0_PWR_BTN
MON_P0_PWR_GOOD
MON_PWROK

Can you help me with those?

4) And what should I do to the board GPIO signals that OpenBMC doesn't
use? If you look at the EthanolX CRB DTS
(https://github.com/torvalds/linux/blob/d25f27432f80a800a3592db128254c8140bd71bf/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts#L102)
it has a ton of GPIOs. Should they be renamed to this OpenBMC style as
well? Or can they be named exactly like in the schematics?

I've also CCed original author of the `device-tree-gpio-naming.md`
document Andrew Geissler. Andrew, can you please provide your opinion
on the subject?

Best regards,
Konstantin Aladyshev

On Wed, Oct 27, 2021 at 12:03 AM Joel Stanley <joel@jms.id.au> wrote:
>
> Hello Konstantin,
>
> On Tue, 26 Oct 2021 at 20:01, Konstantin Aladyshev
> <aladyshev22@gmail.com> wrote:
> >
> > Add initial version of device tree for the BMC in the AMD DaytonaX
> > platform.
> >
> > AMD DaytonaX platform is a customer reference board (CRB) with an
> > Aspeed ast2500 BMC manufactured by AMD.
> >
> > Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
>
> This looks good. I have one comment about the GPIOs below.
>
> > +&gpio {
> > +       status = "okay";
> > +       gpio-line-names =
> > +       /*A0-A7*/       "","","FAULT_LED","","","","","",
> > +       /*B0-B7*/       "","","","","","","","",
> > +       /*C0-C7*/       "CHASSIS_ID_BTN","","","","","","","",
> > +       /*D0-D7*/       "","","ASSERT_BMC_READY","","","","","",
> > +       /*E0-E7*/       "MON_P0_RST_BTN","ASSERT_RST_BTN","MON_P0_PWR_BTN","ASSERT_PWR_BTN","",
> > +                       "MON_P0_PWR_GOOD","MON_PWROK","",
>
> For systems that will run openbmc, we try to use naming conventions
> from this document:
>
> https://github.com/openbmc/docs/blob/master/designs/device-tree-gpio-naming.md
>
> If a GPIO is missing from that doc I encourage you to add it.
