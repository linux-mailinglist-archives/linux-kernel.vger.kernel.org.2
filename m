Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D133CC74A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 05:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbhGRDlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 23:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhGRDlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 23:41:37 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B037C061762;
        Sat, 17 Jul 2021 20:38:39 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id l26so18466571eda.10;
        Sat, 17 Jul 2021 20:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LIlzqY37/ApwF5j7PXVX2Gcn6RoFS6mgR/Cwi+L/v2E=;
        b=Jb6ROQWd5jMjvTPpWafimOYgQ0d4hBWyXVXH3MHDcL0If5wBBIAjcT3NWkmsDz69IK
         QLw7gleWCs7hpilMT54gT1L2UYa7ifs18BNVMAmVxkI/9EWMV1hZWE7ujnhEpZfXUU2m
         vQnzo9rfCbxGmvB1ln8WcDk6yBvRpoo5z61ROgymq3ARCJRRim8XRulvAas20ffSAofp
         pfQLojOlPrnyV+5n9EOw4LTur9NdLpCMeZkEIBe/6htPd6Tcf4F7zRM3QcLSjciyHkvK
         bm2JMJq1sRzzRSfOa4Y0DESU1G+pvGOOhWZSC4EmKa1zjIKEUsXVwf7wqZhAVrUmH/rL
         MbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LIlzqY37/ApwF5j7PXVX2Gcn6RoFS6mgR/Cwi+L/v2E=;
        b=cW7ZLlEW9fzlLWip/Qrxw23nqkrCdjuKfyUMF+wr4JD3i2tso4yq7b+yj5xkveYsNJ
         I4iPrPR3131gQMgNd5NIdqnW5oc0dUNs5bq1jG0teInPYi9aPFvJ02QTppEcoVvWFBhN
         e9PPJQHrMMh6hFqgeAJd6/FiwCB7E6HyVv6g6IOoVPT8LcgsyZJ28XUlysCIs7aGBUBg
         m+LVcFiWCZ4TntlY4qsdACwV+3Vipafb9b/UN8NFUsfOWKJxIn3UxgYJ6rtqAyC9a1pk
         O3sJvF4QqfE9d6m+jLvQbleyxuc+V4in6cR7A8cPY26EkK3m5Vtqr0EC7/d2L+OyYf2m
         YxzA==
X-Gm-Message-State: AOAM533SCEy9tH2af+g43YWX75egyurttox3u30rUB8NK8f4FFJ+0G3U
        5GXhPEoEy5hc3w5iccguD9atBAPmpeXlkZLipMw=
X-Google-Smtp-Source: ABdhPJy+xX/itKKz5o91fjWk6bMjvkzO6a0D0U3UXljnVdJNK9vkNcWGEWkjMlPG/iCTUG9wAw/pzrx5tlWLQH0x2tU=
X-Received: by 2002:a05:6402:1218:: with SMTP id c24mr25333898edw.59.1626579517304;
 Sat, 17 Jul 2021 20:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210716103651.1455-1-linux.amoon@gmail.com> <20210716103651.1455-2-linux.amoon@gmail.com>
 <CAFBinCDeqauw_V-Vn9cat9HaCXj6HEMz6G+G+VbqCNtGEFGYzg@mail.gmail.com>
In-Reply-To: <CAFBinCDeqauw_V-Vn9cat9HaCXj6HEMz6G+G+VbqCNtGEFGYzg@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Sun, 18 Jul 2021 09:08:26 +0530
Message-ID: <CANAwSgQ5PDGUWMH-jxnz5wwutUVniTn7RAe=4J=8-jbmqxYRRg@mail.gmail.com>
Subject: Re: [PATCHv2 1/4] ARM: dts: meson8b: odroidc1: Add usb phy power node
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
        Brian Kim <brian.kim@hardkernel.com>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Thanks for the review comments.

On Sun, 18 Jul 2021 at 01:16, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Fri, Jul 16, 2021 at 12:37 PM Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > Add missing usb phy power node for phy mode fix below warning.
> > P5V0 regulator suppy input voltage range to USB host controller.
> low prio - typo: suppy -> supply
>
> > As descriped in the C1+ schematics, GPIO GPIOAO_5 is used to
> low prio - typo: descriped -> described
>
I definitely run checkpatch with the spellcheck option but I need to
improve on this aspect.

