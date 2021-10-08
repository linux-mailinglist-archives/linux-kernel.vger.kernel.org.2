Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5050426E23
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 17:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243197AbhJHPyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 11:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243077AbhJHPyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 11:54:47 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B10C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 08:52:52 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id w11so7198955ilv.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 08:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ac00s+PRxBmgu3lFPELG1EG9EqpXm9N50GQn2NdGX80=;
        b=Tw8EtKcNyxCSI8Oav/rTOA2zpFi3rNCHInhlVMCcFX2vY1AefU8OyiMin18iKfOKRL
         okgNXLaHez2T61cy9WirxUvZ2ZPkBPEKoMOG5LrVCxbBOWr/soQkDNbLnCMTLEPT5iHY
         jrh+7Yp2J5dbcURs3oxaJMEsVXF6qLbobZODQp/Hz+SLnk1qVFKsCagmIx0OL4tvFr8Y
         zf9KG1ZdUGJLqS737vGsp3K45LXZaQVGrLeCWtIZ3O4+wFebtaHIaZfsXZzP3GMW8+Vk
         2qtfbIgXZ3tuZL+RDcUeA/WhV/LrobOsuoQjYpFrSi/1Yj0bD3KM+4V0vEKOMiWKehp0
         lyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ac00s+PRxBmgu3lFPELG1EG9EqpXm9N50GQn2NdGX80=;
        b=clohPut+dELdM8lJ6nTIP1w3X2CaKFYkVaThlfmIbqIO7U+9/0bLlBQuV/47+KU1UB
         udKPhdpbhDwkGZpNiNqJ/3tBt/YTd2R1LFPu73y53T8Kynp7hwal5x5vVItwghDDkPj/
         5anwVZFV58XlPEFg+lkPAQHGEuVzhFPZMkhiqRFnWtDDT3/1/wVWjsk7GTfP//L1EqzH
         Fdc1ojpMbNvBzU/EurAXNvqza0/3N/D4Cxd+WPKVIiGagPVxJM9bbSA4ZoEOrGrr357v
         m+R8rJt5zzYXQDObt8dCGIaRJNMlWI6bcKzMR6+6iRij46g949zckhnRcxXhu6MKZwA/
         ZhNw==
X-Gm-Message-State: AOAM533vOwE7UwEr6aDELXh/dYI1uhMbgciyy8cRDopFAz1DqEIH69y5
        o8v2oPx+M4N+0jT3cUR+JFdrKb77xJEFjFMay+395Q==
X-Google-Smtp-Source: ABdhPJxlL991Sm7cGy5p23FjZmGBQYOjZwg0XmCfEwsR87F/DK2SMzgr9qaPwm0W60l/bxW/tTI1QByy6W/Za3r1Pfw=
X-Received: by 2002:a05:6e02:1023:: with SMTP id o3mr8254592ilj.27.1633708371331;
 Fri, 08 Oct 2021 08:52:51 -0700 (PDT)
MIME-Version: 1.0
References: <20211008114343.57920-1-robert.marko@sartura.hr>
 <20211008120855.46zbo2fl5edwf7ja@pali> <CA+HBbNGvFtws2GF7RLbznAbXfvjKx4rOJ=eMeuHOJ6s7iANtzw@mail.gmail.com>
 <20211008134347.lskm5pzt73pkf7oc@pali>
In-Reply-To: <20211008134347.lskm5pzt73pkf7oc@pali>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Fri, 8 Oct 2021 17:52:40 +0200
Message-ID: <CA+HBbNEDxBDvNZPSWnBYJOUhqdwonBhFwD9P0xhSGccdvQJx3Q@mail.gmail.com>
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

On Fri, Oct 8, 2021 at 3:43 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Friday 08 October 2021 15:28:38 Robert Marko wrote:
> > > > +     cp0_pcie_reset_pins: cp0-pcie-reset-pins {
> > > > +             marvell,pins =3D "mpp9";
> > > > +             marvell,function =3D "gpio";
> > >
> > > Now I spotted this. Why is PERST# pin configured into gpio mode? Is
> > > there some issue that this pin in pcie mode is not working properly,
> > > that PCIe controller cannot handle it correctly? Or something else?
> >
> > Its because I have seen way too many broken controllers when it comes
> > to PERST and
> > other Armada 7k/8k devices are using it in GPIO mode as well.
> > Just look at the number of conversions back to GPIO for other
> > platforms as there is always some bug.
>
> I know that A3720 has broken PERST# control in PCIe block... or at least
> I was not able to figure out how A3720 PCIe block can control PERST#. So
> configuring it in gpio mode and let PERST# to be controlled manually via
> gpio by the software is the workaround.
>
> I just wanted to know if A7k/A8k/CN913x is also broken in the same way
> as A3720.
>
> Or it it just a configuration workaround for missing driver or missing
> proper software setup.
>
> HW bugs like this should be properly documented and not hidden behind
> some configuration in DTS file. And reported to HW vendors.

I have to agree, so I did some digging.
I don't think that the Armada 8k PCI driver actually supports HW level PERS=
T#.
I then looked at the functional specs and the only thing that looks
related to PERST#
is PCIe Software Reset Register which has a SoftWarePERst bit.

Can you maybe look at it?

Removed the reset-gpios and set the PERST pinmux to PCIe, and the
QCA9377 card will
show up, but I have no idea whether PERST# actually ever gets toggled.

Regards,
Robert
--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
