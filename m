Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6F3429DE7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 08:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbhJLGpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 02:45:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54978 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232931AbhJLGp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 02:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634021008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W390FrjXxeXjnKet3sM0Jh3/nx2JTaDKLct7RHoJ/nE=;
        b=cmTp5SVgbjLDCEEQmXoL2wEqyNsJLVAxZHdAAqnb3+7SIo9Zz73le/xlR1H0jqctLp2auq
        foCzwCr6SRCEzXK7vi2iD1smVHiyFmttO+sokD53E5PIiB2RE36aJM6QzItPEzf1lQx9yE
        rrB4Br7Bvlurulul1uDbipHBaHWtYdQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-YR56k6deMKWFvWhIdvYoEw-1; Tue, 12 Oct 2021 02:43:26 -0400
X-MC-Unique: YR56k6deMKWFvWhIdvYoEw-1
Received: by mail-lf1-f69.google.com with SMTP id f17-20020a0565123b1100b003fda40b659aso92103lfv.23
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 23:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W390FrjXxeXjnKet3sM0Jh3/nx2JTaDKLct7RHoJ/nE=;
        b=5FXC3VXCqdEuBwMspuTqdxIv2afPZThGy/416R4cqqTaKVmrH1SPBFpVMZ4lGh4Hi4
         5hi6jo1SOdRueKSKCxYZUJy4fWBMK8F6jSUMp4vEwOTvh/llSvJeWf2FSZJsP6+lWwA4
         wMCyEonYrxgS4UPK1fBwZ+2lb8LMZ1LuM3qMQPkQku5NKnfNTqhyKHUYlWieb8m1wj2E
         dJNW1NxAlwEkzoR2gBZovxY63caLcMXWaVxGcngpjfjCb9nlNXbNRYC8koWTnS/37foy
         NH+FbR6qYxZutgEz/1XkNFWnUrFnoJ0jFfLHm3w4IPPuDtdWltUFSI24es4OFkrt8vbz
         2Xzw==
X-Gm-Message-State: AOAM533JSqWspctg+mbx/gl1MykgGSjS2H6kcBYs10CXwDbOLorn+pV1
        Ecyj9WyQxWGaUPuJTM5ZNiF5zdLS4YBlo7HsZiYEUU8FjvjmUAwLKLxaNKk8TgdwiWqOgb/46DS
        79mIDJGhDZNLQwWcgyWB9gzM+cEvteef1lN0fi1W1
X-Received: by 2002:a2e:a553:: with SMTP id e19mr28492039ljn.420.1634021005070;
        Mon, 11 Oct 2021 23:43:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoy+gcs2eNCuGhKxv4BOP2gevTlYF6Z+9SYHdphBSamNOOPOqU1bhAbAjzt6njDFZ5bADKXIU4B0VtS7YbKuw=
X-Received: by 2002:a2e:a553:: with SMTP id e19mr28492018ljn.420.1634021004831;
 Mon, 11 Oct 2021 23:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210913055353.35219-1-jasowang@redhat.com> <20211005032924-mutt-send-email-mst@kernel.org>
 <CACGkMEuQU6jXV_D5QvE29mX9spF6KcyrCDuvVwX99_jSf-x7fQ@mail.gmail.com>
 <20211011082640-mutt-send-email-mst@kernel.org> <CACGkMEtwAFy=bm62X+rjPMJEwChAhZkZ2bBwDJPULdzhWdzagA@mail.gmail.com>
 <20211012012617-mutt-send-email-mst@kernel.org> <CACGkMEu5oP=vix8gZgQi0Y==VBvxqoTg+yG-cu1FenZH6csepw@mail.gmail.com>
 <20211012022024-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211012022024-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 12 Oct 2021 14:43:13 +0800
Message-ID: <CACGkMEvtobDX-bvjhFtDGa8N6PFrvcwnM_5EXGOEgEAVY517=A@mail.gmail.com>
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

