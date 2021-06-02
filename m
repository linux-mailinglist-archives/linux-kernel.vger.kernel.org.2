Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949F3398D90
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 16:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbhFBPAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:00:32 -0400
Received: from foss.arm.com ([217.140.110.172]:47160 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230072AbhFBPAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:00:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 022D912FC;
        Wed,  2 Jun 2021 07:58:48 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BE7A3F719;
        Wed,  2 Jun 2021 07:58:45 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: Fix util_est UTIL_AVG_UNCHANGED handling
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Quentin Perret <qperret@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210514103748.737809-1-dietmar.eggemann@arm.com>
 <20210519160633.GA230499@e120877-lin.cambridge.arm.com>
 <cb72557a-6039-df95-7e25-a7f37d3f9cef@arm.com>
 <CAB8ipk8POOzM2Dut0gcqsgNO0r2585GGv4SG+a1mOmMnrW=Vrw@mail.gmail.com>
 <a8ab9455-a9be-2349-d23a-676aa89fbf2d@arm.com>
 <CAB8ipk93Qux6C4X01oHJRUNumYxR7QbZXWx28DCyUZo8KDvi3A@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <9309950f-1e6b-44ab-4536-678b4ced4f49@arm.com>
Date:   Wed, 2 Jun 2021 16:58:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAB8ipk93Qux6C4X01oHJRUNumYxR7QbZXWx28DCyUZo8KDvi3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/05/2021 08:25, Xuewen Yan wrote:
> On Fri, May 28, 2021 at 6:38 AM Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:
>>
>> On 27/05/2021 07:41, Xuewen Yan wrote:
>>> Hi
>>>
>>> On Wed, May 26, 2021 at 10:59 PM Dietmar Eggemann
>>> <dietmar.eggemann@arm.com> wrote:
>>>>
>>>> On 19/05/2021 18:06, Vincent Donnefort wrote:
>>>>> On Fri, May 14, 2021 at 12:37:48PM +0200, Dietmar Eggemann wrote:

[...]

>>> IMHO, Maybe it would be better to put it in the util_est structure
>>> just like UTIL_EST_WEIGHT_SHIFT?
>>
>> Yeah, can do.
>>
>> I just realized that 'kernel/sched/pelt.h' does not include
>> <linux/sched.h> directly (or indirectly via "sched.h". But I can easily
>> move cfs_se_util_change() (which uses UTIL_AVG_UNCHANGED) from pelt.h to
>> pelt.c, its only consumer anyway.
> 
> Since there are so many questions, why not add ( #include "pelt.h" )
> directly into (kernel/sched/debug.c)?
> 
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 9c882f20803e..dde91171d4ae 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -7,6 +7,7 @@
>   * Copyright(C) 2007, Red Hat, Inc., Ingo Molnar
>   */
>  #include "sched.h"
> +#include "pelt.h"

Didn't want to expose PELT internals unnecessarily.

And ... turns out that the include dependency `"sched.h" before
"pelt.h"` exists for much more things than just UTIL_AVG_UNCHANGED. So I
think I don't have to care about the issue in this case.

I sent out a v2 addressing your comment.
