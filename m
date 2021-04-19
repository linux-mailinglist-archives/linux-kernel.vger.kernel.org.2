Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71BE364521
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 15:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243234AbhDSNkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 09:40:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:64501 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242316AbhDSNe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 09:34:28 -0400
IronPort-SDR: 9TMB7mZEonMgeSRguQJkN4ixEpxJ6n5VJdiYqypKiXAzxwAz2qTZgd/bQnemdrgFyy4YzyCzUa
 PFwVFGkgMk5A==
X-IronPort-AV: E=McAfee;i="6200,9189,9959"; a="192137388"
X-IronPort-AV: E=Sophos;i="5.82,234,1613462400"; 
   d="scan'208";a="192137388"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 06:33:55 -0700
IronPort-SDR: 0i+wEhGbCQP8Avpf0xm0vMRCRN4QY7mcaZHGnZjD6+zAPyurprhJLO6MMtOQfxvnKw4hGQi5iT
 gQehU6KPWmxA==
X-IronPort-AV: E=Sophos;i="5.82,234,1613462400"; 
   d="scan'208";a="426512252"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.121]) ([10.254.210.121])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 06:33:51 -0700
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
 <20210413085457.25400-3-zhukeqian1@huawei.com>
 <fb350f27-be8b-80bf-1ce8-e7e8aba26f02@linux.intel.com>
 <491da550-dc54-42e6-ac91-13d411575fad@huawei.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v3 02/12] iommu: Add iommu_split_block interface
Message-ID: <bc2da48b-f4f7-5a46-2696-2c412a83d190@linux.intel.com>
Date:   Mon, 19 Apr 2021 21:33:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <491da550-dc54-42e6-ac91-13d411575fad@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keqian,

On 2021/4/19 17:32, Keqian Zhu wrote:
>>> +EXPORT_SYMBOL_GPL(iommu_split_block);
>> Do you really have any consumers of this interface other than the dirty
>> bit tracking? If not, I don't suggest to make this as a generic IOMMU
>> interface.
>>
>> There is an implicit requirement for such interfaces. The
>> iommu_map/unmap(iova, size) shouldn't be called at the same time.
>> Currently there's no such sanity check in the iommu core. A poorly
>> written driver could mess up the kernel by misusing this interface.
> Yes, I don't think up a scenario except dirty tracking.
> 
> Indeed, we'd better not make them as a generic interface.
> 
> Do you have any suggestion that underlying iommu drivers can share these code but
> not make it as a generic iommu interface?
> 
> I have a not so good idea. Make the "split" interfaces as a static function, and
> transfer the function pointer to start_dirty_log. But it looks weird and inflexible.

I understand splitting/merging super pages is an optimization, but not a
functional requirement. So is it possible to let the vendor iommu driver
decide whether splitting super pages when starting dirty bit tracking
and the opposite operation during when stopping it? The requirement for
upper layer is that starting/stopping dirty bit tracking and
mapping/unmapping are mutually exclusive.

> 
> On the other hand, if a driver calls map/unmap with split/merge at the same time,
> it's a bug of driver, it should follow the rule.
> 

Best regards,
baolu