On Tue, Oct 12, 2021 at 2:35 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Oct 12, 2021 at 02:11:10PM +0800, Jason Wang wrote:
> > On Tue, Oct 12, 2021 at 1:44 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Tue, Oct 12, 2021 at 10:43:57AM +0800, Jason Wang wrote:
> > > > On Mon, Oct 11, 2021 at 8:36 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Mon, Oct 11, 2021 at 03:36:51PM +0800, Jason Wang wrote:
> > > > > > On Tue, Oct 5, 2021 at 3:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Sep 13, 2021 at 01:53:44PM +0800, Jason Wang wrote:
> > > > > > > > Hi All:
> > > > > > > >
> > > > > > > > This series treis to do more hardening for virito.
> > > > > > > >
> > > > > > > > patch 1 validates the num_queues for virio-blk device.
> > > > > > > > patch 2-4 validates max_nr_ports for virito-console device.
> > > > > > > > patch 5-7 harden virtio-pci interrupts to make sure no exepcted
> > > > > > > > interrupt handler is tiggered. If this makes sense we can do similar
> > > > > > > > things in other transport drivers.
> > > > > > > > patch 8-9 validate used ring length.
> > > > > > > >
> > > > > > > > Smoking test on blk/net with packed=on/off and iommu_platform=on/off.
> > > > > > > >
> > > > > > > > Please review.
> > > > > > > >
> > > > > > > > Thanks
> > > > > > >
> > > > > > > So I poked at console at least, and I think I see
> > > > > > > an issue: if interrupt handler queues a work/bh,
> > > > > > > then it can still run while reset is in progress.
> > > > > >
> > > > > > Looks like a bug which is unrelated to the hardening?
> > > > >
> > > > > Won't preventing use after free be relevant?
> > > >
> > > > Oh right.
> > > >
> > > > > I frankly don't know what does hardening means then.
> > > > > > E.g the driver
> > > > > > should sync with work/bh before reset.
> > > > >
> > > > > No, there's no way to fix it ATM without extra locks and state which I
> > > > > think we should strive to avoid or make it generic, not per-driver,
> > > > > since sync before reset is useless, new interrupts will just arrive and
> > > > > queue more work. And a sync after reset is too late since driver will
> > > > > try to add buffers.
> > > >
> > > > Can we do something like
> > > >
> > > > 1) disable interrupt
> > > > 2) sync bh
> > > >
> > > > Or I guess this is somehow you meant in the following steps.
> > >
> > > So that would mean a new API to disable vq interrupts.
> > > reset will re-enable.
> > > E.g. virtqueue_cancel_cb_before_reset()?
> > >
> > > Then drivers can sync, then reset.
> > > This means maintaining more state though, which I don't like.
> > >
> > > An alternative is something like this:
> > >
> > > static void (*virtio_flush_device)(struct virtio_device *dev);
> > >
> > > void virtio_reset_device(struct virtio_device *dev, virtio_flush_device flush)
> > > {
> > >         might_sleep();
> > >         if (flush) {
> > >                 dev->config->disable_interrupts(dev);
> > >                 flush(dev);
> > >                 dev->config->reset(dev);
> > >                 dev->config->enable_interrupts(dev);
> >
> > I wonder whether this is needed. As done in this series,
> > enable_interrupt should be done in virtio_device_ready().
> >
> > Others should work.
> >
> > >         } else {
> > >                 dev->config->reset(dev);
> > >         }
> > > }
> > >
> > > I have patches wrapping all reset calls in virtio_reset_device
> > > (without the flush parameter but that's easy to tweak).
> >
> > Does it work if I post V2 and you post those patches on top?
>
> The reset things? Sure.

Ok.

>
> > >
> > >
> > > > >
> > > > > Maybe we can break device. Two issues with that
> > > > > - drivers might not be ready to handle add_buf failures
> > > > > - restore needs to unbreak then and we don't have a way to do that yet
> > > > >
> > > > > So .. careful reading of all device drivers and hoping we don't mess
> > > > > things up even more ... here we come.
> > > >
> > > > Yes.
> > >
> > > The biggest issue with this trick is drivers not handling add_buf
> > > errors, adding a failure path here risks creating memory leaks.
> > > OTOH with e.g. bounce buffers maybe it's possible for add buf to
> > > fail anyway?
> >
> > I'm not sure I get this, a simple git grep told me at least the return
> > value of add_inbuf() were all checked.
> >
> > Thanks
>
> Checked locally, but not always error is handled all the way
> to the top. E.g. add_port in console returns an error code
> but that is never checked. Well, console is a mess generally.

I see. I can try to audit all virtio drivers for the add_inbuf() case.

Thanks

>
> > >
> > > > >
> > > > > > >
> > > > > > > I sent a patch to fix it for console removal specifically,
> > > > > > > but I suspect it's not enough e.g. freeze is still broken.
> > > > > > > And note this has been reported without any TDX things -
> > > > > > > it's not a malicious device issue, can be triggered just
> > > > > > > by module unload.
> > > > > > >
> > > > > > > I am vaguely thinking about new APIs to disable/enable callbacks.
> > > > > > > An alternative:
> > > > > > >
> > > > > > > 1. adding new remove_nocb/freeze_nocb calls
> > > > > > > 2. disabling/enabling interrupts automatically around these
> > > > > > > 3. gradually moving devices to using these
> > > > > > > 4. once/if all device move, removing the old callbacks
> > > > > > >
> > > > > > > the advantage here is that we'll be sure calls are always
> > > > > > > paired correctly.
> > > > > >
> > > > > > I'm not sure I get the idea, but my feeling is that it doesn't
> > > > > > conflict with the interrupt hardening here (or at least the same
> > > > > > method is required e.g NO_AUTO_EN).
> > > > > >
> > > > > > Thanks
> > > > >
> > > > > Right.  It's not that it conflicts, it's that I was hoping that
> > > > > since you are working on hardening you can take up fixing that.
> > > > > Let me know whether you have the time. Thanks!
> > > >
> > > > I can do that.
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > > Jason Wang (9):
> > > > > > > >   virtio-blk: validate num_queues during probe
> > > > > > > >   virtio: add doc for validate() method
> > > > > > > >   virtio-console: switch to use .validate()
> > > > > > > >   virtio_console: validate max_nr_ports before trying to use it
> > > > > > > >   virtio_config: introduce a new ready method
> > > > > > > >   virtio_pci: harden MSI-X interrupts
> > > > > > > >   virtio-pci: harden INTX interrupts
> > > > > > > >   virtio_ring: fix typos in vring_desc_extra
> > > > > > > >   virtio_ring: validate used buffer length
> > > > > > > >
> > > > > > > >  drivers/block/virtio_blk.c         |  3 +-
> > > > > > > >  drivers/char/virtio_console.c      | 51 +++++++++++++++++++++---------
> > > > > > > >  drivers/virtio/virtio_pci_common.c | 43 +++++++++++++++++++++----
> > > > > > > >  drivers/virtio/virtio_pci_common.h |  7 ++--
> > > > > > > >  drivers/virtio/virtio_pci_legacy.c |  5 +--
> > > > > > > >  drivers/virtio/virtio_pci_modern.c |  6 ++--
> > > > > > > >  drivers/virtio/virtio_ring.c       | 27 ++++++++++++++--
> > > > > > > >  include/linux/virtio.h             |  1 +
> > > > > > > >  include/linux/virtio_config.h      |  6 ++++
> > > > > > > >  9 files changed, 118 insertions(+), 31 deletions(-)
> > > > > > > >
> > > > > > > > --
> > > > > > > > 2.25.1
> > > > > > >
> > > > >
> > >
>

