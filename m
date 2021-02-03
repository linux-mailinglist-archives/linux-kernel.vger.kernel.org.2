Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C51230E2B7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 19:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbhBCSoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 13:44:05 -0500
Received: from foss.arm.com ([217.140.110.172]:45034 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232856AbhBCSnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 13:43:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B22AC11FB;
        Wed,  3 Feb 2021 10:43:02 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 610A03F719;
        Wed,  3 Feb 2021 10:43:01 -0800 (PST)
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
Subject: Re: [PATCH 3/8] sched/fair: Tweak misfit-related capacity checks
In-Reply-To: <20210203151515.4uphnp2lbch57v6y@e107158-lin>
References: <20210128183141.28097-1-valentin.schneider@arm.com> <20210128183141.28097-4-valentin.schneider@arm.com> <20210203151515.4uphnp2lbch57v6y@e107158-lin>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Wed, 03 Feb 2021 18:42:59 +0000
Message-ID: <jhjmtwl2dsc.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/21 15:15, Qais Yousef wrote:
> On 01/28/21 18:31, Valentin Schneider wrote:
>> @@ -113,6 +113,13 @@ int __weak arch_asym_cpu_priority(int cpu)
>>   */
>>  #define fits_capacity(cap, max)	((cap) * 1280 < (max) * 1024)
>>  
>> +/*
>> + * The margin used when comparing CPU capacities.
>> + * is 'cap' noticeably greater than 'ref'
>> + *
>> + * (default: ~5%)
>> + */
>> +#define capacity_greater(cap, ref) ((ref) * 1078 < (cap) * 1024)
>
> nit: can we use cap1 and cap2 and make the implementation use '>' instead of
> '<'? ie:
>
> 	#define capacity_greater(cap1, cap2) ((cap1) * 1024 > (cap2) * 1078)
>
> this is more intuitive to read IMHO. Especially few lines below we have
>
> 	return capacity_greater(ref->sgc->max_capacity, sg->sgc->max_capacity);
>
> which pass 'ref->...' as cap which can be confusing when looking at the
> function signature @ref.
>

Unfortunate naming indeed... And I suppose it can't hurt to follow the
argument "declaration" order. 
