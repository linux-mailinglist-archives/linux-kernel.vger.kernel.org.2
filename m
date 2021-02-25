Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390BC324F63
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 12:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbhBYLre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 06:47:34 -0500
Received: from foss.arm.com ([217.140.110.172]:55646 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232778AbhBYLr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 06:47:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF107D6E;
        Thu, 25 Feb 2021 03:46:41 -0800 (PST)
Received: from [192.168.1.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 504733F73D;
        Thu, 25 Feb 2021 03:46:40 -0800 (PST)
Subject: Re: [PATCH v2 2/2] sched/fair: use lsub_positive in cpu_util_next()
To:     vincent.donnefort@arm.com, peterz@infradead.org, mingo@redhat.com,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, qperret@google.com,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com
References: <20210225083612.1113823-1-vincent.donnefort@arm.com>
 <20210225083612.1113823-3-vincent.donnefort@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <6bf917f3-1581-25ca-1330-3084194a4973@arm.com>
Date:   Thu, 25 Feb 2021 12:46:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210225083612.1113823-3-vincent.donnefort@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/02/2021 09:36, vincent.donnefort@arm.com wrote:
> From: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> The sub_positive local version is saving an explicit load-store and is
> enough for the cpu_util_next() usage.
> 
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 146ac9fec4b6..1364f8b95214 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6525,7 +6525,7 @@ static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
>  	 * util_avg should already be correct.
>  	 */
>  	if (task_cpu(p) == cpu && dst_cpu != cpu)
> -		sub_positive(&util, task_util(p));
> +		lsub_positive(&util, task_util(p));
>  	else if (task_cpu(p) != cpu && dst_cpu == cpu)
>  		util += task_util(p);

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

