Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF7E43AA98
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 05:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbhJZDMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 23:12:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:33906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231445AbhJZDMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 23:12:42 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 600D760F90;
        Tue, 26 Oct 2021 03:10:19 +0000 (UTC)
Date:   Mon, 25 Oct 2021 23:10:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] tracing: Fix missing trace_boot_init_histograms kstrdup
 NULL checks
Message-ID: <20211025231017.01204974@rorschach.local.home>
In-Reply-To: <20211015195550.22742-1-mathieu.desnoyers@efficios.com>
References: <20211015195550.22742-1-mathieu.desnoyers@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2021 15:55:50 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> trace_boot_init_histograms misses NULL pointer checks for kstrdup
> failure.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>

Masami,

Can you ack this?

-- Steve

> ---
>  kernel/trace/trace_boot.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
> index 8d252f63cd78..0580287d7a0d 100644
> --- a/kernel/trace/trace_boot.c
> +++ b/kernel/trace/trace_boot.c
> @@ -430,6 +430,8 @@ trace_boot_init_histograms(struct trace_event_file *file,
>  		/* All digit started node should be instances. */
>  		if (trace_boot_compose_hist_cmd(node, buf, size) == 0) {
>  			tmp = kstrdup(buf, GFP_KERNEL);
> +			if (!tmp)
> +				return;
>  			if (trigger_process_regex(file, buf) < 0)
>  				pr_err("Failed to apply hist trigger: %s\n", tmp);
>  			kfree(tmp);
> @@ -439,6 +441,8 @@ trace_boot_init_histograms(struct trace_event_file *file,
>  	if (xbc_node_find_subkey(hnode, "keys")) {
>  		if (trace_boot_compose_hist_cmd(hnode, buf, size) == 0) {
>  			tmp = kstrdup(buf, GFP_KERNEL);
> +			if (!tmp)
> +				return;
>  			if (trigger_process_regex(file, buf) < 0)
>  				pr_err("Failed to apply hist trigger: %s\n", tmp);
>  			kfree(tmp);

