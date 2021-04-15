Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9B4360AD1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 15:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbhDONoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 09:44:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45619 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233278AbhDONoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 09:44:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618494233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DpNKF7tYIma/A015g27QHa5Y8uvp6cu7V7Zo6pelFWY=;
        b=EW5hF28OuK4KgKMXU1Bqg5zomDT5TKu4SYJEsU1dSpZ+EKEMAnGtXgOpMQGE1/aJ5F2Ij/
        ZtDM6rPCbQtVQ1YZZkaIc/3ZtT/BCzz+EqyIqhekgjlP0g0YYW+jZl4zmjk39seiEqYPrx
        GTU1Pawr2i4ieO/EGwPU6JEdCvYeJQA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-LMmR1WNMP_GTIft8gz0UfQ-1; Thu, 15 Apr 2021 09:43:51 -0400
X-MC-Unique: LMmR1WNMP_GTIft8gz0UfQ-1
Received: by mail-ej1-f72.google.com with SMTP id g7-20020a1709065d07b029037c872d9cdcso947563ejt.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 06:43:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DpNKF7tYIma/A015g27QHa5Y8uvp6cu7V7Zo6pelFWY=;
        b=TOpTtp/5R5uhv+JDmT+QNg38Q6fDIJFxWmJwlEG1hopiCwET0hZw5qXMb8tFND7AU5
         ggIqEEwFZwoNQMJ2Z51mirBPex8iq4DW7W89XZpdw2y2DUBdnycH0R++6WHzq2nKlHhD
         y0WeUq5CSDqA7E4tulABijxgyIFY2FVEGlNGNtNdKeBufxPXtY6nMBdvnXeHTiGJVJoY
         2znpBMmqaeVi2u11Y8+mC1Z3KaPfqekIpNDlMSbaC87mbQYsgp3LGn/SMVf5wHtPPdgj
         vow8dPBQGEgSkJ5qojEs4Cmar76YvAA4OAJYssRObjlCHQIXHD0udje3ClrFPzr/3ZuO
         c3Xw==
X-Gm-Message-State: AOAM530k2X07OamGwnsKe4Az1VPxru+c3Rc48r1sENjuT1Z09n+oT/4S
        UDsmjzo5oIeqSVD9rOuYXoZoJFb9jN0hL5gx80TRidNOzhwFvTN3d7gPDV04Is+24IRxbiGIpH4
        dnMuEDxZabH+ZFdQekvesI5St
X-Received: by 2002:a17:907:3f08:: with SMTP id hq8mr3601913ejc.90.1618494230221;
        Thu, 15 Apr 2021 06:43:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqdjl1gYnSl3cS6fKuUW/wcpkvtTQF231XCRROyIeskVbvOMrKm1Ep1OzpvtDTVQAWp5usKg==
X-Received: by 2002:a17:907:3f08:: with SMTP id hq8mr3601880ejc.90.1618494229866;
        Thu, 15 Apr 2021 06:43:49 -0700 (PDT)
Received: from x1.bristot.me (host-79-56-201-31.retail.telecomitalia.it. [79.56.201.31])
        by smtp.gmail.com with ESMTPSA id i10sm2575658edt.3.2021.04.15.06.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 06:43:49 -0700 (PDT)
Subject: Re: [RFC PATCH 5/5] tracing: Add the osnoise tracer
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, kcarcia@redhat.com,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, linux-doc@vger.kernel.org
References: <cover.1617889883.git.bristot@redhat.com>
 <3a69303b27bfc5d2274ab893b2cfbd0a8dbe31f7.1617889883.git.bristot@redhat.com>
 <20210414131402.2bd448ee@gandalf.local.home>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <ef6f08f1-a798-c99e-4bd6-7b323ab29b87@redhat.com>
