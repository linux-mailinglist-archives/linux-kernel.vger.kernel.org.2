Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7A836E777
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 10:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239982AbhD2I4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 04:56:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32365 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239882AbhD2I4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 04:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619686523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wrm2+m850R7afyhhET81Q0L5398XLTVE1kihsMtBiKk=;
        b=acZlrn56YreqWV1OMoNA4kCdid3L1rkaGvYNIrTE+ZwTL+qDL00kZS1PIAGtvIvGMXqFg/
        xrcIg5LISELEJ0k/uAbaL3CITojKnHNqKPQiYnxqxVXPsAQcr6lC2TCIeggEcJmeM+d6NU
        9cfC4vrtenwBJ8U5qVX5OiDLnklG8wc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-X6dhoxYUNiK321ap5a0xWw-1; Thu, 29 Apr 2021 04:55:18 -0400
X-MC-Unique: X6dhoxYUNiK321ap5a0xWw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E990080ED99;
        Thu, 29 Apr 2021 08:55:15 +0000 (UTC)
Received: from [10.36.113.191] (ovpn-113-191.ams2.redhat.com [10.36.113.191])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C4C876E34;
        Thu, 29 Apr 2021 08:55:03 +0000 (UTC)
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
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
References: <20210415230732.GG1370958@nvidia.com>
 <20210416061258.325e762e@jacob-builder> <20210416094547.1774e1a3@redhat.com>
 <BN6PR11MB406854F56D18E1187A2C98ACC3479@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210421162307.GM1370958@nvidia.com> <20210421105451.56d3670a@redhat.com>
 <20210421175203.GN1370958@nvidia.com> <20210421133312.15307c44@redhat.com>
 <20210421230301.GP1370958@nvidia.com>
 <MWHPR11MB1886188698A6E20338196F788C469@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210422121020.GT1370958@nvidia.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <ecc1d434-6fea-5978-03e3-e557ee16cb51@redhat.com>
Date:   Thu, 29 Apr 2021 10:55:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210422121020.GT1370958@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/22/21 2:10 PM, Jason Gunthorpe wrote:
> On Thu, Apr 22, 2021 at 08:34:32AM +0000, Tian, Kevin wrote:
> 
>> The shim layer could be considered as a new iommu backend in VFIO,
>> which connects VFIO iommu ops to the internal helpers in
>> drivers/ioasid.
> 
> It may be the best we can do because of SPAPR, but the ideal outcome
> should be to remove the entire pluggable IOMMU stuff from vfio
> entirely and have it only use /dev/ioasid
> 
> We should never add another pluggable IOMMU type to vfio - everything
> should be done through drives/iommu now that it is much more capable.
> 
>> Another tricky thing is that a container may be linked to multiple iommu
>> domains in VFIO, as devices in the container may locate behind different
>> IOMMUs with inconsistent capability (commit 1ef3e2bc). 
> 
> Frankly this sounds over complicated. I would think /dev/ioasid should
> select the IOMMU when the first device is joined, and all future joins
> must be compatible with the original IOMMU - ie there is only one set
> of IOMMU capabilities in a /dev/ioasid.
> 
> This means qemue might have multiple /dev/ioasid's if the system has
> multiple incompatible IOMMUs (is this actually a thing?) The platform
> should design its IOMMU domains to minimize the number of
> /dev/ioasid's required.
> 
> Is there a reason we need to share IOASID'd between completely
> divergance IOMMU implementations? I don't expect the HW should be able
> to physically share page tables??
> 
> That decision point alone might be the thing that just says we can't
> ever have /dev/vfio/vfio == /dev/ioasid
> 
>> Just to confirm. Above flow is for current map/unmap flavor as what
>> VFIO/vDPA do today. Later when nested translation is supported,
>> there is no need to detach gpa_ioasid_fd. Instead, a new cmd will
>> be introduced to nest rid_ioasid_fd on top of gpa_ioasid_fd:
> 
> Sure.. The tricky bit will be to define both of the common nested
> operating modes.
> 
>   nested_ioasid = ioctl(ioasid_fd, CREATE_NESTED_IOASID,  gpa_ioasid_id);
>   ioctl(ioasid_fd, SET_NESTED_IOASID_PAGE_TABLES, nested_ioasid, ..)
> 
>    // IOMMU will match on the device RID, no PASID:
>   ioctl(vfio_device, ATTACH_IOASID, nested_ioasid);
> 
>    // IOMMU will match on the device RID and PASID:
>   ioctl(vfio_device, ATTACH_IOASID_PASID, pasid, nested_ioasid);
> 
> Notice that ATTACH (or bind, whatever) is always done on the
> vfio_device FD. ATTACH tells the IOMMU HW to link the PCI BDF&PASID to
> a specific page table defined by an IOASID.
> 
> I expect we have many flavours of IOASID tables, eg we have normal,
> and 'nested with table controlled by hypervisor'. ARM has 'nested with
> table controlled by guest' right? So like this?
yes the PASID table is fully controlled by the guest Same for the stage
1 table.
> 
>   nested_ioasid = ioctl(ioasid_fd, CREATE_DELGATED_IOASID,
>                    gpa_ioasid_id, <some kind of viommu_id>)
>   // PASID now goes to <viommu_id>
>   ioctl(vfio_device, ATTACH_IOASID_PASID, pasid, nested_ioasid);
> 
> Where <viommu_id> is some internal to the guest handle of the viommu
> page table scoped within gpa_ioasid_id? Like maybe it is GPA of the
> base of the page table?
Yes the GPA of the first level page table + some misc info like the max
number of IOASIDs.
> 
> The guest can't select its own PASIDs without telling the hypervisor,
> right?
on ARM there is no system wide IOASID allocator as for x86. So the guest
can select its own PASID without telling the hyp.

Thanks

Eric
> 
>> I also feel hiding group from uAPI is a good thing and is interested in
>> the rationale behind for explicitly managing group in vfio (which is
>> essentially the same boundary as provided by iommu group), e.g. for 
>> better user experience when group security is broken? 
> 
> Indeed, I can see how things might have just evolved into this, but if
> it has a purpose it seems pretty hidden.
> we need it or not seems pretty hidden.
> 
> Jason
> 

