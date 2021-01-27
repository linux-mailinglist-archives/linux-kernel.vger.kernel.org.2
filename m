Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D6E305FA3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 16:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236070AbhA0PbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 10:31:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:34536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343870AbhA0PaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 10:30:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4E82207D0;
        Wed, 27 Jan 2021 15:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611761370;
        bh=6rY3NlDI3lDIO6nnxpjqKv0MKiL3NEanDNhJTSMPH0s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KZTEFYnEvUOQgQitYcnBRhVHUKUrBVcu2eNkHiyn/y1S8A0SAtyiqGw0ab3qhXB4f
         S7OGdtjvDoY7lVYGgxgQHOssxgBeavdOlNitJ8BoHLSnDbRANXRM8R1AFxv0BmH/lY
         BXaqg+E3XSE/jpFDxnvLWn+8pLYXi4nVwRfO6jDIjTcxLjsM8NULp1vSynWx16B7gh
         t6/GsHlFxdWzWcOry0z2RHCLEjDeChFD8XifwbExHQsV4K5JCog+fTeZV17KwGFOIz
         P2dH415iKbEw5vhRCJzggIXpPvomFxsFyIxYH9fLc4yAHUEXC/pXNkOhKYmsmp6yD1
         emqiziyuizK2g==
Date:   Thu, 28 Jan 2021 00:29:27 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jianlin Lv <Jianlin.Lv@arm.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com, oleg@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] tracing: precise log info for kretprobe addr err
Message-Id: <20210128002927.092567332c4413cde2a260c3@kernel.org>
In-Reply-To: <20210127151507.4185234-1-Jianlin.Lv@arm.com>
References: <20210127151507.4185234-1-Jianlin.Lv@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianlin,

Now as you reported, this must be fixed with actual bug which prevent
kretprobe events on unloaded module. I'll send another one which also
fix this issue.

Thank you,

On Wed, 27 Jan 2021 23:15:07 +0800
Jianlin Lv <Jianlin.Lv@arm.com> wrote:

> When trying to create kretprobe with the wrong function symbol in tracefs;
> The error is triggered in the register_trace_kprobe() and recorded as
> FAIL_REG_PROBE issue,
> 
> Example:
>   $ cd /sys/kernel/debug/tracing
>   $ echo 'r:myprobe ERROR_SYMBOL_XXX ret=%x0' >> kprobe_events
>     bash: echo: write error: Invalid argument
>   $ cat error_log
>     [142797.347877] trace_kprobe: error: Failed to register probe event
>     Command: r:myprobe ERROR_SYMBOL_XXX ret=%x0
>                        ^
> 
> This error can be detected in the parameter parsing stage, the effect of
> applying this patch is as follows:
> 
>   $ echo 'r:myprobe ERROR_SYMBOL_XXX ret=%x0' >> kprobe_events
>     bash: echo: write error: Invalid argument
>   $ cat error_log
>     [415.89]trace_kprobe: error: Retprobe address must be an function entry
>     Command: r:myprobe ERROR_SYMBOL_XXX ret=%x0
>                        ^
> v2 changes:
> - Added !strchr(symbol, ':') to check whether symbol is really bad
>   or from a module.
> 
> Signed-off-by: Jianlin Lv <Jianlin.Lv@arm.com>
> ---
> v2: added !strchr(symbol, ':') to check really bad symbol or from module.
> v4: added changelog and code comments.
> ---
>  kernel/trace/trace_kprobe.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index e6fba1798771..384208a38f82 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -830,7 +830,8 @@ static int trace_kprobe_create(int argc, const char *argv[])
>  			flags |= TPARG_FL_RETURN;
>  		if (kprobe_on_func_entry(NULL, symbol, offset))
>  			flags |= TPARG_FL_FENTRY;
> -		if (offset && is_return && !(flags & TPARG_FL_FENTRY)) {
> +		/* Check whether symbol is really bad or from a module */
> +		if (!strchr(symbol, ':') && is_return && !(flags & TPARG_FL_FENTRY)) {
>  			trace_probe_log_err(0, BAD_RETPROBE);
>  			goto parse_error;
>  		}
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