Date:   Thu, 15 Apr 2021 15:43:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210414131402.2bd448ee@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/21 7:14 PM, Steven Rostedt wrote:
> On Thu,  8 Apr 2021 16:13:23 +0200
> Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> 
>> In the context of high-performance computing (HPC), the Operating System
>> Noise (osnoise) refers to the interference experienced by an application
>> due to activities inside the operating system. In the context of Linux,
>> NMIs, IRQs, SoftIRQs, and any other system thread can cause noise to the
>> system. Moreover, hardware-related jobs can also cause noise, for example,
>> via SMIs.
>>
>> hwlat_detector is one of the tools used to identify the most complex
>> source of noise: hardware noise.
>>
>> In a nutshell, the hwlat_detector creates a thread that runs
>> periodically for a given period. At the beginning of a period, the thread
>> disables interrupt and starts sampling. While running, the hwlatd
>> thread reads the time in a loop. As interrupts are disabled, threads,
>> IRQs, and SoftIRQs cannot interfere with the hwlatd thread. Hence, the
>> cause of any gap between two different reads of the time roots either on
>> NMI or in the hardware itself. At the end of the period, hwlatd enables
>> interrupts and reports the max observed gap between the reads. It also
>> prints an NMI occurrence counter. If the output does not report NMI
>> executions, the user can conclude that the hardware is the culprit for
>> the latency. The hwlat detects the NMI execution by observing
>> the entry and exit of an NMI.
>>
>> The osnoise tracer leverages the hwlat_detector by running a
>> similar loop with preemption, SoftIRQs and IRQs enabled, thus allowing
>> all the sources of osnoise during its execution. Using the same approach
>> of hwlat, osnoise takes note of the entry and exit point of any
>> source of interferences, increasing a per-cpu interference counter. The
>> osnoise tracer also saves an interference counter for each source of
>> interference. The interference counter for NMI, IRQs, SoftIRQs, and
>> threads is increased anytime the tool observes these interferences' entry
>> events. When a noise happens without any interference from the operating
>> system level, the hardware noise counter increases, pointing to a
>> hardware-related noise. In this way, osnoise can account for any
>> source of interference. At the end of the period, the osnoise tracer
>> prints the sum of all noise, the max single noise, the percentage of CPU
>> available for the thread, and the counters for the noise sources.
>>
>> Usage
>>
>> Write the ASCII text osnoise into the current_tracer file of the
>> tracing system (generally mounted at /sys/kernel/tracing or
>> /sys/kernel/debug/tracing).
>>
>> For example::
>>
>>         [root@f32 ~]# cd /sys/kernel/tracing/
>>         [root@f32 tracing]# echo osnoise > current_tracer
>>
>> It is possible to follow the trace by reading the trace trace file::
>>
>>         [root@f32 tracing]# cat trace
>>         # tracer: osnoise
>>         #
>>         #                                _-----=> irqs-off
>>         #                               / _----=> need-resched
>>         #                              | / _---=> hardirq/softirq
>>         #                              || / _--=> preempt-depth                            MAX
>>         #                              || /                                             SINGLE     Interference counters:
>>         #                              ||||               RUNTIME      NOISE   % OF CPU  NOISE    +-----------------------------+
>>         #           TASK-PID      CPU# ||||   TIMESTAMP    IN US       IN US  AVAILABLE  IN US     HW    NMI    IRQ   SIRQ THREAD
>>         #              | |         |   ||||      |           |             |    |            |      |      |      |      |      |
>>                    <...>-859     [000] ....    81.637220: 1000000        190  99.98100       9     18      0   1007     18      1
>>                    <...>-860     [001] ....    81.638154: 1000000        656  99.93440      74     23      0   1006     16      3
>>                    <...>-861     [002] ....    81.638193: 1000000       5675  99.43250     202      6      0   1013     25     21
>>                    <...>-862     [003] ....    81.638242: 1000000        125  99.98750      45      1      0   1011     23      0
>>                    <...>-863     [004] ....    81.638260: 1000000       1721  99.82790     168      7      0   1002     49     41
>>                    <...>-864     [005] ....    81.638286: 1000000        263  99.97370      57      6      0   1006     26      2
>>                    <...>-865     [006] ....    81.638302: 1000000        109  99.98910      21      3      0   1006     18      1
>>                    <...>-866     [007] ....    81.638326: 1000000       7816  99.21840     107      8      0   1016     39     19
>>
>> In addition to the regular trace fields (from TASK-PID to TIMESTAMP), the
>> tracer prints a message at the end of each period for each CPU that is
>> running an osnoise/ thread. The osnoise specific fields report:
>>
>>  - The RUNTIME IN USE reports the amount of time in microseconds that
>>    the osnoise thread kept looping reading the time.
>>  - The NOISE IN US reports the sum of noise in microseconds observed
>>    by the osnoise tracer during the associated runtime.
>>  - The % OF CPU AVAILABLE reports the percentage of CPU available for
>>    the osnoise thread during the runtime window.
>>  - The MAX SINGLE NOISE IN US reports the maximum single noise observed
>>    during the runtime window.
>>  - The Interference counters display how many each of the respective
>>    interference happened during the runtime window.
>>
>> Note that the example above shows a high number of HW noise samples.
>> The reason being is that this sample was taken on a virtual machine,
>> and the host interference is detected as a hardware interference.
>>
>> Tracer options
>>
>> The tracer has a set of options inside the osnoise directory, they are:
>>
>>  - cpus: CPUs at which a osnoise thread will execute.
> 
> Again, I think we can reuse the tracing_cpumask.
> 
>>  - period_us: the period of the osnoise thread.
>>  - runtime_us: how long an osnoise thread will look for noise.
> 
> These seem the same as window and width. At a minimum should probably share
> the same code.

how about creating a generic handler for all the "to long" writes, that receives
a structure containing a pointer to where to save the value, a min and a max
acceptable value?

If so, where to place this function? trace.c?

