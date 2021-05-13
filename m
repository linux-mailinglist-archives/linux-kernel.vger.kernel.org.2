Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D926137F283
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 07:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbhEMFOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 01:14:31 -0400
Received: from foss.arm.com ([217.140.110.172]:56890 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229780AbhEMFOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 01:14:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD77F101E;
        Wed, 12 May 2021 22:13:20 -0700 (PDT)
Received: from [10.163.78.16] (unknown [10.163.78.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECE7E3F73B;
        Wed, 12 May 2021 22:13:18 -0700 (PDT)
Subject: Re: [PATCH] arm64/mm: Remove [PUD|PMD]_TABLE_BIT from [pud|pmd]_bad()
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
References: <1620644871-26280-1-git-send-email-anshuman.khandual@arm.com>
 <20210510144337.GA92897@C02TD0UTHF1T.local>
 <4a36d7b7-6b27-31cc-d701-ebe3c6e4946e@arm.com>
 <20210511140708.GC8933@C02TD0UTHF1T.local>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <8023de56-e6d5-8df0-9920-35fe7dbde640@arm.com>
Date:   Thu, 13 May 2021 10:44:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210511140708.GC8933@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/11/21 7:37 PM, Mark Rutland wrote:
> On Tue, May 11, 2021 at 09:21:46AM +0530, Anshuman Khandual wrote:
>>
>> On 5/10/21 8:13 PM, Mark Rutland wrote:
>>> On Mon, May 10, 2021 at 04:37:51PM +0530, Anshuman Khandual wrote:
>>>> Semantics wise, [pud|pmd]_bad() have always implied that a given [PUD|PMD]
>>>> entry does not have a pointer to the next level page table. This had been
>>>> made clear in the commit a1c76574f345 ("arm64: mm: use *_sect to check for
>>>> section maps"). Hence explicitly check for a table entry rather than just
>>>> testing a single bit. This basically redefines [pud|pmd]_bad() in terms of
>>>> [pud|pmd]_table() making the semantics clear.
>>>>
>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>> Cc: Will Deacon <will@kernel.org>
>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>
>>> I have no strong feelings either way, so: 
>>>
>>> Acked-by: Mark Rutland <mark.rutland@arm.com>
>>>
>>> ... that said, I think that the "bad" naming is unclear and misleading,
>>> and it'd be really nice if we could clean that up treewide with
>>> something clearer than "bad".
>>
>> Agreed, the name is misleading.
>>
>>> It does seem that would roughly fit p??_leaf() if we had
>>
>> But what if the platform does not support huge page aka leaf mapping
>> at the given level ? Also a non table i.e bad entry might not always
>> mean a leaf/section/huge page mapping, it could simply imply that the
>> entry is not just pointing to next level and might be just in an bad
>> intermediate or invalid state.
> 
> Ah, so that's also covering swap entries, too? It's not entirely clear
> to me what "bad intermediate or invalid state" means, because I assume
> it's not arbitrary junk or this wouldn't be sound genrally.

Intermediate states like swap, migration or probably even splitting THP.
Though I am not really sure whether pxx_bad() only gets used for valid
table or leaf entries i.e things which are mapped. Hence checking just
for non table entry is better and even safer, than looking out for what
other states the entry could be in.

> 
> I had assumed it was only covering *valid* non-table entries.
> 
>>> p??_clear_leaf() and p??_none_or_clear_leaf() helpers.
>>
>> Could you please elaborate how these new helpers might help define
>> pxx_bad() ?
> 
> This was based on my (evidently wrong) prior understanding above.
> 
> Thanks,
> Mark.
> 
