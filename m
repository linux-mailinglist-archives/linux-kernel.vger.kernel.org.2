Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36328367E46
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 12:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbhDVKDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 06:03:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:37742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235755AbhDVKD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 06:03:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02D2161131;
        Thu, 22 Apr 2021 10:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619085754;
        bh=HkPE5rnmVLS4AHdydPD62qofAjx8DHdPJ968fhV+dxI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=131JaMt1q/KG3BQZw49Ze+akwz3yKn4UWo9wEiavnX7LVkZKxz1TNGfj9EfVAKjkv
         fSSA4/TEgVeCjGmmcPaIZIo0T6RCdR5QUHBjyLcEqrl66GB3BLtbezhz3G57EIITN1
         VmmjnvzskU9KPZ0LQAqRPrwDujTSjAno9FyB2Z68=
Date:   Thu, 22 Apr 2021 12:02:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Samo =?utf-8?B?UG9nYcSNbmlr?= <samo_pogacnik@t-2.net>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jiri Slaby <jirislaby@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH] ttyprintk: Add TTY hangup callback.
Message-ID: <YIFJt9csgZlFkqpT@kroah.com>
References: <051b550c-1cdd-6503-d2b7-0877bf0578fc@i-love.sakura.ne.jp>
 <cd213843-45fe-2eac-4943-0906ab8d272b@i-love.sakura.ne.jp>
 <YHQkeZVs3pmyie9e@kroah.com>
 <32e75be6-6e9f-b33f-d585-13db220519da@i-love.sakura.ne.jp>
 <YHQ3Zy9gRdZsu77w@kroah.com>
 <ffcc8099-614c-f4b1-10c1-f1d4c7f72e65@i-love.sakura.ne.jp>
 <095d5393-b212-c4d8-5d6d-666bd505cc3d@i-love.sakura.ne.jp>
 <31a4dec3d36ed131402244693cae180816ebd4d7.camel@t-2.net>
 <17e0652d-89b7-c8c0-fb53-e7566ac9add4@i-love.sakura.ne.jp>
 <8043d41d48a0f4f13bd891b4c3e9ad28c76b430e.camel@t-2.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8043d41d48a0f4f13bd891b4c3e9ad28c76b430e.camel@t-2.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 18, 2021 at 01:16:05PM +0200, Samo Pogačnik wrote:
> Dne 15.04.2021 (čet) ob 09:22 +0900 je Tetsuo Handa napisal(a):
> > syzbot is reporting hung task due to flood of
> > 
> >   tty_warn(tty, "%s: tty->count = 1 port count = %d\n", __func__,
> >            port->count);
> > 
> > message [1], for ioctl(TIOCVHANGUP) prevents tty_port_close() from
> > decrementing port->count due to tty_hung_up_p() == true.
> > 
> > ----------
> > #include <sys/types.h>
> > #include <sys/stat.h>
> > #include <fcntl.h>
> > #include <sys/ioctl.h>
> > #include <unistd.h>
> > 
> > int main(int argc, char *argv[])
> > {
> > 	int i;
> > 	int fd[10];
> > 
> > 	for (i = 0; i < 10; i++)
> > 		fd[i] = open("/dev/ttyprintk", O_WRONLY);
> > 	ioctl(fd[0], TIOCVHANGUP);
> > 	for (i = 0; i < 10; i++)
> > 		close(fd[i]);
> > 	close(open("/dev/ttyprintk", O_WRONLY));
> > 	return 0;
> > }
> > ----------
> > 
> > When TTY hangup happens, port->count needs to be reset via
> > "struct tty_operations"->hangup callback.
> > 
> > [1] 
> > https://syzkaller.appspot.com/bug?id=39ea6caa479af471183997376dc7e90bc7d64a6a
> > 
> > Reported-by: syzbot <syzbot+43e93968b964e369db0b@syzkaller.appspotmail.com>
> > Reported-by: syzbot <syzbot+3ed715090790806d8b18@syzkaller.appspotmail.com>
> > Tested-by: syzbot <syzbot+43e93968b964e369db0b@syzkaller.appspotmail.com>
> > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > Fixes: 24b4b67d17c308aa ("add ttyprintk driver")
> > ---
> >  drivers/char/ttyprintk.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/char/ttyprintk.c b/drivers/char/ttyprintk.c
> > index 6a0059e508e3..93f5d11c830b 100644
> > --- a/drivers/char/ttyprintk.c
> > +++ b/drivers/char/ttyprintk.c
> > @@ -158,12 +158,23 @@ static int tpk_ioctl(struct tty_struct *tty,
> >  	return 0;
> >  }
> >  
> > +/*
> > + * TTY operations hangup function.
> > + */
> > +static void tpk_hangup(struct tty_struct *tty)
> > +{
> > +	struct ttyprintk_port *tpkp = tty->driver_data;
> > +
> > +	tty_port_hangup(&tpkp->port);
> > +}
> > +
> >  static const struct tty_operations ttyprintk_ops = {
> >  	.open = tpk_open,
> >  	.close = tpk_close,
> >  	.write = tpk_write,
> >  	.write_room = tpk_write_room,
> >  	.ioctl = tpk_ioctl,
> > +	.hangup = tpk_hangup,
> >  };
> >  
> >  static const struct tty_port_operations null_ops = { };
> 
> Using the supplied test code, i've tested the patch on my desktop running the
> 5.4 kernel. After applying the patch, the kernel warnings like "ttyprintk:
> tty_port_close_start: tty->count = 1 port count = 11" do not appear any more,
> when the test code is run.
> I think the patch is ok.

Thanks for the review, I'll go queue this up.

greg k-h
