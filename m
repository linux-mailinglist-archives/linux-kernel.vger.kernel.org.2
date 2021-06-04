Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5833939BD02
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 18:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhFDQYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 12:24:37 -0400
Received: from foss.arm.com ([217.140.110.172]:42556 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230231AbhFDQYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 12:24:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BC601424;
        Fri,  4 Jun 2021 09:22:50 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3BBA3F73D;
        Fri,  4 Jun 2021 09:22:47 -0700 (PDT)
Subject: Re: [PATCH] sched/uclamp: Avoid setting cpu.uclamp.min bigger than
 cpu.uclamp.max
To:     Qais Yousef <qais.yousef@arm.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Quentin Perret <qperret@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Ryan Y <xuewyan@foxmail.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>, tj@kernel.org
References: <20210602123803.15738-1-xuewen.yan94@gmail.com>
 <YLeF/556Wbvx1Ssc@google.com>
 <CAB8ipk9BqzEQ4Ta5s+vJeep=v1pmaXS-WsF2tq0u9G8Q2PGmsA@mail.gmail.com>
 <20210604160839.2op4ak75vle3gmt3@e107158-lin.cambridge.arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <d57e4a37-3e17-3f30-d055-729ece19f555@arm.com>
Date:   Fri, 4 Jun 2021 18:22:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210604160839.2op4ak75vle3gmt3@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/2021 18:08, Qais Yousef wrote:
> On 06/03/21 10:24, Xuewen Yan wrote:
>> +CC Qais
> 
> Thanks for the CC :)
> 
>>
>>
>> Hi Quentin
>>
>> On Wed, Jun 2, 2021 at 9:22 PM Quentin Perret <qperret@google.com> wrote:
>>>
>>> +CC Patrick and Tejun
>>>
>>> On Wednesday 02 Jun 2021 at 20:38:03 (+0800), Xuewen Yan wrote:
>>>> From: Xuewen Yan <xuewen.yan@unisoc.com>
>>>>
>>>> When setting cpu.uclamp.min/max in cgroup, there is no validating
>>>> like uclamp_validate() in __sched_setscheduler(). It may cause the
>>>> cpu.uclamp.min is bigger than cpu.uclamp.max.
>>>
>>> ISTR this was intentional. We also allow child groups to ask for
>>> whatever clamps they want, but that is always limited by the parent, and
>>> reflected in the 'effective' values, as per the cgroup delegation model.
> 
> As Quentin said. This intentional to comply with cgroup model.
> 
> See Limits and Protections sections in Documentation/admin-guide/cgroup-v2.rst
> 
> Specifically
> 
> 	"all configuration combinations are valid"
> 
> So user can set cpu.uclamp.min higher than cpu.uclamp.max. But when we apply
> the setting, cpu.uclamp.min will be capped by cpu.uclamp.max. I can see you
> found the cpu_util_update_eff() logic.

To support this:

Patrick had appropriate checks in his `[PATCH v10 12/16] sched/core:
uclamp: Extend CPU's cgroup controller`.

https://lkml.kernel.org/r/20190621084217.8167-13-patrick.bellasi@arm.com

But is was discussed that cgroup v2 `resource distribution model`
configurations (here protection/limit: uclamp_min/uclamp_max) should not
be restricted.

Further down in this thread:

"... Limits always trump protection in effect of course but please don't
limit what can be configured..."
