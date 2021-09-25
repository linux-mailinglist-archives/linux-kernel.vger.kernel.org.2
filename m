Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9234C4182D6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 16:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343793AbhIYOst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 10:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343755AbhIYOss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 10:48:48 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533F9C061604
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 07:47:13 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id p80so16513453iod.10
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 07:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UtpI8bkA4DIUDYf0Om9w5i1QkTs/FeOohDrQdIrJOwY=;
        b=wiOATbyh/UTsI9zK+GX4w+Bn9cXCcYCoCkdO5cOCwwwjD54jJ0VLTjLtMyDJHiUsdM
         FSIKW5mEc6U0CSB68rACNzOeXbf5jMPuofnCof87JGXXhwz4WMpaRS+Hc2vgSA2BslGg
         esDk4y+/C3Sf/T6vUipwwSVqNsHKMRNgOIP9EYMg5/qDEMpYSz9j6jAx7tSJUTsg+ZWf
         M104/jvSSedx/7rFpD0AGXyAQ8MFh+yC46Dw5ciuDzOuvcu6bFeI9bf9fo1aqwwfSXAD
         0nsUVI4crQdsYHlMqHe4mIAylOkcu1SN0maYGkWP2uiQvRoNZl1XJBsy3/126LYJBf97
         4TxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UtpI8bkA4DIUDYf0Om9w5i1QkTs/FeOohDrQdIrJOwY=;
        b=tTfnEsByeOGWWgAnhXcHf19Q/UgV03//QHKP+CRzKUy0F34lWgOP71o4W3R2REeXIU
         Zym3oyQn7g15o6TD+ee53KET8gh9iM2H5P9pJ4ax4tRmXzEis4NyKunk2dWZTVCoWdt5
         ljxfVRwKpKRKuz3HVT5EmfnQzCrhnq1dc4SF9/Bm0fwtBy4ggppJzQ2u/Cv/2qXO7WP8
         VeiGRIVIgERUJoO9UtJws9yRTcyev3rWhsblTfzKMPdvimYVA5M/icp9W5rSBbPIIdOD
         HS+vr+jl6hwusKIMyJCGrvQ4CZfe7rL9zWsI48lAo3eStdGGqVdTWBFOxF2EFvcKo68z
         EaRQ==
X-Gm-Message-State: AOAM531w7E3xaFxMVgGu02O0hOUw5F4aDX0QLWhlvI3xfk0+XGht2n/f
        KRXJDA8+68iNhcUp4SZ+hiP3X4BYhS+1ys2HkDgadM3blxg=
X-Google-Smtp-Source: ABdhPJxYlMVqhTHmXIeFSA26uPZxn8sqEZoUBpak5MOZjsz61Ohz12gpQcsOh3K5Oa+01TS/+X0S8m9QldsXTehpDLQ=
X-Received: by 2002:a02:710d:: with SMTP id n13mr13686326jac.31.1632581232663;
 Sat, 25 Sep 2021 07:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210607123317.3242031-1-robert.marko@sartura.hr>
 <20210607123317.3242031-5-robert.marko@sartura.hr> <CA+HBbNH7wcpfQOX2=vZmW78GoWy_WL3Pz-dMKe0N0ebZDp+oUw@mail.gmail.com>
 <20210713222528.GA952399@robh.at.kernel.org> <CA+HBbNFj5+6sLKxmL8XtsZQ48ch8OjTbJ1bwkDC8dfRiOyWY1Q@mail.gmail.com>
 <20210719225906.GA2769608@robh.at.kernel.org> <CACRpkdbq6Jow6AT9OpsR7Q0JVCWVMcmamh9KHPXMtUnkoe7ZFw@mail.gmail.com>
 <CA+HBbNFEs-=5XTK7PUL+LsgBCcPfwHsCPe4v6byK0x=O_7TRPA@mail.gmail.com>
 <CACRpkdZfZLQMgpMAF2FwSVt1YAzhQJ9ZWkVUjVc2xpmWL7yEvQ@mail.gmail.com>
 <CA+HBbNHZyYnnyz9=4Hgav96ZH8-R-nYoi300j2x3fgei8aa4zQ@mail.gmail.com> <CA+HBbNE_U3dbnWh-8QasaxfQrQHS4YK8TEr0YebH9mCJsc0JTQ@mail.gmail.com>
