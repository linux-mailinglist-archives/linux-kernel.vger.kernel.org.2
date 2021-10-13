Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA48142B0DC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 02:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235323AbhJMALB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 20:11:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:58602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234483AbhJMALA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 20:11:00 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF67D60041;
        Wed, 13 Oct 2021 00:08:57 +0000 (UTC)
Date:   Tue, 12 Oct 2021 20:08:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Yordan Karadzhov <y.karadz@gmail.com>
Subject: Re: [PATCH v2] tracing: Fix event probe removal from dynamic events
Message-ID: <20211012200856.6e5b8f28@gandalf.local.home>
In-Reply-To: <20211013074226.d521cf9ddf378db20f77f043@kernel.org>
References: <20211012081925.0e19cc4f@gandalf.local.home>
        <20211012233107.671725f6ec0316b3d0a9dd85@kernel.org>
        <20211012120310.2f742adb@gandalf.local.home>
        <20211013074226.d521cf9ddf378db20f77f043@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2021 07:42:26 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Tue, 12 Oct 2021 12:03:10 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Tue, 12 Oct 2021 23:31:07 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >   
> > > Hmm, this seems something wrong. Via dynamic_events interface, all the
> > > events must be parsed equaly. If you have to pass the attached "system/event"
> > > that's something wrong. The dynamic_events interface will accept 
> > > 
> > > -:[GROUP/]EVENT [optional arguments]
> > > 
> > > Or
> > > 
> > > !e:[GROUP/]EVENT [optional arguments]
> > > 
> > > What did you expect other that these syntax?  
> > 
> > But there are non "optional arguments".
> > 
> > To create the event probe, we need to send:
> > 
> >   e:[GROUP/]EVENT system/event [optional arguments]
> > 
> > Where the "system/event" is what we attach to. Similar to adding a function
> > or address to kprobes. Do you not need to add that for deleting a kprobe?  
> 
> No, since if the GROUP name is given, we can identify the event.
> 
> And sorry. I misunderstood your patch, simply I mixed the group/event is
> the name of group/event or the attached group/event.

The GROUP/EVENT is the name of the created eprobe, my "system/event" is the
name of the probe being attached.

> 
> Actually, the dynamic_events delete command is something like wildcard
> unless you specify the options.

OK, so we need to update this a little bit more. But currently, it fails if
you do:

 # echo 'e:hrstate timer/hrtimer_cancel state=+0x38($hrtimer):u8' >> dynamic_events
 # cat dynamic_events
eprobes/hrstate timer.hrtimer_cancel state=+0x38($hrtimer):u8
 # echo '-:eprobes/hrstate timer.hrtimer_cancel state=+0x38($hrtimer):u8' >> dynamic_events

It will error out with "-EBUSY".

It would make sense if we echo in exactly what is in dynamic_events with
"-:" in front of it it, that it will remove it. But currently, it expects:

 # echo '-:eprobes/hrstate state=+0x38($hrtimer):u8' >> dynamic_events

Which is completely wrong.


> 
> > 
> > That is, if I create a kprobe with:
> > 
> >   p:myprobe schedule > dynamic_events
> > 
> > To remove it, don't we need to have:
> > 
> >   -:myprobe schedule >> dynamic_events  
> 
> Yes, it is possible. But you can also do
> 
>  -:kprobes/myprobe >> dynamic_events 
> 
> So, the "schedule" trace point is optional.
> 
> Anyway, let me comment on your patch again.

OK, we can make it optional, but we need to fix it so that it also works.

-- Steve
