Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61903B8501
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 16:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235102AbhF3O1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 10:27:19 -0400
Received: from foss.arm.com ([217.140.110.172]:39576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234913AbhF3O1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 10:27:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA1C16D;
        Wed, 30 Jun 2021 07:24:48 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0AEC3F718;
        Wed, 30 Jun 2021 07:24:46 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Xuewen Yan <xuewen.yan94@gmail.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com
Cc:     rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        patrick.bellasi@matbug.net, qais.yousef@arm.com, qperret@google.com
Subject: Re: [PATCH v2] sched/uclamp: Avoid getting unreasonable ucalmp value when rq is idle
In-Reply-To: <20210630141204.8197-1-xuewen.yan94@gmail.com>
References: <20210630141204.8197-1-xuewen.yan94@gmail.com>
Date:   Wed, 30 Jun 2021 15:24:42 +0100
Message-ID: <87a6n78m6t.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On the subject: s/ucalmp/uclamp/

On 30/06/21 22:12, Xuewen Yan wrote:
> From: Xuewen Yan <xuewen.yan@unisoc.com>
>
> Now in uclamp_rq_util_with(), when the task != NULL, the uclamp_max as following:
> uc_rq_max = rq->uclamp[UCLAMP_MAX].value;
> uc_eff_max = uclamp_eff_value(p, UCLAMP_MAX);
> uclamp_max = max{uc_rq_max, uc_eff_max};
>
> Consider the following scenario:
> (1)the rq is idle, the uc_rq_max is last runnable task's UCLAMP_MAX;
> (2)the p's uc_eff_max < uc_rq_max.
>
> As a result, the uclamp_max = uc_rq_max instead of uc_eff_max, it is unreasonable.
>
> The scenario often happens in find_energy_efficient_cpu(), when the task has smaller UCLAMP_MAX.
>
> When rq has UCLAMP_FLAG_IDLE flag, enqueuing the task will lift UCLAMP_FLAG_IDLE
> and set the rq clamp as the task's via uclamp_idle_reset(). It doesn't need
> to read the rq clamp. And it can also avoid the problems described above.
>
> Fixes: 9d20ad7dfc9a ("sched/uclamp: Add uclamp_util_with()")
>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
>

Thanks!

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
