Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E544E379D87
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 05:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhEKDOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 23:14:15 -0400
Received: from mga07.intel.com ([134.134.136.100]:26066 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhEKDOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 23:14:07 -0400
IronPort-SDR: KkcvMG3ElJBVcXePNnIfJLlIiB3QmYdqp6Uysg1y7FTtFHOz5e6kNNsnHDKbgLEj6mO7XF9EN6
 Q0yOgf3A6kTw==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="263273556"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="263273556"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 20:12:58 -0700
IronPort-SDR: stKccw6CyTiwgY6Z4oynDLYVZ9iolDqy5GJI2whakNs9xp75faAiZ3QlNCdDdLhdiWlAPMdVj9
 pZkA/PEv8pfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="621641217"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga006.fm.intel.com with ESMTP; 10 May 2021 20:12:52 -0700
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
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f47e90c6-f3c4-b28f-a810-e03afe79e62d@linux.intel.com>
Date:   Tue, 11 May 2021 11:12:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <a8df289a-47c2-c193-cd6f-8415f68b900f@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keqian,

On 5/10/21 7:07 PM, Keqian Zhu wrote:
>>>> I suppose this interface is to ask the vendor IOMMU driver to check
>>>> whether each device/iommu in the domain supports dirty bit tracking.
>>>> But what will happen if new devices with different tracking capability
>>>> are added afterward?
>>> Yep, this is considered in the vfio part. We will query again after attaching or
>>> detaching devices from the domain.  When the domain becomes capable, we enable
>>> dirty log for it. When it becomes not capable, we disable dirty log for it.
>> If that's the case, why not putting this logic in the iommu subsystem so
>> that it doesn't need to be duplicate in different upper layers?
>>
>> For example, add something like dirty_page_trackable in the struct of
>> iommu_domain and ask the vendor iommu driver to update it once any
>> device is added/removed to/from the domain. It's also better to disallow
> If we do it, the upper layer still needs to query the capability from domain and switch
> dirty log tracking for it. Or do you mean the domain can switch dirty log tracking automatically
> when its capability change? If so, I think we're lack of some flexibility. The upper layer
> may have it's own policy, such as only enable dirty log tracking when all domains are capable,
> and disable dirty log tracking when just one domain is not capable.

I may not get you.

Assume that dirty_page_trackable is an attribution of an iommu_domain.
This attribution might be changed once a new device (with different
capability) added or removed. So it should be updated every time a new
device is attached or detached. This work could be done by the vendor
iommu driver on the path of dev_attach/dev_detach callback.

For upper layers, before starting page tracking, they check the
dirty_page_trackable attribution of the domain and start it only it's
capable. Once the page tracking is switched on the vendor iommu driver
(or iommu core) should block further device attach/detach operations
until page tracking is stopped.

> 
>> any domain attach/detach once the dirty page tracking is on.
> Yep, this can greatly simplify our code logic, but I don't know whether our maintainers
> agree that, as they may think that IOMMU dirty logging should not change original domain
> behaviors.

The maintainer owns the last word, but we need to work out a generic and
self-contained API set.

Best regards,
baolu
