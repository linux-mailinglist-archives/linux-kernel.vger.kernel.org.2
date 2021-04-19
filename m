Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5EB363951
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 04:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237244AbhDSCJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 22:09:54 -0400
Received: from mga05.intel.com ([192.55.52.43]:49128 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233224AbhDSCJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 22:09:52 -0400
IronPort-SDR: qmvQ/PI0pLD+OrUGkkw5b9sEaa8F7FhAkGMGoQKVGD/GufvZdBFNqBaVz0igcozFt2BFi1HnaZ
 aPuB4nLRlyBQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9958"; a="280580173"
X-IronPort-AV: E=Sophos;i="5.82,232,1613462400"; 
   d="scan'208";a="280580173"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2021 19:09:21 -0700
IronPort-SDR: zxuHjgLbcM9BtCHqQCZ13ZYmO7rMenKxwRxWp6ygS8GE0+VyAbOHSkgSEuqzA05JJwQLR+P5AF
 LRu1uAXt3CzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,232,1613462400"; 
   d="scan'208";a="426330304"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by orsmga008.jf.intel.com with ESMTP; 18 Apr 2021 19:09:17 -0700
Cc:     baolu.lu@linux.intel.com,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        wanghaibin.wang@huawei.com, jiangkunkun@huawei.com,
        yuzenghui@huawei.com, lushenming@huawei.com
Subject: Re: [PATCH v3 01/12] iommu: Introduce dirty log tracking framework
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
 <2c01425f-813c-4278-ba06-26d651496a5c@linux.intel.com>
 <64c87f67-3687-61bd-1587-724cc2f9cc97@huawei.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <4e7ae083-08f5-b273-f873-21a2960ea68a@linux.intel.com>
Date:   Mon, 19 Apr 2021 09:59:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <64c87f67-3687-61bd-1587-724cc2f9cc97@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keqian,

On 4/16/21 5:07 PM, Keqian Zhu wrote:
>> I am worrying about having two sets of APIs for single purpose. From
>> vendor iommu driver's point of view, this feature is per device. Hence,
>> it still needs to do the same thing.
> Yes, we can unify the granule of feature reporting and status management.
> 
> The basic granule of dirty tracking is iommu_domain, I think it's very reasonable. We need an
> interface to report the feature of iommu_domain, then the logic is much more clear.
> 
> Every time we add new device or remove device from the domain, we should update the feature (e.g.,
> maintain a counter of unsupported devices).

Yes. This looks cleaner.

> 
> What do you think about this idea?
> 
> Thanks,
> Keqian

Best regards,
baolu
