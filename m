Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796FA42C6D3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 18:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbhJMQz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 12:55:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230118AbhJMQz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 12:55:28 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F2206052B;
        Wed, 13 Oct 2021 16:53:24 +0000 (UTC)
Date:   Wed, 13 Oct 2021 12:53:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Yordan Karadzhov <y.karadz@gmail.com>
Subject: Re: [PATCH v2] tracing: Fix event probe removal from dynamic events
Message-ID: <20211013125322.49098953@gandalf.local.home>
In-Reply-To: <20211013234206.37dd18ffcc2a2cbf4493f125@kernel.org>
References: <20211012081925.0e19cc4f@gandalf.local.home>
        <20211012233107.671725f6ec0316b3d0a9dd85@kernel.org>
        <20211012120310.2f742adb@gandalf.local.home>
        <20211013074226.d521cf9ddf378db20f77f043@kernel.org>
        <20211012200856.6e5b8f28@gandalf.local.home>
        <20211013234206.37dd18ffcc2a2cbf4493f125@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2021 23:42:06 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > > Actually, the dynamic_events delete command is something like wildcard
> > > unless you specify the options.  
> > 
> > OK, so we need to update this a little bit more. But currently, it fails if
> > you do:
> > 
> >  # echo 'e:hrstate timer/hrtimer_cancel state=+0x38($hrtimer):u8' >> dynamic_events
> >  # cat dynamic_events
> > eprobes/hrstate timer.hrtimer_cancel state=+0x38($hrtimer):u8  
> 
> BTW, Isn't there 'e:' prefix like below?
> e:eprobes/hrstate timer.hrtimer_cancel state=+0x38($hrtimer):u8

Yes, that works too, but you can leave off the GROUP/ when creating the
event, which it will default to "eprobes/".

> 
> >  # echo '-:eprobes/hrstate timer.hrtimer_cancel state=+0x38($hrtimer):u8' >> dynamic_events
> > 
> > It will error out with "-EBUSY".  
> 
> That may be another reason. (Did you enable the eprobes/hrstate?)
> If the event doesn't match, it will return -ENOENT.

Hmm, now trying to reproduce it, I'm getting:

  -bash: echo: write error: No such file or directory

Which would be -ENOENT. Before I was getting -EBUSY when attaching eprobes
to kprobes with your $$args patch. But that's not applied right now, so I
can't try to reproduce it at the moment. I probably hit something else at
the time anyway.

But still, it's broken, and I need to fix it. I'll make the updates to
allow the above. Perhaps I'll include a test that tests the above too.

-- Steve

