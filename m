Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308D3413FBC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 04:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbhIVCrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 22:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhIVCq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 22:46:59 -0400
X-Greylist: delayed 499 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Sep 2021 19:45:30 PDT
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAF6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 19:45:29 -0700 (PDT)
Subject: Re: [PATCH] tracing: fix missing osnoise tracer on max_latency
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1632278728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lv6RGpQNH1U+F7E0m5cJriKp+OIAjiqADkPShgavMgA=;
        b=cp4AG9WyI0d9+JIKjYBAk3ZFCCv1iuRYqsQv5D95ytL12vv5K4CrwmNAo8gauXFErCZuES
        m5ZF1BG53j3abpKhU+70hcfKcp0I1qZayGCBBl2Zf5wCQZWS2oP5mHCGo4vCvHw3vBcEhD
        Qmdy1qGtpInwE/oCJBok0NhbucnPdoE=
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, bristot@redhat.com
References: <20210918051118.1096575-1-liu.yun@linux.dev>
 <20210919120124.3e2b1b7b@rorschach.local.home>
 <650206a9-500d-2dcf-69d1-946c470dac25@linux.dev>
 <20210921224048.4c5b414d@oasis.local.home>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jackie Liu <liu.yun@linux.dev>
Message-ID: <6ee02953-4d43-039f-47f7-0efaa69a6f16@linux.dev>
Date:   Wed, 22 Sep 2021 10:45:21 +0800
MIME-Version: 1.0
In-Reply-To: <20210921224048.4c5b414d@oasis.local.home>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: liu.yun@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2021/9/22 ÉÏÎç10:40, Steven Rostedt Ð´µÀ:
> On Wed, 22 Sep 2021 10:26:24 +0800
> Jackie Liu <liu.yun@linux.dev> wrote:
> 
>>>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>>>> index 7896d30d90f7..d7e3ed82fafd 100644
>>>> --- a/kernel/trace/trace.c
>>>> +++ b/kernel/trace/trace.c
>>>> @@ -1744,11 +1744,7 @@ void latency_fsnotify(struct trace_array *tr)
>>>>    	irq_work_queue(&tr->fsnotify_irqwork);
>>>>    }
>>>>    
>>>> -/*
>>>> - * (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
>>>> - *  defined(CONFIG_FSNOTIFY)
>>>> - */
>>>> -#else
>>>> +#else /* LATENCY_FS_NOTIFY  >>
>>>>    #define trace_create_maxlat_file(tr, d_tracer)				\
>>>>    	trace_create_file("tracing_max_latency", 0644, d_tracer,	\
>>>
>>> To clean this up even better, we should add here:
>>>
>>> #elif defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER) \
>>> 	|| defined(CONFIG_OSNOISE_TRACER)
>>
>> This place should need to use LATENCY_FS_NOTIFY, because not only these
>> three Traces, we also need to pay attention to CONFIG_FSNOTIFY, at
>> least, we should not change the original meaning.
>>
>> How about this:
>>
>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>> index 7896d30d90f7..6a88d03c6d3b 100644
>> --- a/kernel/trace/trace.c
>> +++ b/kernel/trace/trace.c
>> @@ -1744,16 +1744,14 @@ void latency_fsnotify(struct trace_array *tr)
>>           irq_work_queue(&tr->fsnotify_irqwork);
>>    }
>>
>> -/*
>> - * (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
>> - *  defined(CONFIG_FSNOTIFY)
>> - */
>> -#else
>> +#elif defined(LATENCY_FS_NOTIFY)
> 
> Um, but isn't the #if before the #else:
> 
>    #ifdef LATENCY_FS_NOTIFY
> 
> ?
> 
> Then, here we have:
> 
> 
> #ifdef LATENCY_FS_NOTIFY
> 
> [..]
> 
> #elif defined(LATENCY_FS_NOTIFY)
> 
> // this will never be called.
> 
> That doesn't make any sense.
> 
> -- Steve

Thanks Steve, I see.  :)

-- 
BR, Jackie Liu

> 
>>
>>    #define trace_create_maxlat_file(tr, d_tracer)                         \
>>           trace_create_file("tracing_max_latency", 0644, d_tracer,        \
>>                             &tr->max_latency, &tracing_max_lat_fops)
>>
>> +#else
>> +#define trace_create_maxlat_file(tr, d_tracer)  do { } while (0)
>>    #endif
>>
>>    #ifdef CONFIG_TRACER_MAX_TRACE
>> @@ -9473,9 +9471,7 @@ init_tracer_tracefs(struct trace_array *tr, struct
>> dentry *d_tracer)
>>
>>           create_trace_options_dir(tr);
>>
>> -#if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
>>           trace_create_maxlat_file(tr, d_tracer);
>> -#endif
>>
>>           if (ftrace_create_function_files(tr, d_tracer))
>>                   MEM_FAIL(1, "Could not allocate function filter files");
>>
>>
>> ==
>> What do you think? If there is no problem, I will send V2.
>>
