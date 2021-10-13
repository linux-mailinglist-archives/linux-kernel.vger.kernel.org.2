Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E5042C3B5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236544AbhJMOoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:44:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235047AbhJMOoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:44:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3C3B61105;
        Wed, 13 Oct 2021 14:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634136130;
        bh=KwuYyfdemtWn5MRmGDMrhkZLYCPaqwUl3J/lNUcfzV0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iQ+07OvBnnwAzU2XVffEsQ/AWc9hVh6BRjNw6eQQt2JBQo3Dt3YP0mWyg5/qRmnK4
         6vXl1zkBYMKFezf2gXJ3GaAv7tF1+yz6fGSDyJZVa/W7sBwIXbFskOLQT+pI468vPS
         fbITsk2Pa9No8vlnkqA7EtotIlh3Ov5lyI0cYdDyt+afZ3k5uL5ebrpIb2FUey/u/g
         Q14cIlB2t+LkArZaAm/co82k2GkA3bZxpVCPHREjYbb3Mij7++GyHbIPhw0BbcOYUd
         kBIWzj6lb0mFSB2g1JUVbrsjUKBctSgGGUiC+Mt+f4VMxWPSD4SN020XfYc0RE91tD
         SHbbfAdYDVFUg==
Date:   Wed, 13 Oct 2021 23:42:06 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Yordan Karadzhov <y.karadz@gmail.com>
Subject: Re: [PATCH v2] tracing: Fix event probe removal from dynamic events
Message-Id: <20211013234206.37dd18ffcc2a2cbf4493f125@kernel.org>
In-Reply-To: <20211012200856.6e5b8f28@gandalf.local.home>
References: <20211012081925.0e19cc4f@gandalf.local.home>
        <20211012233107.671725f6ec0316b3d0a9dd85@kernel.org>
        <20211012120310.2f742adb@gandalf.local.home>
        <20211013074226.d521cf9ddf378db20f77f043@kernel.org>
        <20211012200856.6e5b8f28@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2021 20:08:56 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 13 Oct 2021 07:42:26 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Tue, 12 Oct 2021 12:03:10 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > On Tue, 12 Oct 2021 23:31:07 +0900
> > > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >   
> > > > Hmm, this seems something wrong. Via dynamic_events interface, all the
> > > > events must be parsed equaly. If you have to pass the attached "system/event"
> > > > that's something wrong. The dynamic_events interface will accept 
> > > > 
> > > > -:[GROUP/]EVENT [optional arguments]
> > > > 
> > > > Or
> > > > 
> > > > !e:[GROUP/]EVENT [optional arguments]
> > > > 
> > > > What did you expect other that these syntax?  
> > > 
> > > But there are non "optional arguments".
> > > 
> > > To create the event probe, we need to send:
> > > 
> > >   e:[GROUP/]EVENT system/event [optional arguments]
> > > 
> > > Where the "system/event" is what we attach to. Similar to adding a function
> > > or address to kprobes. Do you not need to add that for deleting a kprobe?  
> > 
> > No, since if the GROUP name is given, we can identify the event.
> > 
> > And sorry. I misunderstood your patch, simply I mixed the group/event is
> > the name of group/event or the attached group/event.
> 
> The GROUP/EVENT is the name of the created eprobe, my "system/event" is the
> name of the probe being attached.

OK, I understand that.

> 
> > 
> > Actually, the dynamic_events delete command is something like wildcard
> > unless you specify the options.
> 
> OK, so we need to update this a little bit more. But currently, it fails if
> you do:
> 
>  # echo 'e:hrstate timer/hrtimer_cancel state=+0x38($hrtimer):u8' >> dynamic_events
>  # cat dynamic_events
> eprobes/hrstate timer.hrtimer_cancel state=+0x38($hrtimer):u8

BTW, Isn't there 'e:' prefix like below?
e:eprobes/hrstate timer.hrtimer_cancel state=+0x38($hrtimer):u8

>  # echo '-:eprobes/hrstate timer.hrtimer_cancel state=+0x38($hrtimer):u8' >> dynamic_events
> 
> It will error out with "-EBUSY".

That may be another reason. (Did you enable the eprobes/hrstate?)
If the event doesn't match, it will return -ENOENT.

> 
> It would make sense if we echo in exactly what is in dynamic_events with
> "-:" in front of it it, that it will remove it. But currently, it expects:
> 
>  # echo '-:eprobes/hrstate state=+0x38($hrtimer):u8' >> dynamic_events
> 
> Which is completely wrong.

Ah, I see what was wrong... you used trace_probe_match_command_args() but
didn't skip the attached system/event. Thus the patch check and skipped it.

> > > That is, if I create a kprobe with:
> > > 
> > >   p:myprobe schedule > dynamic_events
> > > 
> > > To remove it, don't we need to have:
> > > 
> > >   -:myprobe schedule >> dynamic_events  
> > 
> > Yes, it is possible. But you can also do
> > 
> >  -:kprobes/myprobe >> dynamic_events 
> > 
> > So, the "schedule" trace point is optional.
> > 
> > Anyway, let me comment on your patch again.
> 
> OK, we can make it optional, but we need to fix it so that it also works.

Agreed.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
