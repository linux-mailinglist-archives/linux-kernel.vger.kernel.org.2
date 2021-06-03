Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECBCC39AD0F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 23:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhFCVp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 17:45:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51432 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229656AbhFCVp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 17:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622756651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eB4AhoVRrohLIXm7A6phxopY9UW47sYoDfPiWiAbtu4=;
        b=SEFPUDaYQOB8oLt/FpTRVgR83g7u+3LpTQeV7CY2u9HxBYnfrVOlB5cyV1CSkI7MgHZ1Wm
        UdN9rPpeEGKeAs+CCvvxsUtXpllfMHW0AMlzpp8Xq/7SRBUhG6EorHm76PX+hUzzJ2zelz
        TWbDUf6I8EFu2xD8xLWrB6HUnj4Tq9M=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-OVxauzrvO-mle0F9cctUCw-1; Thu, 03 Jun 2021 17:44:09 -0400
X-MC-Unique: OVxauzrvO-mle0F9cctUCw-1
Received: by mail-ot1-f70.google.com with SMTP id f18-20020a0568303092b02903a7896a597aso3908055ots.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 14:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eB4AhoVRrohLIXm7A6phxopY9UW47sYoDfPiWiAbtu4=;
        b=QRPF4GNjMy6wjp+9BabkL4XuGA557QUgKd0PVjAOIMhUveHve79E3S84yiE8ac/iyv
         oUUtJkvZP+Dc4pC4Vu8K3ag/xSKtccQcE0kiqzx31qWwYMtsT6yT1+L5Ejyp75TIHAQV
         6SvkUrKvcbtQFm3N9NKKf3VBNETYUuBQ99CnY2+rSkrh77bRIybGhnz1oe1Q0DTy84Ty
         MTmgf9OGQNfIVNNukCNNR/kgsRGEkNQw7tDS6BWsytKUdU1eh/DpRt23DpkpOAaVQDzS
         +bsFuR/P33fauYHDUucol8NScbg1aoGkC55r2D5PZC71busI1q6i39trUX2oA/HgmG96
         Zjzg==
X-Gm-Message-State: AOAM530DtfO06PTfECtBVQS7mndlh/ERxjqhN3xtKLvNoNzZP+6Ysb0X
        XDo+xs9cZXKvuhjBB9g9x5iHDtIEbxomp2lRaTgSmm9Q47UMymwf99bl1Jxp0DRbuRkfYRKoQWV
        eKRnkV9D9gUEN24q+fx4Zqe6g
X-Received: by 2002:aca:4a82:: with SMTP id x124mr278759oia.43.1622756649102;
        Thu, 03 Jun 2021 14:44:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyi8xD8sEnXgrgCImoMdW6AHQMJ9dR5bHs140AA+++p7Oa6zepOjpqKOgFamMGN+pn0ef/UTg==
X-Received: by 2002:aca:4a82:: with SMTP id x124mr278745oia.43.1622756648859;
        Thu, 03 Jun 2021 14:44:08 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id v20sm25134ooe.47.2021.06.03.14.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 14:44:08 -0700 (PDT)
Date:   Thu, 3 Jun 2021 15:44:07 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Robin Murphy <robin.murphy@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210603154407.6fe33880.alex.williamson@redhat.com>
In-Reply-To: <20210603201018.GF1002214@nvidia.com>
References: <20210602173510.GE1002214@nvidia.com>
        <20210602120111.5e5bcf93.alex.williamson@redhat.com>
        <20210602180925.GH1002214@nvidia.com>
        <20210602130053.615db578.alex.williamson@redhat.com>
        <20210602195404.GI1002214@nvidia.com>
        <20210602143734.72fb4fa4.alex.williamson@redhat.com>
        <20210602224536.GJ1002214@nvidia.com>
        <20210602205054.3505c9c3.alex.williamson@redhat.com>
        <20210603123401.GT1002214@nvidia.com>
        <20210603140146.5ce4f08a.alex.williamson@redhat.com>
        <20210603201018.GF1002214@nvidia.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2021 17:10:18 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Jun 03, 2021 at 02:01:46PM -0600, Alex Williamson wrote:
> 
> > > > > 1) Mixing IOMMU_CAP_CACHE_COHERENCY and !IOMMU_CAP_CACHE_COHERENCY
> > > > >    domains.
> > > > > 
> > > > >    This doesn't actually matter. If you mix them together then kvm
> > > > >    will turn on wbinvd anyhow, so we don't need to use the DMA_PTE_SNP
> > > > >    anywhere in this VM.
> > > > > 
> > > > >    This if two IOMMU's are joined together into a single /dev/ioasid
> > > > >    then we can just make them both pretend to be
> > > > >    !IOMMU_CAP_CACHE_COHERENCY and both not set IOMMU_CACHE.    
> > > > 
> > > > Yes and no.  Yes, if any domain is !IOMMU_CAP_CACHE_COHERENCY then we
> > > > need to emulate wbinvd, but no we'll use IOMMU_CACHE any time it's
> > > > available based on the per domain support available.  That gives us the
> > > > most consistent behavior, ie. we don't have VMs emulating wbinvd
> > > > because they used to have a device attached where the domain required
> > > > it and we can't atomically remap with new flags to perform the same as
> > > > a VM that never had that device attached in the first place.    
> > > 
> > > I think we are saying the same thing..  
> > 
> > Hrm?  I think I'm saying the opposite of your "both not set
> > IOMMU_CACHE".  IOMMU_CACHE is the mapping flag that enables
> > DMA_PTE_SNP.  Maybe you're using IOMMU_CACHE as the state reported to
> > KVM?  
> 
> I'm saying if we enable wbinvd in the guest then no IOASIDs used by
> that guest need to set DMA_PTE_SNP.

Yes

> If we disable wbinvd in the guest
> then all IOASIDs must enforce DMA_PTE_SNP (or we otherwise guarentee
> no-snoop is not possible).

Yes, but we can't get from one of these to the other atomically wrt to
the device DMA.

> This is not what VFIO does today, but it is a reasonable choice.
> 
> Based on that observation we can say as soon as the user wants to use
> an IOMMU that does not support DMA_PTE_SNP in the guest we can still
> share the IO page table with IOMMUs that do support DMA_PTE_SNP.

If your goal is to prioritize IO page table sharing, sure.  But because
we cannot atomically transition from one to the other, each device is
stuck with the pages tables it has, so the history of the VM becomes a
factor in the performance characteristics.

For example if device {A} is backed by an IOMMU capable of blocking
no-snoop and device {B} is backed by an IOMMU which cannot block
no-snoop, then booting VM1 with {A,B} and later removing device {B}
would result in ongoing wbinvd emulation versus a VM2 only booted with
{A}.

Type1 would use separate IO page tables (domains/ioasids) for these such
that VM1 and VM2 have the same characteristics at the end.

Does this become user defined policy in the IOASID model?  There's
quite a mess of exposing sufficient GET_INFO for an IOASID for the user
to know such properties of the IOMMU, plus maybe we need mapping flags
equivalent to IOMMU_CACHE exposed to the user, preventing sharing an
IOASID that could generate IOMMU faults, etc.

> > > It doesn't solve the problem to connect kvm to AP and kvmgt though  
> > 
> > It does not, we'll probably need a vfio ioctl to gratuitously announce
> > the KVM fd to each device.  I think some devices might currently fail
> > their open callback if that linkage isn't already available though, so
> > it's not clear when that should happen, ie. it can't currently be a
> > VFIO_DEVICE ioctl as getting the device fd requires an open, but this
> > proposal requires some availability of the vfio device fd without any
> > setup, so presumably that won't yet call the driver open callback.
> > Maybe that's part of the attach phase now... I'm not sure, it's not
> > clear when the vfio device uAPI starts being available in the process
> > of setting up the ioasid.  Thanks,  
> 
> At a certain point we maybe just have to stick to backward compat, I
> think. Though it is useful to think about green field alternates to
> try to guide the backward compat design..

I think more to drive the replacement design; if we can't figure out
how to do something other than backwards compatibility trickery in the
kernel, it's probably going to bite us.  Thanks,

Alex

