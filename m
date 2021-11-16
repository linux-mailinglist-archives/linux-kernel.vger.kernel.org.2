Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F8A4535DC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 16:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238302AbhKPPfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 10:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238303AbhKPPe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 10:34:58 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F244C061746
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 07:32:01 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id j63so16589137qkd.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 07:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mF1aWu0JjOzyky5t42jJsAVlkltphNeGZXNSFiIsSXY=;
        b=zo5BPGFpXF7PyojCnvUNbK9IEYkLv6Li9fwVBTAIectWMlVmUgDTpCFhW+O0mfKWSD
         WzZrdBgb9rrlcs43MKa8FNU2G9Lr48o24jlyWxptW1FB0aFrh1Gz0ww38i7gGVsIf0s4
         RxA3wav5s79zJlp6X14CxAP/jHQhVDXlAWnTTw/Skb1dBmWgE6gIfnzf7tMXmtgpiKUA
         8/tT/gMSW/cO5Y6CakCqBGp+hf97wdVIDVrn43rWZ9Qxj0tWfK51vm/UtoGjzGmWtqlJ
         qL/T130SgshZJGWchYERRxidEifVDDFTGlpWiayVDF7XGOIohDw5upSxx0aOdfOMzZtR
         TxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mF1aWu0JjOzyky5t42jJsAVlkltphNeGZXNSFiIsSXY=;
        b=k6VyM/xdPuYVNHDDr4yxfelQ2TSYfuJ7Rz63Boq1SS9/t1ZTZa17U9kL37qnGbgJBA
         d3i69HaN77b+9OR81hrfEp0J0mhE62PsWDOBRWD4GTCJqM+l8KuuHTRuxlf1RKY+xzhu
         PZ3ufPrIBio/yPn6auNbp5LSl1cpnZQFArcC7F7lFrNrkg/NjrMGBRqoAC66/FJol3qU
         QBRVPrALsFpg53P1MzPoZeg8g2mxKBO+O1WahMtx148G0pQdJ3Sh6WLynlvZ8QrUs3XC
         gkL5/fOPtSmwS1NzS60xknPpGA9XbrAJwzuLE9WOtt2fuZaSMeHg3Ntpc/WjSh7nEoQB
         3TXQ==
X-Gm-Message-State: AOAM533BDQ6zJE9rS99Grb6RRJdGO2qX7uIfjG2vpeqq13rgqq3B9rq7
        3tFum0aMJMqw1oRc3UNvnx8svBNXEtlC1g==
X-Google-Smtp-Source: ABdhPJzEeWsZmjQlzDlo9QmEf9qz1BasxVxQ5ozXbJznB2YN5rA4FXCJFv1ThHdM1E7oXsUbFIkF9A==
X-Received: by 2002:a37:bc01:: with SMTP id m1mr6759398qkf.28.1637076720456;
        Tue, 16 Nov 2021 07:32:00 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id p18sm5038012qtk.54.2021.11.16.07.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 07:31:59 -0800 (PST)
Subject: Re: [PATCH] cpufreq: freq_table: Initialize cpuinfo.max_freq to
 correct max frequency.
To:     Steev Klimaszewski <steev@kali.org>, rafael@kernel.org,
        viresh.kumar@linaro.org, bjorn.andersson@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20211115195011.52999-1-thara.gopinath@linaro.org>
 <5ae2c644-4743-c62c-b17c-96945a0e6a01@kali.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <1ceb5a9b-817b-a9ef-c378-be3bd0f7ff17@linaro.org>
Date:   Tue, 16 Nov 2021 10:31:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <5ae2c644-4743-c62c-b17c-96945a0e6a01@kali.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steev,

Thanks for testing this.

On 11/15/21 8:23 PM, Steev Klimaszewski wrote:

