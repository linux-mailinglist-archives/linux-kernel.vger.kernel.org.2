Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0C545CBB3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 19:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350175AbhKXSDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 13:03:40 -0500
Received: from foss.arm.com ([217.140.110.172]:41660 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241542AbhKXSDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 13:03:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46B781FB;
        Wed, 24 Nov 2021 10:00:29 -0800 (PST)
Received: from [10.57.56.56] (unknown [10.57.56.56])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CDBA3F66F;
        Wed, 24 Nov 2021 10:00:27 -0800 (PST)
Message-ID: <e95f682b-a9b4-d946-c6fc-e59aba624466@arm.com>
Date:   Wed, 24 Nov 2021 18:00:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 9/9] iommu: Move flush queue data into iommu_dma_cookie
Content-Language: en-GB
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org
Cc:     iommu@lists.linux-foundation.org, suravee.suthikulpanit@amd.com,
        baolu.lu@linux.intel.com, willy@infradead.org,
        linux-kernel@vger.kernel.org
References: <cover.1637671820.git.robin.murphy@arm.com>
 <49bfd9636fd21c4b40e07558db6bfbbf82a449ac.1637674723.git.robin.murphy@arm.com>
 <9dece0b8-2832-f467-91f3-f63ef0f70d16@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <9dece0b8-2832-f467-91f3-f63ef0f70d16@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-24 17:25, John Garry wrote:
> On 23/11/2021 14:10, Robin Murphy wrote:
>> ruct iommu_dma_msi_page {
>>       struct list_head    list;
>> @@ -41,7 +43,19 @@ struct iommu_dma_cookie {
>>       enum iommu_dma_cookie_type    type;
>>       union {
>>           /* Full allocator for IOMMU_DMA_IOVA_COOKIE */
>> -        struct iova_domain    iovad;
>> +        struct {
>> +            struct iova_domain    iovad;
>> +
>> +            struct iova_fq __percpu *fq;    /* Flush queue */
>> +            /* Number of TLB flushes that have been started */
>> +            atomic64_t        fq_flush_start_cnt;
>> +            /* Number of TLB flushes that have been finished */
>> +            atomic64_t        fq_flush_finish_cnt;
>> +            /* Timer to regularily empty the flush queues */
>> +            struct timer_list    fq_timer;
>> +            /* 1 when timer is active, 0 when not */
>> +            atomic_t        fq_timer_on;
> 
> I thought that putting all the FQ stuff in its own structure would be 
> neater, but that's just personal preference.

But look, it is! ;)

The iova_domain is still a fundamental part of the flush queue built 
around it; the rest of the machinery can't stand in isolation. It's just 
an anonymous structure because I don't feel like needlessly cluttering 
up the code with "cookie->fq.fq" silliness.

Cheers,
Robin.
