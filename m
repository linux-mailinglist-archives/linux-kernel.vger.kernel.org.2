Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94841455167
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 01:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241759AbhKRADo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 19:03:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:60284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240415AbhKRADk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 19:03:40 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3540461B73;
        Thu, 18 Nov 2021 00:00:41 +0000 (UTC)
Date:   Wed, 17 Nov 2021 19:00:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [GIT PULL] tracing: Fix double free bug
Message-ID: <20211117190039.61d9746e@gandalf.local.home>
In-Reply-To: <CAHk-=wgcrEbFgkw9720H3tW-AhHOoEKhYwZinYJw4FpzSaJ6_Q@mail.gmail.com>
References: <20211117181922.3e9a2329@gandalf.local.home>
        <CAHk-=wgcrEbFgkw9720H3tW-AhHOoEKhYwZinYJw4FpzSaJ6_Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2021 15:38:59 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Nov 17, 2021 at 3:19 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On error, the operands and the histogram expression are destroyed,
> > but since the destruction is recursive, do not destroy the operands
> > if they already belong to the expression that is about to be destroyed.  
> 
> Honestly, this seems horribly ugly.

I guess we have a difference in opinion to what is ugly, as the v1 version
of Kalesh's patch was closer to yours, and I hated the complexity of having
to know when to to call what. Because the logic is not that simple.

See https://lore.kernel.org/all/20211117021223.2137117-1-kaleshsingh@google.com/

> 
> The problem seems to be that the "goto error" cases are simply just wrong.
> 
> Why isn't the fix to make the error cases be the right ones, instead
> of having one odd error case that then has to do some magic things to
> not free the wrong things?
> 
> The patch ends up a bit bigger, mainly because I renamed the different
> "free" cases, and because I made the non-freeing ones just return the
> error directly.

I agree with the first part of your patch, which was not the reason for
being the cause of the bug.

> 
> Something like this (UNTESTED!) patch, IOW?

But the part after the expr is allocated gets a bit more tricky, and that
is why I requested that logic, namely due to the "combine_consts" case. But
as the expr->operand[]s are NULL'd and the operand*s are destroyed, I guess
it's still fine with just freeing the expr if we add an error case there.

Kalesh, care to spin a v3 implementing Linus's solution?

-- Steve
