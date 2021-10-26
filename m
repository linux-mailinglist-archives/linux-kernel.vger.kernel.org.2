Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD7543ADF6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 10:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbhJZIaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 04:30:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234104AbhJZIaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 04:30:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F7A960FC2;
        Tue, 26 Oct 2021 08:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635236865;
        bh=WyZz9WC/grDwm3ecm1TPmONkuEwBp4PEk/1gMvfsi1c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DpB6GHzGgm7L6pSxHgv1tthBaEjYVlWtMSSP7FVjGvbRBRDji0Zn8oK2Ln18nX3zB
         AwOT+sWH8Iyk6jUF+H3ZZ0ReGQB72mkLVDmhJ1oBoFKzpH9gOI+SQxDOztREs1gqAf
         3MSJ5VPH3FPgAI2K5TGMdBqDnBAX8yROhzbRr/JHYY/tRxvElj81+UCWSdqk+ZUACs
         zznv93eYHSTSTCdv1z/PXhH4eqYBCrgrVpL/EMhe74UlEfY47zu3auTbUV+WTZv/wl
         /wuhwdDYy8oL0NGQiwFfYBe3CWKDSiH7MS1b9IGcxP8641+NjedmEQhWn3gr+bU/Fv
         qmwsd9n8mDS5Q==
Date:   Tue, 26 Oct 2021 17:27:43 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] tracing: Fix missing trace_boot_init_histograms kstrdup
 NULL checks
Message-Id: <20211026172743.be436b228057c26fd73d0649@kernel.org>
In-Reply-To: <20211025231017.01204974@rorschach.local.home>
References: <20211015195550.22742-1-mathieu.desnoyers@efficios.com>
        <20211025231017.01204974@rorschach.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2021 23:10:17 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 15 Oct 2021 15:55:50 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
> > trace_boot_init_histograms misses NULL pointer checks for kstrdup
> > failure.
> > 
> > Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> 
> Masami,
> 
> Can you ack this?

Yes, thanks for reporting this!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> 
> -- Steve
> 
> > ---
> >  kernel/trace/trace_boot.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
> > index 8d252f63cd78..0580287d7a0d 100644
> > --- a/kernel/trace/trace_boot.c
> > +++ b/kernel/trace/trace_boot.c
> > @@ -430,6 +430,8 @@ trace_boot_init_histograms(struct trace_event_file *file,
> >  		/* All digit started node should be instances. */
> >  		if (trace_boot_compose_hist_cmd(node, buf, size) == 0) {
> >  			tmp = kstrdup(buf, GFP_KERNEL);
> > +			if (!tmp)
> > +				return;
> >  			if (trigger_process_regex(file, buf) < 0)
> >  				pr_err("Failed to apply hist trigger: %s\n", tmp);
> >  			kfree(tmp);
> > @@ -439,6 +441,8 @@ trace_boot_init_histograms(struct trace_event_file *file,
> >  	if (xbc_node_find_subkey(hnode, "keys")) {
> >  		if (trace_boot_compose_hist_cmd(hnode, buf, size) == 0) {
> >  			tmp = kstrdup(buf, GFP_KERNEL);
> > +			if (!tmp)
> > +				return;
> >  			if (trigger_process_regex(file, buf) < 0)
> >  				pr_err("Failed to apply hist trigger: %s\n", tmp);
> >  			kfree(tmp);
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
