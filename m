Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9B935E089
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 15:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhDMNrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 09:47:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22267 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245641AbhDMNrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 09:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618321608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ruitcOttvU8pMtnqETNMINtrcJvOv4W/NYv8bRKWdyw=;
        b=L25n+g7dAvWl1vZhYP9kA+HVCDUPkLQeoZOyvAQUFsjyoh9FfTmScnVWA00FMgUOPtnOkf
        vgdXucHEJKxJRVDmCc8AwbdDCUr8n6XjmMyQJyvRPkPcvzRoOaXxPvA8+tbbcEIenugetA
        xLIvrrUtFlUKJpiOEDJ1jeZXRdqtk5c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-XtlVwu_PPzqigNsuHswLcA-1; Tue, 13 Apr 2021 09:46:47 -0400
X-MC-Unique: XtlVwu_PPzqigNsuHswLcA-1
Received: by mail-wm1-f72.google.com with SMTP id b20-20020a7bc2540000b029010f7732a35fso839356wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 06:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ruitcOttvU8pMtnqETNMINtrcJvOv4W/NYv8bRKWdyw=;
        b=pHaEbVKuPS1FaZ+5r4W+SYMUppi3FhbDcMSn7Yh5u5kDgIrN9XulZc9ZGCj+Glk/av
         RiAybl/k2eHaPEkUe80hrz4jKw1heZp6VDF7YyYckFC7Yar3Ht/tl7DshIUuvZWLAXIv
         kSQhmuPRkKWOmyq5dJUGT6Ap5z2yjYrd/BE/sIpJuohXWfJ4fuwxUpFsZ/N9LWsA9S3d
         NMeJtrT7vzfjJHPzeQIM2wl8YpxnA8edrAXmEbcaqFtNb9FiIxvMIyEIdI7O/slxUmlQ
         561ZpXj3C4kc8xcZpdv5ZUZLCifZnCfUq9ough8AiHRRBZtU1i/dHUcITCMKoYDfYyLT
         Urhg==
X-Gm-Message-State: AOAM532xSqUw35bEsBUnqZGFvO1SdmtiO/EqGVMjuerJLttDZ+jjJYGK
        UqJhZ6cA68Ai+wNH//0X8UJUhQP7RgZgEHnnwWKRbwrEnodviG0TczyPh7fjbeDpLODtHMOvuEr
        8e+iF1lH2bdjuOGNNgvNwgMqp
X-Received: by 2002:adf:c587:: with SMTP id m7mr36496051wrg.369.1618321605398;
        Tue, 13 Apr 2021 06:46:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxweykvbt/QwASFWtvZxLoKiOTh8XNV0MDGo+vClfJbzD4DLNEo7214/mwtOKq8JtZgcctFLw==
X-Received: by 2002:adf:c587:: with SMTP id m7mr36496043wrg.369.1618321605232;
        Tue, 13 Apr 2021 06:46:45 -0700 (PDT)
Received: from redhat.com ([2a10:8006:2281:0:1994:c627:9eac:1825])
        by smtp.gmail.com with ESMTPSA id q20sm2842983wmq.2.2021.04.13.06.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 06:46:44 -0700 (PDT)
Date:   Tue, 13 Apr 2021 09:46:41 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Subject: Re: Linux 5.12-rc7
Message-ID: <20210413094525-mutt-send-email-mst@kernel.org>
References: <CAHk-=wiHGchP=V=a4DbDN+imjGEc=2nvuLQVoeNXNxjpU1T8pg@mail.gmail.com>
 <20210412051445.GA47322@roeck-us.net>
 <CAHk-=whYcwWgSPxuu8FxZ2i_cG7kw82m-Hbj0-67C6dk1Wb0tQ@mail.gmail.com>
 <CANn89iK2aUESa6DSG=Y4Y9tPmPW2weE05AVpxnDbqYwQjFM2Vw@mail.gmail.com>
 <CANn89i+sYS_x8D5hASKNgmc-k3P7B9JGY9mU1aBwhqHuAkwnBQ@mail.gmail.com>
 <20210413085538-mutt-send-email-mst@kernel.org>
 <CANn89iJODpHFAAZt0X-EewnbwKgeLPYpb=0GPRqqZmU9=12R6g@mail.gmail.com>
 <CANn89iKrSDL9usw18uvVfarWRUBv=V4xTHOMEgS48jhNmzR5_A@mail.gmail.com>
 <20210413093606-mutt-send-email-mst@kernel.org>
 <CANn89iKB3x2T=8j5qBVVtStdQBASD-P6B1+yLKwLh+Y+PggB0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iKB3x2T=8j5qBVVtStdQBASD-P6B1+yLKwLh+Y+PggB0A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 03:42:24PM +0200, Eric Dumazet wrote:
