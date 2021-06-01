Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E0A3972FC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 14:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbhFAMIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 08:08:24 -0400
Received: from foss.arm.com ([217.140.110.172]:48436 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231201AbhFAMIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 08:08:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4330C6D;
        Tue,  1 Jun 2021 05:06:40 -0700 (PDT)
Received: from [10.57.73.64] (unknown [10.57.73.64])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 094DF3F73D;
        Tue,  1 Jun 2021 05:06:38 -0700 (PDT)
Subject: Re: [PATCH v5 08/14] arm64: Import latest optimization of memcpy
To:     Sunil Kovvuri <sunil.kovvuri@gmail.com>,
        Oliver Swede <oli.swede@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        linux-arm-kernel@lists.indradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Sunil Goutham <sgoutham@marvell.com>,
        George Cherian <gcherian@marvell.com>
References: <20200914150958.2200-1-oli.swede@arm.com>
 <20200914150958.2200-9-oli.swede@arm.com>
 <CA+sq2CfGu+JPJ9h3Q-nCdmM2erqWbe=p-v_eip-J-R6F2EoXbw@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <5156db7f-09a7-b0fa-d246-b024e40775fc@arm.com>
Date:   Tue, 1 Jun 2021 13:06:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CA+sq2CfGu+JPJ9h3Q-nCdmM2erqWbe=p-v_eip-J-R6F2EoXbw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-01 11:03, Sunil Kovvuri wrote:
> On Mon, Sep 14, 2020 at 8:44 PM Oliver Swede <oli.swede@arm.com> wrote:
>>
>> From: Sam Tebbs <sam.tebbs@arm.com>
>>
>> Import the latest memcpy implementation into memcpy,
>> copy_{from, to and in}_user.
>> The implementation of the user routines is separated into two forms:
>> one for when UAO is enabled and one for when UAO is disabled, with
>> the two being chosen between with a runtime patch.
>> This avoids executing the many NOPs emitted when UAO is disabled.
>>
>> The project containing optimized implementations for various library
>> functions has now been renamed from 'cortex-strings' to
>> 'optimized-routines', and the new upstream source is
>> string/aarch64/memcpy.S as of commit 4c175c8be12 in
>> https://github.com/ARM-software/optimized-routines.
>>
>> Signed-off-by: Sam Tebbs <sam.tebbs@arm.com>
>> [ rm: add UAO fixups, streamline copy_exit paths, expand commit message ]
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> [ os: import newer memcpy algorithm, update commit message ]
>> Signed-off-by: Oliver Swede <oli.swede@arm.com>
>> ---
>>   arch/arm64/include/asm/alternative.h |  36 ---
>>   arch/arm64/lib/copy_from_user.S      | 113 ++++++--
>>   arch/arm64/lib/copy_in_user.S        | 129 +++++++--
>>   arch/arm64/lib/copy_template.S       | 375 +++++++++++++++------------
>>   arch/arm64/lib/copy_template_user.S  |  24 ++
>>   arch/arm64/lib/copy_to_user.S        | 112 ++++++--
>>   arch/arm64/lib/copy_user_fixup.S     |  14 +
>>   arch/arm64/lib/memcpy.S              |  47 ++--
>>   8 files changed, 557 insertions(+), 293 deletions(-)
>>   create mode 100644 arch/arm64/lib/copy_template_user.S
>>   create mode 100644 arch/arm64/lib/copy_user_fixup.S
> 
> Do you have any performance data with this patch ?
> I see these patches are still not pushed to mainline, any reasons ?

Funny you should pick up on the 6-month-old thread days after I've been 
posting new versions of the relevant parts[1] :)

I think this series mostly stalled on the complexity of the usercopy 
parts, which then turned into even more of a moving target anyway, hence 
why I decided to split it up.

> Also curious to know why 128bit registers are not considered, similar to
> https://android.googlesource.com/platform/bionic.git/+/a71b4c3f144a516826e8ac5b262099b920c49ce0/libc/arch-arm64/generic-neon/bionic/memcpy.S

The overhead of kernel_neon_begin() etc. is significant, and usually 
only worth it in places like the crypto routines where there's enough 
benefit from actual ASIMD computation to outweigh the save/restore cost. 
On smaller cores where the L1 interface is only 128 bits wide anyway 
there is no possible gain in memcpy() throughput to ever offset that 
cost, and even for wider microarchitectures it's only likely to start 
breaking even at relatively large copy sizes. Plus we can't necessarily 
assume the ASIMD registers are even present (apparently the lack of a 
soft-float ABI hasn't stopped people from wanting to run Linux on such 
systems...)

Robin.

[1] 
https://lore.kernel.org/linux-arm-kernel/cover.1622128527.git.robin.murphy@arm.com/
