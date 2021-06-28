Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C973B691D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 21:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236588AbhF1Tcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 15:32:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22969 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236582AbhF1Tcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 15:32:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624908625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4aDinynGafajdrFAUt+N4CTx5HYHFQkR8BqRweQ4D0Y=;
        b=VlaJGig4ONJLrG+56SBCFW1YavqbjQO7Ww92zq9VnyT4AfnM/UXYnq3oRIgmlFp8eEAvTg
        HyEsosGx5xjiivcfQ96RPgsgeC/nrZdBVX+nptr6NJH2cBaomBkxqbH2KPL9OIoChrgdUX
        Q2ggsAruCx7G8omBSGeOPLkpDUUkmkE=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-dID1gGYOPbybFZzsQdNh8w-1; Mon, 28 Jun 2021 15:30:21 -0400
X-MC-Unique: dID1gGYOPbybFZzsQdNh8w-1
Received: by mail-oo1-f71.google.com with SMTP id b9-20020a4a87890000b0290248cb841124so12249454ooi.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 12:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4aDinynGafajdrFAUt+N4CTx5HYHFQkR8BqRweQ4D0Y=;
        b=BBSCsea2aK3b2kTX8DpwPIIlX9rD7X854+EJUQza/D/v5GzbbwEJAZRShKDnY0RheL
         GcoqZoV+6XZ90sVodN63rMypChFsc8mD9RNhc4CWMg+pQAoqSdG4Zpx2l5lm/vpwEEin
         so7bxGAngodPk0Z76vfeYFtX3nVQko/7iva33aRyhyG6g9tx4gNMFdBZagJNuqSwUcI/
         pJp00qXm7Ra6JmZndftKole87r8CwJTMDKvs4s8UvFzMHWObPJq5LPy/xHsZz9fGzix7
         hTaXWzFy57t1MUbxiPNSF8uqwAecjEQv3DZDt58H9eW0NYEFhdpMu3H2bKkqjhPBx2xl
         AgzA==
X-Gm-Message-State: AOAM531KUrIijwMLwjCqqFYD3H/PG4bdr4px8nOQbUpcRAO/d76iBkxg
        7mxA2Sa45nRRYkmMHzHEwARz4xKplRQpJgFfO2q5xFAEMFAdlO/UNqu3qInZK6g5wJP2XTI4FcP
        BiF0pu5BJx97UzXeEiZXFaVoq
X-Received: by 2002:a54:4f99:: with SMTP id g25mr22137013oiy.132.1624908620954;
        Mon, 28 Jun 2021 12:30:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHkDsJ/vlm84kWczYHiEPW2vUWVs3lqbZWoF2KSYi5CmBFOLj4QzsAch5CX8CfxouV5F4pOg==
X-Received: by 2002:a54:4f99:: with SMTP id g25mr22137005oiy.132.1624908620753;
        Mon, 28 Jun 2021 12:30:20 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id y11sm1245357oto.28.2021.06.28.12.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 12:30:20 -0700 (PDT)
Date:   Mon, 28 Jun 2021 13:30:19 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterx@redhat.com, prime.zeng@hisilicon.com, cohuck@redhat.com
Subject: Re: [PATCH v2] vfio/pci: Handle concurrent vma faults
Message-ID: <20210628133019.6a246fec.alex.williamson@redhat.com>
In-Reply-To: <20210628185242.GI4459@nvidia.com>
References: <161540257788.10151.6284852774772157400.stgit@gimli.home>
        <20210628104653.4ca65921.alex.williamson@redhat.com>
        <20210628173028.GF4459@nvidia.com>
        <20210628123621.7fd36a1b.alex.williamson@redhat.com>
        <20210628185242.GI4459@nvidia.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2021 15:52:42 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Jun 28, 2021 at 12:36:21PM -0600, Alex Williamson wrote:
