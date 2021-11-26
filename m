Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A99C45ECFD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 12:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376926AbhKZLy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 06:54:58 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:49220
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346733AbhKZLw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 06:52:57 -0500
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BE4713F1BF
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 11:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637927380;
        bh=tBgoSFpQX99Leb6xXitOBQwcXI6bgAJ6FI0dUd+cmr8=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=BxndOUhM0Pc3uxtbkEtZxjKl2JIlcs/l4SRQXyqXnsCBG/pEWz6AEg/k9aqn3hjsZ
         luD40qRk7cWU/RBMjWMZBoBR6q77Ypb5mqUS7nqa5DYMa0LgZsBbHpvHgh22qz1dJk
         0J029dbzFKKLgzohwgRAXT9KQr3J2uUbbgJ69b8an2QTNKP61rg94uvhyMaqsi3bXd
         l4iVIXWOPAYBO/6cPS40ab1mcaNWFwyp5ErIGP8MW/KtvdyGGJOqhJIORQTenBtHgi
         Ui91czS+8mtas+BcVznCqHPh9OIZBL1F25D42bU0u9hyhFTlKlrgEoCAryNALfVBYk
         WBvcsJjpUgnLg==
Received: by mail-oo1-f71.google.com with SMTP id c24-20020a4a3818000000b002c9ba7f00e7so2618122ooa.18
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 03:49:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tBgoSFpQX99Leb6xXitOBQwcXI6bgAJ6FI0dUd+cmr8=;
        b=Xns/GTV2pOPaYl+SssLKPOsx/DjCYz40Qp45r774YsHKB4GkwtM6Tx1B7okRXkxfEj
         F/BPl3xmnPRaN+DgBtgZU4MvZdG6iEW6wxZu3U+Egm8sLKbi39IQzXOeTU+s3+OTtCTr
         /CHo+GuPueKXiHcXEKUhshmCGw3cInHoJqVEGChLuPsso1h8qm/HaNNTM93OiswoxPXv
         /cCPMC8uyn6EawTCSTl0Ch1lPQ7dMta3AOwx3MdvAQU2mamwxCiPUWiTdNWX0Yd/abPF
         EpC9LFayMxzN9GJhJXXj7WdpCfGxc6XGuUuL/jFTitX+G86eOfrBrH53neTqbPKGK4EG
         Soeg==
X-Gm-Message-State: AOAM531IN7YLya7TMyonT6wyi9zdmbVsWzPzorCMs+qiE+DXEOnyEPsA
        9zRzyvbD4VU1QUHg0jZNsiuN2fXRp1/qY/Gn5ix21KinMUbh+lJVmuiTm99MSAdQMa+bva+yWnO
        aTIFlJ6LwfT82w/Sqwwkrkok8RJ3KzIH2VbM26n5zAViCIgh9pqWEP03PCQ==
X-Received: by 2002:a05:6808:199c:: with SMTP id bj28mr23168896oib.98.1637927379628;
        Fri, 26 Nov 2021 03:49:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwea8JDby1x5TQNnw270DFr+kvyjl8O1BHn6wP6utlk8y4YFpkUISyDUmWiVxf97p13uwjBXLDOUA7B90HuGYY=
X-Received: by 2002:a05:6808:199c:: with SMTP id bj28mr23168869oib.98.1637927379309;
 Fri, 26 Nov 2021 03:49:39 -0800 (PST)
MIME-Version: 1.0
References: <20211126032622.1101448-1-kai.heng.feng@canonical.com> <YaCEUoB7C7hUiREv@kroah.com>
In-Reply-To: <YaCEUoB7C7hUiREv@kroah.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 26 Nov 2021 19:49:27 +0800
Message-ID: <CAAd53p4SzR8f36uAAvRc2qe50RMDFytSOUEJ+WKY8wQJi=a1yQ@mail.gmail.com>
Subject: Re: [PATCH] usb: core: Avoid doing warm reset on disconnect event
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stern@rowland.harvard.edu, mathias.nyman@linux.intel.com,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Bixuan Cui <cuibixuan@huawei.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Chris Chiu <chris.chiu@canonical.com>,
        Rajat Jain <rajatja@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 2:53 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Nov 26, 2021 at 11:26:21AM +0800, Kai-Heng Feng wrote:
> > Unplugging USB device may cause an incorrect warm reset loop:
> > [  143.039019] xhci_hcd 0000:00:14.0: Port change event, 2-3, id 19, po=
rtsc: 0x4202c0
> > [  143.039025] xhci_hcd 0000:00:14.0: handle_port_status: starting usb2=
 port polling.
> > [  143.039051] hub 2-0:1.0: state 7 ports 10 chg 0000 evt 0008
> > [  143.039058] xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x4202c=
0, return 0x4102c0
> > [  143.039092] xhci_hcd 0000:00:14.0: clear port3 connect change, ports=
c: 0x4002c0
> > [  143.039096] usb usb2-port3: link state change
> > [  143.039099] xhci_hcd 0000:00:14.0: clear port3 link state change, po=
rtsc: 0x2c0
> > [  143.039101] usb usb2-port3: do warm reset
> > [  143.096736] xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x2b0, =
return 0x2b0
> > [  143.096751] usb usb2-port3: not warm reset yet, waiting 50ms
> > [  143.131500] xhci_hcd 0000:00:14.0: Can't queue urb, port error, link=
 inactive
> > [  143.138260] xhci_hcd 0000:00:14.0: Port change event, 2-3, id 19, po=
rtsc: 0x2802a0
> > [  143.138263] xhci_hcd 0000:00:14.0: handle_port_status: starting usb2=
 port polling.
> > [  143.160756] xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x2802a=
0, return 0x3002a0
> > [  143.160798] usb usb2-port3: not warm reset yet, waiting 200ms
> >
> > The warm reset is due to its PLS is in eSS.Inactive state. However, USB
> > 3.2 spec table 10-13 mentions "Ports can be disabled by either a fault
> > condition (disconnect event or other fault condition)", xHCI 1.2 spec
> > table 5-27 also states that "This flag shall automatically be cleared t=
o
> > =E2=80=980=E2=80=99 by a disconnect event or other fault condition." on=
 PED.
> >
> > So use CSC =3D 0 and PED =3D 0 as indication that device is disconnecti=
ng to
> > avoid doing warm reset.
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/usb/core/hub.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > index 86658a81d2844..abd5a83d194b0 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -5530,6 +5530,7 @@ static void port_event(struct usb_hub *hub, int p=
ort1)
> >               __must_hold(&port_dev->status_lock)
> >  {
> >       int connect_change;
> > +     int disconnect =3D 0;
>
> bool?

Will change.

>
> >       struct usb_port *port_dev =3D hub->ports[port1 - 1];
> >       struct usb_device *udev =3D port_dev->child;
> >       struct usb_device *hdev =3D hub->hdev;
> > @@ -5545,6 +5546,9 @@ static void port_event(struct usb_hub *hub, int p=
ort1)
> >       if (portchange & USB_PORT_STAT_C_CONNECTION) {
> >               usb_clear_port_feature(hdev, port1, USB_PORT_FEAT_C_CONNE=
CTION);
> >               connect_change =3D 1;
> > +             if (!(portstatus & USB_PORT_STAT_CONNECTION) &&
> > +                 !(portstatus & USB_PORT_STAT_ENABLE))
> > +                     disconnect =3D 1;
> >       }
> >
> >       if (portchange & USB_PORT_STAT_C_ENABLE) {
> > @@ -5613,7 +5617,7 @@ static void port_event(struct usb_hub *hub, int p=
ort1)
> >        * Warm reset a USB3 protocol port if it's in
> >        * SS.Inactive state.
> >        */
> > -     if (hub_port_warm_reset_required(hub, port1, portstatus)) {
> > +     if (hub_port_warm_reset_required(hub, port1, portstatus) && !disc=
onnect) {
>
> Why is this problem just showing up now?  What commit caused this
> regression?

It's not a regression, the issue happens on all kernels I tried.
port_event() stays unchanged for a while.

Kai-Heng

>
> thanks,
>
> greg k-h