> > enable input power to USB ports, set it to Active Low.
> >
> > [    1.253149] phy phy-c1108820.phy.0: Looking up phy-supply from device tree
> > [    1.253166] phy phy-c1108820.phy.0: Looking up phy-supply property
> >                 in node /soc/cbus@c1100000/phy@8820 failed
> high prio:
> Can you please describe how I can test this patch?
> My concern is that previously I have tested your patch with ACTIVE_LOW
> and ACTIVE_HIGH polarity.
> In both cases USB is working and I cannot observe any change (apart
> from this debug message being gone).
>
> In the Odroid-C1 schematics (page 1) GPIOAO.BIT5 is connected to USB_OTG *only*.
> I cannot give my Acked-/Reviewed-/Tested-by without a description of
> how I can actually test the GPIO potion of this patch.
>
> [...]
> > +               /*
> > +                * signal name from schematics: PWREN - GPIOAO.BIT5
> > +                */
> > +               gpios = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
> low prio:
> Even though it's strictly not necessary I think this is confusing to read.
> Since there's no "enable-active-high" property the GPIO will be
> considered as "active low".
> My suggestion is to change GPIO_ACTIVE_HIGH to GPIO_ACTIVE_LOW
>
My apologies, I might have sent the wrong set of patches its
GPIO_ACTIVE_LOW I meant
I have formatted with and in the course of testing and verifying It
might have got SKIPPED.
I didn't do this intentionally it happen with a mistake with my two
repositories.
I don't intend to repeat my mistake, again and again, *sorry for the trouble*.

> Also if you have any extra information since you last pinged me on IRC
> then it would be great if you could document it.
> I am referring to these IRC message, where you are stating that the
> correct polarity should be "active high":
> <armoon> xdarklight I have a question on USB GPIO Polarity on Odroid C1+
 > <armoon> As per the
> https://dn.odroid.com/S805/Schematics/odroid-c1+_rev0.4_20160226.pdf
> <armoon> MP62551DGT-LF IC controls the power for the USB PORTS
> <armoon> https://www.mouser.com/datasheet/2/277/MP62550-1384050.pdf is
> MP62551DGT datasheet
> <armoon> As per the data sheet in section ORDERING INFORMATION  Active
> enable signal is set below MP62551DGT Active High
>

[1] https://www.mouser.com/datasheet/2/277/MP62550-1384050.pdf

I have read the datasheets MP62551DGT EN*  pin its Enable input. Active Low:
       *EN I Enable input. Active Low: (MP62550), Active High: (MP62551).*

I have tested with ACTIVE_LOW and followed all the steps invalidating
 this with debugfs output.

Last login: Tue Jul 13 00:02:49 2021 from 10.0.0.14
[alarm@archl-c1e ~]$ sudo cat /sys/kernel/debug/gpio | grep usb
 gpio-1953 (USB_HUB_RST_N       |usb-hub-reset       ) out hi
 gpio-1954 (USB_OTG_PWREN       |regulator-usb-pwr-en) out lo ACTIVE LOW

> [...]
> >  &usb1_phy {
> >         status = "okay";
> > +       phy-supply = <&usb_pwr_en>;
> medium priority:
> I have raised the following concern in one of my previous emails on this topic:
> > The mistake I made before is considering USB VBUS as PHY power supply.
> > I believe the USB PHY is actually powered by the AVDD18_USB_ADC and
> > USB33_VDDIOH signals. See the S905 datasheet [0], page 25
> > These are 1.8V and 3.3V signals while you are adding a 5V regulator.
> you replied with:
> > OK, thanks.
> so I don't understand what "OK, thanks" means.
> If it means "Martin, you are wrong" then please provide a description
> so I can also learn something!

Yes, I understood your inputs. But from the logs below is seen to
looking for phy-supply
This is the reason I went ahead with phy-supply as the core phy node
needs this property.

Please check below commit
e841ec956e53 ("ARM64: dts: meson-gxbb-odroidc2: fix usb1 power supply")

[    1.253149] phy phy-c1108820.phy.0: Looking up phy-supply from device tree
[    1.253166] phy phy-c1108820.phy.0: Looking up phy-supply property
in node /soc/cbus@c1100000/phy@8820 failed
[    1.255031] pwm-regulator regulator-vcck: Failed to get PWM, deferring probe
[    1.256730] pwm-regulator regulator-vddee: Failed to get PWM, deferring probe
[    1.260300] dwc2 c90c0000.usb: mapped PA c90c0000 to VA (ptrval)
[    1.260446] dwc2 c90c0000.usb: Looking up vusb_d-supply from device tree
[    1.260460] dwc2 c90c0000.usb: Looking up vusb_d-supply property in
node /soc/usb@c90c0000 failed
[    1.260490] dwc2 c90c0000.usb: supply vusb_d not found, using dummy regulator
[    1.260606] dwc2 c90c0000.usb: Looking up vusb_a-supply from device tree
[    1.260620] dwc2 c90c0000.usb: Looking up vusb_a-supply property in
node /soc/usb@c90c0000 failed
[    1.260641] dwc2 c90c0000.usb: supply vusb_a not found, using dummy regulator
[    1.260717] dwc2 c90c0000.usb: registering common handler for irq35
[    1.260772] dwc2 c90c0000.usb: Looking up vbus-supply from device tree
[    1.260784] dwc2 c90c0000.usb: Looking up vbus-supply property in
node /soc/usb@c90c0000 failed
[    1.261949] dwc2 c90c0000.usb: Core Release: 3.10a (snpsid=4f54310a)

>
>
> Best regards,
> Martin

-Anand
