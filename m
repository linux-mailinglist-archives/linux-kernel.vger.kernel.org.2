Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6F536905A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 12:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241898AbhDWK30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 06:29:26 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:43659 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhDWK3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 06:29:24 -0400
Received: by mail-wr1-f41.google.com with SMTP id x7so47813493wrw.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 03:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3bihcbjXILwCGMROvfAwOuvMvpvYX9C6xxJ/XorMq0g=;
        b=Uo5fjGuE4PiEvUec/vu7chd/wOS6JK5rBtnb/8DnuJFRyGeRpXBSvqcNEO7hh9pGPp
         xGeHhhvIrJcw8xIWj+xUm+jaWbs+x89ejQHJzcR8TfC8LTYhlCTc6yb4Zg+Hgq8me33B
         qMOa7c85lQU1G5uslznlz4NOjgV0L26NUK5YzWU+RhrgamrQ8Em2Zk80Fl/OUtFzo3fX
         YcN2gU8aBbr5eMrgZ8qdqUMGaPa0WUFielkHm7glj3/OyDsIjV9oAUt3nExoRBDrdzrB
         Mj2p2uDpXG+uwSOHOAqbTFIY8tMNk9Cjd7g87pUFfWwUdhAK2qGCK5e8weCl1La2njBM
         ij4A==
X-Gm-Message-State: AOAM533H7vA/blIWpIkhut+hOH2JozllXdnohUcoGpw74I9XGMbDLaIM
        YcoAjIhuPsFQxF6R/Yeh3HU=
X-Google-Smtp-Source: ABdhPJz88Ys4UkaXoolbTaNQFtihyLsc6VVmhPgY4rImaM44VtkniV2907KtRAbb8qXM3JMj7jm+xA==
X-Received: by 2002:a5d:5407:: with SMTP id g7mr3876672wrv.149.1619173727264;
        Fri, 23 Apr 2021 03:28:47 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id m15sm8665241wrx.32.2021.04.23.03.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 03:28:46 -0700 (PDT)
Subject: Re: [PATCH] ttyprintk: Add TTY hangup callback.
To:     =?UTF-8?Q?Samo_Poga=c4=8dnik?= <samo_pogacnik@t-2.net>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
 <095d5393-b212-c4d8-5d6d-666bd505cc3d@i-love.sakura.ne.jp>
 <31a4dec3d36ed131402244693cae180816ebd4d7.camel@t-2.net>
 <17e0652d-89b7-c8c0-fb53-e7566ac9add4@i-love.sakura.ne.jp>
 <8043d41d48a0f4f13bd891b4c3e9ad28c76b430e.camel@t-2.net>
 <699d0312-ee68-8f05-db2d-07511eaad576@kernel.org>
 <ba5907e12a30ed8eb3e52a72ea84bf4f72a4c801.camel@t-2.net>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <56763238-c613-e882-a575-75a324d539b1@kernel.org>
