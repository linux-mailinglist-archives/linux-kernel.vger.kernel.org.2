Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE523E0A2D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 23:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbhHDV6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 17:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhHDV6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 17:58:49 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA8EC0613D5;
        Wed,  4 Aug 2021 14:58:35 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id hs10so6034309ejc.0;
        Wed, 04 Aug 2021 14:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UDFP+Kh/RXp5326ifRvFQhSNe6psMCNDhU/dD1rM8SA=;
        b=aJO8jUZNJLtuyY3pbXnWfLurE2o2BUbvMDRodBpaALLIZ2vk5/obf8tI5CyYpMWTl4
         S5XUXdJF3PHtTAjg1DnFFgd/mL0mQPgOyIfSKCMBkE3duy8WCvdniyRU3ptJt6GCKL4I
         AmFaCUzJ4/DmqYkLrHG+EIqPrkKkmjWYETYbTwpidM68uG/HOw2hgTJMXL1IsS1iPgXJ
         gu6v4/zddwPtMK9qctadVp9lM8/aFvqZF/tklCEWR1KjObJTv+twR7GK4pTmy5nR2Uac
         aoh16hY5LSJeQccnLabchOIf2UooX6zYGnswmEMOHR9ZBaIFCgYCc1l/WXNjd/jPragF
         3zIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UDFP+Kh/RXp5326ifRvFQhSNe6psMCNDhU/dD1rM8SA=;
        b=jkeD0RDNW0nocveiyjbYBBX/POk/LqmbZUaPvA3mqMqjF1+QJQtNm0/oYuhW15U/1b
         s/xdzouxuwXxxqhIL5XeEq5L8xfICIPbgpK20lu1TStRzhkCi7e8qxqaYUecAgmirOhE
         v6doySSOJ2EQdrC7WY+OHuxZqpCuGXmpgXOT6K2kal56UfkmUYkpwYhI7tPhAfX/WU7s
         ZeqRuhYKRtxHFFPL7vlPYobbmhRhsxlZHTM75H2mpzWMhbuxGYSRxKy06TxcqFPpcB/d
         bLyomuxlCStHmct8Xt/BC3pTxAeLzcQSdezYPvVFEmuf6IJvMvvnpn/x/XZOAN+HniXW
         UW7g==
X-Gm-Message-State: AOAM531v62pa0LYU00tkkV2o3f6H7vUWabpgQ8cegtY+UlKLflQqLJnY
        PEeUes8mXgO6XylwZYcrd3vdeUMT90LW4su+JoM=
X-Google-Smtp-Source: ABdhPJy+1zg5ha6tdssaaLOTO5ub8yD6ePygjh/AQXLvSk2ersQk/TktWkm2YuWkuPfs+j45CXhQuk4L7keHv/Dy1cE=
X-Received: by 2002:a17:906:b0c5:: with SMTP id bk5mr1228728ejb.428.1628114314016;
 Wed, 04 Aug 2021 14:58:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210716103651.1455-1-linux.amoon@gmail.com> <20210716103651.1455-2-linux.amoon@gmail.com>
 <CAFBinCDeqauw_V-Vn9cat9HaCXj6HEMz6G+G+VbqCNtGEFGYzg@mail.gmail.com>
 <CANAwSgQ5PDGUWMH-jxnz5wwutUVniTn7RAe=4J=8-jbmqxYRRg@mail.gmail.com>
 <CAFBinCBhg+dije+3DvV_V_kqHv9q+r4EPxXCYFti6KuA4mK7KQ@mail.gmail.com>
 <CANAwSgT9-5zGr67aGzBmW6WDBfeiAvjv_zv2UbRC+YbgAGg==A@mail.gmail.com>
 <CAFBinCCGA0b=LVjbQood+iN+DHLodY0RJ-GrSOcgdzrDFJ25pQ@mail.gmail.com> <CAFBinCAohjxcsY3D1rdAiYVGL+==cnjzZxg1GmYxSNVhxSTDoA@mail.gmail.com>
In-Reply-To: <CAFBinCAohjxcsY3D1rdAiYVGL+==cnjzZxg1GmYxSNVhxSTDoA@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 4 Aug 2021 23:58:23 +0200
Message-ID: <CAFBinCAP_DDvPLn4h1yQKEdU_x1ovokHUTPeq3vNV_sDF8PcWg@mail.gmail.com>
Subject: Re: [PATCHv2 1/4] ARM: dts: meson8b: odroidc1: Add usb phy power node
To:     Anand Moon <linux.amoon@gmail.com>
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

On Sun, Jul 18, 2021 at 9:09 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Sun, Jul 18, 2021 at 4:01 PM Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> [...]
> > > From the schematics [1]
> > > https://dn.odroid.com/S805/Schematics/odroid-c1+_rev0.4_20160226.pdf
> > >
> > > You could find references to PWREN  <--- GPIOAO.BIT5
> > > The second reference is USB HOST Power Switch
> > > The third reference is USB HOST POWER.
> > >
> > > Hope I am clean in my thought process now.
> > Can you please point out the page numbers for me?
> >
> > What I am seeing on page 1 is:
> > GPIOAO_5 (called GPIOAO.BIT5) is connected as an INPUT to the USB_OTG
> > PWREN signal (that's the green box with the label "USB_OTG.SchDoc"
> > above it).
> I unfortunately missed your question on IRC on this topic:
> <armoon> xdarklight: just want to understand the confusion on PWREN,
> either is INPUT / OTPUT to usb hub am I correct
> My understanding of the INPUT/OUTPUT direction in the Odroid-C1
> schematics (which you linked) above is that the arrow direction shows
> whether it's an input or output.
> For example (all on page one):
> - HDMI_HPD is an input to the Meson8b SoC, arrow direction is: HDMI => S805
> - IR_IN is an input to the Meson8b SoC, arrow direction is: S805 <=
> GPIOAO.BIT7 IR_IN
> - PWM is an output, arrow direction is: S805 => PWM.C VCCK_PWM
> - 3.3V/1.8V switch for the SD card is an output, arrow direction is:
> S805 => GPIOAO.BIT3 TF_3V3N_1V8_EN
>
> That tells me: the arrow direction shows which connections are inputs
> or outputs.
> Some pins can be input and output at the same time (HDMI_CEC). But
> let's keep it simple for now any only look at inputs/output.
>
> Based on this information I am looking at the arrow direction for
> USB_OTG: GPIOAO.BIT5 PWREN <= S805
> So this confirms that GPIOAO_5 is an output to the SoC.
> Please note though that this part is not linked with any USB host
> connector, it's only linked to the USB OTG path.
>
> For the next part the S805 SoC is not involved:
> USB1 USB_HOST_PWR_SW PWREN <= PWREN USB_HUB_GL852G
> USB2 USB_HOST_PWR_SW PWREN <= PWREN USB_HUB_GL852G
> This tells me that the PWREN signal for the two USB_HOST_PWR_SW (USB
> host power switches / current limiters) is driven by the GL852G USB
> hub.
Hardkernel team responded on the Odroid forums to the request from Anand:
"Power-Enable signal to the USB load switch ICs is connected to the
USB hub controller.
It is not connected the CPU GPIO."

The regulator from Anand's patch is therefore connected to the micro USB port.
This means that the patch needs updating in case Anand wants to have
it included.


Best regards,
Martin


[0] https://forum.odroid.com/viewtopic.php?p=332217#p332217
