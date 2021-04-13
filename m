Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C5435D4AA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 03:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240385AbhDMBIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 21:08:36 -0400
Received: from foss.arm.com ([217.140.110.172]:34156 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239318AbhDMBIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 21:08:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7EB5106F;
        Mon, 12 Apr 2021 18:08:16 -0700 (PDT)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB2793F792;
        Mon, 12 Apr 2021 18:08:11 -0700 (PDT)
Subject: Re: [PATCH V2 4/6] mm: Drop redundant
 ARCH_ENABLE_[HUGEPAGE|THP]_MIGRATION
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
References: <1617259448-22529-1-git-send-email-anshuman.khandual@arm.com>
 <1617259448-22529-5-git-send-email-anshuman.khandual@arm.com>
 <20210412115952.GC27818@linux>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <3ae8627b-68dc-8a86-fbf0-5e65e25ebffb@arm.com>
Date:   Tue, 13 Apr 2021 06:38:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210412115952.GC27818@linux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/21 5:29 PM, Oscar Salvador wrote:
> On Thu, Apr 01, 2021 at 12:14:06PM +0530, Anshuman Khandual wrote:
>> ARCH_ENABLE_[HUGEPAGE|THP]_MIGRATION configs have duplicate definitions on
>> platforms that subscribe them. Drop these reduntant definitions and instead
>> just select them appropriately.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: x86@kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Acked-by: Catalin Marinas <catalin.marinas@arm.com> (arm64)
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> Hi Anshuman, 
> 
> X86 needs fixing, see below:
> 
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 503d8b2e8676..10702ef1eb57 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -60,8 +60,10 @@ config X86
>>  	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
>>  	select ARCH_32BIT_OFF_T			if X86_32
>>  	select ARCH_CLOCKSOURCE_INIT
>> +	select ARCH_ENABLE_HUGEPAGE_MIGRATION if x86_64 && HUGETLB_PAGE && MIGRATION
>>  	select ARCH_ENABLE_MEMORY_HOTPLUG if X86_64 || (X86_32 && HIGHMEM)
>>  	select ARCH_ENABLE_MEMORY_HOTREMOVE if MEMORY_HOTPLUG
>> +	select ARCH_ENABLE_THP_MIGRATION if x86_64 && TRANSPARENT_HUGEPAGE
> 
> you need s/x86_64/X86_64/, otherwise we are left with no migration :-)

Ahh, right. I guess this could not have got detected during a build test.
As the series is in mmotm tree, wondering if Andrew could help fix these
typos in this patch.
