Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15333AD63E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 02:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbhFSAYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 20:24:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59978 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbhFSAYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 20:24:25 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624062134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KxAbQdX4x9ITcgn11l/fWdjzsw3PL9N3JK1TmT4+wAs=;
        b=Zm86m9AfxpgsoNXtCf9g+AWVSm356U5pNy1VPpBRTqAE//YAUx7aXhYrU3ofKLsmFXVBe3
        ZYb8NTodqKFIlrjyCXOufOtdnUBktkyFRAK/2Bb2s5/gZ0qklfowDkrLlJQKQemxLDpoL8
        7vwkHoa4iSalVjm1qFRx9rLQqr67pbTf7WrIERXKeTCmU6ZMyex+/Qi1ukoW352iQPvDxj
        MaPC8S3i26XziC0E9+EmRm3F8l+ocYV2s8/wCTHEgDKgo929O1OClvPqXNoB9PaJFYyeco
        Ts44CYdt7wA9dePQC8+nXqOKUOCMDGFELrJTejHk5n4yhvgDWuxEPMIiPOjkzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624062134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KxAbQdX4x9ITcgn11l/fWdjzsw3PL9N3JK1TmT4+wAs=;
        b=EN0eTwAB+ucNb1U3wf/PKxjOjcKYMxbYY29jgilJPMc1G1t308fXkH9pCCtdKwtYSyfjH9
        ET96zqcKLOivMlBA==
To:     Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH next v4 1/2] lib/dump_stack: move cpu lock to printk.c
In-Reply-To: <20210618122541.49fbd114@oasis.local.home>
References: <20210617095051.4808-1-john.ogness@linutronix.de> <20210617095051.4808-2-john.ogness@linutronix.de> <20210617093243.795b4853@gandalf.local.home> <YMyyCwMt549micJE@alley> <20210618122541.49fbd114@oasis.local.home>
Date:   Sat, 19 Jun 2021 02:28:13 +0206
Message-ID: <87czsiog96.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-18, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Fri, 18 Jun 2021 16:47:39 +0200 Petr Mladek <pmladek@suse.com> wrote:
>> My understanding is that early_printk() is used only for very early
>> boot message in plain kernel. And that there is not much concurrency
>> at that time.
>
> It will continue if you use ",keep" option. And that is something I
> have done without Peter's patches, but then they become illegible when
> there's a bug if more than one CPU triggers.

Note that using "keep" to force some boot consoles to regular consoles
does not mean that early_printk() is used. Your suggestion of adding the
cpu lock to early_printk() will not help for the "keep" scenario.

>> That said. I always wanted to upstream Peter's patchset. But I never
>> found time to clean it up.

The main problem with Peter's patchset (aside from using unsafe
early_printk code in a preemptive environment) is that it does not
handle CONT messages. While I'm sure this is fine for Peter, it is quite
horrible for things like lockdep output.

It would not be too much work to implement an early_printk printing loop
as a reader of the ringbuffer. But that is basically what the upcoming
atomic console and sync mode will be doing. Once that code is available,
it would be trivial to allow early_printk usage if an atomic console is
not available.

My recommendation right now is wait a bit longer on the early_printk
hack. We are not far the atomic console and sync mode series (which come
immediately after the safe buffer removal series that we are currently
pushing).

John Ogness
