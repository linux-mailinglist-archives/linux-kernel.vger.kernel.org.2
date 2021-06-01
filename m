Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16009397C64
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 00:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbhFAWYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 18:24:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47540 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234890AbhFAWYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 18:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622586152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QQ6OOCiaBJ+Tmwz5+IKCbPSSgkslxV7sVjnAnThBj/I=;
        b=iYW4l/ye/20fA3QsGFfc+xYd8NHpoyaVYYaPcJyftRCfBy11bbVc11FJ0VIgNxIR54gHtO
        1IL6d89qvYydAgcjri4m6JHfQiNOFdYRYDiPpUs/iWnxy59NYB52dnVloYsKemBbp7cBv+
        XgAw2M3VyBEURbkBlPs94Dj3feHCJ3E=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-zsuddzURMbq_ran-qb7wkw-1; Tue, 01 Jun 2021 18:22:30 -0400
X-MC-Unique: zsuddzURMbq_ran-qb7wkw-1
Received: by mail-oi1-f198.google.com with SMTP id k18-20020a05680808d2b02901edfe86c6dcso439600oij.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 15:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QQ6OOCiaBJ+Tmwz5+IKCbPSSgkslxV7sVjnAnThBj/I=;
        b=I1wbz/16+wrsyrOI8htiNOgtH/Je6JbBPwdIWMHPl/mcq8PiYWF97p2BZ4xcHCV5U0
         OUkU09/TTqukercd36lOC1K1LwPmgswVc8/UXqNLdlt4CveC1kaX+gg0E3xxsaUKs8lH
         Xd5sTaUo7uEpcVC1FrepTmakKqk9Zvu/SxZSDhJT2Mxlk2VFch4snoGxN4p4DsNyrfD3
         gYzdzT5vdWi2gqqufiuy67hJkKsgIWjBRMok73SnAag84bpXlNNn91tqk7179VrNt372
         Ctz1+opxP9hD6xxbMzPcd7986COsMmdKpcxd2dmoJ0XB+g52AnQ8qTbXyMMz7CM/4o7Q
         j3sQ==
X-Gm-Message-State: AOAM530DnJV8URn7T3wFggD8IxO8uxFryuQ2irefhk8ZqjReLbVAyKGb
        SY4NUHkWRLumjRHVm/EfVQ2H+Q8szn54Cn8/HJqstoJeq/2uOIsaixmbC6TYuCgyMeu+j46wt/P
        4Ski7pqTWgkNGY3tmMBygGg49
X-Received: by 2002:aca:6505:: with SMTP id m5mr18776740oim.93.1622586150037;
        Tue, 01 Jun 2021 15:22:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxi5D5R/YKBkpuFV42WBo2g+RPZt7CRIoVFlvzPv1SWguiDXnA+px3cN3uoGLgwkwtxnkMPhw==
X-Received: by 2002:aca:6505:: with SMTP id m5mr18776727oim.93.1622586149841;
        Tue, 01 Jun 2021 15:22:29 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id w10sm3658007oou.35.2021.06.01.15.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 15:22:29 -0700 (PDT)
Date:   Tue, 1 Jun 2021 16:22:25 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        "Robin Murphy" <robin.murphy@arm.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210601162225.259923bc.alex.williamson@redhat.com>
In-Reply-To: <MWHPR11MB188685D57653827B566BF9B38C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
        <20210528200311.GP1002214@nvidia.com>
        <MWHPR11MB188685D57653827B566BF9B38C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jun 2021 07:01:57 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:
> 
> I summarized five opens here, about:
> 
> 1)  Finalizing the name to replace /dev/ioasid;
> 2)  Whether one device is allowed to bind to multiple IOASID fd's;
> 3)  Carry device information in invalidation/fault reporting uAPI;
> 4)  What should/could be specified when allocating an IOASID;
> 5)  The protocol between vfio group and kvm;
> 
...
> 
> For 5), I'd expect Alex to chime in. Per my understanding looks the
> original purpose of this protocol is not about I/O address space. It's
> for KVM to know whether any device is assigned to this VM and then
> do something special (e.g. posted interrupt, EPT cache attribute, etc.).

Right, the original use case was for KVM to determine whether it needs
to emulate invlpg, so it needs to be aware when an assigned device is
present and be able to test if DMA for that device is cache coherent.
The user, QEMU, creates a KVM "pseudo" device representing the vfio
group, providing the file descriptor of that group to show ownership.
The ugly symbol_get code is to avoid hard module dependencies, ie. the
kvm module should not pull in or require the vfio module, but vfio will
be present if attempting to register this device.

With kvmgt, the interface also became a way to register the kvm pointer
with vfio for the translation mentioned elsewhere in this thread.

The PPC/SPAPR support allows KVM to associate a vfio group to an IOMMU
page table so that it can handle iotlb programming from pre-registered
memory without trapping out to userspace.

> Because KVM deduces some policy based on the fact of assigned device, 
> it needs to hold a reference to related vfio group. this part is irrelevant
> to this RFC. 

All of these use cases are related to the IOMMU, whether DMA is
coherent, translating device IOVA to GPA, and an acceleration path to
emulate IOMMU programming in kernel... they seem pretty relevant.

> But ARM's VMID usage is related to I/O address space thus needs some
> consideration. Another strange thing is about PPC. Looks it also leverages
> this protocol to do iommu group attach: kvm_spapr_tce_attach_iommu_
> group. I don't know why it's done through KVM instead of VFIO uAPI in
> the first place.

AIUI, IOMMU programming on PPC is done through hypercalls, so KVM needs
to know how to handle those for in-kernel acceleration.  Thanks,

Alex

