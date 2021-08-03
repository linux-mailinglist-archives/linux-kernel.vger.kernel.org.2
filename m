Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7C43DE4CE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 05:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbhHCDvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 23:51:19 -0400
Received: from foss.arm.com ([217.140.110.172]:42544 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233719AbhHCDvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 23:51:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3219511D4;
        Mon,  2 Aug 2021 20:51:02 -0700 (PDT)
Received: from [10.163.67.68] (unknown [10.163.67.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FF773F70D;
        Mon,  2 Aug 2021 20:50:58 -0700 (PDT)
Subject: Re: [PATCH 10/10] arm64: errata: Add workaround for TSB flush
 failures
To:     Marc Zyngier <maz@kernel.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, will@kernel.org,
        catalin.marinas@arm.com, james.morse@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, mark.rutland@arm.com
References: <20210728135217.591173-1-suzuki.poulose@arm.com>
 <20210728135217.591173-11-suzuki.poulose@arm.com>
 <87mtq5a1gs.wl-maz@kernel.org> <c41330d9-c2a2-afbe-624f-77c1e94f0490@arm.com>
 <477c4943-7c35-8502-0291-4c0ed3a03905@arm.com>
 <32f719c8f9f61b244b3fc29137f76a19@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <eb02839d-b7af-0284-e4ef-8c628e0548d9@arm.com>
Date:   Tue, 3 Aug 2021 09:21:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <32f719c8f9f61b244b3fc29137f76a19@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/21 3:05 PM, Marc Zyngier wrote:
> On 2021-08-02 10:12, Anshuman Khandual wrote:
>> On 7/29/21 4:11 PM, Suzuki K Poulose wrote:
>>> On 29/07/2021 10:55, Marc Zyngier wrote:
>>>> On Wed, 28 Jul 2021 14:52:17 +0100,
>>>> Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> [...]
> 
>>>>> +            __tsb_csync();                        \
>>>>> +            __tsb_csync();                        \
>>>>> +        } else {                            \
>>>>> +            __tsb_csync();                        \
>>>>> +        }                                \
>>>>
>>>> nit: You could keep one unconditional __tsb_csync().
>>>
>>> I thought about that, I was worried if the CPU expects them back to back
>>> without any other instructions in between them. Thinking about it a bit
>>> more, it doesn't look like that is the case. I will confirm this and
>>> change it accordingly.
>> But its a very subtle change which might be difficult to debug and blame
>> later on, if indeed both the instructions need to be back to back. Seems
>> like just better to leave this unchanged.
> 
> Is that an actual requirement? Sounds like you want to find out
> from the errata document.

Sure, will get back on this.

> 
> And if they actually need to be back to back, what ensures that
> this is always called with interrupt disabled?
> 
> You would also need to have them in the same asm block to avoid
> the compiler reordering stuff.

Agreed, both the above constructs will be required to make sure that
the instructions will be executed consecutively (if required).
