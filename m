Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FBA3DF055
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 16:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbhHCOcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 10:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbhHCOcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 10:32:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71948C061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 07:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=dICe99PNKdaCBWC/I/hc70xHtOGdVUaGzA6/fyx1sJ4=; b=p1SVWUtwKhGmckwRMxl7JSMG9j
        MILC+HtsQxXnnBUMank9DEr9+6jbgGZB1c6gMoD0aWmS3Amin2Kuw0QREM802MCZsFGSYyz4+JZV3
        wDeDf32CWRXV57FNtvQzcaQnt86hAiJ/+KAB1eCmmkdFMEQCQzZgywc8wOYoDf9qY2TuLliAT0zUg
        UvEIlXrkjNoWndvGw7LqU8n44s7Yy6He6b/zkVQMDOh+53YZW83WWOgz/Bavsr97Z5s8becQnak/T
        k+dTtQBL29QbdFgJdMsM5iMWjljgH4h3WuvnR9VOSj/r9qK3udBOyojb70ybgVyPYN49EGtFEHkTc
        Uu804ldA==;
Received: from [2601:1c0:6280:3f0:e65e:37ff:febd:ee53]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mAvRr-004loT-7U; Tue, 03 Aug 2021 14:31:25 +0000
Subject: Re: [PATCH] trace/osnoise: Rename main variable to tracer_main
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
References: <fc62f7deb2258f6068d77c3e734633e3c3511464.1627977494.git.bristot@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b4cbe5a3-c76f-4fc0-4cf6-1d6ff729b971@infradead.org>
Date:   Tue, 3 Aug 2021 07:31:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <fc62f7deb2258f6068d77c3e734633e3c3511464.1627977494.git.bristot@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/21 1:28 AM, Daniel Bristot de Oliveira wrote:
> The *main variable in start_kthread() is causing warnings in some
> compilers/analyzers. Although it is not necessarily a problem, it is
> not a problem changing the variable name too.
> 
> Rename the *main variable to *tracer_main.
> 
> No functional change.
> 
> Fixes: c8895e271f79 ("trace/osnoise: Support hotplug operations")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>   kernel/trace/trace_osnoise.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index 0b11db9595b6..eda10d39da47 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -1576,20 +1576,20 @@ static void stop_per_cpu_kthreads(void)
>   static int start_kthread(unsigned int cpu)
>   {
>   	struct task_struct *kthread;
> -	void *main = osnoise_main;
> +	void *tracer_main = osnoise_main;
>   	char comm[24];
>   
>   #ifdef CONFIG_TIMERLAT_TRACER
>   	if (osnoise_data.timerlat_tracer) {
>   		snprintf(comm, 24, "timerlat/%d", cpu);
> -		main = timerlat_main;
> +		tracer_main = timerlat_main;
>   	} else {
>   		snprintf(comm, 24, "osnoise/%d", cpu);
>   	}
>   #else
>   	snprintf(comm, 24, "osnoise/%d", cpu);
>   #endif
> -	kthread = kthread_create_on_cpu(main, NULL, cpu, comm);
> +	kthread = kthread_create_on_cpu(tracer_main, NULL, cpu, comm);
>   
>   	if (IS_ERR(kthread)) {
>   		pr_err(BANNER "could not start sampling thread\n");
> 


-- 
~Randy

