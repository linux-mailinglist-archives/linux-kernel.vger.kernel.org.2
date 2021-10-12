Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE80342A039
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 10:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbhJLIsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 04:48:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55577 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234952AbhJLIsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 04:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634028374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8jbtmrvdydVcbKtmwH0mVqKY5lC9q0zSEeq9Jm8aa9s=;
        b=CQGeS03gG8WfLs2sYm1FN/PySQTz4FweB34zFGMDzmkdoOS2AVmOtWRatdmoHTCKtlgQDz
        3kHcGp6Q+F4XrAKDzQoyGU1fp9bN7bN6H12fpncsYzVI7d+dnkqzleEiYcaQHCO2n3VIMo
        tv+PKJdKos46+p2Hza3w9DtrtpmVWGA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-slt68gxEMdGz-KqGsffoIw-1; Tue, 12 Oct 2021 04:46:13 -0400
X-MC-Unique: slt68gxEMdGz-KqGsffoIw-1
Received: by mail-lf1-f72.google.com with SMTP id br42-20020a056512402a00b003fd94a74905so3103568lfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 01:46:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8jbtmrvdydVcbKtmwH0mVqKY5lC9q0zSEeq9Jm8aa9s=;
        b=n/eBp6zbRl31Nowd896vx9wH8pVuTJUrHPk9M9SCEch65pNXgzM/brjmvVs1LWQxmx
         7ptzb2f5P1bTzxeBldgbsHEznTDFDsQB1ZlMs7tNB53YCiQWc/EoZQ/ZY155n0obqRj2
         pogXQUm6uTsUeqi6Wlxm5+Gb2l77/lGl9+bUPYQy/OQaLzpaww12+1lCtEvOKpcQZ7XU
         iCkIYLZm16W9GrnHj6ew8UyiYo8DSg6o7/qseORx4zXkPwztOO/qBKz/CH+dpePbcI4p
         KN3nmB1grjUBQN1snUPGzgjElKFR7yFd+n23WIQ2rc22fuZ3oy4LDpGUQHWjLEYrU5j9
         ZUNA==
X-Gm-Message-State: AOAM531tydxMDWJEWTiO9snvGH5KTIu3ilEaptsmWaYo2R48BIzbBTwV
        ep5+jOyxYabGYD8aaywnmx1ZfBp0luhZZKF3mSzSCfzaWqbx0y6poarTqvRQ3nLE/FXQ7wOZtcS
        tj1DTkxQSX3W2bPj/mlueafmIMFlzIYSJK2COrXkU
X-Received: by 2002:ac2:43d1:: with SMTP id u17mr12793470lfl.348.1634028371625;
        Tue, 12 Oct 2021 01:46:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbfo+wRlZQ4toG3xfT67w0misrN1XCgXks2u7IG1JuYC3sMCHZSrIKtMdp5Aamvp7Pxwzc53Wod5ofiphwDE8=
X-Received: by 2002:ac2:43d1:: with SMTP id u17mr12793452lfl.348.1634028371392;
 Tue, 12 Oct 2021 01:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210913055353.35219-1-jasowang@redhat.com> <20211005032924-mutt-send-email-mst@kernel.org>
 <CACGkMEuQU6jXV_D5QvE29mX9spF6KcyrCDuvVwX99_jSf-x7fQ@mail.gmail.com>
 <20211011082640-mutt-send-email-mst@kernel.org> <CACGkMEtwAFy=bm62X+rjPMJEwChAhZkZ2bBwDJPULdzhWdzagA@mail.gmail.com>
 <20211012012617-mutt-send-email-mst@kernel.org> <CACGkMEu5oP=vix8gZgQi0Y==VBvxqoTg+yG-cu1FenZH6csepw@mail.gmail.com>
 <20211012022024-mutt-send-email-mst@kernel.org> <CACGkMEvtobDX-bvjhFtDGa8N6PFrvcwnM_5EXGOEgEAVY517=A@mail.gmail.com>
 <20211012030143-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211012030143-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 12 Oct 2021 16:46:00 +0800
Message-ID: <CACGkMEv9hFk6efhikY+CtpiCTAT3_at+ww7rPQ9tWP5qC+JWsw@mail.gmail.com>
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

