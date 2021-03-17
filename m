Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3405233EED8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 11:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhCQKwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 06:52:34 -0400
Received: from foss.arm.com ([217.140.110.172]:56958 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230439AbhCQKwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:52:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C535DD6E;
        Wed, 17 Mar 2021 03:52:13 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F14463F70D;
        Wed, 17 Mar 2021 03:52:11 -0700 (PDT)
Subject: Re: [PATCH v3 2/7] sched/fair: Clean up active balance
 nr_balance_failed trickery
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>
References: <20210311120527.167870-1-valentin.schneider@arm.com>
 <20210311120527.167870-3-valentin.schneider@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <76133a77-3098-5bb4-cdae-060d2e4b93c9@arm.com>
Date:   Wed, 17 Mar 2021 11:52:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210311120527.167870-3-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2021 13:05, Valentin Schneider wrote:

[...]

> @@ -9952,7 +9954,8 @@ static int active_load_balance_cpu_stop(void *data)
>  			 * @dst_grpmask we need to make that test go away with lying
>  			 * about DST_PINNED.
>  			 */
> -			.flags		= LBF_DST_PINNED,
> +			.flags		= LBF_DST_PINNED |
> +					  LBF_ACTIVE_LB,

Since you now have a dedicated LBF flag for active balancing you could remove the
LBF_DST_PINNED here and adapt the if condition in can_migrate_task():

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f50a902bdf24..9f7feb512016 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7583,10 +7583,13 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
                 * meet load balance goals by pulling other tasks on src_cpu.
                 *
                 * Avoid computing new_dst_cpu for NEWLY_IDLE or if we have
-                * already computed one in current iteration.
+                * already computed one in current iteration or if it is an
+                * active balance.
                 */
-               if (env->idle == CPU_NEWLY_IDLE || (env->flags & LBF_DST_PINNED))
+               if (env->idle == CPU_NEWLY_IDLE ||
+                   (env->flags & (LBF_DST_PINNED | LBF_ACTIVE_LB))) {
                        return 0;
+               }
 
                /* Prevent to re-select dst_cpu via env's CPUs: */
                for_each_cpu_and(cpu, env->dst_grpmask, env->cpus) {
@@ -9948,14 +9951,7 @@ static int active_load_balance_cpu_stop(void *data)
                        .src_cpu        = busiest_rq->cpu,
                        .src_rq         = busiest_rq,
                        .idle           = CPU_IDLE,
-                       /*
-                        * can_migrate_task() doesn't need to compute new_dst_cpu
-                        * for active balancing. Since we have CPU_IDLE, but no
-                        * @dst_grpmask we need to make that test go away with lying
-                        * about DST_PINNED.
-                        */
-                       .flags          = LBF_DST_PINNED |
-                                         LBF_ACTIVE_LB,
+                       .flags          = LBF_ACTIVE_LB,
                };
