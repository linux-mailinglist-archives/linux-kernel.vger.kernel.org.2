Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2482042D71D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 12:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhJNK3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 06:29:14 -0400
Received: from foss.arm.com ([217.140.110.172]:52742 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230179AbhJNK3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 06:29:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7D6611D4;
        Thu, 14 Oct 2021 03:27:07 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.73.197])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C1D93F66F;
        Thu, 14 Oct 2021 03:27:05 -0700 (PDT)
Date:   Thu, 14 Oct 2021 11:27:02 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/8] arm64: kprobes: Record frame pointer with kretprobe
 instance
Message-ID: <20211014102702.GB13770@C02TD0UTHF1T.local>
References: <163369609308.636038.15295764725220907794.stgit@devnote2>
 <163369611948.636038.11552166777773804729.stgit@devnote2>
 <20211013100126.GA3187@C02TD0UTHF1T.local>
 <20211014170405.f59d287b30086efe7dd7f4d9@kernel.org>
 <20211014091332.GA13770@C02TD0UTHF1T.local>
 <20211014190155.3fdc7cf7c42e44ee75c43a9d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014190155.3fdc7cf7c42e44ee75c43a9d@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 07:01:55PM +0900, Masami Hiramatsu wrote:
> On Thu, 14 Oct 2021 10:13:32 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > On Thu, Oct 14, 2021 at 05:04:05PM +0900, Masami Hiramatsu wrote:
> > > On Wed, 13 Oct 2021 11:01:39 +0100
> > > Mark Rutland <mark.rutland@arm.com> wrote:
> > > 
> > > > On Fri, Oct 08, 2021 at 09:28:39PM +0900, Masami Hiramatsu wrote:
> > > > > Record the frame pointer instead of stack address with kretprobe
> > > > > instance as the identifier on the instance list.
> > > > > Since arm64 always enable CONFIG_FRAME_POINTER, we can use the
> > > > > actual frame pointer (x29).
> > > > 
> > > > Just to check, why do we need to use the FP rather than SP? It wasn't
> > > > clear to me if that's necessary later in the series, or if I'm missing
> > > > something here.
> > > 
> > > Actually, this is for finding correct return address from the per-task
> > > kretprobe instruction list (suppose it as a shadow stack) when it will
> > > be searched in stack-backtracing. At that point, the framepointer will
> > > be a reliable key.
> > 
> > Sure, my question was more "why isn't the SP a reliable key?", because both
> > the SP and FP should be balanced at function-entry and function-return
> > time. I'm asking because I think I'm missing a subtlety.
> 
> Ah, because SP is not used while unwinding frame. For the kretprobe,
> either FP or SP is OK. But for the stacktrace.c, I can not use SP
> and is easy to change to use FP. :)

Ah, so this is just so that stacktrace can match the address. For
clarity, would you be happy to add a sentence to the commit message like:

| This will allow the stacktrace code to find the original return
| address from the FP alone.

Thanks,
Mark.
