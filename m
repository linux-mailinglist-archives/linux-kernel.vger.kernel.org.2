Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158F03A4DEC
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 11:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhFLJnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 05:43:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26748 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229942AbhFLJnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 05:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623490906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pPOTnBlb5gG14HcFtr8VUBr+dq0of1GZHHpn43YJCFs=;
        b=XcTzTiTYk0ZPulPYwi5onlffu2YvOMK6Vd0zYSV8j5X7JUTyOLK2BwpZLyQWebiiFeJFWk
        AMc+KMx3vSZAESkTXUex/4xPs+rtjDe9wvxDDodJWPYYyYHLsGOIEQArdi90zodjEzHamy
        7bSoC6SmBMnoqjXr+LqD2VqXugtjGQw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-JacvINWmPX2im60BiZ89Dw-1; Sat, 12 Jun 2021 05:41:44 -0400
X-MC-Unique: JacvINWmPX2im60BiZ89Dw-1
Received: by mail-ej1-f69.google.com with SMTP id f1-20020a1709064941b02903f6b5ef17bfso1660595ejt.20
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 02:41:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pPOTnBlb5gG14HcFtr8VUBr+dq0of1GZHHpn43YJCFs=;
        b=H2X9Yn/gydbiIah16K19OGoEMkfJ1NzkDYS3mr85lXkJpxuxbAnJjY9DnaFzZpD5ug
         eUxiWG9tmOfrwWZ47ufcY8ZVn1hdlHKwbAObofSODX2qfPnKh6JZxTweGHRniYdThd29
         5rIXCEwk9zqaG4uRESOQzvT64P14GM5hknYhkTCWq7saDJVlq8XraG8yG8aJCA54Qdva
         wgHhxmDkaEzCUhQNjx/eeEQ6zejZOcFZcX17tFsDC9fDTvRcsfJsGzVtTio447UAQqlT
         MhKSfIZeCkYlmXwsJkEfkmh14KoLxgiKgwCbPTpgI5qE+/+tyyMRuni7zaadex8vGTtk
         7UoA==
X-Gm-Message-State: AOAM531mTgmljASOtDw88mVY10YyEHGrWEiaoR9cY8X2bF9r3mNY3chK
        hi46QU/jIQ4DyLguec/fFTNQCqkiE8uNK32RdO5HGabPRC0em9Hm2Zcc3urp6FC4ES8FpH7fFBi
        4YttO55poOKetI9eKq7cMKQ9i
X-Received: by 2002:a05:6402:40cc:: with SMTP id z12mr7765828edb.202.1623490903256;
        Sat, 12 Jun 2021 02:41:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjkRPqvVX2DYHQMsKZKDTTc+kPdXuszH9U3Wlwp10935qst42YhGcUNHLhN676CBUWW0ayrw==
X-Received: by 2002:a05:6402:40cc:: with SMTP id z12mr7765815edb.202.1623490903063;
        Sat, 12 Jun 2021 02:41:43 -0700 (PDT)
Received: from x1.bristot.me (host-79-23-205-114.retail.telecomitalia.it. [79.23.205.114])
        by smtp.gmail.com with ESMTPSA id u17sm3529584edx.16.2021.06.12.02.41.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Jun 2021 02:41:42 -0700 (PDT)
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
 <fd2bdb45-e68a-995e-271e-ec181f04ecbc@redhat.com>
 <20210611160340.6970e10c@gandalf.local.home>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <6808245d-208c-c6d2-1c6e-7410df158992@redhat.com>