> On Tue, Apr 13, 2021 at 3:38 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Apr 13, 2021 at 03:33:40PM +0200, Eric Dumazet wrote:
> > > On Tue, Apr 13, 2021 at 3:27 PM Eric Dumazet <edumazet@google.com> wrote:
> > > >
> > > > On Tue, Apr 13, 2021 at 2:57 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Mon, Apr 12, 2021 at 06:47:07PM +0200, Eric Dumazet wrote:
> > > > > > On Mon, Apr 12, 2021 at 6:31 PM Eric Dumazet <edumazet@google.com> wrote:
> > > > > > >
> > > > > > > On Mon, Apr 12, 2021 at 6:28 PM Linus Torvalds
> > > > > > > <torvalds@linux-foundation.org> wrote:
> > > > > > > >
> > > > > > > > On Sun, Apr 11, 2021 at 10:14 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > > > > > > >
> > > > > > > > > Qemu test results:
> > > > > > > > >         total: 460 pass: 459 fail: 1
> > > > > > > > > Failed tests:
> > > > > > > > >         sh:rts7751r2dplus_defconfig:ata:net,virtio-net:rootfs
> > > > > > > > >
> > > > > > > > > The failure bisects to commit 0f6925b3e8da ("virtio_net: Do not pull payload in
> > > > > > > > > skb->head"). It is a spurious problem - the test passes roughly every other
> > > > > > > > > time. When the failure is seen, udhcpc fails to get an IP address and aborts
> > > > > > > > > with SIGTERM. So far I have only seen this with the "sh" architecture.
> > > > > > > >
> > > > > > > > Hmm. Let's add in some more of the people involved in that commit, and
> > > > > > > > also netdev.
> > > > > > > >
> > > > > > > > Nothing in there looks like it should have any interaction with
> > > > > > > > architecture, so that "it happens on sh" sounds odd, but maybe it's
> > > > > > > > some particular interaction with the qemu environment.
> > > > > > >
> > > > > > > Yes, maybe.
> > > > > > >
> > > > > > > I spent few hours on this, and suspect a buggy memcpy() implementation
> > > > > > > on SH, but this was not conclusive.
> > > > > > >
> > > > > > > By pulling one extra byte, the problem goes away.
> > > > > > >
> > > > > > > Strange thing is that the udhcpc process does not go past sendto().
> > > > > >
> > > > > > This is the patch working around the issue. Unfortunately I was not
> > > > > > able to root-cause it (I really suspect something on SH)
> > > > > >
> > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > index 0824e6999e49957f7aaf7c990f6259792d42f32b..fd890a951beea03bdf24406809042666eb972655
> > > > > > 100644
> > > > > > --- a/drivers/net/virtio_net.c
> > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > @@ -408,11 +408,17 @@ static struct sk_buff *page_to_skb(struct
> > > > > > virtnet_info *vi,
> > > > > >
> > > > > >         /* Copy all frame if it fits skb->head, otherwise
> > > > > >          * we let virtio_net_hdr_to_skb() and GRO pull headers as needed.
> > > > > > +        *
> > > > > > +        * Apparently, pulling only the Ethernet Header triggers a bug
> > > > > > on qemu-system-sh4.
> > > > > > +        * Since GRO aggregation really cares of IPv4/IPv6, pull 20 bytes
> > > > > > +        * more to work around this bug : These 20 bytes can not belong
> > > > > > +        * to UDP/TCP payload.
> > > > > > +        * As a bonus, this makes GRO slightly faster for IPv4 (one less copy).
> > > > > >          */
> > > > >
> > > > > Question: do we still want to do this for performance reasons?
> > > > > We also have the hdr_len coming from the device which is
> > > > > just skb_headlen on the host.
> > > >
> > > > Well, putting 20 bytes in skb->head will disable frag0 optimization.
> > > >
> > > > The change would only benefit to sh architecture :)
> > > >
> > > > About hdr_len, I suppose we could try it, with appropriate safety checks.
> > >
> > > I have added traces, hdr_len seems to be 0 with the qemu-system-sh4 I am using.
> > >
> > > Have I understood you correctly ?
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 0824e6999e49957f7aaf7c990f6259792d42f32b..f024860f7dc260d4efbc35a3b8ffd358bd0da894
> > > 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -399,9 +399,10 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
> > >                 hdr_padded_len = sizeof(struct padded_vnet_hdr);
> > >
> > >         /* hdr_valid means no XDP, so we can copy the vnet header */
> > > -       if (hdr_valid)
> > > +       if (hdr_valid) {
> > >                 memcpy(hdr, p, hdr_len);
> > > -
> > > +               pr_err("hdr->hdr_len=%u\n", hdr->hdr.hdr_len);
> > > +       }
> > >         len -= hdr_len;
> > >         offset += hdr_padded_len;
> > >         p += hdr_padded_len;
> >
> >
> > Depends on how you connect qemu on the host. It's filled by host tap,
> > see virtio_net_hdr_from_skb. If you are using slirp that just zero-fills
> > it.
> 
> Guenter provided :
> 
> qemu-system-sh4 -M r2d -kernel ./arch/sh/boot/zImage -no-reboot \
>         -snapshot \
>         -drive file=rootfs.ext2,format=raw,if=ide \
>         -device virtio-net,netdev=net0 -netdev user,id=net0 \
>         -append "root=/dev/sda console=ttySC1,115200
> earlycon=scif,mmio16,0xffe80000 noiotrap" \
>         -serial null -serial stdio -nographic -monitor null

That's slirp, sure enough. It generates packets in userspace thus no
skbs thus no skb_headlen.

-- 
MST

