Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2E93DEDF4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 14:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbhHCMiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 08:38:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36384 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235721AbhHCMiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 08:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627994282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Ex2iTU4myVhXpr9BHhMkSSukVTkdZXvGLuCVys/TzA=;
        b=dRWM8HGXjYb/Lfp5wBNAZLK3W4BqIh0EB8D9Dy97DNqY5Dwtn2cxILMpB1kasmfRslSdvO
        /zQxg/ID3Gf1fsgAbqZ720SqgNegn6cILd+PxJge5cLsHSA+hTLUb7Vns3oc3dyUddcvye
        6TYw1d1oZJxDmpLFCJalY7dLzD5UYgU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-Xv710JNFO-WTcanwkuIy9A-1; Tue, 03 Aug 2021 08:38:01 -0400
X-MC-Unique: Xv710JNFO-WTcanwkuIy9A-1
Received: by mail-ed1-f71.google.com with SMTP id x1-20020a05640218c1b02903bc7f97f858so8769759edy.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 05:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4Ex2iTU4myVhXpr9BHhMkSSukVTkdZXvGLuCVys/TzA=;
        b=ZL7/dV0B/0JLtVGCvyLLqUlJXILDVQhk3I0FKOv+/X5rmLsch5HnmGPggytuGhpbEa
         4AHGZRydC4KApsdsS2melWlk+alla8bUb8DJV6iWdu56k3VTJ31iFnvp91fYvFvFWKNC
         f7oCcuyI5c3lJwefg2iGHhv0wuaB3H28L6ztiD9tCXAZOjI4kxayGFMwG33gzttBIQ8i
         moUS9eT30CSpJaejzr/7GVR3eRWBO1mhC7z8+PBm04Uxsp9vaFj5wQqYmDgRKXbpxBuk
         oil9iVNPzF0PsGVFQ6Ku2DHs6tli5qdU+M3eGQxbp2EJz9FVdYTp4cbtdhHE80HCfLav
         kFMg==
X-Gm-Message-State: AOAM530+o7AtJJi61mrXVd6PyUXpWhUUaw7NDgfkpTgrMheWFDG/smYP
        IBqzwLSqDpIJRVrDLGoS7bUNkSUOGR3lJGtMzxpmSuHcZFj0fWVXZFPW9ckTIzBz2NiIyLHM9x8
        aoIyz6zZO1Z4x3cM7GwBPrZn6
X-Received: by 2002:a05:6402:3507:: with SMTP id b7mr25841133edd.293.1627994280500;
        Tue, 03 Aug 2021 05:38:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylGgBusP7nVq6VcI8g4JMkut0nG2ManxoJGnFC9C8SfuWxwX2HBseB5fg9EsC7eKRDliuiOQ==
X-Received: by 2002:a05:6402:3507:: with SMTP id b7mr25841107edd.293.1627994280254;
        Tue, 03 Aug 2021 05:38:00 -0700 (PDT)
Received: from x1.bristot.me (host-95-239-202-226.retail.telecomitalia.it. [95.239.202.226])
        by smtp.gmail.com with ESMTPSA id og35sm6252934ejc.28.2021.08.03.05.37.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 05:37:59 -0700 (PDT)
Subject: Re: [patch 00/63] locking, sched: The PREEMPT-RT locking
 infrastructure
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
References: <20210730135007.155909613@linutronix.de>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <b16efbf4-47ee-4689-debf-76ff7cf83903@redhat.com>
Date:   Tue, 3 Aug 2021 14:37:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210730135007.155909613@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/21 3:50 PM, Thomas Gleixner wrote:
> Folks,
> 
> the following series is an update to V1 which can be found here:
> 
>   https://lore.kernel.org/r/20210713151054.700719949@linutronix.de
> 
> It contains the bulk of the PREEMPT-RT locking infrastructure. In
> PREEMPT-RT enabled kernels the following locking primitives are substituted
> by RT-Mutex based variants:
> 
>   mutex, rw_semaphore, spinlock, rwlock
> 
> semaphores are not substituted because they do not provide strict owner
> semantics.
> 
> ww_mutexes are also not substituted because the usage sites are not really
> RT relevant and it would require a full reimplementation to make them work
> correctly based on rtmutex. That might change in the future, but for now
> utilizing the existing variant is considered a safe and sane choice.
> 
> Of course raw_spinlocks are not touched either as they protect low level
> operations in the scheduler, timers and hardware access.
> 
> The most interesting parts of the series which need a lot of eyeballs
> are:
> 
>   - the scheduler bits which provide the infrastructure for spinlock and
>     rwlock substitution to ensure that the task state is preserved when
>     blocking on such a lock and a regular wakeup is handled correctly and
>     not lost
> 
>   - the rtmutex core implementation to handle lock contention on spinlocks
>     and rwlocks correctly vs. the task state
> 
>   - the rw_semaphore/rwlock substitutions which utilize the same
>     implementation vs. the reader/writer handling
> 
>   - the isolation of the ww_mutex code which allows to build it stand alone.
>     The typedef based solution might look a bit odd on the first glance,
>     but that turned out to be the least intrusive variant.
> 
>   - the PI futex related bits to handle the interaction between blocking
>     on the underlying rtmutex and contention on the hash bucket lock which
>     is converted to a 'sleeping spinlock'.
> 
> The rest surely needs a thorough review as well, but those parts are pretty
> straight forward. Quite some code restructuring and the actual wrapper
> functions to replace the existing !RT implementations.
> 
> The series survived quite some internal testing in RT kernels and is part
> of the recent 5.14-rc3-rt2 release.
> 
> For !RT kernels there is no functional change.
> 
> The series is also available from git:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rtmutex
> 
> and fully integrated into the v5.14-rc3-rt2 release:
> 
>  https://lore.kernel.org/r/20210730131256.7d3jccmpuiw5pr4o@linutronix.de

Thomas,

While reviewing/testing this series, I ended up finding some (simple) typos,
reporting them here:

patch 2:
	unneccesary -> unnecessary

patches 2/3/27/29/31:	
	accross -> across

patch 4:
	optimze -> optimize
	
patches 4/15:
	seperately -> separately

patches 5(2x)/12/17/18:
	seperate -> separate

patch 11:
	appropiate -> appropriate

patch 15:
	indentical -> identical

patch 34:
	Preperatory -> Preparatory

patch 53:
	completness -> 	completeness

patch 61:
	Signficant -> Significant

continuing the testing...

-- Daniel

