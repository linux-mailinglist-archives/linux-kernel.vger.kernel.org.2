Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE1A360A6F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 15:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbhDONXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 09:23:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59733 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233092AbhDONXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 09:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618492977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pGV51z/usrS1hQ4D2fvkw4t5pvqiVsDoLlcb6+T8FmE=;
        b=TzwPGBulwZbPHzde8JuZHdx2MRLNjn8StMzFiHG27L2kgGdGNOayWWpytincwEHwFSaSoq
        u+geoj4Bv8Rju0x+w+jKXXB3IUWzkoDTAMNwEh1DSASNdnuE76Nc787qoO1yBLhop0shz0
        a8y62aigU+ii8oHFa68PbbqvO3ln3LA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-2nsn58eRM8mvuwm2FCKQfA-1; Thu, 15 Apr 2021 09:22:55 -0400
X-MC-Unique: 2nsn58eRM8mvuwm2FCKQfA-1
Received: by mail-ed1-f70.google.com with SMTP id d27-20020a50f69b0000b02903827b61b783so5215475edn.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 06:22:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pGV51z/usrS1hQ4D2fvkw4t5pvqiVsDoLlcb6+T8FmE=;
        b=MbyZeH/Cl9pVFaoTsilfGdKQ897+l0LhUotwRU4dYlIOvkJHGfCPoblqliZrR4aTYT
         vxVP0s9MRuAmaGn7Ya2zRU+WyltdaqR4YK3/toJeZkEZOD5h1qDFgRYBqz87diU5F7iA
         ONInkxFZoHx4ebs2EBNcTk9iuH8fl9yxq6WOimWChxRQKgyLSBDTt3AQskiI6SuoIZu7
         bwSwVB5vf41dssaJHQDHL/q6LaV14OiCUSd9D2+cD9LNf3qBxjF5h7GH/xv0gz6uEinE
         AauSxD7RglT7lx8yxLDv3E8y96y26vB2k7NdwAkmNtiQuYtwGEENQjIgUnnZb53yTtT3
         kQww==
X-Gm-Message-State: AOAM530ymblbaGh6toALw4oeAp4JmnlC0CgAfiRSmWC/QG2kWAonlGoU
        9c6wcz8e4FlupJuJakBot+r1+3LXoDEdKQmCb1YyA7rVVjeRJWaNhNgKPMdHgHyc2/JKlmhXrc+
        y2uaovnFdCZZu4ycg9UCSbstP
X-Received: by 2002:a17:906:c9d8:: with SMTP id hk24mr3460565ejb.480.1618492974001;
        Thu, 15 Apr 2021 06:22:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAL5WmKiee4K1Rey26vkRplVgrgGt4D2DFy+mWeFf8XGvsxY+pfdobIz8/jHYwKuBtBeDwdg==
X-Received: by 2002:a17:906:c9d8:: with SMTP id hk24mr3460550ejb.480.1618492973777;
        Thu, 15 Apr 2021 06:22:53 -0700 (PDT)
Received: from x1.bristot.me (host-79-56-201-31.retail.telecomitalia.it. [79.56.201.31])
        by smtp.gmail.com with ESMTPSA id o20sm2531764eds.65.2021.04.15.06.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 06:22:53 -0700 (PDT)
Subject: Re: [RFC PATCH 3/5] tracing/hwlat: Implement the per-cpu mode
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
 <1c99ca2d7403474508aa7b025869c0673238400a.1617889883.git.bristot@redhat.com>
 <20210414104102.7589626c@gandalf.local.home>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <bce142fc-4b1d-9924-e0d7-c02b0bd38405@redhat.com>
Date:   Thu, 15 Apr 2021 15:22:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210414104102.7589626c@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/21 4:41 PM, Steven Rostedt wrote:
> On Thu,  8 Apr 2021 16:13:21 +0200
> Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> 
>> Implements the per-cpu mode in which a sampling thread is created for
>> each cpu in the "cpus" (and tracing_mask).
>>
>> The per-cpu mode has the potention to speed up the hwlat detection by
>> running on multiple CPUs at the same time.
> 
> And totally slow down the entire system in the process ;-)

