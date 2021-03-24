Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B4B347DA2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 17:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbhCXQZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 12:25:43 -0400
Received: from foss.arm.com ([217.140.110.172]:35908 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234343AbhCXQZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 12:25:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D27ED6E;
        Wed, 24 Mar 2021 09:25:15 -0700 (PDT)
Received: from [10.57.51.32] (unknown [10.57.51.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3CFB3F7D7;
        Wed, 24 Mar 2021 09:25:13 -0700 (PDT)
Subject: Re: [PATCH v5 05/19] arm64: Add support for trace synchronization
 barrier
To:     Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, anshuman.khandual@arm.com,
        Will Deacon <will.deacon@arm.com>
References: <20210323120647.454211-1-suzuki.poulose@arm.com>
 <20210323120647.454211-6-suzuki.poulose@arm.com>
 <20210323182142.GA16080@arm.com>
 <7675ab71-c2ff-91e0-5728-fcb216ac1e0d@arm.com> <875z1gk6fo.wl-maz@kernel.org>
 <1b5e5bb2-b89f-fa35-0a8b-8c5476cb9ff6@arm.com> <871rc4jzn0.wl-maz@kernel.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <17e57b01-840b-dbeb-c09f-1c04becb8749@arm.com>
Date:   Wed, 24 Mar 2021 16:25:12 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <871rc4jzn0.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2021 16:16, Marc Zyngier wrote:
> On Wed, 24 Mar 2021 15:51:14 +0000,
> Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>> On 24/03/2021 13:49, Marc Zyngier wrote:
>>> On Wed, 24 Mar 2021 09:39:13 +0000,
>>> Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>>>
>>>> On 23/03/2021 18:21, Catalin Marinas wrote:
>>>>> Hi Suzuki?
>>>>>
>>>>> On Tue, Mar 23, 2021 at 12:06:33PM +0000, Suzuki K Poulose wrote:
>>>>>> tsb csync synchronizes the trace operation of instructions.
>>>>>> The instruction is a nop when FEAT_TRF is not implemented.
>>>>>>
>>>>>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>>>>>> Cc: Mike Leach <mike.leach@linaro.org>
>>>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>>>> Cc: Will Deacon <will.deacon@arm.com>
>>>>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>>>
>>>>> How do you plan to merge these patches? If they go via the coresight
>>>>> tree:
>>>>>
>>>>
>>>> Ideally all of this should go via the CoreSight tree to have the
>>>> dependencies solved at one place. But there are some issues :
>>>>
>>>> If this makes to 5.13 queue for CoreSight,
>>>>
>>>> 1) CoreSight next is based on rc2 at the moment and we have fixes gone
>>>> into rc3 and later, which this series will depend on. (We could move
>>>> the next tree forward to a later rc to solve this).
>>>>
>>>> 2) There could be conflicts with the kvmarm tree for the KVM host
>>>> changes (That has dependency on the TRBE definitions patch).
>>>>
>>>> If it doesn't make to 5.13 queue, it would be good to have this patch,
>>>> the TRBE defintions and the KVM host patches queued for 5.13 (not sure
>>>> if this is acceptable) and we could rebase the CoreSight changes on 5.13
>>>> and push it to next release.
>>>>
>>>> I am open for other suggestions.
>>>>
>>>> Marc, Mathieu,
>>>>
>>>> Thoughts ?
>>>
>>> I was planning to take the first two patches in 5.12 as fixes (they
>>> are queued already, and would hopefully land in -rc5). If that doesn't
>>> fit with the plan, please let me know ASAP.
>>
>> Marc,
>>
>> I think it would be better to hold on pushing those patches until we
>> have a clarity on how things will go.
> 
> OK. I thought there was a need for these patches to prevent guest
> access to the v8.4 self hosted tracing feature that went in 5.12
> though[1]... Did I get it wrong?

Yes, that is correct. The guest could access the Trace Filter Control 
register and fiddle with the host settings, without this patch.
e.g, it could disable tracing at EL0/EL1, without the host being
aware on nVHE host.

Cheers
Suzuki
