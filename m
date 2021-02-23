Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9249F322EAD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 17:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbhBWQ0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 11:26:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:39116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232176AbhBWQZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 11:25:57 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5264E64E3F;
        Tue, 23 Feb 2021 16:25:14 +0000 (UTC)
Date:   Tue, 23 Feb 2021 11:25:12 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andrew Scull <ascull@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        julien.thierry.kdev@gmail.com, will@kernel.org,
        catalin.marinas@arm.com, kernel-team@android.com,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 1/4] bug: Remove redundant condition check in
 report_bug
Message-ID: <20210223112512.30746025@gandalf.local.home>
In-Reply-To: <20210223155759.3495252-2-ascull@google.com>
References: <20210223155759.3495252-1-ascull@google.com>
        <20210223155759.3495252-2-ascull@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Feb 2021 15:57:56 +0000
Andrew Scull <ascull@google.com> wrote:

> report_bug() will return early if it cannot find a bug corresponding to
> the provided address. The subsequent test for the bug will always be
> true so remove it.

Fixes: 1b4cfe3c0a30d ("lib/bug.c: exclude non-BUG/WARN exceptions from report_bug()")

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> 
> Signed-off-by: Andrew Scull <ascull@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> ---
>  lib/bug.c | 33 +++++++++++++++------------------
>  1 file changed, 15 insertions(+), 18 deletions(-)
> 
> diff --git a/lib/bug.c b/lib/bug.c
> index 7103440c0ee1..4ab398a2de93 100644
> --- a/lib/bug.c
> +++ b/lib/bug.c
> @@ -158,30 +158,27 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
>  
>  	file = NULL;
>  	line = 0;
> -	warning = 0;
>  
> -	if (bug) {
>  #ifdef CONFIG_DEBUG_BUGVERBOSE
>  #ifndef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
> -		file = bug->file;
> +	file = bug->file;
>  #else
> -		file = (const char *)bug + bug->file_disp;
> +	file = (const char *)bug + bug->file_disp;
>  #endif
> -		line = bug->line;
> +	line = bug->line;
>  #endif
> -		warning = (bug->flags & BUGFLAG_WARNING) != 0;
> -		once = (bug->flags & BUGFLAG_ONCE) != 0;
> -		done = (bug->flags & BUGFLAG_DONE) != 0;
> -
> -		if (warning && once) {
> -			if (done)
> -				return BUG_TRAP_TYPE_WARN;
> -
> -			/*
> -			 * Since this is the only store, concurrency is not an issue.
> -			 */
> -			bug->flags |= BUGFLAG_DONE;
> -		}
> +	warning = (bug->flags & BUGFLAG_WARNING) != 0;
> +	once = (bug->flags & BUGFLAG_ONCE) != 0;
> +	done = (bug->flags & BUGFLAG_DONE) != 0;
> +
> +	if (warning && once) {
> +		if (done)
> +			return BUG_TRAP_TYPE_WARN;
> +
> +		/*
> +		 * Since this is the only store, concurrency is not an issue.
> +		 */
> +		bug->flags |= BUGFLAG_DONE;
>  	}
>  
>  	/*

