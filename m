Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8034F3A7ABC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 11:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhFOJhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 05:37:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:56074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231466AbhFOJhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 05:37:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37E2D6144B;
        Tue, 15 Jun 2021 09:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623749730;
        bh=//ryPHpmp2BAyP61p1XXbD/iGY7SyIxTQHpJ3qxKUsY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Wthh4K6pbfGMqdNoCho+1uibmQaKu8dVqI/Ny8tQ4r1EqRvbdXWxF0rly83dVPWEG
         tyHpvXGx28sC93hmNYpdVUwDCnH6jDtdtVSEtefsOO7mn58PVX5401DcTKB/5ZFWln
         vJRTtRq6Re3si16esc/Ig4FHW0lH6HFBNCWIlc55nfIW44Pbdn0Zz28P4U1Xo8jRUx
         /iMyx0q1f6v3AYLrx7Husl1ESfiNYehmQKeSE3jSyys6Hj7tMqDYaSKzfkO40aAigV
         MpQKovuNt/0rNWQQ5myQEVi+xzl3VHrehtak19fObyxPYOM3r7TuQ3EoiFVyU0Xifp
         MDS6LDM0NaFmA==
Date:   Tue, 15 Jun 2021 18:35:27 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Anton Blanchard <anton@ozlabs.org>
Subject: Re: [PATCH 2/2] trace/kprobe: Remove limit on kretprobe maxactive
Message-Id: <20210615183527.9068ef2f70fdd2a45fea78f0@kernel.org>
In-Reply-To: <a751a0617a2c06e7e233f2c98ccabe8b94a8076d.1623693448.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1623693448.git.naveen.n.rao@linux.vnet.ibm.com>
        <a751a0617a2c06e7e233f2c98ccabe8b94a8076d.1623693448.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jun 2021 23:33:29 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> We currently limit maxactive for a kretprobe to 4096 when registering
> the same through tracefs. The comment indicates that this is done so as
> to keep list traversal reasonable. However, we don't ever iterate over
> all kretprobe_instance structures. The core kprobes infrastructure also
> imposes no such limitation.
> 
> Remove the limit from the tracefs interface. This limit is easy to hit
> on large cpu machines when tracing functions that can sleep.
> 
> Reported-by: Anton Blanchard <anton@ozlabs.org>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

OK, but I don't like to just remove the limit (since it can cause
memory shortage easily.)
Can't we make it configurable? I don't mean Kconfig, but 
tracefs/options/kretprobe_maxactive, or kprobes's debugfs knob.

Hmm, maybe debugfs/kprobes/kretprobe_maxactive will be better since
it can limit both trace_kprobe and kprobes itself.

Let me fix that.

Thank you,

> ---
>  kernel/trace/trace_kprobe.c                               | 8 --------
>  kernel/trace/trace_probe.h                                | 1 -
>  .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc          | 1 -
>  .../selftests/ftrace/test.d/kprobe/kretprobe_maxactive.tc | 3 ---
>  4 files changed, 13 deletions(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 0475e2a6d0825e..b3e214980eed3d 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -21,7 +21,6 @@
>  #include "trace_probe_tmpl.h"
>  
>  #define KPROBE_EVENT_SYSTEM "kprobes"
> -#define KRETPROBE_MAXACTIVE_MAX 4096
>  
>  /* Kprobe early definition from command line */
>  static char kprobe_boot_events_buf[COMMAND_LINE_SIZE] __initdata;
> @@ -786,13 +785,6 @@ static int __trace_kprobe_create(int argc, const char *argv[])
>  			trace_probe_log_err(1, BAD_MAXACT);
>  			goto parse_error;
>  		}
> -		/* kretprobes instances are iterated over via a list. The
> -		 * maximum should stay reasonable.
> -		 */
> -		if (maxactive > KRETPROBE_MAXACTIVE_MAX) {
> -			trace_probe_log_err(1, MAXACT_TOO_BIG);
> -			goto parse_error;
> -		}
>  	}
>  
>  	/* try to parse an address. if that fails, try to read the
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index 227d518e5ba521..e331017dc086ed 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -389,7 +389,6 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
>  	C(BAD_UPROBE_OFFS,	"Invalid uprobe offset"),		\
>  	C(MAXACT_NO_KPROBE,	"Maxactive is not for kprobe"),		\
>  	C(BAD_MAXACT,		"Invalid maxactive number"),		\
> -	C(MAXACT_TOO_BIG,	"Maxactive is too big"),		\
>  	C(BAD_PROBE_ADDR,	"Invalid probed address or symbol"),	\
>  	C(BAD_RETPROBE,		"Retprobe address must be an function entry"), \
>  	C(BAD_ADDR_SUFFIX,	"Invalid probed address suffix"), \
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> index fa928b431555ca..be3360a258bae8 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> @@ -10,7 +10,6 @@ check_error() { # command-with-error-pos-by-^
>  if grep -q 'r\[maxactive\]' README; then
>  check_error 'p^100 vfs_read'		# MAXACT_NO_KPROBE
>  check_error 'r^1a111 vfs_read'		# BAD_MAXACT
> -check_error 'r^100000 vfs_read'		# MAXACT_TOO_BIG
>  fi
>  
>  check_error 'p ^non_exist_func'		# BAD_PROBE_ADDR (enoent)
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_maxactive.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_maxactive.tc
> index 4f0b268c12332a..f57c95bfc5ed5a 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_maxactive.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_maxactive.tc
> @@ -6,9 +6,6 @@
>  # Test if we successfully reject unknown messages
>  if echo 'a:myprobeaccept inet_csk_accept' > kprobe_events; then false; else true; fi
>  
> -# Test if we successfully reject too big maxactive
> -if echo 'r1000000:myprobeaccept inet_csk_accept' > kprobe_events; then false; else true; fi
> -
>  # Test if we successfully reject unparsable numbers for maxactive
>  if echo 'r10fuzz:myprobeaccept inet_csk_accept' > kprobe_events; then false; else true; fi
>  
> -- 
> 2.31.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