Too :-) But this is not the default config... So it should be an intentional change.

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
>>  Documentation/trace/hwlat_detector.rst |   6 +-
>>  kernel/trace/trace_hwlat.c             | 171 +++++++++++++++++++------
>>  2 files changed, 137 insertions(+), 40 deletions(-)
>>
>> diff --git a/Documentation/trace/hwlat_detector.rst b/Documentation/trace/hwlat_detector.rst
>> index f63fdd867598..7a6fab105b29 100644
>> --- a/Documentation/trace/hwlat_detector.rst
>> +++ b/Documentation/trace/hwlat_detector.rst
>> @@ -85,10 +85,12 @@ the available options are:
>>  
>>   - none:        do not force migration
>>   - round-robin: migrate across each CPU specified in cpus between each window
>> + - per-cpu:     create a per-cpu thread for each cpu in cpus
>>  
>>  By default, hwlat detector will also obey the tracing_cpumask, so the thread
>>  will be placed only in the set of cpus that is both on the hwlat detector's
>>  cpus and in the global tracing_cpumask file. The user can overwrite the
>>  cpumask by setting it manually. Changing the hwlatd affinity externally,
>> -e.g., via taskset tool, will disable the round-robin migration.
>> -
>> +e.g., via taskset tool, will disable the round-robin migration. In the
>> +per-cpu mode, the per-cpu thread (hwlatd/CPU) will be pinned to its relative
>> +cpu, and its affinity cannot be changed.
>> diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
>> index 3818200c9e24..52968ea312df 100644
>> --- a/kernel/trace/trace_hwlat.c
>> +++ b/kernel/trace/trace_hwlat.c
>> @@ -34,7 +34,7 @@
>>   * Copyright (C) 2008-2009 Jon Masters, Red Hat, Inc. <jcm@redhat.com>
>>   * Copyright (C) 2013-2016 Steven Rostedt, Red Hat, Inc. <srostedt@redhat.com>
>>   *
>> - * Includes useful feedback from Clark Williams <clark@redhat.com>
>> + * Includes useful feedback from Clark Williams <williams@redhat.com>
> 
> Interesting update ;-)

Should I make it a separated patch? :-)

