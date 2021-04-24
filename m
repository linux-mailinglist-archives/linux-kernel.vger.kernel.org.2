Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE8E36A094
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbhDXJ7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:59:06 -0400
Received: from smtp-good-out-4.t-2.net ([93.103.246.70]:41794 "EHLO
        smtp-good-out-4.t-2.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhDXJ7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:59:04 -0400
Received: from smtp-1.t-2.net (smtp-1.t-2.net [84.255.208.30])
        by smtp-good-out-4.t-2.net (Postfix) with ESMTP id 4FS66m4kvqz2TdT;
        Sat, 24 Apr 2021 11:58:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-2.net;
        s=smtp-out-2; t=1619258304;
        bh=ypb2UrBwwB//ihXVXppvATnFzd9PXE4hhZyFAFmRCaU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=xMKtHJgQqYgfxRrTz5VmEYUTw6cFB+l1hxDpwL52sTFoTJ2IRu4TWVJ++6NLjZTaP
         14u8lxYed04AJsr0w657VakAbjMWaN1oAJ35d8cczUc77adS/IJ7R11awcdHLac0Hm
         kxfjepVRnPBgecpWtkAcFCsCFrP/Q7yMsAY65y5Q=
Received: from localhost (localhost [127.0.0.1])
        by smtp-1.t-2.net (Postfix) with ESMTP id 4FS66m4Wq6zTpmnB;
        Sat, 24 Apr 2021 11:58:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at t-2.net
Received: from smtp-1.t-2.net ([127.0.0.1])
        by localhost (smtp-1.t-2.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PV4iskh6-aLh; Sat, 24 Apr 2021 11:58:24 +0200 (CEST)
Received: from hp450g3 (89-212-91-172.static.t-2.net [89.212.91.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-1.t-2.net (Postfix) with ESMTPS;
        Sat, 24 Apr 2021 11:57:48 +0200 (CEST)
Message-ID: <9e8805a98d6c0d0f20e563c8e4db98b595826c13.camel@t-2.net>
Subject: Re: [PATCH] ttyprintk: Add TTY hangup callback.
From:   Samo =?UTF-8?Q?Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Date:   Sat, 24 Apr 2021 11:57:47 +0200
In-Reply-To: <e7010c9e-1ac2-55a7-b505-802e03f13362@i-love.sakura.ne.jp>
References: <20210403041444.4081-1-penguin-kernel@I-love.SAKURA.ne.jp>
         <YGx59PEq2Y015YdK@alley>
         <3c15d32f-c568-7f6f-fa7e-af4deb9b49f9@i-love.sakura.ne.jp>
         <d78ae8da-16e9-38d9-e274-048c54e24360@i-love.sakura.ne.jp>
         <YG24F9Kx+tjxhh8G@kroah.com>
         <051b550c-1cdd-6503-d2b7-0877bf0578fc@i-love.sakura.ne.jp>
         <cd213843-45fe-2eac-4943-0906ab8d272b@i-love.sakura.ne.jp>
         <YHQkeZVs3pmyie9e@kroah.com>
         <32e75be6-6e9f-b33f-d585-13db220519da@i-love.sakura.ne.jp>
         <YHQ3Zy9gRdZsu77w@kroah.com>
         <ffcc8099-614c-f4b1-10c1-f1d4c7f72e65@i-love.sakura.ne.jp>
         <095d5393-b212-c4d8-5d6d-666bd505cc3d@i-love.sakura.ne.jp>
         <31a4dec3d36ed131402244693cae180816ebd4d7.camel@t-2.net>
         <17e0652d-89b7-c8c0-fb53-e7566ac9add4@i-love.sakura.ne.jp>
         <8043d41d48a0f4f13bd891b4c3e9ad28c76b430e.camel@t-2.net>
         <699d0312-ee68-8f05-db2d-07511eaad576@kernel.org>
         <ba5907e12a30ed8eb3e52a72ea84bf4f72a4c801.camel@t-2.net>
         <33461bad-ef57-9036-135d-95a60a8c88d5@i-love.sakura.ne.jp>
         <07c3c9015491ca9b42362098d5e90ca7480cf5ed.camel@t-2.net>
         <e7010c9e-1ac2-55a7-b505-802e03f13362@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 24.04.2021 (sob) ob 10:16 +0900 je Tetsuo Handa napisal(a):
> On 2021/04/24 4:47, Samo Pogačnik wrote:
> > At any point the tpk_buffer is potentially multiplexed/interleaved by parts
> > of
> > required output of any concurrent user, as buffs are being delivered by the
> > scheduled writes.
> 
> As long as one line is printed by one printk() call, CONFIG_PRINTK_CALLER=y is
> helpful enough to distinguish multilplexed/interleaved messages. I consider
> that
> ttyprintk offers additional advantage over printk() for allow buffering one
> line
> of message from userspace.
> 
> > 
> > As per user buffers look promising with output formatting, the FDs passing
> > between tasks lead to the same single buffer (Greg already mentioned that).
> 
> Those programs which use FD passing know what they are doing. If they still
> want
> one line of message printed via ttyprintk interface, they must do their
> buffering
> before trying to write() to ttyprintk's file descriptor.
> 
> Use of per "struct file" buffer gives those programs which does not use
> FD passing a guarantee that one line of message from those programs won't be
> multilplexed/interleaved (with the aid of CONFIG_PRINTK_CALLER=y).
> I consider it an improvement.
> 
> >                                                                             
> > The
> > other thing which is important to me is the console redirection to
> > ttyprintk,
> > which automatically brings all concurrent console users to the single open
> > of
> > ttyprintk.
> 
> Gathering whole console output into one FD is similar to FD passing; that is
> inevitable. But use of per "struct file" buffer allows /dev/ttyprintk users
>  from outside of "gather whole console output into one FD" case to avoid
> multilplexed/interleaved messages. I tried /dev/ttyprintk like
> 
https://lkml.kernel.org/r/be9e80b1-5be1-842e-538e-d69a3995d567@i-love.sakura.ne.jp
>  .
> 

I think i understand, what would you like to achieve, however implementation
wise there seems to be no reference point available in tty write operation that
would relate to its tty open/close operations (i.e. open() and close() provide
filp while write() does not - probably for a reason) or is there such a relation
available?

On the other hand, my main concern is how to provide a reliable system wide
collection of all console output via ttyprintk console redirection, while normal
operation of system console is preserved (except its output being detoured via
printk and as such logged together with kernel output). Such logging is
particularly useful for after-the-fact inspection of system operation.

That being said i am thinking about how to permanently enable this redirection
as early as possible (i.e. via kernel command line option). I had a working
prototype for that some time ago (never posted). Would anybody like to see such
functionality?

best regards, Samo

