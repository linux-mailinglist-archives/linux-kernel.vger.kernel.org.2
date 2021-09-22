Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C5A414AFB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 15:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbhIVNrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 09:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbhIVNrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 09:47:03 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CFAC061760
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 06:45:33 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u15so6977286wru.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 06:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OqATTE/BrEowQNUew/i6t2ee/2HGj0S7vXDfrjI49UE=;
        b=DiFDtXnK5X1h8sM3UZZQRitNG46c4VhNndlN1Odh528nj4uqe1rhaiY9GrzMcSViJ1
         rdpmjBv5rgcIxCztX0ZC6gUzb0g7Av9IlCsKTuW5/TJ0I1n0JfVcD6Bti2sizUZdoN/Q
         Hajavq/eLRHSvRS+MW3GxTtRFbIXdSCyG75s1XxJjIv2L8HOSapwFmOAHtN0JmiQKrSS
         8kQV/YWauMZ9YmXgzL0VI14g/jBN6zXaVWoXggUZUtrSNRRWbyDPHlDFXNlSPomnOTYC
         nlbbobY5tGo0sKEALZSpdtpxH5Ep1jqzvBp8MH2fyzTf7VMYYYrkKbG6sdJXK1aHboA/
         oflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OqATTE/BrEowQNUew/i6t2ee/2HGj0S7vXDfrjI49UE=;
        b=WpFpTYhjDCo15UuSt84TYaMOMOWbRd84R9G2FM7bnFybc8PpJLdV7bhzYLjNJ2vIie
         +bP+nefh92D7LQWVjk6TiNYmCTPr+LytbfWOUbCBIr/STHkj8pb+QCuwA4nKsQbXT1ET
         lHBKmhgy8IdiVXxaSMU8XMqCERNIZN7gTJXPuAAOrZvTV7Z6uslDCbZl07nj5pdWYSSR
         vunS6gmgBhAwhuMCzH4bFi71bmwjmP8WFQhmjhj/iJeP6m1RJOL4G7I+HOQ3mJLNGUun
         O2v6XdTKjsjSFsvWBgsJus15RxVHYJp+an08N5JJm4IndxQ2WjXCzFC7+In/SkYy5c9A
         6CIg==
X-Gm-Message-State: AOAM533wcGzZXDPvqFpC/xoLC+KxrPbaDkVw7+3ZgyW79fAL91UE5kXe
        jMktBrzH1/oxhe8D2N440FoOzg==
X-Google-Smtp-Source: ABdhPJxBzcwQu66fWHD0pP9MO/Sy42U55J8u2Jc1kFiULK7OUlEvJjbPdmOm0qWW1UWefraskQ1WQw==
X-Received: by 2002:a05:6000:1081:: with SMTP id y1mr42132164wrw.14.1632318331658;
        Wed, 22 Sep 2021 06:45:31 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id i2sm2158226wrq.78.2021.09.22.06.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 06:45:31 -0700 (PDT)
Date:   Wed, 22 Sep 2021 14:45:09 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Liu Yi L <yi.l.liu@intel.com>
Cc:     alex.williamson@redhat.com, jgg@nvidia.com, hch@lst.de,
        jasowang@redhat.com, joro@8bytes.org, kevin.tian@intel.com,
        parav@mellanox.com, lkml@metux.net, pbonzini@redhat.com,
        lushenming@huawei.com, eric.auger@redhat.com, corbet@lwn.net,
        ashok.raj@intel.com, yi.l.liu@linux.intel.com,
        jun.j.tian@intel.com, hao.wu@intel.com, dave.jiang@intel.com,
        jacob.jun.pan@linux.intel.com, kwankhede@nvidia.com,
        robin.murphy@arm.com, kvm@vger.kernel.org,
        iommu@lists.linux-foundation.org, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, baolu.lu@linux.intel.com,
        david@gibson.dropbear.id.au, nicolinc@nvidia.com
Subject: Re: [RFC 11/20] iommu/iommufd: Add IOMMU_IOASID_ALLOC/FREE
Message-ID: <YUszZRk1vZOgVvFF@myrica>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-12-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210919063848.1476776-12-yi.l.liu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 19, 2021 at 02:38:39PM +0800, Liu Yi L wrote:
> This patch adds IOASID allocation/free interface per iommufd. When
> allocating an IOASID, userspace is expected to specify the type and
> format information for the target I/O page table.
> 
> This RFC supports only one type (IOMMU_IOASID_TYPE_KERNEL_TYPE1V2),
> implying a kernel-managed I/O page table with vfio type1v2 mapping
> semantics. For this type the user should specify the addr_width of
> the I/O address space and whether the I/O page table is created in
> an iommu enfore_snoop format. enforce_snoop must be true at this point,
> as the false setting requires additional contract with KVM on handling
> WBINVD emulation, which can be added later.
> 
> Userspace is expected to call IOMMU_CHECK_EXTENSION (see next patch)
> for what formats can be specified when allocating an IOASID.
> 
> Open:
> - Devices on PPC platform currently use a different iommu driver in vfio.
>   Per previous discussion they can also use vfio type1v2 as long as there
>   is a way to claim a specific iova range from a system-wide address space.

Is this the reason for passing addr_width to IOASID_ALLOC?  I didn't get
what it's used for or why it's mandatory. But for PPC it sounds like it
should be an address range instead of an upper limit?

Thanks,
Jean

>   This requirement doesn't sound PPC specific, as addr_width for pci devices
>   can be also represented by a range [0, 2^addr_width-1]. This RFC hasn't
>   adopted this design yet. We hope to have formal alignment in v1 discussion
>   and then decide how to incorporate it in v2.
> 
> - Currently ioasid term has already been used in the kernel (drivers/iommu/
>   ioasid.c) to represent the hardware I/O address space ID in the wire. It
>   covers both PCI PASID (Process Address Space ID) and ARM SSID (Sub-Stream
>   ID). We need find a way to resolve the naming conflict between the hardware
>   ID and software handle. One option is to rename the existing ioasid to be
>   pasid or ssid, given their full names still sound generic. Appreciate more
>   thoughts on this open!
