Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFED41410D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 07:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbhIVFHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 01:07:55 -0400
Received: from foss.arm.com ([217.140.110.172]:42956 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231836AbhIVFHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 01:07:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C8A611B3;
        Tue, 21 Sep 2021 22:06:23 -0700 (PDT)
Received: from [10.163.73.113] (unknown [10.163.73.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE0E43F40C;
        Tue, 21 Sep 2021 22:06:20 -0700 (PDT)
Subject: Re: [PATCH V2] arm64/mm: Add pud_sect_supported()
To:     Itaru Kitayama <itaru.kitayama@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
References: <1632130171-472-1-git-send-email-anshuman.khandual@arm.com>
 <YUirurhvmBPCOsS+@arm.com> <127b2334-5c40-1b71-e510-ac837c3ac614@arm.com>
 <CANW9uyveSs-+DgGr87jYtruYcS7_FMxS=VD7mM4-G8NNcqBqNQ@mail.gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <da59cd2e-9666-b236-8b23-49bd51a1c784@arm.com>
Date:   Wed, 22 Sep 2021 10:37:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CANW9uyveSs-+DgGr87jYtruYcS7_FMxS=VD7mM4-G8NNcqBqNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/21 10:22 AM, Itaru Kitayama wrote:
> How did you test the 16K page size configurations? In QEMU? I wasn't
> aware of hardware that's capable 16KB page size.

FVP (Fixed Virtual Platforms).

> 
> On Wed, Sep 22, 2021 at 1:47 PM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>>
>>
>>
>> On 9/20/21 9:11 PM, Catalin Marinas wrote:
>>> On Mon, Sep 20, 2021 at 02:59:31PM +0530, Anshuman Khandual wrote:
>>>> Section mapping at PUD level is supported only on 4K pages and currently it
>>>> gets verified with explicit #ifdef or IS_ENABLED() constructs. This adds a
>>>> new helper pud_sect_supported() for this purpose, which particularly cleans
>>>> up the HugeTLB code path. It updates relevant switch statements with checks
>>>> for __PAGETABLE_PMD_FOLDED in order to avoid build failures caused with two
>>>> identical switch case values in those code blocks.
>>>>
>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>> Cc: Will Deacon <will@kernel.org>
>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Suggested-by: Mark Rutland <mark.rutland@arm.com>
>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>
>>> Assuming that you tested the corresponding configurations,
>>
>> Right, I did test this on all page size and VA bits configurations
>> , including the specific ones which were problematic.
>>
>>>
>>> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
