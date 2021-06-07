Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55D539E54C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 19:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhFGR0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 13:26:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231222AbhFGR00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 13:26:26 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 753CE61078;
        Mon,  7 Jun 2021 17:24:34 +0000 (UTC)
Date:   Mon, 7 Jun 2021 13:24:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jacob Wen <jian.w.wen@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] tracing: Add a verifier to check string pointers
 for trace events
Message-ID: <20210607132432.08287102@oasis.local.home>
In-Reply-To: <YL5DE9vqDG/fUSMh@google.com>
References: <20210226185909.100032746@goodmis.org>
        <20210226190705.871102407@goodmis.org>
        <YLrRUmwjjaozIt4K@google.com>
        <20210604222830.2505d67a@rorschach.local.home>
        <20210604224544.134c652f@rorschach.local.home>
        <YL5DE9vqDG/fUSMh@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jun 2021 16:02:27 +0000
Sean Christopherson <seanjc@google.com> wrote:

> I assumed that was the gist of the unsafe string detection, but the module core
> data exemption confused me.  I take it that the tracepoint itself goes away if
> the module is unloaded?  I.e. it's safe for a module to pass a constant string to
> its own tracepoints, but not to tracepoints defined elsewhere?  The comment
> above tracepoint_string() seems to confirm this.


If a trace event of a module was enabled, a flag is set, so that when
that module is unloaded, the ring buffer that it was enabled in is
cleared. That's because there's more data that is referenced about the
trace event then just strings. And referencing that data is dangerous
if it no longer exists.

> 
> > There's two fixes you can do with this. One is to covert that to use
> > __string, the other is to do what RCU does, and use the
> > tracepoint_string() functionality.

I realize now that tracepoint_string() is not a work around. It only is
or exporting the string to user space. The __string option is really
the only fix here.



> This doesn't appear to be correct.  Were you thinking of something else?
> 
> Unless I'm misreading the code and section output, tracepoint_string() just saves
> a pointer to the string into a dedicated section, it doesn't magically hoist the
> string itself into the kernel proper.  And I can't see how that would work, e.g.
> if the module is compiled and linked independent from the core kernel.

That is correct. I was mistaken about it. It has some code to track
unloading, and I was thinking it saved the string itself, but that is
not correct.

> 
> And the comment above the macro strongly suggests that persistence needs to be
> guaranteed by the entity using tracepoint_string().  Testing bears this out, e.g.
> the WARN and UNSAFE_MEMORY errors still happen when using tracepoint_string().

That is correct. I misspoke when I suggested using it. :-/


> 
>  * The @str used must be a constant string and persistent as it would not
>  * make sense to show a string that no longer exists. But it is still fine
>  * to be used with modules, because when modules are unloaded, if they
>  * had tracepoints, the ring buffers are cleared too. As long as the string
>  * does not change during the life of the module, it is fine to use
>  * tracepoint_string() within a module.
>  */
> #define tracepoint_string(str)						\
> 	({								\
> 		static const char *___tp_str __tracepoint_string = str; \
> 		___tp_str;						\
> 	})
> 
> 
> Thanks for the help!

No problem.

-- Steve
