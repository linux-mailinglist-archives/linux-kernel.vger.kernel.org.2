Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984873B981F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 23:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbhGAV10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 17:27:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38726 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233080AbhGAV1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 17:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625174693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J/pkuckV+XJBIvkI3fjjZrH/4ezGzwjpiC++Zq74xe4=;
        b=Lqm9T4U1Ly1q1ivn44PtCJFCjciNVr+ndhyV7OTxm9h93/OQrNr/02C0hsaMAifMq1xWXa
        we7y5KltBFzJnHpI9uqzPYv8gmQ1YvPzErup2T8JFB8lqw6YyxWlHdEAFYw3Z1V+KPTiju
        oYWD+oVn8hg7RQk+BXMFcRqLB4OQcd8=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-8pDW78AhMi6KYMkXjwREwQ-1; Thu, 01 Jul 2021 17:24:52 -0400
X-MC-Unique: 8pDW78AhMi6KYMkXjwREwQ-1
Received: by mail-ot1-f72.google.com with SMTP id t4-20020a9d77440000b0290463a472d9a2so4857703otl.16
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 14:24:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J/pkuckV+XJBIvkI3fjjZrH/4ezGzwjpiC++Zq74xe4=;
        b=MRUkAOe/D6PISJesnCRNmVgJHMdZJa/+xzi9lHHbsRbA4YKrvqDh+SqPrVSRnZ9Kl7
         0nb7XoHjKpvVQSSo2VobN2RLScf3Fy+fi2BSkQ47estzNQ1q1qg8XkuegeO8nbZQb+UP
         /KF8yf9sTLpaznB9tBakRNdwARpJUM0h8EPzuBUQUgObdXR2tvfBcg6Rw/LARPgteFzQ
         OQUwyWkY55Hn4M90IgCRFmc/oqEgRc/PKFmnDfP4ITgdNvPqECiZrdN3LX6bt3UXoDGM
         bnsTOAmid6pOegK7wKy5f98aBtZVYw1G5Ob0HUq3whzyaZmQ10Maqo/HV8681ORNUE1q
         cqXg==
X-Gm-Message-State: AOAM531RzeeelhTQC7gSgpi43R3LgFiobh/l6ku435g2aTTDhLXpg6oT
        N+JPKWzghEeC9mM28efA7hpCD8wUcvl95IBvGMrsxU3sK19UZx0zqKQCPJuvxxGFGkiFqIObO+m
        SmHK/eYnD1sXhv3vWEKAWNHFy
X-Received: by 2002:aca:5384:: with SMTP id h126mr9135134oib.69.1625174691989;
        Thu, 01 Jul 2021 14:24:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6wIfKRZimG8t6mMWGtJhAyre1Asho1T6CrSgZ4HQm/Ze4Vd5ECmaJfJdOPoNqjNBTl2GL6g==
X-Received: by 2002:aca:5384:: with SMTP id h126mr9135124oib.69.1625174691710;
        Thu, 01 Jul 2021 14:24:51 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id c14sm245279oic.50.2021.07.01.14.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 14:24:51 -0700 (PDT)
Date:   Thu, 1 Jul 2021 15:24:49 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Robert Straw <drbawb@fatalsyntax.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Disable Samsung SM951/PM951 NVMe before FLR
Message-ID: <20210701152449.6071f1d2.alex.williamson@redhat.com>
In-Reply-To: <20210701201545.GA85919@bjorn-Precision-5520>
References: <YN4etaP6hInKvSgG@infradead.org>
        <20210701201545.GA85919@bjorn-Precision-5520>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jul 2021 15:15:45 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Thu, Jul 01, 2021 at 08:59:49PM +0100, Christoph Hellwig wrote:
> > On Thu, Jul 01, 2021 at 02:38:56PM -0500, Bjorn Helgaas wrote:  
> > > On Fri, Apr 30, 2021 at 06:01:19PM -0500, Robert Straw wrote:  
> > > > The SM951/PM951, when used in conjunction with the vfio-pci driver and
> > > > passed to a KVM guest, can exhibit the fatal state addressed by the
> > > > existing `nvme_disable_and_flr` quirk. If the guest cleanly shuts down
> > > > the SSD, and vfio-pci attempts an FLR to the device while it is in this
> > > > state, the nvme driver will fail when it attempts to bind to the device
> > > > after the FLR due to the frozen config area, e.g:
> > > > 
> > > >   nvme nvme2: frozen state error detected, reset controller
> > > >   nvme nvme2: Removing after probe failure status: -12
> > > > 
> > > > By including this older model (Samsung 950 PRO) of the controller in the
> > > > existing quirk: the device is able to be cleanly reset after being used
> > > > by a KVM guest.
> > > > 
> > > > Signed-off-by: Robert Straw <drbawb@fatalsyntax.com>  
> > > 
> > > Applied to pci/virtualization for v5.14, thanks!  
> > 
> > FYI, I really do not like the idea of the PCIe core messing with NVMe
> > registers like this.  

What are the specific concerns of PCI-core messing with NVMe registers,
or any other device specific registers?

PCI-core is being told to reset the device, so whether directly or
implicitly, device specific registers will be affected regardless of
how much we directly poke them.
 
> I hadn't looked at the nvme_disable_and_flr() implementation, but yes,
> I see what you mean, that *is* ugly.  I dropped this patch for now.

This attempts to implement the minimum necessary code to disable the
device per the spec, where even though the spec reference isn't the
latest, it should still be applicable to newer devices (I assume the
NVMe standard cares about backwards compatibility).
 
> I see that you suggested earlier that we not allow these devices to be
> assigned via VFIO [1].  Is that practical?  Sounds like it could be
> fairly punitive.

Punitive, yes.  Most hardware is broken in one way or another.

> I assume this reset is normally used when vfio-pci is the driver in
> the host kernel and there probably is no guest.  In that particular
> case, I'd guess there's no conflict, but as you say, the sysfs reset
> attribute could trigger this reset when there *is* a guest driver, so
> there *would* be a conflict.
> 
> Could we coordinate this reset with vfio somehow so we only use
> nvme_disable_and_flr() when there is no guest?

We can trigger a reset via sysfs whether the host driver is vfio-pci or
any other device driver.  I don't understand what that has to do with
specifically messing with NVMe registers here.  Don't we usually say
that resetting *any* running devices via sysfs is a shoot yourself in
the foot scenario?  `echo 0 > enable` would be dis-recommended as well,
or using setpci to manually trigger a reset or poking BAR registers, or
writing garbage to the resource attributes.

vfio tries to make use of this in coordination with userspace
requesting a device reset or to attempt to clear devices state so it's
not leaked between users (more applicable when we're not talking about
mass storage devices).  In a VM scenario, that should correspond to
something like a VM reset or poking FLR from the guest.

I think the sysfs reset mechanism used to be more useful for VMs back
in the days of legacy KVM device assignment, when it was usually
libvirt trying to reset a device rather than a host kernel driver like
vfio-pci.  I still find it useful for some use cases and it's not like
there aren't plenty of other ways to break your device out from under
the running drivers if you're sufficiently privileged.  What's really
the issue here?  Thanks,

Alex

