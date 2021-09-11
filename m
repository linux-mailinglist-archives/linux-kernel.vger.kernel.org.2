Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDA140768D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 14:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235796AbhIKMVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 08:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhIKMVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 08:21:18 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944C4C061574;
        Sat, 11 Sep 2021 05:20:05 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id a21so4014507vsp.12;
        Sat, 11 Sep 2021 05:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7H4xpqYSY81qruCKg0gMtRjcT5K5rttH7wg/f9oDRUM=;
        b=EjO+h+qRdpbAaxSWbNySY0QHC1aHKW7nV63e4IqtLrd636xgC/5uI+LtnX69vgv0wx
         XJUILMykuNMsKd+JQRY7VEYrGKnKytB+LHSkmoC2sgf9U3WQ3lpoxM6jqgabw01fOqSV
         aPyoRXE1I+uuZInytFq6ZMW9wC9m9XVqbOVi2Xe2Nf+EIT6TPJIwCW2MSM9G7KP3o23p
         lPicPE5P2YpprhhSTM3AJa3F61nDbAuXHIHT3ZbhdXIFbPSpkmL83BKOJPQ79uEvohMP
         W6lDSC3YZe+2fE4kOjj4MRn6V0TMXY2QbR/lONQmIP6HRASOqyvzufMxTMlyTeNOmnXQ
         LUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7H4xpqYSY81qruCKg0gMtRjcT5K5rttH7wg/f9oDRUM=;
        b=0cWBifenGshzDDQegqzFnydgN3bXu+7CIdoNMngUSM6e68+J9o1swRDVHMv48uUE7i
         W6ju2jBG9NslUqPZNGpzywJmhbckiVcFaeYs02Jfdp0Oohyu1rBxadIZXL8looAPjRrZ
         HiuAJMn2Hj1s0eU9SLDzX7/5vf4GJ6H+aiXsDYJrx0bwI6qHiz3nio6W70hgEqWov0jy
         um9TNV4CPh4xlssW+Lv3b/9u3iUMV7JMr4jRC5hoWFjvRH6Mi6EtOlC1iDymDq8gqxtU
         6oTIlWXeo3yL9Ilk4eSo4nfj3xPmBV9tXXtEj3U1FyZPUIkAYAj9YpLeImwK40VIe93e
         amMw==
X-Gm-Message-State: AOAM5302p5ulyzG55JMQIvmgSDWmtgo5iiggbZk2DAkHK7zKPVqP/4ay
        AUvbTmaxUJio+3RWo9OkYj5LY6kT+9Jq/8dIHZ7QEALm
X-Google-Smtp-Source: ABdhPJwx8ta3pvKIUZJBToP9h/NasPw2m0chELd5Fz7tfkbqg/HunG1xeb+C+1VTrJrxG0KT4myBNizMQaCNb+rNFsI=
X-Received: by 2002:a67:ef85:: with SMTP id r5mr756445vsp.32.1631362804642;
 Sat, 11 Sep 2021 05:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210910190322.27058-1-romain.perier@gmail.com>
 <20210910190322.27058-3-romain.perier@gmail.com> <CAFr9PXmRXcu_ifE62dT5AwZv2uFbYVfAc5ZX5qBoRkEPKGB+JA@mail.gmail.com>
In-Reply-To: <CAFr9PXmRXcu_ifE62dT5AwZv2uFbYVfAc5ZX5qBoRkEPKGB+JA@mail.gmail.com>
From:   Romain Perier <romain.perier@gmail.com>
Date:   Sat, 11 Sep 2021 14:19:53 +0200
Message-ID: <CABgxDoLBbD8P-PhRH+SmuuQ8jNR53Ti=8brFL3NXMmiotXU5ww@mail.gmail.com>
Subject: Re: [PATCH 2/4] ARM: dts: mstar: Add the Wireless Tag IDO-SBC2D06-V1B-22W
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Ack, I will fix it (remove "common" from the file name and the unneeded spa=
ce)

Thanks,
Romain

