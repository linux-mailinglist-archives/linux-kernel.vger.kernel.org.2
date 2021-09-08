Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D774037CC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 12:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348845AbhIHKZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 06:25:22 -0400
Received: from mother.openwall.net ([195.42.179.200]:45538 "HELO
        mother.openwall.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1348771AbhIHKZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 06:25:21 -0400
Received: (qmail 19587 invoked from network); 8 Sep 2021 10:24:11 -0000
Received: from localhost (HELO pvt.openwall.com) (127.0.0.1)
  by localhost with SMTP; 8 Sep 2021 10:24:11 -0000
Received: by pvt.openwall.com (Postfix, from userid 503)
        id 9905AAB88C; Wed,  8 Sep 2021 12:24:00 +0200 (CEST)
Date:   Wed, 8 Sep 2021 12:24:00 +0200
From:   Solar Designer <solar@openwall.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     CGEL <cgel.zte@gmail.com>, peterz@infradead.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        James Morris <jamorris@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, NeilBrown <neilb@suse.de>
Subject: Re: [PATCH] set_user: add capability check when rlimit(RLIMIT_NPROC) exceeds
Message-ID: <20210908102400.GA22799@openwall.com>
References: <20210728072629.530435-1-ran.xiaokai@zte.com.cn> <20210728115930.2lzs57h4hvnqipue@wittgenstein> <20210730082329.GA544980@www> <20210803100354.GA607722@www> <20210803140702.f3rdnka3e2x6vj4r@wittgenstein> <20210907213042.GA22626@openwall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210907213042.GA22626@openwall.com>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a further observation:

On Tue, Sep 07, 2021 at 11:30:42PM +0200, Solar Designer wrote:
> As I understand, the resulting commit:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2863643fb8b92291a7e97ba46e342f1163595fa8
> 
> broke RLIMIT_NPROC support for Apache httpd suexec and likely similar.

The commit above tries to make things consistent by duplicating the
check from copy_process() also in set_user().  However, the check isn't
actually the same because set_user(new) is called _before_
security_task_fix_setuid(new, ...), whereas in the described detour via
fork() its check would be reached already as the new user.  So those
capable() calls just look the same, but are actually very different, and
that's the problem.  My current understanding is the commit actually
increases inconsistency.

The commit message starts with:

"in copy_process(): non root users but with capability CAP_SYS_RESOURCE
or CAP_SYS_ADMIN will clean PF_NPROC_EXCEEDED flag even
rlimit(RLIMIT_NPROC) exceeds. Add the same capability check logic here."

It talks about the obscure case of "non root users but with capability".
However, the capable() calls added by the commit actually also apply to
root, such as in suexec.

> Anyway, now I suggest that 2863643fb8b92291a7e97ba46e342f1163595fa8 be
> reverted, and if there's any reason to make any change (what reason?
> mere consistency or any real issue?) then I suggest that the flag
> resetting on fork() be made conditional.  Something like this:
> 
> 	if (atomic_read(&p->real_cred->user->processes) >=
> 			task_rlimit(p, RLIMIT_NPROC)) {
> 		if (p->real_cred->user != INIT_USER &&
> 		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
> 			goto bad_fork_free;
> -	}
> -	current->flags &= ~PF_NPROC_EXCEEDED;
> +	} else
> +		current->flags &= ~PF_NPROC_EXCEEDED;

Alternatively, we could postpone the set_user() calls until we're
running with the new user's capabilities, but that's an invasive change
that's likely to create its own issues.  So my suggestion above holds.

Alexander
