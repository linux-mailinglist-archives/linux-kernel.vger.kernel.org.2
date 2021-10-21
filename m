Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8404364B3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 16:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhJUOvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 10:51:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231424AbhJUOvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 10:51:21 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54E26611CE;
        Thu, 21 Oct 2021 14:49:04 +0000 (UTC)
Date:   Thu, 21 Oct 2021 10:49:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
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
Message-ID: <20211021104902.2600dd0a@gandalf.local.home>
In-Reply-To: <20211021232630.94bea4540670cdab5a7a63c5@kernel.org>
References: <163477765570.264901.3851692300287671122.stgit@devnote2>
        <163477770935.264901.1772964361191833681.stgit@devnote2>
        <20211021101512.GA16485@willie-the-truck>
        <20211021232630.94bea4540670cdab5a7a63c5@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2021 23:26:30 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > 
> > I'm not sure how you're planning to merge this, so please let me know if
> > you want me to queue any of the arm64 bits.  
> 
> Ah, good question. Since this part depends on the first 3 patches and
> Steve's tracing tree, these should go through the tracing tree. Is that
> OK for you?
> 

I'm OK with merging this.

> (Or, wait for merging the current tracing tree and merge rest of them.
>  but this will take a long time.)

And my linux-next is behind because my tests triggered a bug on one of my
arcane configs, and I'm still debugging it. :-p

-- Steve
