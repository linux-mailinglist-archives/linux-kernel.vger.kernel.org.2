Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49EE74016E7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 09:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240056AbhIFHVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 03:21:54 -0400
Received: from mail.thorsis.com ([92.198.35.195]:51298 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233040AbhIFHVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 03:21:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.thorsis.com (Postfix) with ESMTP id EB34D1C60;
        Mon,  6 Sep 2021 09:20:47 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mail.thorsis.com
Received: from mail.thorsis.com ([127.0.0.1])
        by localhost (mail.thorsis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Na__r9QRpKGM; Mon,  6 Sep 2021 09:20:47 +0200 (CEST)
Received: by mail.thorsis.com (Postfix, from userid 109)
        id 4FF701C69; Mon,  6 Sep 2021 09:20:45 +0200 (CEST)
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NO_RECEIVED,
        NO_RELAYS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.2
X-Spam-Report: * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: thorsis.com]
        * -0.0 NO_RELAYS Informational: message was not relayed via SMTP
        * -0.0 NO_RECEIVED Informational: message has no Received headers
From:   Alexander Dahl <ada@thorsis.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        Cristian Birsan <Cristian.Birsan@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] USB: host: ehci-atmel: Allow enabling HSIC on SAMA5D2
Date:   Mon, 06 Sep 2021 09:20:38 +0200
Message-ID: <2753502.AcZM6cElzO@ada>
In-Reply-To: <7c3d1248-b708-68f9-a76a-712e345b8218@microchip.com>
References: <20210823140052.GA120849@rowland.harvard.edu> <20210824063702.24586-1-ada@thorsis.com> <7c3d1248-b708-68f9-a76a-712e345b8218@microchip.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nicolas,

Am Donnerstag, 2. September 2021, 17:33:50 CEST schrieb Nicolas Ferre:
> Hi Alexander,
>=20
> On 24/08/2021 at 08:37, Alexander Dahl wrote:
> > Unlike other SoC series featuring the 'atmel,at91sam9g45-ehci' USB EHCI
> > controller, which have embedded USB high-speed transceivers for each
> > port, the third port on the SAMA5D2 series is HSIC only.  That HSIC
> > interface is not enabled after a power-on reset, but can be enabled by
> > setting a flag in a vendor specific EHCI register.
> >=20
> > The register offsets added to the new header file were compared with
> > those for the SAM9G45, SAM9X25, SAMA5D3, SAMA5D4, and SAM9X60 series and
> > there are no differences in the offsets or contents of those registers.
> > Which of those additional vendor specific registers are supported,
> > differs by SoC family.  So while the HSIC enable feature is currently
> > only present for SAMA5D2, it probably does not hurt to set it on the
> > other families, hence no additional check for SoC family here.
> >=20
> > Tested on a custom board featuring a SAMA5D27C-D5M SiP connected to an
> > USB3503 hub with an upstream HSIC interface.
> >=20
> > Link: https://community.atmel.com/forum/sama5d2-using-hsic-under-linux
> > Signed-off-by: Alexander Dahl <ada@thorsis.com>
>=20
> Sorry for not having coming back to you earlier, summertime...

