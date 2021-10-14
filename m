Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F6742DAD2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 15:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhJNNwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 09:52:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:52758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231639AbhJNNws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 09:52:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 223F1610CF;
        Thu, 14 Oct 2021 13:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634219443;
        bh=K0W0hKGyjfFO1U06aIOcgJEPpZbe/PT4zdtCvDdyUus=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K1zBSuA/a++xMuHbWTwwfKRItfCw5mlPlpivgA+yyhaMEivRDMPdUOOCBM1tmuSvQ
         8ObbrKt9UC+5ttt8danTDZc6zX5mJ8eHDw8JiXphhAO1el7ByOVcLCGHHdgmYXJcNO
         tIlqaIe8XExr2P/MBvSDQeIi+kS0ohu/2JwNV/hbFY00jT22ipa4BLuEDyk99gQo8D
         vVZarOloqz6fdmhGqODznMNeU/7bO/V2NQJ24wPbdQwRH2BOBLn+9fbt0kR7grH/o3
         1qCqdK7ujRU124pxP2AV2BGtzzQZb+E42ezW826OPmkIZto+BuBcnurLC3FdET6jkf
         LoNLOQGCm+pEw==
Date:   Thu, 14 Oct 2021 22:50:39 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
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
Message-Id: <20211014225039.b96ff7b7fa86f340ceb50192@kernel.org>
In-Reply-To: <20211014102702.GB13770@C02TD0UTHF1T.local>
References: <163369609308.636038.15295764725220907794.stgit@devnote2>
        <163369611948.636038.11552166777773804729.stgit@devnote2>
        <20211013100126.GA3187@C02TD0UTHF1T.local>
        <20211014170405.f59d287b30086efe7dd7f4d9@kernel.org>
        <20211014091332.GA13770@C02TD0UTHF1T.local>
        <20211014190155.3fdc7cf7c42e44ee75c43a9d@kernel.org>
        <20211014102702.GB13770@C02TD0UTHF1T.local>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2021 11:27:02 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> On Thu, Oct 14, 2021 at 07:01:55PM +0900, Masami Hiramatsu wrote:
> > On Thu, 14 Oct 2021 10:13:32 +0100
> > Mark Rutland <mark.rutland@arm.com> wrote:
> > 
> > > On Thu, Oct 14, 2021 at 05:04:05PM +0900, Masami Hiramatsu wrote:
> > > > On Wed, 13 Oct 2021 11:01:39 +0100
> > > > Mark Rutland <mark.rutland@arm.com> wrote:
> > > > 
> > > > > On Fri, Oct 08, 2021 at 09:28:39PM +0900, Masami Hiramatsu wrote:
> > > > > > Record the frame pointer instead of stack address with kretprobe
> > > > > > instance as the identifier on the instance list.
> > > > > > Since arm64 always enable CONFIG_FRAME_POINTER, we can use the
> > > > > > actual frame pointer (x29).
> > > > > 
> > > > > Just to check, why do we need to use the FP rather than SP? It wasn't
> > > > > clear to me if that's necessary later in the series, or if I'm missing
> > > > > something here.
> > > > 
> > > > Actually, this is for finding correct return address from the per-task
> > > > kretprobe instruction list (suppose it as a shadow stack) when it will
> > > > be searched in stack-backtracing. At that point, the framepointer will
> > > > be a reliable key.
> > > 
> > > Sure, my question was more "why isn't the SP a reliable key?", because both
> > > the SP and FP should be balanced at function-entry and function-return
> > > time. I'm asking because I think I'm missing a subtlety.
> > 
> > Ah, because SP is not used while unwinding frame. For the kretprobe,
> > either FP or SP is OK. But for the stacktrace.c, I can not use SP
> > and is easy to change to use FP. :)
> 
> Ah, so this is just so that stacktrace can match the address. For
> clarity, would you be happy to add a sentence to the commit message like:
> 
> | This will allow the stacktrace code to find the original return
> | address from the FP alone.

Yes, I'm happy to update the changelog :)

Thanks!

> 
> Thanks,
> Mark.


-- 
Masami Hiramatsu <mhiramat@kernel.org>
