Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B8735F1F2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 13:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239428AbhDNLMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 07:12:16 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:51287 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhDNLMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 07:12:12 -0400
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 13EBBnhj073324;
        Wed, 14 Apr 2021 20:11:50 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav304.sakura.ne.jp);
 Wed, 14 Apr 2021 20:11:49 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav304.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 13EBBhIP073266
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 14 Apr 2021 20:11:49 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: How to handle concurrent access to /dev/ttyprintk ?
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samo Pogacnik <samo_pogacnik@t-2.net>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
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
 <32e75be6-6e9f-b33f-d585-13db220519da@i-love.sakura.ne.jp>
 <YHQ3Zy9gRdZsu77w@kroah.com>
 <ffcc8099-614c-f4b1-10c1-f1d4c7f72e65@i-love.sakura.ne.jp>
Message-ID: <095d5393-b212-c4d8-5d6d-666bd505cc3d@i-love.sakura.ne.jp>
Date:   Wed, 14 Apr 2021 20:11:40 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <ffcc8099-614c-f4b1-10c1-f1d4c7f72e65@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/04/14 9:45, Tetsuo Handa wrote:
> On 2021/04/12 21:04, Greg Kroah-Hartman wrote:
>>> Since syzkaller is a fuzzer, syzkaller happily opens /dev/ttyprintk from
>>> multiple threads. Should we update syzkaller to use CONFIG_TTY_PRINTK=n ?
>>
>> Why?  Can you not hit the same tty code paths from any other tty driver
>> being open multiple times?  Why is ttyprintk somehow "special" here?
> 
> I found a simplified reproducer. If we call ioctl(TIOCVHANGUP) on /dev/ttyprintk ,
> "struct ttyprintk_port tpk_port".port.count cannot be decremented by
> tty_port_close() from tpk_close() due to tty_hung_up_p() == true when
> close() is called. As a result, tty->count and port count gets out of sync.
> 
> Then, when /dev/ttyprintk is opened again and then closed without calling
> ioctl(TIOCVHANGUP), this message is printed due to tty_hung_up_p() == false.
> 
> If I replace /dev/ttyprintk with /dev/ttyS0 in the reproducer shown above,
> this message is not printed.
> 

The difference between /dev/ttyS0 and /dev/ttyprintk is that
the former provides uart_hangup() as "struct tty_operations"->hangup
while the latter does not provide "struct tty_operations"->hangup .

It seems to me that below patch avoids this message, but I'm not familiar
with tty code. Is this fix correct? Don't we need to enforce all drivers
to provide "struct tty_operations"->hangup in order to reset port count ?

diff --git a/drivers/char/ttyprintk.c b/drivers/char/ttyprintk.c
index 6a0059e508e3..ff3b9a41b91b 100644
--- a/drivers/char/ttyprintk.c
+++ b/drivers/char/ttyprintk.c
@@ -158,12 +158,26 @@ static int tpk_ioctl(struct tty_struct *tty,
 	return 0;
 }
 
+/*
+ * TTY operations hangup function.
+ */
+static void tpk_hangup(struct tty_struct *tty)
+{
+	struct ttyprintk_port *tpkp = tty->driver_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&tpkp->port.lock, flags);
+	tpkp->port.count = 0;
+	spin_unlock_irqrestore(&tpkp->port.lock, flags);
+}
+
 static const struct tty_operations ttyprintk_ops = {
 	.open = tpk_open,
 	.close = tpk_close,
 	.write = tpk_write,
 	.write_room = tpk_write_room,
 	.ioctl = tpk_ioctl,
+	.hangup = tpk_hangup,
 };
 
 static const struct tty_port_operations null_ops = { };
