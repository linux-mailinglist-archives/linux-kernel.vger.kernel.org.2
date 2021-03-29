Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E2834D232
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 16:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhC2ONV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 10:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhC2OMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 10:12:51 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC357C061574;
        Mon, 29 Mar 2021 07:12:50 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id n140so13182568oig.9;
        Mon, 29 Mar 2021 07:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6x8zAt8lnCziyXsdjiT/x+IMPqWACGtewRIKnLgJ5DM=;
        b=ep/MmVDiI62WwC0kfB6zr1ciUzNXIHklI9r7jbqki8dCE7fJLiOn4f5yZuJAAC3Qdu
         DQDDQdDtz1DXj0fcsA0KSbz6JKPHSnP8Lj/rR8gFmPWAkm5SV0xDLc46JNVbC/XfbnFF
         TfuJlEMB1rEwVrj/Ff7saAG4FyI/OXJ9SiAkKj1pOjnaaFNbiY5dZJOwsnJCxbQcGQE9
         RcBCPmrzViUik5W8gsKVvW6A3h6S1fJpMeG+DCrUrl+9EnOx+0xIVyvkVsF5yrGJKs46
         SaGtDG/KamZaeZWeI0IhoRvh3bnrvZElwafBZV+5o6ZaowAW/V5WGSZ2wPkyzGmVRd4K
         GnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6x8zAt8lnCziyXsdjiT/x+IMPqWACGtewRIKnLgJ5DM=;
        b=lKJPC9pSonfq2boWF0/rYDYe+pEKMqSjcWJiE7CUYSqIsZbrCI6Ko9ySz4u6lnt9vH
         U8AhMqWlcYr7poegIoqf7LjFvDI9triObWhcYMKWJd8J1NCQvyAu3N2+JqcVc+aOxF9Z
         1tIM3oXzyqKdrWaDg3UhGB7sJRSHODnSWKI55Y35eTWfo4kLAbVB5Gx5dZsF/MiWg4U9
         qlIiA47c8HHMS4zdMKVbqQkhIfD0MiftKyu75lMseqmH/Kz1P4UHDz6mxgru3MtY4a9Z
         R2lNwY53lOGPg75EsrAUcomSI7I5b3An22ZznSJxArNoMIBW1yUfew2dgk72M93hpAtF
         61fw==
X-Gm-Message-State: AOAM532xw6RcUygt6kA/bV0a7qRlKmBKNDqAMqZ4pQ7uRjJtOhaeWlkx
        FgZENGmCkhGbaXTQvT+e9cDO8PVQ4YMgUTr2slc=
X-Google-Smtp-Source: ABdhPJx/j3y4Qh2rl6er04OVmrJwmrKdoXYya3VLSKn3yF6ACR4jSBDD4hKXJ5fiZGTjxx4t/fYTv4ernKXdjGLaEHI=
X-Received: by 2002:aca:f084:: with SMTP id o126mr17882705oih.95.1617027170000;
 Mon, 29 Mar 2021 07:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <1610720001-15300-1-git-send-email-u0084500@gmail.com>
 <3a4a88a9-f0e3-2b65-9df4-6c1d4e3f1c14@roeck-us.net> <CADiBU38g_E+iH4jTwQfPvJh4=WRH4vzQ12oubGg47gj+CpTU0A@mail.gmail.com>
 <1611041874.12761.13.camel@mhfsdcap03> <CADiBU39fAa30pK5uNCN=sBVZ2pC-ACFqCoY8vKr3+6e+n828tw@mail.gmail.com>
In-Reply-To: <CADiBU39fAa30pK5uNCN=sBVZ2pC-ACFqCoY8vKr3+6e+n828tw@mail.gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Mon, 29 Mar 2021 22:12:38 +0800
Message-ID: <CADiBU3_==CobcGVoLBF35Hp5+5c3kNuWu4MZBxjk0ZkK-L1-bw@mail.gmail.com>
Subject: Re: [PATCH 1/2] usb typec: tcpci: mt6360: Add vsafe0v support and
 external vbus supply control
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        matthias.bgg@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>,
        cy_huang <cy_huang@richtek.com>, gene_chen@richtek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI, reviews:

ChiYuan Huang <u0084500@gmail.com> =E6=96=BC 2021=E5=B9=B41=E6=9C=8819=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:23=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Chunfeng Yun <chunfeng.yun@mediatek.com> =E6=96=BC 2021=E5=B9=B41=E6=9C=
=8819=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=883:38=E5=AF=AB=E9=81=93=
=EF=BC=9A
> >
> > On Mon, 2021-01-18 at 16:28 +0800, ChiYuan Huang wrote:
> > > Guenter Roeck <linux@roeck-us.net> =E6=96=BC 2021=E5=B9=B41=E6=9C=881=
8=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=881:43=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > > >
> > > > On 1/15/21 6:13 AM, cy_huang wrote:
> > > > > From: ChiYuan Huang <cy_huang@richtek.com>
> > > > >
> > > > > MT6360 not support for TCPC command to control source and sink.
> > > >
> > > > does not
> > > >
> > > Ack
> > > > > Uses external 5V vbus regulator as the vbus source control.
> > > > >
> > > > Use
> > > >
> > > Ack
> > > > > Also adds the capability to report vsafe0v.
> > > > >
> > > > add
> > > >
> > > Ack
> > > > So far this driver works without regulator. Unless I am missing som=
ething,
> > > > this patch makes regulator support mandatory, meaning existing code=
 will fail.
