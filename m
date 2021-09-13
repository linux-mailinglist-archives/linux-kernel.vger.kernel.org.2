Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0AF14096A9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 16:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346013AbhIMPA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 11:00:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346443AbhIMO7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 10:59:18 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C70F60F36;
        Mon, 13 Sep 2021 14:58:02 +0000 (UTC)
Date:   Mon, 13 Sep 2021 10:58:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tang Yizhou <tangyizhou@huawei.com>
Cc:     <bristot@redhat.com>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] trace: Do some cleanups for osnoise tracer
Message-ID: <20210913105800.77699437@oasis.local.home>
In-Reply-To: <20210913033206.23682-1-tangyizhou@huawei.com>
References: <20210913033206.23682-1-tangyizhou@huawei.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2021 11:32:06 +0800
Tang Yizhou <tangyizhou@huawei.com> wrote:

> 1. Add 'static' and 'const' qualifier when necessary.
> 2. Use DEFINE_MUTEX() to define a mutex.
> 
> Signed-off-by: Tang Yizhou <tangyizhou@huawei.com>
> ---
>  kernel/trace/trace_osnoise.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index ce053619f289..c1a8dc6a154e 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -105,7 +105,7 @@ struct osnoise_variables {
>  /*
>   * Per-cpu runtime information.
>   */
> -DEFINE_PER_CPU(struct osnoise_variables, per_cpu_osnoise_var);
> +static DEFINE_PER_CPU(struct osnoise_variables, per_cpu_osnoise_var);
>  
>  /*
>   * this_cpu_osn_var - Return the per-cpu osnoise_variables on its relative CPU
> @@ -128,7 +128,7 @@ struct timerlat_variables {
>  	u64			count;
>  };
>  
> -DEFINE_PER_CPU(struct timerlat_variables, per_cpu_timerlat_var);
> +static DEFINE_PER_CPU(struct timerlat_variables, per_cpu_timerlat_var);
>  
>  /*
>   * this_cpu_tmr_var - Return the per-cpu timerlat_variables on its relative CPU
> @@ -220,7 +220,7 @@ struct timerlat_sample {
>  /*
>   * Protect the interface.
>   */
> -struct mutex interface_lock;
> +static DEFINE_MUTEX(interface_lock);
>  
>  /*
>   * Tracer data.
> @@ -1818,8 +1818,8 @@ static struct trace_min_max_param osnoise_print_stack = {
>  /*
>   * osnoise/timerlat_period: min 100 us, max 1 s
>   */
> -u64 timerlat_min_period = 100;
> -u64 timerlat_max_period = 1000000;
> +static const u64 timerlat_min_period = 100;
> +static const u64 timerlat_max_period = 1000000;

Can't be const because it can be modified.

-- Steve

>  static struct trace_min_max_param timerlat_period = {
>  	.lock	= &interface_lock,
>  	.val	= &osnoise_data.timerlat_period,
> @@ -2087,8 +2087,6 @@ __init static int init_osnoise_tracer(void)
>  {
>  	int ret;
>  
> -	mutex_init(&interface_lock);
> -
>  	cpumask_copy(&osnoise_cpumask, cpu_all_mask);
>  
>  	ret = register_tracer(&osnoise_tracer);

