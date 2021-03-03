Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC52232BCDE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244766AbhCCO6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 09:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1843049AbhCCKY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:24:56 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F664C061D7F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 01:03:38 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id c10so14172205ejx.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 01:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vMTqfQU5WtePmhqntDyTowla4Y3Wcf7Wf+OWv8RULi4=;
        b=t5XWWmloQ6iS2paBEz94ecoH3Qc2Bl+Dg58Tk4QXlI23WpnXJTLTjBEEUjZ4YRwpvo
         AHFqjIUAicuKlm+HKJnH9yq/XonTwm0hBPrTXOR130CtgepkQ8oGmNpOLj2pf9XJmVDB
         qH9/r7qUlGtsZeR23FtWXL8HMz/HAcK+zq7Q9Kx+EZn6tT+yfc58IndcHOucZWZ2viye
         vRdNiJ5lJH/+aoSqZgFF6wrwXiaRrJV/T1jUs1zOkQQ4zNEB3R7yDoRLdsafbdHw4k7S
         qYGG8VKhFDDqCIpSiivZbrm+ObAH2/QomPlVX/54zzTzqc9urSuDj6LgFQlcggMffGuf
         uldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vMTqfQU5WtePmhqntDyTowla4Y3Wcf7Wf+OWv8RULi4=;
        b=GvPxtTPot2E+cdnxWraKSVaN96OUFS9j+4nCCeWRB/HvGCrRrkd+rzugEzvhAjKl8e
         9PWgRykcWkbUc2gpEEWvnIFjAalSHofGTEjmBXIez6hVTIznkNdZQu4tleS63iSOT17F
         3cGhHCr3klFRSSfECYP+DwgY5B2TJx3xSv5qQ/uh6BptvwnGjkoVTxh2unqoeBWMfCBX
         csacdIOQkg0Ysu9+nX92OsnEJELeqMa1QjVtqt7p59kQxAqjRgvEQI1KPP7oJOsDdLZa
         tW+nP/mt0eSs8xXM79Y2M28GWCJyDdWhgzk+circ/FcUrMlh7D/h/706+UBY8iNVa3LD
         P4GA==
X-Gm-Message-State: AOAM533M6NzhTERixSLSBmuxxemutCHUpzSD6OVG5W7Nc+hU+B11weWL
        xG7oN9IbKrBNzBhTCd7Tx7/Uadyuyjarsyt1TZ6Yng==
X-Google-Smtp-Source: ABdhPJwXJusg/HXyZqxi0tKgJM4v587Kmbq/V1XrIotrWvGZwIXuUDXVbiTz7yi+Hg/kCI155bCmI3w6ve4PJyyeJ/o=
X-Received: by 2002:a17:906:73d5:: with SMTP id n21mr24685089ejl.8.1614762216616;
 Wed, 03 Mar 2021 01:03:36 -0800 (PST)
MIME-Version: 1.0
References: <20210226091612.508639-1-rickyniu@google.com> <YDi/+TN6AYXropf7@kroah.com>
In-Reply-To: <YDi/+TN6AYXropf7@kroah.com>
From:   Chien Kun Niu <rickyniu@google.com>
Date:   Wed, 3 Mar 2021 17:03:25 +0800
Message-ID: <CADRPvQubTEjKeJc=+LQ2jb0L=N4mxY8n21Bf8U-tS1stpB_eGw@mail.gmail.com>
Subject: Re: [PATCH] ANDROID: usb: core: Send uevent when USB TOPO layer over 6
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stern@rowland.harvard.edu, erosca@de.adit-jv.com,
        gustavoars@kernel.org, a.darwish@linutronix.de, oneukum@suse.com,
        Kyle Tso <kyletso@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, James Wei <jameswei@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi , Greg

What tool will "catch" this?  Where is that code located at?
=3D> I prepare merge the code to Android phone , so I used Android HLOS
to catch this uevent.

uevents are not for stuff like this, you are trying to send "error
conditions" to userspace, please use the "proper" interfaces like this
and not abuse existing ones.
=3D> Sorry , I am not sure what is the "proper" interfaces your mean.
     Could you please give me more description?

You just created a whole new sysfs class with no Documentation/ABI/
update?
=3D> Yes, I will add it.

Wait, how did you even test this code?  This will not work if you have
more than one hub in the system at a single time, right?
=3D> I build the test build which flash in Android phone and connect
several hubs to try it.
     When the new hub which met MAX_TOPO_LEVEL connected , it sent
notify to user space.

Phone ------=E2=86=93
                 hub ------=E2=86=93
                             hub ------=E2=86=93
                                           ...------=E2=86=93
                                                    hub

     if (hdev->level =3D=3D MAX_TOPO_LEVEL) {
                dev_err(&intf->dev,
                        "Unsupported bus topology: hub nested too deep\n");
                hub_over_tier();
                return -E2BIG;
     }


So, proof that this works?  How did you test this?
=3D> I use the Pixel phone to verify the code , the framework received
the uevent when the last connected hub over "MAX_TOPO_LEVEL".

