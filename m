Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD0537A370
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 11:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhEKJWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 05:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbhEKJWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 05:22:23 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0553CC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 02:21:17 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id c3so18386457oic.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 02:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SpuzP5dD89015IuaoQUypVRri84Ral9X2cBH7/+h6B0=;
        b=EJZPKRTPNk0sadX+CdnzrZDhkw4Zupn/oAC4s8Xy/pdkvPNEJUfpTYqnMa/X4Z+fAN
         BAEsRNsd0/uWgG1OhOWCGb7+V+f4tw9l6CsbbJ4VwId+/4PrV2HHZ9NDSRFHr+rrtYpz
         MLaWeEhBurHu8pnY+SoVgpIM5SaHZ4m2+3eOhp9olv+0Gh9zqH2pWsNW/S/Caj5a93T3
         D4gMSdUhjoOSwmxDO3MgOiAIe84SOqaO8clT1T21M90BgAdmyJJmmBnTJpf6ApIvM2Fx
         1amz9mJyQe3eOZ0NJGDnvXTr/E67EQCoRdJLPdKOFZT61ssBQZuKRbvQtJ3f40obRIbv
         /EXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SpuzP5dD89015IuaoQUypVRri84Ral9X2cBH7/+h6B0=;
        b=ZTu39Qos9TwWHiZFh1YBsaRmKr6jVfUS0hL3sB1p3Z+fgv6VOJpGdwKILRn2n/RHJe
         MttzOWXJDzqgG4zQ/Udy8BeEONpr6PlfkgPqc01TAAA35Nx+YyTDuaIxrcKO5Q31qvYY
         MZyRjwxhkQL8yKqM3voxYbkmwfjt5B5MQj1ZD79Rzk4xbxJvVz8n4XqQ44blh/uavltt
         m6c+YKmmrIAQGNDa0FXZlXUBIkiIFqBY8bk6s5QPeTmfIW8wdZpUczEhn/TRZ9A6lGnO
         M6I49R8Pvi3iyPqq596OQghENCWCcdSgGG5PsNDBytCc8OvoFb85sAZ5CCo9UHEF6Nqd
         PI8g==
X-Gm-Message-State: AOAM531nBzt/5aI+gP5IDQZcow+XHVkch0zDQMSgtFrjfVqXEp1xu6Kz
        SBYP/q5emfv6MqJTU7wE+RrfNX8lEBAPdL8B4gCfCg==
X-Google-Smtp-Source: ABdhPJyafaXyIkykLjYRRydc5zqSCnCbYc4lexHHectPWvV2uB9PGFbQwIt/YYm59WbO+bJqIioASXZVBuj+bdHr32g=
X-Received: by 2002:aca:ad06:: with SMTP id w6mr2807257oie.54.1620724876444;
 Tue, 11 May 2021 02:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210511044253.469034-1-yuri.benditovich@daynix.com>
 <20210511044253.469034-2-yuri.benditovich@daynix.com> <40938c20-5851-089b-c3c0-074bbd636970@redhat.com>
 <CAOEp5OdgYtP+W1thGsTGnvEPWrJ02s1HemskQpnMTUyYbsX4jQ@mail.gmail.com> <CACGkMEuk3-iP+AxsvhT16t+5dXXtVMGoWPovM=Msm0kvo3LR2Q@mail.gmail.com>
