Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFBC368BF4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 06:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237021AbhDWEXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 00:23:33 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:52777 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhDWEXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 00:23:32 -0400
Received: by mail-wm1-f49.google.com with SMTP id y204so23857891wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 21:22:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M56j6J+2Pwqhpe8pZcjygHn3ALnVsBugCAUBhQaiPQw=;
        b=J0M/1/XiuFgnexDLE6pBcdkwgvMZvO6a4Lmw8En2Rlb7WlyUmi3hzILJai128ZjQ53
         zq/wFv28WE3WyU8im1OCmtDAo1XCWi6PlMWwVIP0ol8PwYPYyD5XL7scAokuE+Z8YgkN
         wOFeWHEjbbRMIFR39hHsDMZDhyt1s8muCtiLZqHdawUft83Huc/SSKeg3e1tFxUk6oHg
         t+S70Pz51/BabNqGpvdtpec79phVYezq9OM+OGYnBMC37cpmGPpas91iIwk3dNWGvOiV
         sprXLIxmTEO4koCbRp1krVihRXk5gOzv3YeTW3VfGKfgs955+hzyz5BG/jrX/dCikGta
         i+mg==
X-Gm-Message-State: AOAM530GWyqqkA3RJVo78W4PuvN5KuOdd0mYQ60LUwCanME9EzWCW/yo
        UGQZLWxdM5GTBsFunJin83A=
X-Google-Smtp-Source: ABdhPJxF2f83eLmCJFPgUPOY6XzD6e9Lw3ewirkqt71xOF97zzSg9SSZ2MQnW3QpY2FK4IPgRigKdg==
X-Received: by 2002:a7b:c5c8:: with SMTP id n8mr3346489wmk.63.1619151775616;
        Thu, 22 Apr 2021 21:22:55 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id z17sm7177200wro.1.2021.04.22.21.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 21:22:55 -0700 (PDT)
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
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <699d0312-ee68-8f05-db2d-07511eaad576@kernel.org>
Date:   Fri, 23 Apr 2021 06:22:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <8043d41d48a0f4f13bd891b4c3e9ad28c76b430e.camel@t-2.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18. 04. 21, 13:16, Samo Pogačnik wrote:
> Dne 15.04.2021 (čet) ob 09:22 +0900 je Tetsuo Handa napisal(a):
>> syzbot is reporting hung task due to flood of
>>
>>    tty_warn(tty, "%s: tty->count = 1 port count = %d\n", __func__,
>>             port->count);
>>
>> message [1], for ioctl(TIOCVHANGUP) prevents tty_port_close() from
>> decrementing port->count due to tty_hung_up_p() == true.
>>
>> ----------
>> #include <sys/types.h>
>> #include <sys/stat.h>
>> #include <fcntl.h>
>> #include <sys/ioctl.h>
>> #include <unistd.h>
>>
>> int main(int argc, char *argv[])
>> {
>> 	int i;
>> 	int fd[10];
>>
>> 	for (i = 0; i < 10; i++)
>> 		fd[i] = open("/dev/ttyprintk", O_WRONLY);
>> 	ioctl(fd[0], TIOCVHANGUP);
>> 	for (i = 0; i < 10; i++)
>> 		close(fd[i]);
>> 	close(open("/dev/ttyprintk", O_WRONLY));
>> 	return 0;
>> }
>> ----------
>>
>> When TTY hangup happens, port->count needs to be reset via
>> "struct tty_operations"->hangup callback.
>>
>> [1]
>> https://syzkaller.appspot.com/bug?id=39ea6caa479af471183997376dc7e90bc7d64a6a
>>
>> Reported-by: syzbot <syzbot+43e93968b964e369db0b@syzkaller.appspotmail.com>
>> Reported-by: syzbot <syzbot+3ed715090790806d8b18@syzkaller.appspotmail.com>
>> Tested-by: syzbot <syzbot+43e93968b964e369db0b@syzkaller.appspotmail.com>
>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> Fixes: 24b4b67d17c308aa ("add ttyprintk driver")
>> ---
>>   drivers/char/ttyprintk.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/char/ttyprintk.c b/drivers/char/ttyprintk.c
>> index 6a0059e508e3..93f5d11c830b 100644
>> --- a/drivers/char/ttyprintk.c
>> +++ b/drivers/char/ttyprintk.c
>> @@ -158,12 +158,23 @@ static int tpk_ioctl(struct tty_struct *tty,
>>   	return 0;
>>   }
>>   
>> +/*
>> + * TTY operations hangup function.
>> + */
>> +static void tpk_hangup(struct tty_struct *tty)
>> +{
>> +	struct ttyprintk_port *tpkp = tty->driver_data;
>> +
>> +	tty_port_hangup(&tpkp->port);
>> +}
>> +
>>   static const struct tty_operations ttyprintk_ops = {
>>   	.open = tpk_open,
>>   	.close = tpk_close,
>>   	.write = tpk_write,
>>   	.write_room = tpk_write_room,
>>   	.ioctl = tpk_ioctl,
>> +	.hangup = tpk_hangup,
>>   };
>>   
>>   static const struct tty_port_operations null_ops = { };
> 
> Using the supplied test code, i've tested the patch on my desktop running the
> 5.4 kernel. After applying the patch, the kernel warnings like "ttyprintk:
> tty_port_close_start: tty->count = 1 port count = 11" do not appear any more,
> when the test code is run.
> I think the patch is ok.

I wonder if the buffer shouldn't be flushed in hangup too? Or better, 
the flush moved from tty_ops->close to tty_port->ops->shutdown?

thanks,
-- 
js
suse labs
