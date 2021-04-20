Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFBB365B86
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 16:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbhDTOzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 10:55:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232504AbhDTOzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 10:55:46 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 895B0613CA;
        Tue, 20 Apr 2021 14:55:13 +0000 (UTC)
Date:   Tue, 20 Apr 2021 10:55:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        fweisbec <fweisbec@gmail.com>, Jessica Yu <jeyu@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>, chris@chris-wilson.co.uk,
        yuanhan liu <yuanhan.liu@linux.intel.com>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Subject: Re: [PATCH][RFC] tracing: Enable tracepoints via module parameters
Message-ID: <20210420105511.65490e8d@gandalf.local.home>
In-Reply-To: <1154727029.2004.1618925367044.JavaMail.zimbra@efficios.com>
References: <1299622684.20306.77.camel@gandalf.stny.rr.com>
        <20130813111442.632f3421@gandalf.local.home>
        <87siybk8yl.fsf@rustcorp.com.au>
        <20130814233228.778f25d0@gandalf.local.home>
        <77a6e40b57df092d1bd8967305906a210f286111.camel@intel.com>
        <20210419181111.5eb582e8@gandalf.local.home>
        <CAPcyv4gw7KoL8U66LLx_DVAE+5Jguz7tb3Rax-bdTz4BrpwhvQ@mail.gmail.com>
        <20210420085532.4062b15e@gandalf.local.home>
        <1154727029.2004.1618925367044.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Apr 2021 09:29:27 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> ----- On Apr 20, 2021, at 8:55 AM, rostedt rostedt@goodmis.org wrote:
> [...]
> > 
> > Would adding automatic module parameters be an issue? That is, you can add
> > in the insmod command line a parameter that will enable tracepoints. We
> > could have a way to even see them from the modinfo. I think I had that
> > working once, and it wasn't really that hard to do.  
> 
> There is one thing we should consider here in terms of namespacing: those module
> command line parameters should be specific to each tracer (e.g. ftrace, perf, ebpf).
> 
> LTTng for instance already tackles early module load tracing in a different
> way: users can enable instrumentation of yet-to-be loaded kernel modules. So
> it would not make sense in that scheme to have module load parameters.
> 
> It's a different trade-off in terms of error reporting though: for instance,
> LTTng won't report an error if a user does a typo when entering an event name.
> 
> So I think those command line parameters should be tracer-specific, do you agree ?


No, I do not agree. I would like to make it consistent with the kernel
command line. As you can put in: "trace_event=sched_switch" and the
sched_switch trace point will be enable (for the tracefs directory) on boot
up. The same should be for modules as well.

It shouldn't affect LTTng, as you already have a way to enable them as they
get loaded.

-- Steve
