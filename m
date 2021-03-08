Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2CD33117D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 15:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhCHO5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 09:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbhCHO5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 09:57:32 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12C5C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 06:57:31 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id bm21so20939810ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 06:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LD+oPeQow1xVqc+HYD3DbwSbqmX9ue85IWBHHpJuobw=;
        b=GtnxKeg5pWb7G0664knn8bzR+jM+QGQrMvuGjUWUS9jkFlbNiHsz14qFTYPzJp6EZz
         Ssg+OMxyyjcoBRMJooXiuVd7xbawDNTvl0YJWkT1jkZWJSLwAE1veBG54E6y6oQhAglE
         q3FH132kxpzA1yc9k5+XcFVNbD9zrFGOt2kSO1TAreE9ATuSU9r0y2VyvFLkNGatZ/I9
         s8Kv+QvrSOJsPe3/R4VFH+xv1vNe3gOf13aUilLwC6KHAJo5zinhjHNKjfKNGotlSK99
         szM/mWCwYMATYjXVuo0rFniu9A509+wkRDqo4zYBOS2wP8j+K7jpEeT7bp/6y2DsSooW
         Db1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LD+oPeQow1xVqc+HYD3DbwSbqmX9ue85IWBHHpJuobw=;
        b=D2k5n9hS7qFvAMlgAKIrc9pH/TDxO7eg/dGVx5SX37La/TCLMDtlq+NrenBgCVmsdc
         q5bAw734UXILqSVy8HFb63eI7K62r+k+tPrLg+ctfNdoj/LsolSCmjuKnCt0Ilu+N3ew
         Xc7wfFC/G5j2olimpvRiCGXjvFpprbEOb6bn0KgcX9GgiQ4SC0xs0OKHCu+2rSuXrSdC
         W94QySIWLP+F9wghzaiyExu4x4tROKo9jGxbMiePz6IDwyVoum+fwoX/JZEqmApKjfKc
         ere3y2ADagfBhLHGE5ujNTfikSVtIEhZXow/ppu5z4WEKUyWYME3D05dSrunMW1ZQg02
         l8MA==
X-Gm-Message-State: AOAM532ydnsF1n4lLmQgRB6GRt9wknw0TrxMaoDcADcpw+vTaqQmbXdP
        wkq+idh/CaazzOUdI/JJ/zCoF7Y/w76OFQ==
X-Google-Smtp-Source: ABdhPJyPz38GNLJw/gUpUETnESwxtpjS0ipnaXJFjeJdU+mU+A9NPb6q0cHEm74X3OTJPzFT8iR4XA==
X-Received: by 2002:a17:906:c051:: with SMTP id bm17mr15064968ejb.21.1615215450451;
        Mon, 08 Mar 2021 06:57:30 -0800 (PST)
Received: from [192.168.0.109] ([84.40.73.174])
        by smtp.gmail.com with ESMTPSA id cw14sm7553068edb.8.2021.03.08.06.57.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 06:57:30 -0800 (PST)
Subject: Re: [RFC PATCH 1/5] tracing: Define new ftrace event "func_repeats"
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org
References: <20210304090141.207309-1-y.karadz@gmail.com>
 <20210304090141.207309-2-y.karadz@gmail.com>
 <20210304113809.5c2ccceb@gandalf.local.home>
From:   "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Message-ID: <6f4083f2-6c71-e404-9000-b08ff94ab328@gmail.com>
Date:   Mon, 8 Mar 2021 16:57:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210304113809.5c2ccceb@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4.03.21 г. 18:38, Steven Rostedt wrote:
> On Thu,  4 Mar 2021 11:01:37 +0200
> "Yordan Karadzhov (VMware)" <y.karadz@gmail.com> wrote:
> 
> Thanks Yordan for doing this!
> 
> I have some comments below.
> 

Hi Steven,

Thank you very much for looking into this!

Your suggestion makes perfect sense. I only have one clarifying question 
below.

>> diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
>> index 4547ac59da61..8007f9b6417f 100644
>> --- a/kernel/trace/trace_entries.h
>> +++ b/kernel/trace/trace_entries.h
>> @@ -338,3 +338,19 @@ FTRACE_ENTRY(hwlat, hwlat_entry,
>>   		 __entry->nmi_total_ts,
>>   		 __entry->nmi_count)
>>   );
>> +
>> +FTRACE_ENTRY(func_repeats, func_repeats_entry,
>> +
>> +	TRACE_FUNC_REPEATS,
>> +
>> +	F_STRUCT(
>> +		__field(	unsigned long,	ip	)
>> +		__field(	unsigned long,	pip	)
>> +		__field(	unsigned long,	count	)
>> +	),
>> +
>> +	F_printk(" %ps <-%ps\t(repeats:%lu)",
>> +		 (void *)__entry->ip,
>> +		 (void *)__entry->pip,
>> +		 __entry->count)
> 
> After playing with this a little, I realized that we should also store the
> last timestamp as well. I think that would be interesting information.
> 
>             <...>-37      [004] ...1  2022.303820: gc_worker <-process_one_work
>             <...>-37      [004] ...1  2022.303820: ___might_sleep <-gc_worker
>             <...>-37      [004] ...1  2022.303831: ___might_sleep <-gc_worker (repeats: 127)
>             <...>-37      [004] ...1  2022.303831: queue_delayed_work_on <-process_one_work
> 
> The above shows that __might_sleep() was called 128 times, but what I don't
> get from the above, is when that last call was made. You'll see that the
> timestamp for the repeat output is the same as the next function shown
> (queue_delayed_work_on()). But the timestamp for the last call to
> __might_sleep() is lost, and the repeat event ends up being written when
> it is detected that there are no more repeats.
> 
> If we had:
> 
>             <...>-37      [004] ...1  2022.303820: gc_worker <-process_one_work
>             <...>-37      [004] ...1  2022.303820: ___might_sleep <-gc_worker
>             <...>-37      [004] ...1  2022.303831: ___might_sleep <-gc_worker (last ts: 2022.303828 repeats: 127)
>             <...>-37      [004] ...1  2022.303831: queue_delayed_work_on <-process_one_work
> 
> We would know the last time __might_sleep was called.
> 
> That is, not only should we save the ip and pip in the trace_func_repeats
> structure, but we should also be storing the last time stamp of the last
> function event that repeated. Otherwise the above looks like the last
> __might_sleep called above happened when the queue_delayed_work_on
> happened, where that may not be the case.

If we store the last timestamp, this means we will need to use 
additional 64b on the buffer, every time we record the "func_repeats" 
event. This looks like an overkill to me.
Can we store only the duration of the repeats (the difference between 
the timestamp)? This way we can use less memory at the price of having 
one extra arithmetic operation.
Alternative approach can be to store only the least-significant bits of 
the timestamp.

What do you think?

Best regards,
Yordan

> 
> -- Steve
> 
> 
