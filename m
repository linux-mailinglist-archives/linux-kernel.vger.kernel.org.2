Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062DF34436E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 13:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbhCVMu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 08:50:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49458 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbhCVMlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 08:41:21 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lOJrz-0006Jx-Gk
        for linux-kernel@vger.kernel.org; Mon, 22 Mar 2021 12:41:19 +0000
Received: by mail-wr1-f71.google.com with SMTP id p12so23361268wrn.18
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 05:41:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ffw4TtTmf7dHm6AGofgtdlWOudU4YnCbk4hRJNOwNVE=;
        b=lWvm/8EDBlr7gkG+TDwkVx4BhpdEcjR4J+ua1gzUwpAAAxdS1Y6eT5EXq+5Bpktao8
         ymh9onS3GGQV9G8JtIfBXRXymIaa1ByHKQC6gGAF9WapIBvSFsrmABEsDpmLSywa0IVF
         SA+a5YXwTvxiHk4mn3PjuGLKx7DL9YGdfVs8yUAS/MaQXwkwCcFjHhFrQmtrPBP18+1m
         HetT1ndrP3HYcX5NL6IaQbHue+vJQXg6b0kM7dkiFNqHLmNXz+qWeN+QfQ0bU6pGRBkV
         Sw6qBxlU41u9lDjHJnywWWMHX5xcvW/uhQJmppEdjEEJPqifdOXMubW2vxtyrwWfOI1C
         18WQ==
X-Gm-Message-State: AOAM530wPfVVaWI5VybW5ki+F5Zfp55cTfMvHD8TeEoRfD1RV1yWFfva
        FmdhBK6cHSSJd5zr2eDKnNvfygeAjg3GIRfg3HMCITG+ixc0KLQwnNZ4ZM579q7EoLuWrbZbxRc
        F5VnLATSorySBSIOMnBwFBKhQSI8ZGHCGl1kdCYfEhQ==
X-Received: by 2002:adf:e791:: with SMTP id n17mr17874869wrm.322.1616416879257;
        Mon, 22 Mar 2021 05:41:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTC/mX2GCQ13QuW69V3uxX/+Dh0hjXKWA/q+lj9bBM0nCdjsJaKqM3dQrC6iM6yzwYaFPfgQ==
X-Received: by 2002:adf:e791:: with SMTP id n17mr17874849wrm.322.1616416879072;
        Mon, 22 Mar 2021 05:41:19 -0700 (PDT)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id w6sm19335108wrl.49.2021.03.22.05.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 05:41:18 -0700 (PDT)
Subject: Re: [PATCH] firmware: stratix10-svc: build only on 64-bit ARM
To:     Richard Gong <richard.gong@linux.intel.com>,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <5c4ede72-b937-586b-78d7-1f6770c23b09@canonical.com>
Date:   Mon, 22 Mar 2021 13:41:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <26fe4358-4ebd-7346-8944-13b13da75c6f@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2021 13:58, Richard Gong wrote:
> 
> 
> On 3/22/21 3:26 AM, Krzysztof Kozlowski wrote:
>>
>> On 21/03/2021 22:09, Arnd Bergmann wrote:
>>> On Sun, Mar 21, 2021 at 7:46 PM Krzysztof Kozlowski
>>> <krzysztof.kozlowski@canonical.com> wrote:
>>>>
>>>> The Stratix10 service layer and RCU drivers are useful only on
>>>> Stratix10, so on ARMv8.  Compile testing the RCU driver on 32-bit ARM
>>>> fails:
>>>>
>>>>    drivers/firmware/stratix10-rsu.c: In function 'rsu_status_callback':
>>>>    include/linux/compiler_types.h:320:38: error: call to '__compiletime_assert_179'
>>>>      declared with attribute error: FIELD_GET: type of reg too small for mask
>>>>      _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>>>    ...
>>>>    drivers/firmware/stratix10-rsu.c:96:26: note: in expansion of macro 'FIELD_GET'
>>>>      priv->status.version = FIELD_GET(RSU_VERSION_MASK,
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>
>>> While I agree that one shouldn't run 32-bit kernels on this, we should also try
>>> to write drivers portably, and in theory any SoC that can run a 64-bit
>>> Arm kernel
>>> should also be able to run a 32-bit kernel if you include the same drivers.
>>>
>>> It seems that the problem here is in the smccc definition
>>>
>>> struct arm_smccc_res {
>>>          unsigned long a0;
>>>          unsigned long a1;
>>>          unsigned long a2;
>>>          unsigned long a3;
>>> };
>>>
>>> so the result of
>>>
>>> #define RSU_VERSION_MASK                GENMASK_ULL(63, 32)
>>>            priv->status.version = FIELD_GET(RSU_VERSION_MASK, res->a2);
>>>
>>> tries to access bits that are just not returned by the firmware here,
>>> which indicates that it probably won't work in this case.
>>>
>>> What I'm not entirely sure about is whether this is a problem in
>>> the Intel firmware implementation requiring the smccc caller to
>>> run in a 64-bit context, or if it's a mistake in the way the driver
>>> extracts the information if the firmware can actually pass it down
>>> correctly.
>>
>> The SMC has two calling conventions - SMC32/HVC32 and SMC64/HVC64. The
>> Stratix 10 driver uses the 64-bit calling convention (see
>> INTEL_SIP_SMC_FAST_CALL_VAL in
>> include/linux/firmware/intel/stratix10-smc.h), so it should not run in
>> aarch32 (regardless of type of hardware).
>>
>> I think that my patch limiting the support to 64-bit makes sense.
>>
> 
> The stratix10 service layer and RSU driver are only used in Intel 64-bit 
> SoCFPGA platforms.

This we know, however the questions were:
1. Why the driver cannot be made portable? Why it cannot be developed in
a way it allows building on different platforms?
2. Does the actual firmware support 32-bit SMC convention call?

Best regards,
Krzysztof
