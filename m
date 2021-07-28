Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48CC3D8D5A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 13:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236234AbhG1L7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 07:59:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234753AbhG1L7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 07:59:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06E7F60F91;
        Wed, 28 Jul 2021 11:59:33 +0000 (UTC)
Date:   Wed, 28 Jul 2021 13:59:30 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     cgel.zte@gmail.com
Cc:     peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        James Morris <jamorris@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, NeilBrown <neilb@suse.de>
Subject: Re: [PATCH] set_user: add capability check when rlimit(RLIMIT_NPROC)
 exceeds
Message-ID: <20210728115930.2lzs57h4hvnqipue@wittgenstein>
References: <20210728072629.530435-1-ran.xiaokai@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210728072629.530435-1-ran.xiaokai@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Ccing a few people that did the PF_NPROC_EXCEEDED changes]

On Wed, Jul 28, 2021 at 12:26:29AM -0700, cgel.zte@gmail.com wrote:
> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> 
> in copy_process(): non root users but with capability CAP_SYS_RESOURCE
> or CAP_SYS_ADMIN will clean PF_NPROC_EXCEEDED flag even
> rlimit(RLIMIT_NPROC) exceeds. Add the same capability check logic here.
> 
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> ---
>  kernel/sys.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sys.c b/kernel/sys.c
> index ef1a78f5d71c..72c7639e3c98 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -480,7 +480,8 @@ static int set_user(struct cred *new)
>  	 * failure to the execve() stage.
>  	 */
>  	if (is_ucounts_overlimit(new->ucounts, UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC)) &&
> -			new_user != INIT_USER)
> +			new_user != INIT_USER &&
> +			!capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
>  		current->flags |= PF_NPROC_EXCEEDED;
>  	else
>  		current->flags &= ~PF_NPROC_EXCEEDED;

Hey Cgel,
Hey Ran,

The gist seems to me that this code wants to make sure that a program
can't successfully exec if it has gone through a set*id() transition
while exceeding its RLIMIT_NPROC.

But I agree that the semantics here are a bit strange.

Iicu, a capable but non-INIT_USER caller getting PF_NPROC_EXCEEDED set
during a set*id() transition wouldn't be able to exec right away if they
still exceed their RLIMIT_NPROC at the time of exec. So their exec would
fail in fs/exec.c:

	if ((current->flags & PF_NPROC_EXCEEDED) &&
	    is_ucounts_overlimit(current_ucounts(), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
		retval = -EAGAIN;
		goto out_ret;
	}

However, if the caller were to fork() right after the set*id()
transition but before the exec while still exceeding their RLIMIT_NPROC
then they would get PF_NPROC_EXCEEDED cleared (while the child would
inherit it):

	retval = -EAGAIN;
	if (is_ucounts_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
		if (p->real_cred->user != INIT_USER &&
		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
			goto bad_fork_free;
	}
	current->flags &= ~PF_NPROC_EXCEEDED;

which means a subsequent exec by the capable caller would now succeed
even though they could still exceed their RLIMIT_NPROC limit.

So at first glance, it seems that set_user() should probably get the
same check as it can be circumvented today unless I misunderstand the
original motivation.

Christian
