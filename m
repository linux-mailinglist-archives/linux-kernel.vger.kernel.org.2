Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B10A436AAC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 20:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbhJUSkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 14:40:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:36108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231616AbhJUSka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 14:40:30 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8210F611BD;
        Thu, 21 Oct 2021 18:38:13 +0000 (UTC)
Date:   Thu, 21 Oct 2021 14:38:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Will Deacon <will@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
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
Message-ID: <20211021143811.6f42b942@gandalf.local.home>
In-Reply-To: <20211021125943.11c10133@gandalf.local.home>
References: <163477765570.264901.3851692300287671122.stgit@devnote2>
        <163477770935.264901.1772964361191833681.stgit@devnote2>
        <20211021101512.GA16485@willie-the-truck>
        <20211021232630.94bea4540670cdab5a7a63c5@kernel.org>
        <20211021104902.2600dd0a@gandalf.local.home>
        <20211021165241.GB16889@willie-the-truck>
        <20211021125943.11c10133@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2021 12:59:43 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > Happy debugging :)  
> 
> Found the bug. I'll restart my tests (takes around 13 hours more or less to
> complete) and when/if they succeed, I'll push it for inclusion in
> linux-next.

And of course, more bugs appear. Nothing (yet) to do with this patch
series, but as I started running tests I haven't run yet, it's triggering
bugs in other places that I need to go sort out :-p

-- Steve
