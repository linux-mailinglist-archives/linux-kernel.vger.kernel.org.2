Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1E23342C7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 17:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhCJQOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 11:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhCJQOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:14:10 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AB5C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 08:14:10 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 18so12375613pfo.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 08:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mP0Pmg1TsfeNTMXh8LZDgwg/s3Yyn46RRnWB2NCR4B4=;
        b=dwHC5V2O6WUyIwpcrr1eBVQZ05mOINWAm4ay/OrSBF9oWwiO4nNg7LpAsGK69NAUK3
         bNcLOaSngVLoMQ5vhfM84B0ZZkfnu7pTNq6vNyTSRWWrwYu5Ny2vlk/MKhv8oB3ZGgGM
         4uKQRemPyvUbLwl1IOBOIl/dT1qEXu0///Oo1XIYujXsOm0NG5oy19WVVfwXCT/f5Gil
         LJk9+jnW4njBveo4sg9GmmwHb+5ypPmvhwfWXQnlIlDBOiqNMq645jJdXAHx/6Gf0Vhn
         6VuO3uRTlw34/R7I8IvcU9XA0Khae4zskZId9RyT5rgyueA/uXd4Oz/KtlNNB8uecrpe
         dstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mP0Pmg1TsfeNTMXh8LZDgwg/s3Yyn46RRnWB2NCR4B4=;
        b=gF+VVOZxi5tbjG5HI8qOJtdGnggw1qt9FqaBJh0Q9RhF+63KgFg/Fs4DXZoz6VrAIk
         ZtHv2rwB3P/k5jPw3yS8Hsjn26dSKwp0fY5tdgvvF+UTD15ensoQ5HcBAQzobKJUGLBH
         QUs5vpiOWE9X2kd8t/nwOwOoAYSWKUOOdkMiRt3NJmi+R5h/1uXhCLd2qDumJjW4rnY/
         FErg0lMoG3o3hCeTGMP+UmRnOOBR1W7H/DTvii856W66IIoPkw5YahUSEL6pxNs2Yl4S
         tEI+ENlUqoRFWPelNIYVBkijyW1wNl8+PaSAZKNOTXHTq+d/h5FSucqDQZ25nbZPtAgf
         YDYQ==
X-Gm-Message-State: AOAM531aO3Grxk0WXc/Z3clElaXblHG/D5yLWaxA9GogJOkdLszkCDLF
        cTPkhZ5kbiTqAqLhsMylROw=
X-Google-Smtp-Source: ABdhPJzVmPf2InihsFrUagBLY4eHO1VM2+gwTFhG3wS0HWMf/Olxeg9WE6GvUQ6tc8QD0Ft3RSbcJg==
X-Received: by 2002:a63:4502:: with SMTP id s2mr3568246pga.94.1615392849731;
        Wed, 10 Mar 2021 08:14:09 -0800 (PST)
Received: from [10.230.29.30] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id v27sm3681pfi.89.2021.03.10.08.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 08:14:09 -0800 (PST)
Subject: Re: [PATCH v7 2/2] ARM: ftrace: Add MODULE_PLTS support
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Qais Yousef <qais.yousef@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <20210127110944.41813-1-alexander.sverdlin@nokia.com>
 <20210127110944.41813-3-alexander.sverdlin@nokia.com>
 <20210307172650.uztx3sk5abybbp3f@e107158-lin.cambridge.arm.com>
 <0c122390-6e76-f773-86e9-8c085f4384f2@nokia.com>
 <20210309174201.n53za7mw33dqyleh@e107158-lin.cambridge.arm.com>
 <3eecf51d-b189-9e8b-f19d-a49d0764aae5@nokia.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <05608bc8-f44d-5f91-15ab-af00c59b53e6@gmail.com>
Date:   Wed, 10 Mar 2021 08:14:07 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <3eecf51d-b189-9e8b-f19d-a49d0764aae5@nokia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/9/2021 11:23 PM, Alexander Sverdlin wrote:
> Hi!
> 
> On 09/03/2021 18:42, Qais Yousef wrote:
>>>> I tried on 5.12-rc2 and 5.11 but couldn't reproduce the problem using your
>> I still can't reproduce on 5.12-rc2.
>>
>> I do have CONFIG_ARM_MODULE_PLTS=y. Do you need to do something else after
>> loading the module? I tried starting ftrace, but maybe there's a particular
>> combination required?
> 
> You need to load a BIG module, so big that it has no place in the modules area
> any more and goes to vmalloc area.

You absolutely need a very big module maybe more than one. When I tested
this, I could use the two proprietary modules (*sigh*) that I needed to
exercise against and loading one but not the other was not enough to
make the second module loading spill into vmalloc space.

> 
>>>> instructions on the other email. But most likely because I'm hitting another
>>>> problem that could be masking it. I'm not sure it is related or just randomly
>>>> happened to hit it.
>>>>
>>>> Did you see something similar?
>>> [...]
>>>
>>>> 	[    0.000000] [<c1b01a38>] (ftrace_bug) from [<c046316c>] (ftrace_process_locs+0x2b0/0x518)
>>>> 	[    0.000000]  r7:c3817ac4 r6:c38040c0 r5:00000a3c r4:000134e4
>>>> 	[    0.000000] [<c0462ebc>] (ftrace_process_locs) from [<c2b25240>] (ftrace_init+0xc8/0x174)
>>>> 	[    0.000000]  r10:c2ffa000 r9:c2be8a78 r8:c2c5d1fc r7:c2c0c208 r6:00000001 r5:c2d0908c
>>>> 	[    0.000000]  r4:c362f518
>>>> 	[    0.000000] [<c2b25178>] (ftrace_init) from [<c2b00e14>] (start_kernel+0x2f4/0x5b8)
>>>> 	[    0.000000]  r9:c2be8a78 r8:dbfffec0 r7:00000000 r6:c36385cc r5:c2d08f00 r4:c2ffa000
>>>> 	[    0.000000] [<c2b00b20>] (start_kernel) from [<00000000>] (0x0)
>>> This means, FTRACE has more problems with your kernel/compiler/platform, I've addressed similar issue
>>> in the past, but my patch should be long merged:
>>>
>>> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1817963.html
>>>
>>> Could it be the same problem as here:
>>> https://www.spinics.net/lists/arm-kernel/msg854022.html
>>>
>>> Seems that the size check deserves something line BUILD_BUG_ON() with FTRACE...
>> So I only see this when I convert all modules to be built-in
>>
>> 	sed -i 's/=m/=y/' .config
>>
>> FWIW, I see the problem with your patch applied too. Trying to dig more into
>> it..
> 
> Then it's definitely the problem explained in the second link. If you have THUMB2 kernel, maybe
> you have to switch to ARM.
> 

-- 
Florian