In-Reply-To: <CA+HBbNE_U3dbnWh-8QasaxfQrQHS4YK8TEr0YebH9mCJsc0JTQ@mail.gmail.com>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Sat, 25 Sep 2021 16:47:02 +0200
Message-ID: <CA+HBbNH5Bybts2n6S3DrigNa_ZA-7_rgSZVgHZtoS27W9ZCtig@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] dt-bindings: mfd: Add Delta TN48M CPLD drivers bindings
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luka Perkov <luka.perkov@sartura.hr>, jmp@epiphyte.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Donald Buczek <buczek@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 11:02 PM Robert Marko <robert.marko@sartura.hr> wrote:
>
> On Tue, Aug 24, 2021 at 10:03 AM Robert Marko <robert.marko@sartura.hr> wrote:
> >
> > On Wed, Aug 11, 2021 at 2:17 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > >
> > > On Tue, Aug 3, 2021 at 9:23 PM Robert Marko <robert.marko@sartura.hr> wrote:
> > >
> > > > The pins that this driver wants to expose are used for SFP-s only,
> > > > they are provided by the Lattice CPLD which also does other things.
> > > >
> > > > Linux has a generic SFP driver which is used to manage these SFP
> > > > ports, but it only supports GPIO-s, it has no concept of anything else.
> > > > Since the driver is fully generic, I have no idea how could one extend it
> > > > to effectively handle these pins internally, especially since I have more
> > > > switches that use the CPLD for SFP-s as well, even for 48 ports and 192
> > > > pins for them.
> > >
> > > Which file is this driver in so I can look?
> >
> > Hi Linus,
> > Sorry for the late reply.
> >
> > Sure, here is the generic Linux driver that is used for SFP handling:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/phy/sfp.c?h=v5.14-rc7
> >
> > >
> > > Maybe it is not a good idea to look for generic code just because
> > > it is convenient? I have had this problem before with GPIO, along
> > > the lines "lemme just do this dirty thing this one time because it
> > > is so convenient for me" (more or less) and the answer is still
> > > "no".
> > >
> > > Can you either augment the driver to handle a regmap with bit indices
> > > instead or write a new similar driver for that or refactor it some other
> > > way?
> > >
> > > It is not a simple solution to your problem, but it might be the right
> > > solution even if it means some more work.
> >
> > I understand your position, believe me, I spend some time looking at
> > what would be the logical way for these switches.
> > But I see no way how could the SFP driver be extended in a generic way
> > that would allow supporting different register layouts when it comes to pins.
> >
> > >
> > > > GPIO regmap works perfectly for this as its generic enough to cover all of
> > > > these cases.
> > >
> > > Yeah but it might be the wrong thing to do even if it is simple
> > > to use and works.
> > >
> > > > CPLD also provides pins to test the port LED-s per color as well,
> > > > but I have chosen not to expose them so far.
> > >
> > > Have you considered
> > > Documentation/devicetree/bindings/leds/register-bit-led.txt
> >
> > Yeah, but unfortunately in this case it wont work as the LED-s
> > are for debugging/test purposes only and you first need to switch
> > the CPLD out of it interpreting the LED state with a BIT flip.
> >
> > Regards,
> > Robert
> > >
> > > > > If it is a regmap in Linux then that is fine, just pass the regmap
> > > > > around inside the kernel, OK finished. But really that is an OS
> > > > > detail.
> > > >
> > > > Yes, its regmap but I cant really pass it to the SFP driver as I don't have
> > > > special driver handling the SFP but rather the generic kernel one.
> > > > It only knows how to handle GPIO-s.
> > >
> > > Of course you have to program it. If I know which driver it
> > > is it is easier to provide architecture ideas.
> > >
> > > Yours,
> > > Linus Walleij
>
> Linus,
>
> can I offer some further explanation?
>
> Regards,
> Robert

Hi Linus,

I would really like to move forward with this somehow.

I have multiple switches depending on the outcome of this series.

Regards,
Robert
> >
> >
> >
> > --
> > Robert Marko
> > Staff Embedded Linux Engineer
> > Sartura Ltd.
> > Lendavska ulica 16a
> > 10000 Zagreb, Croatia
> > Email: robert.marko@sartura.hr
> > Web: www.sartura.hr
>
>
>
> --
> Robert Marko
> Staff Embedded Linux Engineer
> Sartura Ltd.
> Lendavska ulica 16a
> 10000 Zagreb, Croatia
> Email: robert.marko@sartura.hr
> Web: www.sartura.hr



-- 
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
