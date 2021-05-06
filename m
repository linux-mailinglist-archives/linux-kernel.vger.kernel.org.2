Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679AA375015
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 09:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbhEFHZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 03:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbhEFHZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 03:25:06 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99BEC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 00:24:08 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id l4so6727327ejc.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 00:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eRP4wTn1wFZOpPD7g2y7lVg+V5xezb4JX6rjQ3r6xH4=;
        b=hUJi1Ju1LlScfHhDyP72PNYvaUr6tj3fzBj+bZ8lHKvWeTBj3NT+hIdlrf/7xRWASa
         6Pzl54QcOoN1FrgBAKNgI7p/u+Z67s85MNyGYoOGpLpm+B7uGbsGiRpdBDjBmYzy+mn1
         T4+0QHVMlUST9R6hoUf/e2yagDGq567NRATcCfxLdrrWXMQAlV9egyi1+gUty6dpbudK
         sG8R5sRiXurKziDANc3OM7wQg/58LnoDibOv9BsTRUF+iR4Ijjh1a2YVVOz/Sx6vpa/J
         3lZ2bKsEQKGQxdMwD9vshCsR0OAelyfZBQ01L7pmUJ1RGEcUaLvkbSVy2Yjc9Coaiplc
         6HWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eRP4wTn1wFZOpPD7g2y7lVg+V5xezb4JX6rjQ3r6xH4=;
        b=AN0Y+LHgTQeUaBWUdu5O3P+KuilHcr2scH2tblFJ8YIOJ0aae3/fCPTZHvO9jiauCu
         7g4lmXBiaxcdS+H+ZooSB9rs4ayF+QeF6vM7ec0Q3/lDxE6FvzZUHsNJqVE7EfHUDuDB
         SwRz3THIq/tF2nYRg5/B7EWopOt2jGYu2Acrn7Io/BnVm38FGvwgZQmF7Fdvo13TM+F/
         89a9EFduqDnvHJPmHrfr1WH90x6myCP3kxEErgn0xQCZJreD3SEIPFG6F4k42yiP0xm1
         +v6uYCRdE8QjrELdBTxBAJcg5dN6ThsvDXqNtAmCdnKNIywdql7g6ToH2PpvLJ+icsnF
         rbBA==
X-Gm-Message-State: AOAM53051C/YrLMHE7lBs5BRnFamNJoDlXwEj7xc3+c28CY4zpdCh7Dw
        bGcXaQ7Kg7Mm1YAPWq9RoVlzGA==
X-Google-Smtp-Source: ABdhPJzixQ3BaFD3OTh1vRysF4zM97RPtVrKDRVk2N/ghEPf5TXJ8hDsWRBVGG0/0QhCyqEk1Prz2g==
X-Received: by 2002:a17:906:170a:: with SMTP id c10mr2796408eje.493.1620285847402;
        Thu, 06 May 2021 00:24:07 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id r16sm935986edq.87.2021.05.06.00.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 00:24:06 -0700 (PDT)
Date:   Thu, 6 May 2021 09:23:48 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Auger Eric <eric.auger@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <YJOZhPGheTSlHtQc@myrica>
References: <MWHPR11MB18861FE6982D73AFBF173E048C439@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210426123817.GQ1370958@nvidia.com>
 <MWHPR11MB188625137D5B7423822396C88C409@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210504084148.4f61d0b5@jacob-builder>
 <20210504180050.GB1370958@nvidia.com>
 <20210504151154.02908c63@jacob-builder>
 <20210504231530.GE1370958@nvidia.com>
 <20210505102259.044cafdf@jacob-builder>
 <20210505180023.GJ1370958@nvidia.com>
 <20210505130446.3ee2fccd@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505130446.3ee2fccd@jacob-builder>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2021 at 01:04:46PM -0700, Jacob Pan wrote:
> > > For ARM, since the guest owns the per device PASID table. There is no
> > > need to allocate PASIDs from the host nor the hypervisor. Without SWQ,
> > > there is no need for global PASID/SSID either. So PASID being global
> > > for ARM is for simplicity in case of host PASID/SSID.  
> > 
> > It isn't clear how ARM can support PASID and mdev but that is an
> > unrelated issue..
> > 
> AFAIK, the current SMMU device assignment is per RID, since only one stage2
> page tables per RID, not per PASID. This is equivalent to the older VT-d
> spec. prior to scalable mode.

Yes that's right. Since SMMUv3 has a single level-2 page table per RID, it
doesn't support assigning level-1 page tables to guests for mdevs (sub-VF
devices). So no PASIDs for mdevs, which also means each guest has its own
PASID space and the host doesn't track guest PASIDs.

Thanks,
Jean