Le sam. 11 sept. 2021 =C3=A0 05:18, Daniel Palmer <daniel@0x0f.com> a =C3=
=A9crit :
>
> Hi Romain,
>
> On Sat, 11 Sept 2021 at 04:03, Romain Perier <romain.perier@gmail.com> wr=
ote:
> > +              - wirelesstag,ido-som2d01 # Wireless Tag IDO-SOM2D01
> > +              - wirelesstag,ido-sbc2d06-v1b-22w # Wireless Tag IDO-SBC=
2D06-1VB-22W
>
> For anyone wondering why we have two strings here:
> The SBC board is made up of a SoM and a board with the connectors.
> The SoM could be used standalone so we might as well have a compatible
> for it too.
> We have some dtsis for the SoM but really those could be built as is
> to support someone using the SoM on it's own.
>
> > +++ b/arch/arm/boot/dts/mstar-infinity2m-ssd201-som2d01-common.dtsi
>
> For anyone wondering:
>
> The som2d01 can come with an SSD201 (64MB DDR2 integrated) or SSD202D
> (128MB DDR3 integrated) and they need different fixed regulators for
> the DDR supply.
> So we have a common dtsi and then override the regulator in another
> layer of dtsi for the SSD202D version.
>
> Thinking about it now I think we can drop common from the file name.
>
> > @@ -0,0 +1,21 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> > +/*
> > + * Copyright (c) 2021 thingy.jp.
> > + * Author: Daniel Palmer <daniel@thingy.jp>
> > + * Author: Romain Perier <romain.perier@gmail.com>
> > + */
> > +
> > +/ {
> > +
>
> Unneeded space.
>
> > +       reg_vcc_dram: regulator-vcc-dram {
> > +               compatible =3D "regulator-fixed";
> > +               regulator-name =3D "vcc_dram";
> > +               regulator-min-microvolt =3D <1800000>;
> > +               regulator-max-microvolt =3D <1800000>;
> > +               regulator-boot-on;
> > +       };
> > +};
> > +
> > +&pm_uart {
> > +       status =3D "okay";
> > +};
> > diff --git a/arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesstag-ido=
-sbc2d06-v1b-22w.dts b/arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesst=
ag-ido-sbc2d06-v1b-22w.dts
> > new file mode 100644
> > index 000000000000..20b40b711d4f
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesstag-ido-sbc2d0=
6-v1b-22w.dts
> > @@ -0,0 +1,23 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> > +/*
> > + * Copyright (c) 2021 thingy.jp.
> > + * Author: Daniel Palmer <daniel@thingy.jp>
> > + * Author: Romain Perier <romain.perier@gmail.com>
> > + */
> > +
> > +/dts-v1/;
> > +#include "mstar-infinity2m-ssd202d-wirelesstag-ido-som2d01.dtsi"
> > +#include <dt-bindings/gpio/gpio.h>
> > +
> > +/ {
> > +       model =3D "Wireless Tag IDO-SBC2D06-1VB-22W";
> > +       compatible =3D "wirelesstag,ido-sbc2d06-v1b-22w", "wirelesstag,=
ido-som2d01", "mstar,infinity2m";
> > +
> > +       leds {
> > +               compatible =3D "gpio-leds";
> > +               sys_led {
> > +                       gpios =3D <&gpio SSD20XD_GPIO_GPIO85 GPIO_ACTIV=
E_LOW>;
> > +                       linux,default-trigger =3D "heartbeat";
> > +               };
> > +       };
> > +};
> > diff --git a/arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesstag-ido=
-som2d01.dtsi b/arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesstag-ido-=
som2d01.dtsi
> > new file mode 100644
> > index 000000000000..06567a5219c5
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesstag-ido-som2d0=
1.dtsi
> > @@ -0,0 +1,28 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> > +/*
> > + * Copyright (c) 2021 thingy.jp.
> > + * Author: Daniel Palmer <daniel@thingy.jp>
> > + * Author: Romain Perier <romain.perier@gmail.com>
> > + */
> > +
> > +/dts-v1/;
> > +#include "mstar-infinity2m-ssd202d.dtsi"
> > +#include "mstar-infinity2m-ssd201-som2d01-common.dtsi"
> > +
> > +/ {
> > +       model =3D "Wireless Tag IDO-SOM2D01 (SSD202D)";
> > +       compatible =3D "wirelesstag,ido-som2d01", "mstar,infinity2m";
> > +
> > +       aliases {
> > +               serial0 =3D &pm_uart;
> > +       };
> > +
> > +       chosen {
> > +               stdout-path =3D "serial0:115200n8";
> > +       };
> > +};
> > +
> > +&reg_vcc_dram {
> > +       regulator-min-microvolt =3D <1500000>;
> > +       regulator-max-microvolt =3D <1500000>;
> > +};
> > --
> > 2.33.0
> >
>
> Cheers,
>
> Daniel
