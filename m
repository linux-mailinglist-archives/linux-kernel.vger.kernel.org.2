Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3F6322EDD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 17:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbhBWQgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 11:36:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:40506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233546AbhBWQgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 11:36:15 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D82564E60;
        Tue, 23 Feb 2021 16:35:32 +0000 (UTC)
Date:   Tue, 23 Feb 2021 11:35:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andrew Scull <ascull@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        julien.thierry.kdev@gmail.com, will@kernel.org,
        catalin.marinas@arm.com, kernel-team@android.com,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 2/4] bug: Factor out a getter for a bug's file line
Message-ID: <20210223113530.3703dd19@gandalf.local.home>
In-Reply-To: <20210223155759.3495252-3-ascull@google.com>
References: <20210223155759.3495252-1-ascull@google.com>
        <20210223155759.3495252-3-ascull@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Feb 2021 15:57:57 +0000
Andrew Scull <ascull@google.com> wrote:

> There is some non-trivial config-based logic to get the file name and
> line number associated with a bug. Factor this out to a getter that can
> be resused.
> 
> Signed-off-by: Andrew Scull <ascull@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> ---
>  include/linux/bug.h |  3 +++
>  lib/bug.c           | 27 +++++++++++++++++----------
>  2 files changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/bug.h b/include/linux/bug.h
> index f639bd0122f3..e3841bee4c8d 100644
> --- a/include/linux/bug.h
> +++ b/include/linux/bug.h
> @@ -36,6 +36,9 @@ static inline int is_warning_bug(const struct bug_entry *bug)
>  	return bug->flags & BUGFLAG_WARNING;
>  }
>  
> +void bug_get_file_line(struct bug_entry *bug, const char **file,
> +		       unsigned int *line);
> +
>  struct bug_entry *find_bug(unsigned long bugaddr);
>  
>  enum bug_trap_type report_bug(unsigned long bug_addr, struct pt_regs *regs);
> diff --git a/lib/bug.c b/lib/bug.c
> index 4ab398a2de93..f936615176b8 100644
> --- a/lib/bug.c
> +++ b/lib/bug.c
> @@ -130,6 +130,22 @@ static inline struct bug_entry *module_find_bug(unsigned long bugaddr)
>  }
>  #endif
>  
> +void bug_get_file_line(struct bug_entry *bug, const char **file,
> +		       unsigned int *line)
> +{
> +	*file = NULL;
> +	*line = 0;
> +
> +#ifdef CONFIG_DEBUG_BUGVERBOSE
> +#ifndef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
> +	*file = bug->file;
> +#else
> +	*file = (const char *)bug + bug->file_disp;
> +#endif
> +	*line = bug->line;

Not that it should be part of this patch, as this patch is moving the code
and shouldn't modify it, but as a micro optimization, we could remove the
initialization from the beginning and place it here:

#else 
	*file = NULL;
	*line = 0;

But again, this patch is fine.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


> +#endif
> +}
> +
>  struct bug_entry *find_bug(unsigned long bugaddr)
>  {
>  	struct bug_entry *bug;
> @@ -156,17 +172,8 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
>  
>  	disable_trace_on_warning();
>  
> -	file = NULL;
> -	line = 0;
> +	bug_get_file_line(bug, &file, &line);
>  
> -#ifdef CONFIG_DEBUG_BUGVERBOSE
> -#ifndef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
> -	file = bug->file;
> -#else
> -	file = (const char *)bug + bug->file_disp;
> -#endif
> -	line = bug->line;
> -#endif
>  	warning = (bug->flags & BUGFLAG_WARNING) != 0;
>  	once = (bug->flags & BUGFLAG_ONCE) != 0;
>  	done = (bug->flags & BUGFLAG_DONE) != 0;

