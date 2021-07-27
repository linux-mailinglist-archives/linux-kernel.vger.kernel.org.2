Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B763D7E0A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 20:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhG0SxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 14:53:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60143 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229763AbhG0SxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 14:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627411993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pywaGuqiWa+m7IiTARlllehIqVu1cJ37vlNw1KlZgMk=;
        b=M9ur1aRiiiQjgCaGe+rgz0Q+693/HPJ6+cetAo9uf9Cg3MEv9VSBUbH/Ru4Nh1u4uopbhk
        MGmlBplY3tmeBs6LHjhWa8o9K2MJdcF1/7OCZ6rwxnLnX5plRLkagi0TErLd0cH71eP656
        B4YNbv44NF5Pjumy/u+5yMGP0NvYsE0=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-Efw50KJfMsydRKedJGQjvQ-1; Tue, 27 Jul 2021 14:53:11 -0400
X-MC-Unique: Efw50KJfMsydRKedJGQjvQ-1
Received: by mail-oo1-f70.google.com with SMTP id b24-20020a4ac2980000b0290269ebe9b797so17753ooq.18
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 11:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=pywaGuqiWa+m7IiTARlllehIqVu1cJ37vlNw1KlZgMk=;
        b=AMIay3GKYlrWmI7rXVIahGAzp84Y6vL6PhGSBve9ZoB87JerGfTJYHEfsYsR0k6ApB
         j2D+iYeBOad3o1r/KmZLmOM6yhbhmHdn6BoedLId244JS0waDwIck+kk/89MY2hU6+uh
         u7N/DWP4p+/TUpgTY4vYy7AfpsxgsbJyNyY/3Qk7Z6x9ZbjVu1ObosC/6AWhQy7Yj9Vr
         WtlsqpfEJE1taH3VANKh2uSdGZdY9bvZlaw7OrtFjkN4vWt9LvZHScSEXahVGNyKw/BP
         gNL/rMcp6I1fIeCr8U2aH4nRQDyNdur/54MCFUsbDuwZV3jHXWoBasTaUsN9JMr8qoLN
         sn5w==
X-Gm-Message-State: AOAM530HaOK+y3DJoUu90/v3JypzCNhUfOMOO8Gtgd2q4TcG5xNEMgI6
        9KwLwQuxfHBB/6zRzv8RhPkt4MTKTHrWYm9tvhm223qut8QdDqPziIsRGqzk9+TC91X5UbdU8eE
        tqaWhGwuoavfmSTXKLk1tw+ox
X-Received: by 2002:a05:6830:11d3:: with SMTP id v19mr17222649otq.98.1627411991237;
        Tue, 27 Jul 2021 11:53:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQACTDPYwC/EEIPJP2/Eptj4nf31Vq9hx3nse0SZ0K8pyRgSXydLLBvOMzEu23g7Kl+qQZQA==
X-Received: by 2002:a05:6830:11d3:: with SMTP id v19mr17222644otq.98.1627411991056;
        Tue, 27 Jul 2021 11:53:11 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id a7sm613602ooo.9.2021.07.27.11.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 11:53:10 -0700 (PDT)
Date:   Tue, 27 Jul 2021 12:53:09 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Cornelia Huck <cohuck@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Kirti Wankhede <kwankhede@nvidia.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] vfio/mdev: don't warn if ->request is not set
Message-ID: <20210727125309.292b30c0.alex.williamson@redhat.com>
In-Reply-To: <20210727173209.GG1721383@nvidia.com>
References: <20210726143524.155779-1-hch@lst.de>
        <20210726143524.155779-3-hch@lst.de>
        <87zgu93sxz.fsf@redhat.com>
        <20210726230906.GD1721383@nvidia.com>
        <20210726172831.3a7978fd.alex.williamson@redhat.com>
        <87wnpc47j3.fsf@redhat.com>
        <20210727173209.GG1721383@nvidia.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2021 14:32:09 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Jul 27, 2021 at 08:04:16AM +0200, Cornelia Huck wrote:
> > On Mon, Jul 26 2021, Alex Williamson <alex.williamson@redhat.com> wrote:
> >   
> > > On Mon, 26 Jul 2021 20:09:06 -0300
> > > Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >  
> > >> On Mon, Jul 26, 2021 at 07:07:04PM +0200, Cornelia Huck wrote:
> > >>   
> > >> > But I wonder why nobody else implements this? Lack of surprise removal?    
> > >> 
> > >> The only implementation triggers an eventfd that seems to be the same
> > >> eventfd as the interrupt..
> > >> 
> > >> Do you know how this works in userspace? I'm surprised that the
> > >> interrupt eventfd can trigger an observation that the kernel driver
> > >> wants to be unplugged?  
> > >
> > > I think we're talking about ccw, but I see QEMU registering separate
> > > eventfds for each of the 3 IRQ indexes and the mdev driver specifically
> > > triggering the req_trigger...?  Thanks,
> > >
> > > Alex  
> > 
> > Exactly, ccw has a trigger for normal I/O interrupts, CRW (machine
> > checks), and this one.  
> 
> If it is a dedicated eventfd for 'device being removed' why is it in
> the CCW implementation and not core code?

The CCW implementation (likewise the vfio-pci implementation) owns the
IRQ index address space and the decision to make this a signal to
userspace rather than perhaps some handling a device might be able to
do internally.  For instance an alternate vfio-pci implementation might
zap all mmaps, block all r/w access, and turn this into a surprise
removal.  Another implementation might be more aggressive to sending
SIGKILL to the user process.  This was the thought behind why vfio-core
triggers the driver request callback with a counter, leaving the policy
to the driver.

> Is PCI doing the same?

Yes, that's where this handling originated.  Thanks,

Alex

