Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7050A3150B9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 14:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhBINri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 08:47:38 -0500
Received: from foss.arm.com ([217.140.110.172]:51872 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231596AbhBINpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 08:45:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC68FED1;
        Tue,  9 Feb 2021 05:44:50 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D9183F73D;
        Tue,  9 Feb 2021 05:44:48 -0800 (PST)
Subject: Re: [PATCH 1/6] sched/fair: remove update of blocked load from
 newidle_balance
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, fweisbec@gmail.com,
        tglx@linutronix.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org
Cc:     qais.yousef@arm.com
References: <20210205114830.781-1-vincent.guittot@linaro.org>
 <20210205114830.781-2-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <8cea2836-aedd-0925-4359-a04c8e8729e6@arm.com>
Date:   Tue, 9 Feb 2021 14:44:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210205114830.781-2-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/2021 12:48, Vincent Guittot wrote:
> newidle_balance runs with both preempt and irq disabled which prevent
> local irq to run during this period. The duration for updating of the
> blocked load of CPUs varies according to the number of cgroups and

Maybe s/number of cgroups/number of CPU cgroups with non-decayed
cfs_rq's (i.e. cfs_rq within the leaf cfs_rq list)

> extends this critical period to an uncontrolled level.
> 
> Remove the update from newidle_balance and trigger a normal ILB that
> will take care of the update instead.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

otherwise, LGTM.

[...]
