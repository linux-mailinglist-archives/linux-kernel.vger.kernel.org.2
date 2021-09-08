Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B780403CE6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 17:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349660AbhIHPzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 11:55:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:59578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235546AbhIHPzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 11:55:00 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB4156113D;
        Wed,  8 Sep 2021 15:53:51 +0000 (UTC)
Date:   Wed, 8 Sep 2021 11:53:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] trace/osnoise: Do not use 'main' as variable name
Message-ID: <20210908115350.555941ba@oasis.local.home>
In-Reply-To: <20210908151407.217052-1-linux@roeck-us.net>
References: <20210908151407.217052-1-linux@roeck-us.net>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  8 Sep 2021 08:14:07 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> gcc 11.x may get a hiccup when encountering 'main' as variable name.
> 
> kernel/trace/trace_osnoise.c: In function 'start_kthread':
> kernel/trace/trace_osnoise.c:1515:8: error: 'main' is usually a function
> 
> Use a different variable name to silence it.

Egad, no. NACK! Double NACK. Linus already NACK'd this.

(although it's ironic that he also added -Werror as the default :-/ )

The bug in is in gcc, go send them a patch.

THERE IS NO ISSUE WITH HAVING A LOCAL VARIABLE NAMED "main"!!!!

This has already been discussed:

  https://lore.kernel.org/all/CAHk-=whHxeUjaNrWOLb0qx=-nibRZzQomwkw9xMPH_aHCf=BWQ@mail.gmail.com/

For now, the workaround is this patch:

   https://lore.kernel.org/all/20210813224131.25803-1-rdunlap@infradead.org/


-- Steve


> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  kernel/trace/trace_osnoise.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index 65b08b8e5bf8..7a4c73b4fdcf 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -1512,20 +1512,20 @@ static void stop_per_cpu_kthreads(void)
>  static int start_kthread(unsigned int cpu)
>  {
>  	struct task_struct *kthread;
> -	void *main = osnoise_main;
> +	void *func = osnoise_main;
>  	char comm[24];
>  
>  #ifdef CONFIG_TIMERLAT_TRACER
>  	if (osnoise_data.timerlat_tracer) {
>  		snprintf(comm, 24, "timerlat/%d", cpu);
> -		main = timerlat_main;
> +		func = timerlat_main;
>  	} else {
>  		snprintf(comm, 24, "osnoise/%d", cpu);
>  	}
>  #else
>  	snprintf(comm, 24, "osnoise/%d", cpu);
>  #endif
> -	kthread = kthread_create_on_cpu(main, NULL, cpu, comm);
> +	kthread = kthread_create_on_cpu(func, NULL, cpu, comm);
>  
>  	if (IS_ERR(kthread)) {
>  		pr_err(BANNER "could not start sampling thread\n");

