Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4153A437C8C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 20:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbhJVSZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 14:25:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:52470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233615AbhJVSZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 14:25:30 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B765561163;
        Fri, 22 Oct 2021 18:23:11 +0000 (UTC)
Date:   Fri, 22 Oct 2021 14:23:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/9] kprobes: Add a test case for stacktrace from
 kretprobe handler
Message-ID: <20211022142310.62c3baa7@gandalf.local.home>
In-Reply-To: <20211022121537.32821979@gandalf.local.home>
References: <163477765570.264901.3851692300287671122.stgit@devnote2>
        <163477767243.264901.10894979830215919916.stgit@devnote2>
        <20211022121537.32821979@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2021 12:15:37 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> I'm going to continue testing my code, as I have over 40 patches that need
> to go into next. I'll just rebase removing this commit only (hopefully
> nothing else breaks), and if everything then passes, I'll push to next.

My tests are now back at the allmodconfig (did most the tests, but not all,
to save time), hopefully it will pass this time ;-)

What I plan on posting soon is located here (if you want to see them).

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
  branch: ftrace/core

-- Steve
