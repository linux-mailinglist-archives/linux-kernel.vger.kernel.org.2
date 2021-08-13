Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CAB3EBC9A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 21:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbhHMTgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 15:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhHMTgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 15:36:20 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7A4C061756;
        Fri, 13 Aug 2021 12:35:53 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bq25so10148700ejb.11;
        Fri, 13 Aug 2021 12:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HOexqmWKRM3IjPdhhxIgoa6z/c3dqxUyUXL0t6jHr2k=;
        b=mu+lRZY8XVbAUyaFHX7V7WTY4Wb56SszmMWradGud5YJ7iyPeq1q9lkaERCVe+0HY2
         xVs3PfulG5c4qbkwWB4wLG/2a88mFTYZAbUWSEhOvKLEr5Kb3iiv0jXFRKwNOh74S+EC
         HSS8H3vRqxmZbolrxCPE+6iLoLF7W9KPsyoG3jKYtnoqRvEbg42XqGOQGZFAkxfbQGST
         /5A8zApjpQbmGRqiRe5668ZrxQlyvAqtPDJvVVNlu+uKIUpYTSt/Q/479o7RAR6rFAg3
         sV9mfyJ8iUXc7AzLs1KGXNZ0WZ5UHirEMfmse4d9jiry7lR6nSzJZBJH5bZvYmNNthEh
         70+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HOexqmWKRM3IjPdhhxIgoa6z/c3dqxUyUXL0t6jHr2k=;
        b=WqpBXHgKPrVhVBHQ06UkGWZm3M/kVgax+qs5/0hjZpHJo292ObjlBCN81IzAsE8eo7
         ruPjmg+9hSNo/A7mFxOf6SvhCWdKPBMrla31YRSMHGcqpmBUV/nYpSMU1Gk71fE21zNn
         SlbSxaxT2r6cqw6q1wosIg8IDDkVgl3T/dWUIf/K2fgXAqE/0r/RikaBVIbkOA5IhFhD
         QSgyKWbMck4A/u3QrWDg7KOSzoO8qSyDPMlYPA/JneD1q/Le1a8jaFf6jA1G3S0saPXD
         QL0b0TizJAAyAfw+BN1ve27UgsTRsh+EEgMOeW8kC/7UBN04W1oo1zQ8xjlA+UXubz4s
         Gn3w==
X-Gm-Message-State: AOAM531P5+5vmPoWoplCPZZ5TjfPODeBAeb0XlqNMnViOqQcGjsUVQRe
        Eo2ubj1mG7CbWAogzUSmOueOmUWNGFzdCGw8Aks=
X-Google-Smtp-Source: ABdhPJzo21B8s2gllwmkb26smEseF4nn9KMOpTZclBGisjc+pLGtFjEFegAWFUtyZGrm231/pEtt6UX8eiW6VVT2fVA=
X-Received: by 2002:a17:907:1c92:: with SMTP id nb18mr4163817ejc.191.1628883351488;
 Fri, 13 Aug 2021 12:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210716103651.1455-1-linux.amoon@gmail.com> <20210716103651.1455-2-linux.amoon@gmail.com>
 <CAFBinCDeqauw_V-Vn9cat9HaCXj6HEMz6G+G+VbqCNtGEFGYzg@mail.gmail.com>
 <CANAwSgQ5PDGUWMH-jxnz5wwutUVniTn7RAe=4J=8-jbmqxYRRg@mail.gmail.com>
 <CAFBinCBhg+dije+3DvV_V_kqHv9q+r4EPxXCYFti6KuA4mK7KQ@mail.gmail.com>
 <CANAwSgT9-5zGr67aGzBmW6WDBfeiAvjv_zv2UbRC+YbgAGg==A@mail.gmail.com>
 <CAFBinCCGA0b=LVjbQood+iN+DHLodY0RJ-GrSOcgdzrDFJ25pQ@mail.gmail.com>
 <CAFBinCAohjxcsY3D1rdAiYVGL+==cnjzZxg1GmYxSNVhxSTDoA@mail.gmail.com>
 <CAFBinCAP_DDvPLn4h1yQKEdU_x1ovokHUTPeq3vNV_sDF8PcWg@mail.gmail.com> <CANAwSgS2vi7hZqX0LWxNTvk-3aN=n1fEErj4Zt0_4CCpZGyRkg@mail.gmail.com>
