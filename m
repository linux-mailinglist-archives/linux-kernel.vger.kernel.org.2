Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2623AD279
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 21:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbhFRTCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 15:02:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231589AbhFRTCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 15:02:33 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39E25610EA;
        Fri, 18 Jun 2021 19:00:22 +0000 (UTC)
Date:   Fri, 18 Jun 2021 15:00:20 -0400
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
Subject: Re: [PATCH V4 05/12] trace/hwlat: Support hotplug operations
Message-ID: <20210618150020.689439d4@oasis.local.home>
In-Reply-To: <20210618124503.388fe4d4@oasis.local.home>
References: <cover.1623746916.git.bristot@redhat.com>
        <8899f8a8bec38bc600f7a2c61bc6ca664aa7beeb.1623746916.git.bristot@redhat.com>
        <20210618124503.388fe4d4@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2021 12:45:03 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > +/*
> > + * hwlat_cpu_init - CPU hotplug online callback function
> > + */
> > +static int hwlat_cpu_init(unsigned int cpu)
> > +{
> > +	struct trace_array *tr = hwlat_trace;
> > +  
> 
> You need to take the trace_types_lock here, between testing the
> hwlat_busy and starting the threads. Otherwise, between the two, the
> hwlat tracer could be turned off while a CPU is coming on line, and
> then you just started a per cpu thread, while the hwlat tracer is not
> enabled.

And of course, because get_online_cpus() is called within
trace_types_lock, doing this check is going to cause a lock inversion.

The only thing I could think of is to wake up a worker thread to do the
work. That is, this just wakes the worker thread, then the worker grabs
the trace_types_lock, iterates through the cpu mask of expect running
threads, and then starts or kills them depending on the hwlat_busy
value.

-- Steve

> 
> > +	if (!hwlat_busy)
> > +		return 0;
> > +
> > +	if (!cpumask_test_cpu(cpu, tr->tracing_cpumask))
> > +		return 0;
> > +
> > +	return start_cpu_kthread(cpu);
> > +}
