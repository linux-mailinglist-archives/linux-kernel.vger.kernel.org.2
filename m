Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189703D0C57
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 12:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238837AbhGUJf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 05:35:56 -0400
Received: from foss.arm.com ([217.140.110.172]:50472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238515AbhGUJ06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 05:26:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8420531B;
        Wed, 21 Jul 2021 03:07:17 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C851B3F694;
        Wed, 21 Jul 2021 03:07:15 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] sched: Fix UCLAMP_FLAG_IDLE setting
To:     Quentin Perret <qperret@google.com>, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        qais.yousef@arm.com, rickyiu@google.com, wvw@google.com,
        patrick.bellasi@matbug.net, xuewen.yan94@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com
References: <20210719161656.3833943-1-qperret@google.com>
 <20210719161656.3833943-2-qperret@google.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <7ef85d3f-fd2b-a192-07ef-3431b33d06ce@arm.com>
Date:   Wed, 21 Jul 2021 12:07:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210719161656.3833943-2-qperret@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2021 18:16, Quentin Perret wrote:
> The UCLAMP_FLAG_IDLE flag is set on a runqueue when dequeueing the last
> active task to maintain the last uclamp.max and prevent blocked util

s/active/runnable ?

> from suddenly becoming visible.
> 

[...]

IMHO, the main argument in v3 to do the clearing outside
uclamp_rq_inc_id() was a possible order change in `for_each_clamp_id()`.
So setting/clearing `rq->uclamp_flags` (UCLAMP_FLAG_IDLE) on UCLAMP_MAX
(currently the highest Uclamp constraint (UCLAMP_CNT-1)) could be
incorrect when UCLAMP_MIN and UCLAMP_MAX change place because the
same `rq->uclamp_flags` value is needed for both Uclamp constraint
values.

What about decoupling rq->uclamp_flags` handling from UCLAMP_MAX and
doing this for 'UCLAMP_CNT - 1', i.e. always on the highest Uclamp
constraint?

#define for_each_clamp_id(clamp_id) \
    for ((clamp_id) = 0; (clamp_id) < UCLAMP_CNT; (clamp_id)++)

In this case the code change can be as easy as in your original v3.

Setting UCLAMP_FLAG_IDLE in uclamp_idle_value():

  uclamp_rq_dec_id() -> uclamp_rq_max_value() -> *uclamp_idle_value()*

Resetting UCLAMP_FLAG_IDLE in uclamp_idle_reset():

  uclamp_rq_inc_id()                          -> *uclamp_idle_reset()*  

This would be more symmetrical then uclamp_idle_value() and
uclamp_rq_inc()/uclamp_rq_reinc_id().

--8<--

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0c22cd026440..600f68f3378c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1300,15 +1300,16 @@ static inline unsigned int
 uclamp_idle_value(struct rq *rq, enum uclamp_id clamp_id,
 		  unsigned int clamp_value)
 {
+	if (clamp_id == UCLAMP_CNT - 1)
+		rq->uclamp_flags |= UCLAMP_FLAG_IDLE;
+
 	/*
 	 * Avoid blocked utilization pushing up the frequency when we go
 	 * idle (which drops the max-clamp) by retaining the last known
 	 * max-clamp.
 	 */
-	if (clamp_id == UCLAMP_MAX) {
-		rq->uclamp_flags |= UCLAMP_FLAG_IDLE;
+	if (clamp_id == UCLAMP_MAX)
 		return clamp_value;
-	}
 
 	return uclamp_none(UCLAMP_MIN);
 }
@@ -1320,6 +1321,9 @@ static inline void uclamp_idle_reset(struct rq *rq, enum uclamp_id clamp_id,
 	if (!(rq->uclamp_flags & UCLAMP_FLAG_IDLE))
 		return;
 
+	if ((clamp_id == UCLAMP_CNT - 1) && (rq->uclamp_flags & UCLAMP_FLAG_IDLE))
+		rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
+
 	WRITE_ONCE(rq->uclamp[clamp_id].value, clamp_value);
 }
 
@@ -1595,10 +1599,6 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
 
 	for_each_clamp_id(clamp_id)
 		uclamp_rq_inc_id(rq, p, clamp_id);
-
-	/* Reset clamp idle holding when there is one RUNNABLE task */
-	if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
-		rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
 }
