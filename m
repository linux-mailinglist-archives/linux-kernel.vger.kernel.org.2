Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C123EBBED
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 20:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbhHMSSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 14:18:32 -0400
Received: from foss.arm.com ([217.140.110.172]:56486 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229607AbhHMSSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 14:18:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D987DD6E;
        Fri, 13 Aug 2021 11:18:03 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44BC53F70D;
        Fri, 13 Aug 2021 11:18:02 -0700 (PDT)
Subject: Re: [PATCH 2/5] arm64: Handle UNDEF in the EL2 stub vectors
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, kernel-team@android.com
References: <20210812190213.2601506-1-maz@kernel.org>
 <20210812190213.2601506-3-maz@kernel.org>
 <2f6bf17f-d235-8311-13d5-dcb3d00e23c4@arm.com> <87im091bu7.wl-maz@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <060ef66a-6d6f-082e-5f69-117235b8ce4e@arm.com>
Date:   Fri, 13 Aug 2021 19:17:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87im091bu7.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-13 18:41, Marc Zyngier wrote:
> On Fri, 13 Aug 2021 14:08:23 +0100,
> Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2021-08-12 20:02, Marc Zyngier wrote:
>>> As we want to handle the silly case where HVC has been disabled
>>> from EL3, augment our ability to handle exception at EL2.
>>>
>>> Check for unknown exceptions (usually UNDEF) coming from EL2,
>>> and treat them as a failing HVC call into the stubs. While
>>> this isn't great and obviously doesn't catter for the gigantic
>>> range of possible exceptions, it isn't any worse than what we
>>> have today.
>>>
>>> Just don't try and use it for anything else.
>>>
>>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>>> ---
>>>    arch/arm64/kernel/hyp-stub.S | 19 ++++++++++++++++++-
>>>    1 file changed, 18 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
>>> index 43d212618834..026a34515b21 100644
>>> --- a/arch/arm64/kernel/hyp-stub.S
>>> +++ b/arch/arm64/kernel/hyp-stub.S
>>> @@ -46,7 +46,16 @@ SYM_CODE_END(__hyp_stub_vectors)
>>>    	.align 11
>>>      SYM_CODE_START_LOCAL(elx_sync)
>>> -	cmp	x0, #HVC_SET_VECTORS
>>> +	mrs	x4, spsr_el2
>>> +	and	x4, x4, #PSR_MODE_MASK
>>> +	orr	x4, x4, #1
>>> +	cmp	x4, #PSR_MODE_EL2h
>>> +	b.ne	0f
>>> +	mrs	x4, esr_el2
>>> +	eor	x4, x4, #ESR_ELx_IL
>>> +	cbz	x4, el2_undef
>>
>> Hmm, might it be neater to check ESR_EL2.ISS to see if we landed here
>> for any reason *other* than a successfully-executed HVC?
> 
> We absolutely could. However, the sixpence question (yes, that's the
> Brexit effect for you) is "what do you do with exceptions that are
> neither UNDEF now HVC?".
> 
> We are taking a leap of faith by assuming that the only thing that
> will UNDEF at EL2 while the stubs are installed is HVC. If anything
> else occurs, I have no idea what to do with it. I guess we could always
> ignore it instead of treating it as a HVC (as it is done at the
> moment).

Right, I think that concern applies pretty much equally whichever way 
you slice it. "Any exception other than an unknown from EL2 must imply 
HVC" doesn't seem any less sketchy than "Any exception other than HVC 
implies something is horribly wrong and abandoning EL2 might be wise" to 
me, but it was primarily that the latter avoids having to faff with the 
SPSR as well. No big deal either way, just one of my "I reckon this 
could be shorter..." musings; it's been particularly Friday today :)

Robin.
