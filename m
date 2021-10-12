Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D0E429B98
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 04:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbhJLCqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 22:46:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59425 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231649AbhJLCqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 22:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634006651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2fREGIk8jReLlGTNXAectxIpYSI3IYPQI22eSOPGC+M=;
        b=PE1NNHc4EAJ1DzhfjH8er93SK+VoSmyJPjWTMBxcbRjvKWIgziC7fBymJIjHcBvkokkzsd
        uWSfNlkz7/Mr5PaaUOL6m+tkJtUqmtou33ovJTNSd82RgqffT6L4GtiS+H2sQHOezdxydo
        Kpn6TNUJOrKEDcBItlnFNr4W8lctEQg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-KjZgnSEBPvOIrzyoyUufWg-1; Mon, 11 Oct 2021 22:44:10 -0400
X-MC-Unique: KjZgnSEBPvOIrzyoyUufWg-1
Received: by mail-lf1-f71.google.com with SMTP id u17-20020a05651206d100b003fd714d9a38so8571007lff.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 19:44:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2fREGIk8jReLlGTNXAectxIpYSI3IYPQI22eSOPGC+M=;
        b=D5NYjYK3o13isWvDifeGGJq8OMP+nvZaUgxOdCoB5lrFzkwn7yoKxmaO8BthL3YAnM
         hYcOWU/T13Meh9OLcWul+0PFiKM4zsAdugWNmKwtmKrtA33kyKlDCvGkdc8zwma/tpD9
         gEveqs5qiiBG+kyQszG7Ex815jybpuILdPJ9do2Sny7VhKeBSVrMzvFfr5BWPhrTaliC
         exEISxwnfOh6smqQcpJxRY0mTk3oifsvtX5RmxldaxVGFpVpP5aUoEyKA2wgp+X/MaLk
         0xh1uB+VxKf3gwSAMDZWNOr9L2oeSUMyatDovWOOrmhKEaodiv9Y4gtoGZ/0DpWhuQ8G
         hd2A==
X-Gm-Message-State: AOAM531VVdAAmleSxoRjOPl6Ft7O5JzqdbW0Ieep8vxpW5ge1A9EQZZn
        L4yTF4yLrXnrgJbeb89a70w6icc3/u9Km2Uti7OCzl7MiTK6yJv0RtnVwvhp6AaY6vFCP0tprJh
        jDveg7zwrlE3duAdCAOIr6OYJVucf0AythEJfAtOG
X-Received: by 2002:a05:6512:3b22:: with SMTP id f34mr29419433lfv.629.1634006648559;
        Mon, 11 Oct 2021 19:44:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyx/KLlNrfkt0VZFwEzX8ZyEI7j45+2mfl4fPCObn1at2NnMfMijAQfk9/2snYOZBE/4Ph6vOTEckI0S3tYRs=
X-Received: by 2002:a05:6512:3b22:: with SMTP id f34mr29419417lfv.629.1634006648300;
 Mon, 11 Oct 2021 19:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210913055353.35219-1-jasowang@redhat.com> <20211005032924-mutt-send-email-mst@kernel.org>
 <CACGkMEuQU6jXV_D5QvE29mX9spF6KcyrCDuvVwX99_jSf-x7fQ@mail.gmail.com> <20211011082640-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211011082640-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 12 Oct 2021 10:43:57 +0800
Message-ID: <CACGkMEtwAFy=bm62X+rjPMJEwChAhZkZ2bBwDJPULdzhWdzagA@mail.gmail.com>
Subject: Re: [PATCH 0/9] More virtio hardening
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Hetzelt, Felicitas" <f.hetzelt@tu-berlin.de>,
        "kaplan, david" <david.kaplan@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 8:36 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Oct 11, 2021 at 03:36:51PM +0800, Jason Wang wrote:
