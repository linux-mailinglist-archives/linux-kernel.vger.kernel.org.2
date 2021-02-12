Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8005B319A26
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 08:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhBLHN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 02:13:59 -0500
Received: from foss.arm.com ([217.140.110.172]:33142 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhBLHNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 02:13:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5233D12FC;
        Thu, 11 Feb 2021 23:13:06 -0800 (PST)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF0653F73D;
        Thu, 11 Feb 2021 23:13:02 -0800 (PST)
Subject: Re: [PATCH 2/3] arm64/hugetlb: Enable HUGETLB_PAGE_SIZE_VARIABLE
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, akpm@linux-foundation.org,
        will@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        David Hildenbrand <david@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <1613024531-19040-1-git-send-email-anshuman.khandual@arm.com>
 <1613024531-19040-3-git-send-email-anshuman.khandual@arm.com>
 <20210211080148.GB14448@lst.de>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <768e2ee2-93a5-02ec-4842-41e1242a6bef@arm.com>
Date:   Fri, 12 Feb 2021 12:43:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210211080148.GB14448@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/11/21 1:31 PM, Christoph Hellwig wrote:
> On Thu, Feb 11, 2021 at 11:52:10AM +0530, Anshuman Khandual wrote:
>> MAX_ORDER which invariably depends on FORCE_MAX_ZONEORDER can be a variable
>> for a given page size, depending on whether TRANSPARENT_HUGEPAGE is enabled
>> or not. In certain page size and THP combinations HUGETLB_PAGE_ORDER can be
>> greater than MAX_ORDER, making it unusable as pageblock_order.
>>
>> This enables HUGETLB_PAGE_SIZE_VARIABLE making pageblock_order a variable
>> rather than the compile time constant HUGETLB_PAGE_ORDER which could break
>> MAX_ORDER rule for certain configurations.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/Kconfig | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index f39568b28ec1..8e3a5578f663 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -1909,6 +1909,10 @@ config ARCH_ENABLE_THP_MIGRATION
>>  	def_bool y
>>  	depends on TRANSPARENT_HUGEPAGE
>>  
>> +config HUGETLB_PAGE_SIZE_VARIABLE
> 
> Please move the definition of HUGETLB_PAGE_SIZE_VARIABLE to
> mm/Kconfig and select it from the arch Kconfigfs instead of duplicating
> the definition.

Sure, will do.
