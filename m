Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDBF30E2B9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 19:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbhBCSoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 13:44:24 -0500
Received: from foss.arm.com ([217.140.110.172]:45082 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232879AbhBCSoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 13:44:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B1E7143D;
        Wed,  3 Feb 2021 10:43:27 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE3A63F719;
        Wed,  3 Feb 2021 10:43:25 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH 0/8] sched/fair: misfit task load-balance tweaks
In-Reply-To: <20210203151400.ommltjjyuok4yj5e@e107158-lin>
References: <20210128183141.28097-1-valentin.schneider@arm.com> <20210203151400.ommltjjyuok4yj5e@e107158-lin>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Wed, 03 Feb 2021 18:43:23 +0000
Message-ID: <jhjim792dro.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais,

On 03/02/21 15:14, Qais Yousef wrote:
> On 01/28/21 18:31, Valentin Schneider wrote:
>> Hi folks,
>> 
>> Here is this year's series of misfit changes. On the menu:
>> 
>> o Patch 1 is an independent active balance cleanup
>> o Patch 2 adds some more sched_asym_cpucapacity static branches
>> o Patch 3 introduces yet another margin for capacity to capacity
>>   comparisons
>> o Patches 4-6 build on top of patch 3 and change capacity comparisons
>>   throughout misfit load balancing  
>> o Patches 7-8 fix some extra misfit issues I've been seeing on "real"
>>   workloads.
>> 
>> IMO the somewhat controversial bit is patch 3, because it attempts to solve
>> margin issues by... Adding another margin. This does solve issues on
>> existing platforms (e.g. Pixel4), but we'll be back to square one the day
>> some "clever" folks spin a platform with two different CPU capacities less than
>> 5% apart.
>
> One more margin is a cause of apprehension to me. But in this case I think it
> is the appropriate thing to do now. I can't think of a scenario where this
> could hurt.
>

Thanks for having a look!

> Thanks
>
> --
> Qais Yousef
