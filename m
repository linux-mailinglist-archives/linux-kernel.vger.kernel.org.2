Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E200A399C34
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 10:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhFCICk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 04:02:40 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3134 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhFCICi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 04:02:38 -0400
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FwdLK2htKz6J9Tk;
        Thu,  3 Jun 2021 15:48:25 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 10:00:52 +0200
Received: from [10.47.80.115] (10.47.80.115) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 3 Jun 2021
 09:00:51 +0100
Subject: Re: [PATCH v3 0/7] iommu: Allow IOVA rcache range be configured
To:     Lu Baolu <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>
CC:     <iommu@lists.linux-foundation.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>
References: <1622557781-211697-1-git-send-email-john.garry@huawei.com>
 <834ad35a-7310-1738-7d17-7c061ca73e4c@linux.intel.com>
 <1cbf8cc2-8cee-0579-2514-56f664baa9cd@huawei.com>
 <5e6ff4d6-cd67-d4ab-814c-e10a258191b1@linux.intel.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <74dd66d6-315c-3273-afaa-e6164b4ea33f@huawei.com>
Date:   Thu, 3 Jun 2021 09:00:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <5e6ff4d6-cd67-d4ab-814c-e10a258191b1@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.80.115]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/2021 01:39, Lu Baolu wrote:
>> I did actually try increasing the range for a 'live' domain in the v1 
>> series, but it turned out too messy. First problem is reallocating the 
>> memory to hold the rcaches. Second problem is that we need to deal 
>> with the issue that all IOVAs in the rcache need to be a pow-of-2, 
>> which is difficult to enforce for IOVAs which weren't being cached 
>> before, but now would be.
>>
>> So now I changed to work similar to how we change the default domain 
>> type, i.e. don't operate on a 'live' domain.
> 
> If these hard restrictions on users are just to walk around the messy
> code in kernel, I would rather solve those messy code to achieve a
> better user experience. :-)

Hi Baolu,

It's not that the code is messy. I'm just saying that it's difficult to 
change the rcache range of a live domain. So we take an approach similar 
to changing the domain default type - it is more straightforward to 
configure the rcache range that way.

Anyway, it would be great if you or anyone could look at the code so 
that some progress can be made here.

Thanks,
John
