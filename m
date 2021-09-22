Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2BC413F68
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 04:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbhIVC2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 22:28:05 -0400
Received: from out0.migadu.com ([94.23.1.103]:18060 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhIVC2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 22:28:04 -0400
Subject: Re: [PATCH] tracing: fix missing osnoise tracer on max_latency
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1632277593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=11m4hXCLZySPqYTcDmlkoX7CxkvFHtkT+xL37beSJ0Q=;
        b=ENX1NX9IYAmAQZbUBdGeYb34Fm9zwLtYF6NWH3weFy/ZhXUrMTgf6JOwh2et0lKcs8JIeZ
        j0pjSOJusfQLKvrszlDO2h/epa30euIOEcUz+CsDI8WDtlsuWX5ucBwA5qAZxrFu7ZQHHr
        qXMS8lNT1ptkG7LxwTENl+X1zOzOGsQ=
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, bristot@redhat.com
References: <20210918051118.1096575-1-liu.yun@linux.dev>
 <20210919120124.3e2b1b7b@rorschach.local.home>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jackie Liu <liu.yun@linux.dev>
Message-ID: <650206a9-500d-2dcf-69d1-946c470dac25@linux.dev>
Date:   Wed, 22 Sep 2021 10:26:24 +0800
MIME-Version: 1.0
In-Reply-To: <20210919120124.3e2b1b7b@rorschach.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: liu.yun@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Steven.

在 2021/9/20 上午12:01, Steven Rostedt 写道:
> On Sat, 18 Sep 2021 13:11:18 +0800
> Jackie Liu <liu.yun@linux.dev> wrote:
> 
>> From: Jackie Liu <liuyun01@kylinos.cn>
>>
>> The compiler warns when the data are actually unused:
>>
>>    kernel/trace/trace.c:1712:13: error: ‘trace_create_maxlat_file’ defined but not used [-Werror=unused-function]
>>     1712 | static void trace_create_maxlat_file(struct trace_array *tr,
>>          |             ^~~~~~~~~~~~~~~~~~~~~~~~
>>
>> [Why]
>> CONFIG_HWLAT_TRACER=n, CONFIG_TRACER_MAX_TRACE=n, CONFIG_OSNOISE_TRACER=y
>> gcc report warns.
>>
>> [How]
>> Now trace_create_maxlat_file will only take effect when
>> CONFIG_HWLAT_TRACER=y or CONFIG_TRACER_MAX_TRACE=y. In fact, after
>> adding osnoise trace, it also needs to take effect.
>>
>> BTW, Fixed the conflicting defined comment information.
> 
> Thanks for the report.
> 
>>
>> Fixes: bce29ac9ce0b ("trace: Add osnoise tracer")
>> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
>> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
>> ---
>>   kernel/trace/trace.c | 9 +++------
>>   1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>> index 7896d30d90f7..d7e3ed82fafd 100644
>> --- a/kernel/trace/trace.c
>> +++ b/kernel/trace/trace.c
>> @@ -1744,11 +1744,7 @@ void latency_fsnotify(struct trace_array *tr)
>>   	irq_work_queue(&tr->fsnotify_irqwork);
>>   }
>>   
>> -/*
>> - * (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
>> - *  defined(CONFIG_FSNOTIFY)
>> - */
>> -#else
>> +#else /* LATENCY_FS_NOTIFY  >>
>>   #define trace_create_maxlat_file(tr, d_tracer)				\
>>   	trace_create_file("tracing_max_latency", 0644, d_tracer,	\
> 
> To clean this up even better, we should add here:
> 
> #elif defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER) \
> 	|| defined(CONFIG_OSNOISE_TRACER)

This place should need to use LATENCY_FS_NOTIFY, because not only these
three Traces, we also need to pay attention to CONFIG_FSNOTIFY, at
least, we should not change the original meaning.

How about this:

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 7896d30d90f7..6a88d03c6d3b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1744,16 +1744,14 @@ void latency_fsnotify(struct trace_array *tr)
         irq_work_queue(&tr->fsnotify_irqwork);
  }

-/*
- * (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
- *  defined(CONFIG_FSNOTIFY)
- */
-#else
+#elif defined(LATENCY_FS_NOTIFY)

  #define trace_create_maxlat_file(tr, d_tracer)                         \
         trace_create_file("tracing_max_latency", 0644, d_tracer,        \
                           &tr->max_latency, &tracing_max_lat_fops)

+#else
+#define trace_create_maxlat_file(tr, d_tracer)  do { } while (0)
  #endif

  #ifdef CONFIG_TRACER_MAX_TRACE
@@ -9473,9 +9471,7 @@ init_tracer_tracefs(struct trace_array *tr, struct 
dentry *d_tracer)

         create_trace_options_dir(tr);

-#if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
         trace_create_maxlat_file(tr, d_tracer);
-#endif

         if (ftrace_create_function_files(tr, d_tracer))
                 MEM_FAIL(1, "Could not allocate function filter files");


==
What do you think? If there is no problem, I will send V2.

--
BR.
Jackie Liu

> 
> #  define trace_create_maxlat_file(tr, d_tracer)			\
> 	trace_create_file("tracing_max_latency", 0644, d_tracer,	\
> 			  &tr->max_latency, &tracing_max_lat_fops)
> 
> #else
> # define trace_create_maxlat_file(tr, d_tracer)	 do { } while (0)
> #endif
> 
>> @@ -9473,7 +9469,8 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
>>   
>>   	create_trace_options_dir(tr);
>>   
>> -#if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
>> +#if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER) \
>> +	|| defined(CONFIG_OSNOISE_TRACER)
> 
> And remove the #if statement complete from inside the function.
> 
> -- Steve
> 
>>   	trace_create_maxlat_file(tr, d_tracer);
>>   #endif
>>   
> 
