Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67EA35F8D4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351682AbhDNQQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 12:16:29 -0400
Received: from smtp-good-out-4.t-2.net ([93.103.246.70]:55582 "EHLO
        smtp-good-out-4.t-2.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237770AbhDNQQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 12:16:27 -0400
Received: from smtp-1.t-2.net (smtp-1.t-2.net [84.255.208.30])
        by smtp-good-out-4.t-2.net (Postfix) with ESMTP id 4FL6z45B2bz24kn;
        Wed, 14 Apr 2021 18:16:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-2.net;
        s=smtp-out-2; t=1618416960;
        bh=XvvB3lOkLpYUeqi1cLHIyJdNQ5+cUx8m1z4OVjMo844=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=CoC5iVkDTc/JSQeFRbfownlvyP9bLkyKw4fOForv2fUSUSqYjCjqvFLWMHGm0RTS0
         WZO+NzK+ZVov8vLRmpZMGT5aGhDsGdn1tN3NUPDTYTHFKxDPU6K6MqsnPQtgw2Po0h
         /QZrw7rCzWIqKz4X8HcYD1aiVouJxzzHyf/+lliA=
Received: from localhost (localhost [127.0.0.1])
        by smtp-1.t-2.net (Postfix) with ESMTP id 4FL6z451HGzV9Sr5;
        Wed, 14 Apr 2021 18:16:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at t-2.net
Received: from smtp-1.t-2.net ([127.0.0.1])
        by localhost (smtp-1.t-2.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 50AVCU-6kubu; Wed, 14 Apr 2021 18:16:00 +0200 (CEST)
Received: from hpg3.u2up.net (89-212-91-172.static.t-2.net [89.212.91.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-1.t-2.net (Postfix) with ESMTPS;
        Wed, 14 Apr 2021 18:15:23 +0200 (CEST)
Message-ID: <31a4dec3d36ed131402244693cae180816ebd4d7.camel@t-2.net>
Subject: Re: How to handle concurrent access to /dev/ttyprintk ?
From:   Samo =?UTF-8?Q?Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Date:   Wed, 14 Apr 2021 18:15:23 +0200
In-Reply-To: <095d5393-b212-c4d8-5d6d-666bd505cc3d@i-love.sakura.ne.jp>
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
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 14.04.2021 (sre) ob 20:11 +0900 je Tetsuo Handa napisal(a):
> On 2021/04/14 9:45, Tetsuo Handa wrote:
> > On 2021/04/12 21:04, Greg Kroah-Hartman wrote:
> > > > Since syzkaller is a fuzzer, syzkaller happily opens /dev/ttyprintk from
> > > > multiple threads. Should we update syzkaller to use CONFIG_TTY_PRINTK=n
> > > > ?
> > > 
> > > Why?  Can you not hit the same tty code paths from any other tty driver
> > > being open multiple times?  Why is ttyprintk somehow "special" here?
> > 
> > I found a simplified reproducer. If we call ioctl(TIOCVHANGUP) on
> > /dev/ttyprintk ,
> > "struct ttyprintk_port tpk_port".port.count cannot be decremented by
> > tty_port_close() from tpk_close() due to tty_hung_up_p() == true when
> > close() is called. As a result, tty->count and port count gets out of sync.
> > 
> > Then, when /dev/ttyprintk is opened again and then closed without calling
> > ioctl(TIOCVHANGUP), this message is printed due to tty_hung_up_p() == false.
> > 
> > If I replace /dev/ttyprintk with /dev/ttyS0 in the reproducer shown above,
> > this message is not printed.
> > 
> 
> The difference between /dev/ttyS0 and /dev/ttyprintk is that
> the former provides uart_hangup() as "struct tty_operations"->hangup
> while the latter does not provide "struct tty_operations"->hangup .
> 
> It seems to me that below patch avoids this message, but I'm not familiar
> with tty code. Is this fix correct? Don't we need to enforce all drivers
> to provide "struct tty_operations"->hangup in order to reset port count ?
> 
> diff --git a/drivers/char/ttyprintk.c b/drivers/char/ttyprintk.c
> index 6a0059e508e3..ff3b9a41b91b 100644
> --- a/drivers/char/ttyprintk.c
> +++ b/drivers/char/ttyprintk.c
> @@ -158,12 +158,26 @@ static int tpk_ioctl(struct tty_struct *tty,
>  	return 0;
>  }
>  
> +/*
> + * TTY operations hangup function.
> + */
> +static void tpk_hangup(struct tty_struct *tty)
> +{
> +	struct ttyprintk_port *tpkp = tty->driver_data;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&tpkp->port.lock, flags);
> +	tpkp->port.count = 0;
> +	spin_unlock_irqrestore(&tpkp->port.lock, flags);
> +}
> +
>  static const struct tty_operations ttyprintk_ops = {
>  	.open = tpk_open,
>  	.close = tpk_close,
>  	.write = tpk_write,
>  	.write_room = tpk_write_room,
>  	.ioctl = tpk_ioctl,
> +	.hangup = tpk_hangup,
>  };
>  
>  static const struct tty_port_operations null_ops = { };

Wish i could be of more help here, especially around locking.

If this addition is needed, i'd probably do something similar.
However, when comparing the code around other drivers it seems that
'tty_port_hangup()' should be used instead explicit 'port.count'
reset.

best regards, Samo


