Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB87401AD0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 13:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240013AbhIFL5w convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Sep 2021 07:57:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229648AbhIFL5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 07:57:51 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B58960F43;
        Mon,  6 Sep 2021 11:56:46 +0000 (UTC)
Date:   Mon, 6 Sep 2021 07:56:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jackie Liu <liu.yun@linux.dev>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trace_osnoise: rename main to trace_main to avoid
 Werror=main
Message-ID: <20210906075644.1b8ded67@rorschach.local.home>
In-Reply-To: <20210906094003.948975-1-liu.yun@linux.dev>
References: <20210906094003.948975-1-liu.yun@linux.dev>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  6 Sep 2021 17:40:03 +0800
Jackie Liu <liu.yun@linux.dev> wrote:

> From: Jackie Liu <liuyun01@kylinos.cn>
> 
> kernel builds with -Werror=main, gcc report failed.
> 
> Avoids warnings like:
> kernel/trace/trace_osnoise.c:1515:8: error: ‘main’ is usually a function [-Werror=main]

NACK!

It's a stupid warning, and likely a bug in the compiler.

There's nothing wrong with using "main" as a local variable. It will
*never* conflict with the main main. Less so in the kernel, as the
kernel doesn't even have a main!

Do not send patches to fix this "error".

Not to mention, we already went through this discussion a month ago.

  https://lore.kernel.org/all/20210813224131.25803-1-rdunlap@infradead.org/

-- Steve

> 
> Fixes: a955d7eac177 ("trace: Add timerlat tracer")
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>  kernel/trace/trace_osnoise.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index b61eefe5ccf5..938e2791010a 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -1512,20 +1512,20 @@ static void stop_per_cpu_kthreads(void)
>  static int start_kthread(unsigned int cpu)
>  {
>  	struct task_struct *kthread;
> -	void *main = osnoise_main;
> +	void *trace_main = osnoise_main;
>  	char comm[24];
>  
>  #ifdef CONFIG_TIMERLAT_TRACER
>  	if (osnoise_data.timerlat_tracer) {
>  		snprintf(comm, 24, "timerlat/%d", cpu);
> -		main = timerlat_main;
> +		trace_main = timerlat_main;
>  	} else {
>  		snprintf(comm, 24, "osnoise/%d", cpu);
>  	}
>  #else
>  	snprintf(comm, 24, "osnoise/%d", cpu);
>  #endif
> -	kthread = kthread_create_on_cpu(main, NULL, cpu, comm);
> +	kthread = kthread_create_on_cpu(trace_main, NULL, cpu, comm);
>  
>  	if (IS_ERR(kthread)) {
>  		pr_err(BANNER "could not start sampling thread\n");

