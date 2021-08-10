Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3593E506C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 02:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236385AbhHJAsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 20:48:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233500AbhHJAst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 20:48:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8D8160C41;
        Tue, 10 Aug 2021 00:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628556508;
        bh=dLbfgKGVJzWqHwD1nWAsoDi2fcpXhT9sM6MRFOqtlGo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fGhz44Qn3Eh8MFJZvF3TzK2BMzMni/p780ExhTKyLBZPOuCPvs4u6goKNKLR+1jxd
         E0M7UiydwSQPb4KXVfVxsBPBezo0oPagi9w6O3OIIpw2gYGhVcWfmRY27oURjId2vZ
         AcriVgJV7ol+zwBRZj4X9AB+UPSLVC5Pm+FdZl9mz8xsxeQP1HcpSOBmOXnNZIFTVa
         RpBorIkSk6U8c0/piEs3oetRyFcCPjJ2spj6o8hFIsLiP8K3/z+jKBInJZsEObNoIb
         cES2LMjJt6pMVvutICygWBYY4ZPlAwRNT2dcgqd52kZx4w8/PEG7EwnhqAARlO8U1z
         o+IVr6QHmfkeQ==
Date:   Tue, 10 Aug 2021 09:48:26 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v2 05/10] tracing/boot: Show correct histogram error
 command
Message-Id: <20210810094826.2c15ddd0d96455a3de545cbd@kernel.org>
In-Reply-To: <162852410657.143877.9603399373481908754.stgit@devnote2>
References: <162852406891.143877.12110677006587392853.stgit@devnote2>
        <162852410657.143877.9603399373481908754.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2021 00:48:26 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Since trigger_process_regex() modifies given trigger actions
> while parsing, the error message couldn't show what command
> was passed to the trigger_process_regex() when it returns
> an error.
> 
> To fix that, show the backed up trigger action command
> instead of parsed buffer.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_boot.c |   11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
> index 69558f149620..cfe4a415b468 100644
> --- a/kernel/trace/trace_boot.c
> +++ b/kernel/trace/trace_boot.c
> @@ -422,6 +422,7 @@ trace_boot_init_histograms(struct trace_event_file *file,
>  {
>  	struct xbc_node *node;
>  	const char *p;
> +	char *tmp;
>  
>  	xbc_node_for_each_subkey(hnode, node) {
>  		p = xbc_node_get_data(node);
> @@ -429,15 +430,19 @@ trace_boot_init_histograms(struct trace_event_file *file,
>  			continue;
>  		/* All digit started node should be instances. */
>  		if (trace_boot_compose_hist_cmd(node, buf, size) == 0) {
> +			tmp = kstrdup(buf, GFP_KERNEL);
>  			if (trigger_process_regex(file, buf) < 0)
> -				pr_err("Failed to apply hist trigger: %s\n", buf);
> +				pr_err("Failed to apply hist trigger: %s\n", tmp);
> +			kfree(tmp);
>  		}
>  	}
>  
>  	if (xbc_node_find_child(hnode, "keys")) {
>  		if (trace_boot_compose_hist_cmd(hnode, buf, size) == 0)
> +			tmp = kstrdup(buf, GFP_KERNEL);
>  			if (trigger_process_regex(file, buf) < 0)
> -				pr_err("Failed to apply hist trigger: %s\n", buf);
> +				pr_err("Failed to apply hist trigger: %s\n", tmp);
> +			kfree(tmp);

And this lacks '{}' for the 2nd if...

>  	}
>  }
>  #else
> @@ -488,7 +493,7 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
>  			if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf))
>  				pr_err("action string is too long: %s\n", p);
>  			else if (trigger_process_regex(file, buf) < 0)
> -				pr_err("Failed to apply an action: %s\n", buf);
> +				pr_err("Failed to apply an action: %s\n", p);
>  		}
>  		anode = xbc_node_find_child(enode, "hist");
>  		if (anode)
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
