Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF841357F70
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhDHJhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhDHJhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:37:46 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D37DC061761
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 02:37:35 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id p19so869177wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 02:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W/yHsDt8vP0u2gfAgM+TLjsXBjDf3kcjStZ5TkuBO04=;
        b=L5BRsWJ8dydkBP9Vi3TF7ADyA4Q5GaNirzWF94eqpg+JL306eqT94na2clpu3nDELP
         dMAUkP34cNKUubQsnzzBBJumO4zcJGAIfpj1grXxgQ2yhbG3monwA+u5fya1ii40SmGn
         uvAWVf2oQg1pX4OpfR97WCcf31mQtF2h1bItuDvOJMwp+9YtuW4mtreSNi9FGNsIofm+
         ua2fL0BRhP0XS5ofnTIxaJffPESnYgmxaDLwoXDKxIflWeQJwndYp52a0kZ9Qeh/hmre
         7ZTLGWwwViwBS+UTUcH7N0rwucQn3bwcuWYusqgoEZMOTJjo/wgxp7GTAipXRVmo/K9m
         2INg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W/yHsDt8vP0u2gfAgM+TLjsXBjDf3kcjStZ5TkuBO04=;
        b=j9J3szegb7OAtFjSPrcwqeKz5aQNZqda3/60Cc9zJI0mZQWs+LVhPp+LpyO2IPx2j0
         A10NCNMw3mW56W08RI+4aERRkx8lpVEpmYEIMIAMdz6BKMM61MGcNZTFynnvMBd3OiqL
         V1eD1JxcBet1j44W70F6ukUB01+vJhUpFXQSdzR5hxE1ptnfzyqqdQVnBYYVIYoBOTY8
         kEOJZsezrRQ3ShYCTJBKG10WnC7o2ZPmuBrAEeC3hqk0Fxr50kS/ZPFXXAftfbIIkj84
         bQvi1US83af6HQe70n8+AJCHnZNlPy3ZhnrR3alAO6axTVtWEJt3guGXdj7XTRGOESop
         YwMg==
X-Gm-Message-State: AOAM5331r1uA5KlSkLuTiQhy/ASF+3kklSaxGya2/GXTBNwIlN8t1B43
        BNNW5orIjCAzYP2WDy/PMY0JyOefIhKE+w==
X-Google-Smtp-Source: ABdhPJzJL3dixxN/yLW8668xthwKI1Qe27J5sx/WY544bIVjXbdwnVBFT5n3x6q0eGEHleVFu9k3cQ==
X-Received: by 2002:a7b:c047:: with SMTP id u7mr7488121wmc.98.1617874653812;
        Thu, 08 Apr 2021 02:37:33 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id a15sm45246768wrr.53.2021.04.08.02.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 02:37:33 -0700 (PDT)
Date:   Thu, 8 Apr 2021 11:37:15 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Wang <jasowang@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "Wu, Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <YG7Oyyju/2J6KMf+@myrica>
References: <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <MWHPR11MB1886CAD48AFC156BFC7C1D398C7A9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210405234230.GF7405@nvidia.com>
 <fa57bde5-472f-6e66-3521-bfac7d6e4f8d@redhat.com>
 <20210406124251.GO7405@nvidia.com>
 <MWHPR11MB1886A7E4C6F3E3A81240517B8C759@MWHPR11MB1886.namprd11.prod.outlook.com>
 <YG39ZtnTuyn5uBOa@myrica>
 <20210407193654.GG282464@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407193654.GG282464@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 04:36:54PM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 07, 2021 at 08:43:50PM +0200, Jean-Philippe Brucker wrote:
> 
> > * Get a container handle out of /dev/ioasid (or /dev/iommu, really.)
> >   No operation available since we don't know what the device and IOMMU
> >   capabilities are.
> >
> > * Attach the handle to a VF. With VFIO that would be
> >   VFIO_GROUP_SET_CONTAINER. That causes the kernel to associate an IOMMU
> >   with the handle, and decide which operations are available.
> 
> Right, this is basically the point, - the VFIO container (/dev/vfio)
> and the /dev/ioasid we are talking about have a core of
> similarity. ioasid is the generalized, modernized, and cross-subsystem
> version of the same idea. Instead of calling it "vfio container" we
> call it something that evokes the idea of controlling the iommu.
> 
> The issue is to seperate /dev/vfio generic functionality from vfio and
> share it with every subsystem.
> 
> It may be that /dev/vfio and /dev/ioasid end up sharing a lot of code,
> with a different IOCTL interface around it. The vfio_iommu_driver_ops
> is not particularly VFIOy.
> 
> Creating /dev/ioasid may primarily start as a code reorganization
> exercise.
> 
> > * With a map/unmap vIOMMU (or shadow mappings), a single translation level
> >   is supported. With a nesting vIOMMU, we're populating the level-2
> >   translation (some day maybe by binding the KVM page tables, but
> >   currently with map/unmap ioctl).
> > 
> >   Single-level translation needs single VF per container. 
> 
> Really? Why?

The vIOMMU is started in bypass, so the device can do DMA to the GPA space
until the guest configures the vIOMMU, at which point each VF is either
kept in bypass or gets new DMA mappings, which requires the host to tear
down the bypass mappings and set up the guest mappings on a per-VF basis
(I'm not considering nesting translation in the host kernel for this,
because it's not supported by all pIOMMUs and is expensive in terms of TLB
and pinned memory). So keeping a single VF per container is simpler, but
there are certainly other programming models possible.

Thanks,
Jean

