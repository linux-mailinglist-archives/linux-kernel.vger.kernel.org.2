Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77A9353AD2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 03:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhDEBaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 21:30:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54040 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231887AbhDEBaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 21:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617586194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YD512Im+MfzeFXa/2sskA5SKXgI3nkmLTxAtwF3W3+0=;
        b=Hoyv6rx+mwZwQKv+nVikHx1MxbMT6wZ6eeQej1X405ibNjzVBAh0JRsNoRt/Oq32Nz+KjI
        VQBDiqVGjnOZPlBGZsQCxHGS+13U3KBSQg4M+NUA6RECpl3MvHqTE5dT6CAGzteL2HYUM4
        QWyKKnuPEwtHehBCVWPw8/8h9pQkR9s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-c6p3Y2UHN-ugBOdMMTZ4pg-1; Sun, 04 Apr 2021 21:29:53 -0400
X-MC-Unique: c6p3Y2UHN-ugBOdMMTZ4pg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EE7687A826;
        Mon,  5 Apr 2021 01:29:51 +0000 (UTC)
Received: from llong.remote.csb (ovpn-113-6.rdu2.redhat.com [10.10.113.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 051276B8D4;
        Mon,  5 Apr 2021 01:29:43 +0000 (UTC)
Subject: Re: [PATCH v3] sched/debug: Use sched_debug_lock to serialize use of
 cgroup_path[] only
From:   Waiman Long <longman@redhat.com>
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
 <b5d7e93f-c594-7678-eb8d-275ddd9cd8ce@redhat.com>
 <20210404120231.13843854@oasis.local.home>
 <4014fe97-5875-f64a-7b68-854a2b08394e@redhat.com>
Organization: Red Hat
Message-ID: <03f8cfd4-bb73-a7e5-83f8-7b0731071ae8@redhat.com>
Date:   Sun, 4 Apr 2021 21:29:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <4014fe97-5875-f64a-7b68-854a2b08394e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/21 9:27 PM, Waiman Long wrote:
> On 4/4/21 12:02 PM, Steven Rostedt wrote:
>> On Fri, 2 Apr 2021 23:09:09 -0400
>> Waiman Long <longman@redhat.com> wrote:
>>
>>> The main problem with sched_debug_lock is that under certain
>>> circumstances, a lock waiter may wait a long time to acquire the lock
>>> (in seconds). We can't insert touch_nmi_watchdog() while the cpu is
>>> waiting for the spinlock.
>> The problem I have with the patch is that it seems to be a hack (as it
>> doesn't fix the issue in all cases). Since sched_debug_lock is
>> "special", perhaps we can add wrappers to take it, and instead of doing
>> the spin_lock_irqsave(), do a trylock loop. Add lockdep annotation to
>> tell lockdep that this is not a try lock (so that it can still detect
>> deadlocks).
>>
>> Then have the strategically placed touch_nmi_watchdog() also increment
>> a counter. Then in that trylock loop, if it sees the counter get
>> incremented, it knows that forward progress is being made by the lock
>> holder, and it too can call touch_nmi_watchdog().
>
> Thanks for the suggestion, but it also sound complicated.
>
> I think we can fix this lockup problem if we are willing to lose some 
> information in case of contention. As you have suggested, a trylock 
> will be used to acquire sched_debug_lock. If succeeded, all is good. 
> Otherwise, a shorter stack buffer will be used for cgroup path. The 
> path may be truncated in this case. If we detect that the full length 
> of the buffer is used, we assume truncation and add, e.g. "...", to 
> indicate there is more to the actual path.
>
> Do you think this is an acceptable comprise? 

Actually, I don't really need to disable interrupt under this situation 
as deadlock can't happen.

Cheers,
Longman

