Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8BB0433712
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 15:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbhJSNcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 09:32:31 -0400
Received: from foss.arm.com ([217.140.110.172]:49380 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235817AbhJSNca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 09:32:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 598A42F;
        Tue, 19 Oct 2021 06:30:16 -0700 (PDT)
Received: from [10.57.25.70] (unknown [10.57.25.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 918433F70D;
        Tue, 19 Oct 2021 06:30:05 -0700 (PDT)
Subject: Re: [PATCH v5 04/15] arm64: errata: Add detection for TRBE write to
 out-of-range
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     will@kernel.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, maz@kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
References: <20211014223125.2605031-1-suzuki.poulose@arm.com>
 <20211014223125.2605031-5-suzuki.poulose@arm.com>
 <20211018155041.GA3163131@p14s>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <928f02ab-8226-1679-a120-06778d03c93c@arm.com>
Date:   Tue, 19 Oct 2021 14:29:58 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211018155041.GA3163131@p14s>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2021 16:50, Mathieu Poirier wrote:
> Good morning,
> 
> On Thu, Oct 14, 2021 at 11:31:14PM +0100, Suzuki K Poulose wrote:
>> Arm Neoverse-N2 and Cortex-A710 cores are affected by an erratum where the
>> trbe, under some circumstances, might write upto 64bytes to an address after
> 
> Checkpatch gives me a warning about this line...
> 
>> the Limit as programmed by the TRBLIMITR_EL1.LIMIT. This might -
>>
>>    - Corrupt a page in the ring buffer, which may corrupt trace from a
>>      previous session, consumed by userspace.
>>    - Hit the guard page at the end of the vmalloc area and raise a fault.
>>
>> To keep the handling simpler, we always leave the last page from the
>> range, which TRBE is allowed to write. This can be achieved by ensuring
>> that we always have more than a PAGE worth space in the range, while
>> calculating the LIMIT for TRBE. And then the LIMIT pointer can be adjusted
>> to leave the PAGE (TRBLIMITR.LIMIT -= PAGE_SIZE), out of the TRBE range
>> while enabling it. This makes sure that the TRBE will only write to an area
>> within its allowed limit (i.e, [head-head+size]) and we do not have to handle
> 
> I'm pretty sure this line will also be flagged.
> 

Thanks for pointing them out. I have fixed it now.

Suzuki
