Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E97630F2D3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 13:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbhBDMEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 07:04:37 -0500
Received: from foss.arm.com ([217.140.110.172]:57122 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235578AbhBDMEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 07:04:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6CD6D6E;
        Thu,  4 Feb 2021 04:03:50 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA3343F73B;
        Thu,  4 Feb 2021 04:03:48 -0800 (PST)
Subject: Re: [PATCH 0/8] sched/fair: misfit task load-balance tweaks
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>
References: <20210128183141.28097-1-valentin.schneider@arm.com>
 <20210203151400.ommltjjyuok4yj5e@e107158-lin> <jhjim792dro.mognet@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <66efcfb1-d6ee-248a-e337-d690cda1bb5a@arm.com>
Date:   Thu, 4 Feb 2021 13:03:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <jhjim792dro.mognet@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2021 19:43, Valentin Schneider wrote:
> Hi Qais,
> 
> On 03/02/21 15:14, Qais Yousef wrote:
>> On 01/28/21 18:31, Valentin Schneider wrote:
>>> Hi folks,
>>>
>>> Here is this year's series of misfit changes. On the menu:
>>>
>>> o Patch 1 is an independent active balance cleanup
>>> o Patch 2 adds some more sched_asym_cpucapacity static branches
>>> o Patch 3 introduces yet another margin for capacity to capacity
>>>   comparisons
>>> o Patches 4-6 build on top of patch 3 and change capacity comparisons
>>>   throughout misfit load balancing  
>>> o Patches 7-8 fix some extra misfit issues I've been seeing on "real"
>>>   workloads.
>>>
>>> IMO the somewhat controversial bit is patch 3, because it attempts to solve
>>> margin issues by... Adding another margin. This does solve issues on
>>> existing platforms (e.g. Pixel4), but we'll be back to square one the day
>>> some "clever" folks spin a platform with two different CPU capacities less than
>>> 5% apart.
>>
>> One more margin is a cause of apprehension to me. But in this case I think it
>> is the appropriate thing to do now. I can't think of a scenario where this
>> could hurt.
>>
> 
> Thanks for having a look!
> 
>> Thanks
>>
>> --
>> Qais Yousef

How did you verify the benefit of these changes?

It's clear that you need a platform with capacity_orig diffs <20%
between CPU types (like Pixel4 - SD855 (4x261, 3x871, 1x1024) or QC's
RB5 platform - SD865 (4x284, 3x871, 1*1024)) but which
benchmark/testcase did you use?
