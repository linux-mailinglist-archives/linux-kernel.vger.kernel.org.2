Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0076C33D762
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 16:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236677AbhCPP2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 11:28:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233595AbhCPP2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 11:28:04 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CDC9650E4;
        Tue, 16 Mar 2021 15:28:02 +0000 (UTC)
Date:   Tue, 16 Mar 2021 11:28:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Sangmoon Kim <sangmoon.kim@samsung.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, jordan.lim@samsung.com,
        Ingo Molnar <mingo@redhat.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Gavin Shan <gshan@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: traps: add tracepoints for unusal exception
 cases
Message-ID: <20210316112800.3617ffd7@gandalf.local.home>
In-Reply-To: <20210308133149.GA4656@sirena.org.uk>
References: <CGME20210305124537epcas1p1930302083680f1b1cf87e37630556460@epcas1p1.samsung.com>
        <20210305123635.27492-1-sangmoon.kim@samsung.com>
        <20210308133149.GA4656@sirena.org.uk>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Mar 2021 13:31:49 +0000
Mark Brown <broonie@kernel.org> wrote:

> > @@ -832,6 +846,7 @@ void __noreturn arm64_serror_panic(struct pt_regs *regs, u32 esr)
> >  	if (regs)
> >  		__show_regs(regs);
> >  
> > +	trace_traps_serror_panic_tp(regs, esr);
> >  	nmi_panic(regs, "Asynchronous SError Interrupt");  
> 
> One of the concerns people have with adding tracepoints is that they can
> end up defining ABI so if we *are* going to add any then we need to
> think carefully about how they're defined.  As things currently stand
> they'll pass in the full pt_regs struct which includes not only what's
> defined by the hardware but also additional software defined information
> we store along with it like the stackframe which would be even more of a
> problem if it ends up getting used by someone in a way that ends up as
> ABI.  These are defined as bare tracehooks which does mitigate against
> things ending up getting used in ways that cause problems but people are
> still going to worry about things ending up getting relied on one way or
> another.
> 
> That said it's not clear to me that this will record anything beyond the
> pointer directly in the trace buffer so the value might not be useful
> for terribly long, that itself feels like it might not be as robust an
> interface as it should be.

BTW, we are working on an "event probe". That is similar to kprobe
event, but attaches to the output of an event to create another event.

Thus, if you had a trace event that was like this:

	trace_regs(pt_regs *regs);

Where you save the regs pointer for output:

	TP_STRUCT__entry(
		__field(void *, regs )
	),

	TP_fast_assign(
		__entry->regs = regs;
	)


Then you would be able to get access to all the regs for that tracepoint!

 # echo 'e:pt_regs regs ip=+8(regs):x64' > /sys/kernel/tracing/kprobe_events

Where "e:" denotes that this connects to a trace event, "pt_regs" is the
event name created under kprobes subsystem, "regs" is the trace event to
attach to, "ip=" is what will be printed, and "+8(regs):x64" is a way to
dereference the regs pointer at the time of the trace event is executed.
That is, it will dereference 8 bytes from the pointer and return a x64 hex
number.

Thus, trace events like this may be very useful in the near future.

-- Steve
