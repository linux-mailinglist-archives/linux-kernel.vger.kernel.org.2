Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3B135C507
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 13:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238892AbhDLLZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 07:25:53 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:54896 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237626AbhDLLZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 07:25:52 -0400
Received: from fsav107.sakura.ne.jp (fsav107.sakura.ne.jp [27.133.134.234])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 13CBPX82077974;
        Mon, 12 Apr 2021 20:25:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav107.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav107.sakura.ne.jp);
 Mon, 12 Apr 2021 20:25:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav107.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 13CBPXt1077967
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 12 Apr 2021 20:25:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: How to handle concurrent access to /dev/ttyprintk ?
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Samo Pogacnik <samo_pogacnik@t-2.net>,
        Petr Mladek <pmladek@suse.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <20210403041444.4081-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <YGx59PEq2Y015YdK@alley>
 <3c15d32f-c568-7f6f-fa7e-af4deb9b49f9@i-love.sakura.ne.jp>
 <d78ae8da-16e9-38d9-e274-048c54e24360@i-love.sakura.ne.jp>
 <YG24F9Kx+tjxhh8G@kroah.com>
 <051b550c-1cdd-6503-d2b7-0877bf0578fc@i-love.sakura.ne.jp>
 <cd213843-45fe-2eac-4943-0906ab8d272b@i-love.sakura.ne.jp>
 <YHQkeZVs3pmyie9e@kroah.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <32e75be6-6e9f-b33f-d585-13db220519da@i-love.sakura.ne.jp>
Date:   Mon, 12 Apr 2021 20:25:27 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YHQkeZVs3pmyie9e@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/04/12 19:44, Greg Kroah-Hartman wrote:
> And trying to "open exclusive only" just does not work, the kernel can
> not enforce that at all, sorry.  Any driver that you see trying to do
> that is trivial to work around in userspace, making the kernel code
> pointless.

You mean something like below cannot be used?

diff --git a/drivers/char/ttyprintk.c b/drivers/char/ttyprintk.c
index 6a0059e508e3..57200569918a 100644
--- a/drivers/char/ttyprintk.c
+++ b/drivers/char/ttyprintk.c
@@ -84,14 +84,26 @@ static int tpk_printk(const unsigned char *buf, int count)
 	return count;
 }
 
+static DEFINE_MUTEX(open_close_lock);
+
 /*
  * TTY operations open function.
  */
 static int tpk_open(struct tty_struct *tty, struct file *filp)
 {
-	tty->driver_data = &tpk_port;
+	int ret;
+
+	if (mutex_lock_killable(&open_close_lock))
+		return -EINTR;
 
-	return tty_port_open(&tpk_port.port, tty, filp);
+	if (tpk_port.port.count) {
+		ret = -EBUSY;
+	} else {
+		tty->driver_data = &tpk_port;
+		ret = tty_port_open(&tpk_port.port, tty, filp);
+	}
+	mutex_unlock(&open_close_lock);
+	return ret;
 }
 
 /*
@@ -102,12 +114,14 @@ static void tpk_close(struct tty_struct *tty, struct file *filp)
 	struct ttyprintk_port *tpkp = tty->driver_data;
 	unsigned long flags;
 
+	mutex_lock(&open_close_lock);
 	spin_lock_irqsave(&tpkp->spinlock, flags);
 	/* flush tpk_printk buffer */
 	tpk_printk(NULL, 0);
 	spin_unlock_irqrestore(&tpkp->spinlock, flags);
 
 	tty_port_close(&tpkp->port, tty, filp);
+	mutex_unlock(&open_close_lock);
 }
 
 /*

> Like any tty port, if you have multiple accesses, all bets are off and
> hilarity ensues.  Just don't do that and expect things to be working
> well.

Since syzkaller is a fuzzer, syzkaller happily opens /dev/ttyprintk from
multiple threads. Should we update syzkaller to use CONFIG_TTY_PRINTK=n ?

