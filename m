Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6277230732C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 10:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbhA1Juk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 04:50:40 -0500
Received: from foss.arm.com ([217.140.110.172]:55570 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231468AbhA1Jtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 04:49:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 482CC1042;
        Thu, 28 Jan 2021 01:48:50 -0800 (PST)
Received: from [10.57.45.249] (unknown [10.57.45.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E73AC3F766;
        Thu, 28 Jan 2021 01:48:47 -0800 (PST)
Subject: Re: [PATCH V3 10/14] arm64: nvhe: Allow TRBE access at EL1
To:     Marc Zyngier <maz@kernel.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        lcherian@marvell.com, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-11-git-send-email-anshuman.khandual@arm.com>
 <12b1572e2568d4936f0458649065fe64@kernel.org>
 <d0daf831-3340-87f2-a021-0b775ce7af2a@arm.com>
 <05c4cde3da791e7effd6196a197f5c98@kernel.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <7a3252ae-8b8e-1d60-9ce5-5291e33ae8c8@arm.com>
Date:   Thu, 28 Jan 2021 09:48:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <05c4cde3da791e7effd6196a197f5c98@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/21 9:46 AM, Marc Zyngier wrote:
> On 2021-01-28 09:34, Suzuki K Poulose wrote:
>> On 1/27/21 9:58 AM, Marc Zyngier wrote:
>>> On 2021-01-27 08:55, Anshuman Khandual wrote:
>>>> From: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>>
>>>> When the kernel is booted at EL2 in a nvhe configuration,
>>>> enable the TRBE access to the EL1. The EL1 still can't trace
>>>> EL2, unless EL2 permits explicitly via TRFCR_EL2.E2TRE.
>>>>
>>>> Cc: Will Deacon <will@kernel.org>
>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>> Cc: Marc Zyngier <maz@kernel.org>
>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>> cc: Anshuman Khandual <anshuman.khandual@arm.com>
>>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>
>>> Acked-by: Marc Zyngier <maz@kernel.org>
>>>
>>> One comment below, though:
>>>
>>>> ---
>>>>  arch/arm64/include/asm/el2_setup.h | 19 +++++++++++++++++++
>>>>  arch/arm64/include/asm/kvm_arm.h   |  2 ++
>>>>  2 files changed, 21 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/include/asm/el2_setup.h
>>>> b/arch/arm64/include/asm/el2_setup.h
>>>> index a7f5a1b..05ecce9 100644
>>>> --- a/arch/arm64/include/asm/el2_setup.h
>>>> +++ b/arch/arm64/include/asm/el2_setup.h
>>>> @@ -72,6 +72,25 @@
>>>>  .endif
>>>>
>>>>  3:
>>>> +
>>>> +.ifeqs    "\mode", "nvhe"
>>>> +    /*
>>>> +     * If the Trace Buffer is available, allow
>>>> +     * the EL1 to own it. Note that EL1 cannot
>>>> +     * trace the EL2, as it is prevented by
>>>> +     * TRFCR_EL2.E2TRE == 0.
>>>> +     */
>>>> +    ubfx    x0, x1, #ID_AA64DFR0_TRBE_SHIFT, #4
>>>> +    cbz    x0, 1f
>>>> +
>>>> +    mrs_s    x0, SYS_TRBIDR_EL1
>>>> +    and    x0, x0, TRBIDR_PROG
>>>> +    cbnz    x0, 1f
>>>> +    mov    x0, #(MDCR_EL2_E2TB_EL1_OWN << MDCR_EL2_E2TB_SHIFT)
>>>> +    orr    x2, x2, x0
>>>> +.endif
>>>> +
>>>> +1:
>>>
>>> Note that this will (badly) conflict with the late-VHE patches[1],
>>> where this code path has been reworked.
>>
>> Thanks for the heads up. We will need to see how things get merged.
>> Ideally this patch and the previous one (TRBE definitions could go
>> via the arm64 tree / kvm tree), in which case we could rebase these
>> two patches on the respective tree.
> 
> I think the current plan of action is to go via the arm64 tree,
> given that there is nothing really KVM specific there. I'll respin
> the series one last (hopefully!) time on Monday. Let me know if
> you need a hand with the rebasing.

Sounds good, will rebase it on top of that then.

Cheers
Suzuki
