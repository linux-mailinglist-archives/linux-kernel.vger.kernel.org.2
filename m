Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFE23DD585
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 14:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbhHBMTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 08:19:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:34740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233498AbhHBMTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 08:19:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E20260F35;
        Mon,  2 Aug 2021 12:19:38 +0000 (UTC)
Date:   Mon, 2 Aug 2021 14:19:35 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     John Ericson <mail@johnericson.me>,
        LKML <linux-kernel@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Jann Horn <jann@thejh.net>,
        Christian Brauner <christian.brauner@canonical.com>
Subject: Re: Leveraging pidfs for process creation without fork
Message-ID: <20210802121935.dkiw627twcrxbh54@wittgenstein>
References: <CAHmME9oHBtR4fBBUY8E_Oi7av-=OjOGkSNhQuMJMHhafCjazBw@mail.gmail.com>
 <CALCETrVGLx5yeHo7ExAmJZmPjVjcJiV7p1JOa4iUaW5DRoEvLQ@mail.gmail.com>
 <cf07f0732eb94dbfa67c9d56ceba738e@AcuMS.aculab.com>
 <f8457e20-c3cc-6e56-96a4-3090d7da0cb6@JohnEricson.me>
 <20210729142415.qovpzky537zkg3dp@wittgenstein>
 <YQNYs+BKenJHBMSP@zeniv-ca.linux.org.uk>
 <1468d75c-57ae-42aa-85ce-2bee8d403763@www.fastmail.com>
 <YQXRyMUGS5cDSbzu@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YQXRyMUGS5cDSbzu@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2021 at 10:42:16PM +0000, Al Viro wrote:
> On Sat, Jul 31, 2021 at 03:11:03PM -0700, John Ericson wrote:
> > Do you mind pointing out one of those examples? I'm new to this, but if they follow a pattern I should be able to find the other examples based off it. I'm certainly curious to take a look :).
> > 
> > I hope these issues aren't to deep. Ideally there's a nice decoupling so the creating process is just manipulating "inert" data structures for the embryo that scheduler doesn't even need see, and then after the embryonic process is submitted, when the context switches to it for the first time that's a completely normal process without special cases.
> > 
> > The place complexity is hardest to avoid I think would be cleaning up the yet-unborn embryonic processes orphaned by exitted parent(s), because that will have to handle all the semi-initialized states those could be in (as opposed to real processes).
> 
> 	It's more on the exit/exec/coredump side, actually.  For
> exit we want to be sure that no new live threads will appear in a
> group once the last live thread has entered do_exit().  For
> exec (de_thread(), for starters) you want to have all threads
> except for the one that does execve() to be killed and your
> thread to take over as group leader.  Look for the machinery there
> and in do_exit()/release_task() involved into that.  For coredump
> you want all threads except for dumper to be brought into do_exit()
> and stopped there, for dumping one to be able to access their state.
> 
> 	Then there's fun with ->sighand treatment - the whole thing
> critically relies upon ->sighand being shared for the entire thread
> group; look at the ->sighand->siglock uses.
> 
> 	The whole area is full of rather subtle places.  Again, the
> real headache comes from the exit and execve.  Embryonic threads are
> passive; it's the ones already running that can (and do) cause PITA.

Iiuc, you're talking about adding a thread into a thread-group tg1 from
a thread in another thread-group tg2. I don't think that's a very
pressing use-case and I agree that that sounds rather nasty right now.
Unless I'm missing something, a simple api to create something like a
processes configuration context doesn't require this.
