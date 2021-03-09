Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A88332EFC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 20:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhCIT0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 14:26:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55914 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231197AbhCIT0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 14:26:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615317973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ie/zBOys7oevTegcdriKKRKYfpe93c9I/vD8unRIik=;
        b=bcoDTFvVTuMbQPlEra1JEo7LlYzA+w5W50FgrzRX4kbU3Uoh30ncmx1gNG7Bus/3cINFOq
        AWdRSxjHnHX7CsXfn28OEQeQAk9m0fT4IjdODn0fdhL4JmmFvzA7rdxvt4KYt/ZBvgcbGg
        fIK4e0yDGjq6ambFsIaISAHr/Xnh9lc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-1aCeoGM6P6udNG46NEfJuA-1; Tue, 09 Mar 2021 14:26:11 -0500
X-MC-Unique: 1aCeoGM6P6udNG46NEfJuA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E64C4801817;
        Tue,  9 Mar 2021 19:26:08 +0000 (UTC)
Received: from omen.home.shazbot.org (ovpn-112-255.phx2.redhat.com [10.3.112.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A98F360C13;
        Tue,  9 Mar 2021 19:26:07 +0000 (UTC)
Date:   Tue, 9 Mar 2021 12:26:07 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Michel Lespinasse <walken@google.com>,
        Jann Horn <jannh@google.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH] vfio/pci: make the vfio_pci_mmap_fault reentrant
Message-ID: <20210309122607.0b68fb9b@omen.home.shazbot.org>
In-Reply-To: <20210309184739.GD763132@xz-x1>
References: <1615201890-887-1-git-send-email-prime.zeng@hisilicon.com>
        <20210308132106.49da42e2@omen.home.shazbot.org>
        <20210308225626.GN397383@xz-x1>
        <6b98461600f74f2385b9096203fa3611@hisilicon.com>
        <20210309124609.GG2356281@nvidia.com>
        <20210309082951.75f0eb01@x1.home.shazbot.org>
        <20210309164004.GJ2356281@nvidia.com>
        <20210309184739.GD763132@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Mar 2021 13:47:39 -0500
Peter Xu <peterx@redhat.com> wrote:

> On Tue, Mar 09, 2021 at 12:40:04PM -0400, Jason Gunthorpe wrote:
> > On Tue, Mar 09, 2021 at 08:29:51AM -0700, Alex Williamson wrote:  
> > > On Tue, 9 Mar 2021 08:46:09 -0400
> > > Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >   
> > > > On Tue, Mar 09, 2021 at 03:49:09AM +0000, Zengtao (B) wrote:  
> > > > > Hi guys:
> > > > > 
> > > > > Thanks for the helpful comments, after rethinking the issue, I have proposed
> > > > >  the following change: 
> > > > > 1. follow_pte instead of follow_pfn.    
> > > > 
> > > > Still no on follow_pfn, you don't need it once you use vmf_insert_pfn  
> > > 
> > > vmf_insert_pfn() only solves the BUG_ON, follow_pte() is being used
> > > here to determine whether the translation is already present to avoid
> > > both duplicate work in inserting the translation and allocating a
> > > duplicate vma tracking structure.  
> >  
> > Oh.. Doing something stateful in fault is not nice at all
> > 
> > I would rather see __vfio_pci_add_vma() search the vma_list for dups
> > than call follow_pfn/pte..  
> 
> It seems to me that searching vma list is still the simplest way to fix the
> problem for the current code base.  I see io_remap_pfn_range() is also used in
> the new series - maybe that'll need to be moved to where PCI_COMMAND_MEMORY got
> turned on/off in the new series (I just noticed remap_pfn_range modifies vma
> flags..), as you suggested in the other email.


In the new series, I think the fault handler becomes (untested):

static vm_fault_t vfio_pci_mmap_fault(struct vm_fault *vmf)
{
        struct vm_area_struct *vma = vmf->vma;
        struct vfio_pci_device *vdev = vma->vm_private_data;
        unsigned long base_pfn, pgoff;
        vm_fault_t ret = VM_FAULT_SIGBUS;

        if (vfio_pci_bar_vma_to_pfn(vma, &base_pfn))
                return ret;

        pgoff = (vmf->address - vma->vm_start) >> PAGE_SHIFT;

        down_read(&vdev->memory_lock);

        if (__vfio_pci_memory_enabled(vdev))
                ret = vmf_insert_pfn(vma, vmf->address, pgoff + base_pfn);

        up_read(&vdev->memory_lock);

        return ret;
}

Thanks,
Alex

