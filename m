Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCE23B252F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 04:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhFXCuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 22:50:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32267 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229759AbhFXCuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 22:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624502912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0oGgPEcoD4ONx9/UCCyiySHgdVual9P5TWTD0oYSIj8=;
        b=Iwt1iEpUYtL+Ex60Dhrz5/TgW5QWV/JxcztXMkBeLB7E59W52Z27k3prznOILLge6o+kVR
        oCb3Pz/ZPPNoUDF8O29mHJxLSif6HwRzUcazTIYn6QVjM7377qD3xBFf2FrGkgxEaQD9eE
        kbUoGtL7pZPB039PBvNWxykNDvRYdhM=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-_OgjrWGvMdajFL7ozw0FLQ-1; Wed, 23 Jun 2021 22:48:30 -0400
X-MC-Unique: _OgjrWGvMdajFL7ozw0FLQ-1
Received: by mail-oo1-f70.google.com with SMTP id n13-20020a4ae1cd0000b029024af40d0cc4so2851082oot.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 19:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=0oGgPEcoD4ONx9/UCCyiySHgdVual9P5TWTD0oYSIj8=;
        b=WVJnpjtoNh4s/c12VgziDX7fzmUwKx8JxXATUY7Jju4CgRsmysfm83pvvrPI7r2yyL
         cvjeAetn3k9k9Neq5VcqCz8BBsR0JwMP2yW7MrtAtrHsEzGilWrURbHGxj+VTVM/615D
         m3yRP67s0lGZc3b7XmG2i53IYQnDj44AFN+4AMJ31tod3aJgTqZVh5K4VrH0zHD+W9hS
         ZYo/kNI5b/nVztFHNECVyaL/NCC09ipsJQiY3mzcG8wlt9UAOeJxKf4askynK5XCjYf1
         TeYoQgnNqdqg7s53/jC8e0wy8MqlNiFvjY5cCPK0IUKADp09a6wTct5yPXbs844I0hX5
         6ofg==
X-Gm-Message-State: AOAM530NtYx3uX+649WSM7wIpeP2VzjaI+Ey0+wsAmYcNmA4cd8xwP++
        jEgSYC4udDysKkHhC9Ym517Z1Fmj7ZVHbY0NZtjFKhMbrlYW3LxMOY1YvZIOeVYsKiYj3o4q9KK
        c7OTe8CcHGjY3cBAtsmqr14Cv
X-Received: by 2002:aca:e107:: with SMTP id y7mr5708900oig.11.1624502910104;
        Wed, 23 Jun 2021 19:48:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5cb15OSczinwDBZ0eLJUKGUzdOAvDD3cFOqNVD6Kdn+fqQHTToQViMwWLwXFOh+ZGRnRF1w==
X-Received: by 2002:aca:e107:: with SMTP id y7mr5708885oig.11.1624502909883;
        Wed, 23 Jun 2021 19:48:29 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id y7sm396157oti.80.2021.06.23.19.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 19:48:29 -0700 (PDT)
Date:   Wed, 23 Jun 2021 20:48:28 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Tian\, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Dey\, Megha" <megha.dey@intel.com>,
        "Raj\, Ashok" <ashok.raj@intel.com>,
        "Pan\, Jacob jun" <jacob.jun.pan@intel.com>,
        "Jiang\, Dave" <dave.jiang@intel.com>,
        "Liu\, Yi L" <yi.l.liu@intel.com>,
        "Lu\, Baolu" <baolu.lu@intel.com>,
        "Williams\, Dan J" <dan.j.williams@intel.com>,
        "Luck\, Tony" <tony.luck@intel.com>,
        "Kumar\, Sanjay K" <sanjay.k.kumar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, KVM <kvm@vger.kernel.org>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: Virtualizing MSI-X on IMS via VFIO
Message-ID: <20210623204828.2bc7e6dc.alex.williamson@redhat.com>
In-Reply-To: <87mtrgatqo.ffs@nanos.tec.linutronix.de>
References: <20210622131217.76b28f6f.alex.williamson@redhat.com>
        <87o8bxcuxv.ffs@nanos.tec.linutronix.de>
        <20210623091935.3ab3e378.alex.williamson@redhat.com>
        <MWHPR11MB18864420ACE88E060203F7818C079@MWHPR11MB1886.namprd11.prod.outlook.com>
        <87mtrgatqo.ffs@nanos.tec.linutronix.de>
