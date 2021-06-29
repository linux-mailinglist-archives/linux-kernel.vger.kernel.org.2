Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8013B7402
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 16:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbhF2OO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 10:14:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31278 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229933AbhF2OO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 10:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624975919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cTj2GaDcZWU+j1tFujIoAWfLdhmvczFyfCMnUSaow60=;
        b=FXyEV6fNlBOgVwWXPtANQOe8bLsrdqo9DeXQ1YpLvs+UsrOM+rhvRFe6UZHJ/8YN4P4VPc
        IiYwSRQJt8dd3MyEeAEFFafW8x285V1bn4cWOFt+L7HYIE44mOUGFbCJ54pkM3hDYsXa+6
        K3Fw5EZSrpx0UipxVO5fE7YPX2/51Ng=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370--8UK3HJgP3qeEkHQNjEcaQ-1; Tue, 29 Jun 2021 10:11:58 -0400
X-MC-Unique: -8UK3HJgP3qeEkHQNjEcaQ-1
Received: by mail-oo1-f71.google.com with SMTP id x24-20020a4a9b980000b0290249d5c08dd6so13694562ooj.15
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 07:11:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=cTj2GaDcZWU+j1tFujIoAWfLdhmvczFyfCMnUSaow60=;
        b=YSv88BHpZC1PYlBZuX6dLGWaWviXBijqYitNvuWbJ6yGHMUOUh/LY8NOMT2pmqv2qi
         H7zeb8X+vZlKt0TRi534ssYnWmYNtn9pPqRxFa4AY4GbtlgBdfxfTZpwylrZuTs9TXW2
         CVCfA7ZEz//hV0o2xfV09R2MtPhF/mfOgcy9Fby5Ty57Y/yoAp2eHk3f5PwJpemEnSNU
         FqpypufaBncgLVU1YvJhyhNzqbv7H2PibsG57hoLrBmIEh7I3O0T8kJgMOyiqTYYkQH8
         rUTsV2MxJCHZrRTm8RZa7Ki6zxJ8aZfeJacjh/8fFtqGqlySBXfUjkmnjzaaoXU3xzQK
         SRFQ==
X-Gm-Message-State: AOAM532kAcl+PUCO581znID2u0AIn3+Yyg5wnGbUaDWcbFQAuhRIjSRk
        1vtFYsrhucQIpH9JcPlj0kHdLdk/ZGbStFLNG6xuB4Ht/z+n6nS07cKCUE7fq4k0Phru2WkWUlK
        1Q6lOQfIrADaS7df/nat2W+Kf
X-Received: by 2002:a05:6830:270b:: with SMTP id j11mr4577550otu.161.1624975917392;
        Tue, 29 Jun 2021 07:11:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2rdsO1Tev2pNOU7Zy06AyW3UxdRYtpunjftoMW9xLPyqwnP6SAQPAKIyjjtXZU7CLtWs9BA==
X-Received: by 2002:a05:6830:270b:: with SMTP id j11mr4577530otu.161.1624975917147;
        Tue, 29 Jun 2021 07:11:57 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id bb34sm2229071oob.39.2021.06.29.07.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 07:11:56 -0700 (PDT)
Date:   Tue, 29 Jun 2021 08:11:54 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterx@redhat.com, prime.zeng@hisilicon.com, cohuck@redhat.com
Subject: Re: [PATCH v2] vfio/pci: Handle concurrent vma faults
Message-ID: <20210629081154.2345fbe0.alex.williamson@redhat.com>
In-Reply-To: <20210628232625.GM4459@nvidia.com>
References: <161540257788.10151.6284852774772157400.stgit@gimli.home>
        <20210628104653.4ca65921.alex.williamson@redhat.com>
        <20210628173028.GF4459@nvidia.com>
        <20210628123621.7fd36a1b.alex.williamson@redhat.com>
        <20210628185242.GI4459@nvidia.com>
        <20210628133019.6a246fec.alex.williamson@redhat.com>
        <20210628232625.GM4459@nvidia.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2021 20:26:25 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Jun 28, 2021 at 01:30:19PM -0600, Alex Williamson wrote:
> > On Mon, 28 Jun 2021 15:52:42 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >   
> > > On Mon, Jun 28, 2021 at 12:36:21PM -0600, Alex Williamson wrote:  
> > > > On Mon, 28 Jun 2021 14:30:28 -0300
> > > > Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > >     
> > > > > On Mon, Jun 28, 2021 at 10:46:53AM -0600, Alex Williamson wrote:    
> > > > > > On Wed, 10 Mar 2021 11:58:07 -0700
> > > > > > Alex Williamson <alex.williamson@redhat.com> wrote:
> > > > > >       
> > > > > > > vfio_pci_mmap_fault() incorrectly makes use of io_remap_pfn_range()
> > > > > > > from within a vm_ops fault handler.  This function will trigger a
> > > > > > > BUG_ON if it encounters a populated pte within the remapped range,
> > > > > > > where any fault is meant to populate the entire vma.  Concurrent
> > > > > > > inflight faults to the same vma will therefore hit this issue,
> > > > > > > triggering traces such as:      
> > > > > 
> > > > > If it is just about concurrancy can the vma_lock enclose
> > > > > io_remap_pfn_range() ?    
> > > > 
> > > > We could extend vma_lock around io_remap_pfn_range(), but that alone
> > > > would just block the concurrent faults to the same vma and once we
> > > > released them they'd still hit the BUG_ON in io_remap_pfn_range()
> > > > because the page is no longer pte_none().  We'd need to combine that
> > > > with something like __vfio_pci_add_vma() returning -EEXIST to skip the
> > > > io_remap_pfn_range(), but I've been advised that we shouldn't be
> > > > calling io_remap_pfn_range() from within the fault handler anyway, we
> > > > should be using something like vmf_insert_pfn() instead, which I
> > > > understand can be called safely in the same situation.  That's rather
> > > > the testing I was hoping someone who reproduced the issue previously
> > > > could validate.    
> > > 
> > > Yes, using the vmf_ stuff is 'righter' for sure, but there isn't
> > > really a vmf for IO mappings..
> > >   
> > > > > I assume there is a reason why vm_lock can't be used here, so I
> > > > > wouldn't object, though I don't especially like the loss of tracking
> > > > > either.    
> > > > 
> > > > There's no loss of tracking here, we were only expecting a single fault
> > > > per vma to add the vma to our list.  This just skips adding duplicates
> > > > in these cases where we can have multiple faults in-flight.  Thanks,    
> > > 
> > > I mean the arch tracking of IO maps that is hidden inside ioremap_pfn  
> > 
> > Ok, so I take it you'd feel more comfortable with something like this,
> > right?  Thanks,  
> 
> I think so, it doesn't abuse the arch code, but it does abuse not
> using vmf_* in a fault handler.
> 
> > index 759dfb118712..74fc66cf9cf4 100644
> > +++ b/drivers/vfio/pci/vfio_pci.c
> > @@ -1584,6 +1584,7 @@ static vm_fault_t vfio_pci_mmap_fault(struct vm_fault *vmf)
> >  {
> >  	struct vm_area_struct *vma = vmf->vma;
> >  	struct vfio_pci_device *vdev = vma->vm_private_data;
> > +	struct vfio_pci_mmap_vma *mmap_vma;
> >  	vm_fault_t ret = VM_FAULT_NOPAGE;
> >  
> >  	mutex_lock(&vdev->vma_lock);
> > @@ -1591,24 +1592,33 @@ static vm_fault_t vfio_pci_mmap_fault(struct vm_fault *vmf)
> >  
> >  	if (!__vfio_pci_memory_enabled(vdev)) {
> >  		ret = VM_FAULT_SIGBUS;
> > -		mutex_unlock(&vdev->vma_lock);
> >  		goto up_out;
> >  	}
> >  
> > -	if (__vfio_pci_add_vma(vdev, vma)) {
> > -		ret = VM_FAULT_OOM;
> > -		mutex_unlock(&vdev->vma_lock);
> > -		goto up_out;  
> 
> 
> > +	/*
> > +	 * Skip existing vmas, assume concurrent in-flight faults to avoid
> > +	 * BUG_ON from io_remap_pfn_range() hitting !pte_none() pages.
> > +	 */
> > +	list_for_each_entry(mmap_vma, &vdev->vma_list, vma_next) {
> > +		if (mmap_vma->vma == vma)
> > +			goto up_out;
> >  	}
> >  
> > -	mutex_unlock(&vdev->vma_lock);
> > -
> >  	if (io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
> > -			       vma->vm_end - vma->vm_start, vma->vm_page_prot))
> > +			       vma->vm_end - vma->vm_start,
> > +			       vma->vm_page_prot)) {
> >  		ret = VM_FAULT_SIGBUS;
> > +		goto up_out;
> > +	}  
> 
> I suppose io_remap_pfn_range can fail inside after partially
> populating the range, ie if it fails to allocate another pte table or
> something.
> 
> Since partial allocations are not allowed we'd have to zap it here
> too.

Yup, easy enough.
 
> I suppose the other idea is to do the io_remap_pfn_range() when the
> mmap becomes valid and the zap when it becomes invalid and just have
> the fault handler always fail. That way we don't abuse anything.

That's coming, but it's a more substantial change, I'd rather fix this
within the current framework first.

> Was there some tricky locking reason why this didn't work? Does it get
> better with the address_space?

Yes it does, we can create the reverse of unmmap_mapping_range() using
the address space solution, which hugely simplifies zapping and
re-inserting BAR mappings.  This has been stalled due to lack of time
to work out the notifier issues for dropping IOMMU mappings, but it
also stands on its own, so I'll see if I can get that far in the series
reposted.  v3 w/ zap on io_remap_pfn_range() error path coming.  Thanks,

Alex