>>  - stop_tracing_single_us: stop the system tracing of a single noise
>>    higher than the configured value is happens. Writing 0 disables this
>>    option.
>>  - stop_tracing_total_us: stop the system tracing of a NOISE IN USE
>>    higher than the configured value is happens. Writing 0 disables this
>>    option.
>>  - tolerance_ns: the minimum delta between two time() reads to be
>>    considered as noise.
> 
> You can use tracing_threshold for the tolerance. Do you really need it in
> ns?

Yes, I can. I placed it in ns to serve as a fine tune that one might need. But,
I can use the tracing_threshold in us as well.

>>
>> Additional Tracing
>>
>> In addition to the tracer, a set of tracepoints were added to
>> facilitate the identification of the osnoise source.
>>
>>  - osnoise:sample_threshold: printed anytime a noise is higher than
>>    the configurable tolerance_ns.
>>  - osnoise:nmi_noise: noise from NMI, including the duration.
>>  - osnoise:irq_noise: noise from an IRQ, including the duration.
>>  - osnoise:softirq_noise: noise from a SoftIRQ, including the
>>    duration.
>>  - osnoise:thread_noise: noise from a thread, including the duration.
>>
>> Note that a all the values are net values. This means that a thread
>> duration will not contain the duration of the IRQs that happened during
>> its execution, for example. The same is valid for all duration values.
>>
>> Here is one example of the usage of these tracepoints::
>>
>>        osnoise/8-961     [008] d.h.  5789.857532: irq_noise: local_timer:236 start 5789.857529929 duration 1845 ns
>>        osnoise/8-961     [008] dNh.  5789.858408: irq_noise: local_timer:236 start 5789.858404871 duration 2848 ns
>>      migration/8-54      [008] d...  5789.858413: thread_noise: migration/8:54 start 5789.858409300 duration 3068 ns
>>        osnoise/8-961     [008] ....  5789.858413: sample_threshold: start 5789.858404555 duration 8 us interferences 2
>>
>> In this example, a noise sample of 8 microseconds was reported in the last
>> fine, pointing to two interferences. Looking backward in the trace, the
>> two previous entries were about the migration thread running after
>> a timer IRQ execution. The first event is not part of the noise because
>> it took place one millisecond before.
>>
>> It is worth noticing that the sum of the duration reported in the
>> tracepoints is smaller than eight us reported in the
>> sample_threshold. The reason roots in the tracing overhead and in
>> the overhead of the entry and exit code that happens before and after
>> any interference execution. This justifies the dual approach: measuring
>> thread and tracing.
> 
> I'm not sure the tracing overhead had much to do with it as did the
> overhead of entering the interrupt itself. events are rather fast (usually
> less than 200ns depending on the system). You can always enable the
> benchmark_event to see what trace event overhead is. Then again, cold cache
> can play into it as well.

I agree, I will remove the tracing overhead part.

>>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Alexandre Chartre <alexandre.chartre@oracle.com>
>> Cc: Clark Willaims <williams@redhat.com>
>> Cc: John Kacur <jkacur@redhat.com>
>> Cc: Juri Lelli <juri.lelli@redhat.com>
>> Cc: linux-doc@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
>>
>> ---
>>  Documentation/trace/osnoise_tracer.rst |  149 ++
>>  include/linux/ftrace_irq.h             |   16 +
>>  include/trace/events/osnoise.h         |  141 ++
>>  kernel/trace/Kconfig                   |   34 +
>>  kernel/trace/Makefile                  |    1 +
>>  kernel/trace/trace.h                   |    9 +-
>>  kernel/trace/trace_entries.h           |   27 +
>>  kernel/trace/trace_osnoise.c           | 1714 ++++++++++++++++++++++++
>>  kernel/trace/trace_output.c            |   72 +-
>>  9 files changed, 2159 insertions(+), 4 deletions(-)
>>  create mode 100644 Documentation/trace/osnoise_tracer.rst
>>  create mode 100644 include/trace/events/osnoise.h
>>  create mode 100644 kernel/trace/trace_osnoise.c
>>
>> diff --git a/Documentation/trace/osnoise_tracer.rst b/Documentation/trace/osnoise_tracer.rst
>> new file mode 100644
>> index 000000000000..9a97f557317b
>> --- /dev/null
>> +++ b/Documentation/trace/osnoise_tracer.rst
>> @@ -0,0 +1,149 @@
>> +==============
>> +OSNOISE Tracer
>> +==============
>> +
>> +In the context of high-performance computing (HPC), the Operating System
>> +Noise (*osnoise*) refers to the interference experienced by an application
>> +due to activities inside the operating system. In the context of Linux,
>> +NMIs, IRQs, SoftIRQs, and any other system thread can cause noise to the
>> +system. Moreover, hardware-related jobs can also cause noise, for example,
>> +via SMIs.
>> +
>> +``hwlat_detector`` is one of the tools used to identify the most complex
>> +source of noise: *hardware noise*.
>> +
>> +In a nutshell, the ``hwlat_detector`` creates a thread that runs
>> +periodically for a given period. At the beginning of a period, the thread
>> +disables interrupt and starts sampling. While running, the ``hwlatd``
>> +thread reads the time in a loop. As interrupts are disabled, threads,
>> +IRQs, and SoftIRQs cannot interfere with the ``hwlatd`` thread. Hence, the
>> +cause of any gap between two different reads of the time roots either on
>> +NMI or in the hardware itself. At the end of the period, ``hwlatd`` enables
>> +interrupts and reports the max observed gap between the reads. It also
>> +prints a NMI occurrence counter. If the output does not report NMI
>> +executions, the user can conclude that the hardware is the culprit for
>> +the latency. The ``hwlat`` detects the NMI execution by observing
>> +the entry and exit of a NMI.
>> +
>> +The ``osnoise`` tracer leverages the ``hwlat_detector`` by running a
>> +similar loop with preemption, SoftIRQs and IRQs enabled, thus allowing
>> +all the sources of *osnoise* during its execution. Using the same approach
>> +of ``hwlat``, ``osnoise`` takes note of the entry and exit point of any
>> +source of interferences, increasing a per-cpu interference counter. The
>> +``osnoise`` tracer also saves an interference counter for each source of
>> +interference. The interference counter for NMI, IRQs, SoftIRQs, and
>> +threads is increased anytime the tool observes these interferences' entry
>> +events. When a noise happens without any interference from the operating
>> +system level, the hardware noise counter increases, pointing to a
>> +hardware-related noise. In this way, ``osnoise`` can account for any
>> +source of interference. At the end of the period, the ``osnoise`` tracer
>> +prints the sum of all noise, the max single noise, the percentage of CPU
>> +available for the thread, and the counters for the noise sources.
>> +
>> +Usage
>> +-----
>> +
>> +Write the ASCII text ``osnoise`` into the ``current_tracer`` file of the
>> +tracing system (generally mounted at ``/sys/kernel/tracing`` or
>> +``/sys/kernel/debug/tracing``).
> 
> I wouldn't even mention the /sys/kernel/debug/tracing path, I'm trying to
> deprecated that.

