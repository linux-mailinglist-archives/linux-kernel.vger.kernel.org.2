Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931374287BC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 09:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbhJKHjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 03:39:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59076 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231194AbhJKHjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 03:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633937824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t+zePsLaJ5jk9l+H2Z7aJXGzmwFM0MVSiI7p4UCnEWY=;
        b=Jis+5/5iOjBYpRFJAMzdfe/YkR7ySXtXa0h/irztP4+ut4+o6R1D+r3vS+bd+bwrw2XqZi
        vijrOsjSBw85CeDnp1mWaFlWQgUMyjUUj5LRLPoms3ZVN4uu7ieQYgpQqOFoKw40KulceV
        P6y3u9Tu/K+iYcixw8rufCfjZ4yACHg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-8eSL27lzN5y0QNqZCBnFeQ-1; Mon, 11 Oct 2021 03:37:03 -0400
X-MC-Unique: 8eSL27lzN5y0QNqZCBnFeQ-1
Received: by mail-lf1-f72.google.com with SMTP id g9-20020a0565123b8900b003f33a027130so12037354lfv.18
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 00:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t+zePsLaJ5jk9l+H2Z7aJXGzmwFM0MVSiI7p4UCnEWY=;
        b=C/WVrCH1T5zEI9hefxSMs8jPAziQodiQqjARm6cfXY/as5AgD2igMye3PL56bz5pFw
         oGqwCtdtBF7bexwHlmpgxsgCS8faC+XIpCO9ZRE0BfKmRxCYsfWEOtlBf7K7UXOH/fKp
         eHMN/+cyJjmDC4saLtFntUeraaN5BLzzcJi70gDm/TT368/YxCo5bMrWXmTN9vVnFxH5
         GQBonu/ja7eHRVmyHmiac7hHjS7g94WWULOjwF+gcQ8aHKvIgYb/LH+gTxu4LMmvQEJe
         C6YO28OBK1AFRMKtBIj7spbQMaedMW9615z1zfq8UEmTKuoAOykMwcQnfVKOoCUis5tN
         QYyA==
X-Gm-Message-State: AOAM5329ufr6a/5AN/cqibAWGugg3FxA9dmO25E5ItBws5dfj+n3dhYn
        xVBuyxsGrXSxgBmzxppVRSEq+YS8uVsLZhDmRqatDY1/7oY+iCB8ltpg2JQFV7I0eVJhbBBPm7s
        3a1+ngMUb6GRRKgQTnEsTqudtUv1tme38/371SG3P
X-Received: by 2002:a2e:a553:: with SMTP id e19mr21985056ljn.420.1633937822166;
        Mon, 11 Oct 2021 00:37:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHF43Bv4a442lrS3Inm2wP5avpUoj52WKebeHxwAtu27Oel/SY3K49AAyzdQxaxbDPKhgTNCLNKOFGhPaYcA0=
X-Received: by 2002:a2e:a553:: with SMTP id e19mr21985044ljn.420.1633937821988;
 Mon, 11 Oct 2021 00:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210913055353.35219-1-jasowang@redhat.com> <20211005032924-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211005032924-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 11 Oct 2021 15:36:51 +0800
Message-ID: <CACGkMEuQU6jXV_D5QvE29mX9spF6KcyrCDuvVwX99_jSf-x7fQ@mail.gmail.com>
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

On Tue, Oct 5, 2021 at 3:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Sep 13, 2021 at 01:53:44PM +0800, Jason Wang wrote:
> > Hi All:
> >
> > This series treis to do more hardening for virito.
> >
> > patch 1 validates the num_queues for virio-blk device.
> > patch 2-4 validates max_nr_ports for virito-console device.
> > patch 5-7 harden virtio-pci interrupts to make sure no exepcted
> > interrupt handler is tiggered. If this makes sense we can do similar
> > things in other transport drivers.
> > patch 8-9 validate used ring length.
> >
> > Smoking test on blk/net with packed=on/off and iommu_platform=on/off.
> >
> > Please review.
> >
> > Thanks
>
> So I poked at console at least, and I think I see
> an issue: if interrupt handler queues a work/bh,
> then it can still run while reset is in progress.

Looks like a bug which is unrelated to the hardening? E.g the driver
should sync with work/bh before reset.

>
> I sent a patch to fix it for console removal specifically,
> but I suspect it's not enough e.g. freeze is still broken.
> And note this has been reported without any TDX things -
> it's not a malicious device issue, can be triggered just
> by module unload.
>
> I am vaguely thinking about new APIs to disable/enable callbacks.
> An alternative:
>
> 1. adding new remove_nocb/freeze_nocb calls
> 2. disabling/enabling interrupts automatically around these
> 3. gradually moving devices to using these
> 4. once/if all device move, removing the old callbacks
>
> the advantage here is that we'll be sure calls are always
> paired correctly.

I'm not sure I get the idea, but my feeling is that it doesn't
conflict with the interrupt hardening here (or at least the same
method is required e.g NO_AUTO_EN).

Thanks

>
>
>
>
>
> > Jason Wang (9):
> >   virtio-blk: validate num_queues during probe
> >   virtio: add doc for validate() method
> >   virtio-console: switch to use .validate()
> >   virtio_console: validate max_nr_ports before trying to use it
> >   virtio_config: introduce a new ready method
> >   virtio_pci: harden MSI-X interrupts
> >   virtio-pci: harden INTX interrupts
> >   virtio_ring: fix typos in vring_desc_extra
> >   virtio_ring: validate used buffer length
> >
> >  drivers/block/virtio_blk.c         |  3 +-
> >  drivers/char/virtio_console.c      | 51 +++++++++++++++++++++---------
> >  drivers/virtio/virtio_pci_common.c | 43 +++++++++++++++++++++----
> >  drivers/virtio/virtio_pci_common.h |  7 ++--
> >  drivers/virtio/virtio_pci_legacy.c |  5 +--
> >  drivers/virtio/virtio_pci_modern.c |  6 ++--
> >  drivers/virtio/virtio_ring.c       | 27 ++++++++++++++--
> >  include/linux/virtio.h             |  1 +
> >  include/linux/virtio_config.h      |  6 ++++
> >  9 files changed, 118 insertions(+), 31 deletions(-)
> >
> > --
> > 2.25.1
>

