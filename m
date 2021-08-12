Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B123EA1A6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 11:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbhHLJNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 05:13:11 -0400
Received: from foss.arm.com ([217.140.110.172]:40576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231392AbhHLJNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 05:13:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D29711FB;
        Thu, 12 Aug 2021 02:12:44 -0700 (PDT)
Received: from [10.163.68.17] (unknown [10.163.68.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA3543F718;
        Thu, 12 Aug 2021 02:12:39 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [RFC V2 10/10] arm64/mm: Enable CONFIG_ARM64_PA_BITS_52 on
 CONFIG_ARM64_[4K|16K]_PAGES
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        suzuki.poulose@arm.com, mark.rutland@arm.com, will@kernel.org,
        maz@kernel.org, james.morse@arm.com, steven.price@arm.com
References: <1627281445-12445-1-git-send-email-anshuman.khandual@arm.com>
 <1627281445-12445-11-git-send-email-anshuman.khandual@arm.com>
 <20210805172314.GF6719@arm.com>
Message-ID: <a3eb7cc3-8f31-c70b-1830-830e10605d50@arm.com>
Date:   Thu, 12 Aug 2021 14:43:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210805172314.GF6719@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/5/21 10:53 PM, Catalin Marinas wrote:
> On Mon, Jul 26, 2021 at 12:07:25PM +0530, Anshuman Khandual wrote:
>> All required FEAT_LPA2 components for 52 bit PA range are already in place.
>> Just enable CONFIG_ARM64_PA_BITS_52 on 4K and 16K pages which would select
>> CONFIG_ARM64_PA_BITS_52_LPA2 activating 52 bit PA range via FEAT_LPA2.
>>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 1999ac6..ce139415 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -952,9 +952,9 @@ config ARM64_PA_BITS_48
>>  
>>  config ARM64_PA_BITS_52
>>  	bool "52-bit (ARMv8.2)"
>> -	depends on ARM64_64K_PAGES
>>  	depends on ARM64_PAN || !ARM64_SW_TTBR0_PAN
>>  	select ARM64_PA_BITS_52_LPA if ARM64_64K_PAGES
>> +	select ARM64_PA_BITS_52_LPA2 if (ARM64_4K_PAGES  || ARM64_16K_PAGES)
>>  	help
>>  	  Enable support for a 52-bit physical address space, introduced as
>>  	  part of the ARMv8.2-LPA extension.
> 
> If you do it this way, the text here needs updating and the 8.2
> architecture version removed.

Sure, will update as required.
