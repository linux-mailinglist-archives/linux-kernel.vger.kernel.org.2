Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0433448D5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 16:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbhCVPJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 11:09:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:15234 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230056AbhCVPJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 11:09:22 -0400
IronPort-SDR: RmCQUz1UvwoWLXOBe/pIk3i/gjpB/+T/Ru9+9kTeMFU8+m2R/nDT4P4E5d5eeU8n5J1wV4yRpk
 xgofuBB0yM9g==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="254288287"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="254288287"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 08:09:21 -0700
IronPort-SDR: rYPX1yAniq4hVTdHu57nyKOja/Sm9o+/0Q5YMXq1wJrsKkf6tfa1OfsPVQHtMxLkbv0MJaoCC/
 +PC7DUAcHxGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="441213761"
Received: from marshy.an.intel.com (HELO [10.122.105.143]) ([10.122.105.143])
  by fmsmga002.fm.intel.com with ESMTP; 22 Mar 2021 08:09:20 -0700
Subject: Re: [PATCH] firmware: stratix10-svc: build only on 64-bit ARM
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>, kbuild-all@lists.01.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kernel test robot <lkp@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
References: <20210321184650.10926-1-krzysztof.kozlowski@canonical.com>
 <CAK8P3a2mN0stqiGSMqyY7neODfqFv700KkVecaYS0Ck3D7LRnQ@mail.gmail.com>
 <2ae8379f-c79f-3257-e54c-fa17c576e929@canonical.com>
 <26fe4358-4ebd-7346-8944-13b13da75c6f@linux.intel.com>
 <5c4ede72-b937-586b-78d7-1f6770c23b09@canonical.com>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <af80b8de-3e55-d0e4-f5ee-7fc90e60c4c2@linux.intel.com>
Date:   Mon, 22 Mar 2021 10:29:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5c4ede72-b937-586b-78d7-1f6770c23b09@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/22/21 7:41 AM, Krzysztof Kozlowski wrote:
> On 22/03/2021 13:58, Richard Gong wrote:
>>
>>
>> On 3/22/21 3:26 AM, Krzysztof Kozlowski wrote:
>>>
>>> On 21/03/2021 22:09, Arnd Bergmann wrote:
>>>> On Sun, Mar 21, 2021 at 7:46 PM Krzysztof Kozlowski
>>>> <krzysztof.kozlowski@canonical.com> wrote:
>>>>>
>>>>> The Stratix10 service layer and RCU drivers are useful only on
>>>>> Stratix10, so on ARMv8.  Compile testing the RCU driver on 32-bit ARM
>>>>> fails:
>>>>>
>>>>>     drivers/firmware/stratix10-rsu.c: In function 'rsu_status_callback':
>>>>>     include/linux/compiler_types.h:320:38: error: call to '__compiletime_assert_179'
>>>>>       declared with attribute error: FIELD_GET: type of reg too small for mask
>>>>>       _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>>>>     ...
>>>>>     drivers/firmware/stratix10-rsu.c:96:26: note: in expansion of macro 'FIELD_GET'
>>>>>       priv->status.version = FIELD_GET(RSU_VERSION_MASK,
>>>>>
>>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>
>>>> While I agree that one shouldn't run 32-bit kernels on this, we should also try
>>>> to write drivers portably, and in theory any SoC that can run a 64-bit
>>>> Arm kernel
>>>> should also be able to run a 32-bit kernel if you include the same drivers.
>>>>
>>>> It seems that the problem here is in the smccc definition
>>>>
>>>> struct arm_smccc_res {
>>>>           unsigned long a0;
>>>>           unsigned long a1;
>>>>           unsigned long a2;
>>>>           unsigned long a3;
>>>> };
>>>>
>>>> so the result of
>>>>
>>>> #define RSU_VERSION_MASK                GENMASK_ULL(63, 32)
>>>>             priv->status.version = FIELD_GET(RSU_VERSION_MASK, res->a2);
>>>>
>>>> tries to access bits that are just not returned by the firmware here,
>>>> which indicates that it probably won't work in this case.
>>>>
>>>> What I'm not entirely sure about is whether this is a problem in
>>>> the Intel firmware implementation requiring the smccc caller to
>>>> run in a 64-bit context, or if it's a mistake in the way the driver
>>>> extracts the information if the firmware can actually pass it down
>>>> correctly.
>>>
>>> The SMC has two calling conventions - SMC32/HVC32 and SMC64/HVC64. The
>>> Stratix 10 driver uses the 64-bit calling convention (see
>>> INTEL_SIP_SMC_FAST_CALL_VAL in
>>> include/linux/firmware/intel/stratix10-smc.h), so it should not run in
>>> aarch32 (regardless of type of hardware).
>>>
>>> I think that my patch limiting the support to 64-bit makes sense.
>>>
>>
>> The stratix10 service layer and RSU driver are only used in Intel 64-bit
>> SoCFPGA platforms.
> 
> This we know, however the questions were:
> 1. Why the driver cannot be made portable? Why it cannot be developed in
> a way it allows building on different platforms?

The drivers was originally developed for Intel Stratix10 SoCFPGA 
platform, which is ARM 64-bit architecture. The same drivers can be used 
for other Intel ARM 64-bit SoCFPGA platforms (Agilex, eASIC N5X as 
example), which have the same SDM architecture as Stratix10 has.

SDM = Secure Device Manager

So far Intel 32-bit SoCFPGA platform doesn't support SDM architecture.

> 2. Does the actual firmware support 32-bit SMC convention call?

No.

> 
> Best regards,
> Krzysztof
> 

Regards,
Richard
