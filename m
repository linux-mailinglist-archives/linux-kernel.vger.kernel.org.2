Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A589234F002
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 19:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhC3Rn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 13:43:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39003 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232311AbhC3Rng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 13:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617126215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AcNrF5VPLnmzXK0uIJbQI2XjApDLU1f4iiFjAuTsbh8=;
        b=ZuyWXJ/Zu6dLbLqacgD6zifgMKYTOa4yxRnb/1EG6WMAJPms9lVChweAg6ZAGWQ08bmaAT
        4CH/VVTUxOlYNJyKMKA4SE7D4WZz1VP8oTwXQkPapa5NPc5+1vOLvmDchmkWjKTYwMnUnw
        udlbKpFITyQdy1Go04G2hpCj8D7YyKU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-fPZzHZytNg-2-CPJCKh9Mg-1; Tue, 30 Mar 2021 13:43:34 -0400
X-MC-Unique: fPZzHZytNg-2-CPJCKh9Mg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E8A9802B40;
        Tue, 30 Mar 2021 17:43:32 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-27.rdu2.redhat.com [10.10.117.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A56795DDAD;
        Tue, 30 Mar 2021 17:43:23 +0000 (UTC)
Subject: Re: [PATCH v2] sched/debug: Use sched_debug_lock to serialize use of
 cgroup_path[] only
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Bharata B Rao <bharata@linux.vnet.ibm.com>,
        Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org
References: <20210329193235.30364-1-longman@redhat.com>
 <20210330104235.afoljxizvfcijxqx@maple.lan>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <626d056e-1489-d406-62cc-4b981ff94175@redhat.com>
Date:   Tue, 30 Mar 2021 13:43:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210330104235.afoljxizvfcijxqx@maple.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/21 6:42 AM, Daniel Thompson wrote:
> On Mon, Mar 29, 2021 at 03:32:35PM -0400, Waiman Long wrote:
>> The handling of sysrq keys should normally be done in an user context
>> except when MAGIC_SYSRQ_SERIAL is set and the magic sequence is typed
>> in a serial console.
> This seems to be a poor summary of the typical calling context for
> handle_sysrq() except in the trivial case of using
> /proc/sysrq-trigger.
>
> For example on my system then the backtrace when I do sysrq-h on a USB
> keyboard shows us running from a softirq handler and with interrupts
> locked. Note also that the interrupt lock is present even on systems that
> handle keyboard input from a kthread due to the interrupt lock in
> report_input_key().
I will reword this part of the patch. I don't have a deep understanding 
of how the different way of keyword input work and thanks for showing me 
that there are other ways of getting keyboard input.
>
>> Currently in print_cpu() of kernel/sched/debug.c, sched_debug_lock is taken
>> with interrupt disabled for the whole duration of the calls to print_*_stats()
>> and print_rq() which could last for the quite some time if the information dump
>> happens on the serial console.
>>
>> If the system has many cpus and the sched_debug_lock is somehow busy
>> (e.g. parallel sysrq-t), the system may hit a hard lockup panic, like
> <snip>
>
>> The purpose of sched_debug_lock is to serialize the use of the global
>> cgroup_path[] buffer in print_cpu(). The rests of the printk() calls
>> don't need serialization from sched_debug_lock.
>>
>> Calling printk() with interrupt disabled can still be/proc/sysrq-trigger
>> problematic. Allocating a stack buffer of PATH_MAX bytes is not
>> feasible. So a compromised solution is used where a small stack buffer
>> is allocated for pathname. If the actual pathname is short enough, it
>> is copied to the stack buffer with sched_debug_lock release afterward
>> before printk().  Otherwise, the global group_path[] buffer will be
>> used with sched_debug_lock held until after printk().
> Does this actually fix the problem in any circumstance except when the
> sysrq is triggered using /proc/sysrq-trigger?

I have a reproducer that generates hard lockup panic when there are 
multiple instances of sysrq-t via /proc/sysrq-trigger. This is probably 
less a problem on console as I don't think we can do multiple 
simultaneous sysrq-t there. Anyway, my goal is to limit the amount of 
time that irq is disabled. Doing a printk can take a while depending on 
whether there are contention in the underlying locks or resources. Even 
if I limit the the critical sections to just those printk() that outputs 
cgroup path, I can still cause the panic.

Cheers,
Longman

The approach used by this patch should minimize the chance of a panic 
happening. However, if there are many tasks with very long cgroup paths, 
I suppose that panic may still happen under some extreme conditions. So 
I won't say this will completely fix the problem until the printk() 
rework that makes printk work more like printk_deferred() is merged.


