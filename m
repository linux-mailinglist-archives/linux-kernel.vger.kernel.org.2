Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A283CF888
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 13:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236974AbhGTKUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 06:20:32 -0400
Received: from foss.arm.com ([217.140.110.172]:55878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237769AbhGTKGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:06:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3896C6D;
        Tue, 20 Jul 2021 03:47:27 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 557303F73D;
        Tue, 20 Jul 2021 03:47:26 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] sched/fair: Trigger nohz.next_balance updates when
 a CPU goes NOHZ-idle
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20210719103117.3624936-1-valentin.schneider@arm.com>
 <20210719103117.3624936-3-valentin.schneider@arm.com>
 <e8dffbaf-71cb-d3b3-04e8-64fc8e6256af@arm.com> <878s22mfnn.mognet@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <dce1c131-d52d-4eec-276b-3a2eeefabb3d@arm.com>
Date:   Tue, 20 Jul 2021 12:47:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <878s22mfnn.mognet@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2021 18:28, Valentin Schneider wrote:
> On 19/07/21 17:24, Dietmar Eggemann wrote:
>> On 19/07/2021 12:31, Valentin Schneider wrote:

[...]

>>>       * Ensures that if we miss the CPU, we must see the has_blocked
>>> @@ -10531,6 +10540,8 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
>>>              if (need_resched()) {
>>>                      if (flags & NOHZ_STATS_KICK)
>>>                              has_blocked_load = true;
>>
>> This looks weird now? 'has_blocked_load = true' vs
>> 'WRITE_ONCE(nohz.needs_update, 1)'.
>>
> 
> Well, has_blocked_load lets us factorize the nohz.has_blocked write
> (one is needed either when aborting or at the tail of the cpumask
> iteration), whereas there is just a single write for nohz.needs_update
> (when aborting).

You're right. Looks good then.

[...]
