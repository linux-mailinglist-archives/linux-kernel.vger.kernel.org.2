Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598C7441BDE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 14:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbhKANoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 09:44:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231693AbhKANoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 09:44:37 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B9AF60FE8;
        Mon,  1 Nov 2021 13:35:04 +0000 (UTC)
Date:   Mon, 1 Nov 2021 09:35:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     cgel.zte@gmail.com
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Zhang Mingyu <zhang.mingyu@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] tracing:Remove unneeded semicolon
Message-ID: <20211101093502.37de73c0@gandalf.local.home>
In-Reply-To: <20211101055602.35167-1-zhang.mingyu@zte.com.cn>
References: <20211101055602.35167-1-zhang.mingyu@zte.com.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Nov 2021 05:56:02 +0000
cgel.zte@gmail.com wrote:

> From: Zhang Mingyu <zhang.mingyu@zte.com.cn>
> 
> Eliminate the following coccinelle check warning:
> kernel/trace/trace_events_hist.c:6087:2-3

Thanks, but a fix (by a robot) was already added to my queue.

https://lore.kernel.org/all/20211030005615.GA41257@3074f0d39c61/

-- Steve


> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Zhang Mingyu <zhang.mingyu@zte.com.cn>
> ---
>  kernel/trace/trace_events_hist.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index cddf6bf165a0..61586f16a853 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -6084,7 +6084,7 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
>  	while (start) {
>  		*(start + 4) = 'X';
>  		start = strstr(start + 11, ".sym-offset");
> -	};
> +	}
>  
>  	attrs = parse_hist_trigger_attrs(file->tr, trigger);
>  	if (IS_ERR(attrs))

