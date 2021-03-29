Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E98434D4CD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 18:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhC2QW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 12:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbhC2QWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 12:22:20 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732D9C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 09:22:19 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id c8so13441195wrq.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 09:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jZbWweHIj/iw1Oz6DYxQVEIzp/1xsW8SliME+sloCtE=;
        b=v5BIfzssEyWHaeWvOMenXdg/ShP4omXLwwwTl5P9IiKBjEQEnFCvXfdlcTHvD3rKqt
         0QovNRCSLDyrotfiUA/HQPerYJTVXXZjIvB4l0p0RbOPBe7Grd+xLRumEu1CAAkJXJA7
         ApNJ3UKtdnvwVvy0YUiV8fgal7daW7pKYF3YVVmTSTlJ/kxHo/ZEzxneQUs9ED8GMdge
         lp3H0XDfAg/P+mq4iEoF7EEZfv7RBSpXJWp5miiHTYwnlxyYJm2GegL7TYmfTrUebA6L
         BYBxL7GmPjL1SdVurioHfx1F/Y6urULxFiWxeQYwNL3mBB88QDBDeAPP33rPLANH7b2G
         98Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jZbWweHIj/iw1Oz6DYxQVEIzp/1xsW8SliME+sloCtE=;
        b=EvNs07LzIPQftgE41YKKuCS10irV+WgPE7+H7bY8ve699VACf9WreildMt+5ymtFCi
         qpJwMMDpS7EeiDhQdiHuetw57ZBzMY4Fxjtw+aUbASLrmdqpW8mXe2iJ0mXxTQz2vMzv
         6k9wQlJBwQDMbMAlTe/74HdeRCVLLYZ35AHuCGqTKoikzomk/kntJ9RBZCDmieHKxUsC
         cqxsYGDCT+xOU7HPannOblR1oGiPVw9I6iUjzH3slEGVKfJn4k+fxsffJ15U7QVY8o6n
         dOiT82rI9E4EOYF0q2TGAEUy262qzAj1GvhwDIm3Qf2M8zUBScMFEPcJ7mNt2TVFXEDg
         4QTw==
X-Gm-Message-State: AOAM532R7MYzZZcWffatmDybPrA2AsDjPu4NYOvDJLSRFGUWbv4c/XlG
        tH/bB8CuQFsrHgdYUkb7PhOzmg==
X-Google-Smtp-Source: ABdhPJz7MvKPUQKWgDaNYw187loYoMGXwbMaxT87b8Cm4aAN69o65xT6zTUwjl1xl1XKHggGy5zNhw==
X-Received: by 2002:adf:e582:: with SMTP id l2mr29775270wrm.207.1617034938172;
        Mon, 29 Mar 2021 09:22:18 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id v18sm31545369wru.85.2021.03.29.09.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 09:22:17 -0700 (PDT)
Date:   Mon, 29 Mar 2021 18:21:59 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Vivek Kumar Gautam <vivek.gautam@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org, joro@8bytes.org,
        will.deacon@arm.com, mst@redhat.com, robin.murphy@arm.com,
        eric.auger@redhat.com, alex.williamson@redhat.com,
        kevin.tian@intel.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@intel.com, lorenzo.pieralisi@arm.com,
        shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH RFC v1 13/15] iommu/virtio: Attach Arm PASID tables when
 available
Message-ID: <YGH+pyO8bEKNhhGl@myrica>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
 <20210115121342.15093-14-vivek.gautam@arm.com>
 <YD/GeIJA/ARevO7X@myrica>
 <ee88590b-513e-7821-ab52-18d496ad90dc@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee88590b-513e-7821-ab52-18d496ad90dc@arm.com>
X-TUID: x5lqDTusQD9a
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 06:59:17PM +0530, Vivek Kumar Gautam wrote:
> > > +	/* XXX HACK: set feature bit ARM_SMMU_FEAT_2_LVL_CDTAB */
> > > +	pst_cfg->vendor.cfg.feat_flag |= (1 << 1);
> > 
> > Oh right, this flag is missing. I'll add
> > 
> >    #define VIRTIO_IOMMU_PST_ARM_SMMU3_F_CD2L (1ULL << 1)
> > 
> > to the spec.
> 
> Regarding this Eric pointed out [1] in my other patch about the scalability
> of the approach where we keep adding flags in 'iommu_nesting_info'
> corresponding to the arm-smmu-v3 capabilities. I guess the same goes to
> these flags in virtio.
> May be the 'iommu_nesting_info' can have a bitmap with the caps for vendor
> specific features, and here we can add the related flags?

Something like that, but I'd keep separate arch-specific structs. Vt-d
reports the capability registers directly through iommu_nesting_info [2].
We could do the same for Arm, copy sanitized values of IDR0..5 into
struct iommu_nesting_info_arm_smmuv3.

I've avoided doing that for virtio-iommu because every field needs a
description in the spec. So where possible I used generic properties that
apply to any architecture, such as page, PASID and address size. What's
left is the minimum arch-specific information to get nested translation
going, leaving out a lot of properties such as big-endian and 32-bit,
which can be added later if needed. The Arm specific properties are split
into page table and pasid table information. Page table info should work
for both SMMUv2 and v3 (where they correspond to an SMMU_IDRx field that
constrains a context descriptor field.) I should move BTM in there since
it's supported by SMMUv2.

Thanks,
Jean

[2] https://lore.kernel.org/linux-iommu/20210302203545.436623-11-yi.l.liu@intel.com/
