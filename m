Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0130738FEEC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 12:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhEYKVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 06:21:09 -0400
Received: from foss.arm.com ([217.140.110.172]:54306 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229597AbhEYKVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 06:21:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70180D6E;
        Tue, 25 May 2021 03:19:38 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F74D3F719;
        Tue, 25 May 2021 03:19:37 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>, peterz@infradead.org,
        vincent.donnefort@arm.com, mingo@kernel.org, bristot@redhat.com,
        npiggin@gmail.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpu/hotplug: simplify access percpu cpuhp_state
In-Reply-To: <1621776690-13264-1-git-send-email-yuanzhaoxiong@baidu.com>
References: <1621776690-13264-1-git-send-email-yuanzhaoxiong@baidu.com>
Date:   Tue, 25 May 2021 11:19:27 +0100
Message-ID: <87k0nnglow.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/21 21:31, Yuan ZhaoXiong wrote:
> It is unnecessary to invoke per_cpu_ptr() function everytime to access
> percpu cpuhp_state and use the variable st instead.
>
> Signed-off-by: Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

> ---
>  kernel/cpu.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index e538518..2942cb4 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -961,7 +961,7 @@ static int takedown_cpu(unsigned int cpu)
>       int err;
>
>       /* Park the smpboot threads */
> -	kthread_park(per_cpu_ptr(&cpuhp_state, cpu)->thread);
> +	kthread_park(st->thread);
>
>       /*
>        * Prevent irq alloc/free while the dying cpu reorganizes the
> @@ -977,7 +977,7 @@ static int takedown_cpu(unsigned int cpu)
>               /* CPU refused to die */
>               irq_unlock_sparse();
>               /* Unpark the hotplug thread so we can rollback there */
> -		kthread_unpark(per_cpu_ptr(&cpuhp_state, cpu)->thread);
> +		kthread_unpark(st->thread);
>               return err;
>       }
>       BUG_ON(cpu_online(cpu));
> --
> 1.7.1
