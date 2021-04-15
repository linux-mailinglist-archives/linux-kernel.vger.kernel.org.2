Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD41C3606F9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbhDOKVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:21:53 -0400
Received: from mga14.intel.com ([192.55.52.115]:30066 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229481AbhDOKVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:21:52 -0400
IronPort-SDR: OFxdEZTxUD5vuGtxvI7cj7zPElaSBhKdPlTuHWwbST1/n6FJikXJWfPqIemtAxPphVdWFFyp8m
 i4EW6BKEf2Fg==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="194390027"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="194390027"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 03:21:29 -0700
IronPort-SDR: S4tkgA4j2Grn9PWxRgbOLJ6hnJxtiufe2YSOnSbpbDbhtm6EBzJKb667y0goYd/rcq3OMWvghG
 EvdwM4I1L0Hg==
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="425129910"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.126]) ([10.254.214.126])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 03:21:25 -0700
Cc:     baolu.lu@linux.intel.com,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        wanghaibin.wang@huawei.com, jiangkunkun@huawei.com,
        yuzenghui@huawei.com, lushenming@huawei.com
To:     Keqian Zhu <zhukeqian1@huawei.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Yi Sun <yi.y.sun@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tian Kevin <kevin.tian@intel.com>
References: <20210413085457.25400-1-zhukeqian1@huawei.com>
 <20210413085457.25400-2-zhukeqian1@huawei.com>
 <fe337950-f8d0-3d21-a7b1-98b385d71f3e@linux.intel.com>
 <e42373e3-10d5-5a34-8f33-8bb82d64fb19@huawei.com>
 <56b001fa-b4fe-c595-dc5e-f362d2f07a19@linux.intel.com>
 <88cba608-2f22-eb83-f22e-50cb547b6ee8@huawei.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v3 01/12] iommu: Introduce dirty log tracking framework
Message-ID: <2c01425f-813c-4278-ba06-26d651496a5c@linux.intel.com>
Date:   Thu, 15 Apr 2021 18:21:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <88cba608-2f22-eb83-f22e-50cb547b6ee8@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2021/4/15 15:43, Keqian Zhu wrote:
>>> design it as not switchable. I will modify the commit message of patch#12, thanks!
>> I am not sure that I fully get your point. But I can't see any gaps of
>> using iommu_dev_enable/disable_feature() to switch dirty log on and off.
>> Probably I missed anything.
> IOMMU_DEV_FEAT_HWDBM just tells user whether underlying IOMMU driver supports
> dirty tracking, it is not used to management the status of dirty log tracking.
> 
> The feature reporting is per device, but the status management is per iommu_domain.
> Only when all devices in a domain support HWDBM, we can start dirty log for the domain.

So why not

	for_each_device_attached_domain()
		iommu_dev_enable_feature(IOMMU_DEV_FEAT_HWDBM)

?
> 
> And I think we'd better not mix the feature reporting and status management. Thoughts?
> 

I am worrying about having two sets of APIs for single purpose. From
vendor iommu driver's point of view, this feature is per device. Hence,
it still needs to do the same thing.

Best regards,
baolu
