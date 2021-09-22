Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F23414CE2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 17:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236334AbhIVPWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 11:22:31 -0400
Received: from foss.arm.com ([217.140.110.172]:50474 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236393AbhIVPW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 11:22:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71AB6113E;
        Wed, 22 Sep 2021 08:20:59 -0700 (PDT)
Received: from [10.57.95.67] (unknown [10.57.95.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46C8F3F718;
        Wed, 22 Sep 2021 08:20:58 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] coresight: Don't immediately close events that are
 run on invalid CPU/sink combos
To:     James Clark <james.clark@arm.com>, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org
Cc:     Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210922125144.133872-1-james.clark@arm.com>
 <20210922125144.133872-2-james.clark@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <b36e8a19-4867-c788-7d68-774a3244fa61@arm.com>
Date:   Wed, 22 Sep 2021 16:20:56 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210922125144.133872-2-james.clark@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2021 13:51, James Clark wrote:
> When a traced process runs on a CPU that can't reach the selected sink,
> the event will be stopped with PERF_HES_STOPPED. This means that even if
> the process migrates to a valid CPU, tracing will not resume.
> 
> This can be reproduced (on N1SDP) by using taskset to start the process
> on CPU 0, and then switching it to CPU 2 (ETF 1 is only reachable from
> CPU 2):
> 
>    taskset --cpu-list 0 ./perf record -e cs_etm/@tmc_etf1/ --per-thread -- taskset --cpu-list 2 ls
> 
> This produces a single 0 length AUX record, and then no more trace:
> 
>    0x3c8 [0x30]: PERF_RECORD_AUX offset: 0 size: 0 flags: 0x1 [T]
> 
> After the fix, the same command produces normal AUX records. The perf
> self test "89: Check Arm CoreSight trace data recording and synthesized
> samples" no longer fails intermittently. This was because the taskset in
> the test is after the fork, so there is a period where the task is
> scheduled on a random CPU rather than forced to a valid one.
> 
> Specifically selecting an invalid CPU will still result in a failure to
> open the event because it will never produce trace:
> 
>    ./perf record -C 2 -e cs_etm/@tmc_etf0/
>    failed to mmap with 12 (Cannot allocate memory)
> 
> The only scenario that has changed is if the CPU mask has a valid CPU
> sink combo in it.
> 
> Testing
> =======
> 
> * Coresight self test passes consistently:
>    ./perf test Coresight
> 
> * CPU wide mode still produces trace:
>    ./perf record -e cs_etm// -a
> 
> * Invalid -C options still fail to open:
>    ./perf record -C 2,3 -e cs_etm/@tmc_etf0/
>    failed to mmap with 12 (Cannot allocate memory)
> 
> * Migrating a task to a valid sink/CPU now produces trace:
>    taskset --cpu-list 0 ./perf record -e cs_etm/@tmc_etf1/ --per-thread -- taskset --cpu-list 2 ls
> 
> * If the task remains on an invalid CPU, no trace is emitted:
>    taskset --cpu-list 0 ./perf record -e cs_etm/@tmc_etf1/ --per-thread -- ls
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: James Clark <james.clark@arm.com>

Thanks James, I have queued this.

Suzuki
