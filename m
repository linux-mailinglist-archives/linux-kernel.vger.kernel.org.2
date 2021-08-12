Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6723EA986
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 19:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236117AbhHLRdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 13:33:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235761AbhHLRdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 13:33:40 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9168961019;
        Thu, 12 Aug 2021 17:33:13 +0000 (UTC)
Date:   Thu, 12 Aug 2021 13:33:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [GIT PULL] tracing: Fixes and clean ups for v5.14
Message-ID: <20210812133306.1c480741@oasis.local.home>
In-Reply-To: <CAHk-=whHxeUjaNrWOLb0qx=-nibRZzQomwkw9xMPH_aHCf=BWQ@mail.gmail.com>
References: <20210812112938.3748c7f5@oasis.local.home>
        <CAHk-=whHxeUjaNrWOLb0qx=-nibRZzQomwkw9xMPH_aHCf=BWQ@mail.gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2021 07:18:37 -1000
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, Aug 12, 2021 at 5:29 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > - Fix warning for use of "main" variable in osnoise tracer  
> 
> Honestly, I refuse to pull this kind of inexplicable garbage.

That was my take too, when this was first addressed:

  https://lore.kernel.org/lkml/20210730204050.46975ae2@oasis.local.home/

> 
> The commit message talks about "some compilers/analyzers" without any
> explanation, and the "Link:" thing doesn't link to anything useful
> either.

I should have added the above link. :-/

Where the link in this commit was simply added by my scripts.

> 
> Those compilers/analyzers are clearly complete and utter crap, and my
> reaction is that I want a *lot* more explanation why we should care
> about other peoples crap.

I totally agree.

> 
> I do NOT want to see people caring about warnings that make no sense,
> certainly not without extensive explanations about why we should care
> about broken tools.
> 
> Fix the tool. Add a "--Wno-warn-about-stupid-issues" flag to the tool
> usage. Don't make pointless changes to the kernel to work around other
> peoples garbage.

:-) :-) :-)

I'm totally happy with this approach. I took the lazy method, and let
them change the variable.

But I'm 100% on your side of the issue. I HATE these stupid warnings.

I swear, these warnings are the gcc equivalent of spelling fixes to the
kernel. "Oh, I can get a patch into gcc via adding a new useless
warning!"

I'll drop the patch, and send you a v2.

-- Steve
