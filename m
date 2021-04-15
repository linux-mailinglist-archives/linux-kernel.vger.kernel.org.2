Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E10360922
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 14:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbhDOMQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 08:16:49 -0400
Received: from foss.arm.com ([217.140.110.172]:44844 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232889AbhDOMQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 08:16:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1358A106F;
        Thu, 15 Apr 2021 05:16:22 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93C1C3F73B;
        Thu, 15 Apr 2021 05:16:19 -0700 (PDT)
Subject: Re: [PATCH v2 7/9] sched,debug: Convert sysctl sched_domains to
 debugfs
To:     Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     mingo@kernel.org, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, bristot@redhat.com, joshdon@google.com,
        linux-kernel@vger.kernel.org, greg@kroah.com,
        linux@rasmusvillemoes.dk
References: <20210412101421.609526370@infradead.org>
 <20210412102001.485107586@infradead.org> <87lf9mmdyk.mognet@arm.com>
 <YHgB/s4KCBQ1ifdm@hirez.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <a3399de6-ebe9-a813-23a1-565f6fdf38c7@arm.com>
Date:   Thu, 15 Apr 2021 14:16:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YHgB/s4KCBQ1ifdm@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/2021 11:06, Peter Zijlstra wrote:
> On Tue, Apr 13, 2021 at 03:55:15PM +0100, Valentin Schneider wrote:
>> On 12/04/21 12:14, Peter Zijlstra wrote:
>>> Stop polluting sysctl, move to debugfs for SCHED_DEBUG stuff.
>>>
>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>>
>> On my Juno (2+4 big.LITTLE), sys/kernel/debug/sched/domains/ is now empty.
>>
>> I think that's because of unregister_sched_domain_sysctl() -
>> debugfs_remove() is recursive, and I do get a case where we rebuild the
>> domains but no CPU has been added or removed (we rebuild the domains when
>> cpufreq kicks in, it's part of the big.LITTLE ponies).
>>
>> Do we actually still need that unregister? From a brief glance it looks
>> like we could throw it out.
> 
> Yeah, I can't think of anything either. AFAICT it hasn't done anything
> useful since that cpumask optimization. Consider it gone.
> 
> I'll let it soak for another day or so, but then I was planning on
> merging this series.
> 
> Updated patch has been in queue.git/sched/debug since yesterday.

Had to check since v1 was working fine on Juno. So it was this
__cpumask_clear_cpu() in register_sched_domain_sysctl() introduced in v2
which let the files under /sys/kernel/debug/sched/domains disapear.

With {un,}register_sched_domain_sysctl() removed from
partition_sched_domains_locked() they're there again.

Looks like now register_sched_domain_sysctl() can be made static in
kernel/sched/debug.c.

[...]
