Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12ED13EA2CB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 12:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhHLKJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 06:09:27 -0400
Received: from foss.arm.com ([217.140.110.172]:41572 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236234AbhHLKJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 06:09:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5C3F1042;
        Thu, 12 Aug 2021 03:08:56 -0700 (PDT)
Received: from [10.163.68.17] (unknown [10.163.68.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CF043F718;
        Thu, 12 Aug 2021 03:08:53 -0700 (PDT)
Subject: Re: [RFC V2 05/10] arm64/mm: Add CONFIG_ARM64_PA_BITS_52_[LPA|LPA2]
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        suzuki.poulose@arm.com, mark.rutland@arm.com, will@kernel.org,
        maz@kernel.org, james.morse@arm.com, steven.price@arm.com
References: <1627281445-12445-1-git-send-email-anshuman.khandual@arm.com>
 <1627281445-12445-6-git-send-email-anshuman.khandual@arm.com>
 <20210805172550.GG6719@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <44a3f3e2-ee11-09b1-69cf-210aa2f6ddb5@arm.com>
Date:   Thu, 12 Aug 2021 15:39:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210805172550.GG6719@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/5/21 10:55 PM, Catalin Marinas wrote:
> On Mon, Jul 26, 2021 at 12:07:20PM +0530, Anshuman Khandual wrote:
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index b5b13a9..1999ac6 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -934,6 +934,12 @@ config ARM64_VA_BITS
>>  	default 48 if ARM64_VA_BITS_48
>>  	default 52 if ARM64_VA_BITS_52
>>  
>> +config ARM64_PA_BITS_52_LPA
>> +	bool
>> +
>> +config ARM64_PA_BITS_52_LPA2
>> +	bool
>> +
>>  choice
>>  	prompt "Physical address space size"
>>  	default ARM64_PA_BITS_48
>> @@ -948,6 +954,7 @@ config ARM64_PA_BITS_52
>>  	bool "52-bit (ARMv8.2)"
>>  	depends on ARM64_64K_PAGES
>>  	depends on ARM64_PAN || !ARM64_SW_TTBR0_PAN
>> +	select ARM64_PA_BITS_52_LPA if ARM64_64K_PAGES
>>  	help
>>  	  Enable support for a 52-bit physical address space, introduced as
>>  	  part of the ARMv8.2-LPA extension.
> 
> Do we actually need to bother with LPA, LPA2 options? We could just add

These are internal configs for code organization purpose, which otherwise
becomes bit entangled. Basically these configs just imply the following
combinations being selected together.

- ARM64_PA_BITS_52_LPA	: ARM64_64K_PAGES && ARM64_PA_BITS_52
- ARM64_PA_BITS_52_LPA2	: (ARM64_4K_PAGES || ARM64_16K_PAGES) && ARM64_PA_BITS_52

There are some benefits here

- ARM64_PA_BITS_52_[LPA|LPA2] helps in avoiding writing out code blocks for
  these above combinations in various different places, keeps it clean.

- Cleanly encapsulates ARM64_PA_BITS_52 implementation into two different
  logical code blocks depending on the respective HW features enabling it
  i.e FEAT_LPA and FEAT_LPA2. This is important because there are distinct
  pte <----> phys encodings, ptdump handling, setting TCR_DS, FEAT_LPA2
  detection, PTE sharability attribute handling which are dependent on how
  52 bits PA is implemented.

> an extra defined(ARM64_64K_PAGES) in places, it may be easier to follow
> in a few years time when we won't remember what LPA or LPA2 was. I

Are you suggesting that over the years, folks might forget about LPA/LPA2
details and might have to look back in arch/arm64/Kconfig to figure this
out, which is not desirable ? But would not that be an acceptable trade
off given the encapsulation it helps achieve ?

> haven't got to the rest of the patches but it may just be simpler to
> define the shifts separately for 52-bit based on 4K/16K/64K and ignore
> the LPA/LPA2 distinction altogether (we'll still keep it for CPUID
> checking though).
> 

Sure. After you have gone through and reviewed rest of the series, if it
still appears that dropping LPA/LPA2 distinction here would be simpler
from a long term perspective, will be happy to change it accordingly.
