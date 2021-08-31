Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7807B3FC1A8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 05:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239747AbhHaDp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 23:45:26 -0400
Received: from foss.arm.com ([217.140.110.172]:50670 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239631AbhHaDpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 23:45:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1C021FB;
        Mon, 30 Aug 2021 20:44:30 -0700 (PDT)
Received: from [10.163.72.217] (unknown [10.163.72.217])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 772CD3F5A1;
        Mon, 30 Aug 2021 20:44:29 -0700 (PDT)
Subject: Re: [PATCH V2] arm64/mm: Drop <asm/page-def.h>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
References: <1629457516-32306-1-git-send-email-anshuman.khandual@arm.com>
 <20210820183520.GC23080@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <84b647b6-9cee-5aad-78f8-7bc253300534@arm.com>
Date:   Tue, 31 Aug 2021 09:15:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210820183520.GC23080@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/21/21 12:05 AM, Catalin Marinas wrote:
> On Fri, Aug 20, 2021 at 04:35:16PM +0530, Anshuman Khandual wrote:
>> PAGE_SHIFT (PAGE_SIZE and PAGE_MASK) which is derived from ARM64_PAGE_SHIFT
>> should be moved into <asm/page.h> instead like in case for other platforms,
>> and then subsequently <asm/page-def.h> can be just dropped off completely.
> 
> These were moved to page-def.h as part of commit b6531456ba27 ("arm64:
> factor out PAGE_* and CONT_* definitions") to avoid some circular header
> dependencies.
> 
>> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
>> index 824a3655dd93..649d26396f9e 100644
>> --- a/arch/arm64/include/asm/memory.h
>> +++ b/arch/arm64/include/asm/memory.h
>> @@ -12,7 +12,7 @@
>>  
>>  #include <linux/const.h>
>>  #include <linux/sizes.h>
>> -#include <asm/page-def.h>
>> +#include <asm/page.h>
> 
> In 5.14-rc3, asm/page.h still includes asm/memory.h.

Dropping <asm/memory.h> from <asm/page.h> does not seem to cause
any problem, will change that. Afterwards build tested it across
page sizes and also with some random configs. Is that circular
dependency still present ? Also wondering why was <asm/memory.h>
included in <asm/page.h> to begin with ?
