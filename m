Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086EC343BA8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 09:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhCVI0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 04:26:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36340 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhCVI0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 04:26:04 -0400
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lOFsx-0002Ge-28
        for linux-kernel@vger.kernel.org; Mon, 22 Mar 2021 08:26:03 +0000
Received: by mail-ed1-f69.google.com with SMTP id p6so26867207edq.21
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 01:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f3ajaOD5lL9Dzu+yQf9pDJLTE6UsAearV7ZvHqe+8So=;
        b=LycNytw26jw/gUs37GdGz3bBXwdAxIin8laoKO3ISgjh4JOGuv0DCq9G2GGR7PeaGd
         iH1EheVi49ENi39ZK+esxA3syJdPiWF09FZLACWEHDRhkS/Cp9H8H2A1RX34+gQp/66C
         TZNSBzkLFuELYctWQQ8KW+ulR7TFoFHs5lj0T9NNz08VdYX4hxF3vyEeGra1a4wJwBTw
         Rl0OhJfBkbabk/KllkL2ZdnQZLEXsWkLRy5eikZvFNbar8vQWS5GNWU0yccfABxqNpmq
         LOXsV/QIxqSjdaRy2yMHUjzaIQVlrUTdgTum69lNz1rax7A/x3k+cuLa122TpxmrDkmo
         0W7A==
X-Gm-Message-State: AOAM532oOu2XGFQRH3g/h/a7LqomMbbiE/kut/rz3fYsXUttJJH67hy4
        3HkYzH/jMb5NQrWRO2Dbqy/Eu9EHoFLF1CxpH4VhRgBQusNtOdCdQorAnqARd/RFK34IPHiCeGU
        AC/1QfzWH9AvTTe6jjmZgI42chdTcqnIVEabgRFjwhg==
X-Received: by 2002:a17:906:f6ce:: with SMTP id jo14mr18423079ejb.476.1616401562790;
        Mon, 22 Mar 2021 01:26:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxFpElIxJ/j6sAJw2hDqrBneVlXz8k8RQWHDkmZ5+nhpflxfZCiwxQC4tNObYjje+0gO3L5Q==
X-Received: by 2002:a17:906:f6ce:: with SMTP id jo14mr18423070ejb.476.1616401562649;
        Mon, 22 Mar 2021 01:26:02 -0700 (PDT)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id a2sm9228987ejy.108.2021.03.22.01.26.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 01:26:02 -0700 (PDT)
Subject: Re: [PATCH] firmware: stratix10-svc: build only on 64-bit ARM
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Richard Gong <richard.gong@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>, kbuild-all@lists.01.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kernel test robot <lkp@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
References: <20210321184650.10926-1-krzysztof.kozlowski@canonical.com>
 <CAK8P3a2mN0stqiGSMqyY7neODfqFv700KkVecaYS0Ck3D7LRnQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <2ae8379f-c79f-3257-e54c-fa17c576e929@canonical.com>
Date:   Mon, 22 Mar 2021 09:26:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2mN0stqiGSMqyY7neODfqFv700KkVecaYS0Ck3D7LRnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/03/2021 22:09, Arnd Bergmann wrote:
> On Sun, Mar 21, 2021 at 7:46 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>>
>> The Stratix10 service layer and RCU drivers are useful only on
>> Stratix10, so on ARMv8.  Compile testing the RCU driver on 32-bit ARM
>> fails:
>>
>>   drivers/firmware/stratix10-rsu.c: In function 'rsu_status_callback':
>>   include/linux/compiler_types.h:320:38: error: call to '__compiletime_assert_179'
>>     declared with attribute error: FIELD_GET: type of reg too small for mask
>>     _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>   ...
>>   drivers/firmware/stratix10-rsu.c:96:26: note: in expansion of macro 'FIELD_GET'
>>     priv->status.version = FIELD_GET(RSU_VERSION_MASK,
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> Reported-by: kernel test robot <lkp@intel.com>
> 
> While I agree that one shouldn't run 32-bit kernels on this, we should also try
> to write drivers portably, and in theory any SoC that can run a 64-bit
> Arm kernel
> should also be able to run a 32-bit kernel if you include the same drivers.
> 
> It seems that the problem here is in the smccc definition
> 
> struct arm_smccc_res {
>         unsigned long a0;
>         unsigned long a1;
>         unsigned long a2;
>         unsigned long a3;
> };
> 
> so the result of
> 
> #define RSU_VERSION_MASK                GENMASK_ULL(63, 32)
>           priv->status.version = FIELD_GET(RSU_VERSION_MASK, res->a2);
> 
> tries to access bits that are just not returned by the firmware here,
> which indicates that it probably won't work in this case.
> 
> What I'm not entirely sure about is whether this is a problem in
> the Intel firmware implementation requiring the smccc caller to
> run in a 64-bit context, or if it's a mistake in the way the driver
> extracts the information if the firmware can actually pass it down
> correctly.

The SMC has two calling conventions - SMC32/HVC32 and SMC64/HVC64. The
Stratix 10 driver uses the 64-bit calling convention (see
INTEL_SIP_SMC_FAST_CALL_VAL in
include/linux/firmware/intel/stratix10-smc.h), so it should not run in
aarch32 (regardless of type of hardware).

I think that my patch limiting the support to 64-bit makes sense.

Best regards,
Krzysztof