I mention it because that is the path (still) used on Fedora...

>> +
>> +For example::
>> +
>> +        [root@f32 ~]# cd /sys/kernel/tracing/
>> +        [root@f32 tracing]# echo osnoise > current_tracer
>> +
>> +It is possible to follow the trace by reading the ``trace`` trace file::
>> +
>> +        [root@f32 tracing]# cat trace
>> +        # tracer: osnoise
>> +        #
>> +        #                                _-----=> irqs-off
>> +        #                               / _----=> need-resched
>> +        #                              | / _---=> hardirq/softirq
>> +        #                              || / _--=> preempt-depth                            MAX
>> +        #                              || /                                             SINGLE     Interference counters:
>> +        #                              ||||               RUNTIME      NOISE   % OF CPU  NOISE    +-----------------------------+
>> +        #           TASK-PID      CPU# ||||   TIMESTAMP    IN US       IN US  AVAILABLE  IN US     HW    NMI    IRQ   SIRQ THREAD
>> +        #              | |         |   ||||      |           |             |    |            |      |      |      |      |      |
>> +                   <...>-859     [000] ....    81.637220: 1000000        190  99.98100       9     18      0   1007     18      1
>> +                   <...>-860     [001] ....    81.638154: 1000000        656  99.93440      74     23      0   1006     16      3
>> +                   <...>-861     [002] ....    81.638193: 1000000       5675  99.43250     202      6      0   1013     25     21
>> +                   <...>-862     [003] ....    81.638242: 1000000        125  99.98750      45      1      0   1011     23      0
>> +                   <...>-863     [004] ....    81.638260: 1000000       1721  99.82790     168      7      0   1002     49     41
>> +                   <...>-864     [005] ....    81.638286: 1000000        263  99.97370      57      6      0   1006     26      2
>> +                   <...>-865     [006] ....    81.638302: 1000000        109  99.98910      21      3      0   1006     18      1
>> +                   <...>-866     [007] ....    81.638326: 1000000       7816  99.21840     107      8      0   1016     39     19
>> +
>> +In addition to the regular trace fields (from TASK-PID to TIMESTAMP), the
>> +tracer prints a message at the end of each period for each CPU that is
>> +running an ``osnoise/`` thread. The osnoise specific fields report:
>> +
>> + - The ``RUNTIME IN USE`` reports the amount of time in microseconds that
>> +   the ``osnoise`` thread kept looping reading the time.
>> + - The ``NOISE IN US`` reports the sum of noise in microseconds observed
>> +   by the osnoise tracer during the associated runtime.
>> + - The ``% OF CPU AVAILABLE`` reports the percentage of CPU available for
>> +   the ``osnoise`` thread during the ``runtime`` window.
>> + - The ``MAX SINGLE NOISE IN US`` reports the maximum single noise observed
>> +   during the ``runtime`` window.
>> + - The ``Interference counters`` display how many each of the respective
>> +   interference happened during the ``runtime`` window.
>> +
>> +Note that the example above shows a high number of ``HW noise`` samples.
>> +The reason being is that this sample was taken on a virtual machine,
>> +and the host interference is detected as a hardware interference.
>> +
>> +Tracer options
>> +---------------------
>> +
>> +The tracer has a set of options inside the ``osnoise`` directory, they are:
>> +
>> + - ``cpus``: CPUs at which a ``osnoise`` thread will execute.
>> + - ``period_us``: the period of the ``osnoise`` thread.
>> + - ``runtime_us``: how long an ``osnoise`` thread will look for noise.
>> + - ``stop_tracing_single_us``: stop the system tracing of a single noise
>> +   higher than the configured value is happens. Writing ``0`` disables this
>> +   option.
>> + - ``stop_tracing_total_us``: stop the system tracing of a ``NOISE IN USE``
>> +   higher than the configured value is happens. Writing ``0`` disables this
>> +   option.
>> + - ``tolerance_ns``: the minimum delta between two time() reads to be
>> +   considered as noise.
>> +
>> +Additional Tracing
>> +------------------
>> +
>> +In addition to the tracer, a set of ``tracepoints`` were added to
>> +facilitate the identification of the osnoise source.
>> +
>> + - ``osnoise:sample_threshold``: printed anytime a noise is higher than
>> +   the configurable ``tolerance_ns``.
>> + - ``osnoise:nmi_noise``: noise from NMI, including the duration.
>> + - ``osnoise:irq_noise``: noise from an IRQ, including the duration.
>> + - ``osnoise:softirq_noise``: noise from a SoftIRQ, including the
>> +   duration.
>> + - ``osnoise:thread_noise``: noise from a thread, including the duration.
>> +
>> +Note that a all the values are *net values*. This means that a *thread*
> 
>    "a all"?

