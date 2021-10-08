Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2386142729E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 22:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243090AbhJHUxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 16:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242932AbhJHUxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 16:53:11 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482E9C061755
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 13:51:15 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id r134so946405iod.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 13:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TZc6Dbq3mfofULZfRURZejbb2JPbKOus7S+/NxDibZo=;
        b=Wo18ubXSfUbJNKKU5ezHgN2V3Z6lDdT++c5vQz8CY11i9oSHPn9yslvnWgozyB2wNF
         xCB48xxfLQvOMmgHRlSmPArd9NRnF6JHTtcEM+DkZJTBd4XA+ev+IzIPQIaKMkfU8Uvr
         yA9YQxJM97ozurBRvvIoBkseQ2W4Oa43URGEp+x8seT0lK2/htLAsJuo+DbBOMEvnwVj
         8aVFWWckq9lM+2rzjnllbuFfVGqX+2K9lLNmRozHPkxibdARh2+PoZvnlhNtOjsoL0NO
         Nsq9GGZYdQ4ASIGal7rdO/waBzktoEObQtkgzBSyF5mrJ7IdyyzFVCYXIH7acuLCuTp/
         ISuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TZc6Dbq3mfofULZfRURZejbb2JPbKOus7S+/NxDibZo=;
        b=6yYf2AfGGsiIqLLEZsAmI3oCKC60oeo6rdjGyZ8BBeQVvmPrrbja7ez1kHJf+xZrA+
         11dSwGVLXSzS0OrpmiuNEvYHCj2L5Ue6HC63QUxeWcdj6f3pJpKy16Uc3gje3CULoKSL
         yUvVrCYfB2VkKVzcEFStdCtsy1se6BMGbOgcJt/tcNLrvgv8Je9fAApGFw7nd5M6g/bJ
         Zao7zmOUMeYWyS6Y1E5BgtMZXphLTfk572+05ulijLpsBfG1k5YP6ndJVDxbEakh/via
         OOCnWXbwVJ34llwc/u7OurMyO4nKU9a9FOxCAprZhViwyDNMaU7WDTZkJm1c2l2aEcyn
         l9VA==
X-Gm-Message-State: AOAM533/fDTo9M7e2gcBQnU+wroasBrqbh2zY++e4tb5iZDj8LYv43LH
        gLPiBzJR+65zQRbuuBtoexMEdVsSbIvU8jec0n1w8Q==
X-Google-Smtp-Source: ABdhPJzqQv1HUtYlytlPxCeDeUMA9DmkflEFjNb7eSyoGHc9uugysbKaMyPQNMh9WfvUc4gtyAP5GrzEoJtDLOPa7a0=
X-Received: by 2002:a6b:cd8b:: with SMTP id d133mr9672696iog.88.1633726274688;
 Fri, 08 Oct 2021 13:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211008114343.57920-1-robert.marko@sartura.hr>
 <20211008120855.46zbo2fl5edwf7ja@pali> <CA+HBbNGvFtws2GF7RLbznAbXfvjKx4rOJ=eMeuHOJ6s7iANtzw@mail.gmail.com>
 <20211008134347.lskm5pzt73pkf7oc@pali> <CA+HBbNEDxBDvNZPSWnBYJOUhqdwonBhFwD9P0xhSGccdvQJx3Q@mail.gmail.com>
 <20211008172948.rpev5iptnczdofwi@pali>
In-Reply-To: <20211008172948.rpev5iptnczdofwi@pali>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Fri, 8 Oct 2021 22:51:04 +0200
Message-ID: <CA+HBbNExegyMENPrWBWrhNVJPMOfcE7L=5psUvBEi3o5quP=Fg@mail.gmail.com>
Subject: Re: [PATCH v5] arm64: dts: marvell: add Globalscale MOCHAbin
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 8, 2021 at 7:29 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Friday 08 October 2021 17:52:40 Robert Marko wrote:
> > On Fri, Oct 8, 2021 at 3:43 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > >
> > > On Friday 08 October 2021 15:28:38 Robert Marko wrote:
> > > > > > +     cp0_pcie_reset_pins: cp0-pcie-reset-pins {
> > > > > > +             marvell,pins =3D "mpp9";
> > > > > > +             marvell,function =3D "gpio";
> > > > >
> > > > > Now I spotted this. Why is PERST# pin configured into gpio mode? =
Is
> > > > > there some issue that this pin in pcie mode is not working proper=
ly,
> > > > > that PCIe controller cannot handle it correctly? Or something els=
e?
> > > >
> > > > Its because I have seen way too many broken controllers when it com=
es
> > > > to PERST and
> > > > other Armada 7k/8k devices are using it in GPIO mode as well.
> > > > Just look at the number of conversions back to GPIO for other
> > > > platforms as there is always some bug.
> > >
> > > I know that A3720 has broken PERST# control in PCIe block... or at le=
ast
> > > I was not able to figure out how A3720 PCIe block can control PERST#.=
 So
> > > configuring it in gpio mode and let PERST# to be controlled manually =
via
> > > gpio by the software is the workaround.
> > >
> > > I just wanted to know if A7k/A8k/CN913x is also broken in the same wa=
y
> > > as A3720.
> > >
> > > Or it it just a configuration workaround for missing driver or missin=
g
> > > proper software setup.
> > >
> > > HW bugs like this should be properly documented and not hidden behind
> > > some configuration in DTS file. And reported to HW vendors.
> >
> > I have to agree, so I did some digging.
> > I don't think that the Armada 8k PCI driver actually supports HW level =
PERST#.
> > I then looked at the functional specs and the only thing that looks
> > related to PERST#
> > is PCIe Software Reset Register which has a SoftWarePERst bit.
> >
> > Can you maybe look at it?
>
> Some details are in "PCIe Reset" section in Hardware Specification. In
> Software Functional Specification seems to be nothing useful. Just those
> registers without description.

It seems there are 4 bits that somehow set PCIe_Reset_out signal as
they call it.
No idea how to properly use it anyway, I will use it as a GPIO for now.

Regards,
Robert
>
> > Removed the reset-gpios and set the PERST pinmux to PCIe, and the
> > QCA9377 card will
> > show up, but I have no idea whether PERST# actually ever gets toggled.
> >
> > Regards,
> > Robert
> > --
> > Robert Marko
> > Staff Embedded Linux Engineer
> > Sartura Ltd.
> > Lendavska ulica 16a
> > 10000 Zagreb, Croatia
> > Email: robert.marko@sartura.hr
> > Web: www.sartura.hr



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
