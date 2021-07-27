Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E459C3D7E7E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 21:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbhG0TZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 15:25:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50941 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231916AbhG0TZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 15:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627413942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fh1Qlb2hbonembrGXgFVXQjLx82VQf+wwQBAo+zwcxI=;
        b=bhvWYVut64WBMT9OiS+fy0RvP79yZSjpM3Eivsnxp1sAe4RQhFq28DAzPBPZDPQ024fEAQ
        0dpuDguEGankes47aA4AaNFdlsKQxCfaR8uV8fWp/RoaoiUwb9hSmFuLm4cZ3/Zg+hC9Dx
        gXYny1JrQQVPO4GfclRBdGxpgR25ZlU=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-0I_p4d6ZNyat-Zc4lhVc9g-1; Tue, 27 Jul 2021 15:25:40 -0400
X-MC-Unique: 0I_p4d6ZNyat-Zc4lhVc9g-1
Received: by mail-oo1-f70.google.com with SMTP id z25-20020a4ad1b90000b029023bbaaddcbbso68344oor.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 12:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Fh1Qlb2hbonembrGXgFVXQjLx82VQf+wwQBAo+zwcxI=;
        b=SOo7o4rXaxsqcqcOF8nUr9jHAmgwqfgWTMGU4l/voCVSWFv2cLJbbAI18i0jAV8jDh
         rvDA/lK6Geta8Fat8U3BvLhZut176jTo/vGpzfsVv9ynELIXwT5Y0sb14c8k9IRRUvC1
         Y7FMwH+d2hRtPloTV7cJVFMVAqKpNIslCobBDzdj4LZ1Jh4XFDBD23t8ymmYjuDxoWcJ
         wpYT3OFGd2CME5tr3oFp9mZkqRp4IloR7QSRvHE+2Sw9usRlt7f07ZpmNOKQeH36qIhg
         9lbk2vZFbb/eGeeLeV+woJoomMppOsRcinIAcRizrBd+S9YyhvAQyllUGGZ0f2Z2zHzw
         qNIA==
X-Gm-Message-State: AOAM533uTcoCOUyw/iueVOKqdiJIpd3t0U0jDvAzMYEc1z2iCobie2B/
        5jywBgecPsjar8lKDWVWzz1chI9bqjJrUUudKbIv3TtGnSdS2O2ZypPR1bVMgB5ibz8RQ/coiZE
        8FWNndezt6MOukPh699TQ5Uj1
X-Received: by 2002:aca:4814:: with SMTP id v20mr15978892oia.73.1627413940004;
        Tue, 27 Jul 2021 12:25:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHuNpt2EgjAsW6E1OWopyiblvZ9a1q01or2R07vjcBltz2Ka5N4nb765LF7L8cBXkwsf5FDw==
X-Received: by 2002:aca:4814:: with SMTP id v20mr15978883oia.73.1627413939856;
        Tue, 27 Jul 2021 12:25:39 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id h2sm690704oti.24.2021.07.27.12.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 12:25:39 -0700 (PDT)
Date:   Tue, 27 Jul 2021 13:25:38 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Cornelia Huck <cohuck@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Kirti Wankhede <kwankhede@nvidia.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] vfio/mdev: don't warn if ->request is not set
Message-ID: <20210727132538.13f65188.alex.williamson@redhat.com>
In-Reply-To: <20210727190317.GJ1721383@nvidia.com>
References: <20210726143524.155779-1-hch@lst.de>
        <20210726143524.155779-3-hch@lst.de>
        <87zgu93sxz.fsf@redhat.com>
        <20210726230906.GD1721383@nvidia.com>
        <20210726172831.3a7978fd.alex.williamson@redhat.com>
        <87wnpc47j3.fsf@redhat.com>
        <20210727173209.GG1721383@nvidia.com>
        <20210727125309.292b30c0.alex.williamson@redhat.com>
        <20210727190317.GJ1721383@nvidia.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2021 16:03:17 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Jul 27, 2021 at 12:53:09PM -0600, Alex Williamson wrote:
> > On Tue, 27 Jul 2021 14:32:09 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >   
> > > On Tue, Jul 27, 2021 at 08:04:16AM +0200, Cornelia Huck wrote:  
> > > > On Mon, Jul 26 2021, Alex Williamson <alex.williamson@redhat.com> wrote:
> > > >     
> > > > > On Mon, 26 Jul 2021 20:09:06 -0300
> > > > > Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > > >    
> > > > >> On Mon, Jul 26, 2021 at 07:07:04PM +0200, Cornelia Huck wrote:
> > > > >>     
> > > > >> > But I wonder why nobody else implements this? Lack of surprise removal?      
> > > > >> 
> > > > >> The only implementation triggers an eventfd that seems to be the same
> > > > >> eventfd as the interrupt..
> > > > >> 
> > > > >> Do you know how this works in userspace? I'm surprised that the
> > > > >> interrupt eventfd can trigger an observation that the kernel driver
> > > > >> wants to be unplugged?    
> > > > >
> > > > > I think we're talking about ccw, but I see QEMU registering separate
> > > > > eventfds for each of the 3 IRQ indexes and the mdev driver specifically
> > > > > triggering the req_trigger...?  Thanks,
> > > > >
> > > > > Alex    
> > > > 
> > > > Exactly, ccw has a trigger for normal I/O interrupts, CRW (machine
> > > > checks), and this one.    
> > > 
> > > If it is a dedicated eventfd for 'device being removed' why is it in
> > > the CCW implementation and not core code?  
> > 
> > The CCW implementation (likewise the vfio-pci implementation) owns
> > the IRQ index address space and the decision to make this a signal
> > to userspace rather than perhaps some handling a device might be
> > able to do internally.   
> 
> The core code holds the vfio_device_get() so long as the FD is
> open. There is no way to pass the wait_for_completion without
> userspace closing the FD, so there isn't really much choice for the
> drivers to do beyond signal to userpace to close the FD??
> 
> > For instance an alternate vfio-pci implementation might zap all
> > mmaps, block all r/w access, and turn this into a surprise removal.  
> 
> This is nice, but wouldn't close the FD, so needs core changes
> anyhow..

Right, the core would need to be able to handle an FD disconnected from
the device, obviously some core changes would be required.

> > Another implementation might be more aggressive to sending SIGKILL
> > to the user process.  
> 
> We don't try to revoke FDs from the kernel, it is racy, dangerous and
> unreliable.

I'm not sure how trying to kill the process using an open file becomes
a revoke...  In fact, the surprise hotplug might just be able to zap
mmaps and wait for userspace to generate a SIGBUS.

> > This was the thought behind why vfio-core triggers the driver
> > request callback with a counter, leaving the policy to the driver.  
> 
> IMHO subsystem policy does not belong in drivers. Down that road lies
> a mess for userspace.

I think my argument was that to this point it's been driver policy, not
subsystem policy.  The subsystem policy is to block until the device is
released, it's the driver policy whether it has a means to implement
something to expedite that.  Thanks,

Alex

