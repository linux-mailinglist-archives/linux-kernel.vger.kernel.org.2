Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE26F3B0674
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 16:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhFVOH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 10:07:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55685 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230047AbhFVOHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 10:07:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624370738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A9E+vsSKUiBkxTr1D+uJlyypPItp96yXy0sKlCKPEa0=;
        b=NOlpG15UxQTFFqEMxbSDGnwZNXKLx+3FteI5dTjKInyFdIaGMzRoy/qDqaMMCufGX5MRM8
        4w+pOzNEvuoArBu+GGBB7QuBi9Z2748/i7jLtudqCEMv7djDyyqxaczOe7Vy8V1Oc37JP6
        +GymB8QtTEhO+HYhcKWvQ8yIVO9SLlI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-DFCB4wHpOKmSw84wTrx_Bw-1; Tue, 22 Jun 2021 10:05:36 -0400
X-MC-Unique: DFCB4wHpOKmSw84wTrx_Bw-1
Received: by mail-ed1-f70.google.com with SMTP id v8-20020a0564023488b0290393873961f6so9562413edc.17
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 07:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A9E+vsSKUiBkxTr1D+uJlyypPItp96yXy0sKlCKPEa0=;
        b=Q4FwwBf93huyI7Mzwa+b55sif8oGV6enSzS/UbPko4nz7pvKLISM5YJ1JB2yqdSO51
         jnITv9b8xMlHZvDKpnGKmA9P+ZE9ohY79KBNmSdWElymtuDUPMj5SVsyq9hJ2+HgJQYI
         skHuDkrAFc9AQnw/blLYnKeOiCj19u7VFAnmOke1jlrzhYhc/FfVnUaej4DmoLkHSdJO
         jNWjWyPrb4MhVfwnjmXK33H+iFRP28o3Iqgo/Ysgs2taKGD8Re4te7qSUDvKtggPmNXL
         smxrl2SmmJ7MJq9kq2zH63sHipPtt2BySORWAgdd8yjREgZa7G4weTieI+jz6BRYM91z
         jCtQ==
X-Gm-Message-State: AOAM530HlzkRNSYBc4tL5osznbEKcHnT2XTMWa7AWJvvQZxqnbwu1NbQ
        CEzPpNf61ngCBsLstYNYeG+TIE+zNUM+j5Tp+/gkPE4CLUHYjLuLMd4IEzBrAbM5Oj+qk8fiUJk
        ne9xUmdVOKSGj+Bz228J6444rEuU4XGmdii8KXMO1TrwTulZsFGN0c1hZNGeHUdxQusXSalJaXU
        A=
X-Received: by 2002:a17:906:2582:: with SMTP id m2mr4215010ejb.97.1624370735492;
        Tue, 22 Jun 2021 07:05:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkC2qANxWLcUoq39lcwtN75LGTPi5baLS4o1GkVYY31xfJ5DuFEvm6C5WB4QNQXlOmEP7l2w==
X-Received: by 2002:a17:906:2582:: with SMTP id m2mr4214967ejb.97.1624370735181;
        Tue, 22 Jun 2021 07:05:35 -0700 (PDT)
Received: from x1.bristot.me (host-79-23-205-114.retail.telecomitalia.it. [79.23.205.114])
        by smtp.gmail.com with ESMTPSA id jl21sm4452192ejc.42.2021.06.22.07.05.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 07:05:34 -0700 (PDT)
Subject: Re: [PATCH V4 05/12] trace/hwlat: Support hotplug operations
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Phil Auld <pauld@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kate Carcia <kcarcia@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1623746916.git.bristot@redhat.com>
 <8899f8a8bec38bc600f7a2c61bc6ca664aa7beeb.1623746916.git.bristot@redhat.com>
 <20210618124503.388fe4d4@oasis.local.home>
 <20210618150020.689439d4@oasis.local.home>
 <c4b86b0e-b45d-3039-f49c-0dc53e1adcbd@redhat.com>
 <20210621112528.12aee665@oasis.local.home>
 <c87c24bd-253c-a645-1f29-83c558d8d4c5@redhat.com>
 <20210621134636.5b332226@oasis.local.home>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <77575407-0332-8734-2697-bc2099fd9fe0@redhat.com>
Date:   Tue, 22 Jun 2021 16:05:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210621134636.5b332226@oasis.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/21 7:46 PM, Steven Rostedt wrote:
> On Mon, 21 Jun 2021 18:14:36 +0200
> Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> 
>>>> Yep! I tried to take the trace_type_lock here, and got the lockdep info about
>>>> this problem.
>>>>  
>>>>> The only thing I could think of is to wake up a worker thread to do the
>>>>> work. That is, this just wakes the worker thread, then the worker grabs
>>>>> the trace_types_lock, iterates through the cpu mask of expect running
>>>>> threads, and then starts or kills them depending on the hwlat_busy
>>>>> value.    
>>>> So, it will not wait for the kworker to run?  
>>> What wont wait?  
>>
>> For example, at the shutdown, should the hotplug callback wait for the workqueue
>> to run & kill the thread, or not?
> 
> Doing that won't help the deadlock situation.

yep, that is why I asked... :-(

> 	CPU 1			CPU 2
> 	-----			-----
>     Start shutdown
>     down online_cpus()
> 
> 			   mutex_lock(trace_types_lock);
> 			   get_online_cpus()
> 			   [BLOCK]
> 
>     wake_up_thread;
>     [schedule worker]
> 
>     mutex_lock(trace_types_lock);
> 
>  [ DEADLOCK ]
> 
> 
> Make all access to save_cpumask and hwlat_per_cpu_data inside the
> get_online_cpus() protection. (like in move_to_next_cpu(),
> start_single_thread() expand the get_online_cpus()).
> 
> Then in the cpu going down case, we can simply kill the thread and
> update the save_cpumask, as it will be protected by the
> get_online_cpus() code.
> 
> That is, don't even check if hwlat_busy is set or not. Just simply do:
> 
> 
> CPU_DOWN:
> 
> 	stop_cpu_kthead(cpu);
> 
> That will stop the kthread if it is running.  But we should update
> that function to also set per_cpu(hwlat_per_cpu_data).kthread = NULL;
> Like stop_single_kthread() does.
> 
> But for CPU_UP, we should do the work via a worker thread.
> 
> CPU_UP:
> 	schedule_work_on(&update_kthreads, cpu);
> 
> Which in the work function for that update_kthreads work queue:
> 
> 	mutex_lock(&trace_types_lock);
> 	if (!hwlat_busy || hwlat_data.thread_mode != MODE_PER_CPU)
> 		goto out_unlock;
> 
> 	get_online_cpus();
> 	if (!this_cpu(hwlat_per_cpu_data).kthread)
> 		start_per_cpu_kthread(smp_processor_id());
> 	put_online_cpus();
> 
>  out_unlock:
> 	mutex_unlock(&trace_types_lock);
> 
> Or something like that.

It works!

I will send a v5 with all the fixes requested, including this one.

Thanks Steven!
-- Daniel

