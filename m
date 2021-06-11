Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556A83A428F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 14:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhFKNBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:01:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29859 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231196AbhFKNBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623416357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bDzD7TzyGM8+Bk3AkjzQ9WfVLzVVyCXeOnlJBDf9+P8=;
        b=Dqk6RCfKTk3OsWR5wefmscXPoDlH7HRWqtMONRTbPhHZi04avhqxzgo3LQmV6wb+aYkjs6
        2cZ/XuviPmYB8JxMOd+jevKiWpZvLH/GfwdO7eKXqNj5lEneBfj4G6VeLFk+pCbZH0Lb9Q
        jG5cXQsZ3sGLSTUZphPF+xttXNElWq0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-fubM88BvMfWjhN_fCH1Scw-1; Fri, 11 Jun 2021 08:59:16 -0400
X-MC-Unique: fubM88BvMfWjhN_fCH1Scw-1
Received: by mail-ej1-f72.google.com with SMTP id n8-20020a1709067b48b02904171dc68f87so1089372ejo.21
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 05:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bDzD7TzyGM8+Bk3AkjzQ9WfVLzVVyCXeOnlJBDf9+P8=;
        b=I3GJV68FWLTXEgP+I4IcWfgTB4Ig7vvJoiW+pJdRL89CaKFPxBl6KDUJFzjQhpLvW/
         R184XnONZMYg9dCINyRHXLJsKO/dhLSg4PANj6Rhpw/0lxq0HtRNhcR+hheuFLucxDl/
         tSJ6yT/M+xmRGH0yRp1TEeGiSbL/gC2yWrc0uB8dcka7HD6RfK2a7PFPaduEVTd8I1zN
         qEynfVWXohbTGt4k2TO71iaZbM6lorIzOnrGFnVcPuD82bWPO35kqXVGEOFDVVqInuxQ
         hwCd2s8AHLQbQuvwlB2O4XeqUWYPTeDNNKZJC3FA0S0OMmdozJmXndorfoOQ1ByIX4tI
         9rXw==
X-Gm-Message-State: AOAM532Vi5Z73XJN6+fDrV+ldUoP14SyiyoPb8DnUNs7MRpnWXU9/zWp
        a9k6xeNQcMwGdO4cI0LEOLlvEue1BzEtt1AudQUd3dqEd5MEsBUm3C7LZ35dqMuTHWMheLRl1eL
        5BYUtmNw78L/LiMQI3mNrUKKk
X-Received: by 2002:a17:906:1792:: with SMTP id t18mr3451527eje.38.1623416355103;
        Fri, 11 Jun 2021 05:59:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJHPCrEZJvzvSrRG1N9mRxJMGWUgOa1GwGvH+66ZIO7/f5zyLtEWXte4aPNciNITKhJh4o/Q==
X-Received: by 2002:a17:906:1792:: with SMTP id t18mr3451502eje.38.1623416354812;
        Fri, 11 Jun 2021 05:59:14 -0700 (PDT)
Received: from x1.bristot.me (host-79-23-205-114.retail.telecomitalia.it. [79.23.205.114])
        by smtp.gmail.com with ESMTPSA id cx7sm2560631edb.65.2021.06.11.05.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 05:59:14 -0700 (PDT)
Subject: Re: [PATCH V3 9/9] tracing: Add timerlat tracer
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kate Carcia <kcarcia@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, linux-doc@vger.kernel.org
References: <cover.1621024265.git.bristot@redhat.com>
 <b650672b9973887ef1420bc1e76b97940b6522d6.1621024265.git.bristot@redhat.com>
 <20210607213639.68aad064@gandalf.local.home>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <fd2bdb45-e68a-995e-271e-ec181f04ecbc@redhat.com>
Date:   Fri, 11 Jun 2021 14:59:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210607213639.68aad064@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/21 3:36 AM, Steven Rostedt wrote:
> On Fri, 14 May 2021 22:51:18 +0200
> Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

[...]
>> It is possible to follow the trace by reading the trace trace file::
> 
> Do not need rst markup in commit logs ;-)
> 
>>
>>   [root@f32 tracing]# cat trace
>>   # tracer: timerlat
>>   #
>>   #                              _-----=> irqs-off
>>   #                             / _----=> need-resched
>>   #                            | / _---=> hardirq/softirq
>>   #                            || / _--=> preempt-depth
>>   #                            || /
>>   #                            ||||             ACTIVATION
>>   #         TASK-PID      CPU# ||||   TIMESTAMP    ID            CONTEXT                LATENCY
>>   #            | |         |   ||||      |         |                  |                       |
>>           <idle>-0       [000] d.h1    54.029328: #1     context    irq timer_latency       932 ns
>>            <...>-867     [000] ....    54.029339: #1     context thread timer_latency     11700 ns
>>           <idle>-0       [001] dNh1    54.029346: #1     context    irq timer_latency      2833 ns
>>            <...>-868     [001] ....    54.029353: #1     context thread timer_latency      9820 ns
>>           <idle>-0       [000] d.h1    54.030328: #2     context    irq timer_latency       769 ns
>>            <...>-867     [000] ....    54.030330: #2     context thread timer_latency      3070 ns
>>           <idle>-0       [001] d.h1    54.030344: #2     context    irq timer_latency       935 ns
>>            <...>-868     [001] ....    54.030347: #2     context thread timer_latency      4351 ns
>>
>> The tracer creates a per-cpu kernel thread with real-time priority that
>> prints two lines at every activation. The first is the *timer latency*
>> observed at the *hardirq* context before the activation of the thread.
>> The second is the *timer latency* observed by the thread, which is the
>> same level that cyclictest reports. The ACTIVATION ID field
> 
> The above is misleading. Below, I see that you state that the values are
> "net values" where the thread latency does not include the irq latency.
> This is not the same as cyclictest. (I had to update my ASCII art below
> after reading the below statement).

