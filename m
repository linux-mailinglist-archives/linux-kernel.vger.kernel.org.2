Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E582403ACE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 15:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbhIHNkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 09:40:42 -0400
Received: from foss.arm.com ([217.140.110.172]:46618 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229945AbhIHNkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 09:40:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D3966D;
        Wed,  8 Sep 2021 06:39:32 -0700 (PDT)
Received: from [10.57.94.84] (unknown [10.57.94.84])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C69903F766;
        Wed,  8 Sep 2021 06:39:30 -0700 (PDT)
Subject: Re: [PATCH 10/10] arm64: errata: Add workaround for TSB flush
 failures
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, will@kernel.org,
        catalin.marinas@arm.com, james.morse@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, mark.rutland@arm.com
References: <20210728135217.591173-1-suzuki.poulose@arm.com>
 <20210728135217.591173-11-suzuki.poulose@arm.com>
 <87mtq5a1gs.wl-maz@kernel.org> <c41330d9-c2a2-afbe-624f-77c1e94f0490@arm.com>
 <477c4943-7c35-8502-0291-4c0ed3a03905@arm.com>
 <32f719c8f9f61b244b3fc29137f76a19@kernel.org>
 <eb02839d-b7af-0284-e4ef-8c628e0548d9@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <37b9e52a-9790-2d9d-f613-b95b7aa50994@arm.com>
Date:   Wed, 8 Sep 2021 14:39:28 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <eb02839d-b7af-0284-e4ef-8c628e0548d9@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2021 04:51, Anshuman Khandual wrote:
> 
> 
> On 8/2/21 3:05 PM, Marc Zyngier wrote:
>> On 2021-08-02 10:12, Anshuman Khandual wrote:
>>> On 7/29/21 4:11 PM, Suzuki K Poulose wrote:
>>>> On 29/07/2021 10:55, Marc Zyngier wrote:
>>>>> On Wed, 28 Jul 2021 14:52:17 +0100,
>>>>> Suzuki K Poulose <suzuki.poulose@arm.com>
>>
>> [...]
>>
>>>>>> +            __tsb_csync();                        \
>>>>>> +            __tsb_csync();                        \
>>>>>> +        } else {                            \
>>>>>> +            __tsb_csync();                        \
>>>>>> +        }                                \
>>>>>
>>>>> nit: You could keep one unconditional __tsb_csync().
>>>>
>>>> I thought about that, I was worried if the CPU expects them back to back
>>>> without any other instructions in between them. Thinking about it a bit
>>>> more, it doesn't look like that is the case. I will confirm this and
>>>> change it accordingly.
>>> But its a very subtle change which might be difficult to debug and blame
>>> later on, if indeed both the instructions need to be back to back. Seems
>>> like just better to leave this unchanged.
>>
>> Is that an actual requirement? Sounds like you want to find out
>> from the errata document.
> 
> Sure, will get back on this.
> 
>>
>> And if they actually need to be back to back, what ensures that
>> this is always called with interrupt disabled?
>>
>> You would also need to have them in the same asm block to avoid
>> the compiler reordering stuff.
> 
> Agreed, both the above constructs will be required to make sure that
> the instructions will be executed consecutively (if required).
> 


I checked this with our architects and it doesn't have to be in tight
loop. The TSBs are meant to be used with the PE in Trace prohibited
regions (which they are for TRBE and the KVM nvhe stub, TRFCR_ELx 
cleared). As long as that is honored, we are fine. I will update
the patch.

Kind regards
Suzuki

