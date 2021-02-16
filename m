Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3A531C5BE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 04:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhBPDMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 22:12:48 -0500
Received: from foss.arm.com ([217.140.110.172]:53770 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229708AbhBPDMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 22:12:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C92631B;
        Mon, 15 Feb 2021 19:12:01 -0800 (PST)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CFCF3F73D;
        Mon, 15 Feb 2021 19:11:57 -0800 (PST)
Subject: Re: [PATCH v2 1/1] arm64: mm: correct the inside linear map
 boundaries during hotplug check
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        James Morris <jmorris@namei.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210215192237.362706-1-pasha.tatashin@soleen.com>
 <20210215192237.362706-2-pasha.tatashin@soleen.com>
 <CAMj1kXGxyV0=s6jVZ674O_2amkYSnwSnubnozbzD6g6GOMJE-A@mail.gmail.com>
 <CA+CK2bA7Xz0Zg5phsQi3mhnp+_PHLAAGRLgFTQNw1FjBHaXsHA@mail.gmail.com>
 <CAMj1kXESuD-von_dtzYcUMwK7TLF=qTki9bd8_iTo_isBwj13g@mail.gmail.com>
 <CA+CK2bDJ7Y2-vEpZrZ0fzigAfDgcJOmjhmin_GjTqioYXAYB3Q@mail.gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <1790afff-eebd-1eda-a1b4-0062908f1f32@arm.com>
Date:   Tue, 16 Feb 2021 08:42:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+CK2bDJ7Y2-vEpZrZ0fzigAfDgcJOmjhmin_GjTqioYXAYB3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/16/21 1:21 AM, Pavel Tatashin wrote:
> On Mon, Feb 15, 2021 at 2:34 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>> On Mon, 15 Feb 2021 at 20:30, Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
>>>
>>>> Can't we simply use signed arithmetic here? This expression works fine
>>>> if the quantities are all interpreted as s64 instead of u64
>>>
>>> I was thinking about that, but I do not like the idea of using sign
>>> arithmetics for physical addresses. Also, I am worried that someone in
>>> the future will unknowingly change it to unsigns or to phys_addr_t. It
>>> is safer to have start explicitly set to 0 in case of wrap.
>>
>> memstart_addr is already a s64 for this exact reason.
> 
> memstart_addr is basically an offset and it must be negative. For
> example, this would not work if it was not signed:
> #define vmemmap ((struct page *)VMEMMAP_START - (memstart_addr >> PAGE_SHIFT))
> 
> However, on powerpc it is phys_addr_t type.
> 
>>
>> Btw, the KASLR check is incorrect: memstart_addr could also be
>> negative when running the 52-bit VA kernel on hardware that is only
>> 48-bit VA capable.
> 
> Good point!
> 
> if (IS_ENABLED(CONFIG_ARM64_VA_BITS_52) && (vabits_actual != 52))
>     memstart_addr -= _PAGE_OFFSET(48) - _PAGE_OFFSET(52);
> 
> So, I will remove IS_ENABLED(CONFIG_RANDOMIZE_BASE) again.
> 
> I am OK to change start_linear_pa, end_linear_pa to signed, but IMO
> what I have now is actually safer to make sure that does not break
> again in the future.
An explicit check for the flip over and providing two different start
addresses points would be required in order to use the new framework.
