Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E99F4249AA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 00:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239905AbhJFW2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 18:28:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:32788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239820AbhJFW2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 18:28:47 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43693610C8;
        Wed,  6 Oct 2021 22:26:54 +0000 (UTC)
Date:   Wed, 6 Oct 2021 18:26:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Robin H. Johnson" <robbat2@gentoo.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        rjohnson@digitalocean.com, Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 1/2] tracing: show size of requested buffer
Message-ID: <20211006182652.6c11ce1b@gandalf.local.home>
In-Reply-To: <20210831043723.13481-1-robbat2@gentoo.org>
References: <20210831043723.13481-1-robbat2@gentoo.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Aug 2021 21:37:22 -0700
"Robin H. Johnson" <robbat2@gentoo.org> wrote:

Sorry for the late reply, I was on holiday when this was sent, and I'm just
getting to looking at this email now (as my OoO email should have suggested ;-)

Anyway, this needs to be reviewed by the Perf maintainers (Cc'd)

(Lore link for patch 2: 
  https://lore.kernel.org/all/20210831043723.13481-2-robbat2@gentoo.org/ )

-- Steve


> If the perf buffer isn't large enough, provide a hint about how large it
> needs to be for whatever is running.
> 
> Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
> ---
>  kernel/trace/trace_event_perf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
> index 03be4435d103..26eed4b89100 100644
> --- a/kernel/trace/trace_event_perf.c
> +++ b/kernel/trace/trace_event_perf.c
> @@ -400,7 +400,8 @@ void *perf_trace_buf_alloc(int size, struct pt_regs **regs, int *rctxp)
>  	BUILD_BUG_ON(PERF_MAX_TRACE_SIZE % sizeof(unsigned long));
>  
>  	if (WARN_ONCE(size > PERF_MAX_TRACE_SIZE,
> -		      "perf buffer not large enough"))
> +		      "perf buffer not large enough, wanted %d, have %d",
> +		      size, PERF_MAX_TRACE_SIZE))
>  		return NULL;
>  
>  	*rctxp = rctx = perf_swevent_get_recursion_context();

