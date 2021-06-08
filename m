Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D1039FDE7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbhFHRln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 13:41:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:36026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232376AbhFHRlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 13:41:42 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE94861287;
        Tue,  8 Jun 2021 17:39:47 +0000 (UTC)
Date:   Tue, 8 Jun 2021 13:39:46 -0400
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
Subject: Re: [PATCH V3 8/9] tracing: Add osnoise tracer
Message-ID: <20210608133946.52eb7859@oasis.local.home>
In-Reply-To: <abf38ca3-3c14-c00a-ff74-f1a75e3ec2e5@redhat.com>
References: <cover.1621024265.git.bristot@redhat.com>
        <bd09a2be9cd0cecee86374dbb49235dd2ef9d750.1621024265.git.bristot@redhat.com>
        <20210604172803.527aa070@oasis.local.home>
        <abf38ca3-3c14-c00a-ff74-f1a75e3ec2e5@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jun 2021 19:17:55 +0200
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> On 6/4/21 11:28 PM, Steven Rostedt wrote:
> >> +	/*
> >> +	 * This is an evidence of race conditions that cause
> >> +	 * a value to be "discounted" too much.
> >> +	 */
> >> +	if (duration < 0)
> >> +		pr_err("int safe negative!\n");  
> > Probably want to have this happen at most once a run. If something were
> > to break, I don't think we want this to live lock the machine doing
> > tons of prints. We could have a variable stored on the
> > osnoise_variables that states this was printed. Check that variable to
> > see if it wasn't printed during a run (when current_tracer was set),
> > and print only once if it is.  
> 
> I created a "bool tainted" variable, that is set true if any problem with time()
> related functions happen. I will pr_warn that there is a problem on _start(),
> but also print this info at the top of the tracer header, so it is clear also
> from the trace output.
> 
> Thoughts?
>

Or perhaps have that pr_err() actually be written into the trace buffer?

You can use

	trace_array_printk_buf(tr->array_buffer.buffer, _THIS_IP_, "string");

without it triggering that nasty trace_printk() notice ;-)

-- Steve
