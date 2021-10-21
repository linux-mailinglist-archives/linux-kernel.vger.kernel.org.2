Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6D3436CE0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 23:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbhJUVod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 17:44:33 -0400
Received: from foss.arm.com ([217.140.110.172]:48026 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231138AbhJUVoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 17:44:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDFF8D6E;
        Thu, 21 Oct 2021 14:42:15 -0700 (PDT)
Received: from [10.57.25.70] (unknown [10.57.25.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34EF13F73D;
        Thu, 21 Oct 2021 14:42:14 -0700 (PDT)
Subject: Re: [PATCH v6 00/15] arm64: Self-hosted trace related errata
 workarounds
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Will Deacon <will@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Marc Zyngier <maz@kernel.org>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211019163153.3692640-1-suzuki.poulose@arm.com>
 <20211020154207.GA3456574@p14s> <20211021085313.GA15622@willie-the-truck>
 <20211021163531.GA3561043@p14s> <20211021164730.GA16889@willie-the-truck>
 <CANLsYky7NA8km7Xwu_XXFSoqHcQGwYHKsggshcBKsL53e-jEng@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <599078af-e321-01b0-65e8-69020393c00d@arm.com>
Date:   Thu, 21 Oct 2021 22:42:12 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CANLsYky7NA8km7Xwu_XXFSoqHcQGwYHKsggshcBKsL53e-jEng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 21/10/2021 18:11, Mathieu Poirier wrote:
> On Thu, 21 Oct 2021 at 10:47, Will Deacon <will@kernel.org> wrote:
>>
>> Hi Mathieu,
>>
>> [CC Greg]
>>
>> On Thu, Oct 21, 2021 at 10:35:31AM -0600, Mathieu Poirier wrote:
>>> On Thu, Oct 21, 2021 at 09:53:14AM +0100, Will Deacon wrote:
>>>> On Wed, Oct 20, 2021 at 09:42:07AM -0600, Mathieu Poirier wrote:
>>>>> On Tue, Oct 19, 2021 at 05:31:38PM +0100, Suzuki K Poulose wrote:
>>>>>> Suzuki K Poulose (15):
>>>>>>    arm64: Add Neoverse-N2, Cortex-A710 CPU part definition
>>>>>>    arm64: errata: Add detection for TRBE overwrite in FILL mode
>>>>>>    arm64: errata: Add workaround for TSB flush failures
>>>>>>    arm64: errata: Add detection for TRBE write to out-of-range
>>>>>>    coresight: trbe: Add a helper to calculate the trace generated
>>>>>>    coresight: trbe: Add a helper to pad a given buffer area
>>>>>>    coresight: trbe: Decouple buffer base from the hardware base
>>>>>>    coresight: trbe: Allow driver to choose a different alignment
>>>>>>    coresight: trbe: Add infrastructure for Errata handling
>>>>>>    coresight: trbe: Workaround TRBE errata overwrite in FILL mode
>>>>>>    coresight: trbe: Add a helper to determine the minimum buffer size
>>>>>>    coresight: trbe: Make sure we have enough space
>>>>>>    coresight: trbe: Work around write to out of range
>>>>>>    arm64: errata: Enable workaround for TRBE overwrite in FILL mode
>>>>>>    arm64: errata: Enable TRBE workaround for write to out-of-range
>>>>>>      address
>>>>>>
>>>>>>   Documentation/arm64/silicon-errata.rst       |  12 +
>>>>>>   arch/arm64/Kconfig                           | 111 ++++++
>>>>>>   arch/arm64/include/asm/barrier.h             |  16 +-
>>>>>>   arch/arm64/include/asm/cputype.h             |   4 +
>>>>>>   arch/arm64/kernel/cpu_errata.c               |  64 +++
>>>>>>   arch/arm64/tools/cpucaps                     |   3 +
>>>>>>   drivers/hwtracing/coresight/coresight-trbe.c | 394 +++++++++++++++++--
>>>>>>   7 files changed, 567 insertions(+), 37 deletions(-)
>>>>>
>>>>> I have applied this set.
>>>>
>>>> Mathieu -- the plan here (which we have discussed on the list [1]) is
>>>> for the first four patches to be shared with arm64. Since you've gone
>>>> ahead and applied the whole series, please can you provide me a stable
>>>> branch with the first four patches only so that I can include them in
>>>> the arm64 tree?
>>>>
>>>> Failing that, I can create a branch for you to pull and apply the remaining
>>>> patches on top.
>>>>
>>>> Please let me know.
>>>
>>> Coresight patches flow through Greg's tree and as such the coresight-next tree
>>> gets rebased anyway.  I will remove the first 4 patches and push again.  By the
>>> way do you also want to pick up patches 14 and 16 since they are concerned with
>>> "arch/arm64/Kconfig" or should I keep them?
>>
>> I'll take the first 4 and put them on a stable branch, which you can choose
>> to pull if you like (but please don't rebase it or we'll end up with
>> duplicate commits). The rest of the patches, including the later Kconfig
>> changes, are yours but I doubt they'll apply cleanly without the initial
>> changes.
> 
> Right - I just had another look at them and what I suggested above won't work.
> 
>>
>> Are you sure Greg rebases everything? That sounds a bit weird to me, as it
>> means it's impossible to share branches with other trees. How do you usually
>> handle this situation?
> 
> Greg applies the patches I send to him near the end of every cycle -
> see this one [1] as an example.  Unfortunately that way of working
> makes it hard to deal with patchsets such as this one.
> 
> To move forward you can either pick up this whole series (just add my
> RB to all the CS patches) or I start sending pull requests to Greg.

I don't think that may work well, as the CoreSight bits in the series
depend on what is in coresight/next. So this series can't be pulled
in to arm64 without what is already in coresight/next.

Suzuki
