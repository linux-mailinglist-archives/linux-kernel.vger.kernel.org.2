Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A46937B51B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 06:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhELEsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 00:48:52 -0400
Received: from mga12.intel.com ([192.55.52.136]:61438 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229495AbhELEsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 00:48:50 -0400
IronPort-SDR: lm5mruyCjAlZqTVgzWpdSsTzOyC6YCzGB8DaNBHbu+lOyy9ggQAzCOZH4Wv1ZvOlOUFbzbFcMH
 iIjOqbtQ8OlA==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="179210148"
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="179210148"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 21:47:41 -0700
IronPort-SDR: 53J1wazrS1QReixwdHkkxnR6h55hKjKPB+/AHJbpqmNp4e/76VbGCJhC1SNjmVaypT58hu5x5h
 SX50P3VhkV8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,292,1613462400"; 
   d="scan'208";a="622109218"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga006.fm.intel.com with ESMTP; 11 May 2021 20:21:05 -0700
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
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <36cc7267-6aa3-db54-b08c-c2dfc0bbacb6@linux.intel.com>
Date:   Wed, 12 May 2021 11:20:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <60182a35-e151-7150-3708-4e58dd8e78da@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/21 3:40 PM, Keqian Zhu wrote:
>> For upper layers, before starting page tracking, they check the
>> dirty_page_trackable attribution of the domain and start it only it's
>> capable. Once the page tracking is switched on the vendor iommu driver
>> (or iommu core) should block further device attach/detach operations
>> until page tracking is stopped.
> But when a domain becomes capable after detaching a device, the upper layer
> still needs to query it and enable dirty log for it...
> 
> To make things coordinated, maybe the upper layer can register a notifier,
> when the domain's capability change, the upper layer do not need to query, instead
> they just need to realize a callback, and do their specific policy in the callback.
> What do you think?
> 

That might be an option. But why not checking domain's attribution every
time a new tracking period is about to start?

Best regards,
baolu
