Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38F942DB4B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 16:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbhJNOUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 10:20:05 -0400
Received: from foss.arm.com ([217.140.110.172]:55452 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231464AbhJNOUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 10:20:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76D27D6E;
        Thu, 14 Oct 2021 07:17:59 -0700 (PDT)
Received: from [10.57.25.70] (unknown [10.57.25.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB7193F694;
        Thu, 14 Oct 2021 07:17:57 -0700 (PDT)
Subject: Re: [PATCH v4 02/15] arm64: errata: Add detection for TRBE overwrite
 in FILL mode
To:     Randy Dunlap <rdunlap@infradead.org>, will@kernel.org,
        mathieu.poirier@linaro.org
Cc:     catalin.marinas@arm.com, anshuman.khandual@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org, maz@kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
References: <20211012131743.2040596-1-suzuki.poulose@arm.com>
 <20211012131743.2040596-3-suzuki.poulose@arm.com>
 <50b26f6c-d0d3-b8bc-085d-1e274bb42a96@infradead.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <55aca58d-8aec-a929-cdc9-15c5809a0781@arm.com>
Date:   Thu, 14 Oct 2021 15:17:56 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <50b26f6c-d0d3-b8bc-085d-1e274bb42a96@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi


Thanks for the report. I have fixed all of them.

Suzuki

On 12/10/2021 16:31, Randy Dunlap wrote:
> Hi,
> 
> On 10/12/21 6:17 AM, Suzuki K Poulose wrote:
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 077f2ec4eeb2..404f56e87e93 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -666,6 +666,47 @@ config ARM64_ERRATUM_1508412
>>         If unsure, say Y.
>> +config ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
>> +    bool
>> +
>> +config ARM64_ERRATUM_2119858
>> +    bool "Cortex-A710: 2119858: workaround TRBE overwriting trace 
>> data in FILL mode"
>> +    default y
>> +    depends on COMPILE_TEST # Until the CoreSight TRBE driver changes 
>> are in
>> +    depends on CORESIGHT_TRBE
>> +    select ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
>> +    help
>> +      This option adds the workaround for ARM Cortex-A710 erratum 
>> 2119858.
>> +
>> +      Affected Cortex-A710 cores could overwrite upto 3 cache lines 
>> of trace
> 
>                                                   up to
> 
>> +      data at the base of the buffer (ponited by TRBASER_EL1) in FILL 
>> mode in
> 
>                                        pointed to by
> 
>> +      the event of a WRAP event.
>> +
>> +      Work around the issue by always making sure we move the 
>> TRBPTR_EL1 by
>> +      256bytes before enabling the buffer and filling the first 
>> 256bytes of
> 
>        256 bytes                                                 256 bytes
> 
>> +      the buffer with ETM ignore packets upon disabling.
>> +
>> +      If unsure, say Y.
>> +
>> +config ARM64_ERRATUM_2139208
>> +    bool "Neoverse-N2: 2139208: workaround TRBE overwriting trace 
>> data in FILL mode"
>> +    default y
>> +    depends on COMPILE_TEST # Until the CoreSight TRBE driver changes 
>> are in
>> +    depends on CORESIGHT_TRBE
>> +    select ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
>> +    help
>> +      This option adds the workaround for ARM Neoverse-N2 erratum 
>> 2139208.
>> +
>> +      Affected Neoverse-N2 cores could overwrite upto 3 cache lines 
>> of trace
> 
>                                                   up to
> 
>> +      data at the base of the buffer (ponited by TRBASER_EL1) in FILL 
>> mode in
> 
>                                        pointed to by
> 
>> +      the event of a WRAP event.
>> +
>> +      Work around the issue by always making sure we move the 
>> TRBPTR_EL1 by
>> +      256bytes before enabling the buffer and filling the first 
>> 256bytes of
> 
>        256 bytes                                                 256 bytes
> 
>> +      the buffer with ETM ignore packets upon disabling.
>> +
>> +      If unsure, say Y.
> 
> 

