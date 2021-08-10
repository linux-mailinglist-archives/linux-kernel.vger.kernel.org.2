Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706D33E7BA8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 17:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242556AbhHJPEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 11:04:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33577 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241246AbhHJPEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628607847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=saDSmbq1KyQ846SiUJnNdk6f6G6MN7+bgqLynbPPajY=;
        b=ToejtRUQPvNc8sJTdHkCNIL71YLPUo6sSveCPWHocY5gcLGMj7rN8ICmqqe1WCj/IO1bYY
        Uv2V47cDGLCsrbzU7g6RXazZS6imh/bTbKjf6qITgtQqEfqMw1KLi9Zw5KqjJn2uBuz/LU
        /1KREvFL2fwxCn01vJcAghopokxYYwY=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-HcZwE0PEN2meg930QJMF7Q-1; Tue, 10 Aug 2021 11:04:04 -0400
X-MC-Unique: HcZwE0PEN2meg930QJMF7Q-1
Received: by mail-oo1-f71.google.com with SMTP id k18-20020a4a94920000b029026767722880so7485263ooi.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 08:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=saDSmbq1KyQ846SiUJnNdk6f6G6MN7+bgqLynbPPajY=;
        b=EI/2E4A0R9ubrBGpx5KudtPqxkOgVxvMMpZrOwaU0qssc0l+Gsv0xpOM57XT7isoAB
         5XmM0PT7S4pvwSpuixE/uNkKuR4fgOSg/OdsVTshR/dR7IIW1tc/tGwQ7VUpGjSI81VW
         yTpM2z7evrm/dgqhxPQ7Hz4PnVgowPQd44KJJhprS5cBghTclJbATSVezXygp2qw4g0P
         1bqiWQjNw4MmWpd37qT6i9zSyMdTOfjBeGgQqJzDsXP11u+RKSjKj5/ufBFCSgUPejMb
         H9/9q3zVKXu7V4/J13i7KrjyzkEBg+QcRVcFFLmWFY+v6DYwJCTa/Cg3MLiBZ0n+ytQp
         gFwQ==
X-Gm-Message-State: AOAM530VQCnSD74ckNihdKfua2ExGLAWeBe68E5GrjUo7yMrOpLCSZt5
        t6rFSS0yxjGl/dBSOutkpt6pfeHnN+PQ88lsLfZBlTNuzyUj97SnYwU9euTUpJttATKZQIecTUL
        BlVmb2c1r01vu+NvYhGlRJYa1
X-Received: by 2002:a9d:4e03:: with SMTP id p3mr20862110otf.214.1628607843794;
        Tue, 10 Aug 2021 08:04:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwa8NsTflJyoCSB3QzQu/ldQGo0dEw8Tvkv48rIc4s6fH1Ji0z48X8Eqi491aAosuf+mgaKlg==
X-Received: by 2002:a9d:4e03:: with SMTP id p3mr20862079otf.214.1628607843599;
        Tue, 10 Aug 2021 08:04:03 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id w13sm2037036otl.41.2021.08.10.08.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 08:04:03 -0700 (PDT)
Date:   Tue, 10 Aug 2021 09:04:02 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, peterx@redhat.com
Subject: Re: [PATCH 7/7] vfio/pci: Remove map-on-fault behavior
Message-ID: <20210810090402.0a120276.alex.williamson@redhat.com>
In-Reply-To: <YRJC1buKp67kGemh@infradead.org>
References: <162818167535.1511194.6614962507750594786.stgit@omen>
        <162818330190.1511194.10498114924408843888.stgit@omen>
        <YRJC1buKp67kGemh@infradead.org>
Organization: Red Hat
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2021 11:11:49 +0200
Christoph Hellwig <hch@infradead.org> wrote:

> On Thu, Aug 05, 2021 at 11:08:21AM -0600, Alex Williamson wrote:
> > +void vfio_pci_test_and_up_write_memory_lock(struct vfio_pci_device *vdev)
> > +{
> > +	if (vdev->zapped_bars && __vfio_pci_memory_enabled(vdev)) {
> > +		WARN_ON(vfio_device_io_remap_mapping_range(&vdev->vdev,
> > +			VFIO_PCI_INDEX_TO_OFFSET(VFIO_PCI_BAR0_REGION_INDEX),
> > +			VFIO_PCI_INDEX_TO_OFFSET(VFIO_PCI_ROM_REGION_INDEX) -
> > +			VFIO_PCI_INDEX_TO_OFFSET(VFIO_PCI_BAR0_REGION_INDEX)));
> > +		vdev->zapped_bars = false;  
> 
> Doing actual work inside a WARN_ON is pretty nasty.  Also the non-ONCE
> version here will lead to massive log splatter if it actually hits.
> 
> I'd prefer something like:
> 
> 	loff_t start = VFIO_PCI_INDEX_TO_OFFSET(VFIO_PCI_BAR0_REGION_INDEX);
> 	loff_t end = VFIO_PCI_INDEX_TO_OFFSET(VFIO_PCI_ROM_REGION_INDEX);
> 
> 	if (vdev->zapped_bars && __vfio_pci_memory_enabled(vdev)) {
> 		if (!vfio_device_io_remap_mapping_range(&vdev->vdev, start,
> 				end - start))
> 			vdev->zapped_bars = false;
> 		WARN_ON_ONCE(vdev->zapped_bars);
> 
> >  	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> > -	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);  
> 
> What is the story with this appearing earlier and disappearing here
> again?

We switched from io_remap_pfn_range() which includes this flag
implicitly, to vmf_insert_pfn() which does not, and back to
io_remap_pfn_range() when the fault handler is removed.

> > +extern void vfio_pci_test_and_up_write_memory_lock(struct vfio_pci_device
> > +						   *vdev);  
> 
> No need for the extern.

Thanks much for the reviews!

Alex

