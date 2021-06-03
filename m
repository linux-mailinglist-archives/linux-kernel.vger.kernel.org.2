Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226F039AC9B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 23:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhFCVTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 17:19:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229963AbhFCVTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 17:19:46 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A9DF6139A;
        Thu,  3 Jun 2021 21:18:00 +0000 (UTC)
Date:   Thu, 3 Jun 2021 17:17:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kate Carcia <kcarcia@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH V3 4/9] tracing/hwlat: Implement the per-cpu mode
Message-ID: <20210603171758.48da3357@gandalf.local.home>
In-Reply-To: <187db3f9eed1603c858a1f7669d0140dfb753bfd.1621024265.git.bristot@redhat.com>
References: <cover.1621024265.git.bristot@redhat.com>
        <187db3f9eed1603c858a1f7669d0140dfb753bfd.1621024265.git.bristot@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2021 22:51:13 +0200
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

>  void trace_hwlat_callback(bool enter)
>  {
> -	if (smp_processor_id() != nmi_cpu)
> +	struct hwlat_kthread_data *kdata = get_cpu_data();
> +
> +	if (kdata->kthread)

Shouldn't that be:

	if (!kdata->kthread)

?

-- Steve

>  		return;
>  
>  	/*
> @@ -158,13 +173,13 @@ void trace_hwlat_callback(bool enter)
>  	 */
>  	if (!IS_ENABLED(CONFIG_GENERIC_SCHED_CLOCK)) {
>  		if (enter)
> -			nmi_ts_start = time_get();
> +			kdata->nmi_ts_start = time_get();
>  		else
> -			nmi_total_ts += time_get() - nmi_ts_start;
> +			kdata->nmi_total_ts += time_get() - kdata->nmi_ts_start;
>  	}
>  
>  	if (enter)
> -		nmi_count++;
> +		kdata->nmi_count++;
>  }
> 
