Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410C83B38DD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 23:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbhFXVl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 17:41:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:54004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232029AbhFXVlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 17:41:25 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDB6C613A9;
        Thu, 24 Jun 2021 21:39:03 +0000 (UTC)
Date:   Thu, 24 Jun 2021 17:39:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Phil Auld <pauld@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kate Carcia <kcarcia@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 12/14] trace: Protect tr->tracing_cpumask with
 get/put_online_cpus
Message-ID: <20210624173902.57f4f34f@oasis.local.home>
In-Reply-To: <38d2ef13b33c42fcf424a6213a27c8b5246548e0.1624372313.git.bristot@redhat.com>
References: <cover.1624372313.git.bristot@redhat.com>
        <38d2ef13b33c42fcf424a6213a27c8b5246548e0.1624372313.git.bristot@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jun 2021 16:42:30 +0200
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 52fc9438b7b4..c14f33db147e 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -5053,7 +5053,13 @@ int tracing_set_cpumask(struct trace_array *tr,
>  	arch_spin_unlock(&tr->max_lock);
>  	local_irq_enable();
>  
> +	/*
> +	 * tracing_cpumask is read by tracers that support CPU
> +	 * hotplug.
> +	 */
> +	get_online_cpus();
>  	cpumask_copy(tr->tracing_cpumask, tracing_cpumask_new);
> +	put_online_cpus();
>  
>  	return 0;

Hmm, the tracing_cpumask is only touched in he work function, with the
necessary locks. How is get_online_cpus() protecting it here?

That is, tracing_cpumask isn't touched in the path of bringing up or
taking down a CPU, and shouldn't be an issue here.

Should I just drop this patch?

-- Steve