In-Reply-To: <CANAwSgS2vi7hZqX0LWxNTvk-3aN=n1fEErj4Zt0_4CCpZGyRkg@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Sat, 14 Aug 2021 01:05:40 +0530
Message-ID: <CANAwSgTw-aY16NOcQhgPcN+Tkz-OXdioDEAM2q0OPhvbf2TwaQ@mail.gmail.com>
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
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Thu, 5 Aug 2021 at 23:48, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Martin,
>
> On Thu, 5 Aug 2021 at 03:28, Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> >
> > On Sun, Jul 18, 2021 at 9:09 PM Martin Blumenstingl
> > <martin.blumenstingl@googlemail.com> wrote:
> > >
> > > Hi Anand,
> > >
> > > On Sun, Jul 18, 2021 at 4:01 PM Martin Blumenstingl
> > > <martin.blumenstingl@googlemail.com> wrote:
> > > [...]
> > > > > From the schematics [1]
> > > > > https://dn.odroid.com/S805/Schematics/odroid-c1+_rev0.4_20160226.pdf
> > > > >
> > > > > You could find references to PWREN  <--- GPIOAO.BIT5
> > > > > The second reference is USB HOST Power Switch
> > > > > The third reference is USB HOST POWER.
> > > > >
> > > > > Hope I am clean in my thought process now.
> > > > Can you please point out the page numbers for me?
> > > >
> > > > What I am seeing on page 1 is:
> > > > GPIOAO_5 (called GPIOAO.BIT5) is connected as an INPUT to the USB_OTG
> > > > PWREN signal (that's the green box with the label "USB_OTG.SchDoc"
> > > > above it).
> > > I unfortunately missed your question on IRC on this topic:
> > > <armoon> xdarklight: just want to understand the confusion on PWREN,
> > > either is INPUT / OTPUT to usb hub am I correct
> > > My understanding of the INPUT/OUTPUT direction in the Odroid-C1
> > > schematics (which you linked) above is that the arrow direction shows
> > > whether it's an input or output.
> > > For example (all on page one):
> > > - HDMI_HPD is an input to the Meson8b SoC, arrow direction is: HDMI => S805
> > > - IR_IN is an input to the Meson8b SoC, arrow direction is: S805 <=
> > > GPIOAO.BIT7 IR_IN
> > > - PWM is an output, arrow direction is: S805 => PWM.C VCCK_PWM
> > > - 3.3V/1.8V switch for the SD card is an output, arrow direction is:
> > > S805 => GPIOAO.BIT3 TF_3V3N_1V8_EN
> > >
> > > That tells me: the arrow direction shows which connections are inputs
> > > or outputs.
> > > Some pins can be input and output at the same time (HDMI_CEC). But
> > > let's keep it simple for now any only look at inputs/output.
> > >
> > > Based on this information I am looking at the arrow direction for
> > > USB_OTG: GPIOAO.BIT5 PWREN <= S805
> > > So this confirms that GPIOAO_5 is an output to the SoC.
> > > Please note though that this part is not linked with any USB host
> > > connector, it's only linked to the USB OTG path.
> > >
> > > For the next part the S805 SoC is not involved:
> > > USB1 USB_HOST_PWR_SW PWREN <= PWREN USB_HUB_GL852G
> > > USB2 USB_HOST_PWR_SW PWREN <= PWREN USB_HUB_GL852G
> > > This tells me that the PWREN signal for the two USB_HOST_PWR_SW (USB
> > > host power switches / current limiters) is driven by the GL852G USB
> > > hub.
> > Hardkernel team responded on the Odroid forums to the request from Anand:
> > "Power-Enable signal to the USB load switch ICs is connected to the
> > USB hub controller.
> > It is not connected the CPU GPIO."
> >
> > The regulator from Anand's patch is therefore connected to the micro USB port.
> > This means that the patch needs updating in case Anand wants to have
> > it included.
> >
>
> Yes, I will send a corrected version of the patches soon.

I have a small query regarding GPIO polarity

As per the datasheet of *MP62551DGT-LF-Z*
[0] https://www.mouser.in/datasheet/2/277/MP62550-1384050.pdf

USB power enables EN signal need to be Active High.

PIN Fucntion > Enable input. Active Low: (MP62550), Active High: (MP62551).

So the correct option in dts
+               /*
+                * signal name from schematics: PWREN - GPIOAO.BIT5
+                */
+               gpios = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
+               enable-active-high;

which gives me the below output.

$  sudo cat /sys/kernel/debug/gpio | grep USB
 gpio-1953 (USB_HUB_RST_N       |usb-hub-reset       ) out hi
 gpio-1954 (USB_OTG_PWREN       |regulator-usb-pwr-en) out hi

Please clear this small query so that I can send the update patch.

Thanks
-Anand

>
> >
> > Best regards,
> > Martin
> >
> >
> > [0] https://forum.odroid.com/viewtopic.php?p=332217#p332217
>
> Thanks
> -Anand