Date:   Fri, 23 Apr 2021 12:28:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <ba5907e12a30ed8eb3e52a72ea84bf4f72a4c801.camel@t-2.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 04. 21, 11:55, Samo Pogačnik wrote:
> Dne 23.04.2021 (pet) ob 06:22 +0200 je Jiri Slaby napisal(a):
>> On 18. 04. 21, 13:16, Samo Pogačnik wrote:
>>> Dne 15.04.2021 (čet) ob 09:22 +0900 je Tetsuo Handa napisal(a):
>>>> syzbot is reporting hung task due to flood of
>>>>
>>>>     tty_warn(tty, "%s: tty->count = 1 port count = %d\n", __func__,
>>>>              port->count);
>>>>
>>>> message [1], for ioctl(TIOCVHANGUP) prevents tty_port_close() from
>>>> decrementing port->count due to tty_hung_up_p() == true.
>>>>
>>>> ----------
>>>> #include <sys/types.h>
>>>> #include <sys/stat.h>
>>>> #include <fcntl.h>
>>>> #include <sys/ioctl.h>
>>>> #include <unistd.h>
>>>>
>>>> int main(int argc, char *argv[])
>>>> {
>>>> 	int i;
>>>> 	int fd[10];
>>>>
>>>> 	for (i = 0; i < 10; i++)
>>>> 		fd[i] = open("/dev/ttyprintk", O_WRONLY);
>>>> 	ioctl(fd[0], TIOCVHANGUP);
>>>> 	for (i = 0; i < 10; i++)
>>>> 		close(fd[i]);
>>>> 	close(open("/dev/ttyprintk", O_WRONLY));
>>>> 	return 0;
>>>> }
>>>> ----------
>>>>
>>>> When TTY hangup happens, port->count needs to be reset via
>>>> "struct tty_operations"->hangup callback.
>>>>
>>>> [1]
>>>>
> https://syzkaller.appspot.com/bug?id=39ea6caa479af471183997376dc7e90bc7d64a6a
>>>>
>>>> Reported-by: syzbot <syzbot+43e93968b964e369db0b@syzkaller.appspotmail.com
>>>>>
>>>> Reported-by: syzbot <syzbot+3ed715090790806d8b18@syzkaller.appspotmail.com
>>>>>
>>>> Tested-by: syzbot <syzbot+43e93968b964e369db0b@syzkaller.appspotmail.com>
>>>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>>>> Fixes: 24b4b67d17c308aa ("add ttyprintk driver")
>>>> ---
>>>>    drivers/char/ttyprintk.c | 11 +++++++++++
>>>>    1 file changed, 11 insertions(+)
>>>>
>>>> diff --git a/drivers/char/ttyprintk.c b/drivers/char/ttyprintk.c
>>>> index 6a0059e508e3..93f5d11c830b 100644
>>>> --- a/drivers/char/ttyprintk.c
>>>> +++ b/drivers/char/ttyprintk.c
>>>> @@ -158,12 +158,23 @@ static int tpk_ioctl(struct tty_struct *tty,
>>>>    	return 0;
>>>>    }
>>>>    
>>>> +/*
>>>> + * TTY operations hangup function.
>>>> + */
>>>> +static void tpk_hangup(struct tty_struct *tty)
>>>> +{
>>>> +	struct ttyprintk_port *tpkp = tty->driver_data;
>>>> +
>>>> +	tty_port_hangup(&tpkp->port);
>>>> +}
>>>> +
>>>>    static const struct tty_operations ttyprintk_ops = {
>>>>    	.open = tpk_open,
>>>>    	.close = tpk_close,
>>>>    	.write = tpk_write,
>>>>    	.write_room = tpk_write_room,
>>>>    	.ioctl = tpk_ioctl,
>>>> +	.hangup = tpk_hangup,
>>>>    };
>>>>    
>>>>    static const struct tty_port_operations null_ops = { };
>>>
>>> Using the supplied test code, i've tested the patch on my desktop running
>>> the
>>> 5.4 kernel. After applying the patch, the kernel warnings like "ttyprintk:
>>> tty_port_close_start: tty->count = 1 port count = 11" do not appear any
>>> more,
>>> when the test code is run.
>>> I think the patch is ok.
>>
>> I wonder if the buffer shouldn't be flushed in hangup too? Or better,
>> the flush moved from tty_ops->close to tty_port->ops->shutdown?
>>
>> thanks,
> 
> Good point. I tried the following additional change, which seems to do the
> trick. What do you think?
> 
> thanks, Samo
> ---
>   drivers/char/ttyprintk.c | 26 ++++++++++++++++++--------
>   1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/char/ttyprintk.c b/drivers/char/ttyprintk.c
> index 93f5d11c8..420222a92 100644
> --- a/drivers/char/ttyprintk.c
> +++ b/drivers/char/ttyprintk.c
> @@ -100,12 +100,6 @@ static int tpk_open(struct tty_struct *tty, struct file
> *filp)
>   static void tpk_close(struct tty_struct *tty, struct file *filp)
>   {
>   	struct ttyprintk_port *tpkp = tty->driver_data;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&tpkp->spinlock, flags);
> -	/* flush tpk_printk buffer */
> -	tpk_printk(NULL, 0);

And now, you can drop NULL buf handling from tpk_printk, right?

> -	spin_unlock_irqrestore(&tpkp->spinlock, flags);
>   
>   	tty_port_close(&tpkp->port, tty, filp);



-- 
js
suse labs
