Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6CAA3634CB
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 13:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhDRLRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 07:17:25 -0400
Received: from smtp-good-out-4.t-2.net ([93.103.246.70]:51348 "EHLO
        smtp-good-out-4.t-2.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhDRLRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 07:17:24 -0400
Received: from smtp-1.t-2.net (smtp-1.t-2.net [IPv6:2a01:260:1:4::1e])
        by smtp-good-out-4.t-2.net (Postfix) with ESMTP id 4FNS834nxfz2s1h;
        Sun, 18 Apr 2021 13:16:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-2.net;
        s=smtp-out-2; t=1618744611;
        bh=8+uJWmrlHmdzJqi8Isn89UVn+5VWltIhJSwmEYjRvL0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=uk0ag2jlIaBShplKaftgx6qGFK/K9w/gp+SrQT6dAuF/ROmgiwJg7nJnugqrzDA5C
         HuP5/VwrkL28q4hlenKXSTgqaM8uHvZFEeawWybG3QwBxNINvRJTH0Ix3o7uZqolMO
         SSmUfB3bjaGaY+uDj3QlqCAiFRwaDYJmTOfTTNao=
Received: from localhost (localhost [127.0.0.1])
        by smtp-1.t-2.net (Postfix) with ESMTP id 4FNS834cVXzTqTbT;
        Sun, 18 Apr 2021 13:16:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at t-2.net
Received: from smtp-1.t-2.net ([127.0.0.1])
        by localhost (smtp-1.t-2.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wpmGWOwji7pL; Sun, 18 Apr 2021 13:16:50 +0200 (CEST)
Received: from hp450g3 (89-212-91-172.static.t-2.net [89.212.91.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-1.t-2.net (Postfix) with ESMTPS;
        Sun, 18 Apr 2021 13:16:06 +0200 (CEST)
Message-ID: <8043d41d48a0f4f13bd891b4c3e9ad28c76b430e.camel@t-2.net>
Subject: Re: [PATCH] ttyprintk: Add TTY hangup callback.
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
Date:   Sun, 18 Apr 2021 13:16:05 +0200
In-Reply-To: <17e0652d-89b7-c8c0-fb53-e7566ac9add4@i-love.sakura.ne.jp>
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
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 15.04.2021 (čet) ob 09:22 +0900 je Tetsuo Handa napisal(a):
> syzbot is reporting hung task due to flood of
> 
>   tty_warn(tty, "%s: tty->count = 1 port count = %d\n", __func__,
>            port->count);
> 
> message [1], for ioctl(TIOCVHANGUP) prevents tty_port_close() from
> decrementing port->count due to tty_hung_up_p() == true.
> 
> ----------
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <sys/ioctl.h>
> #include <unistd.h>
> 
> int main(int argc, char *argv[])
> {
> 	int i;
> 	int fd[10];
> 
> 	for (i = 0; i < 10; i++)
> 		fd[i] = open("/dev/ttyprintk", O_WRONLY);
> 	ioctl(fd[0], TIOCVHANGUP);
> 	for (i = 0; i < 10; i++)
> 		close(fd[i]);
> 	close(open("/dev/ttyprintk", O_WRONLY));
> 	return 0;
> }
> ----------
> 
> When TTY hangup happens, port->count needs to be reset via
> "struct tty_operations"->hangup callback.
> 
> [1] 
> https://syzkaller.appspot.com/bug?id=39ea6caa479af471183997376dc7e90bc7d64a6a
> 
> Reported-by: syzbot <syzbot+43e93968b964e369db0b@syzkaller.appspotmail.com>
> Reported-by: syzbot <syzbot+3ed715090790806d8b18@syzkaller.appspotmail.com>
> Tested-by: syzbot <syzbot+43e93968b964e369db0b@syzkaller.appspotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Fixes: 24b4b67d17c308aa ("add ttyprintk driver")
> ---
>  drivers/char/ttyprintk.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/char/ttyprintk.c b/drivers/char/ttyprintk.c
> index 6a0059e508e3..93f5d11c830b 100644
> --- a/drivers/char/ttyprintk.c
> +++ b/drivers/char/ttyprintk.c
> @@ -158,12 +158,23 @@ static int tpk_ioctl(struct tty_struct *tty,
>  	return 0;
>  }
>  
> +/*
> + * TTY operations hangup function.
> + */
> +static void tpk_hangup(struct tty_struct *tty)
> +{
> +	struct ttyprintk_port *tpkp = tty->driver_data;
> +
> +	tty_port_hangup(&tpkp->port);
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

Using the supplied test code, i've tested the patch on my desktop running the
5.4 kernel. After applying the patch, the kernel warnings like "ttyprintk:
tty_port_close_start: tty->count = 1 port count = 11" do not appear any more,
when the test code is run.
I think the patch is ok.

best regards, Samo


