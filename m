Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3228F365953
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 14:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbhDTM4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 08:56:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231393AbhDTM4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 08:56:06 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4C6E613C8;
        Tue, 20 Apr 2021 12:55:33 +0000 (UTC)
Date:   Tue, 20 Apr 2021 08:55:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "fweisbec@gmail.com" <fweisbec@gmail.com>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@elte.hu" <mingo@elte.hu>,
        "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>,
        "yuanhan.liu@linux.intel.com" <yuanhan.liu@linux.intel.com>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Subject: Re: [PATCH][RFC] tracing: Enable tracepoints via module parameters
Message-ID: <20210420085532.4062b15e@gandalf.local.home>
In-Reply-To: <CAPcyv4gw7KoL8U66LLx_DVAE+5Jguz7tb3Rax-bdTz4BrpwhvQ@mail.gmail.com>
References: <1299622684.20306.77.camel@gandalf.stny.rr.com>
        <877hc64klm.fsf@rustcorp.com.au>
        <20130813111442.632f3421@gandalf.local.home>
        <87siybk8yl.fsf@rustcorp.com.au>
        <20130814233228.778f25d0@gandalf.local.home>
        <77a6e40b57df092d1bd8967305906a210f286111.camel@intel.com>
        <20210419181111.5eb582e8@gandalf.local.home>
        <CAPcyv4gw7KoL8U66LLx_DVAE+5Jguz7tb3Rax-bdTz4BrpwhvQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2021 18:25:54 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> On Mon, Apr 19, 2021 at 3:11 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Mon, 19 Apr 2021 21:54:13 +0000
> > "Williams, Dan J" <dan.j.williams@intel.com> wrote:
> >  
> > > [ drop Rusty, add Jessica and Emmanuel ]  
> >
> > Probably could have kept Jessica on as she's the module maintainer.  
> 
> Oh, you misread, I swapped out Rusty for Jessica on the Cc.

Ah, I read that as "Rusty and Jessica".



> > So yes, function tracing now allows setting a filter to trace only the
> > functions for a given module, and if that module is not yet loaded, it
> > stores the filter until it is.  
> 
> Ah, thanks for the pointer. So if I wanted to convert a kernel command like:
> 
> libnvdimm.dyndbg
> 
> ...it would be something like:
> 
> ftrace=function ftrace_filter=:mod:libnvdimm

Hmm, that may not work, but if it doesn't, it would be trivial to add it.

> 
> ...and then "cat /sys/kernel/tracing/trace" instead of "dmesg" to
> retrieve... assuming only "got here" style debug was being attempted.
> 
> > To do something similar for tracepoints, I think we still need to add it as
> > a module parameter.  
> 
> The dev_dbg() filter language is attractive, it's too bad

Not sure what you mean by that. What filter language. Tracepoints do have a
pretty good filtering too.


> trace_printk() has such a high runtime cost as combining dynamic-debug
> and tracing would seem to be a panacea.

trace_printk() has a high runtime cost? Besides that it's not allowed on
production code (see nasty banner), it is made to be extremely fast.
Although, it does do sprintf() work.

Would adding automatic module parameters be an issue? That is, you can add
in the insmod command line a parameter that will enable tracepoints. We
could have a way to even see them from the modinfo. I think I had that
working once, and it wasn't really that hard to do.

-- Steve

