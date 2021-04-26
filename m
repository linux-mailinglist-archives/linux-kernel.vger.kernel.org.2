Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B6836B130
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 12:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbhDZKBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 06:01:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:38364 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232328AbhDZKBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 06:01:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619431238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=236Xh/UNn0S/8u+6zQznzVUUtl8jlR4aS6Ek+3iM9ag=;
        b=e3noeTC28z/Xri6GrVAsLQbb+19/ZXKcwiXykttGpO3/LQwVaTNdxg12/fw2LRPC+6t9IA
        HcPkCQPLrE/HN8gkXcHFzww+HzN2AvJoWL+Y2kwYFA5bE5sc6iWvSNPVySXFy2EecsWSxC
        0I4I24RVxxYVhLylKutG0yct0a6ntQA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EBD40AFE2;
        Mon, 26 Apr 2021 10:00:37 +0000 (UTC)
Date:   Mon, 26 Apr 2021 12:00:35 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Samo =?utf-8?B?UG9nYcSNbmlr?= <samo_pogacnik@t-2.net>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH] ttyprintk: Add TTY hangup callback.
Message-ID: <YIaPQzktArmoWbLr@alley>
References: <095d5393-b212-c4d8-5d6d-666bd505cc3d@i-love.sakura.ne.jp>
 <31a4dec3d36ed131402244693cae180816ebd4d7.camel@t-2.net>
 <17e0652d-89b7-c8c0-fb53-e7566ac9add4@i-love.sakura.ne.jp>
 <8043d41d48a0f4f13bd891b4c3e9ad28c76b430e.camel@t-2.net>
 <699d0312-ee68-8f05-db2d-07511eaad576@kernel.org>
 <ba5907e12a30ed8eb3e52a72ea84bf4f72a4c801.camel@t-2.net>
 <33461bad-ef57-9036-135d-95a60a8c88d5@i-love.sakura.ne.jp>
 <07c3c9015491ca9b42362098d5e90ca7480cf5ed.camel@t-2.net>
 <e7010c9e-1ac2-55a7-b505-802e03f13362@i-love.sakura.ne.jp>
 <9e8805a98d6c0d0f20e563c8e4db98b595826c13.camel@t-2.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e8805a98d6c0d0f20e563c8e4db98b595826c13.camel@t-2.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2021-04-24 11:57:47, Samo Pogačnik wrote:
> Dne 24.04.2021 (sob) ob 10:16 +0900 je Tetsuo Handa napisal(a):
> > On 2021/04/24 4:47, Samo Pogačnik wrote:
> > > At any point the tpk_buffer is potentially multiplexed/interleaved by parts
> > > of
> > > required output of any concurrent user, as buffs are being delivered by the
> > > scheduled writes.
> > 
> > As long as one line is printed by one printk() call, CONFIG_PRINTK_CALLER=y is
> > helpful enough to distinguish multilplexed/interleaved messages. I consider
> > that
> > ttyprintk offers additional advantage over printk() for allow buffering one
> > line
> > of message from userspace.

It does not matter how much buffering games you play. As long as you
use printk() to store single lines into the kernel logbuffer they
alway could be interleaved with lines from other processes/CPUs.

> > > 
> > > As per user buffers look promising with output formatting, the FDs passing
> > > between tasks lead to the same single buffer (Greg already mentioned that).
> > 
> > Those programs which use FD passing know what they are doing. If they still
> > want
> > one line of message printed via ttyprintk interface, they must do their
> > buffering
> > before trying to write() to ttyprintk's file descriptor.

Lines might get interleaved when using printk().
What is special about messages passed via ttyprintk()?
How many processes are using it?
Do they print many lines?
Is it really worth any added complexity?


> > Use of per "struct file" buffer gives those programs which does not use
> > FD passing a guarantee that one line of message from those programs won't be
> > multilplexed/interleaved (with the aid of CONFIG_PRINTK_CALLER=y).

How huge bugffer would be needed?

IMHO, even a 80-bytes big per-task buffer is not acceptable. And even
such a buffer would hold only 1-3 lines.

> I think i understand, what would you like to achieve, however implementation
> wise there seems to be no reference point available in tty write operation that
> would relate to its tty open/close operations (i.e. open() and close() provide
> filp while write() does not - probably for a reason) or is there such a relation
> available?
<
> On the other hand, my main concern is how to provide a reliable system wide
> collection of all console output via ttyprintk console redirection, while normal
> operation of system console is preserved (except its output being detoured via
> printk and as such logged together with kernel output). Such logging is
> particularly useful for after-the-fact inspection of system operation.

I am not sure if I understand the problem. But why does ttyprintk need
any buffer at all. AFAIK, the use-case is to pass any written data into the
kernel logbuffer via printk()?

Why tpk_write() does not call printk() directly?

If you call printk() directly, the caller_id would be from the process
that really wrote the data/message.

> That being said i am thinking about how to permanently enable this redirection
> as early as possible (i.e. via kernel command line option). I had a working
> prototype for that some time ago (never posted). Would anybody like to see such
> functionality?

Please, do not add any complex code if it does not cause real life
problems.

There seems to be only few commits that suggest that anyone is using
this driver and the latest is 7 year old.

+ (2014) acef6660d3aaf18813143
	("ttyprintk: make the printk log level configurable")
+ (2014) b24313a82cf24e9017067
	("ttyprintk: Allow built as a module")
+ (2014) 7d1c2858c49095ab748f5
	("ttyprintk: Fix wrong tty_unregister_driver() call in the error path")
+ (2014) db50d2f65b7c2bcdfb931
	("drivers/char: don't use module_init in non-modular ttyprintk.c")
+ (2013) b5325a02aa84c794cf520
	("ttyprintk: Fix NULL pointer deref by setting tty_port ops
	  after	initializing port")
+ (2012) ee8b593affdf893012e57
	("TTY: ttyprintk, don't touch behind tty->write_buf")
+ (2012) f06fb543c1d0cbd721250
	("TTY: ttyprintk, unregister tty driver on failure")
+ (2012) 2f16669d322e05171c9e1
	("TTY: remove re-assignments to tty_driver members")
+ (2010) 24b4b67d17c308aaa956b
	("add ttyprintk driver")

Best Regards,
Petr