On Tue, Oct 12, 2021 at 3:03 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Oct 12, 2021 at 02:43:13PM +0800, Jason Wang wrote:
> > On Tue, Oct 12, 2021 at 2:35 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Tue, Oct 12, 2021 at 02:11:10PM +0800, Jason Wang wrote:
> > > > On Tue, Oct 12, 2021 at 1:44 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Tue, Oct 12, 2021 at 10:43:57AM +0800, Jason Wang wrote:
> > > > > > On Mon, Oct 11, 2021 at 8:36 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Oct 11, 2021 at 03:36:51PM +0800, Jason Wang wrote:
> > > > > > > > On Tue, Oct 5, 2021 at 3:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, Sep 13, 2021 at 01:53:44PM +0800, Jason Wang wrote:
> > > > > > > > > > Hi All:
> > > > > > > > > >
> > > > > > > > > > This series treis to do more hardening for virito.
> > > > > > > > > >
> > > > > > > > > > patch 1 validates the num_queues for virio-blk device.
> > > > > > > > > > patch 2-4 validates max_nr_ports for virito-console device.
> > > > > > > > > > patch 5-7 harden virtio-pci interrupts to make sure no exepcted
> > > > > > > > > > interrupt handler is tiggered. If this makes sense we can do similar
> > > > > > > > > > things in other transport drivers.
> > > > > > > > > > patch 8-9 validate used ring length.
> > > > > > > > > >
> > > > > > > > > > Smoking test on blk/net with packed=on/off and iommu_platform=on/off.
> > > > > > > > > >
> > > > > > > > > > Please review.
> > > > > > > > > >
> > > > > > > > > > Thanks
> > > > > > > > >
> > > > > > > > > So I poked at console at least, and I think I see
> > > > > > > > > an issue: if interrupt handler queues a work/bh,
> > > > > > > > > then it can still run while reset is in progress.
> > > > > > > >
> > > > > > > > Looks like a bug which is unrelated to the hardening?
> > > > > > >
> > > > > > > Won't preventing use after free be relevant?
> > > > > >
> > > > > > Oh right.
> > > > > >
> > > > > > > I frankly don't know what does hardening means then.
> > > > > > > > E.g the driver
> > > > > > > > should sync with work/bh before reset.
> > > > > > >
> > > > > > > No, there's no way to fix it ATM without extra locks and state which I
> > > > > > > think we should strive to avoid or make it generic, not per-driver,
> > > > > > > since sync before reset is useless, new interrupts will just arrive and
> > > > > > > queue more work. And a sync after reset is too late since driver will
> > > > > > > try to add buffers.
> > > > > >
> > > > > > Can we do something like
> > > > > >
> > > > > > 1) disable interrupt
> > > > > > 2) sync bh
> > > > > >
> > > > > > Or I guess this is somehow you meant in the following steps.
> > > > >
> > > > > So that would mean a new API to disable vq interrupts.
> > > > > reset will re-enable.
> > > > > E.g. virtqueue_cancel_cb_before_reset()?
> > > > >
> > > > > Then drivers can sync, then reset.
> > > > > This means maintaining more state though, which I don't like.
> > > > >
> > > > > An alternative is something like this:
> > > > >
> > > > > static void (*virtio_flush_device)(struct virtio_device *dev);
> > > > >
> > > > > void virtio_reset_device(struct virtio_device *dev, virtio_flush_device flush)
> > > > > {
> > > > >         might_sleep();
> > > > >         if (flush) {
> > > > >                 dev->config->disable_interrupts(dev);
> > > > >                 flush(dev);
> > > > >                 dev->config->reset(dev);
> > > > >                 dev->config->enable_interrupts(dev);
> > > >
> > > > I wonder whether this is needed. As done in this series,
> > > > enable_interrupt should be done in virtio_device_ready().
> > > >
> > > > Others should work.
> > > >
> > > > >         } else {
> > > > >                 dev->config->reset(dev);
> > > > >         }
> > > > > }
> > > > >
> > > > > I have patches wrapping all reset calls in virtio_reset_device
> > > > > (without the flush parameter but that's easy to tweak).
> > > >
> > > > Does it work if I post V2 and you post those patches on top?
> > >
> > > The reset things? Sure.
> >
> > Ok.
> >
> > >
> > > > >
> > > > >
> > > > > > >
> > > > > > > Maybe we can break device. Two issues with that
> > > > > > > - drivers might not be ready to handle add_buf failures
> > > > > > > - restore needs to unbreak then and we don't have a way to do that yet
> > > > > > >
> > > > > > > So .. careful reading of all device drivers and hoping we don't mess
> > > > > > > things up even more ... here we come.
> > > > > >
> > > > > > Yes.
> > > > >
> > > > > The biggest issue with this trick is drivers not handling add_buf
> > > > > errors, adding a failure path here risks creating memory leaks.
> > > > > OTOH with e.g. bounce buffers maybe it's possible for add buf to
> > > > > fail anyway?
> > > >
> > > > I'm not sure I get this, a simple git grep told me at least the return
> > > > value of add_inbuf() were all checked.
> > > >
> > > > Thanks
> > >
> > > Checked locally, but not always error is handled all the way
> > > to the top. E.g. add_port in console returns an error code
> > > but that is never checked. Well, console is a mess generally.
> >
> > I see. I can try to audit all virtio drivers for the add_inbuf() case.
> >
> > Thanks
>
> Why inbuf specifically?

Typo :(

> I mean, re-reading code often finds bugs, sure ;)

Yes.

>
> But I don't think just to fix remove we need to audit them all
> as such, as long as we are not modifying core, whatever
> driver remove we are poking for, that driver needs to be
> audited.

Right.

Thanks

>
>
> > >
> > > > >
> > > > > > >
> > > > > > > > >
> > > > > > > > > I sent a patch to fix it for console removal specifically,
> > > > > > > > > but I suspect it's not enough e.g. freeze is still broken.
> > > > > > > > > And note this has been reported without any TDX things -
> > > > > > > > > it's not a malicious device issue, can be triggered just
> > > > > > > > > by module unload.
> > > > > > > > >
> > > > > > > > > I am vaguely thinking about new APIs to disable/enable callbacks.
> > > > > > > > > An alternative:
> > > > > > > > >
> > > > > > > > > 1. adding new remove_nocb/freeze_nocb calls
> > > > > > > > > 2. disabling/enabling interrupts automatically around these
> > > > > > > > > 3. gradually moving devices to using these
> > > > > > > > > 4. once/if all device move, removing the old callbacks
> > > > > > > > >
> > > > > > > > > the advantage here is that we'll be sure calls are always
> > > > > > > > > paired correctly.
> > > > > > > >
> > > > > > > > I'm not sure I get the idea, but my feeling is that it doesn't
> > > > > > > > conflict with the interrupt hardening here (or at least the same
> > > > > > > > method is required e.g NO_AUTO_EN).
> > > > > > > >
> > > > > > > > Thanks
> > > > > > >
> > > > > > > Right.  It's not that it conflicts, it's that I was hoping that
> > > > > > > since you are working on hardening you can take up fixing that.
> > > > > > > Let me know whether you have the time. Thanks!
> > > > > >
> > > > > > I can do that.
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > > Jason Wang (9):
> > > > > > > > > >   virtio-blk: validate num_queues during probe
> > > > > > > > > >   virtio: add doc for validate() method
> > > > > > > > > >   virtio-console: switch to use .validate()
> > > > > > > > > >   virtio_console: validate max_nr_ports before trying to use it
> > > > > > > > > >   virtio_config: introduce a new ready method
> > > > > > > > > >   virtio_pci: harden MSI-X interrupts
> > > > > > > > > >   virtio-pci: harden INTX interrupts
> > > > > > > > > >   virtio_ring: fix typos in vring_desc_extra
> > > > > > > > > >   virtio_ring: validate used buffer length
> > > > > > > > > >
> > > > > > > > > >  drivers/block/virtio_blk.c         |  3 +-
> > > > > > > > > >  drivers/char/virtio_console.c      | 51 +++++++++++++++++++++---------
> > > > > > > > > >  drivers/virtio/virtio_pci_common.c | 43 +++++++++++++++++++++----
> > > > > > > > > >  drivers/virtio/virtio_pci_common.h |  7 ++--
> > > > > > > > > >  drivers/virtio/virtio_pci_legacy.c |  5 +--
> > > > > > > > > >  drivers/virtio/virtio_pci_modern.c |  6 ++--
> > > > > > > > > >  drivers/virtio/virtio_ring.c       | 27 ++++++++++++++--
> > > > > > > > > >  include/linux/virtio.h             |  1 +
> > > > > > > > > >  include/linux/virtio_config.h      |  6 ++++
> > > > > > > > > >  9 files changed, 118 insertions(+), 31 deletions(-)
> > > > > > > > > >
> > > > > > > > > > --
> > > > > > > > > > 2.25.1
> > > > > > > > >
> > > > > > >
> > > > >
> > >
>

