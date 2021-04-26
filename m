Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C848D36B71A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbhDZQnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:43:31 -0400
Received: from smtp-good-out-4.t-2.net ([93.103.246.70]:43362 "EHLO
        smtp-good-out-4.t-2.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234576AbhDZQna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:43:30 -0400
Received: from smtp-1.t-2.net (smtp-1.t-2.net [IPv6:2a01:260:1:4::1e])
        by smtp-good-out-4.t-2.net (Postfix) with ESMTP id 4FTW0Q3fFgz2Tdv;
        Mon, 26 Apr 2021 18:42:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-2.net;
        s=smtp-out-2; t=1619455366;
        bh=vAWvm4J8IUsdhtm3IvCqag1smIsdVKVd8tfu48VM2MY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=iLTvh2Rr8jICSgtByPtcQ+bBa1kItjmFp6orClC403YvKqzLjhr1HHjPMqAIiaLEF
         sjlaPlZCNiPi6G/0A4gOhIP89/J7WjTbJ74Qiwn/qHuhmhbwHMs+Duyok6Y3fhLHqc
         eZM/XBV8AcGEj34tzFRHfeiShJPcwDNhLLioUHhE=
Received: from localhost (localhost [127.0.0.1])
        by smtp-1.t-2.net (Postfix) with ESMTP id 4FTW0Q3TdHzTpmmq;
        Mon, 26 Apr 2021 18:42:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at t-2.net
Received: from smtp-1.t-2.net ([127.0.0.1])
        by localhost (smtp-1.t-2.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pO3ewzsYZ0oN; Mon, 26 Apr 2021 18:42:46 +0200 (CEST)
Received: from hp450g3 (89-212-91-172.static.t-2.net [89.212.91.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-1.t-2.net (Postfix) with ESMTPS;
        Mon, 26 Apr 2021 18:42:08 +0200 (CEST)
Message-ID: <d4d0603716e5cb99a7a9a93d4f767278ac318557.camel@t-2.net>
Subject: Re: [PATCH] ttyprintk: Add TTY hangup callback.
From:   Samo =?UTF-8?Q?Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Date:   Mon, 26 Apr 2021 18:42:05 +0200
In-Reply-To: <YIaPQzktArmoWbLr@alley>
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
         <YIaPQzktArmoWbLr@alley>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 26.04.2021 (pon) ob 12:00 +0200 je Petr Mladek napisal(a):
> On Sat 2021-04-24 11:57:47, Samo Pogačnik wrote:
> > Dne 24.04.2021 (sob) ob 10:16 +0900 je Tetsuo Handa napisal(a):
> > > On 2021/04/24 4:47, Samo Pogačnik wrote:
> > > > At any point the tpk_buffer is potentially multiplexed/interleaved by
> > > > parts
> > > > of
> > > > required output of any concurrent user, as buffs are being delivered by
> > > > the
> > > > scheduled writes.
> > > 
> > > As long as one line is printed by one printk() call,
> > > CONFIG_PRINTK_CALLER=y is
> > > helpful enough to distinguish multilplexed/interleaved messages. I
> > > consider
> > > that
> > > ttyprintk offers additional advantage over printk() for allow buffering
> > > one
> > > line
> > > of message from userspace.
> 
> It does not matter how much buffering games you play. As long as you
> use printk() to store single lines into the kernel logbuffer they
> alway could be interleaved with lines from other processes/CPUs.

Exactly. The only purpose of ttyprintk buffering is to mark any begining of
lines occurring within the userspace-string written into ttyprintk TTY. The
marked lines do not originate in the kernel source code, which is not obvious
otherwise (imho this is importannt). Even the CONFIG_PRINTK_CALLER=y does not
give this information, if the task ID printed does not live anymore.

> 
> > > > 
> > > > As per user buffers look promising with output formatting, the FDs
> > > > passing
> > > > between tasks lead to the same single buffer (Greg already mentioned
> > > > that).
> > > 
> > > Those programs which use FD passing know what they are doing. If they
> > > still
> > > want
> > > one line of message printed via ttyprintk interface, they must do their
> > > buffering
> > > before trying to write() to ttyprintk's file descriptor.
> 
> Lines might get interleaved when using printk().
> What is special about messages passed via ttyprintk()?
They do not originate in the kernel code.

> How many processes are using it?
In case of redirection any proces, that is writing to console.

> Do they print many lines?
?

> Is it really worth any added complexity?
No.

> 
> > On the other hand, my main concern is how to provide a reliable system wide
> > collection of all console output via ttyprintk console redirection, while
> > normal
> > operation of system console is preserved (except its output being detoured
> > via
> > printk and as such logged together with kernel output). Such logging is
> > particularly useful for after-the-fact inspection of system operation.
> 
> I am not sure if I understand the problem. But why does ttyprintk need
> any buffer at all. AFAIK, the use-case is to pass any written data into the
> kernel logbuffer via printk()?
(see above - it is not something the kernel is telling you)
> 
> Why tpk_write() does not call printk() directly?
(see above)
> 
> If you call printk() directly, the caller_id would be from the process
> that really wrote the data/message.
It can be a kernel-code originating message printk-ed on behalf of a user task
or a kernel-code originating message on behalf of a kernel task. Or it may be a
user-code originating message on behalf of its task, when printk-ed via
ttyprintk.

> 
> > That being said i am thinking about how to permanently enable this
> > redirection
> > as early as possible (i.e. via kernel command line option). I had a working
> > prototype for that some time ago (never posted). Would anybody like to see
> > such
> > functionality?
> 
> Please, do not add any complex code if it does not cause real life
> problems.
> 
Noted, thanks.

Best regards, Samo


