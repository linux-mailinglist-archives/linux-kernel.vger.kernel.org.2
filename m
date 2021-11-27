Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112A946017F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 21:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356225AbhK0Urp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 15:47:45 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41684 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240806AbhK0Upo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 15:45:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5AA660EBA
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 20:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F01C53FBF;
        Sat, 27 Nov 2021 20:42:28 +0000 (UTC)
Date:   Sat, 27 Nov 2021 15:42:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Subject: Re: [GIT PULL] tracing: Two event pid filtering bug fixes
Message-ID: <20211127154226.60aea92a@oasis.local.home>
In-Reply-To: <CAHk-=wiJn3L26=1m4RAeGJ-PFQkrqGNCgdH1bWu7+XJKtwfvgw@mail.gmail.com>
References: <20211127132822.5d4d2a8b@gandalf.local.home>
        <CAHk-=wiJn3L26=1m4RAeGJ-PFQkrqGNCgdH1bWu7+XJKtwfvgw@mail.gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Nov 2021 12:12:55 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, Nov 27, 2021 at 10:28 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Two fixes to event pid filtering:
> >
> > - Have created events reflect the current state of pid filtering
> >
> > - Test pid filtering on discard test of recorded logic.
> >   (Also clean up the if statement to be cleaner).  
> 
> I could not parse either of those statements. The second one in
> particular is just a jumble of random words in a random order.

Ouch, rereading that I see what you mean. I guess it was a combination
of Thanksgiving Turkey, then finding out my email isn't going out due
to the updates to mail.kernel.org (which was acting as my smarthost
relay), and my wife wondering where I am (as I wasn't doing the chores
she asked me to), so I was in a bit of a rush to get the pull request
out after it had passed all my tests.

> 
> I tried to make it make sense by looking at the commits themselves,
> but who knows. Maybe I made it worse by turning it from
> incomprehensible to actively wrong.

First change:

 - If pid filtering is enabled, a flag is set to the file descriptor of
   the event for the instance buffer that has pid filtering enabled.
   This flag is checked at the time of triggering to know if the event
   should be traced or not. The problem was when an event was created
   (by module load, kprobe, eprobe, etc), a file descriptor is create
   in each instance, but it wasn't updating the pid filtering flag for
   that event. Hence, those events would start tracing on every
   task and not honor the pid filter.

Second change:

 - Even if an event is filtered out, it could have a "trigger"
   associated it it (triggers do actions based on the event fields,
   like a stack dump into the tracing buffer, or a histogram, or even
   disable tracing). Thus, the event is recorded into a temporary
   buffer so its fields may be used by the trigger. But after the
   trigger has run, it needs to know if that event should be recorded
   into the trace buffer or not, so the filtering is executed again (if
   the event is to be filtered it is discarded). But this second check
   did not take into account pid filtering, and so if an event had a
   trigger attached to it, it did not honor the pid filters, and traced
   for all processes.

Better?

> 
> Please make those explanations more clear in the future, ok?

This was a unique situation. I hope to be better next time.

-- Steve