> > On Tue, Oct 5, 2021 at 3:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Mon, Sep 13, 2021 at 01:53:44PM +0800, Jason Wang wrote:
> > > > Hi All:
> > > >
> > > > This series treis to do more hardening for virito.
> > > >
> > > > patch 1 validates the num_queues for virio-blk device.
> > > > patch 2-4 validates max_nr_ports for virito-console device.
> > > > patch 5-7 harden virtio-pci interrupts to make sure no exepcted
> > > > interrupt handler is tiggered. If this makes sense we can do similar
> > > > things in other transport drivers.
> > > > patch 8-9 validate used ring length.
> > > >
> > > > Smoking test on blk/net with packed=on/off and iommu_platform=on/off.
> > > >
> > > > Please review.
> > > >
> > > > Thanks
> > >
> > > So I poked at console at least, and I think I see
> > > an issue: if interrupt handler queues a work/bh,
> > > then it can still run while reset is in progress.
> >
> > Looks like a bug which is unrelated to the hardening?
>
> Won't preventing use after free be relevant?

Oh right.

> I frankly don't know what does hardening means then.
> > E.g the driver
> > should sync with work/bh before reset.
>
> No, there's no way to fix it ATM without extra locks and state which I
> think we should strive to avoid or make it generic, not per-driver,
> since sync before reset is useless, new interrupts will just arrive and
> queue more work. And a sync after reset is too late since driver will
> try to add buffers.

Can we do something like

1) disable interrupt
2) sync bh

Or I guess this is somehow you meant in the following steps.

>
> Maybe we can break device. Two issues with that
> - drivers might not be ready to handle add_buf failures
> - restore needs to unbreak then and we don't have a way to do that yet
>
> So .. careful reading of all device drivers and hoping we don't mess
> things up even more ... here we come.

Yes.

>
> > >
> > > I sent a patch to fix it for console removal specifically,
> > > but I suspect it's not enough e.g. freeze is still broken.
> > > And note this has been reported without any TDX things -
> > > it's not a malicious device issue, can be triggered just
> > > by module unload.
> > >
> > > I am vaguely thinking about new APIs to disable/enable callbacks.
> > > An alternative:
> > >
> > > 1. adding new remove_nocb/freeze_nocb calls
> > > 2. disabling/enabling interrupts automatically around these
> > > 3. gradually moving devices to using these
> > > 4. once/if all device move, removing the old callbacks
> > >
> > > the advantage here is that we'll be sure calls are always
> > > paired correctly.
> >
> > I'm not sure I get the idea, but my feeling is that it doesn't
> > conflict with the interrupt hardening here (or at least the same
> > method is required e.g NO_AUTO_EN).
> >
> > Thanks
>
> Right.  It's not that it conflicts, it's that I was hoping that
> since you are working on hardening you can take up fixing that.
> Let me know whether you have the time. Thanks!

I can do that.

Thanks

>
> > >
> > >
> > >
> > >
> > >
> > > > Jason Wang (9):
> > > >   virtio-blk: validate num_queues during probe
> > > >   virtio: add doc for validate() method
> > > >   virtio-console: switch to use .validate()
> > > >   virtio_console: validate max_nr_ports before trying to use it
> > > >   virtio_config: introduce a new ready method
> > > >   virtio_pci: harden MSI-X interrupts
> > > >   virtio-pci: harden INTX interrupts
> > > >   virtio_ring: fix typos in vring_desc_extra
> > > >   virtio_ring: validate used buffer length
> > > >
> > > >  drivers/block/virtio_blk.c         |  3 +-
> > > >  drivers/char/virtio_console.c      | 51 +++++++++++++++++++++---------
> > > >  drivers/virtio/virtio_pci_common.c | 43 +++++++++++++++++++++----
> > > >  drivers/virtio/virtio_pci_common.h |  7 ++--
> > > >  drivers/virtio/virtio_pci_legacy.c |  5 +--
> > > >  drivers/virtio/virtio_pci_modern.c |  6 ++--
> > > >  drivers/virtio/virtio_ring.c       | 27 ++++++++++++++--
> > > >  include/linux/virtio.h             |  1 +
> > > >  include/linux/virtio_config.h      |  6 ++++
> > > >  9 files changed, 118 insertions(+), 31 deletions(-)
> > > >
> > > > --
> > > > 2.25.1
> > >
>

