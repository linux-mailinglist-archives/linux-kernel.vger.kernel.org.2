Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46DD13DA8F6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 18:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhG2Q0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 12:26:47 -0400
Received: from foss.arm.com ([217.140.110.172]:52304 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229614AbhG2Q0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 12:26:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65FA11FB;
        Thu, 29 Jul 2021 09:26:43 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D25093F73D;
        Thu, 29 Jul 2021 09:26:41 -0700 (PDT)
Subject: Re: [PATCH 1/2] sched/deadline: Fix reset_on_fork reporting of DL
 tasks
To:     Quentin Perret <qperret@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20210727101103.2729607-1-qperret@google.com>
 <20210727101103.2729607-2-qperret@google.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <e6d103f1-f8ee-cad9-c7c0-c9ea5d0f099a@arm.com>
Date:   Thu, 29 Jul 2021 18:26:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210727101103.2729607-2-qperret@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2021 12:11, Quentin Perret wrote:
> It is possible for sched_getattr() to incorrectly report the state of
> the reset_on_fork flag when called on a deadline task.
> 
> Indeed, if the flag was set on a deadline task using sched_setattr()
> with flags (SCHED_FLAG_RESET_ON_FORK | SCHED_FLAG_KEEP_PARAMS), then
> p->sched_reset_on_fork will be set, but __setscheduler() will bail out
> early, which means that the dl_se->flags will not get updated by
> __setscheduler_params()->__setparam_dl(). Consequently, if

True, but it would also be awkward if non-DL related flags would have to
be stored in dl_se->flags.

> sched_getattr() is then called on the task, __getparam_dl() will
> override kattr.sched_flags with the now out-of-date copy in dl_se->flags
> and report the stale value to userspace.
> 
> To fix this, make sure to only copy the flags that are relevant to
> sched_deadline to and from the dl_se->flags field.

It also fixes the 'hidden' issue that a

    uclampset -mX -MY -p dl_task

would end up at 'change:' label because of

    dl_se->flags != attr->sched_flags

and not because of

    attr->sched_flags & SCHED_FLAG_UTIL_CLAMP


And it also unblocks the uclamp-dl issue raised in
https://lkml.kernel.org/r/ad30be79-8fb2-023d-9936-01f7173164e4@arm.com
which surfaced when using `get_params()->__getparam_dl()` in
SYSCALL_DEFINE3(sched_setattr,...).
Just for reference, IIRC, you mentioned this already on irc.

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

[...]