Replying here all the comments about the timerlat/cyclictest
timeline, and gross/net values.

So, yeah, my description was not clear enough. The values that are
net are those reported by the *osnoise: events* only. The *timerlat
tracer* values are not discounted, and that is why they are similar
to the value reported by cyclictest (ok, cyclictest still captures
the exit to user overhead and friends).

>> serves to relate the *irq* execution to its respective *thread* execution.
>>
>> The irq/thread splitting is important to clarify at which context
>> the unexpected high value is coming from. The *irq* context can be
>> delayed by hardware related actions, such as SMIs, NMIs, IRQs
>> or by a thread masking interrupts. Once the timer happens, the delay
>> can also be influenced by blocking caused by threads. For example, by
>> postponing the scheduler execution via preempt_disable(),  by the
>> scheduler execution, or by masking interrupts. Threads can
>> also be delayed by the interference from other threads and IRQs.
> 
> 
> I wonder if ASCII art would help clarify the above. At least for the
> document (not the change log here).
> 
> 
>   time ==>
>             expected         actual      thread
>              wakeup          wakeup     scheduled
>                 |              |          |
>                 v              v          v
>       |---------|-------|------|----------|
>                         ^
>                         |
>                     interrupt 
> 
>                 |--------------|
>                    irq latency
> 
>                                |-----------|
>                        thread latency
> 

A liked the idea of adding a timeline!

[...]

