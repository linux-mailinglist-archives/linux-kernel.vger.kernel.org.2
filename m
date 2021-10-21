Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5182243685E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 18:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbhJUQzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 12:55:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229702AbhJUQzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 12:55:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BAB4B61205;
        Thu, 21 Oct 2021 16:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634835167;
        bh=6VzM2r6gVMujzCZ0KUTWduK45vE4GtzoGD/qhc4djN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GwBdi98HgwsdjmNXPfxn/iJ53dQk9VQb+5PM8rpJgbHs002xu52jBjMs71mFRk2un
         GU2oq1jLQ49iRHP3pLMVLq8SAgI4/P9hRvB1DmyIRc+J8alvTYmL9vsYhw5Ez6cDtA
         8YZfZZuofml2cDIi58hOk7T+y3ZJkWVv1DYMobkXu9I1cxrj7fqfMKzSMkJjfLt2ij
         kHe0uc+5WMHXyb8JKAwxedmVxrQhvVChe/MWLMGAusNoo+JCEAMXkbqgXC5zTNzrqX
         0Qf1aElvXn7FFv3jLriD9XtQHXL7dG5fgZeud3zpEAZPQbgUtGhvxGUG3t4qR/3J9R
         /SA17dBIUBj1Q==
Date:   Thu, 21 Oct 2021 17:52:42 +0100
From:   Will Deacon <will@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Message-ID: <20211021165241.GB16889@willie-the-truck>
References: <163477765570.264901.3851692300287671122.stgit@devnote2>
 <163477770935.264901.1772964361191833681.stgit@devnote2>
 <20211021101512.GA16485@willie-the-truck>
 <20211021232630.94bea4540670cdab5a7a63c5@kernel.org>
 <20211021104902.2600dd0a@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021104902.2600dd0a@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 10:49:02AM -0400, Steven Rostedt wrote:
> On Thu, 21 Oct 2021 23:26:30 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > > 
> > > I'm not sure how you're planning to merge this, so please let me know if
> > > you want me to queue any of the arm64 bits.  
> > 
> > Ah, good question. Since this part depends on the first 3 patches and
> > Steve's tracing tree, these should go through the tracing tree. Is that
> > OK for you?
> > 
> 
> I'm OK with merging this.

Ok, cool. I've acked the arm64 bits so I'll leave it in your hands!

> > (Or, wait for merging the current tracing tree and merge rest of them.
> >  but this will take a long time.)
> 
> And my linux-next is behind because my tests triggered a bug on one of my
> arcane configs, and I'm still debugging it. :-p

Happy debugging :)

Will
