Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B034537AD78
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 19:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbhEKR6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 13:58:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59507 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbhEKR6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 13:58:45 -0400
Received: from mail-ua1-f69.google.com ([209.85.222.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lgWdV-0001DX-CC
        for linux-kernel@vger.kernel.org; Tue, 11 May 2021 17:57:37 +0000
Received: by mail-ua1-f69.google.com with SMTP id r26-20020ab058da0000b02901e9245a03f1so2538543uac.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 10:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=94ufJ3ormqHNZspvl8FvlXfnb6f1wmMKW3qzHjBjIRE=;
        b=szwLvxRIXuh+35juxo6z6UHDPL8zRHeRT0CDSxcH9LLITttE+ToGyreX0ofbvyGhkP
         dl7tEY3Em2Pd5Y4lJGPt1ijn4lTC6VCdIJ28vTHo3tnrjBYCOHwkon/flSk8IbTqF/Pr
         w4VP+ocbwSOGqpWxwH9cCf9c/5wc9ZvHoUgnujkxliTBtyD3mQ9b4j/YgjeA20tx0hTh
         IenRVbO2Dln9hgdEdfW+qazEc9F6DzWLt1EHG090FghxWri8QSNJ6igN5AOA42OCqCWz
         VM6p8qj03wnIib5fAN49czruokYbtfZLfb5/gPdWVlPw8tAq1hwLMH/laLwCCI5BZTph
         +RFw==
X-Gm-Message-State: AOAM532teip6fCLJJvUJOouJzXsTCEfWGxeaa2I7JUP5h+zYNOnHwfMy
        4oDKWne/jO4lXxNrEiLDlvabBDyKdHdGAd+qf/cQvHANSGzRXzDmGUUHJ77NiChwT3lyktF15ga
        W5HnaR0SmYntF6y3omcZ+v+ARdi87iZVyWMCuPAMsGA==
X-Received: by 2002:a67:3113:: with SMTP id x19mr21194676vsx.40.1620755855157;
        Tue, 11 May 2021 10:57:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/Zydt+xpEYkJfW7skvnQeKr98J7KH3axJKmUi3JbjcEq6SHG376ogRH/+gT+WJ682romOXA==
X-Received: by 2002:a67:3113:: with SMTP id x19mr21194644vsx.40.1620755854977;
        Tue, 11 May 2021 10:57:34 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.48.6])
        by smtp.gmail.com with ESMTPSA id k198sm2338299vka.37.2021.05.11.10.57.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 10:57:34 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] memory: tegra: Enable compile testing for all
 drivers
To:     Nathan Chancellor <nathan@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20210510213729.7095-3-digetx@gmail.com>
 <202105112125.VctfC6sX-lkp@intel.com>
 <dd0b550e-76a0-bfbc-9d6f-5d867812046d@gmail.com>
 <06addbf3-0090-b76f-65cf-e0c10d284c69@canonical.com>
 <3ab5d50b-4955-7144-5d1d-d44cb0892d65@gmail.com>
 <YJrARxhVD7QM/GPv@archlinux-ax161>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <6fc3e47b-cef6-0d78-0578-551608856ae6@canonical.com>
Date:   Tue, 11 May 2021 13:57:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YJrARxhVD7QM/GPv@archlinux-ax161>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2021 13:35, Nathan Chancellor wrote:
> On Tue, May 11, 2021 at 07:00:34PM +0300, Dmitry Osipenko wrote:
>> 11.05.2021 18:31, Krzysztof Kozlowski пишет:
>> ...
>>                                       ~~~~~~~~~~~~~~~~~~~~~^
>>>>>>> drivers/memory/tegra/tegra124-emc.c:802:26: warning: implicit conversion from 'unsigned long' to 'u32' (aka 'unsigned int') changes value from 18446744071562067985 to 2147483665 [-Wconstant-conversion]
>>>>>                    emc_ccfifo_writel(emc, EMC_ZQ_CAL_LONG_CMD_DEV0, EMC_ZQ_CAL);
>>>>>                    ~~~~~~~~~~~~~~~~~      ^~~~~~~~~~~~~~~~~~~~~~~~
>>>>>    drivers/memory/tegra/tegra124-emc.c:154:36: note: expanded from macro 'EMC_ZQ_CAL_LONG_CMD_DEV0'
>>>>>            (DRAM_DEV_SEL_0 | EMC_ZQ_CAL_LONG | EMC_ZQ_CAL_CMD)
>>>>>             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~
>>>>>    13 warnings generated.
>>>>
>>>> This doesn't look like a useful warning from clang, it should see that
>>>> the constant value itself isn't truncated, hence it should be a problem
>>>> of clang. Do you think it's okay to ignore this nonsense?
>>>
>>> I admit I also do not see the real issue here. The DRAM_DEV_SEL_0 fits
>>> in u32 and there is no other bitwise arithmetic than just OR, so why
>>> clang assumes it can have 32 most signifcant bits toggled on?
>>>
>>> +Cc Nathan and Nick,
>>> Maybe you could shed some light here on this warning?
>>>
>>> Dmitry,
>>> In general you should not ignore it because:
>>> 1. This breaks allyesconfig with clang on powerpc (or it is one of the
>>> stoppers),
>>> 2. We might want in some future to build it with clang.
>>
>> I meant to ignore it from the perspective of the memory drivers, i.e. it
>> likely should be fixed in clang and not worked around in the code. Thank
>> you for pinging the right people.
> 
> I do not think this is a bug in clang, gcc warns the same (just not here
> in this case): https://godbolt.org/z/e9GWobMnd
> 
> DRAM_DEV_SEL_0 and DRAM_DEV_SEL_1 are implicitly signed integers because
> there is no suffix on the literal 1. DRAM_DEV_SEL_0 is 2 << 30, which
> can be turned into 1 << 31. That is equal to INT_MAX + 1, which then
> overflows and becomes INT_MIN (undefined behavior). INT_MIN is then
> promoted to unsigned long because EMC_ZQ_CAL_LONG and EMC_ZQ_CAL_CMD are
> unsigned long due to the BIT macro, resulting in the gigantic number
> that clang reports above.
> 
Thanks, good point.

Best regards,
Krzysztof
