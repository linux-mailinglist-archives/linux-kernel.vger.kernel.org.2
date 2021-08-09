Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0233E500F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 01:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237033AbhHIXir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 19:38:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235649AbhHIXip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 19:38:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C48E460E52;
        Mon,  9 Aug 2021 23:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628552304;
        bh=DVYy3vnM+x/KAEwbOsFZgEawHFEU9uV6mOJ99WBM1uM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KKGRRX4QBd6fjDtCJU8PqxpmCHRBFc0ASDcCFiis6Q66mAbWWNtIjZVAUEtpLVXoJ
         GebjrxflflXyQL8FwlMshB/L62vfD02LFN8OvZM7eQSAEPQ6JgC5cEiHhjDNwGEdUV
         pLDjNZYiDvVv88hLhlEcrEDW7ARggewkNSgkbXU4eZ0RBIonD/F66GTm9UsENGjYab
         M/9QIa6FydMs+Dds2JnPilrgjevKr3weLKNH630vHylVag1S+QgPssOqr9DTUMAlvo
         Z3m2aNs/8/3xwo4Xg1sgmn0Pu6SuR0v0pbUSJv4iL+Tv6iq292dOLXK4wvgr901L+w
         mpxeMjRLLK+9g==
Date:   Tue, 10 Aug 2021 08:38:22 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v2 00/10] tracing/boot: Add histogram syntax support in
 boot-time tracing
Message-Id: <20210810083822.ea1834e5e9ae403b1c8c2ed9@kernel.org>
In-Reply-To: <162852406891.143877.12110677006587392853.stgit@devnote2>
References: <162852406891.143877.12110677006587392853.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Oops, I forgot to update the title. This is v3.

On Tue, 10 Aug 2021 00:47:49 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is the 3rd version of boot-time tracing to add histogram
> syntax extension with a bugfix related hist-trigger.
> 
> In this version, I updated the first bugfix to use IS_ENABLED()
> and show error if CONFIG_HIST_TRIGGERS=n ([1/10]), allow the spaces
> in the variable expressions ([2/10]), and update ktest bootconfig
> testcase ([10/10]).
> 
> 
> 'Histogram' options
> -------------------
> Currently, the boot-time tracing only supports per-event actions
> for setting trigger actions. This is enough for short actions
> like 'traceon', 'traceoff', 'snapshot' etc. However, it is not good
> for the 'hist' trigger action because it is usually too long to write
> it in a single string especially if it has an 'onmatch' action.
> 
> Here is the new syntax.
> 
>     ftrace[.instance.INSTANCE].event.GROUP.EVENT.hist[.N] {
>          keys = <KEY>[,...]
>          values = <VAL>[,...]
>          sort = <SORT-KEY>[,...]
>          size = <ENTRIES>
>          name = <HISTNAME>
>          var { <VAR> = <EXPR> ... }
>          pause|continue|clear
>          onmax|onchange[.M] { var = <VAR>, <ACTION> [= <PARAM>] }
>          onmatch[.M] { event = <EVENT>, <ACTION> [= <PARAM>] }
>          filter = <FILTER>
>     }
>     
> Where <ACTION> is one of below;
>     
>     trace = <EVENT>, <ARG1>[, ...]
>     save = <ARG1>[, ...]
>     snapshot
> 
> And "N" and "M" are digit started strings for multiple histograms
> and actions.
> 
> For example,
> 
> initcall.initcall_finish.actions =
> "hist:keys=func:lat=common_timestamp.usecs-$ts0:onmatch(initcall.initcall_start).trace(initcall_latency,func,$lat)"
> 
> This can be written as below;
> 
> initcall.initcall_finish.hist {
>     keys = func
>     var.lat = common_timestamp.usecs-$ts0
>     onmatch {
>         event = initcall.initcall_start
>         trace = initcall_latency, func, $lat
>     }
> }
> 
> Also, you can add comments for each options.
> 
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (10):
>       tracing/boot: Fix a hist trigger dependency for boot time tracing
>       tracing/boot: Add per-event histogram action options
>       tracing/boot: Support multiple handlers for per-event histogram
>       tracing/boot: Support multiple histograms for each event
>       tracing/boot: Show correct histogram error command
>       Documentation: tracing: Add histogram syntax to boot-time tracing
>       tools/bootconfig: Support per-group/all event enabling option
>       tools/bootconfig: Add histogram syntax support to bconf2ftrace.sh
>       tools/bootconfig: Use per-group/all enable option in ftrace2bconf script
>       bootconfig/tracing/ktest: Update ktest example for boot-time tracing
> 
> 
>  Documentation/trace/boottime-trace.rst             |   85 +++++-
>  kernel/trace/trace_boot.c                          |  301 ++++++++++++++++++++
>  tools/bootconfig/scripts/bconf2ftrace.sh           |   97 ++++++
>  tools/bootconfig/scripts/ftrace2bconf.sh           |   24 +-
>  tools/bootconfig/scripts/xbc.sh                    |    4 
>  .../ktest/examples/bootconfigs/boottrace.bconf     |   20 +
>  .../ktest/examples/bootconfigs/verify-boottrace.sh |    2 
>  7 files changed, 508 insertions(+), 25 deletions(-)
> 
> -- 
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
