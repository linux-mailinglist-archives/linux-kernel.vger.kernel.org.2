Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B48345B36
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhCWJpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:45:14 -0400
Received: from foss.arm.com ([217.140.110.172]:42940 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230139AbhCWJoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:44:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 632F31042;
        Tue, 23 Mar 2021 02:44:44 -0700 (PDT)
Received: from [10.57.55.187] (unknown [10.57.55.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCB8E3F718;
        Tue, 23 Mar 2021 02:44:42 -0700 (PDT)
Subject: Re: [PATCH v4 05/19] kvm: arm64: Disable guest access to trace filter
 controls
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com,
        leo.yan@linaro.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20210225193543.2920532-1-suzuki.poulose@arm.com>
 <20210225193543.2920532-6-suzuki.poulose@arm.com>
 <cbe4ef17-38f9-c555-d838-796be752d4a3@arm.com>
 <8cb6eced29d9749d88af6f6d2f649019@kernel.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <59682421-a985-ec71-3ade-09c17aa58b5a@arm.com>
Date:   Tue, 23 Mar 2021 09:44:41 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <8cb6eced29d9749d88af6f6d2f649019@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2021 09:16, Marc Zyngier wrote:
> Hi Suzuki,
> 
> On 2021-03-22 22:24, Suzuki K Poulose wrote:
>> Hi Marc,
>>
>> On 25/02/2021 19:35, Suzuki K Poulose wrote:
>>> Disable guest access to the Trace Filter control registers.
>>> We do not advertise the Trace filter feature to the guest
>>> (ID_AA64DFR0_EL1: TRACE_FILT is cleared) already, but the guest
>>> can still access the TRFCR_EL1 unless we trap it.
>>>
>>> This will also make sure that the guest cannot fiddle with
>>> the filtering controls set by a nvhe host.
>>>
>>> Cc: Marc Zyngier <maz@kernel.org>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>
>> We have already have the v8.4 self hosted tracing support in 5.12-rcX.
>> Do you think you can pick this up for this 5.12 ?
> 
> Sure, no problem. Shall I pick patch #3 at the same time?

Yes please.

Thanks !
Suzuki
