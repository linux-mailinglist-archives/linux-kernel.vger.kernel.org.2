Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87A435322A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 05:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbhDCDJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 23:09:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39953 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231256AbhDCDJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 23:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617419361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ptqfLD7nf9lwZ1DI0I9d9pCCs4zevjixTE/Wl4UwTAc=;
        b=B3bBHXKe30I+TenLTCfhPQ6h+u+9WC2n24eeOe9jDXj6Vxva2bV3vdnRQJ+bgfq5j7XzDE
        coPdzvLlKYYZ3yrYpxM4fOA/UUo3DpsHQzboBxSvKVPhdRs/9InQ7Y4CijLtPZOXaOvSZg
        sw8yvK4DlRM6I/nXddKZrwKpWS0Q49E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-IpaTvd3dNWyEC9V1OLh8og-1; Fri, 02 Apr 2021 23:09:20 -0400
X-MC-Unique: IpaTvd3dNWyEC9V1OLh8og-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0996E801814;
        Sat,  3 Apr 2021 03:09:18 +0000 (UTC)
Received: from llong.remote.csb (ovpn-112-142.rdu2.redhat.com [10.10.112.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 83D9F5D9DC;
        Sat,  3 Apr 2021 03:09:09 +0000 (UTC)
Subject: Re: [PATCH v3] sched/debug: Use sched_debug_lock to serialize use of
 cgroup_path[] only
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Bharata B Rao <bharata@linux.vnet.ibm.com>,
        Phil Auld <pauld@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20210401181030.7689-1-longman@redhat.com>
 <20210402164014.53c84f05@gandalf.local.home>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <b5d7e93f-c594-7678-eb8d-275ddd9cd8ce@redhat.com>
Date:   Fri, 2 Apr 2021 23:09:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210402164014.53c84f05@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/21 4:40 PM, Steven Rostedt wrote:
> On Thu,  1 Apr 2021 14:10:30 -0400
> Waiman Long <longman@redhat.com> wrote:
>
>> The handling of sysrq key can be activated by echoing the key to
>> /proc/sysrq-trigger or via the magic key sequence typed into a terminal
>> that is connected to the system in some way (serial, USB or other mean).
>> In the former case, the handling is done in a user context. In the
>> latter case, it is likely to be in an interrupt context.
>>
>> There should be no more than one instance of sysrq key processing via
>> a terminal, but multiple instances of /proc/sysrq-trigger is possible.
>>
>> Currently in print_cpu() of kernel/sched/debug.c, sched_debug_lock is
>> taken with interrupt disabled for the whole duration of the calls to
>> print_*_stats() and print_rq() which could last for the quite some time
>> if the information dump happens on the serial console.
>>
>> If the system has many cpus and the sched_debug_lock is somehow busy
>> (e.g. parallel sysrq-t), the system may hit a hard lockup panic
>> depending on the actually serial console implementation of the
>> system. For instance,
> Wouldn't placing strategically located "touch_nmi_watchdog()"s around fix
> this?
>
> -- Steve
>
The main problem with sched_debug_lock is that under certain 
circumstances, a lock waiter may wait a long time to acquire the lock 
(in seconds). We can't insert touch_nmi_watchdog() while the cpu is 
waiting for the spinlock.

Cheers,
Longman

