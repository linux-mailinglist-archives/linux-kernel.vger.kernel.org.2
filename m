Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89898369208
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 14:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242355AbhDWMZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 08:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhDWMZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 08:25:03 -0400
X-Greylist: delayed 8917 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 23 Apr 2021 05:24:26 PDT
Received: from smtp-good-out-4.t-2.net (smtp-good-out-4.t-2.net [IPv6:2a01:260:1:4::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36719C061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 05:24:26 -0700 (PDT)
Received: from smtp-1.t-2.net (smtp-1.t-2.net [84.255.208.30])
        by smtp-good-out-4.t-2.net (Postfix) with ESMTP id 4FRYPh0jGqz1Fyg;
        Fri, 23 Apr 2021 14:24:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-2.net;
        s=smtp-out-2; t=1619180664;
        bh=ldvIxGJbVP27nohopjRASvuunWRgZUj24T93quRxLH8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=BesrjE0uDl/VxaxfGBFp7Z2SP8DqH+OjlshtRpU/Ck3ViQXE8fkIrGHNXGy0/dHP4
         8jlpwc2kaLPsC0WDAGmi8SMQlWtOJ6DgoAykvYRW4risNyEbDTQUBO+j2hGgI6dkp2
         MLJTJgZWng72A+oVbhfF25JWhspkFjFmv/swPZIs=
Received: from localhost (localhost [127.0.0.1])
        by smtp-1.t-2.net (Postfix) with ESMTP id 4FRYPh0WGHzTqTbg;
        Fri, 23 Apr 2021 14:24:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at t-2.net
Received: from smtp-1.t-2.net ([127.0.0.1])
        by localhost (smtp-1.t-2.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oFSRsqNubC84; Fri, 23 Apr 2021 14:24:23 +0200 (CEST)
Received: from hpg3.u2up.net (89-212-91-172.static.t-2.net [89.212.91.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-1.t-2.net (Postfix) with ESMTPS;
        Fri, 23 Apr 2021 14:23:47 +0200 (CEST)
Message-ID: <8b875c15ef457eb25dd1984c09d65dcae91bcee3.camel@t-2.net>
Subject: [PATCH] ttyprintk: Add TTY port shutdown callback.
From:   Samo =?UTF-8?Q?Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>
To:     Jiri Slaby <jirislaby@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Date:   Fri, 23 Apr 2021 14:23:46 +0200
In-Reply-To: <56763238-c613-e882-a575-75a324d539b1@kernel.org>
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
         <56763238-c613-e882-a575-75a324d539b1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 23.04.2021 (pet) ob 12:28 +0200 je Jiri Slaby napisal(a):
> On 23. 04. 21, 11:55, Samo Pogačnik wrote:
> > Dne 23.04.2021 (pet) ob 06:22 +0200 je Jiri Slaby napisal(a):
> > > On 18. 04. 21, 13:16, Samo Pogačnik wrote:
> > > > Dne 15.04.2021 (čet) ob 09:22 +0900 je Tetsuo Handa napisal(a):
> > > > > syzbot is reporting hung task due to flood of
> > > > > 
> > > > >     tty_warn(tty, "%s: tty->count = 1 port count = %d\n", __func__,
> > > > >              port->count);
> > > > > 
> > > > > message [1], for ioctl(TIOCVHANGUP) prevents tty_port_close() from
> > > > > decrementing port->count due to tty_hung_up_p() == true.
> > > > > 
> > > > > ----------
> > > > > #include <sys/types.h>
> > > > > #include <sys/stat.h>
> > > > > #include <fcntl.h>
> > > > > #include <sys/ioctl.h>
> > > > > #include <unistd.h>
> > > > > 
> > > > > int main(int argc, char *argv[])
> > > > > {
> > > > > 	int i;
> > > > > 	int fd[10];
> > > > > 
> > > > > 	for (i = 0; i < 10; i++)
> > > > > 		fd[i] = open("/dev/ttyprintk", O_WRONLY);
> > > > > 	ioctl(fd[0], TIOCVHANGUP);
> > > > > 	for (i = 0; i < 10; i++)
> > > > > 		close(fd[i]);
> > > > > 	close(open("/dev/ttyprintk", O_WRONLY));
> > > > > 	return 0;
> > > > > }
> > > > > ----------
> > > > > 
> > > > > When TTY hangup happens, port->count needs to be reset via
> > > > > "struct tty_operations"->hangup callback.
> > > > > 
> > > > > [1]
> > > > > 
> > 
> > 
https://syzkaller.appspot.com/bug?id=39ea6caa479af471183997376dc7e90bc7d64a6a
> > > > > 
> > > > > Reported-by: syzbot <
> > > > > syzbot+43e93968b964e369db0b@syzkaller.appspotmail.com
> > > > > > 
> > > > > 
> > > > > Reported-by: syzbot <
> > > > > syzbot+3ed715090790806d8b18@syzkaller.appspotmail.com
> > > > > > 
> > > > > 
> > > > > Tested-by: syzbot <
> > > > > syzbot+43e93968b964e369db0b@syzkaller.appspotmail.com>
> > > > > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > > > > Fixes: 24b4b67d17c308aa ("add ttyprintk driver")
> > > > > ---
> > > > >    drivers/char/ttyprintk.c | 11 +++++++++++
> > > > >    1 file changed, 11 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/char/ttyprintk.c b/drivers/char/ttyprintk.c
> > > > > index 6a0059e508e3..93f5d11c830b 100644
> > > > > --- a/drivers/char/ttyprintk.c
> > > > > +++ b/drivers/char/ttyprintk.c
> > > > > @@ -158,12 +158,23 @@ static int tpk_ioctl(struct tty_struct *tty,
> > > > >    	return 0;
> > > > >    }
> > > > >    
> > > > > +/*
> > > > > + * TTY operations hangup function.
> > > > > + */
> > > > > +static void tpk_hangup(struct tty_struct *tty)
> > > > > +{
> > > > > +	struct ttyprintk_port *tpkp = tty->driver_data;
> > > > > +
> > > > > +	tty_port_hangup(&tpkp->port);
> > > > > +}
> > > > > +
> > > > >    static const struct tty_operations ttyprintk_ops = {
> > > > >    	.open = tpk_open,
> > > > >    	.close = tpk_close,
> > > > >    	.write = tpk_write,
> > > > >    	.write_room = tpk_write_room,
> > > > >    	.ioctl = tpk_ioctl,
> > > > > +	.hangup = tpk_hangup,
> > > > >    };
> > > > >    
> > > > >    static const struct tty_port_operations null_ops = { };
> > > > 
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
> > thanks, Samo
> > ---
> >   drivers/char/ttyprintk.c | 26 ++++++++++++++++++--------
> >   1 file changed, 18 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/char/ttyprintk.c b/drivers/char/ttyprintk.c
> > index 93f5d11c8..420222a92 100644
> > --- a/drivers/char/ttyprintk.c
> > +++ b/drivers/char/ttyprintk.c
> > @@ -100,12 +100,6 @@ static int tpk_open(struct tty_struct *tty, struct file
> > *filp)
> >   static void tpk_close(struct tty_struct *tty, struct file *filp)
> >   {
> >   	struct ttyprintk_port *tpkp = tty->driver_data;
> > -	unsigned long flags;
> > -
> > -	spin_lock_irqsave(&tpkp->spinlock, flags);
> > -	/* flush tpk_printk buffer */
> > -	tpk_printk(NULL, 0);
> 
> And now, you can drop NULL buf handling from tpk_printk, right?

Exactly!

thanks, Samo

---
 drivers/char/ttyprintk.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/char/ttyprintk.c b/drivers/char/ttyprintk.c
index 93f5d11c8..6f616cb7c 100644
--- a/drivers/char/ttyprintk.c
+++ b/drivers/char/ttyprintk.c
@@ -54,11 +54,6 @@ static int tpk_printk(const unsigned char *buf, int count)
 {
 	int i = tpk_curr;
 
-	if (buf == NULL) {
-		tpk_flush();
-		return i;
-	}
-
 	for (i = 0; i < count; i++) {
 		if (tpk_curr >= TPK_STR_SIZE) {
 			/* end of tmp buffer reached: cut the message in two */
@@ -100,12 +95,6 @@ static int tpk_open(struct tty_struct *tty, struct file
*filp)
 static void tpk_close(struct tty_struct *tty, struct file *filp)
 {
 	struct ttyprintk_port *tpkp = tty->driver_data;
-	unsigned long flags;
-
-	spin_lock_irqsave(&tpkp->spinlock, flags);
-	/* flush tpk_printk buffer */
-	tpk_printk(NULL, 0);
-	spin_unlock_irqrestore(&tpkp->spinlock, flags);
 
 	tty_port_close(&tpkp->port, tty, filp);
 }
@@ -168,6 +157,20 @@ static void tpk_hangup(struct tty_struct *tty)
 	tty_port_hangup(&tpkp->port);
 }
 
+/*
+ * TTY port operations shutdown function.
+ */
+static void tpk_port_shutdown(struct tty_port *tport)
+{
+	struct ttyprintk_port *tpkp =
+		container_of(tport, struct ttyprintk_port, port);
+	unsigned long flags;
+
+	spin_lock_irqsave(&tpkp->spinlock, flags);
+	tpk_flush();
+	spin_unlock_irqrestore(&tpkp->spinlock, flags);
+}
+
 static const struct tty_operations ttyprintk_ops = {
 	.open = tpk_open,
 	.close = tpk_close,
@@ -177,7 +180,9 @@ static const struct tty_operations ttyprintk_ops = {
 	.hangup = tpk_hangup,
 };
 
-static const struct tty_port_operations null_ops = { };
+static const struct tty_port_operations tpk_port_ops = {
+	.shutdown = tpk_port_shutdown,
+};
 
 static struct tty_driver *ttyprintk_driver;
 
@@ -195,7 +200,7 @@ static int __init ttyprintk_init(void)
 		return PTR_ERR(ttyprintk_driver);
 
 	tty_port_init(&tpk_port.port);
-	tpk_port.port.ops = &null_ops;
+	tpk_port.port.ops = &tpk_port_ops;
 
 	ttyprintk_driver->driver_name = "ttyprintk";
 	ttyprintk_driver->name = "ttyprintk";
-- 
2.17.1