>>   *
>>   */
>>  #include <linux/kthread.h>
>> @@ -54,9 +54,6 @@ static struct trace_array	*hwlat_trace;
>>  #define DEFAULT_SAMPLE_WIDTH	500000			/* 0.5s */
>>  #define DEFAULT_LAT_THRESHOLD	10			/* 10us */
>>  
>> -/* sampling thread*/
>> -static struct task_struct *hwlat_kthread;
>> -
>>  static struct dentry *hwlat_sample_width;	/* sample width us */
>>  static struct dentry *hwlat_sample_window;	/* sample window us */
>>  static struct dentry *hwlat_cpumask_dentry;	/* hwlat cpus allowed */
>> @@ -65,19 +62,27 @@ static struct dentry *hwlat_thread_mode;	/* hwlat thread mode */
>>  enum {
>>  	MODE_NONE = 0,
>>  	MODE_ROUND_ROBIN,
>> +	MODE_PER_CPU,
>>  	MODE_MAX
>>  };
>>  
>> -static char *thread_mode_str[] = { "none", "round-robin" };
>> +static char *thread_mode_str[] = { "none", "round-robin", "per-cpu" };
>>  
>>  /* Save the previous tracing_thresh value */
>>  static unsigned long save_tracing_thresh;
>>  
>> -/* NMI timestamp counters */
>> -static u64 nmi_ts_start;
>> -static u64 nmi_total_ts;
>> -static int nmi_count;
>> -static int nmi_cpu;
>> +/* runtime kthread data */
>> +struct hwlat_kthread_data {
>> +	struct task_struct *kthread;
>> +	/* NMI timestamp counters */
>> +	u64 nmi_ts_start;
>> +	u64 nmi_total_ts;
>> +	int nmi_count;
>> +	int nmi_cpu;
>> +};
>> +
>> +struct hwlat_kthread_data hwlat_single_cpu_data;
>> +DEFINE_PER_CPU(struct hwlat_kthread_data, hwlat_per_cpu_data);
>>  
>>  /* Tells NMIs to call back to the hwlat tracer to record timestamps */
>>  bool trace_hwlat_callback_enabled;
>> @@ -114,6 +119,14 @@ static struct hwlat_data {
>>  	.thread_mode		= MODE_ROUND_ROBIN
>>  };
>>  
>> +struct hwlat_kthread_data *get_cpu_data(void)
>> +{
>> +	if (hwlat_data.thread_mode == MODE_PER_CPU)
>> +		return this_cpu_ptr(&hwlat_per_cpu_data);
>> +	else
>> +		return &hwlat_single_cpu_data;
>> +}
>> +
>>  static bool hwlat_busy;
>>  
>>  static void trace_hwlat_sample(struct hwlat_sample *sample)
>> @@ -151,7 +164,9 @@ static void trace_hwlat_sample(struct hwlat_sample *sample)
>>  
>>  void trace_hwlat_callback(bool enter)
>>  {
>> -	if (smp_processor_id() != nmi_cpu)
>> +	struct hwlat_kthread_data *kdata = get_cpu_data();
>> +
>> +	if (kdata->kthread)
>>  		return;
>>  
>>  	/*
>> @@ -160,13 +175,13 @@ void trace_hwlat_callback(bool enter)
>>  	 */
>>  	if (!IS_ENABLED(CONFIG_GENERIC_SCHED_CLOCK)) {
>>  		if (enter)
>> -			nmi_ts_start = time_get();
>> +			kdata->nmi_ts_start = time_get();
>>  		else
>> -			nmi_total_ts += time_get() - nmi_ts_start;
>> +			kdata->nmi_total_ts += time_get() - kdata->nmi_ts_start;
>>  	}
>>  
>>  	if (enter)
>> -		nmi_count++;
>> +		kdata->nmi_count++;
>>  }
>>  
>>  /**
>> @@ -178,6 +193,7 @@ void trace_hwlat_callback(bool enter)
>>   */
>>  static int get_sample(void)
>>  {
>> +	struct hwlat_kthread_data *kdata = get_cpu_data();
>>  	struct trace_array *tr = hwlat_trace;
>>  	struct hwlat_sample s;
>>  	time_type start, t1, t2, last_t2;
>> @@ -190,9 +206,8 @@ static int get_sample(void)
>>  
>>  	do_div(thresh, NSEC_PER_USEC); /* modifies interval value */
>>  
>> -	nmi_cpu = smp_processor_id();
>> -	nmi_total_ts = 0;
>> -	nmi_count = 0;
>> +	kdata->nmi_total_ts = 0;
>> +	kdata->nmi_count = 0;
>>  	/* Make sure NMIs see this first */
>>  	barrier();
>>  
>> @@ -262,15 +277,15 @@ static int get_sample(void)
>>  		ret = 1;
>>  
>>  		/* We read in microseconds */
>> -		if (nmi_total_ts)
>> -			do_div(nmi_total_ts, NSEC_PER_USEC);
>> +		if (kdata->nmi_total_ts)
>> +			do_div(kdata->nmi_total_ts, NSEC_PER_USEC);
>>  
>>  		hwlat_data.count++;
>>  		s.seqnum = hwlat_data.count;
>>  		s.duration = sample;
>>  		s.outer_duration = outer_sample;
>> -		s.nmi_total_ts = nmi_total_ts;
>> -		s.nmi_count = nmi_count;
>> +		s.nmi_total_ts = kdata->nmi_total_ts;
>> +		s.nmi_count = kdata->nmi_count;
>>  		s.count = count;
>>  		trace_hwlat_sample(&s);
>>  
>> @@ -376,23 +391,43 @@ static int kthread_fn(void *data)
>>  }
>>  
>>  /**
>> - * start_kthread - Kick off the hardware latency sampling/detector kthread
>> + * stop_stop_kthread - Inform the hardware latency samping/detector kthread to stop
>> + *
>> + * This kicks the running hardware latency sampling/detector kernel thread and
>> + * tells it to stop sampling now. Use this on unload and at system shutdown.
>> + */
>> +static void stop_single_kthread(void)
>> +{
>> +	struct hwlat_kthread_data *kdata = get_cpu_data();
>> +	struct task_struct *kthread = kdata->kthread;
>> +
>> +	if (!kthread)
>> +
>> +		return;
>> +	kthread_stop(kthread);
>> +
>> +	kdata->kthread = NULL;
>> +}
>> +
>> +
>> +/**
>> + * start_single_kthread - Kick off the hardware latency sampling/detector kthread
>>   *
>>   * This starts the kernel thread that will sit and sample the CPU timestamp
>>   * counter (TSC or similar) and look for potential hardware latencies.
>>   */
>> -static int start_kthread(struct trace_array *tr)
>> +static int start_single_kthread(struct trace_array *tr)
>>  {
>> +	struct hwlat_kthread_data *kdata = get_cpu_data();
>>  	struct cpumask *current_mask = &save_cpumask;
>>  	struct task_struct *kthread;
>>  	int next_cpu;
>>  
>> -	if (hwlat_kthread)
>> +	if (kdata->kthread)
>>  		return 0;
>>  
>> -
>>  	kthread = kthread_create(kthread_fn, NULL, "hwlatd");
>> -	if (IS_ERR(kthread)) {
>> +	if (IS_ERR(kdata->kthread)) {
>>  		pr_err(BANNER "could not start sampling thread\n");
>>  		return -ENOMEM;
>>  	}
>> @@ -419,24 +454,77 @@ static int start_kthread(struct trace_array *tr)
>>  
>>  	sched_setaffinity(kthread->pid, current_mask);
>>  
>> -	hwlat_kthread = kthread;
>> +	kdata->kthread = kthread;
>>  	wake_up_process(kthread);
>>  
>>  	return 0;
>>  }
>>  
>>  /**
>> - * stop_kthread - Inform the hardware latency samping/detector kthread to stop
>> + * stop_per_cpu_kthread - Inform the hardware latency samping/detector kthread to stop
>>   *
>> - * This kicks the running hardware latency sampling/detector kernel thread and
>> + * This kicks the running hardware latency sampling/detector kernel threads and
>>   * tells it to stop sampling now. Use this on unload and at system shutdown.
>>   */
>> -static void stop_kthread(void)
>> +static void stop_per_cpu_kthreads(void)
>>  {
>> -	if (!hwlat_kthread)
>> -		return;
>> -	kthread_stop(hwlat_kthread);
>> -	hwlat_kthread = NULL;
>> +	struct task_struct *kthread;
>> +	int cpu;
>> +
>> +	for_each_online_cpu(cpu) {
>> +		kthread = per_cpu(hwlat_per_cpu_data, cpu).kthread;
>> +		if (kthread)
>> +			kthread_stop(kthread);
> 
> Probably want:
> 
> 		per_cpu(hwlat_per_cpu_data, cpu).kthread = NULL;
> 
> Just to be safe. I don't like to rely on the start doing the job, as things
> can change in the future. Having the clearing here as well makes the code
> more robust.

Ack!

> 
>> +	}
>> +}
>> +
>> +/**
>> + * start_per_cpu_kthread - Kick off the hardware latency sampling/detector kthreads
>> + *
>> + * This starts the kernel threads that will sit on potentially all cpus and
>> + * sample the CPU timestamp counter (TSC or similar) and look for potential
>> + * hardware latencies.
>> + */
>> +static int start_per_cpu_kthreads(struct trace_array *tr)
>> +{
>> +	struct cpumask *current_mask = &save_cpumask;
>> +	struct cpumask *this_cpumask;
>> +	struct task_struct *kthread;
>> +	char comm[24];
>> +	int cpu;
>> +
>> +	if (!alloc_cpumask_var(&this_cpumask, GFP_KERNEL))
>> +		return -ENOMEM;
>> +
>> +	get_online_cpus();
>> +	/*
>> +	 * Run only on CPUs in which trace and hwlat are allowed to run.
>> +	 */
>> +	cpumask_and(current_mask, tr->tracing_cpumask, &hwlat_cpumask);
>> +	/*
>> +	 * And the CPU is online.
>> +	 */
>> +	cpumask_and(current_mask, cpu_online_mask, current_mask);
>> +	put_online_cpus();
>> +
>> +	for_each_online_cpu(cpu)
>> +		per_cpu(hwlat_per_cpu_data, cpu).kthread = NULL;
>> +
>> +	for_each_cpu(cpu, current_mask) {
>> +		snprintf(comm, 24, "hwlatd/%d", cpu);
>> +
>> +		kthread = kthread_create_on_cpu(kthread_fn, NULL, cpu, comm);
>> +		if (IS_ERR(kthread)) {
>> +			pr_err(BANNER "could not start sampling thread\n");
>> +			stop_per_cpu_kthreads();
>> +			return -ENOMEM;
>> +		}
>> +
>> +		per_cpu(hwlat_per_cpu_data, cpu).kthread = kthread;
>> +		wake_up_process(kthread);
>> +	}
>> +
>> +	return 0;
>>  }
>>  
>>  /*
>> @@ -701,7 +789,8 @@ static int hwlat_mode_open(struct inode *inode, struct file *file)
>>   * The "none" sets the allowed cpumask for a single hwlatd thread at the
>>   * startup and lets the scheduler handle the migration. The default mode is
>>   * the "round-robin" one, in which a single hwlatd thread runs, migrating
>> - * among the allowed CPUs in a round-robin fashion.
>> + * among the allowed CPUs in a round-robin fashion. The "per-cpu" mode
>> + * creates one hwlatd thread per allowed CPU.
>>   */
>>  static ssize_t hwlat_mode_write(struct file *filp, const char __user *ubuf,
>>  				 size_t cnt, loff_t *ppos)
>> @@ -827,14 +916,20 @@ static void hwlat_tracer_start(struct trace_array *tr)
>>  {
>>  	int err;
>>  
>> -	err = start_kthread(tr);
>> +	if (hwlat_data.thread_mode == MODE_PER_CPU)
>> +		err = start_per_cpu_kthreads(tr);
>> +	else
>> +		err = start_single_kthread(tr);
>>  	if (err)
>>  		pr_err(BANNER "Cannot start hwlat kthread\n");
>>  }
>>  
>>  static void hwlat_tracer_stop(struct trace_array *tr)
>>  {
>> -	stop_kthread();
>> +	if (hwlat_data.thread_mode == MODE_PER_CPU)
>> +		stop_per_cpu_kthreads();
>> +	else
>> +		stop_single_kthread();
> 
> This explains why you have the "busy" check in the changing of the modes.
> But really, I don't see why you cant change the mode. Just stop the
> previous mode, and start the new one.

I will try it!

Thanks!
-- Daniel

> -- Steve
> 
> 
>>  }
>>  
>>  static int hwlat_tracer_init(struct trace_array *tr)
>> @@ -864,7 +959,7 @@ static int hwlat_tracer_init(struct trace_array *tr)
>>  
>>  static void hwlat_tracer_reset(struct trace_array *tr)
>>  {
>> -	stop_kthread();
>> +	hwlat_tracer_stop(tr);
>>  
>>  	/* the tracing threshold is static between runs */
>>  	last_tracing_thresh = tracing_thresh;
> 

