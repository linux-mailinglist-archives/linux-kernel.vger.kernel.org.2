Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9CD6354AAB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 03:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243254AbhDFB53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 21:57:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24827 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239052AbhDFB52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 21:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617674241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KO7YOZGHuv1kVdP1LMRNzdDPgf6i9D7Y3FicCdhas5c=;
        b=R8hC4wF7jblD92qK0beLPGzzjbJrryH0LlDhbEcmKUweT8vT5z7mgORAsM6zORhV9wVWW0
        6DrdXYI9BF4JxIlIZfrWEeH5PaBYSiorc/fNaSSSpqH+GXOoYtb2MjjJu+D4hSt8wjwz3H
        Hjte5cZlZ/YPKj+RmKMtyTB2YJC2+Xs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-StJ_PWVtMb2bOXS4wMmrlQ-1; Mon, 05 Apr 2021 21:57:17 -0400
X-MC-Unique: StJ_PWVtMb2bOXS4wMmrlQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0470D180FCA7;
        Tue,  6 Apr 2021 01:57:16 +0000 (UTC)
Received: from llong.remote.csb (ovpn-112-77.rdu2.redhat.com [10.10.112.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 39F40610A8;
        Tue,  6 Apr 2021 01:57:08 +0000 (UTC)
Subject: Re: [PATCH v4] sched/debug: Use sched_debug_lock to serialize use of
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
References: <20210405234203.23526-1-longman@redhat.com>
 <20210405201807.4ee7778d@gandalf.local.home>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <5c4d0d47-5503-76a2-0f27-1b4b13c34aa5@redhat.com>
Date:   Mon, 5 Apr 2021 21:57:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210405201807.4ee7778d@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/21 8:18 PM, Steven Rostedt wrote:
> On Mon,  5 Apr 2021 19:42:03 -0400
> Waiman Long <longman@redhat.com> wrote:
>
>> +/*
>> + * All the print_cpu() callers from sched_debug_show() will be allowed
>> + * to contend for sched_debug_lock and use group_path[] as their SEQ_printf()
>> + * calls will be much faster. However only one print_cpu() caller from
>> + * sysrq_sched_debug_show() which outputs to the console will be allowed
>> + * to use group_path[]. Another parallel console writer will have to use
>> + * a shorter stack buffer instead. Since the console output will be garbled
>> + * anyway, truncation of some cgroup paths shouldn't be a big issue.
>> + */
>> +#define SEQ_printf_task_group_path(m, tg, fmt...)			\
>> +{									\
>> +	unsigned long flags;						\
>> +	int token = m ? TOKEN_NA					\
>> +		      : xchg_acquire(&console_token, TOKEN_NONE);	\
>> +									\
>> +	if (token == TOKEN_NONE) {					\
>> +		char buf[128];						\
>> +		task_group_path(tg, buf, sizeof(buf));			\
>> +		SEQ_printf(m, fmt, buf);				\
>> +	} else {							\
>> +		spin_lock_irqsave(&sched_debug_lock, flags);		\
>> +		task_group_path(tg, group_path, sizeof(group_path));	\
>> +		SEQ_printf(m, fmt, group_path);				\
>> +		spin_unlock_irqrestore(&sched_debug_lock, flags);	\
>> +		if (token == TOKEN_ACQUIRED)				\
>> +			smp_store_release(&console_token, token);	\
>> +	}								\
>>   }
>>   #endif
> And you said my suggestion was complex!
>
> I'll let others review this.
>
This patch is actually inspired by your suggestion, though it is 
structured differently from your approach. I really want to thank you 
for your valuable feedback.

I realized that printing to a sequence file wasn't really a problem, 
only printing to console can be problematic. That is why I decided to 
allow unlimited use of group_path[] for those users and only one console 
writer is allowed to use it. As for calling touch_nmi_watchdog(), I am 
still thinking where will be the right place to do it, but it can be 
done with a separate patch, if needed.

Cheers,
Longman

