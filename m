Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3AA4429D4D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 07:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbhJLFqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 01:46:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40449 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229688AbhJLFqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 01:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634017457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7mKe1aMDAXPiWMtxEmF62m6V5nKGSCmazojMcnMYkQo=;
        b=ZvkWHWOoGEzqILTNm6xNMbvpm0va6Yij9BCGVY49ufy8X3O1mH7K9ccqWZYv0uBI916wz+
        zDHwOQMfG4wJ5lftFCuyzi7K52OVNG+RaWGsTf/ZWeiZYIxWnrNca3iE9YEJ8ExQ3i1EVu
        BrYoecXjWTOLGZEVtTzMWp/7/vmSOKY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-Qk4_v1oKOgevh79JU-QMsw-1; Tue, 12 Oct 2021 01:44:16 -0400
X-MC-Unique: Qk4_v1oKOgevh79JU-QMsw-1
Received: by mail-ed1-f69.google.com with SMTP id l22-20020aa7c316000000b003dbbced0731so491175edq.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 22:44:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7mKe1aMDAXPiWMtxEmF62m6V5nKGSCmazojMcnMYkQo=;
        b=YwPMfR9VeYzg99xEc8soDclymZorgi5AufJ2TMsgxketNaTQFKjJkwDZTzI7nZ5OFV
         RESgzN9W/e7dv1CDHR3OQC5m7ErEMFwMs0i+MN94zrlrcJkACiC73AGEf8K7n0wSkBxp
         9bS0ddQ8x8LJRMi+4NL/xF3ihwh2zJxOdvdM8jZyjVxBzuDkKvRbp4EF8w4A+yMYwzpF
         Y9qTpo8MJRbhyGWqAFKwF7AHDa0h1fmg9ijyE/WqKQ0QGhHYtSMWIQFsvp7LQSVAdkNR
         MvOSdwlJ3XygxD5rNzZsoTYOHgyzK5lQDSJBTb8VCWv79u8zfBEwyKPyuo3OTecg+yS3
         A1lQ==
X-Gm-Message-State: AOAM532oYyGEyJTUMjahC3AXfrfZf1fZ0q2FOOk1I1jbxJ/cgIHavFsM
        FVA4C4sNouE6h3lQyGk8kCjjbY2IO40w5RhlJH7NRXAYOibEvmD+fZrVqJjtU2BMJYLFCKPF5v+
        AfpqBZILbRogAhfZBlslMix2V
X-Received: by 2002:a05:6402:2345:: with SMTP id r5mr47556728eda.202.1634017455336;
        Mon, 11 Oct 2021 22:44:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBz84Cr4FOevtfdR4Vpcm+1X0J5VzmJ34ccs0+u78Q3j+cLahe66b919AVzqGcdg9wxL41dQ==
X-Received: by 2002:a05:6402:2345:: with SMTP id r5mr47556705eda.202.1634017455043;
        Mon, 11 Oct 2021 22:44:15 -0700 (PDT)
Received: from redhat.com ([2.55.159.57])
        by smtp.gmail.com with ESMTPSA id g17sm5214257edv.72.2021.10.11.22.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 22:44:14 -0700 (PDT)
Date:   Tue, 12 Oct 2021 01:44:10 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Hetzelt, Felicitas" <f.hetzelt@tu-berlin.de>,
        "kaplan, david" <david.kaplan@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 0/9] More virtio hardening
Message-ID: <20211012012617-mutt-send-email-mst@kernel.org>
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20211005032924-mutt-send-email-mst@kernel.org>
 <CACGkMEuQU6jXV_D5QvE29mX9spF6KcyrCDuvVwX99_jSf-x7fQ@mail.gmail.com>
 <20211011082640-mutt-send-email-mst@kernel.org>
 <CACGkMEtwAFy=bm62X+rjPMJEwChAhZkZ2bBwDJPULdzhWdzagA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEtwAFy=bm62X+rjPMJEwChAhZkZ2bBwDJPULdzhWdzagA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 10:43:57AM +0800, Jason Wang wrote:
> On Mon, Oct 11, 2021 at 8:36 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Oct 11, 2021 at 03:36:51PM +0800, Jason Wang wrote:
> > > On Tue, Oct 5, 2021 at 3:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, Sep 13, 2021 at 01:53:44PM +0800, Jason Wang wrote:
> > > > > Hi All:
> > > > >
> > > > > This series treis to do more hardening for virito.
> > > > >
> > > > > patch 1 validates the num_queues for virio-blk device.
> > > > > patch 2-4 validates max_nr_ports for virito-console device.
> > > > > patch 5-7 harden virtio-pci interrupts to make sure no exepcted
> > > > > interrupt handler is tiggered. If this makes sense we can do similar
> > > > > things in other transport drivers.
> > > > > patch 8-9 validate used ring length.
> > > > >
> > > > > Smoking test on blk/net with packed=on/off and iommu_platform=on/off.
> > > > >
> > > > > Please review.
> > > > >
> > > > > Thanks
> > > >
> > > > So I poked at console at least, and I think I see
> > > > an issue: if interrupt handler queues a work/bh,
> > > > then it can still run while reset is in progress.
> > >
> > > Looks like a bug which is unrelated to the hardening?
> >
> > Won't preventing use after free be relevant?
> 
> Oh right.
> 
> > I frankly don't know what does hardening means then.
> > > E.g the driver
> > > should sync with work/bh before reset.
> >
> > No, there's no way to fix it ATM without extra locks and state which I
> > think we should strive to avoid or make it generic, not per-driver,
> > since sync before reset is useless, new interrupts will just arrive and
> > queue more work. And a sync after reset is too late since driver will
> > try to add buffers.
> 
> Can we do something like
> 
> 1) disable interrupt
> 2) sync bh
> 
> Or I guess this is somehow you meant in the following steps.

So that would mean a new API to disable vq interrupts.
reset will re-enable.
E.g. virtqueue_cancel_cb_before_reset()?

Then drivers can sync, then reset.
This means maintaining more state though, which I don't like.

An alternative is something like this:

static void (*virtio_flush_device)(struct virtio_device *dev);

void virtio_reset_device(struct virtio_device *dev, virtio_flush_device flush)
{
	might_sleep();
	if (flush) {
		dev->config->disable_interrupts(dev);
		flush(dev);
		dev->config->reset(dev);
		dev->config->enable_interrupts(dev);
	} else {
		dev->config->reset(dev);
	}
}

I have patches wrapping all reset calls in virtio_reset_device
(without the flush parameter but that's easy to tweak).


> >
> > Maybe we can break device. Two issues with that
> > - drivers might not be ready to handle add_buf failures
> > - restore needs to unbreak then and we don't have a way to do that yet
> >
> > So .. careful reading of all device drivers and hoping we don't mess
> > things up even more ... here we come.
> 
> Yes.

The biggest issue with this trick is drivers not handling add_buf
errors, adding a failure path here risks creating memory leaks.
OTOH with e.g. bounce buffers maybe it's possible for add buf to
fail anyway?

> >
> > > >
> > > > I sent a patch to fix it for console removal specifically,
> > > > but I suspect it's not enough e.g. freeze is still broken.
> > > > And note this has been reported without any TDX things -
> > > > it's not a malicious device issue, can be triggered just
> > > > by module unload.
> > > >
> > > > I am vaguely thinking about new APIs to disable/enable callbacks.
> > > > An alternative:
> > > >
> > > > 1. adding new remove_nocb/freeze_nocb calls
> > > > 2. disabling/enabling interrupts automatically around these
> > > > 3. gradually moving devices to using these
> > > > 4. once/if all device move, removing the old callbacks
> > > >
> > > > the advantage here is that we'll be sure calls are always
> > > > paired correctly.
> > >
> > > I'm not sure I get the idea, but my feeling is that it doesn't
> > > conflict with the interrupt hardening here (or at least the same
> > > method is required e.g NO_AUTO_EN).
> > >
> > > Thanks
> >
> > Right.  It's not that it conflicts, it's that I was hoping that
> > since you are working on hardening you can take up fixing that.
> > Let me know whether you have the time. Thanks!
> 
> I can do that.
> 
> Thanks
> 
> >
> > > >
> > > >
> > > >
> > > >
> > > >
> > > > > Jason Wang (9):
> > > > >   virtio-blk: validate num_queues during probe
> > > > >   virtio: add doc for validate() method
> > > > >   virtio-console: switch to use .validate()
> > > > >   virtio_console: validate max_nr_ports before trying to use it
> > > > >   virtio_config: introduce a new ready method
> > > > >   virtio_pci: harden MSI-X interrupts
> > > > >   virtio-pci: harden INTX interrupts
> > > > >   virtio_ring: fix typos in vring_desc_extra
> > > > >   virtio_ring: validate used buffer length
> > > > >
> > > > >  drivers/block/virtio_blk.c         |  3 +-
> > > > >  drivers/char/virtio_console.c      | 51 +++++++++++++++++++++---------
> > > > >  drivers/virtio/virtio_pci_common.c | 43 +++++++++++++++++++++----
> > > > >  drivers/virtio/virtio_pci_common.h |  7 ++--
> > > > >  drivers/virtio/virtio_pci_legacy.c |  5 +--
> > > > >  drivers/virtio/virtio_pci_modern.c |  6 ++--
> > > > >  drivers/virtio/virtio_ring.c       | 27 ++++++++++++++--
> > > > >  include/linux/virtio.h             |  1 +
> > > > >  include/linux/virtio_config.h      |  6 ++++
> > > > >  9 files changed, 118 insertions(+), 31 deletions(-)
> > > > >
> > > > > --
> > > > > 2.25.1
> > > >
> >