> > > > I am not sure if that is appropriate/acceptable. Can we be sure tha=
t this will
> > > > work for existing users of this driver ?
> > > >
> > > Yes, I already checked all the src/snk functionality based on  the
> > > latest typec code.
> > > It'll be common for our TCPC. It didn't support for TCPC command.
> > > From the recent patches, actually, I have the local change to test th=
e
> > > src capability.
> > > But I didn't submit it. It's almost the same to add set_vbus callback=
.
> > > That's why I submit this change after tcpci 'set_vbus callback' is ad=
ded.
> > >
> > > > Thanks,
> > > > Guenter
> > > >
> > > > > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > > > > ---
> > > > >  drivers/usb/typec/tcpm/tcpci_mt6360.c | 29 +++++++++++++++++++++=
++++++++
> > > > >  1 file changed, 29 insertions(+)
> > > > >
> > > > > diff --git a/drivers/usb/typec/tcpm/tcpci_mt6360.c b/drivers/usb/=
typec/tcpm/tcpci_mt6360.c
> > > > > index f1bd9e0..0edf4b6 100644
> > > > > --- a/drivers/usb/typec/tcpm/tcpci_mt6360.c
> > > > > +++ b/drivers/usb/typec/tcpm/tcpci_mt6360.c
> > > > > @@ -11,6 +11,7 @@
> > > > >  #include <linux/of.h>
> > > > >  #include <linux/platform_device.h>
> > > > >  #include <linux/regmap.h>
> > > > > +#include <linux/regulator/consumer.h>
> > > > >  #include <linux/usb/tcpm.h>
> > > > >
> > > > >  #include "tcpci.h"
> > > > > @@ -36,6 +37,7 @@ struct mt6360_tcpc_info {
> > > > >       struct tcpci_data tdata;
> > > > >       struct tcpci *tcpci;
> > > > >       struct device *dev;
> > > > > +     struct regulator *vbus;
> > > > >       int irq;
> > > > >  };
> > > > >
> > > > > @@ -51,6 +53,27 @@ static inline int mt6360_tcpc_write16(struct r=
egmap *regmap,
> > > > >       return regmap_raw_write(regmap, reg, &val, sizeof(u16));
> > > > >  }
> > > > >
> > > > > +static int mt6360_tcpc_set_vbus(struct tcpci *tcpci, struct tcpc=
i_data *data, bool src, bool snk)
> > > > > +{
> > > > > +     struct mt6360_tcpc_info *mti =3D container_of(data, struct =
mt6360_tcpc_info, tdata);
> > > > > +     int ret;
> > > > > +
> > > > > +     /* To correctly handle the already enabled vbus and disable=
 its supply first */
> > > > > +     if (regulator_is_enabled(mti->vbus)) {
> > > > > +             ret =3D regulator_disable(mti->vbus);
> > > > > +             if (ret)
> > > > > +                     return ret;
> > > > > +     }
> > > >
> > > > Is it really a good idea to disable vbus if it happens to be alread=
y enabled
> > > > and there is (another ?) request to enable it ?
> > > >
> > > Yes, for  the state change from src_attach_wait to src_attach,
> > > It need to meet the requirement that  the vbus is at vsafe0v.
> > > So to disable it first is needed.
> > > And to prevent other users from enabling/disabling external vbus
> > > regulator in any case.
> > > I think we may change regulator_get  to 'regulator_get_exclusive'.
> > > From the design, 5v regulator only can be controlled via typec framew=
ork.
> > > If other user touch it, it'll affect the typec state transition.
> > How about to process the case that even switch usb controller to device
> > mode, platform also need to keep vbus on? e.g. Iphone Carplay
> >
> >
> It must be processed by USBPD data role swap.
>
> Type C only decide the initial role (SNK: power snk and ufp; SRC:
> power src and DFP).
> Only USBPD can change the power/data/vconn role individually.
>
I'm  not sure the status about this patch.
But I'm trying to figure out the problems about some TCPCs.

Not all TCPCs can support the source_vbus/sink_vbus command.
I'm trying to add this patch make our mt6360 tcpc work.

Originally, I add some proprietary code in usb to make the otg vbus
output due to no set_vbus callback handled by vendor ops.

Eventually, I found the patch
b9358a068490 usb: typec: tcpci: Add set_vbus tcpci callback

Hope to get any response from you.
> > > > > +
> > > > > +     if (src) {
> > > > > +             ret =3D regulator_enable(mti->vbus);
> > > > > +             if (ret)
> > > > > +                     return ret;
> > > > > +     }
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > >  static int mt6360_tcpc_init(struct tcpci *tcpci, struct tcpci_da=
ta *tdata)
> > > > >  {
> > > > >       struct regmap *regmap =3D tdata->regmap;
> > > > > @@ -138,7 +161,13 @@ static int mt6360_tcpc_probe(struct platform=
_device *pdev)
> > > > >       if (mti->irq < 0)
> > > > >               return mti->irq;
> > > > >
> > > > > +     mti->vbus =3D devm_regulator_get(&pdev->dev, "vbus");
> > > > > +     if (IS_ERR(mti->vbus))
> > > > > +             return PTR_ERR(mti->vbus);
> > > > > +
> > > > >       mti->tdata.init =3D mt6360_tcpc_init;
> > > > > +     mti->tdata.set_vbus =3D mt6360_tcpc_set_vbus;
> > > > > +     mti->tdata.vbus_vsafe0v =3D 1;
> > > > >       mti->tcpci =3D tcpci_register_port(&pdev->dev, &mti->tdata)=
;
> > > > >       if (IS_ERR(mti->tcpci)) {
> > > > >               dev_err(&pdev->dev, "Failed to register tcpci port\=
n");
> > > > >
> > > >
> >
