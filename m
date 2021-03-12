Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C173396B7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbhCLSgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbhCLSfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:35:45 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A70C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 10:35:45 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id r16so1123327pfh.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 10:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=edAAh8F5zzqoy3v4SwV/G5d3/7qdwdw3lH+6LgmNvvU=;
        b=U34KQ5YnKGn0zaSU1tpcVT9OsTo4BjjeQIZWQBtpwnJdUnvVbmJyjw5dgG9xmgf93B
         ZbJlINt5l0G2r1298M0241k7Za6h9sE2dRZxB6KTAwu3w1D8AyddHjLcBmsYp/EiepS2
         T8MSPWEeDP5SCkwIFvEujrSr2PwhHPWGKtI1pIbwBcN7eklNvbIyYmeDGNRcdDQThO9V
         NEo+7faY1djzA3T9+X8qUOhR+6nEbLm/jc0OhEQugPnanYGFQMicws4v57p9Yzs0elIH
         rl8xP2ou8XM8dTtlmV6yfoZ+R2arMKSIza8JxPyg0Zfj5UtC25/1YRfrNevsb1rRlvi2
         Z7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=edAAh8F5zzqoy3v4SwV/G5d3/7qdwdw3lH+6LgmNvvU=;
        b=HRxZJqgIicM7RJmFaBcWpIi3xBw4RxRcdY/6N6YVHOCAIVYfRX75EqMCdJJxILyIwM
         fR1zzXp8wBAYzPfVGpw7QOnNxrMw65w88C3rpvjwxTgH2QrwcxN8Tkr8PuRCXccujdKg
         ZRkm8wWjAlL5EEdRx1v7/S5QC4qRMbdn2rWDFC513qlFUoCjnPF46zEG6fSFMhSOKgQo
         LzIqrb17ESGgtAbfw2NQCAWV8C+qakkHFISwHQhcCxMnG8AKIB9H7bRqJV+6/irDmzfk
         kHMivVQIynxnplwxNi9lr1CIH4UVvAKdNQqS7uViXqEC2j9Xxm7wwtJhRpKgyIbwWmOk
         XLdg==
X-Gm-Message-State: AOAM531Y+7AHlMvbrE+RgofhN4IljtC966m3UMJ4eeWGQK3mTXfQLzAV
        kmg70YBBbEYC7Fubj5zxbOw=
X-Google-Smtp-Source: ABdhPJyl3PQB/5si0USgGvWCMkWEk3uE9jUnOj0DpOLkNTyf1G7+/NbXrOofo6Iso0eKXpi1WWaGSg==
X-Received: by 2002:a65:6a0c:: with SMTP id m12mr12790546pgu.161.1615574144672;
        Fri, 12 Mar 2021 10:35:44 -0800 (PST)
Received: from [10.67.49.104] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id p17sm2888834pjv.49.2021.03.12.10.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 10:35:44 -0800 (PST)
Subject: Re: [PATCH v7 2/2] ARM: ftrace: Add MODULE_PLTS support
To:     Qais Yousef <qais.yousef@arm.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>
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
 <05608bc8-f44d-5f91-15ab-af00c59b53e6@gmail.com>
 <e726be33-bc03-0515-f430-c5a34ebc3619@nokia.com>
 <20210312172401.36awjh4hmj4cs6ot@e107158-lin.cambridge.arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <134e1a2c-daac-7b00-c170-bcca434d08df@gmail.com>
Date:   Fri, 12 Mar 2021 10:35:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210312172401.36awjh4hmj4cs6ot@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/21 9:24 AM, Qais Yousef wrote:
> Hi Alexander
> 
> On 03/10/21 18:17, Alexander Sverdlin wrote:
>> Hi!
>>
>> On 10/03/2021 17:14, Florian Fainelli wrote:
>>>>>>> I tried on 5.12-rc2 and 5.11 but couldn't reproduce the problem using your
>>>>> I still can't reproduce on 5.12-rc2.
>>>>>
>>>>> I do have CONFIG_ARM_MODULE_PLTS=y. Do you need to do something else after
>>>>> loading the module? I tried starting ftrace, but maybe there's a particular
>>>>> combination required?
>>>> You need to load a BIG module, so big that it has no place in the modules area
>>>> any more and goes to vmalloc area.
>>> You absolutely need a very big module maybe more than one. When I tested
>>> this, I could use the two proprietary modules (*sigh*) that I needed to
>>> exercise against and loading one but not the other was not enough to
>>> make the second module loading spill into vmalloc space.
>>
>> Here is what I use instead of these real world "proprietary" modules (which of course
>> were the real trigger for the patch):
>>
>> https://www.spinics.net/lists/arm-kernel/msg878599.html
> 
> I am testing with your module. I can't reproduce the problem you describe with
> it as I stated.
> 
> I will try to spend more time on it on the weekend.

Alexander, do you load one or multiple instances of that fat module?

The test module does a 6 * 1024 * 1024 / 2 = 3 million repetitions of
the "nop" instruction which should be 32-bits wide in ARM mode and
16-bits wide in Thumb mode, right?

In ARM mode we have a 14MB module space, so 3 * 1024 * 1024 * 4 = 12MB,
which should still fit within if you have no module loaded, however a
second instance of the module should make us spill into vmalloc space.

In Thumb mode, we have a 6MB module space, so 3 * 1024 * 1024 * 2 = 6MB
so we may spill, but maybe not.

I was not able to reproduce the warning with just one module, but with
two (cannot have the same name BTW), it kicked in.
-- 
Florian
