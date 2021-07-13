Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C1C3C76A8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 20:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbhGMSr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 14:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhGMSr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 14:47:57 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93374C0613DD;
        Tue, 13 Jul 2021 11:45:06 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id ee25so16332278edb.5;
        Tue, 13 Jul 2021 11:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bhZvAZqqLk0cTR7vw/Ukii3edchRAWA35SbjXDGbRo0=;
        b=jSqR0TciKE1j+fOveVsQHXfCD4RwjQVVN1wnFUMg0gW6QRx8utwRgvZq1Vw/ZkuNKD
         l2Z18akSng37x4HSTFhLoH/MhDBN+k0UVi5UYVLPqNTTwFBerFXyooZbG4GdsjsJkAlT
         1KUP+ond46vDz6gPxMcpHOwfpA4ULQwV1X0cZsYBNNMNB3bw55w42wBskC+0JUlMHRCv
         MyR7iwBOmCKzzJDnvR3QTWleqLxhPL49KLTsNE+WwF4qcakte3ZdzmVScdC54rWKykHp
         HNgspzIqVXdMt5oJB0xFyV/5Gxv+YqNpIBPAxQkyvizxMQYG8GPF41Lv4Z2Iv2WMEQeQ
         /oFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bhZvAZqqLk0cTR7vw/Ukii3edchRAWA35SbjXDGbRo0=;
        b=hYnyCPO9kJ+fRtg8OkK8wi4R+ctjsIQMruw6rrKy3HQCpRMHWqNT/Aq4VL2O0Pt/ET
         txN1cWdg0sa3kuNDxhfcqmjXWQ/wFKgqhFbdv08b4X4OF4pq5dL0jowiVIGAISj6sL00
         u3osJceUgj2NkSaSlO/M+M2xIORBUxhXWjJrR0vOW9sHzSVCUTuajAwjGqqmbFVJmxNn
         tpCh1LDU/jARx/zBlselUJ/8FgFrZJFMfa1RGPHfHct9hT0WUKjKg5lQDuK3DI7Mb6aC
         8XSNfq0HaR19XKfevtQipaSOwHG6ECoJgBkYk5kuJYx4Hdyuw6ZFc8lI+eK30TDzmxQ4
         V9oA==
X-Gm-Message-State: AOAM532eO1cZNt+Z2sbmVgMzA9lLDSxmoW20y4eDxxPrYKknk905/qOX
        cWoV1CAtJBY6U5nYehXHZcRywH5ePRdMINCuCvM=
X-Google-Smtp-Source: ABdhPJz3r6yDNV+B/zDzSSlPR3IcuzwWtSlGnz5S1NjPSQtpiBrftSjvtbCQd8s0RPRzKAZfuOYDpUuB7KCSyOkNN04=
X-Received: by 2002:aa7:c550:: with SMTP id s16mr7537666edr.130.1626201905236;
 Tue, 13 Jul 2021 11:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210713055227.1142-1-linux.amoon@gmail.com> <20210713055227.1142-2-linux.amoon@gmail.com>
 <CAFBinCD3ahpNQhP_jWZ3-4nXx8OqZOAANCpTN3BrsULRbYZHVw@mail.gmail.com>
In-Reply-To: <CAFBinCD3ahpNQhP_jWZ3-4nXx8OqZOAANCpTN3BrsULRbYZHVw@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 14 Jul 2021 00:14:53 +0530
Message-ID: <CANAwSgTh02qg=cMT8tpHcEfAs5yW2vHQ7tPOkvuKXos_fOmh8A@mail.gmail.com>
Subject: Re: [PATCHv1 1/3] ARM: dts: meson8b: odroidc1: Add usb phy power node
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-phy@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Matt Corallo <oc2udbzfd@mattcorallo.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Emiliano Ingrassia <ingrassia@epigenesys.com>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Thanks for reviewing the changes,

On Tue, 13 Jul 2021 at 20:35, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Tue, Jul 13, 2021 at 7:53 AM Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > Add missing usb phy power node for phy mode fix below warning.
> >
> > [    1.253149] phy phy-c1108820.phy.0: Looking up phy-supply from device tree
> > [    1.253166] phy phy-c1108820.phy.0: Looking up phy-supply property
> >                 in node /soc/cbus@c1100000/phy@8820 failed
> I did some testing on my own Odroid-C1+ and this patch is not doing
> anything for me.
> more information below.
Some device node for USB will have

>
> [...]
> > +               /*
> > +                * signal name from schematics: USB_POWER
> > +                */
> Just a few lines below you're saying that the name from the schematics is PWREN
> If this patch is getting another round then please clarify the actual
> signal name, or name both signals if the schematics is actually using
> both names.
>
As per the schematics.
PWREN ---> GPIOAO.BIT5      gpio pin control
USB_POWER ---> P5V0          power source regulator.

> [...]
> > +               gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
> > +               enable-active-high;
> I booted my Odroid-C1+ with this and USB was working fine.
> Then I replaced these two lines with:
>   gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_LOW>;
> and I found that USB is still working.
>
Yep it should be GPIOAO_5 GPIO_ACTIVE_LOW, my mistake

> Can you please give this a try on your Odroid-C1 as well?
> The conclusion from my own testing is that GPIOAO_5 doesn't seem to be
> related to USB1 (host-only) because if it was then inverting the
> polarity (from active high to active low) should result in a change.
>

Ok I have modified as per above but not changes in gpio polarity
from active high to active low. see below.

# Odroid C1
[alarm@archl-c1e ~]$ sudo cat /sys/kernel/debug/gpio | grep USB
 gpio-1953 (USB_HUB_RST_N       |usb-hub-reset       ) out hi
 gpio-1954 (USB_OTG_PWREN       |regulator-usbp_pwr_e) out hi

# Odroid C2
[alarm@archl-c2lm ~]$  sudo cat /sys/kernel/debug/gpio | grep usb
 gpio-501 (USB HUB nRESET      |usb-hub-reset       ) out hi
 gpio-502 (USB OTG Power En    |regulator-usb-pwrs  ) out hi

> [...]
> >  &usb1_phy {
> >         status = "okay";
> > +       phy-supply = <&usb_pwr_en>;
> From the schematics it seems that this is not the PHY supply (which I
> admittedly have used incorrectly for VBUS before).
> In the schematics that I have (odroid-c1+_rev0.4_20150615.pdf) it
> seems to be enabling VBUS.
> So in that case a vbus-supply property should be used inside &usb1 instead.
>
As per the debug log I have added this since core phy looking for this property

[    1.250044] phy phy-c1108820.phy.0: Looking up phy-supply from device tree
[    1.250060] phy phy-c1108820.phy.0: Looking up phy-supply property
in node /soc/cbus@c1100000/phy@8820 failed
[    7.222566] libphy: stmmac: probed

vbus-supply power is needed for dwc2 node see below.

[    1.257714] dwc2 c90c0000.usb: Looking up vbus-supply from device tree
[    1.257725] dwc2 c90c0000.usb: Looking up vbus-supply property in
node /soc/usb@c90c0000 failed

>
> Best regards,
> Martin

Thanks
-Anand