In-Reply-To: <CACGkMEuk3-iP+AxsvhT16t+5dXXtVMGoWPovM=Msm0kvo3LR2Q@mail.gmail.com>
From:   Yuri Benditovich <yuri.benditovich@daynix.com>
Date:   Tue, 11 May 2021 12:21:04 +0300
Message-ID: <CAOEp5OfAEb4=C7GK_EJvJnoTTk-ebdg0RygShPwbn3O67ucQ2Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] virtio-net: add definitions for host USO feature
To:     Jason Wang <jasowang@redhat.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Yan Vugenfirer <yan@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 11:24 AM Jason Wang <jasowang@redhat.com> wrote:
>
> On Tue, May 11, 2021 at 4:12 PM Yuri Benditovich
> <yuri.benditovich@daynix.com> wrote:
> >
> > On Tue, May 11, 2021 at 9:47 AM Jason Wang <jasowang@redhat.com> wrote:
> > >
> > >
> > > =E5=9C=A8 2021/5/11 =E4=B8=8B=E5=8D=8812:42, Yuri Benditovich =E5=86=
=99=E9=81=93:
> > > > Define feature bit and GSO type according to the VIRTIO
> > > > specification.
> > > >
> > > > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > > > ---
> > > >   include/uapi/linux/virtio_net.h | 2 ++
> > > >   1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/v=
irtio_net.h
> > > > index 3f55a4215f11..a556ac735d7f 100644
> > > > --- a/include/uapi/linux/virtio_net.h
> > > > +++ b/include/uapi/linux/virtio_net.h
> > > > @@ -57,6 +57,7 @@
> > > >                                        * Steering */
> > > >   #define VIRTIO_NET_F_CTRL_MAC_ADDR 23       /* Set MAC address */
> > > >
> > > > +#define VIRTIO_NET_F_HOST_USO     56 /* Host can handle USO packet=
s */
> >
> > This is the virtio-net feature
>
> Right, I miss this part.
>
> >
> > > >   #define VIRTIO_NET_F_HASH_REPORT  57        /* Supports hash repo=
rt */
> > > >   #define VIRTIO_NET_F_RSS      60    /* Supports RSS RX steering *=
/
> > > >   #define VIRTIO_NET_F_RSC_EXT          61    /* extended coalescin=
g info */
> > > > @@ -130,6 +131,7 @@ struct virtio_net_hdr_v1 {
> > > >   #define VIRTIO_NET_HDR_GSO_TCPV4    1       /* GSO frame, IPv4 TC=
P (TSO) */
> > > >   #define VIRTIO_NET_HDR_GSO_UDP              3       /* GSO frame,=
 IPv4 UDP (UFO) */
> > > >   #define VIRTIO_NET_HDR_GSO_TCPV6    4       /* GSO frame, IPv6 TC=
P */
> > > > +#define VIRTIO_NET_HDR_GSO_UDP_L4    5       /* GSO frame, IPv4 UD=
P (USO) */
> >
> > This is respective GSO type
> >
> > >
> > >
> > > This is the gso_type not the feature actually.
> > >
> > > I wonder what's the reason for not
> > >
> > > 1) introducing a dedicated virtio-net feature bit for this
> > > (VIRTIO_NET_F_GUEST_GSO_UDP_L4.
> >
> > This series is not for GUEST's feature, it is only for host feature.
> >
> > > 2) toggle the NETIF_F_GSO_UDP_L4  feature for tuntap based on the
> > > negotiated feature.
> >
> > The NETIF_F_GSO_UDP_L4 would be required for the guest RX path.
> > The guest TX path does not require any flags to be propagated, it only
> > allows the guest to transmit large UDP packets and have them
> > automatically splitted.
> > (This is similar to HOST_UFO but does packet segmentation instead of
> > fragmentation. GUEST_UFO indeed requires a respective NETIF flag, as
> > it is unclear whether the guest is capable of receiving such packets).
>
> So I think it's better to implement TX/RX in the same series unless
> there's something missed:
>
> For Guest TX, NETIF_F_GSO_UDP_L4 needs to be enabled in the guest
> virtio-net only when VIRTIO_NET_F_HOST_USO is negotiated.

I understand that this is what should be done when this feature will
be added to Linux virtio-net driver.
But at the moment we do not have enough resources to work on it.
Currently we have a clear use case and ability to test in on Windows guest.
Respective QEMU changes are pending for kernel patches, current
reference is https://github.com/daynix/qemu/tree/uso

> For guest RX, NETIF_F_GSO_UDP_L4 needs to be enabled on the host
> tuntap only when VIRTIO_NET_F_GUEST_USO is neogiated.

Currently we are not able to use guest RX UDP GSO.
In order to do that we at least should be able to build our Windows
drivers with the most updated driver development kit (2004+).
At the moment we can't, this task is in a plan but can take several
months. So we do not have a test/use case with Windows VM.


>
> Thanks
>
> >
> > >
> > > Thanks
> > >
> > >
> > > >   #define VIRTIO_NET_HDR_GSO_ECN              0x80    /* TCP has EC=
N set */
> > > >       __u8 gso_type;
> > > >       __virtio16 hdr_len;     /* Ethernet + IP + tcp/udp hdrs */
> > >
> >
>
