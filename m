Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8DD395636
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 09:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhEaHg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 03:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbhEaHf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 03:35:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A4FC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 00:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=rWh9/tjYcLUEB9pMPWZlpHKCGYzTJGX5um6P0ZNJCZI=; b=kmypJBIyM4dl3IY4K696bBASfi
        vQY1yIzEAJjQ6c766lf5FaqcdCOk4ojsoqFWuJMPfFoUCd0DsIT86ezLlISMq7GGIMNJ4QSzBfAkj
        Ol5at2QY2LEYPSMQe070nU9Rx5J5xi2XDM8QRQlNrQEPrKe3cAxUPN3wg9omBM/F7yBJV2S8+c2ge
        xJyU/76doHNTYXmB4LSIfGtS9Pjx0UFfB7J1Teg8lsmP4waLUh4tXKFOl4us2WHYgBvs6UPnuNoh2
        FeMsb7m1i9si4SSlapXhWZ6hpS7u9DmmJgvxh8k23ZUyYUE3ECpIuQuHPctveDpkggw91SlrD3lJL
        9TXl918A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lncQq-002Dq6-6x; Mon, 31 May 2021 07:33:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F3521300268;
        Mon, 31 May 2021 09:33:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B16B42011C43B; Mon, 31 May 2021 09:33:57 +0200 (CEST)
Date:   Mon, 31 May 2021 09:33:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bixuan Cui <cuibixuan@huawei.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] sched: make sched_set_stop_task() static
Message-ID: <YLSRZa0L79P+eSxk@hirez.programming.kicks-ass.net>
References: <20210529022956.43858-1-cuibixuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210529022956.43858-1-cuibixuan@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2021 at 10:29:56AM +0800, Bixuan Cui wrote:
> make W=1 generates the following warning for kernel/sched/core.c:
> warning: no previous prototype for ‘sched_set_stop_task’ [-Wmissing-prototypes]
> 
> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
> ---
>  kernel/sched/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index adea0b1e8036..1c1e9612018b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3209,7 +3209,7 @@ int select_task_rq(struct task_struct *p, int cpu, int wake_flags)
>  	return cpu;
>  }
>  
> -void sched_set_stop_task(int cpu, struct task_struct *stop)
> +static void sched_set_stop_task(int cpu, struct task_struct *stop)
>  {
>  	static struct lock_class_key stop_pi_lock;
>  	struct sched_param param = { .sched_priority = MAX_RT_PRIO - 1 };

Clearly you tested this well...

$ git grep sched_set_stop_task
kernel/sched/core.c:void sched_set_stop_task(int cpu, struct task_struct *stop)
kernel/stop_machine.c:extern void sched_set_stop_task(int cpu, struct task_struct *stop);
kernel/stop_machine.c:  sched_set_stop_task(cpu, per_cpu(cpu_stopper.thread, cpu));

Please be more careful.