Oops, I will fix that.

>> +duration will not contain the duration of the *IRQs* that happened during
>> +its execution, for example. The same is valid for all duration values.
> 
> The above is hard to understand. Do you mean individual instances of noise
> is not recorded, and only the sum is?

I need to rephrase that.... I meant that when we have two or more "noise"
stacked, e.g., a thread noise happening, and then an IRQ noise happens on top of
it, the noise from the TOP will be discounted, e.g., the IRQ noise added to the
thread noise will be discounted. Like...

osnoise_running
	--------> thread noise in
                       run 5 us
                  ----------------> IRQ noise
                                    run 3 us
		  <---------------- print duration 3 us
                       run 1 us
        <--------- print duration 6 us (not 9 us).

Making this computation in kernel reduces the amount of events printed in the
buffer.

>> +
>> +Here is one example of the usage of these ``tracepoints``::
>> +
>> +       osnoise/8-961     [008] d.h.  5789.857532: irq_noise: local_timer:236 start 5789.857529929 duration 1845 ns
>> +       osnoise/8-961     [008] dNh.  5789.858408: irq_noise: local_timer:236 start 5789.858404871 duration 2848 ns
>> +     migration/8-54      [008] d...  5789.858413: thread_noise: migration/8:54 start 5789.858409300 duration 3068 ns
>> +       osnoise/8-961     [008] ....  5789.858413: sample_threshold: start 5789.858404555 duration 8 us interferences 2
>> +
>> +In this example, a noise sample of 8 microseconds was reported in the last
>> +fine, pointing to two interferences. Looking backward in the trace, the
> 
>   "fine"?

Ops, "line" :-). Will fix.