I had one week off last week due to a mild infection myself, so we just=20
proceed here and now. (-:

> What you are looking for is what Cristian developed in our "vendor tree"
> and that needs to be "Mainlined":
> https://github.com/linux4sam/linux-at91/commit/ca368f544899c14b03df9ce751=
068
> 4f03acf1bf9

Looks like it does what it should from quick code inspection. One could=20
nitpick some things, maybe I add some comments on GitHub.

> It allows us to have a gigabit Ethernet HSIC connected on our sama5d2
> ICP board. It works well for some time.

Good to hear.

> For DT, we rely on the standard "phy_type" property set to "hsic" as
> highlighted in this DT node on the ICP board precisely:
> https://github.com/linux4sam/linux-at91/blob/master/arch/arm/boot/dts/at9=
1-s
> ama5d2_icp.dts#L766
>=20
> This way we can use the of_usb_get_phy_mode() standard function:
> https://github.com/linux4sam/linux-at91/blob/master/drivers/usb/phy/of.c#=
L28

I noticed that phy_type property, but did not follow that approach, because=
=20
that USB block in SAMA5D2 has three ports, where one (A) is shared with a=20
device port, two (A and B) have embedded transceivers, and only the third (=
C)=20
has that HSIC interface, but nothing else. So the flag has no effect on por=
t A=20
and B anyways, and I would have found it misleading to set phy_type to HSIC=
=20
for the whole USB block.

> All this tells me that I would prefer Cristi's approach. If agreed,
> we'll make sure to make progress on the mainlining part soon.

I don't mind. If that's your preferred approach, I will happily test it. Wa=
s=20
the series already posted to upstream?

> Hope that it helps. Best regards,
>    Nicolas

Yes, indeed. Thanks for your feedback.

Greets
Alex

>=20
> > ---
> >=20
> > Notes:
> >      - for introducing new dt binding, would be nice to convert old one
> >     =20
> >        first, probably needs split up and multiple iteration review?
> >     =20
> >      - name of that new dt property?
> >      - register definitions put to a separate file, like
> >     =20
> >        'drivers/usb/host/ehci-fsl.h'
> >     =20
> >      - unsure where exactly in the probe process that register write
> >      should
> >     =20
> >        happen, datasheet gives no hint
> >     =20
> >      - should suspend/resume be considered?
> >  =20
> >   drivers/usb/host/ehci-atmel.c | 17 +++++++++++++++++
> >   drivers/usb/host/ehci-atmel.h | 19 +++++++++++++++++++
> >   2 files changed, 36 insertions(+)
> >   create mode 100644 drivers/usb/host/ehci-atmel.h
> >=20
> > diff --git a/drivers/usb/host/ehci-atmel.c b/drivers/usb/host/ehci-atme=
l.c
> > index e893467d659c..f8d9e686c082 100644
> > --- a/drivers/usb/host/ehci-atmel.c
> > +++ b/drivers/usb/host/ehci-atmel.c
> > @@ -20,6 +20,7 @@
> >=20
> >   #include <linux/usb/hcd.h>
> >  =20
> >   #include "ehci.h"
> >=20
> > +#include "ehci-atmel.h"
> >=20
> >   #define DRIVER_DESC "EHCI Atmel driver"
> >=20
> > @@ -85,6 +86,7 @@ static void atmel_stop_ehci(struct platform_device
> > *pdev)
> >=20
> >   static int ehci_atmel_drv_probe(struct platform_device *pdev)
> >   {
> >=20
> > +       struct device_node *np =3D pdev->dev.of_node;
> >=20
> >          struct usb_hcd *hcd;
> >          const struct hc_driver *driver =3D &ehci_atmel_hc_driver;
> >          struct resource *res;
> >=20
> > @@ -149,6 +151,14 @@ static int ehci_atmel_drv_probe(struct
> > platform_device *pdev)>=20
> >          atmel_start_ehci(pdev);
> >=20
> > +       if (of_property_read_bool(np, "atmel,enable-hsic")) {
> > +               u32 tmp;
> > +
> > +               tmp =3D ehci_readl(ehci, hcd->regs + AT91_UHPHS_INSNREG=
08);
> > +               tmp |=3D AT91_UHPHS_HSIC_EN;
> > +               ehci_writel(ehci, tmp, hcd->regs + AT91_UHPHS_INSNREG08=
);
> > +       }
> > +
> >=20
> >          retval =3D usb_add_hcd(hcd, irq, IRQF_SHARED);
> >          if (retval)
> >         =20
> >                  goto fail_add_hcd;
> >=20
> > @@ -170,10 +180,17 @@ static int ehci_atmel_drv_probe(struct
> > platform_device *pdev)>=20
> >   static int ehci_atmel_drv_remove(struct platform_device *pdev)
> >   {
> >  =20
> >          struct usb_hcd *hcd =3D platform_get_drvdata(pdev);
> >=20
> > +       struct ehci_hcd *ehci;
> > +       u32 tmp;
> >=20
> >          usb_remove_hcd(hcd);
> >          usb_put_hcd(hcd);
> >=20
> > +       ehci =3D hcd_to_ehci(hcd);
> > +       tmp =3D ehci_readl(ehci, hcd->regs + AT91_UHPHS_INSNREG08);
> > +       tmp &=3D ~AT91_UHPHS_HSIC_EN;
> > +       ehci_writel(ehci, tmp, hcd->regs + AT91_UHPHS_INSNREG08);
> > +
> >=20
> >          atmel_stop_ehci(pdev);
> >         =20
> >          return 0;
> >=20
> > diff --git a/drivers/usb/host/ehci-atmel.h b/drivers/usb/host/ehci-atme=
l.h
> > new file mode 100644
> > index 000000000000..4c4998c2a6dd
> > --- /dev/null
> > +++ b/drivers/usb/host/ehci-atmel.h
> > @@ -0,0 +1,19 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Vendor specific definitions for EHCI on Atmel/Microchip SoCs.
> > + *
> > + * =A9 2021 Alexander Dahl <ada@thorsis.com>
> > + */
> > +#ifndef EHCI_ATMEL_H
> > +#define EHCI_ATMEL_H
> > +
> > +/* device specific register offsets, taken from SAMA5D2 datasheet */
> > +
> > +#define AT91_UHPHS_INSNREG06    0xA8        /* AHB Error Status Regist=
er
> > */ +
> > +#define AT91_UHPHS_INSNREG07    0xAC        /* AHB Master Error Address
> > Register */ +
> > +#define AT91_UHPHS_INSNREG08    0xB0        /* HSIC Enable/Disable
> > Register */ +#define AT91_UHPHS_HSIC_EN      (1 << 2)    /* HSIC
> > Enable/Disable */ +
> > +#endif /* ECHI_ATMEL_H */
> >=20
> > base-commit: e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93
> > --
> > 2.30.2


=2D-=20



