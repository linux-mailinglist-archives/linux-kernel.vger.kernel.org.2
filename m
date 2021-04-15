Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B3A360BD4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 16:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbhDOOcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 10:32:41 -0400
Received: from foss.arm.com ([217.140.110.172]:47592 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233037AbhDOOci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 10:32:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B362106F;
        Thu, 15 Apr 2021 07:32:15 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4E293FA45;
        Thu, 15 Apr 2021 07:32:13 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, bigeasy@linutronix.de,
        swood@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, qais.yousef@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] sched: Use cpu_dying() to fix balance_push vs hotplug-rollback
In-Reply-To: <YHgAYef83VQhKdC2@hirez.programming.kicks-ass.net>
References: <20210310145258.899619710@infradead.org> <20210310150109.259726371@infradead.org> <871rclu3jz.mognet@e113632-lin.i-did-not-set--mail-host-address--so-tickle-me> <YHQ3Iy7QfL+0UoM0@hirez.programming.kicks-ass.net> <87r1jfmn8d.mognet@arm.com> <YHU/a9HvGLYpOLKZ@hirez.programming.kicks-ass.net> <YHgAYef83VQhKdC2@hirez.programming.kicks-ass.net>
Date:   Thu, 15 Apr 2021 15:32:11 +0100
Message-ID: <87a6pzmxec.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/21 10:59, Peter Zijlstra wrote:
> Can't make sense of what I did.. I've removed that hunk. Patch now looks
> like this.
>

Small nit below, but regardless feel free to apply to the whole lot:
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

@VincentD, ISTR you had tested the initial version of this with your fancy
shmancy hotplug rollback stresser. Feel like doing this

> So instead, make sure balance_push is enabled between
> sched_cpu_deactivate() and sched_cpu_activate() (eg. when
> !cpu_active()), and gate it's utility with cpu_dying().

I'd word that "is enabled below sched_cpu_activate()", since
sched_cpu_deactivate() is now out of the picture.

[...]
> @@ -7639,6 +7639,9 @@ static DEFINE_PER_CPU(struct cpu_stop_wo
>
>  /*
>   * Ensure we only run per-cpu kthreads once the CPU goes !active.
> + *
> + * This is active/set between sched_cpu_deactivate() / sched_cpu_activate().

Ditto

> + * But only effective when the hotplug motion is down.
>   */
>  static void balance_push(struct rq *rq)
>  {
