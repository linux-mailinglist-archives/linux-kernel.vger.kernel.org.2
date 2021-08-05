Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A554E3E1B1B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 20:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241114AbhHESSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 14:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhHESSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 14:18:47 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33ED5C061765;
        Thu,  5 Aug 2021 11:18:33 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id k9so9653333edr.10;
        Thu, 05 Aug 2021 11:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ojNM9xV3H+nI1/a7NsvJNdRoof5hRfKC/9tKy/ZhcHw=;
        b=olqN3ikMo81rNz4+DbVRQ5Gbl0vu0cGksnagpE9AgmSSecjhUJyB2hL20W+uRwdVkZ
         cmeZCYW7JCSZ/NYW0/792UKXVObEHntrwM0GTVFi4UwIV/gNTlp2HXmft1lA96HTWIuY
         bunfazBEz48qFAV19PJIS6M7B1NmkQhrW5o9iWBSgv8YZr7zlXEkqZ/758h1kjTJSA6H
         4CpzFlazcO/6PiXkUUJuP6CNMezIy0+raIkR6RrivKelpHFimF71gUxhmbtION74UFwD
         wwtoNDpw3trioZGMrWgBU0Alwn86VCLubOfleCkMpfO6DnO9roiE3VkgzfqqkB8qIhqp
         Am9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ojNM9xV3H+nI1/a7NsvJNdRoof5hRfKC/9tKy/ZhcHw=;
        b=TVglxS7nCYDb0vmfAqKI1NsCW0UqIlDvLNGGlmiMJx1V4vIaq6KHbcTQOK8BNURdM9
         yDfHXBc7GgFTWyaAwkUm26dDHWczEvyFCjuNIoG7dX27hYwjBu2ivEnnSG+yGMJvm8GG
         tb/mSaU8exN5UL3zw593RBNwytKkOQhenWUtvBCpA6WGveexLIVCcO00LOGinN/NMnwz
         THKj26j6/Qs4E74K30+/CkdWRsjNZWScwVZPjD1uPY1g1JIzFteeNNQ568mOq+nHyjPp
         smxjJ0LNdIPxbRv72Ya1D6GkVaObSXsYH0eiQ1br59EfMtUZC695Oe8S45z+KPe89crh
         YRrA==
X-Gm-Message-State: AOAM531Rk42NnYtXufRME4gGjbVoyMxK46Fl1aHpxAstPWx8gBIwCDNV
        McJ/Zdwbhtwcchz/gOMi+SW04IZ+tpCP5xBbDYE=
X-Google-Smtp-Source: ABdhPJxAQxK02kP1hoG/1FTsH5hCNBUCJGicnRD8GVaXqj7qpLOmlEdfipZjtgyGJx3opxXShvtRUFnXaflfYi8bGXY=
X-Received: by 2002:a05:6402:cae:: with SMTP id cn14mr8314025edb.31.1628187511800;
 Thu, 05 Aug 2021 11:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210716103651.1455-1-linux.amoon@gmail.com> <20210716103651.1455-2-linux.amoon@gmail.com>
 <CAFBinCDeqauw_V-Vn9cat9HaCXj6HEMz6G+G+VbqCNtGEFGYzg@mail.gmail.com>
 <CANAwSgQ5PDGUWMH-jxnz5wwutUVniTn7RAe=4J=8-jbmqxYRRg@mail.gmail.com>
 <CAFBinCBhg+dije+3DvV_V_kqHv9q+r4EPxXCYFti6KuA4mK7KQ@mail.gmail.com>
 <CANAwSgT9-5zGr67aGzBmW6WDBfeiAvjv_zv2UbRC+YbgAGg==A@mail.gmail.com>
 <CAFBinCCGA0b=LVjbQood+iN+DHLodY0RJ-GrSOcgdzrDFJ25pQ@mail.gmail.com>
 <CAFBinCAohjxcsY3D1rdAiYVGL+==cnjzZxg1GmYxSNVhxSTDoA@mail.gmail.com> <CAFBinCAP_DDvPLn4h1yQKEdU_x1ovokHUTPeq3vNV_sDF8PcWg@mail.gmail.com>
