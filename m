Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643993A86AB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 18:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhFOQmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 12:42:08 -0400
Received: from foss.arm.com ([217.140.110.172]:40554 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230081AbhFOQmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:42:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D788413A1;
        Tue, 15 Jun 2021 09:39:55 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 583BD3F694;
        Tue, 15 Jun 2021 09:39:54 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Yafang Shao <laoar.shao@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched, fair: try to prevent migration thread from preempting non-cfs task
In-Reply-To: <CAKfTPtDj6E00o4ZFDJ+kJKqy8J3oLm-mVSajUnHpufFCRiX_8g@mail.gmail.com>
References: <20210615121551.31138-1-laoar.shao@gmail.com> <87mtrrb2jw.mognet@arm.com> <CAKfTPtDj6E00o4ZFDJ+kJKqy8J3oLm-mVSajUnHpufFCRiX_8g@mail.gmail.com>
Date:   Tue, 15 Jun 2021 17:39:52 +0100
Message-ID: <87im2faxpj.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/21 17:45, Vincent Guittot wrote:
> On Tue, 15 Jun 2021 at 16:55, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
>> This can be summarized as in the below, no?
>>
>>                         /*
>>                          * Don't cause a higher-than-CFS task to be preempted by
>>                          * the CPU stopper.
>>                          */
>
> IMO, it's worth keeping the explanation that we are there because:
> - a CFS task that was running during the 1st step :  if
> (busiest->nr_running > 1) { ...
> so we didn't pull the task
> - but it has been preempted while lb was deciding if it needs an
> active load balance
>
> so maybe something like:
>                          /*
>                           * Don't kick the active_load_balance_cpu_stop,
>                           * if the CFS task has been preempted by higher
>                           * priority task in the meantime.
>                          */
>

Ack
