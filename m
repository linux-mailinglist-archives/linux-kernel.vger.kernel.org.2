Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45ED37BBED
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 13:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhELLiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 07:38:12 -0400
Received: from mga05.intel.com ([192.55.52.43]:62179 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230197AbhELLiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 07:38:10 -0400
IronPort-SDR: wcvoJX32daI6q1ZfruXwNm0/Bsxz9zU81Bru11aPneC5Ie+hW/KBRrsnUorWlaJOsXM9d1hRGf
 oYIBANA8/8Bw==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="285185306"
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="285185306"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 04:37:01 -0700
IronPort-SDR: /H5FLzSrZq+cwNz0Azt92onxkumHrnfiBrY3Lf5zJuvazIodXgHxSAY4WCiCCFCq8gbo3W8m6h
 rUxD+mRhMjiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="622372334"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga006.fm.intel.com with ESMTP; 12 May 2021 04:36:57 -0700
Cc:     baolu.lu@linux.intel.com,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        wanghaibin.wang@huawei.com, jiangkunkun@huawei.com,
        yuzenghui@huawei.com, lushenming@huawei.com
Subject: Re: [RFC PATCH v4 01/13] iommu: Introduce dirty log tracking
 framework
To:     Keqian Zhu <zhukeqian1@huawei.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Yi Sun <yi.y.sun@linux.intel.com>,
        Tian Kevin <kevin.tian@intel.com>
References: <20210507102211.8836-1-zhukeqian1@huawei.com>
 <20210507102211.8836-2-zhukeqian1@huawei.com>
 <efc2d868-28ba-8ed9-1d6b-610b67d671b5@linux.intel.com>
 <18ac787a-179e-71f7-728b-c43feda80a16@huawei.com>
 <55fda826-9ab6-a3a0-b17e-a4d4879f00bc@linux.intel.com>
 <a8df289a-47c2-c193-cd6f-8415f68b900f@huawei.com>
 <f47e90c6-f3c4-b28f-a810-e03afe79e62d@linux.intel.com>
 <60182a35-e151-7150-3708-4e58dd8e78da@huawei.com>
 <36cc7267-6aa3-db54-b08c-c2dfc0bbacb6@linux.intel.com>
 <e38f1837-b814-3717-2faf-4df8349cb57c@huawei.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <7fb678c7-509b-dbb5-d533-32c5ce2a0476@linux.intel.com>
Date:   Wed, 12 May 2021 19:36:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <e38f1837-b814-3717-2faf-4df8349cb57c@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi keqian,

On 5/12/21 4:44 PM, Keqian Zhu wrote:
> 
> 
> On 2021/5/12 11:20, Lu Baolu wrote:
>> On 5/11/21 3:40 PM, Keqian Zhu wrote:
>>>> For upper layers, before starting page tracking, they check the
>>>> dirty_page_trackable attribution of the domain and start it only it's
>>>> capable. Once the page tracking is switched on the vendor iommu driver
>>>> (or iommu core) should block further device attach/detach operations
>>>> until page tracking is stopped.
>>> But when a domain becomes capable after detaching a device, the upper layer
>>> still needs to query it and enable dirty log for it...
>>>
>>> To make things coordinated, maybe the upper layer can register a notifier,
>>> when the domain's capability change, the upper layer do not need to query, instead
>>> they just need to realize a callback, and do their specific policy in the callback.
>>> What do you think?
>>>
>>
>> That might be an option. But why not checking domain's attribution every
>> time a new tracking period is about to start?
> Hi Baolu,
> 
> I'll add an attribution in iommu_domain, and the vendor iommu driver will update
> the attribution when attach/detach devices.
> 
> The attribute should be protected by a lock, so the upper layer shouldn't access
> the attribute directly. Then the iommu_domain_support_dirty_log() still should be
> retained. Does this design looks good to you?

Yes, that's what I was thinking of. But I am not sure whether it worth
of a lock here. It seems not to be a valid behavior for upper layer to
attach or detach any device while doing the dirty page tracking.

Best regards,
baolu
