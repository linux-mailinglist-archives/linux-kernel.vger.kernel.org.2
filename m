Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13BE4369B01
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 21:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbhDWTsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 15:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhDWTsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 15:48:17 -0400
Received: from smtp-good-out-4.t-2.net (smtp-good-out-4.t-2.net [IPv6:2a01:260:1:4::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5F5C061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 12:47:40 -0700 (PDT)
Received: from smtp-1.t-2.net (smtp-1.t-2.net [84.255.208.30])
        by smtp-good-out-4.t-2.net (Postfix) with ESMTP id 4FRlF63sCbz1FxZ;
        Fri, 23 Apr 2021 21:47:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-2.net;
        s=smtp-out-2; t=1619207258;
        bh=3yGHUd8Z+HJ9p1kGXM3dg0c8vffZFIHtV0TYAfwi9e4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=KTstc+Nr4YLkP6QCNDayPMBFRcswz2s1+ovlVsqhsu47ApeEXO4so+61GUeksxUyH
         ahQCWGdy/uNxTAKyoUqBBUGw/UdKMS7NCvXhLlriMfev06V93eZxWD/v06BfioHD8b
         NvYOSWP5IizphvRjRjoMt1Oap8DL0PNO1CnHUJvk=
Received: from localhost (localhost [127.0.0.1])
        by smtp-1.t-2.net (Postfix) with ESMTP id 4FRlF63j3BzTpmmn;
        Fri, 23 Apr 2021 21:47:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at t-2.net
Received: from smtp-1.t-2.net ([127.0.0.1])
        by localhost (smtp-1.t-2.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id swBwA3IceKnf; Fri, 23 Apr 2021 21:47:38 +0200 (CEST)
Received: from hp450g3 (89-212-91-172.static.t-2.net [89.212.91.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-1.t-2.net (Postfix) with ESMTPS;
        Fri, 23 Apr 2021 21:47:02 +0200 (CEST)
Message-ID: <07c3c9015491ca9b42362098d5e90ca7480cf5ed.camel@t-2.net>
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
Date:   Fri, 23 Apr 2021 21:47:01 +0200
In-Reply-To: <33461bad-ef57-9036-135d-95a60a8c88d5@i-love.sakura.ne.jp>
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
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 23.04.2021 (pet) ob 19:12 +0900 je Tetsuo Handa napisal(a):
> On 2021/04/23 18:55, Samo Pogačnik wrote:
> > > > Using the supplied test code, i've tested the patch on my desktop
> > > > running
> > > > the
> > > > 5.4 kernel. After applying the patch, the kernel warnings like
> > > > "ttyprintk:
> > > > tty_port_close_start: tty->count = 1 port count = 11" do not appear any
> > > > more,
> > > > when the test code is run.
> > > > I think the patch is ok.
> > > 
> > > I wonder if the buffer shouldn't be flushed in hangup too? Or better, 
> > > the flush moved from tty_ops->close to tty_port->ops->shutdown?
> > > 
> > > thanks,
> > 
> > Good point. I tried the following additional change, which seems to do the
> > trick. What do you think?
> > 
> 
> Shouldn't the tpk_printk buffer be per a "struct file" (i.e. allocated upon
> open() and released upon close() in order to allow multiple users) ?

Final destination of the ttyprintk is printk(), which is a single destination.
The tpk_printk buffer is a common representation of what is yet to be printk-ed
depending on the formatting conditions within the buffer.

At any point the tpk_buffer is potentially multiplexed/interleaved by parts of
required output of any concurrent user, as buffs are being delivered by the
scheduled writes.

As per user buffers look promising with output formatting, the FDs passing
between tasks lead to the same single buffer (Greg already mentioned that). The
other thing which is important to me is the console redirection to ttyprintk,
which automatically brings all concurrent console users to the single open of
ttyprintk.

best regards, Samo

