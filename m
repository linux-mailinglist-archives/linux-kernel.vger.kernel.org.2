Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44DF9436438
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 16:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbhJUO3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 10:29:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231331AbhJUO2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 10:28:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78DDF6120F;
        Thu, 21 Oct 2021 14:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634826394;
        bh=jfdEw2NewFPjeRp4KTG29+/+u+3mkuWccUasLnsv9Ks=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aQz24XFq3Wy0Wc6sePt3mOOLSc1LtLZOhlrd0Hyj2e5DET1jicrrO4d7SVxRjx8RM
         FDQiNoFuV9oGow5hg118avECfUIBUbYlBbmNvu1fHiY4lEXfqmI0t8jznxCuFsnC4u
         xXqlPW7XUAe/M2B+dt4iGU1TZAScFbke4C5KnC+RFS4KSXtp9wBbnAV+KyhHl+7ZwG
         822JAWeYe6mmShnlNe+3w9a9E6zM3uNUFl3UmOfQcu9iGoarOnZK7apI/XtfbETq+t
         /CDQTwlqCjJFFU95yfPJmaMPAsbKfhQf7I/1N0C2wThamPXxadKR4cJ4TagwsYcwdh
         FiOCN6flg/crQ==
Date:   Thu, 21 Oct 2021 23:26:30 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 6/9] arm64: Recover kretprobe modified return address
 in stacktrace
Message-Id: <20211021232630.94bea4540670cdab5a7a63c5@kernel.org>
In-Reply-To: <20211021101512.GA16485@willie-the-truck>
References: <163477765570.264901.3851692300287671122.stgit@devnote2>
        <163477770935.264901.1772964361191833681.stgit@devnote2>
        <20211021101512.GA16485@willie-the-truck>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2021 11:15:12 +0100
Will Deacon <will@kernel.org> wrote:

> On Thu, Oct 21, 2021 at 09:55:09AM +0900, Masami Hiramatsu wrote:
> > Since the kretprobe replaces the function return address with
> > the kretprobe_trampoline on the stack, stack unwinder shows it
> > instead of the correct return address.
> > 
> > This checks whether the next return address is the
> > __kretprobe_trampoline(), and if so, try to find the correct
> > return address from the kretprobe instance list. For this purpose
> > this adds 'kr_cur' loop cursor to memorize the current kretprobe
> > instance.
> > 
> > With this fix, now arm64 can enable
> > CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE, and pass the
> > kprobe self tests.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  Changes in v2:
> >   - Add comment for kr_cur.
> >   - Make the kretprobe related code depends on CONFIG_KRETPROBES.
> >   - Initialize "kr_cur" directly in start_backtrace() instead
> >     of clearing "frame" data structure by memset().
> > ---
> >  arch/arm64/Kconfig                  |    1 +
> >  arch/arm64/include/asm/stacktrace.h |    4 ++++
> >  arch/arm64/kernel/stacktrace.c      |    7 +++++++
> >  3 files changed, 12 insertions(+)
> 
> Acked-by: Will Deacon <will@kernel.org>

Thank you!

> 
> I'm not sure how you're planning to merge this, so please let me know if
> you want me to queue any of the arm64 bits.

Ah, good question. Since this part depends on the first 3 patches and
Steve's tracing tree, these should go through the tracing tree. Is that
OK for you?

(Or, wait for merging the current tracing tree and merge rest of them.
 but this will take a long time.)

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
