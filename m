Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F92E392DF1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 14:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbhE0Maw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 08:30:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59210 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234683AbhE0Mav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 08:30:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622118558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=blsvMXsnr00Di8AqsbMtP4oJ8EFY4Alf2SaL+RG/1hs=;
        b=LVjkl0PY9HGPZk7V4eJfAc1DH4nhfZPoh8LhLikYmN08+c+07LK+tD1uBy/lYOupZMeCSo
        xuSd2XAMFIfv9kQwI5G2cr4y+m9AorqRC7IDTStWI9wtcKXq7Nyd0RNCOzzOZGiBTLovU+
        FTU9SEtQkqFqvQll6YFCGeIr0+Ccifk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-LO7QkT5LM4m0XKd3_GpJ-w-1; Thu, 27 May 2021 08:29:16 -0400
X-MC-Unique: LO7QkT5LM4m0XKd3_GpJ-w-1
Received: by mail-ej1-f71.google.com with SMTP id w13-20020a170906384db02903d9ad6b26d8so1608434ejc.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 05:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=blsvMXsnr00Di8AqsbMtP4oJ8EFY4Alf2SaL+RG/1hs=;
        b=a8/6wrUNHOFKhQVHdKlJwz8KFe0M/hvkVcLAIb7rQ0jDmHNB3+jtFNI5Z0DoVNdYw5
         5LSyI31Iz5NLm0sStqwbJh2NOIdyZH2v7jSGJ6SP0CVsGLZzujtCvX52XJgIDS1xzUPE
         1M0OLbtJlC1zY4MUVLiG4G506BO/pMUdmoAQqxT12iUy749TEF4qGLCuv+4+9s7LtxUU
         EpAqQS0cipopLBd1OyhCF6Bbj5/mr8psy3z1AfN2r14cvb1bNL59+SPAFPiudIv9QWdb
         eoGRYoZnHQLUv3v83VTHQLTJI6qQQeVRDxjPlzKrcoef2eabdtFy0hUThMZsYDThVkrG
         iFzQ==
X-Gm-Message-State: AOAM531jxN1t7r8NLXENo6m0I8LZCGxTyMGlwbweyQa3GyxjKWImWCVs
        +Oe36XCAIIW+ccMczA5nTVezFXGEbngLp527fQzNZt3J5FFHYm2tvF7fC9TMqSace+EuCura/KB
        CeotCLH8GvzvKFPpOT6djwHT9
X-Received: by 2002:a17:906:5fd1:: with SMTP id k17mr3466976ejv.78.1622118555083;
        Thu, 27 May 2021 05:29:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxe4mTlKJpJXiiOU031vKBWLZgdwTa9d3E/fVcrPcUscegYQrTzpicqFmVM1iwUX75FSYoA3w==
X-Received: by 2002:a17:906:5fd1:: with SMTP id k17mr3466949ejv.78.1622118554917;
        Thu, 27 May 2021 05:29:14 -0700 (PDT)
Received: from x1.bristot.me (nat-cataldo.sssup.it. [193.205.81.5])
        by smtp.gmail.com with ESMTPSA id r17sm1021115edt.33.2021.05.27.05.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 05:29:14 -0700 (PDT)
Subject: Re: [PATCH V3 4/9] tracing/hwlat: Implement the per-cpu mode
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kate Carcia <kcarcia@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>, linux-doc@vger.kernel.org
References: <cover.1621024265.git.bristot@redhat.com>
 <187db3f9eed1603c858a1f7669d0140dfb753bfd.1621024265.git.bristot@redhat.com>
 <YK+JfHHNbvV7odqX@localhost.localdomain>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <c5735fe7-5f21-bec7-56bf-45db8e6e616e@redhat.com>
Date:   Thu, 27 May 2021 14:29:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YK+JfHHNbvV7odqX@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/21 1:58 PM, Juri Lelli wrote:
> Hi,
> 
> On 14/05/21 22:51, Daniel Bristot de Oliveira wrote:
> 
> [...]
> 
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
> 
> Is this_cpumask actually used anywhere?

OOpppsss, this is a left-over :-(....

Before starting using kthread_create_on_cpu(), I was using this_cpumask to set
the affinity of threads created via kthread_create().... but it is not needed
anymore.

I will remove it, good catch.

Thanks!
-- Daniel

> 
> Thanks,
> Juri
> 

