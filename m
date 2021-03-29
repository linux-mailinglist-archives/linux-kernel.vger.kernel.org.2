Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1DE34D24D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 16:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhC2OXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 10:23:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58786 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230258AbhC2OXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 10:23:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617027811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lAuZlU5uT4zcewrzGnLE6fJM/RjMGFb5pbVCfGk3WUk=;
        b=Cx9BBJ7y/GFA1J8FXzOKl3nYSbNN4cE0F/A2k1xE5+YVTDR5omSjcgPDvWE0PWznZC4DFM
        oWRX0QCEm79zAoZkhkolMYlUt3RoK7QkkAf3Q2ViEh1QYe+nJ+B48xho9cQmqA1vDs6AQM
        eLchwergV+s3FstQ4MD/2AdHVn3TXfE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-eqWpyFILNB-wCH5EI9OFkQ-1; Mon, 29 Mar 2021 10:23:29 -0400
X-MC-Unique: eqWpyFILNB-wCH5EI9OFkQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BF60107ACCA;
        Mon, 29 Mar 2021 14:23:27 +0000 (UTC)
Received: from llong.remote.csb (ovpn-118-139.rdu2.redhat.com [10.10.118.139])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D76442BFED;
        Mon, 29 Mar 2021 14:23:18 +0000 (UTC)
Subject: Re: [PATCH 1/2] sched/debug: Don't disable IRQ when acquiring
 sched_debug_lock
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
References: <20210327232529.2349-1-longman@redhat.com>
 <20210329102345.6awrhtlrueqwhrpi@maple.lan>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <e5c9f93d-5e60-7410-fa74-e07278bb1b85@redhat.com>
Date:   Mon, 29 Mar 2021 10:23:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210329102345.6awrhtlrueqwhrpi@maple.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/21 6:23 AM, Daniel Thompson wrote:
> On Sat, Mar 27, 2021 at 07:25:28PM -0400, Waiman Long wrote:
>> The sched_debug_lock was used only in print_cpu().  The
>> print_cpu() function has two callers - sched_debug_show() and
>> sysrq_sched_debug_show(). Both of them are invoked by user action
>> (sched_debug file and sysrq-t). As print_cpu() won't be called from
>> interrupt context at all, there is no point in disabling IRQ when
>> acquiring sched_debug_lock.
> This looks like it introduces a deadlock risk if sysrq-t triggers from an
> interrupt context. Has the behaviour of sysrq changed recently or will
> tools like MAGIC_SYSRQ_SERIAL still trigger from interrupt context?

You are right. It looks like that if CONFIG_MAGIC_SYSRQ_SERIAL is set, 
it is possible for sysrq information dump to happen in an interrupt 
context. I missed that in my initial analysis. However, doing the time 
consuming info dump with interrupt disabled for an extended period of 
time is not a good idea.

Still with my second patch to minimize the size of the critical 
sections, it will minimize the chance of causing trouble except when 
doing it directly from the console.

Thanks,
Longman

