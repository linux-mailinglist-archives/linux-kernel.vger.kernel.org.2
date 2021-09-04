Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED264400C7B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 20:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237325AbhIDSM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 14:12:27 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:42652 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbhIDSMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 14:12:25 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mMa8Q-0016cN-Q0; Sat, 04 Sep 2021 18:11:23 +0000
Date:   Sat, 4 Sep 2021 18:11:22 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [possible bug] missed wakeup in do_sigtimedwait()?
Message-ID: <YTO2yrr3z45XtGWt@zeniv-ca.linux.org.uk>
References: <YTOF8VYTYNFYpB7O@zeniv-ca.linux.org.uk>
 <CAHk-=whho2pj4Au+rVpTGkoj7nJCEJwSfikLQVHDZ8kbKG7U1w@mail.gmail.com>
 <CAHk-=whx9iKutjLY6iRBHg2TTzSDXgrZ0-Uj5sUqhyQZZQ_yRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whx9iKutjLY6iRBHg2TTzSDXgrZ0-Uj5sUqhyQZZQ_yRQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2021 at 10:12:09AM -0700, Linus Torvalds wrote:
> On Sat, Sep 4, 2021 at 9:59 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I agree, that seems like a bug, and your fix seems the trivially correct thing.
> 
> Oh, never mind.  Signals are special.
> 
> Why?
> 
> Because TASK_INTERRUPTIBLE is special, and schedule() will check for
> "am I trying to sleep while a signal is pending" and will never
> actually sleep.
> 
> So you can't have missed wakeups from signals, because this sequence
> is perfectly ok, by design:
> 
>  - signal comes in and is pending
> 
>  - we set TASK_INTERRUPTIBLE
> 
>  - we are thinking about something *entirely* different, like looking
> at a pipe being emty
> 
>  - we schedule()
> 
> and the pending signal will just mean that we never go to sleep.
> 
> It's designed that way exactly so that people who have interruptible
> sleeps don't need to think about signals at all - they can concentrate
> on doing their own thing, and then do the "signal_pending()" check at
> any point without caring.

Thanks.  AFAICS, it's this logics in __schedule():
                if (signal_pending_state(prev_state, prev)) {
                        WRITE_ONCE(prev->__state, TASK_RUNNING);
IOW, TASK_INTERRUPTIBLE with signal_pending() or TASK_WAKEKILL with
pending SIGKILL.  OK...
