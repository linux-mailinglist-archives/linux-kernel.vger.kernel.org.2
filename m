Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38A53EB341
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 11:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239496AbhHMJQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 05:16:36 -0400
Received: from foss.arm.com ([217.140.110.172]:51826 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239035AbhHMJQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 05:16:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B66141042;
        Fri, 13 Aug 2021 02:16:07 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0071B3F70D;
        Fri, 13 Aug 2021 02:16:05 -0700 (PDT)
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW0V4dGVybmFsXVJlOiBBbiBjbWEgb3B0aW1pemF0?=
 =?UTF-8?Q?ion_patch_is_used_for_cma=5f=5balloc=7cfree=5d=2e?=
To:     Jichao Zou <zoujc@motorola.com>,
        David Hildenbrand <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "song.bao.hua@hisilicon.com" <song.bao.hua@hisilicon.com>,
        "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        JianQi Yang <yangj@motorola.com>,
        Yanjune Tian <tianyje@motorola.com>
References: <HK0PR03MB4177A44D9DAD3302251B0EC8D5FA9@HK0PR03MB4177.apcprd03.prod.outlook.com>
 <f5cd9fe6-3b62-eab8-1ff1-d3943d4bb85b@redhat.com>
 <HK0PR03MB41775573A48273BF128C7F72D5FA9@HK0PR03MB4177.apcprd03.prod.outlook.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <ca497139-a6e8-cb66-e221-7fe4af2bda14@arm.com>
Date:   Fri, 13 Aug 2021 10:15:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <HK0PR03MB41775573A48273BF128C7F72D5FA9@HK0PR03MB4177.apcprd03.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-13 09:27, Jichao Zou wrote:
> Hi David,
> 	I'll git-send-email patch again.
> 	Your understanding is exactly right.
> 	Let me explain the background of Patch, we are developing Android phone, kernel is 5.10.43 LTS, we encounter cma_alloc failed during kernel startup, buddy system is ready,
> 01-11 14:22:08.650   216   216 E cma     : cma_alloc([216][init]:cma(ffffffff00b50000:total 8192) linux,cma(ffffffe89d084cf0), count 2, align 1 gfp_mask 0xcc0)
> 01-11 14:22:08.650   216   216 E cma     : cma_alloc(): memory range at ffffffff00b62880 is busy, retrying
>   
> 	cma bitmap show memory is free, but alloc_contig_range failed, we checked it out that some drivers cma_alloc are
> 	"struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align, bool no_warn)"
> 	In 5.10.43, cma_alloc is
> 	"struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align, gfp_t gfp_mask)"
>   	After change cma_alloc parameter with GFP_KERNEL, issue is fixed, at the same time, we found that preallocate a portion of cma memory for audio&video resulted in better performance and guarantee AV function even under memory pressure, so we try to submit this patch.

The whole point of CMA is that the memory can be shared by moveable 
pages while it's not being used for DMA. If you want a dedicated DMA 
carveout, there are already mechanisms for that.

Robin.

> 
> Thanks.
> 
> Best Regards,
> 
> Zou Jichao 邹纪超
> Advisory Engineer, SW BSP
> MBG ROW SW BJ PF BSP (CN)
> Motorola Mobility, A Lenovo Company
> motorola.com
> M +86 18910860212
> E zoujc@lenovo.com
> twitter | facebook | instagram | blog | forums
> 
> 
> 
> 
> -----邮件原件-----
> 发件人: David Hildenbrand <david@redhat.com>
> 发送时间: 2021年8月13日 15:45
> 收件人: Jichao Zou <zoujc@motorola.com>; akpm@linux-foundation.org; linux-kernel@vger.kernel.org; linux-mm@kvack.org; minchan@kernel.org; song.bao.hua@hisilicon.com; hch@lst.de; m.szyprowski@samsung.com; robin.murphy@arm.com; iommu@lists.linux-foundation.org; JianQi Yang <yangj@motorola.com>; Yanjune Tian <tianyje@motorola.com>
> 主题: [External]Re: An cma optimization patch is used for cma_[alloc|free].
> 
> On 13.08.21 09:00, Jichao Zou wrote:
>> Pre-allocate CMA memory that configured in device tree, this greatly
>> improves the CMA memory allocation efficiency, cma_[alloc|free] is
>> less than 1ms, old way is took a few ms to tens or hundreds ms.
>>
> 
> Please send patches as proper emails (man git-format-patch; man git-send-email).
> 
> What you propose is turning cma reservations into something comparable to permanent boottime allocations. From the POV of the buddy, the pages are always allocated and cannot be repurposed for e.g., movable allocations until *actually* allocated via CMA.
> 
> I don't think we want this behavior upstream.
> 
> --
> Thanks,
> 
> David / dhildenb
> 
