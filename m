Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0B045688D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 04:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbhKSDWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 22:22:08 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:39744 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231831AbhKSDWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 22:22:08 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=rocking@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Ux2pcuu_1637291943;
Received: from IT-C02ZG85SLVDL.local(mailfrom:rocking@linux.alibaba.com fp:SMTPD_---0Ux2pcuu_1637291943)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 19 Nov 2021 11:19:04 +0800
Subject: Re: [PATCH] Add busy loop polling for idle SMT
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
References: <cover.1637062971.git.rocking@linux.alibaba.com>
 <YZTgVzAFvZzXBrzy@hirez.programming.kicks-ass.net>
From:   Peng Wang <rocking@linux.alibaba.com>
Message-ID: <e31e9b58-591b-c538-ccd1-5864e586ad02@linux.alibaba.com>
Date:   Fri, 19 Nov 2021 11:19:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YZTgVzAFvZzXBrzy@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2021 18:58, , Peter Zijlstra wrote:
> On Tue, Nov 16, 2021 at 07:51:35PM +0800, Peng Wang wrote:
>> Now we have cpu_idle_force_poll which uses cpu_relax() waiting for
>> an arriving IPI, while sometimes busy loop on idle cpu is also
>> useful to provide consistent pipeline interference for hardware SMT.
>>
>> When hardware SMT is enabled, the switching between idle and
>> busy state of one cpu will cause performance fluctuation of
>> other sibling cpus on the same core.
>>
>> In pay-for-execution-time scenario, cloud service providers prefer
>> stable performance data to set stabel price for same workload.
>> Different execution time of the same workload caused by different
>> idle or busy state of sibling SMT cpus will make different bills, which
>> is confused for customers.
>>
>> Since there is no dynamic CPU time scaling based on SMT pipeline interference,
>> to coordinate sibling SMT noise no matter whether they are idle or not,
>> busy loop in idle state can provide approximately consistent pipeline interference.
>>
>> For example, a workload computing tangent and cotangent will finish in 9071ms when
>> sibling SMT cpus are idle, and 13299ms when sibling SMT cpus are computiing other workload.
>> This generate 32% performance fluctuation.
>>
>> SMT idle polling makes things slower, but we can set bigger cpu quota to make up
>> a deficiency. This also increase power consumption by 2.2%, which is acceptable.
>>
>> There may be some other possible solutions, while each has its own problem:
>> a) disbale hardware SMT, which means half of SMT is unused and more hardware cost.
>> b) busy loop in a userspace thread, but the cpu usage is confusing.
>>
>> We propose this patch to discuss the performance fluctuation problem related to SMT
>> pipeline interference, and any comments are welcome.
> 
> I think you missed April Fools' Day by a wide margin.
> 
> Lowering performance and increasing power usage is a direct

Siblings' noise depends on workloads, when persuing performance 
stability, we have to consider what performance data to keep:

a) the worst with all-time noise
b) the best with monopolizing a whole core by disabling SMT or using 
core scheduling, while wasting some logic CPUs
c) A number between the worst and the best which is hard to decide

That's where lowering performance comes from.

> contradiction to sanity. It also doesn't really work as advertised,
> if the siblings are competing for AVX resources the performance is a
> *lot* lower than when an AVX task is competing against a spinner like
> this.
> 

Yes, idle SMT busy loop polling can only provide approximately pipeline 
interference for normal instructions.

When it comes to AVX works, we notice an idea modifing CPU time 
accounting[1], do you think the combination can lead to a feasible
solution, or any other better ideas?

[1] https://www.usenix.org/conference/atc21/presentation/gottschlag