Date:   Sat, 12 Jun 2021 11:41:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210611160340.6970e10c@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/21 10:03 PM, Steven Rostedt wrote:
> On Fri, 11 Jun 2021 14:59:13 +0200
> Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> 
>> ------------------ %< -----------------------------
>> It is worth mentioning that the *duration* values reported
>> by the osnoise: events are *net* values. For example, the
>> thread_noise does not include the duration of the overhead caused
>> by the IRQ execution (which indeed accounted for 12736 ns). But
>> the values reported by the timerlat tracer (timerlat_latency)
>> are *gross* values.
>>
>> The art below illustrates a CPU timeline and how the timerlat tracer
>> observes it at the top and the osnoise: events at the bottom. Each "-"
>> in the timelines means 1 us, and the time moves ==>:
>>
>>      External          context irq                  context thread
>>       clock           timer_latency                 timer_latency
>>       event              18 us                          48 us 
>>         |                  ^                             ^
>>         v                  |                             |
>>         |------------------|                             |       <-- timerlat irq timeline
>>         |------------------+-----------------------------|       <-- timerlat thread timeline
>>                            ^                             ^
>>  ===================== CPU timeline ======================================
>>                    [timerlat/ irq]  [ dev irq ]                          
>>  [another thread...^             v..^         v........][timerlat/ thread]  
>>  ===================== CPU timeline ======================================
>>                    |-------------|  |---------|                  <-- irq_noise timeline
>>                                  |--^         v--------|         <-- thread_noise timeline
>>                                  |            |        |
>>                                  |            |        + thread_noise: 10 us
>>                                  |            +-> irq_noise: 9 us
>>                                  +-> irq_noise: 13 us
>>
>>  --------------- >% --------------------------------  
> 
> That's really busy, and honestly, I can't tell what is what.
> 
> The "context irq timer_latency" is a confusing name. Could we just have
> that be "timer irq latency"? And "context thread timer_latency" just be
> "thread latency". Adding too much text to the name actually makes it harder
> to understand. We want to simplify it, not make people have to think harder
> to see it.
> 
> I think we can get rid of the "<-- .* timeline" to the right.  I don't
> think they are necessary. Again, the more you add to the diagram, the
> busier it looks, and the harder it is to read.
> 
> Could we switch "[timerlat/ irq]" to just "[timer irq]" and explain how
> that "context irq timer_latency"/"timer irq latency" is related?
> 
> Should probably state that the "dev irq" is an unrelated device interrupt
> that happened.
> 
> What's with the two CPU timeline lines? Now there I think it would be
> better to have the arrow text by itself.
> 
> And finally, not sure if you plan on doing this, but have a output of the
> trace that would show the above.
> 
> Thus, here's what I would expect to see:
> 
>       External         
>        clock         timer irq latency             e    thread latency
>        event              18 us                          48 us 
>          |                  ^                             ^
>          v                  |                             |
>          |------------------|                             |
>          |------------------+-----------------------------|       
>                             ^                             ^
>   =========================================================================
>                     [timerlat/ irq]  [ dev irq ]                             
>   [another thread...^             v..^         v........][timerlat/ thread]  <-- CPU task timeline
>   =========================================================================
>                     |-------------|  |---------|
>                                   |--^         v--------|
>                                   |            |        |
>                                   |            |        + thread_noise: 10 us
>                                   |            +-> irq_noise: 9 us
>                                   +-> irq_noise: 13 us

It looks good to me!

>  The "[ dev irq ]" above is an interrupt from some device on the system that
>  causes extra noise to the timerlat task.
> 
> I think the above may be easier to understand, especially if the trace
> output that represents it is below.

ok, I can try to capture a trace sample and represent it into the ASCII art
format above.

> Also, I have to ask, shouldn't the "thread noise" really start at the
> "External clock event"?

To go in that direction, we need to track things that delayed the IRQ execution.
We are already tracking other IRQs' execution, but we will have to keep a
history of past executions and "playback" them. This will add some overhead
linear to the past event... and/or some pessimism.

We will also have to track IRQ disabled sections. The problem of tracking IRQ
disabled is that it depends on tracing infra-structure that is not enabled by
default of distros... And there are IRQ delay causes that are not related to the
thread... like idle states... (and all these things create more and more states
to track these things)...

So, I added the timer irq latency to figure out when the problem is related to
things that delay the IRQ, and the stack trace will help us figure out where the
problem is in the thread context. After the IRQ execution, the thread noise is
helpful - even without all the thread noise before the IRQ.

Furthermore, if we start trying to abstract the causes of delay, we will find
the rtsl :-). The rtls events and abstractions give us the worst-case scheduling
latency without adding unneeded pessimism (sound analysis). It covers all the
possible cases, for all any schedulers, even without the need of a measuring
thread like here (or with cyclictest) - and this is a good thing because it does
not change the target system's workload.

The problem is that... rtsl depends on tracing infra-structure that are not
enabled by default on distros, like preempt_ and irq_ disabled events.

So, I see timerlat as a tool for on-the-fly usage, like debugging on customers
(as we do at red hat). It can be enabled by default on distros because it only
depends on existing and already enabled events and causes no overhead when
disabled. rtsl targets more specific cases, like safety-critical systems, where
the overhead is acceptable because of the sound analysis of the scheduling bound
(which is rooted in a formal specification & analysis of the system).

-- Daniel

> -- Steve
> 

