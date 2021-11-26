Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B2C45F713
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 00:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245730AbhKZXLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 18:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbhKZXJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 18:09:12 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE98C06173E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 15:05:58 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id i5so21660290wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 15:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hpy2yA4nEK1dd7DYXP3zx+aRL+KR8fcawIJzPdieEMY=;
        b=EeZyvq39JO1QH4MK8UcEaEGcp49dQzt54iSy8Vgq6eZ0JeWqk78I1cYDUSRLJDy97/
         wgmUDI89CXpASYzOzy5bTnjijYUkvmzuTH5kSkbdOCCVrJTJuzqBOwrjg4bDwGOxe9Sf
         h70MH9q0q3xTLzl5ksdi2rr8JCn6+uhNbLlEwXWAo3jjksk63h/JDu/88vyEEt3VypJU
         /hUTOU/pdmniG5sACp/dEuC3VbUo/eDo0DpvkN/syyjzzq4zdNwoj0I3LLkIZXcxmiSY
         poXqLyhhj/NztudcJdwF7ZfY0oyzwClM5V04LOxxD5JBpu8JYiZVhIUjik6idTKDuHz0
         POgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hpy2yA4nEK1dd7DYXP3zx+aRL+KR8fcawIJzPdieEMY=;
        b=KTgFIv8nXl8GO4oiDwvzEPssyhGEglgKoAol8NqWP6aNoUL4iEV8ARjFuWEk2GdAUn
         j9vSWreobKfOzqONyT8wGemxP5dVXU3FFPDbAwoJ6jhu0HOd7AqwKNKk8s2fHxNo/ojL
         v7826ynflEiOuFnqB+ZTZRY2eJCxBlXikfr7bG4h4QpaVCOrILZUtKU/fcLA8orVg25z
         rSybENPi7+ugVuOKkMOkJZy/OSa95jDHzYrQ/Q6nJG1+IfVHZle3j1bYtVC8H5T8A/eD
         WYJIFgdR9TcqTeT7uxhC7287RYPttn504EYzo4exKtVNeg6WSownW7SaDjxeM4KGK/DF
         7wiw==
X-Gm-Message-State: AOAM530pGRk4uLmqO49nGb34dzMycrQxNc0ZjC4tVfuFmgS3ONfI9qPl
        APa3IBJov1zIZMlaEIUBQ/LDaQ==
X-Google-Smtp-Source: ABdhPJzDuUGVVN0JLWKml6ZkVjW29FcX7HzzaFbZfMOwIRCjR9gf1M/bAx6ESZQStpMD0RczVbMPDw==
X-Received: by 2002:adf:8008:: with SMTP id 8mr17336938wrk.188.1637967956864;
        Fri, 26 Nov 2021 15:05:56 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:70b:e5b5:f868:20cf? ([2a01:e34:ed2f:f020:70b:e5b5:f868:20cf])
        by smtp.googlemail.com with ESMTPSA id u2sm8093385wrs.17.2021.11.26.15.05.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Nov 2021 15:05:56 -0800 (PST)
Subject: Re: [PATCH v6 3/7] powercap/drivers/dtpm: Simplify the dtpm table
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210401183654.27214-1-daniel.lezcano@linaro.org>
 <20210401183654.27214-3-daniel.lezcano@linaro.org>
 <CAAYoRsURO1tf03nfiki1uaXYEmTKQyYKUeTyKW+vefrVzCO7jg@mail.gmail.com>
 <CAJZ5v0hcuq0qriHbc=XHbCo8fJMAV1dbCBws3M9GktN17aCE_g@mail.gmail.com>
 <acb3ac6c-d6e6-c3f7-6b04-12d3a1fbf0a1@linaro.org>
 <CAAYoRsXftJbk0q7sjc8fvQJcWtjnsG-SrdhrvWHQbK2vw4TQLQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <9821f60a-c562-12e8-bdd4-45dbfe88a117@linaro.org>
Date:   Sat, 27 Nov 2021 00:05:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAAYoRsXftJbk0q7sjc8fvQJcWtjnsG-SrdhrvWHQbK2vw4TQLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/2021 22:56, Doug Smythies wrote:
> On Fri, Nov 26, 2021 at 9:43 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 26/11/2021 18:21, Rafael J. Wysocki wrote:
>>> Hi Doug,
>>>
>>> On Fri, Nov 26, 2021 at 6:08 PM Doug Smythies <dsmythies@telus.net> wrote:
>>>>
>>>> Hi Daniel,
>>>>
>>>> This patch introduces a regression, at least on my test system.
>>>> I can no longer change CPU frequency scaling drivers, for example
>>>> from intel_cpufreq (A.K.A intel_pstate in passive mode) to intel_pstate
>>>> (A.K.A. active mode). The task just hangs forever.
>>>>
>>>> I bisected the kernel and got this commit as the result.
>>>> As a double check, I reverted this commit:
>>>> 7a89d7eacf8e84f2afb94db5ae9d9f9faa93f01c
>>>> on kernel 5.16-rc2 and the issue was resolved.
>>>>
>>>> While your email is fairly old, I observe that it was only included as of
>>>> kernel 5.16-rc1.
>>>>
>>>> Command Example that never completes:
>>>>
>>>> $ echo passive | sudo tee /sys/devices/system/cpu/intel_pstate/status
>>>>
>>>> syslog excerpt attached.
>>>
>>> This looks like it may be problematic:
>>>
>>> diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
>>> index f6076de39540..98841524a782 100644
>>> --- a/drivers/powercap/dtpm_cpu.c
>>> +++ b/drivers/powercap/dtpm_cpu.c
>>> @@ -204,7 +204,7 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
>>>        return ret;
>>> }
>>>
>>> -int dtpm_register_cpu(struct dtpm *parent)
>>> +static int __init dtpm_cpu_init(void)
>>> {
>>>        int ret;
>>>
>>> so please try to remove the __init annotation from dtpm_cpu_init() and
>>> see if that helps.
>>
>> Yes, actually that should be called only if it is configured properly.
>> The dtpm_cpu just initializes itself unconditionally, I did not figured
>> out there is the usually allyesconfig used by default by the distros.
>>
>> That should be fixed with a proper DT configuration [1]
> 
> I added your 5 patch set on top of 5.16-rc2 and confirm it fixes
> the issue. I tested both ways, with CONFIG_OF not set, forcing the
> CONFIG_DTPM stuff off, and with CONFIG_OF=y.
> 
> Oh, I used V2 of the patch set from earlier today.

Thanks Doug for testing.

For a -rc I should prevent the cpu to setup at boot time with a simple fix.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