In-Reply-To: <CAFBinCAP_DDvPLn4h1yQKEdU_x1ovokHUTPeq3vNV_sDF8PcWg@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Thu, 5 Aug 2021 23:48:20 +0530
Message-ID: <CANAwSgS2vi7hZqX0LWxNTvk-3aN=n1fEErj4Zt0_4CCpZGyRkg@mail.gmail.com>
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

On Thu, 5 Aug 2021 at 03:28, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> On Sun, Jul 18, 2021 at 9:09 PM Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> >
> > Hi Anand,
> >
> > On Sun, Jul 18, 2021 at 4:01 PM Martin Blumenstingl
> > <martin.blumenstingl@googlemail.com> wrote:
> > [...]
> > > > From the schematics [1]
> > > > https://dn.odroid.com/S805/Schematics/odroid-c1+_rev0.4_20160226.pdf
> > > >
> > > > You could find references to PWREN  <--- GPIOAO.BIT5
> > > > The second reference is USB HOST Power Switch
> > > > The third reference is USB HOST POWER.
> > > >
> > > > Hope I am clean in my thought process now.
> > > Can you please point out the page numbers for me?
> > >
> > > What I am seeing on page 1 is:
> > > GPIOAO_5 (called GPIOAO.BIT5) is connected as an INPUT to the USB_OTG
> > > PWREN signal (that's the green box with the label "USB_OTG.SchDoc"
> > > above it).
> > I unfortunately missed your question on IRC on this topic:
> > <armoon> xdarklight: just want to understand the confusion on PWREN,
> > either is INPUT / OTPUT to usb hub am I correct
> > My understanding of the INPUT/OUTPUT direction in the Odroid-C1
> > schematics (which you linked) above is that the arrow direction shows
> > whether it's an input or output.
> > For example (all on page one):
> > - HDMI_HPD is an input to the Meson8b SoC, arrow direction is: HDMI => S805
> > - IR_IN is an input to the Meson8b SoC, arrow direction is: S805 <=
> > GPIOAO.BIT7 IR_IN
> > - PWM is an output, arrow direction is: S805 => PWM.C VCCK_PWM
> > - 3.3V/1.8V switch for the SD card is an output, arrow direction is:
> > S805 => GPIOAO.BIT3 TF_3V3N_1V8_EN
> >
> > That tells me: the arrow direction shows which connections are inputs
> > or outputs.
> > Some pins can be input and output at the same time (HDMI_CEC). But
> > let's keep it simple for now any only look at inputs/output.
> >
> > Based on this information I am looking at the arrow direction for
> > USB_OTG: GPIOAO.BIT5 PWREN <= S805
> > So this confirms that GPIOAO_5 is an output to the SoC.
> > Please note though that this part is not linked with any USB host
> > connector, it's only linked to the USB OTG path.
> >
> > For the next part the S805 SoC is not involved:
> > USB1 USB_HOST_PWR_SW PWREN <= PWREN USB_HUB_GL852G
> > USB2 USB_HOST_PWR_SW PWREN <= PWREN USB_HUB_GL852G
> > This tells me that the PWREN signal for the two USB_HOST_PWR_SW (USB
> > host power switches / current limiters) is driven by the GL852G USB
> > hub.
> Hardkernel team responded on the Odroid forums to the request from Anand:
> "Power-Enable signal to the USB load switch ICs is connected to the
> USB hub controller.
> It is not connected the CPU GPIO."
>
> The regulator from Anand's patch is therefore connected to the micro USB port.
> This means that the patch needs updating in case Anand wants to have
> it included.
>

Yes, I will send a corrected version of the patches soon.

>
> Best regards,
> Martin
>
>
> [0] https://forum.odroid.com/viewtopic.php?p=332217#p332217

Thanks
-Anand