Also, you have a memory leak in this submission :(
=3D> Do you mean I should add device_destroy here ?

hub_device =3D
device_create(hub_class, NULL, MKDEV(0, 0), NULL, "usb_hub");
+if (IS_ERR(hub_device))
+               return PTR_ERR(hub_device);

void usb_hub_cleanup(void)
{
+if (!IS_ERR(hub_device))
+device_destroy(hub_class, hub_device->devt);

if (!IS_ERR(hub_class))
class_destroy(hub_class);

Best Regards,

Chien Kun Niu
rickyniu@google.com


Chien Kun Niu
SSD USB
rickyniu@google.com
02 8729 0651


Greg KH <gregkh@linuxfoundation.org> =E6=96=BC 2021=E5=B9=B42=E6=9C=8826=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=885:31=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, Feb 26, 2021 at 05:16:12PM +0800, Ricky Niu wrote:
> > When the topology of the nested hubs are over 6 layers
> > Send uevent to user space when USB TOPO layer over 6.
> > Let end user more understand what happened.
> >
> > Signed-off-by: Ricky Niu <rickyniu@google.com>
> > ---
> >  drivers/usb/core/hub.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > index 7f71218cc1e5..e5e924526822 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -55,6 +55,10 @@ static DEFINE_SPINLOCK(device_state_lock);
> >  static struct workqueue_struct *hub_wq;
> >  static void hub_event(struct work_struct *work);
> >
> > +/* struct to notify userspace of hub events */
> > +static struct class *hub_class;
> > +static struct device *hub_device;
>
> Wait, how did you even test this code?  This will not work if you have
> more than one hub in the system at a single time, right?
>
> That's going to be really rough, given here's the output of just my
> desktop system, count the number of hubs in it:rdevmgmt.msc
>
> $ lsusb -t
> /:  Bus 10.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci_hcd/4p, 10000M
> /:  Bus 09.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci_hcd/6p, 480M
>     |__ Port 5: Dev 2, If 0, Class=3DWireless, Driver=3Dbtusb, 12M
>     |__ Port 5: Dev 2, If 1, Class=3DWireless, Driver=3Dbtusb, 12M
>     |__ Port 6: Dev 3, If 0, Class=3DHub, Driver=3Dhub/4p, 480M
> /:  Bus 08.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci_hcd/4p, 10000M
>     |__ Port 2: Dev 2, If 0, Class=3DHub, Driver=3Dhub/4p, 5000M
>     |__ Port 3: Dev 3, If 0, Class=3DMass Storage, Driver=3Duas, 10000M
> /:  Bus 07.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci_hcd/6p, 480M
>     |__ Port 2: Dev 2, If 0, Class=3DHub, Driver=3Dhub/4p, 480M
>         |__ Port 2: Dev 4, If 0, Class=3DHub, Driver=3Dhub/2p, 12M
>             |__ Port 2: Dev 5, If 0, Class=3DHuman Interface Device, Driv=
er=3Dusbhid, 12M
>             |__ Port 2: Dev 5, If 1, Class=3DHuman Interface Device, Driv=
er=3Dusbhid, 12M
>             |__ Port 2: Dev 5, If 2, Class=3DHuman Interface Device, Driv=
er=3Dusbhid, 12M
>     |__ Port 5: Dev 3, If 3, Class=3DAudio, Driver=3Dsnd-usb-audio, 480M
>     |__ Port 5: Dev 3, If 1, Class=3DAudio, Driver=3Dsnd-usb-audio, 480M
>     |__ Port 5: Dev 3, If 6, Class=3DAudio, Driver=3Dsnd-usb-audio, 480M
>     |__ Port 5: Dev 3, If 4, Class=3DAudio, Driver=3Dsnd-usb-audio, 480M
>     |__ Port 5: Dev 3, If 2, Class=3DAudio, Driver=3Dsnd-usb-audio, 480M
>     |__ Port 5: Dev 3, If 0, Class=3DAudio, Driver=3Dsnd-usb-audio, 480M
>     |__ Port 5: Dev 3, If 7, Class=3DHuman Interface Device, Driver=3Dusb=
hid, 480M
>     |__ Port 5: Dev 3, If 5, Class=3DAudio, Driver=3Dsnd-usb-audio, 480M
>     |__ Port 6: Dev 6, If 0, Class=3DHuman Interface Device, Driver=3Dusb=
hid, 12M
> /:  Bus 06.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci_hcd/1p, 10000M/=
x2
> /:  Bus 05.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci_hcd/1p, 480M
> /:  Bus 04.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci_hcd/2p, 10000M
>     |__ Port 1: Dev 11, If 0, Class=3DHub, Driver=3Dhub/3p, 5000M
>         |__ Port 3: Dev 12, If 0, Class=3DHub, Driver=3Dhub/3p, 5000M
>             |__ Port 1: Dev 13, If 0, Class=3DMass Storage, Driver=3Dusb-=
storage, 5000M
> /:  Bus 03.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci_hcd/2p, 480M
>     |__ Port 1: Dev 14, If 0, Class=3DHub, Driver=3Dhub/3p, 480M
>         |__ Port 3: Dev 15, If 0, Class=3DHub, Driver=3Dhub/3p, 480M
>             |__ Port 2: Dev 17, If 0, Class=3DHuman Interface Device, Dri=
ver=3Dusbhid, 12M
>             |__ Port 3: Dev 18, If 3, Class=3DHuman Interface Device, Dri=
ver=3Dusbhid, 12M
>             |__ Port 3: Dev 18, If 1, Class=3DAudio, Driver=3Dsnd-usb-aud=
io, 12M
>             |__ Port 3: Dev 18, If 2, Class=3DAudio, Driver=3Dsnd-usb-aud=
io, 12M
>             |__ Port 3: Dev 18, If 0, Class=3DAudio, Driver=3Dsnd-usb-aud=
io, 12M
> /:  Bus 02.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci_hcd/2p, 10000M
> /:  Bus 01.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci_hcd/2p, 480M
>
>
> So, proof that this works?  How did you test this?
>
> Also, you have a memory leak in this submission :(
>
> greg k-h