> > On Mon, 28 Jun 2021 14:30:28 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >   
> > > On Mon, Jun 28, 2021 at 10:46:53AM -0600, Alex Williamson wrote:  
> > > > On Wed, 10 Mar 2021 11:58:07 -0700
> > > > Alex Williamson <alex.williamson@redhat.com> wrote:
> > > >     
> > > > > vfio_pci_mmap_fault() incorrectly makes use of io_remap_pfn_range()
> > > > > from within a vm_ops fault handler.  This function will trigger a
> > > > > BUG_ON if it encounters a populated pte within the remapped range,
> > > > > where any fault is meant to populate the entire vma.  Concurrent
> > > > > inflight faults to the same vma will therefore hit this issue,
> > > > > triggering traces such as:    
> > > 
> > > If it is just about concurrancy can the vma_lock enclose
> > > io_remap_pfn_range() ?  
> > 
> > We could extend vma_lock around io_remap_pfn_range(), but that alone
> > would just block the concurrent faults to the same vma and once we
> > released them they'd still hit the BUG_ON in io_remap_pfn_range()
> > because the page is no longer pte_none().  We'd need to combine that
> > with something like __vfio_pci_add_vma() returning -EEXIST to skip the
> > io_remap_pfn_range(), but I've been advised that we shouldn't be
> > calling io_remap_pfn_range() from within the fault handler anyway, we
> > should be using something like vmf_insert_pfn() instead, which I
> > understand can be called safely in the same situation.  That's rather
> > the testing I was hoping someone who reproduced the issue previously
> > could validate.  
> 
> Yes, using the vmf_ stuff is 'righter' for sure, but there isn't
> really a vmf for IO mappings..
> 
> > > I assume there is a reason why vm_lock can't be used here, so I
> > > wouldn't object, though I don't especially like the loss of tracking
> > > either.  
> > 
> > There's no loss of tracking here, we were only expecting a single fault
> > per vma to add the vma to our list.  This just skips adding duplicates
> > in these cases where we can have multiple faults in-flight.  Thanks,  
> 
> I mean the arch tracking of IO maps that is hidden inside ioremap_pfn

Ok, so I take it you'd feel more comfortable with something like this,
right?  Thanks,

Alex

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 759dfb118712..74fc66cf9cf4 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -1584,6 +1584,7 @@ static vm_fault_t vfio_pci_mmap_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct vfio_pci_device *vdev = vma->vm_private_data;
+	struct vfio_pci_mmap_vma *mmap_vma;
 	vm_fault_t ret = VM_FAULT_NOPAGE;
 
 	mutex_lock(&vdev->vma_lock);
@@ -1591,24 +1592,33 @@ static vm_fault_t vfio_pci_mmap_fault(struct vm_fault *vmf)
 
 	if (!__vfio_pci_memory_enabled(vdev)) {
 		ret = VM_FAULT_SIGBUS;
-		mutex_unlock(&vdev->vma_lock);
 		goto up_out;
 	}
 
-	if (__vfio_pci_add_vma(vdev, vma)) {
-		ret = VM_FAULT_OOM;
-		mutex_unlock(&vdev->vma_lock);
-		goto up_out;
+	/*
+	 * Skip existing vmas, assume concurrent in-flight faults to avoid
+	 * BUG_ON from io_remap_pfn_range() hitting !pte_none() pages.
+	 */
+	list_for_each_entry(mmap_vma, &vdev->vma_list, vma_next) {
+		if (mmap_vma->vma == vma)
+			goto up_out;
 	}
 
-	mutex_unlock(&vdev->vma_lock);
-
 	if (io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
-			       vma->vm_end - vma->vm_start, vma->vm_page_prot))
+			       vma->vm_end - vma->vm_start,
+			       vma->vm_page_prot)) {
 		ret = VM_FAULT_SIGBUS;
+		goto up_out;
+	}
+
+	if (__vfio_pci_add_vma(vdev, vma)) {
+		ret = VM_FAULT_OOM;
+		zap_vma_ptes(vma, vma->vm_start, vma->vm_end - vma->vm_start);
+	}
 
 up_out:
 	up_read(&vdev->memory_lock);
+	mutex_unlock(&vdev->vma_lock);
 	return ret;
 }
 