>> +two previous entries were about the ``migration`` thread running after
>> +a timer IRQ execution. The first event is not part of the noise because
>> +it took place one millisecond before.
>> +
>> +It is worth noticing that the sum of the duration reported in the
>> +``tracepoints`` is smaller than eight us reported in the
>> +``sample_threshold``. The reason roots in the tracing overhead and in
>> +the overhead of the entry and exit code that happens before and after
>> +any interference execution. This justifies the dual approach: measuring
>> +thread and tracing.
>> diff --git a/include/linux/ftrace_irq.h b/include/linux/ftrace_irq.h
>> index 0abd9a1d2852..fd54045980ce 100644
>> --- a/include/linux/ftrace_irq.h
>> +++ b/include/linux/ftrace_irq.h
>> @@ -7,12 +7,24 @@ extern bool trace_hwlat_callback_enabled;
>>  extern void trace_hwlat_callback(bool enter);
>>  #endif
>>  
>> +/*
>> + * XXX: Make it generic
> 
> Yes, this should be the same for both the hwlat detector and for
> osnoise.

Where should I place it? On hwlat, making osnoise to select it? On trace.c?

>> + */
>> +#ifdef CONFIG_OSNOISE_TRACER
>> +extern bool trace_osnoise_callback_enabled;
>> +extern void trace_osnoise_callback(bool enter);
>> +#endif
>> +
>>  static inline void ftrace_nmi_enter(void)
>>  {
>>  #ifdef CONFIG_HWLAT_TRACER
>>  	if (trace_hwlat_callback_enabled)
>>  		trace_hwlat_callback(true);
>>  #endif
>> +#ifdef CONFIG_OSNOISE_TRACER
>> +	if (trace_osnoise_callback_enabled)
>> +		trace_osnoise_callback(true);
>> +#endif
>>  }
>>  
>>  static inline void ftrace_nmi_exit(void)
>> @@ -21,6 +33,10 @@ static inline void ftrace_nmi_exit(void)
>>  	if (trace_hwlat_callback_enabled)
>>  		trace_hwlat_callback(false);
>>  #endif
>> +#ifdef CONFIG_OSNOISE_TRACER
>> +	if (trace_osnoise_callback_enabled)
>> +		trace_osnoise_callback(false);
>> +#endif
>>  }
>>  
>>  #endif /* _LINUX_FTRACE_IRQ_H */
>> diff --git a/include/trace/events/osnoise.h b/include/trace/events/osnoise.h
>> new file mode 100644
>> index 000000000000..81939234814b
>> --- /dev/null
>> +++ b/include/trace/events/osnoise.h
>> @@ -0,0 +1,141 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#undef TRACE_SYSTEM
>> +#define TRACE_SYSTEM osnoise
>> +
>> +#if !defined(_OSNOISE_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
>> +#define _OSNOISE_TRACE_H
>> +
>> +#include <linux/tracepoint.h>
>> +TRACE_EVENT(thread_noise,
>> +
>> +	TP_PROTO(struct task_struct *t, u64 start, u64 duration),
>> +
>> +	TP_ARGS(t, start, duration),
>> +
>> +	TP_STRUCT__entry(
>> +		__array(	char,		comm,	TASK_COMM_LEN)
>> +		__field(	pid_t,		pid	)
> 
> I would place the start and duration first. As pid is 4 bytes, you have a 4
> byte "hole" in the structure:
> 
> system: osnoise
> name: thread_noise
> ID: 442
> format:
> 	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
> 	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
> 	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
> 	field:int common_pid;	offset:4;	size:4;	signed:1;
> 
> 	field:char comm[16];	offset:8;	size:16;	signed:1;
> 	field:pid_t pid;	offset:24;	size:4;	signed:1;
> 
> [ 4 bytes of nothing here ]
> 
> 	field:u64 start;	offset:32;	size:8;	signed:0;
> 	field:u64 duration;	offset:40;	size:8;	signed:0;
> 

Ack, will fix that.

>> +		__field(	u64,		start	)
>> +		__field(	u64,		duration)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		memcpy(__entry->comm, t->comm, TASK_COMM_LEN);
>> +		__entry->pid = t->pid;
>> +		__entry->start = start;
>> +		__entry->duration = duration;
>> +	),
>> +
>> +	TP_printk("%8s:%d start %llu.%09u duration %llu ns",
>> +		__entry->comm,
>> +		__entry->pid,
>> +		__print_ns_to_secs(__entry->start),
>> +		__print_ns_without_secs(__entry->start),
>> +		__entry->duration)
>> +);
>> +
>> +TRACE_EVENT(softirq_noise,
>> +
>> +	TP_PROTO(int vector, u64 start, u64 duration),
>> +
>> +	TP_ARGS(vector, start, duration),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(	int,		vector	)
>> +		__field(	u64,		start	)
>> +		__field(	u64,		duration)
> 
> Same here.
> 
> name: softirq_noise
> ID: 441
> format:
> 	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
> 	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
> 	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
> 	field:int common_pid;	offset:4;	size:4;	signed:1;
> 
> 	field:int vector;	offset:8;	size:4;	signed:1;
> 
> [ 4 bytes of nothing here]
> 
> 	field:u64 start;	offset:16;	size:8;	signed:0;
> 	field:u64 duration;	offset:24;	size:8;	signed:0;

ack!

>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->vector = vector;
>> +		__entry->start = start;
>> +		__entry->duration = duration;
>> +	),
>> +
>> +	TP_printk("%8s:%d start %llu.%09u duration %llu ns",
>> +		show_softirq_name(__entry->vector),
>> +		__entry->vector,
>> +		__print_ns_to_secs(__entry->start),
>> +		__print_ns_without_secs(__entry->start),
>> +		__entry->duration)
>> +);
>> +
>> +TRACE_EVENT(irq_noise,
>> +
>> +	TP_PROTO(int vector, const char *desc, u64 start, u64 duration),
>> +
>> +	TP_ARGS(vector, desc, start, duration),
>> +
>> +	TP_STRUCT__entry(
>> +		__string(	desc,		desc    )
>> +		__field(	int,		vector	)
> 
> This doesn't have a hole, but I think it should still switch to be
> consistent.

Ack!

> 
>> +		__field(	u64,		start	)
>> +		__field(	u64,		duration)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__assign_str(desc, desc);
>> +		__entry->vector = vector;
>> +		__entry->start = start;
>> +		__entry->duration = duration;
>> +	),
>> +
>> +	TP_printk("%s:%d start %llu.%09u duration %llu ns",
>> +		__get_str(desc),
>> +		__entry->vector,
>> +		__print_ns_to_secs(__entry->start),
>> +		__print_ns_without_secs(__entry->start),
>> +		__entry->duration)
>> +);
>> +
>> +TRACE_EVENT(nmi_noise,
>> +
>> +	TP_PROTO(u64 start, u64 duration),
>> +
>> +	TP_ARGS(start, duration),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(	u64,		start	)
>> +		__field(	u64,		duration)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->start = start;
>> +		__entry->duration = duration;
>> +	),
>> +
>> +	TP_printk("start %llu.%09u duration %llu ns",
>> +		__print_ns_to_secs(__entry->start),
>> +		__print_ns_without_secs(__entry->start),
>> +		__entry->duration)
>> +);
>> +
>> +TRACE_EVENT(sample_threshold,
>> +
>> +	TP_PROTO(u64 start, u64 duration, u64 interference),
>> +
>> +	TP_ARGS(start, duration, interference),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(	u64,		start	)
>> +		__field(	u64,		duration)
>> +		__field(	u64,		interference)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->start = start;
>> +		__entry->duration = duration;
>> +		__entry->interference = interference;
>> +	),
>> +
>> +	TP_printk("start %llu.%09u duration %llu us interferences %llu",
>> +		__print_ns_to_secs(__entry->start),
>> +		__print_ns_without_secs(__entry->start),
>> +		__entry->duration,
>> +		__entry->interference)
>> +);
>> +
>> +#endif /* _TRACE_OSNOISE_H */
>> +
> 
> 
> [..]
> 
>> +static void osnoise_tracer_start(struct trace_array *tr)
>> +{
>> +	int retval;
>> +
>> +	/* Only allow one instance to enable this */
>> +	if (osnoise_busy)
>> +		return;
> 
> I found that I couldn't start this with:
> 
> 	trace-cmd start -B foo -p osnoise

ok, I will debug that.

>> +
>> +	/*
>> +	 * Trace is already hooked, we are re-enabling from
>> +	 * a stop_tracing_*.
>> +	 */
>> +	if (trace_osnoise_callback_enabled)
>> +		return;
>> +
>> +	osn_var_reset_all();
>> +
>> +	retval = hook_irq_events();
>> +	if (retval)
>> +		goto err;
>> +
>> +	retval = hook_softirq_events();
>> +	if (retval)
>> +		goto out_unhook_irq;
>> +
>> +	retval = hook_thread_events();
>> +
>> +	if (retval)
>> +		goto out_unrook_softirq;
>> +
>> +	/*
>> +	 * Make sure NMIs see reseted values.
>> +	 */
>> +	barrier();
>> +	trace_osnoise_callback_enabled = true;
>> +
>> +	retval = start_per_cpu_kthreads(tr);
>> +	/*
>> +	 * all fine!
>> +	 */
>> +	if (!retval)
>> +		return;
>> +
>> +	unhook_thread_events();
>> +out_unrook_softirq:
>> +	unhook_softirq_events();
>> +out_unhook_irq:
>> +	unhook_irq_events();
>> +err:
>> +	pr_err(BANNER "Error starting osnoise tracer\n");
>> +}
>> +
>> +static void osnoise_tracer_stop(struct trace_array *tr)
>> +{
>> +	/* Only allow one instance to enable this */
>> +	if (!osnoise_busy)
>> +		return;
>> +
>> +	trace_osnoise_callback_enabled = false;
>> +	barrier();
>> +
>> +	stop_per_cpu_kthreads();
>> +
>> +	unhook_irq_events();
>> +	unhook_softirq_events();
>> +	unhook_thread_events();
>> +}
>> +
>> +static int osnoise_tracer_init(struct trace_array *tr)
>> +{
>> +	/* Only allow one instance to enable this */
>> +	if (osnoise_busy)
>> +		return -EBUSY;
>> +
>> +	osnoise_trace = tr;
>> +
>> +	tr->max_latency = 0;
>> +
>> +	if (tracer_tracing_is_on(tr))
>> +		osnoise_tracer_start(tr);
> 
> That's because trace-cmd will disable tracing when it enables a tracer. And
> the above "osnoise_trace_start() is not called.
> 
>> +
>> +	osnoise_busy = true;
> 
> Once this is set, when we enable tracing, the start wont start.

Ok, I will try to understand this better.

Thanks
-- Daniel

> -- Steve
> 
> 
>> +
>> +
>> +	return 0;
>> +}
>> +
>> +static void osnoise_tracer_reset(struct trace_array *tr)
>> +{
>> +	osnoise_tracer_stop(tr);
>> +
>> +	osnoise_busy = false;
>> +}
>> +
>> +static struct tracer osnoise_tracer __read_mostly = {
>> +	.name		= "osnoise",
>> +	.init		= osnoise_tracer_init,
>> +	.reset		= osnoise_tracer_reset,
>> +	.start		= osnoise_tracer_start,
>> +	.stop		= osnoise_tracer_stop,
>> +	.print_header	= print_osnoise_headers,
>> +	.allow_instances = true,
>> +};
>> +
>> +__init static int init_osnoise_tracer(void)
>> +{
>> +	int ret;
>> +
>> +	mutex_init(&osnoise_data.lock);
>> +
>> +	ret = register_tracer(&osnoise_tracer);
>> +	if (ret)
>> +		return ret;
>> +
>> +	cpumask_copy(&osnoise_cpumask, cpu_all_mask);
>> +
>> +	init_tracefs();
>> +
>> +	return 0;
>> +}
>> +late_initcall(init_osnoise_tracer);
>> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
>> index 61255bad7e01..edeb127fcdea 100644
>> --- a/kernel/trace/trace_output.c
>> +++ b/kernel/trace/trace_output.c
>> @@ -1189,7 +1189,6 @@ trace_hwlat_print(struct trace_iterator *iter, int flags,
>>  	return trace_handle_return(s);
>>  }
>>  
>> -
>>  static enum print_line_t
>>  trace_hwlat_raw(struct trace_iterator *iter, int flags,
>>  		struct trace_event *event)
>> @@ -1219,6 +1218,76 @@ static struct trace_event trace_hwlat_event = {
>>  	.funcs		= &trace_hwlat_funcs,
>>  };
>>  
>> +/* TRACE_OSNOISE */
>> +static enum print_line_t
>> +trace_osnoise_print(struct trace_iterator *iter, int flags,
>> +		    struct trace_event *event)
>> +{
>> +	struct trace_entry *entry = iter->ent;
>> +	struct trace_seq *s = &iter->seq;
>> +	struct osnoise_entry *field;
>> +	u64 ratio, ratio_dec;
>> +	u64 net_runtime;
>> +
>> +	trace_assign_type(field, entry);
>> +
>> +	/*
>> +	 * compute the available % of cpu time.
>> +	 */
>> +	net_runtime = field->runtime - field->noise;
>> +	ratio = net_runtime * 10000000;
>> +	do_div(ratio, field->runtime);
>> +	ratio_dec = do_div(ratio, 100000);
>> +
>> +	trace_seq_printf(s, "%llu %10llu %3llu.%05llu %7llu",
>> +			 field->runtime,
>> +			 field->noise,
>> +			 ratio, ratio_dec,
>> +			 field->max_sample);
>> +
>> +	trace_seq_printf(s, " %6u", field->hw_count);
>> +	trace_seq_printf(s, " %6u", field->nmi_count);
>> +	trace_seq_printf(s, " %6u", field->irq_count);
>> +	trace_seq_printf(s, " %6u", field->softirq_count);
>> +	trace_seq_printf(s, " %6u", field->thread_count);
>> +
>> +	trace_seq_putc(s, '\n');
>> +
>> +	return trace_handle_return(s);
>> +}
>> +
>> +static enum print_line_t
>> +trace_osnoise_raw(struct trace_iterator *iter, int flags,
>> +		  struct trace_event *event)
>> +{
>> +	struct osnoise_entry *field;
>> +	struct trace_seq *s = &iter->seq;
>> +
>> +	trace_assign_type(field, iter->ent);
>> +
>> +	trace_seq_printf(s, "%lld %llu %llu %u %u %u %u %u\n",
>> +			 field->runtime,
>> +			 field->noise,
>> +			 field->max_sample,
>> +			 field->hw_count,
>> +			 field->nmi_count,
>> +			 field->irq_count,
>> +			 field->softirq_count,
>> +			 field->thread_count);
>> +
>> +	return trace_handle_return(s);
>> +}
>> +
>> +static struct trace_event_functions trace_osnoise_funcs = {
>> +	.trace		= trace_osnoise_print,
>> +	.raw		= trace_osnoise_raw,
>> +};
>> +
>> +static struct trace_event trace_osnoise_event = {
>> +	.type		= TRACE_OSNOISE,
>> +	.funcs		= &trace_osnoise_funcs,
>> +};
>> +
>>  /* TRACE_BPUTS */
>>  static enum print_line_t
>>  trace_bputs_print(struct trace_iterator *iter, int flags,
>> @@ -1384,6 +1453,7 @@ static struct trace_event *events[] __initdata = {
>>  	&trace_bprint_event,
>>  	&trace_print_event,
>>  	&trace_hwlat_event,
>> +	&trace_osnoise_event,
>>  	&trace_raw_data_event,
>>  	NULL
>>  };
> 
> 	
> 

