Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74E0395744
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 10:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbhEaIoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 04:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbhEaIog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 04:44:36 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2210EC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 01:42:56 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id b25so11195458iot.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 01:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9Mi3Wc4wHLv8tIa+hLjhTLDdoH9+eOQcDbBHus3jcwY=;
        b=hmCoSp24fBHkpCJ28/A6H2mG7drh7iE2gbHVnUjd1F1/a3qgfa8Zg5buYb8D+kPRKA
         vFIN03NL5UJpHITGd5GvRt2B0XSEAd4ecFyCDFA7WEOA0mhkiJdQDdF829F9kuTzdweg
         AnTkvd2kPIDZJjnUlirre/MzXhHQ1Wjf/n5S4lBrOhMGBjUGBs5hENrV6jnpcdMO3mzM
         uFwS7sT4URADbSCEQ3RfqHu3QeVJ3+Qbcgq1B6BEAmYglRBWh/QzhYWzSbQHDftubtsn
         Kkzls7I1UsFqwsYL74ajif2EmBraY2OzRKm77LradLFjvKjm5TF9i1rJAC86RKTIATRn
         p+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9Mi3Wc4wHLv8tIa+hLjhTLDdoH9+eOQcDbBHus3jcwY=;
        b=sTf8fHPE6UkWfDYemUf+c67jfl+O0AyaBvDr25tvK7Z14vMZUyT7105dbGAOJuRXmD
         4n9ICwQpv+ZOn2GjVf3nqwv/DYs2SRSuuHto/SGaz9Pu2eCKN0bBoRchDG9VBj3ojT9z
         JLHx9/79CwNGWd5G5H5TW0TEl51GCh8J38EUBTHIajAHY2QCnIh5f1UgNRuMikUk80Oz
         zTe1zqRwmt+AVWVlc4CrenqiovY8Qf/mBvWxA4ImXhccA5TzjwBLaz5WnLhlsstyhB/c
         rudBe4tq1GCnwgU7ozG+cDlZQX6fhfQ4O/PLg5qPdoGV54A53kEOfxrqTrV072V9tCH+
         C1nQ==
X-Gm-Message-State: AOAM531du5OZZq22eahMztipr8ig8FhN7tZeHOHOmxgFXQ6ZMrdxDIBN
        uoYpyvh2bDAZ0Ry8/WZDxT1isZuLfb3EKgd14D9GEQ==
X-Google-Smtp-Source: ABdhPJyEWiPmm+WC4L8StZTlomC4jIjIdzDIxQp1eeRM1WySUE3xGQ8LMbo3OEoapR/arPt9GZt+Javtp/uLoK2sWmE=
X-Received: by 2002:a05:6602:189:: with SMTP id m9mr16236035ioo.88.1622450575393;
 Mon, 31 May 2021 01:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210524120539.3267145-1-robert.marko@sartura.hr>
 <20210524120539.3267145-3-robert.marko@sartura.hr> <20210524230940.GA1350504@robh.at.kernel.org>
 <20210525074649.GC4005783@dell> <CA+HBbNFxCKbitVctbUisuZXJWxaZp0cswNNNTgD0UxQZ1smJbg@mail.gmail.com>
 <20210526075255.GG4005783@dell>
In-Reply-To: <20210526075255.GG4005783@dell>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Mon, 31 May 2021 10:42:44 +0200
Message-ID: <CA+HBbNGSH9AvRo0Hwa5pWea94u0LwJt=Kj7gWjSAV9fS5VFr0A@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: mfd: Add Delta TN48M CPLD drivers bindings
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        bgolaszewski@baylibre.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luka Perkov <luka.perkov@sartura.hr>, jmp@epiphyte.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Donald Buczek <buczek@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 9:52 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Tue, 25 May 2021, Robert Marko wrote:
>
> > On Tue, May 25, 2021 at 9:46 AM Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > On Mon, 24 May 2021, Rob Herring wrote:
> > >
> > > > On Mon, May 24, 2021 at 02:05:38PM +0200, Robert Marko wrote:
> > > > > Add binding documents for the Delta TN48M CPLD drivers.
> > > > >
> > > > > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > > > > ---
> > > > > Changes in v2:
> > > > > * Implement MFD as a simple I2C MFD
> > > > > * Add GPIO bindings as separate
> > > >
> > > > I don't understand why this changed. This doesn't look like an MFD =
to
> > > > me. Make your binding complete if there are missing functions.
> > > > Otherwise, stick with what I already ok'ed.
> > >
> > > Right.  What else, besides GPIO, does this do?
> >
> > It currently does not do anything else as hwmon driver was essentially
> > NACK-ed for not exposing standard attributes.
>
> Once this provides more than GPIO capabilities i.e. becomes a proper
> Multi-Function Device, then it can use the MFD framework.  Until then,
> it's a GPIO device I'm afraid.
>
> Are you going to re-author the HWMON driver to conform?
hwmon cannot be reathored as it has no standard hwmon attributes.

>
> > The CPLD itself has PSU status-related information, bootstrap related
> > information,
> > various resets for the CPU-s, OOB ethernet PHY, information on the exac=
t board
> > model it's running etc.
> >
> > PSU and model-related info stuff is gonna be exposed via a misc driver
> > in debugfs as
> > we have user-space SW depending on that.
> > I thought we agreed on that as v1 MFD driver was exposing those directl=
y and
> > not doing anything else.
>
> Yes, we agreed that creating an MFD driver just to expose chip
> attributes was not an acceptable solution.
>
> > So I moved to use the simple I2C MFD driver, this is all modeled on the=
 sl28cpld
> > which currently uses the same driver and then GPIO regmap as I do.
> >
> > Other stuff like the resets is probably gonna get exposed later when
> > it's required
> > to control it directly.
>
> In order for this driver to tick the MFD box, it's going to need more
> than one function.

Understood, would a debug driver count or I can expose the resets via
a reset driver
as we have a future use for them?

Regards,
Robert
>
> > > > >  .../bindings/gpio/delta,tn48m-gpio.yaml       | 42 ++++++++++
> > > > >  .../bindings/mfd/delta,tn48m-cpld.yaml        | 81 +++++++++++++=
++++++
> > > > >  2 files changed, 123 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/gpio/delta,=
tn48m-gpio.yaml
> > > > >  create mode 100644 Documentation/devicetree/bindings/mfd/delta,t=
n48m-cpld.yaml
> > >
> >
> >
> >
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
