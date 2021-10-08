Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C325142673A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 11:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238638AbhJHJ7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 05:59:12 -0400
Received: from foss.arm.com ([217.140.110.172]:39386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236118AbhJHJ7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 05:59:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E40B5D6E;
        Fri,  8 Oct 2021 02:57:11 -0700 (PDT)
Received: from [10.57.73.246] (unknown [10.57.73.246])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0B513F70D;
        Fri,  8 Oct 2021 02:57:09 -0700 (PDT)
Subject: Re: [PATCH v2 00/17] arm64: Self-hosted trace related errata
 workarounds
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        james.morse@arm.com, anshuman.khandual@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, mathieu.poirier@linaro.org,
        lcherian@marvell.com, coresight@lists.linaro.org
References: <20210921134121.2423546-1-suzuki.poulose@arm.com>
 <20211008073229.GB32625@willie-the-truck>
 <b2527493-d4ca-2c42-eb22-7e8ddbe50279@arm.com>
 <20211008095255.GA790@willie-the-truck>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <45486d40-3a9d-8011-8fed-6f54eaca9b0b@arm.com>
Date:   Fri, 8 Oct 2021 10:57:08 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211008095255.GA790@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/2021 10:52, Will Deacon wrote:
> On Fri, Oct 08, 2021 at 10:25:03AM +0100, Suzuki K Poulose wrote:
>> Hi Will
>>
>> On 08/10/2021 08:32, Will Deacon wrote:
>>> Hi Suzuki,
>>>
>>> On Tue, Sep 21, 2021 at 02:41:04PM +0100, Suzuki K Poulose wrote:
>>>> This series adds CPU erratum work arounds related to the self-hosted
>>>> tracing. The list of affected errata handled in this series are :
>>>>
>>>>    * TRBE may overwrite trace in FILL mode
>>>>      - Arm Neoverse-N2	#2139208
>>>>      - Cortex-A710	#211985
>>>>
>>>>    * A TSB instruction may not flush the trace completely when executed
>>>>      in trace prohibited region.
>>>>
>>>>      - Arm Neoverse-N2	#2067961
>>>>      - Cortex-A710	#2054223
>>>>
>>>>    * TRBE may write to out-of-range address
>>>>      - Arm Neoverse-N2	#2253138
>>>>      - Cortex-A710	#2224489
>>>>
>>>> The series applies on the self-hosted/trbe fixes posted here [0].
>>>> A tree containing both the series is available here [1]
>>>
>>> Any chance you could put the arch/arm64/ bits at the start of the series,
>>> please? That way, I can queue them on their own branch which can be shared
>>> with the coresight tree.
>>
>> I could move the bits around. I have a question though.
>>
>> Will, Catalin, Mathieu,
>>
>> The workaround for these errata, at least two of them are
>> in the TRBE driver patches. Are we happy with enabling the Kconfig
>> entry in the kernel, without the CoreSight patches to implement the work
>> around ?
> 
> I suppose you could move all the Kconfig changes into their own patch and
> stick it right at the end in the Coresight tree.

Cool, I will do that then. Thanks. I will send the updated series.

Suzuki

