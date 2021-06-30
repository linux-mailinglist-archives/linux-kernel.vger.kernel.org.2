Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528973B86B7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 18:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235980AbhF3QEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 12:04:30 -0400
Received: from foss.arm.com ([217.140.110.172]:41706 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235822AbhF3QE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 12:04:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 899B9106F;
        Wed, 30 Jun 2021 09:02:00 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C1083F718;
        Wed, 30 Jun 2021 09:01:59 -0700 (PDT)
Date:   Wed, 30 Jun 2021 17:01:56 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rickyiu@google.com, wvw@google.com,
        patrick.bellasi@matbug.net, xuewen.yan94@gmail.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 2/3] sched: Skip priority checks with
 SCHED_FLAG_KEEP_PARAMS
Message-ID: <20210630160156.wemzedjg6wuaw7zw@e107158-lin.cambridge.arm.com>
References: <20210623123441.592348-1-qperret@google.com>
 <20210623123441.592348-3-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210623123441.592348-3-qperret@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/23/21 12:34, Quentin Perret wrote:
> SCHED_FLAG_KEEP_PARAMS can be passed to sched_setattr to specify that
> the call must not touch scheduling parameters (nice or priority). This
> is particularly handy for uclamp when used in conjunction with
> SCHED_FLAG_KEEP_POLICY as that allows to issue a syscall that only
> impacts uclamp values.
> 
> However, sched_setattr always checks whether the priorities and nice
> values passed in sched_attr are valid first, even if those never get
> used down the line. This is useless at best since userspace can
> trivially bypass this check to set the uclamp values by specifying low
> priorities. However, it is cumbersome to do so as there is no single
> expression of this that skips both RT and CFS checks at once. As such,
> userspace needs to query the task policy first with e.g. sched_getattr
> and then set sched_attr.sched_priority accordingly. This is racy and
> slower than a single call.
> 
> As the priority and nice checks are useless when SCHED_FLAG_KEEP_PARAMS
> is specified, simply inherit them in this case to match the policy
> inheritance of SCHED_FLAG_KEEP_POLICY.
> 
> Reported-by: Wei Wang <wvw@google.com>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---

LGTM.

Reviewed-by: Qais Yousef <qais.yousef@arm.com>

Cheers

--
Qais Yousef
