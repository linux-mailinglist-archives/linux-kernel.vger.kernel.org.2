Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F0235C42D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239411AbhDLKjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 06:39:31 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:51059 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239343AbhDLKja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 06:39:30 -0400
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 13CAdAfF031521;
        Mon, 12 Apr 2021 19:39:10 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav105.sakura.ne.jp);
 Mon, 12 Apr 2021 19:39:10 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav105.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 13CAdAKa031517
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 12 Apr 2021 19:39:10 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: How to handle concurrent access to /dev/ttyprintk ?
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Samo Pogacnik <samo_pogacnik@t-2.net>
Cc:     Petr Mladek <pmladek@suse.com>, Jiri Slaby <jirislaby@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210403041444.4081-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <YGx59PEq2Y015YdK@alley>
 <3c15d32f-c568-7f6f-fa7e-af4deb9b49f9@i-love.sakura.ne.jp>
 <d78ae8da-16e9-38d9-e274-048c54e24360@i-love.sakura.ne.jp>
 <YG24F9Kx+tjxhh8G@kroah.com>
 <051b550c-1cdd-6503-d2b7-0877bf0578fc@i-love.sakura.ne.jp>
Message-ID: <cd213843-45fe-2eac-4943-0906ab8d272b@i-love.sakura.ne.jp>
Date:   Mon, 12 Apr 2021 19:39:04 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <051b550c-1cdd-6503-d2b7-0877bf0578fc@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What is the intended usage of /dev/ttyprintk ?

It seems that drivers/char/ttyprintk.c was not designed to be opened by
multiple processes. As a result, syzbot can trigger tty_warn() flooding
enough to fire khungtaskd warning due to tty_port_close().

Do we need to allow concurrent access to /dev/ttyprintk ?
If we can't change /dev/ttyprintk exclusively open()able by only
one thread, how to handle concurrent access to /dev/ttyprintk ?

On 2021/04/07 23:24, Tetsuo Handa wrote:
> On 2021/04/07 22:48, Greg Kroah-Hartman wrote:
>>> By the way, as soon as applying this patch, I guess that syzkaller starts
>>> generating hung task reports because /dev/ttyprintk can trivially trigger
>>> flood of
>>>
>>>   tty_warn(tty, "%s: tty->count = 1 port count = %d\n", __func__,
>>>            port->count);
>>>
>>> message, and adding
>>>
>>>   if (strcmp(tty_driver_name(tty), "ttyprintk"))
>>
>> Odd, how can ttyprintk() generate that mess?
> 
> So far three tests and results:
> 
>   https://groups.google.com/g/syzkaller-bugs/c/yRLYijD2tbw/m/WifLgadvAAAJ
>   https://groups.google.com/g/syzkaller-bugs/c/yRLYijD2tbw/m/w2_MiMmAAAAJ
>   https://groups.google.com/g/syzkaller-bugs/c/yRLYijD2tbw/m/hfsQqSOPAAAJ
> 
> Patch https://syzkaller.appspot.com/x/patch.diff?x=145e4c9ad00000 generated
> console output https://syzkaller.appspot.com/x/log.txt?x=162f9fced00000 .
> 
> Patch https://syzkaller.appspot.com/x/patch.diff?x=14839931d00000 did not
> flood the console output enough to fire khungtaskd.
> 
> Maybe it is because /dev/ttyprintk can be opened/closed by multiple processes
> without serialization?
> 
> Running
> 
>   for i in $(seq 1 100); do sleep 1 > /dev/ttyprintk & done
> 
> results in
> 
>   tty_port_close_start: tty->count = 1 port count = 100
> 
> . If tty_port_open() from tpk_open() can do
> 
>   spin_lock_irq(&port->lock);
>   ++port->count;
>   spin_unlock_irq(&port->lock);
> 
> when tty_port_close_start() from tty_port_close() from tpk_close() is doing
> 
>   spin_lock_irqsave(&port->lock, flags);
>   if (tty->count == 1 && port->count != 1) {
>     tty_warn(tty, "%s: tty->count = 1 port count = %d\n", __func__,
>              port->count);
>     port->count = 1;
>   }
>   if (--port->count < 0) {
>     tty_warn(tty, "%s: bad port count (%d)\n", __func__,
>              port->count);
>     port->count = 0;
>   }
> 
>   if (port->count) {
>     spin_unlock_irqrestore(&port->lock, flags);
>     return 0;
>   }
>   spin_unlock_irqrestore(&port->lock, flags);
> 
> , what prevents port->count from getting larger than 1 ?
> 

