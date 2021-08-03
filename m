Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5B83DEAEB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 12:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbhHCK3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 06:29:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235204AbhHCK3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 06:29:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2687060EFD;
        Tue,  3 Aug 2021 10:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627986531;
        bh=X1kVRUl5xL09hwrA4sPmYs6qgDtCSuQKAFQdkdn3Jdk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S+yUgp4GJPn9ZahYTzuHNXU709uuEPjV6Kyvi8SRJ5d9evwZjDxBpme6i9MaFl9+v
         rg3P63Bs/3vQFSt+TBehwpPEGEpoYuYLmBFwP9zD/B0Z52s4Kq4MjrJJj0PMKdxXHI
         9JTiXQqtUZUbIovHhyR7bKRTn4bm2rAyKDNpLcK9TvaDiDmC8ewEeFf4vcDbltu7qF
         cwHiacnrE7pxc5g0Cde+ZmtR2c9QpSj6f1s0AVA8FDGA5Jthb/fyVOsKl9uTmPJzc7
         9pxCUtMvNEkA+/+LJfNYnJn47boDZEvMoX2DRvDKJij3QxmnxgE63Hu7cJ1z9XOUN0
         unsBZNmkJCK2Q==
Date:   Tue, 3 Aug 2021 19:28:49 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [RFC PATCH 0/3] tracing/boot: Add histogram syntax support in
 boot-time tracing
Message-Id: <20210803192849.c18569179c0ecc1848537cc4@kernel.org>
In-Reply-To: <162791821009.552329.4358174280895732459.stgit@devnote2>
References: <162791821009.552329.4358174280895732459.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Aug 2021 00:30:10 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is a series of patches for boot-time tracing to add histogram
> syntax extension and fixes a build issue.
> 
> Currently, the boot-time tracing only supports per-event actions
> for setting trigger actions. This is enough for short actions
> like 'traceon', 'traceoff', 'snapshot' etc. However, it is not good
> for the 'hist' trigger action because it is usually too long to write
> it in a single string especially if it has an 'onmatch' action.
> 
> Here is the new syntax.
> 
>     ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist {
>          keys = <KEY>[,...]
>          values = <VAL>[,...]
>          sort = <SORT-KEY>[,...]
>          size = <ENTRIES>
>          name = <HISTNAME>
>          var { <VAR> = <EXPR> ... }
>          pause|continue|clear
>          onmax|onchange { var = <VAR>, <ACTION> [= <PARAM>] }
>          onmatch { event = <EVENT>, <ACTION> [= <PARAM>] }

Oops, these must use ';' as below.

  onmax|onchange { var = <VAR>; <ACTION> [= <PARAM>] }
  onmatch { event = <EVENT>; <ACTION> [= <PARAM>] }

>          filter = <FILTER>
>     }

Hmm, I found that one histogram can have several actions.

"hist:keys=func:lat=common_timestamp.usecs-$ts0:onmatch(A).trace(initcall_latency,func,$lat):onmatch(B).trace(initcall_latency,func,$lat)"

This syntax can be used for the case that measures the elapsed time
from A to C, and from B to C, 

event A -> event C
event B -> event C

So,

onmatch.GROUP.EVENT.<ACTION> = <PARAMS>

allows us to define multiple "onmatch" on one histogram.

onmatch.groupA.eventA.trace = synthevent, arg1, arg2
onmatch.groupB.eventB.trace = synthevent, arg1, arg2

However, there is another problem on "onmax" and "onchange".
Those will take a variable name that starts from "$", but we can not
use "$" in the subkey in bootconfig.

onmax.$lat.trace = synthevent, arg1, arg2 # this will cause error because of "$lat"

Thus, maybe we can expand the original one as

  onmax|onchange[.#NUM] { var = <VAR>; <ACTION> [= <PARAM>] }
  onmatch[.#NUM] { event = <EVENT>; <ACTION> [= <PARAM>] }

Then, we can add multiple handler-actions in one histogram.

onmatch.1 {
  event = ...
  trace = ...
}
onmatch.2 {
  event = ...
  trace = ...
}

Thank you,

>     
> Where <ACTION> is one of below;
>     
>     trace = <EVENT>, <ARG1>[, ...]
>     save = <ARG1>[, ...]
>     snapshot
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
> TODO
> ====
> - This version doesn't support multiple histograms on an event. For
>   that purpose, you still need to use per-event 'actions' option.
>   Maybe it can be extended to support multiple instance by adding
>   '_#NUM' subkey, e.g. "hist._1.keys = ...; hist._2.keys = ...".
> - This also doesn't support multiple 'onmatch'/'onmax'/'onchange'
>   handler actions.
> - Need to expand ktest testcase for checking this syntax.
> 
> Tom, this version doesn't make pause/continue/clear mutually exclusive.
> And onmatch/onmax/onchange, too. As far as I can see the code, those
> can be set on one histogram. But maybe I'm wrong. Please tell me if
> there is some limitations or exclusiveness among those options.
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (3):
>       tracing/boot: Fix a hist trigger dependency for boot time tracing
>       tracing/boot: Add per-event histogram action options
>       Documentation: tracing: Add histogram syntax to boot-time tracing
> 
> 
>  Documentation/trace/boottime-trace.rst |   81 ++++++++++++-
>  kernel/trace/trace_boot.c              |  203 ++++++++++++++++++++++++++++++++
>  2 files changed, 278 insertions(+), 6 deletions(-)
> 
> -- 
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
