Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6D2428D2A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 14:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236664AbhJKMi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 08:38:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48872 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236662AbhJKMi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 08:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633955786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GrUQkfy44LwX8fmQn2Zrl2/DU83nyPEQ3GJ0LUQ6ZjE=;
        b=N+Qp/hzMvwnnA4UD4yiCkBHPVCOM/5MHlNIilo7W0IPfOUgZuWQSbMnYyfDqsfvdc3kTEl
        HQlnc0hMjzOX25e35X+c+5Zsnp1SzJ6EVBKfkggqrO/m1V8aCW8lHj7QyriBP0JkYAldrO
        6m+VkWGjggM8uBPJ9lPDkGBvoj1FjaY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-2caFHm-zMwOyzh-I3envTA-1; Mon, 11 Oct 2021 08:36:25 -0400
X-MC-Unique: 2caFHm-zMwOyzh-I3envTA-1
Received: by mail-ed1-f72.google.com with SMTP id i7-20020a50d747000000b003db0225d219so15826727edj.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 05:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GrUQkfy44LwX8fmQn2Zrl2/DU83nyPEQ3GJ0LUQ6ZjE=;
        b=LSgyx0HTyDZSakResTmlngvh64JQY1hXJPtFDdyTOcvX++C4hMl9EAAA3PHV6BjFpf
         vs6spbScJc68E80Dbx+bMsIq5cFhHmaR4hJLchbSvYqpHbSpbfZTIWyVvisI0NXqelUn
         A96y4JvoCnblOWAXbYJSw6TvbBXZeRYkTy3XVAxvA5TBosvruPYuSOSuUo8uksoMlL4Y
         z3V7NMrh9yu/9FWMQ6POwH9yhilsBwJ9opfcfGWf1caxuf+X7kpOJvDIurpwZxBZmsAJ
         HFtVhAEHGhYhpNNwiNK7qXzcmjk0znD4f5CC/LJHRzUPgmGqVdqFTFsN9C+WcvyVDFKp
         +x7w==
X-Gm-Message-State: AOAM530j9gfUmCJCmAlIVvb+kO/4Tu97vLax1u2pZr//ve485PZrSv4u
        0OamW3il+yMCMKS9a/kITnm/i5nwa94tQmRAe5MLZ176n7SC6+/EbBSJTwEfH5aAhTaSevvyM30
        s1rzn5r67IMy9aZ6dDC+Ie87E
X-Received: by 2002:a50:d84e:: with SMTP id v14mr40623240edj.85.1633955783972;
        Mon, 11 Oct 2021 05:36:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUHUlowo8yKJap2dLlduI1p5gsrv1S32zcK1Jih//aSKoZhhLQqAIuRjYwg1HKIyO/huFh9Q==
X-Received: by 2002:a50:d84e:: with SMTP id v14mr40623218edj.85.1633955783796;
        Mon, 11 Oct 2021 05:36:23 -0700 (PDT)
Received: from redhat.com ([2.55.159.57])
        by smtp.gmail.com with ESMTPSA id e7sm4414518edk.3.2021.10.11.05.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 05:36:23 -0700 (PDT)
Date:   Mon, 11 Oct 2021 08:36:19 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Hetzelt, Felicitas" <f.hetzelt@tu-berlin.de>,
        "kaplan, david" <david.kaplan@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 0/9] More virtio hardening
Message-ID: <20211011082640-mutt-send-email-mst@kernel.org>
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20211005032924-mutt-send-email-mst@kernel.org>
 <CACGkMEuQU6jXV_D5QvE29mX9spF6KcyrCDuvVwX99_jSf-x7fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEuQU6jXV_D5QvE29mX9spF6KcyrCDuvVwX99_jSf-x7fQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 03:36:51PM +0800, Jason Wang wrote:
> On Tue, Oct 5, 2021 at 3:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Sep 13, 2021 at 01:53:44PM +0800, Jason Wang wrote:
> > > Hi All:
> > >
> > > This series treis to do more hardening for virito.
> > >
> > > patch 1 validates the num_queues for virio-blk device.
> > > patch 2-4 validates max_nr_ports for virito-console device.
> > > patch 5-7 harden virtio-pci interrupts to make sure no exepcted
> > > interrupt handler is tiggered. If this makes sense we can do similar
> > > things in other transport drivers.
> > > patch 8-9 validate used ring length.
> > >
> > > Smoking test on blk/net with packed=on/off and iommu_platform=on/off.
> > >
> > > Please review.
> > >
> > > Thanks
> >
> > So I poked at console at least, and I think I see
> > an issue: if interrupt handler queues a work/bh,
> > then it can still run while reset is in progress.
> 
> Looks like a bug which is unrelated to the hardening?

Won't preventing use after free be relevant?
I frankly don't know what does hardening means then.
> E.g the driver
> should sync with work/bh before reset.

No, there's no way to fix it ATM without extra locks and state which I
think we should strive to avoid or make it generic, not per-driver,
since sync before reset is useless, new interrupts will just arrive and
queue more work. And a sync after reset is too late since driver will
try to add buffers.

Maybe we can break device. Two issues with that
- drivers might not be ready to handle add_buf failures
- restore needs to unbreak then and we don't have a way to do that yet

So .. careful reading of all device drivers and hoping we don't mess
things up even more ... here we come.

> >
> > I sent a patch to fix it for console removal specifically,
> > but I suspect it's not enough e.g. freeze is still broken.
> > And note this has been reported without any TDX things -
> > it's not a malicious device issue, can be triggered just
> > by module unload.
> >
> > I am vaguely thinking about new APIs to disable/enable callbacks.
> > An alternative:
> >
> > 1. adding new remove_nocb/freeze_nocb calls
> > 2. disabling/enabling interrupts automatically around these
> > 3. gradually moving devices to using these
> > 4. once/if all device move, removing the old callbacks
> >
> > the advantage here is that we'll be sure calls are always
> > paired correctly.
> 
> I'm not sure I get the idea, but my feeling is that it doesn't
> conflict with the interrupt hardening here (or at least the same
> method is required e.g NO_AUTO_EN).
> 
> Thanks

Right.  It's not that it conflicts, it's that I was hoping that
since you are working on hardening you can take up fixing that.
Let me know whether you have the time. Thanks!

> >
> >
> >
> >
> >
> > > Jason Wang (9):
> > >   virtio-blk: validate num_queues during probe
> > >   virtio: add doc for validate() method
> > >   virtio-console: switch to use .validate()
> > >   virtio_console: validate max_nr_ports before trying to use it
> > >   virtio_config: introduce a new ready method
> > >   virtio_pci: harden MSI-X interrupts
> > >   virtio-pci: harden INTX interrupts
> > >   virtio_ring: fix typos in vring_desc_extra
> > >   virtio_ring: validate used buffer length
> > >
> > >  drivers/block/virtio_blk.c         |  3 +-
> > >  drivers/char/virtio_console.c      | 51 +++++++++++++++++++++---------
> > >  drivers/virtio/virtio_pci_common.c | 43 +++++++++++++++++++++----
> > >  drivers/virtio/virtio_pci_common.h |  7 ++--
> > >  drivers/virtio/virtio_pci_legacy.c |  5 +--
> > >  drivers/virtio/virtio_pci_modern.c |  6 ++--
> > >  drivers/virtio/virtio_ring.c       | 27 ++++++++++++++--
> > >  include/linux/virtio.h             |  1 +
> > >  include/linux/virtio_config.h      |  6 ++++
> > >  9 files changed, 118 insertions(+), 31 deletions(-)
> > >
> > > --
> > > 2.25.1
> >

