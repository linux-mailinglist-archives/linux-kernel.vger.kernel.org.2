Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E5A3474CD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 10:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236256AbhCXJjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 05:39:47 -0400
Received: from foss.arm.com ([217.140.110.172]:59162 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236168AbhCXJjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 05:39:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09E301FB;
        Wed, 24 Mar 2021 02:39:17 -0700 (PDT)
Received: from [10.57.55.187] (unknown [10.57.55.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39BA73F718;
        Wed, 24 Mar 2021 02:39:15 -0700 (PDT)
Subject: Re: [PATCH v5 05/19] arm64: Add support for trace synchronization
 barrier
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org,
        anshuman.khandual@arm.com, maz@kernel.org,
        Will Deacon <will.deacon@arm.com>
References: <20210323120647.454211-1-suzuki.poulose@arm.com>
 <20210323120647.454211-6-suzuki.poulose@arm.com>
 <20210323182142.GA16080@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <7675ab71-c2ff-91e0-5728-fcb216ac1e0d@arm.com>
Date:   Wed, 24 Mar 2021 09:39:13 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210323182142.GA16080@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2021 18:21, Catalin Marinas wrote:
> Hi Suzuki?
> 
> On Tue, Mar 23, 2021 at 12:06:33PM +0000, Suzuki K Poulose wrote:
>> tsb csync synchronizes the trace operation of instructions.
>> The instruction is a nop when FEAT_TRF is not implemented.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> How do you plan to merge these patches? If they go via the coresight
> tree:
> 

Ideally all of this should go via the CoreSight tree to have the 
dependencies solved at one place. But there are some issues :

If this makes to 5.13 queue for CoreSight,

1) CoreSight next is based on rc2 at the moment and we have fixes gone
into rc3 and later, which this series will depend on. (We could move
the next tree forward to a later rc to solve this).

2) There could be conflicts with the kvmarm tree for the KVM host 
changes (That has dependency on the TRBE definitions patch).

If it doesn't make to 5.13 queue, it would be good to have this patch, 
the TRBE defintions and the KVM host patches queued for 5.13 (not sure
if this is acceptable) and we could rebase the CoreSight changes on 5.13
and push it to next release.

I am open for other suggestions.

Marc, Mathieu,

Thoughts ?

> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> 

Thanks
Suzuki

