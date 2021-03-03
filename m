Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC7B32BAE5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443428AbhCCMGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 07:06:46 -0500
Received: from foss.arm.com ([217.140.110.172]:41860 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238845AbhCCGX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 01:23:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0A9F11FB
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 22:22:37 -0800 (PST)
Received: from mail-pl1-f174.google.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2FA23FA00
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 22:22:37 -0800 (PST)
Received: by mail-pl1-f174.google.com with SMTP id a24so13442776plm.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 22:22:37 -0800 (PST)
X-Gm-Message-State: AOAM533TGLY4XIDHIKjFFQIK0mUpswobQSq07Xw5IH06IqXtlKoq3YYT
        VeAjPDNcKvLvR9VhYVBSxUtXbQBtmacxPsH9fKk=
X-Google-Smtp-Source: ABdhPJyjKH03+b8N29Pq6s8DcllmtesgUkkzNBnaIPi2WHDARS5YrTkldcfc+EwzrIjmynqJ/ZDKVuoA8lP2aAyQaPY=
X-Received: by 2002:a17:902:868a:b029:e3:e605:36d with SMTP id
 g10-20020a170902868ab02900e3e605036dmr1540492plo.31.1614752553056; Tue, 02
 Mar 2021 22:22:33 -0800 (PST)
MIME-Version: 1.0
References: <20210212105859.8445-1-vivek.gautam@arm.com> <20210212105859.8445-3-vivek.gautam@arm.com>
 <0708b0b2-78f7-e55c-21a7-3c49eb5141df@redhat.com>
In-Reply-To: <0708b0b2-78f7-e55c-21a7-3c49eb5141df@redhat.com>
From:   Vivek Gautam <vivek.gautam@arm.com>
Date:   Wed, 3 Mar 2021 11:52:20 +0530
X-Gmail-Original-Message-ID: <CAFp+6iEL1KDSro=KVMTatP+_YYKuHQ+esbLSEGSZEQeJhZ56bw@mail.gmail.com>
Message-ID: <CAFp+6iEL1KDSro=KVMTatP+_YYKuHQ+esbLSEGSZEQeJhZ56bw@mail.gmail.com>
Subject: Re: [PATCH 2/2] iommu: arm-smmu-v3: Report domain nesting info
 reuqired for stage1
To:     Auger Eric <eric.auger@redhat.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        virtualization@lists.linux-foundation.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Tian, Kevin" <kevin.tian@intel.com>, mst@redhat.com,
        Will Deacon <will.deacon@arm.com>, alex.williamson@redhat.com,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Fri, Feb 12, 2021 at 11:44 PM Auger Eric <eric.auger@redhat.com> wrote:
>
> Hi Vivek,
>
> On 2/12/21 11:58 AM, Vivek Gautam wrote:
> > Update nested domain information required for stage1 page table.
>
> s/reuqired/required in the commit title

Oh! my bad.

> >
> > Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index c11dd3940583..728018921fae 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -2555,6 +2555,7 @@ static int arm_smmu_domain_nesting_info(struct arm_smmu_domain *smmu_domain,
> >                                       void *data)
> >  {
> >       struct iommu_nesting_info *info = (struct iommu_nesting_info *)data;
> > +     struct arm_smmu_device *smmu = smmu_domain->smmu;
> >       unsigned int size;
> >
> >       if (!info || smmu_domain->stage != ARM_SMMU_DOMAIN_NESTED)
> > @@ -2571,9 +2572,20 @@ static int arm_smmu_domain_nesting_info(struct arm_smmu_domain *smmu_domain,
> >               return 0;
> >       }
> >
> > -     /* report an empty iommu_nesting_info for now */
> > -     memset(info, 0x0, size);
> > +     /* Update the nesting info as required for stage1 page tables */
> > +     info->addr_width = smmu->ias;
> > +     info->format = IOMMU_PASID_FORMAT_ARM_SMMU_V3;
> > +     info->features = IOMMU_NESTING_FEAT_BIND_PGTBL |
> I understood IOMMU_NESTING_FEAT_BIND_PGTBL advertises the requirement to
> bind tables per PASID, ie. passing iommu_gpasid_bind_data.
> In ARM case I guess you plan to use attach/detach_pasid_table API with
> iommu_pasid_table_config struct. So I understood we should add a new
> feature here.

Right, the idea is to let vfio know that we support pasid table binding, and
I thought we could use the same flag. But clearly that's not the case.
Will add a new feature.

> > +                      IOMMU_NESTING_FEAT_PAGE_RESP |
> > +                      IOMMU_NESTING_FEAT_CACHE_INVLD;
> > +     info->pasid_bits = smmu->ssid_bits;
> > +     info->vendor.smmuv3.asid_bits = smmu->asid_bits;
> > +     info->vendor.smmuv3.pgtbl_fmt = ARM_64_LPAE_S1;
> > +     memset(&info->padding, 0x0, 12);
> > +     memset(&info->vendor.smmuv3.padding, 0x0, 9);
> > +
> >       info->argsz = size;
> > +
> spurious new line

Sure, will remove it.

Best regards
Vivek

> >       return 0;
> >  }
> >
> >
>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
