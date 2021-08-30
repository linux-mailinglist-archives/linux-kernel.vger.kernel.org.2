Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1436E3FBE9E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 23:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238749AbhH3V5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 17:57:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233612AbhH3V5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 17:57:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C994A60FA0;
        Mon, 30 Aug 2021 21:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630360576;
        bh=BL2a/+ILZCMV88SgrRizcRt8Z6238csTH1V+RUMXRbk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=srEDS6O56XDegSh04E5eoXkPUJb21dA8D8sj14WT5Z2EVxgFduXjl84bIHbk42/5E
         LlLwoVbWLuRj3O4+5oXOh9s7ezfIUB4mLipRnbvFrvc4EYKEJEId41/yodvU2GMUcP
         eWD7QGZupimrKVJvFVxtdH3ofJZdJu+qHFb8R56etLh2bUa0J8OU5Dcr0T6uTh0mTp
         JYHIysXvDU5NNJ83suA6LAE8kooesztx2D8S+lipaBKiZMsdb/GNyAT2MDW6yWLA3v
         dHEEseQobHtKSg2NIvvSmzjWwVYuhNLTFuqNx6XZ2RfAVzC6qJoBjL053wCntu5WoQ
         2CZGJJwlaXTvA==
Received: by mail-ej1-f42.google.com with SMTP id me10so34223759ejb.11;
        Mon, 30 Aug 2021 14:56:16 -0700 (PDT)
X-Gm-Message-State: AOAM530RK5+CA1KN0ZH+RjBmYCQZisrYRP1UrcsFsZvL301imi9yJokJ
        X4VpOi7dIWfUf2k9w+/vY4CXTl04Pq7uSUDvUA==
X-Google-Smtp-Source: ABdhPJwk8Z7m3j8Ym+P+boObT4LEZn4Mw7FR56a8AB/W7yV1bdAL9KIv8YaRGdWT3u7gL8xAKB17NHzq8lI9e9tMGvU=
X-Received: by 2002:a17:906:d9dc:: with SMTP id qk28mr27314626ejb.359.1630360575439;
 Mon, 30 Aug 2021 14:56:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210830103909.323356-1-nsaenzju@redhat.com> <YSzfoyesEzAuLkSS@robh.at.kernel.org>
 <22bbfdefb2b9a1a65a807d0aecee67e607b7ff60.camel@redhat.com>
In-Reply-To: <22bbfdefb2b9a1a65a807d0aecee67e607b7ff60.camel@redhat.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 30 Aug 2021 16:56:04 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJgf3SD51+_J=oNAOvMc9PmFNmuaVrisKkGV++JUzBwew@mail.gmail.com>
Message-ID: <CAL_JsqJgf3SD51+_J=oNAOvMc9PmFNmuaVrisKkGV++JUzBwew@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: bcm2711-rpi-4-b: Fix pcie0's unit address
To:     nsaenzju@redhat.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 11:45 AM <nsaenzju@redhat.com> wrote:
>
> On Mon, 2021-08-30 at 08:39 -0500, Rob Herring wrote:
> > On Mon, Aug 30, 2021 at 12:39:09PM +0200, Nicolas Saenz Julienne wrote:
> > > dtbs_check currently complains that:
> > >
> > > arch/arm/boot/dts/bcm2711-rpi-4-b.dts:220.10-231.4: Warning
> > > (pci_device_reg): /scb/pcie@7d500000/pci@1,0: PCI unit address format
> > > error, expected "0,0"
> > >
> > > Unsurprisingly pci@0,0 is the right address, as illustrated by its reg
> > > property:
> > >
> > >     &pcie0 {
> > >             pci@0,0 {
> > >                     /*
> > >                      * As defined in the IEEE Std 1275-1994 document,
> > >                      * reg is a five-cell address encoded as (phys.hi
> > >                      * phys.mid phys.lo size.hi size.lo). phys.hi
> > >                      * should contain the device's BDF as 0b00000000
> > >                      * bbbbbbbb dddddfff 00000000. The other cells
> > >                      * should be zero.
> > >                      */
> > >                     reg = <0 0 0 0 0>;
> > >             };
> > >     };
> > >
> > > The bus is clearly 0. So fix it.
> >
> > s/bus/device/
> >
> > The unit-address format is '<device>,<function>' (and function is
> > optional). The bus number is not part of the unit-address because that
> > is dynamic and then the path would not be fixed/known. The bus is part
> > of 'reg' for true OpenFirmware, but for FDT I think it should always be
> > 0 as the DT is static.
> >
> > Looks like the child node is wrong (both unit-address and reg) as well:
> >
> >                 usb@1,0 {
> >                         reg = <0x10000 0 0 0 0>;
> >                         resets = <&reset RASPBERRYPI_FIRMWARE_RESET_ID_USB>;
> >                 };
> >
> > It doesn't warn because the bridge node is also missing 'device_type =
> > "pci";'.
> >
> > This is all fairly hard to get right (see recent hikey970 patches for a
> > complex example). I'm thinking about writing a tool that generates a DT
> > with PCI nodes by reading the PCI hierachy from sysfs.
>
> Just to double-check I understood everything, with:
>
>         lspci -D -PP
>         0000:00:00.0 PCI bridge: Broadcom Inc. and subsidiaries BCM2711 PCIe Bridge (rev 10)
>         0000:00:00.0/01:00.0 USB controller: VIA Technologies, Inc. VL805/806 xHCI USB 3.0 Controller (rev 01)
>
> It should look like this:
>
>         &pcie0 {
>                 pci@0,0 {
>                         device_type = "pci";
>                         #address-cells = <3>;
>                         #size-cells = <2>;
>                         ranges;
>
>                         reg = <0 0 0 0 0>;
>
>                         usb@0,0 {
>                                 reg = <0 0 0 0 0>;
>                                 resets = <&reset RASPBERRYPI_FIRMWARE_RESET_ID_USB>;
>                         };
>                 };
>         };

Yes, that looks correct.

Rob