>> +  [root@f32 tracing]# cat trace
>> +  # tracer: timerlat
>> +  #
>> +  #                              _-----=> irqs-off
>> +  #                             / _----=> need-resched
>> +  #                            | / _---=> hardirq/softirq
>> +  #                            || / _--=> preempt-depth
>> +  #                            || /
>> +  #                            ||||             ACTIVATION
>> +  #         TASK-PID      CPU# ||||   TIMESTAMP    ID            CONTEXT                LATENCY
>> +  #            | |         |   ||||      |         |                  |                       |
>> +          <idle>-0       [000] d.h1    54.029328: #1     context    irq timer_latency       932 ns
>> +           <...>-867     [000] ....    54.029339: #1     context thread timer_latency     11700 ns
>> +          <idle>-0       [001] dNh1    54.029346: #1     context    irq timer_latency      2833 ns
>> +           <...>-868     [001] ....    54.029353: #1     context thread timer_latency      9820 ns
>> +          <idle>-0       [000] d.h1    54.030328: #2     context    irq timer_latency       769 ns
>> +           <...>-867     [000] ....    54.030330: #2     context thread timer_latency      3070 ns
>> +          <idle>-0       [001] d.h1    54.030344: #2     context    irq timer_latency       935 ns
>> +           <...>-868     [001] ....    54.030347: #2     context thread timer_latency      4351 ns
>> +
>> +
>> +The tracer creates a per-cpu kernel thread with real-time priority that
>> +prints two lines at every activation. The first is the *timer latency*
>> +observed at the *hardirq* context before the activation of the thread.
>> +The second is the *timer latency* observed by the thread, which is the
>> +same level that cyclictest reports. The ACTIVATION ID field
>> +serves to relate the *irq* execution to its respective *thread* execution.
>> +
>> +The *irq*/*thread* splitting is important to clarify at which context
>> +the unexpected high value is coming from. The *irq* context can be
>> +delayed by hardware related actions, such as SMIs, NMIs, IRQs
>> +or by a thread masking interrupts. Once the timer happens, the delay
>> +can also be influenced by blocking caused by threads. For example, by
>> +postponing the scheduler execution via preempt_disable(),  by the
>> +scheduler execution, or by masking interrupts. Threads can
>> +also be delayed by the interference from other threads and IRQs.
> 
> This is where I would add that ASCII art.

I am proposing a ASCII art on another point.... see bellow.

> 
>> +
>> +Tracer options
>> +---------------------
>> +
>> +The timerlat tracer is built on top of osnoise tracer.
>> +So its configuration is also done in the osnoise/ config
>> +directory. The timerlat configs are:
>> +
>> + - cpus: CPUs at which a timerlat thread will execute.
>> + - timerlat_period_us: the period of the timerlat thread.
>> + - osnoise/stop_tracing_in_us: stop the system tracing if a
>> +   timer latency at the *irq* context higher than the configured
>> +   value happens. Writing 0 disables this option.
>> + - stop_tracing_out_us: stop the system tracing if a
>> +   timer latency at the *thread* context higher than the configured
>> +   value happens. Writing 0 disables this option.
>> + - print_stack: save the stack of the IRQ ocurrence, and print
>> +   it after the *thread* read the latency.
> 
> "thread read the latency" doesn't make sense.
> 
>  "and print it after the *thread context* event".  ?
> 
> 
>> +
>> +timerlat and osnoise
>> +----------------------------
>> +
>> +The timerlat can also take advantage of the osnoise: traceevents.
>> +For example::
>> +
>> +        [root@f32 ~]# cd /sys/kernel/tracing/
>> +        [root@f32 tracing]# echo timerlat > current_tracer
>> +        [root@f32 tracing]# echo osnoise > set_event
> 
> Note, set_event should be deprecated. Use:
> 
> 	echo 1 > events/osnoise/enable
> 
> instead.
> 
> 
>> +        [root@f32 tracing]# echo 25 > osnoise/stop_tracing_out_us
>> +        [root@f32 tracing]# tail -10 trace
>> +             cc1-87882   [005] d..h...   548.771078: #402268 context    irq timer_latency      1585 ns
>> +             cc1-87882   [005] dNLh1..   548.771082: irq_noise: local_timer:236 start 548.771077442 duration 4597 ns
>> +             cc1-87882   [005] dNLh2..   548.771083: irq_noise: reschedule:253 start 548.771083017 duration 56 ns
>> +             cc1-87882   [005] dNLh2..   548.771086: irq_noise: call_function_single:251 start 548.771083811 duration 2048 ns
>> +             cc1-87882   [005] dNLh2..   548.771088: irq_noise: call_function_single:251 start 548.771086814 duration 1495 ns
>> +             cc1-87882   [005] dNLh2..   548.771091: irq_noise: call_function_single:251 start 548.771089194 duration 1558 ns
>> +             cc1-87882   [005] dNLh2..   548.771094: irq_noise: call_function_single:251 start 548.771091719 duration 1932 ns
>> +             cc1-87882   [005] dNLh2..   548.771096: irq_noise: call_function_single:251 start 548.771094696 duration 1050 ns
>> +             cc1-87882   [005] d...3..   548.771101: thread_noise:      cc1:87882 start 548.771078243 duration 10909 ns
>> +      timerlat/5-1035    [005] .......   548.771103: #402268 context thread timer_latency     25960 ns
>> +
>> +In this case, the root cause of the timer latency does not point for a
>> +single, but to a series of call_function_single IPIs, followed by a 10
> 
> "not point to a single"
> 
>> +*us* delay from a cc1 thread noise, along with the regular timer
>> +activation. It is worth mentioning that the *duration* values reported
>> +by the osnoise events are *net* values. For example, the
>> +thread_noise does not include the duration of the overhead caused
>> +by the IRQ execution (which indeed accounted for 12736 ns).
> 
> As stated above, I updated my view of the ASCII art after reading this. You
> should not compare what cyclictest reports as the thread latency. But what
> cyclictest reports is the sum of the two (irq latency plus thread latency).

Here is the point where I mention net values... so I am changing this part of
documentation to:

------------------- %< -----------------------------
It is worth mentioning that the *duration* values reported
by the osnoise: events are *net* values. For example, the
thread_noise does not include the duration of the overhead caused
by the IRQ execution (which indeed accounted for 12736 ns). But
the values reported by the timerlat tracer (timerlat_latency)
are *gross* values.

The art below illustrates a CPU timeline and how the timerlat tracer
observes it at the top and the osnoise: events at the bottom. Each "-"
in the timelines means 1 us, and the time moves ==>:

     External          context irq                  context thread
      clock           timer_latency                 timer_latency
      event              18 us                          48 us 
        |                  ^                             ^
        v                  |                             |
        |------------------|                             |       <-- timerlat irq timeline
        |------------------+-----------------------------|       <-- timerlat thread timeline
                           ^                             ^
 ===================== CPU timeline ======================================
                   [timerlat/ irq]  [ dev irq ]                          
 [another thread...^             v..^         v........][timerlat/ thread]  
 ===================== CPU timeline ======================================
                   |-------------|  |---------|                  <-- irq_noise timeline
                                 |--^         v--------|         <-- thread_noise timeline
                                 |            |        |
                                 |            |        + thread_noise: 10 us
                                 |            +-> irq_noise: 9 us
                                 +-> irq_noise: 13 us

 --------------- >% --------------------------------

thoughts?

-- Daniel