Organization: Red Hat
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2021 04:20:31 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> Kevin,
> 
> thank you very much for digging into this! You made my day!
> 
> On Thu, Jun 24 2021 at 00:00, Kevin Tian wrote:
> >> From: Alex Williamson <alex.williamson@redhat.com>
> >> To work with what we've got, the vfio API describes the limitation of
> >> the host interfaces via the VFIO_IRQ_INFO_NORESIZE flag.  QEMU then
> >> makes a choice in an attempt to better reflect what we can infer of the
> >> guest programming of the device to incrementally enable vectors.  We  
> >
> > It's a surprise to me that Qemu even doesn't look at this flag today after
> > searching its code...  
> 
> Indeed.
> 
> git clone https://github.com/qemu/qemu.git
> cd qemu
> git log -p | grep NORESIZE
> + * The NORESIZE flag indicates that the interrupt lines within the index
> +#define VFIO_IRQ_INFO_NORESIZE		(1 << 3)
> 
> According to the git history of QEMU this was never used at all and I
> don't care about the magic muck which might be in some RHT repository
> which might make use of that.
> 
> Find below the proper fix for this nonsense which just wasted everyones
> time. I'll post it officialy with a proper changelog tomorrow unless
> Kevin beats me to it who actually unearthed this and surely earns the
> credit.
> 
> Alex, I seriously have to ask what you were trying to tell us about this
> flag and it's great value and the design related to this.
> 
> I'm sure you can submit the corresponding fix to qemu yourself.
> 
> And once you are back from lala land, can you please explain how
> VFIO/PCI/MSIX is supposed to work in reality?

It's part of the spec, there's never been a case of !NORESIZE, assuming
NORESIZE is the safe behavior.  Sorry, there's no smoking gun here, NAK

> ---
> --- a/drivers/gpu/drm/i915/gvt/kvmgt.c
> +++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
> @@ -1644,8 +1644,6 @@ static long intel_vgpu_ioctl(struct mdev
>  		if (info.index == VFIO_PCI_INTX_IRQ_INDEX)
>  			info.flags |= (VFIO_IRQ_INFO_MASKABLE |
>  				       VFIO_IRQ_INFO_AUTOMASKED);
> -		else
> -			info.flags |= VFIO_IRQ_INFO_NORESIZE;
>  
>  		return copy_to_user((void __user *)arg, &info, minsz) ?
>  			-EFAULT : 0;
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -1018,8 +1018,6 @@ static long vfio_pci_ioctl(struct vfio_d
>  		if (info.index == VFIO_PCI_INTX_IRQ_INDEX)
>  			info.flags |= (VFIO_IRQ_INFO_MASKABLE |
>  				       VFIO_IRQ_INFO_AUTOMASKED);
> -		else
> -			info.flags |= VFIO_IRQ_INFO_NORESIZE;
>  
>  		return copy_to_user((void __user *)arg, &info, minsz) ?
>  			-EFAULT : 0;
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -693,16 +693,6 @@ struct vfio_region_info_cap_nvlink2_lnks
>   * automatically masked by VFIO and the user needs to unmask the line
>   * to receive new interrupts.  This is primarily intended to distinguish
>   * level triggered interrupts.
> - *
> - * The NORESIZE flag indicates that the interrupt lines within the index
> - * are setup as a set and new subindexes cannot be enabled without first
> - * disabling the entire index.  This is used for interrupts like PCI MSI
> - * and MSI-X where the driver may only use a subset of the available
> - * indexes, but VFIO needs to enable a specific number of vectors
> - * upfront.  In the case of MSI-X, where the user can enable MSI-X and
> - * then add and unmask vectors, it's up to userspace to make the decision
> - * whether to allocate the maximum supported number of vectors or tear
> - * down setup and incrementally increase the vectors as each is enabled.
>   */
>  struct vfio_irq_info {
>  	__u32	argsz;
> @@ -710,7 +700,6 @@ struct vfio_irq_info {
>  #define VFIO_IRQ_INFO_EVENTFD		(1 << 0)
>  #define VFIO_IRQ_INFO_MASKABLE		(1 << 1)
>  #define VFIO_IRQ_INFO_AUTOMASKED	(1 << 2)
> -#define VFIO_IRQ_INFO_NORESIZE		(1 << 3)
>  	__u32	index;		/* IRQ index */
>  	__u32	count;		/* Number of IRQs within this index */
>  };
> --- a/samples/vfio-mdev/mtty.c
> +++ b/samples/vfio-mdev/mtty.c
> @@ -1092,9 +1092,6 @@ static int mtty_get_irq_info(struct mdev
>  	if (irq_info->index == VFIO_PCI_INTX_IRQ_INDEX)
>  		irq_info->flags |= (VFIO_IRQ_INFO_MASKABLE |
>  				VFIO_IRQ_INFO_AUTOMASKED);
> -	else
> -		irq_info->flags |= VFIO_IRQ_INFO_NORESIZE;
> -
>  	return 0;
>  }
>  
> 

