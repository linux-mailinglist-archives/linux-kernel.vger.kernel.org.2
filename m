Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C0535581D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 17:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbhDFPgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 11:36:52 -0400
Received: from foss.arm.com ([217.140.110.172]:44886 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232431AbhDFPgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:36:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC7B51FB;
        Tue,  6 Apr 2021 08:36:41 -0700 (PDT)
Received: from [192.168.1.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF02D3F792;
        Tue,  6 Apr 2021 08:36:39 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] sched/fair: Clean up active balance
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
References: <20210401193006.3392788-1-valentin.schneider@arm.com>
 <20210401193006.3392788-3-valentin.schneider@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <eed905d1-b1d8-6184-1fff-044860e17c4b@arm.com>
Date:   Tue, 6 Apr 2021 17:36:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210401193006.3392788-3-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2021 21:30, Valentin Schneider wrote:
> When triggering an active load balance, sd->nr_balance_failed is set to
> such a value that any further can_migrate_task() using said sd will ignore
> the output of task_hot().
> 
> This behaviour makes sense, as active load balance intentionally preempts a
> rq's running task to migrate it right away, but this asynchronous write is
> a bit shoddy, as the stopper thread might run active_load_balance_cpu_stop
> before the sd->nr_balance_failed write either becomes visible to the
> stopper's CPU or even happens on the CPU that appended the stopper work.
> 
> Add a struct lb_env flag to denote active balancing, and use it in
> can_migrate_task(). Remove the sd->nr_balance_failed write that served the
> same purpose. Cleanup the LBF_DST_PINNED active balance special case.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

[...]
