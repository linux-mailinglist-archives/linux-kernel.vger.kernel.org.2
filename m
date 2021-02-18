Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF9931ECE7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 18:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbhBRRIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 12:08:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:52128 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231145AbhBRO0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 09:26:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613658304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C5T3ehENXPR3Dp3wxtz7+m4co+ANYhyC2qUBSrxsMQA=;
        b=A6otcrdkcGuk6b40y0c2Ep48vXGzabWsPISrtj4Q5FVBXISGZwVSnVyWP2mxlSgh/KPT58
        Tf9lI02hF0MxBpSUfVajAD1N7RyktXC2tJhZyfAhP6Adn9hC7Z1Ntqu+6Yr68kpUySAdSj
        L1NvfLGr+Cr4kduxUX0TiXsi74hNUC8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7D216AFF1;
        Thu, 18 Feb 2021 14:25:04 +0000 (UTC)
Date:   Thu, 18 Feb 2021 15:25:03 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: [PATCH v4] printk: Userspace format enumeration support
Message-ID: <YC54vyU8ZZPiaYOQ@alley>
References: <YCafCKg2bAlOw08H@chrisdown.name>
 <YC5b4+hTjrGwG22o@chrisdown.name>
 <YC5flsiUEZnPs7qz@alley>
 <YC5ggyeC0uqtOD6R@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YC5ggyeC0uqtOD6R@chrisdown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-02-18 12:41:39, Chris Down wrote:
> Petr Mladek writes:
> > > - See if it's safe to pass a printk_fmt_sec to seq_file instead of a module
> > 
> > Also it might be needed to store the pointer to struct module.
> 
> You mean, have a `struct module` entry for this? I somewhat suspect that
> module.c maintainers are not likely to be happy about injecting non-generic
> code into there if it's possible to be avoided, but maybe I'm
> misunderstanding?

Yes, I suggest to store the pointer into struct module. It includes
many external entries. It is similar to struct task_struct.

I am active also in the kernel livepatch subsystem. We have added
there three values:

#ifdef CONFIG_LIVEPATCH
	bool klp; /* Is this a livepatch module? */
	bool klp_alive;

	/* Elf information */
	struct klp_modinfo *klp_info;
#endif

Many other subsystems have their stuff there, for example:

#ifdef CONFIG_TRACING
	unsigned int num_trace_bprintk_fmt;
	const char **trace_bprintk_fmt_start;
#endif
#ifdef CONFIG_EVENT_TRACING
	struct trace_event_call **trace_events;
	unsigned int num_trace_events;
	struct trace_eval_map **trace_evals;
	unsigned int num_trace_evals;
#endif
#ifdef CONFIG_FTRACE_MCOUNT_RECORD
	unsigned int num_ftrace_callsites;
	unsigned long *ftrace_callsites;
#endif
#ifdef CONFIG_KPROBES
	void *kprobes_text_start;
	unsigned int kprobes_text_size;
	unsigned long *kprobe_blacklist;
	unsigned int num_kprobe_blacklist;
#endif

BTW: Jessica originally worked on the kernel livepatching.
     She became module loader code maintainer because we needed
     even more hacks there and the original maintainer got
     busy with other stuff at that time ;-)

     I am pretty sure that she would accept it. We need a per-module
     value. It is not necessary to maintain separate global list/hash
     table just to store these values.

Best Regards,
Petr
