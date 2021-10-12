Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD75542AFC0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 00:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbhJLWoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 18:44:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229588AbhJLWob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 18:44:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1966C60C4A;
        Tue, 12 Oct 2021 22:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634078549;
        bh=7f2uhrc9DSaxq7RL+5PA2aSEOWNrIpL1ssB5AlN8hZc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PXcxPvoO7EaGUYUxpJao+tk4piOlAKn4svhJMyPRyX8hlIUGkJWQsubcZ0rNDM1uk
         1h/TMCCDD9WgoFxtGdfmoTNrhIIQ9o2KD+alJtWfJ5CWUDginB5kguCpIFMUjqejdS
         FIV+b32R/yoCSKIWmgVukHdqUKF9gDDFLD7kU5hF017Q6NAlB7HnrV/fJcjMQzXfjj
         O431kMuZI4MiAfXaJXXdw7fAAa4ATAVvWiLyLqkKp1XrVF/aXoDFGGIxfrcyG5xL46
         2BQVdw7VXKebe5vFFRgBnpNAEevwk7ZGKfKVd5GrbrmIYZg1+g4KZ+Mo0Tgjn725tg
         pIknvAXGXAi2g==
Date:   Wed, 13 Oct 2021 07:42:26 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Yordan Karadzhov <y.karadz@gmail.com>
Subject: Re: [PATCH v2] tracing: Fix event probe removal from dynamic events
Message-Id: <20211013074226.d521cf9ddf378db20f77f043@kernel.org>
In-Reply-To: <20211012120310.2f742adb@gandalf.local.home>
References: <20211012081925.0e19cc4f@gandalf.local.home>
        <20211012233107.671725f6ec0316b3d0a9dd85@kernel.org>
        <20211012120310.2f742adb@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2021 12:03:10 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 12 Oct 2021 23:31:07 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Hmm, this seems something wrong. Via dynamic_events interface, all the
> > events must be parsed equaly. If you have to pass the attached "system/event"
> > that's something wrong. The dynamic_events interface will accept 
> > 
> > -:[GROUP/]EVENT [optional arguments]
> > 
> > Or
> > 
> > !e:[GROUP/]EVENT [optional arguments]
> > 
> > What did you expect other that these syntax?
> 
> But there are non "optional arguments".
> 
> To create the event probe, we need to send:
> 
>   e:[GROUP/]EVENT system/event [optional arguments]
> 
> Where the "system/event" is what we attach to. Similar to adding a function
> or address to kprobes. Do you not need to add that for deleting a kprobe?

No, since if the GROUP name is given, we can identify the event.

And sorry. I misunderstood your patch, simply I mixed the group/event is
the name of group/event or the attached group/event.

Actually, the dynamic_events delete command is something like wildcard
unless you specify the options.

> 
> That is, if I create a kprobe with:
> 
>   p:myprobe schedule > dynamic_events
> 
> To remove it, don't we need to have:
> 
>   -:myprobe schedule >> dynamic_events

Yes, it is possible. But you can also do

 -:kprobes/myprobe >> dynamic_events 

So, the "schedule" trace point is optional.

Anyway, let me comment on your patch again.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
