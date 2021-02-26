Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C01F326436
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 15:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhBZOlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 09:41:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:47888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229554AbhBZOlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 09:41:14 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C375F64E20;
        Fri, 26 Feb 2021 14:40:33 +0000 (UTC)
Date:   Fri, 26 Feb 2021 09:40:32 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Use WARN(1,...)
Message-ID: <20210226094032.49ac56d7@gandalf.local.home>
In-Reply-To: <20210226094426.49016-1-vulab@iscas.ac.cn>
References: <20210226094426.49016-1-vulab@iscas.ac.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Feb 2021 09:44:26 +0000
Xu Wang <vulab@iscas.ac.cn> wrote:

> Use WARN(1,...) rather than printk followed by WARN_ON(1).

Why?

> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
> ---
>  kernel/trace/trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 526fd5ac2ba8..a556b8c00a9f 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -1957,7 +1957,7 @@ static int run_tracer_selftest(struct tracer *type)
>  	tr->current_trace = saved_tracer;
>  	if (ret) {
>  		/* Add the warning after printing 'FAILED' */
> -		WARN(1, KERN_CONT "FAILED!\n");
> +		WARN(1, "FAILED!\n");

The above isn't even in my tree.

Anyway, look at the code around it, and then tell that this patch makes
sense.

NAK.

-- Steve


>  		return -1;
>  	}
>  	/* Only reset on passing, to avoid touching corrupted buffers */

