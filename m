Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAFF36E2B2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 02:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbhD2AtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 20:49:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16165 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhD2AtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 20:49:21 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FVxcN65dqzlVyx;
        Thu, 29 Apr 2021 08:45:24 +0800 (CST)
Received: from [10.174.177.244] (10.174.177.244) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Thu, 29 Apr 2021 08:48:27 +0800
Subject: Re: arm32: panic in move_freepages (Was [PATCH v2 0/4] arm64: drop
 pfn_valid_within() and simplify pfn_valid())
To:     Mike Rapoport <rppt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Will Deacon" <will@kernel.org>, <kvmarm@lists.cs.columbia.edu>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <9aa68d26-d736-3b75-4828-f148964eb7f0@huawei.com>
 <YIEl8aKr8Ly0Zd3O@kernel.org>
 <33fa74c2-f32d-f224-eb30-acdb717179ff@huawei.com>
 <2a1592ad-bc9d-4664-fd19-f7448a37edc0@huawei.com>
 <YIUYG8N9T3/C/tSG@kernel.org>
 <52f7d03b-7219-46bc-c62d-b976bc31ebd5@huawei.com>
 <YIZNq5HMfJ1rWytv@kernel.org>
 <2d879629-3059-fd42-428f-4b7c2a73d698@huawei.com>
 <YIet5X7lgygD9rpZ@kernel.org>
 <259d14df-a713-72e7-4ccb-c06a8ee31e13@huawei.com>
 <YIj5zcbHBHt7CC8B@kernel.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <6ad2956c-70ae-c423-ed7d-88e94c88060f@huawei.com>
Date:   Thu, 29 Apr 2021 08:48:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YIj5zcbHBHt7CC8B@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.244]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/4/28 13:59, Mike Rapoport wrote:
> On Tue, Apr 27, 2021 at 07:08:59PM +0800, Kefeng Wang wrote:
>> On 2021/4/27 14:23, Mike Rapoport wrote:
>>> On Mon, Apr 26, 2021 at 11:26:38PM +0800, Kefeng Wang wrote:
>>>> On 2021/4/26 13:20, Mike Rapoport wrote:
>>>>> On Sun, Apr 25, 2021 at 03:51:56PM +0800, Kefeng Wang wrote:
>>>>>> On 2021/4/25 15:19, Mike Rapoport wrote:
>>>>>>
>>>>>>        On Fri, Apr 23, 2021 at 04:11:16PM +0800, Kefeng Wang wrote:
>>>>>>
>>>>>>            I tested this patchset(plus arm32 change, like arm64 does)
>>>>>>            based on lts 5.10，add some debug log, the useful info shows
>>>>>>            below, if we enable HOLES_IN_ZONE, no panic, any idea,
>>>>>>            thanks.
>>>>>>
>>>>>>        Are there any changes on top of 5.10 except for pfn_valid() patch?
>>>>>>        Do you see this panic on 5.10 without the changes?
>>>>>>
>>>>>> Yes, there are some BSP support for arm board based on 5.10,
>>> Is it possible to test 5.12?
> Do you use SPARSMEM? If yes, what is your section size?
> What is the value if CONFIG_FORCE_MAX_ZONEORDER in your configuration?

Yes,

CONFIG_SPARSEMEM=y

CONFIG_SPARSEMEM_STATIC=y

CONFIG_FORCE_MAX_ZONEORDER = 11

CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_HAVE_ARCH_PFN_VALID=y
CONFIG_HIGHMEM=y
#define SECTION_SIZE_BITS    26
#define MAX_PHYSADDR_BITS    32
#define MAX_PHYSMEM_BITS     32


>
