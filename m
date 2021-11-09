Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D2344B0D3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 17:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238441AbhKIQF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 11:05:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:47588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238396AbhKIQF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 11:05:26 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC1B0611CA;
        Tue,  9 Nov 2021 16:02:39 +0000 (UTC)
Date:   Tue, 9 Nov 2021 11:02:37 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ftrace/direct: Fix lockup in modify_ftrace_direct_multi
Message-ID: <20211109110237.4f5d7ef3@gandalf.local.home>
In-Reply-To: <20211109114217.1645296-1-jolsa@kernel.org>
References: <20211109114217.1645296-1-jolsa@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  9 Nov 2021 12:42:17 +0100
Jiri Olsa <jolsa@redhat.com> wrote:

> We can't call unregister_ftrace_function under ftrace_lock.

Ouch. 

Do you have a sample module that triggers this?

I thought we had something that tested this code, but I don't see it in my
tree.

-- Steve

> 
> Fixes: ed29271894aa ("ftrace/direct: Do not disable when switching direct callers")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/trace/ftrace.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index b4ed1a301232..fc49e8809a56 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -5602,10 +5602,11 @@ int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
>  		}
>  	}
>  
> +	mutex_unlock(&ftrace_lock);
> +
>  	/* Removing the tmp_ops will add the updated direct callers to the functions */
>  	unregister_ftrace_function(&tmp_ops);
>  
> -	mutex_unlock(&ftrace_lock);
>   out_direct:
>  	mutex_unlock(&direct_mutex);
>  	return err;