--- snip
>>
>> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
>> index 67e56cf638ef..6784f94124df 100644
>> --- a/drivers/cpufreq/freq_table.c
>> +++ b/drivers/cpufreq/freq_table.c
>> @@ -35,11 +35,15 @@ int cpufreq_frequency_table_cpuinfo(struct 
>> cpufreq_policy *policy,
>>       struct cpufreq_frequency_table *pos;
>>       unsigned int min_freq = ~0;
>>       unsigned int max_freq = 0;
>> +    unsigned int cpuinfo_max_freq = 0;
>>       unsigned int freq;
>>       cpufreq_for_each_valid_entry(pos, table) {
>>           freq = pos->frequency;
>> +        if (freq > cpuinfo_max_freq)
>> +            cpuinfo_max_freq = freq;
>> +
>>           if (!cpufreq_boost_enabled()
>>               && (pos->flags & CPUFREQ_BOOST_FREQ))
>>               continue;
>> @@ -57,8 +61,8 @@ int cpufreq_frequency_table_cpuinfo(struct 
>> cpufreq_policy *policy,
>>        * If the driver has set its own cpuinfo.max_freq above 
>> max_freq, leave
>>        * it as is.
>>        */
>> -    if (policy->cpuinfo.max_freq < max_freq)
>> -        policy->max = policy->cpuinfo.max_freq = max_freq;
>> +    if (policy->cpuinfo.max_freq < cpuinfo_max_freq)
>> +        policy->cpuinfo.max_freq = cpuinfo_max_freq;
>>       if (policy->min == ~0)
>>           return -EINVAL;
> 
> 
> Something still isn't quite right...
> 
> The setup is that I have an rc.local of
> 
> #!/bin/sh
> 
> echo 1 > /sys/devices/system/cpu/cpufreq/boost
> 
> exit 0
> 
> 
> After booting and logging in:
> 
> steev@limitless:~$ cat 
> /sys/devices/system/cpu/cpufreq/policy4/stats/time_in_state
> 825600 2499
> <snip>
> 2649600 38
> 2745600 31
> 2841600 1473
> 2956800 0

Did you try debugging this ? As in did you read back boost and 
cpuinfo_max_freq at this point to ensure that everything is as expected ?


-- 
Warm Regards
Thara (She/Her/Hers)
> 
> After running a "cargo build --release" in an alacritty git checkout:
> 
> teev@limitless:~$ cat 
> /sys/devices/system/cpu/cpufreq/policy4/stats/time_in_state
> 825600 11220
> <snip>
> 2649600 41
> 2745600 35
> 2841600 3065
> 2956800 0
> 
> 
> however...
> 
> If I then
> 
> steev@limitless:~$ echo 0 | sudo tee /sys/devices/system/cpu/cpufreq/boost
> [sudo] password for steev:
> 0
> steev@limitless:~$ echo 1 | sudo tee /sys/devices/system/cpu/cpufreq/boost
> 1
> 
> and run the build again...
> 
> steev@limitless:~$ cat 
> /sys/devices/system/cpu/cpufreq/policy4/stats/time_in_state
> 825600 21386
> <snip>
> 2649600 45
> 2745600 38
> 2841600 3326
> 2956800 4815
> 
> As a workaround, I attempted to jiggle it 1-0-1 in rc.local, however 
> that ends up giving
> 
> steev@limitless:~$ cat 
> /sys/devices/system/cpu/cpufreq/policy4/stats/time_in_state
> 825600 2902
> <snip>
> 2649600 36
> 2745600 36
> 2841600 6050
> 2956800 13
> 
> And it doesn't go up, I even tried adding a sleep of 1 second between 
> the echo 1/0/1 lines and while 2956800 goes up to 28 (but never uses it) 
> it seems like, unless I do it manually once I've logged in, which I'm 
> assuming is a lot slower than waiting 1 second between them, it's not 
> quite giving us 2956800 "easily".
> 
> If the email wasn't clear, please let me know! I tried to explain as 
> best I could what I am seeing here.
> 
> -- steev
> 

