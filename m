Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F8B321E86
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 18:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhBVRuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 12:50:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:33860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230177AbhBVRuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 12:50:20 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9FC964F00;
        Mon, 22 Feb 2021 17:49:38 +0000 (UTC)
Date:   Mon, 22 Feb 2021 12:49:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Romain Perier <romain.perier@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel-hardening@lists.openwall.com,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/20] tracing/probe: Manual replacement of the
 deprecated strlcpy() with return values
Message-ID: <20210222124936.03103585@gandalf.local.home>
In-Reply-To: <20210222151231.22572-17-romain.perier@gmail.com>
References: <20210222151231.22572-1-romain.perier@gmail.com>
        <20210222151231.22572-17-romain.perier@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Feb 2021 16:12:27 +0100
Romain Perier <romain.perier@gmail.com> wrote:

> The strlcpy() reads the entire source buffer first, it is dangerous if
> the source buffer lenght is unbounded or possibility non NULL-terminated.
> It can lead to linear read overflows, crashes, etc...
> 
> As recommended in the deprecated interfaces [1], it should be replaced
> by strscpy.
> 
> This commit replaces all calls to strlcpy that handle the return values
> by the corresponding strscpy calls with new handling of the return
> values (as it is quite different between the two functions).
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> 
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> ---
>  kernel/trace/trace_uprobe.c |   11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 3cf7128e1ad3..f9583afdb735 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -154,12 +154,11 @@ fetch_store_string(unsigned long addr, void *dest, void *base)
>  	u8 *dst = get_loc_data(dest, base);
>  	void __user *src = (void __force __user *) addr;
>  
> -	if (unlikely(!maxlen))
> -		return -ENOMEM;

Don't remove the above. You just broke the else side.

> -
> -	if (addr == FETCH_TOKEN_COMM)
> -		ret = strlcpy(dst, current->comm, maxlen);
> -	else
> +	if (addr == FETCH_TOKEN_COMM) {
> +		ret = strscpy(dst, current->comm, maxlen);
> +		if (ret == -E2BIG)
> +			return -ENOMEM;

I'm not sure the above is what we want. current->comm is always nul
terminated, and not only that, it will never be bigger than TASK_COMM_LEN.
If the "dst" location is smaller than comm (maxlen < TASK_COMM_LEN), it is
still OK to copy a partial string. It should not return -ENOMEM which looks
to be what happens with this patch.

In other words, it looks like this patch breaks the current code in more
ways than one.

-- Steve


> +	} else
>  		ret = strncpy_from_user(dst, src, maxlen);
>  	if (ret >= 0) {
>  		if (ret == maxlen)

