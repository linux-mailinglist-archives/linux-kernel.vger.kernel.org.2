Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C2B356E7E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 16:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348307AbhDGOZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 10:25:52 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:52120 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235723AbhDGOZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 10:25:43 -0400
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 137EOcIX079120;
        Wed, 7 Apr 2021 23:24:39 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav405.sakura.ne.jp);
 Wed, 07 Apr 2021 23:24:38 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav405.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 137EOc4s079117
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 7 Apr 2021 23:24:38 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2] tty: use printk_deferred() at tty_msg()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Petr Mladek <pmladek@suse.com>, Jiri Slaby <jirislaby@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <20210403041444.4081-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <YGx59PEq2Y015YdK@alley>
 <3c15d32f-c568-7f6f-fa7e-af4deb9b49f9@i-love.sakura.ne.jp>
 <d78ae8da-16e9-38d9-e274-048c54e24360@i-love.sakura.ne.jp>
 <YG24F9Kx+tjxhh8G@kroah.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <051b550c-1cdd-6503-d2b7-0877bf0578fc@i-love.sakura.ne.jp>
Date:   Wed, 7 Apr 2021 23:24:33 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YG24F9Kx+tjxhh8G@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/04/07 22:48, Greg Kroah-Hartman wrote:
>> By the way, as soon as applying this patch, I guess that syzkaller starts
>> generating hung task reports because /dev/ttyprintk can trivially trigger
>> flood of
>>
>>   tty_warn(tty, "%s: tty->count = 1 port count = %d\n", __func__,
>>            port->count);
>>
>> message, and adding
>>
>>   if (strcmp(tty_driver_name(tty), "ttyprintk"))
> 
> Odd, how can ttyprintk() generate that mess?

So far three tests and results:

  https://groups.google.com/g/syzkaller-bugs/c/yRLYijD2tbw/m/WifLgadvAAAJ
  https://groups.google.com/g/syzkaller-bugs/c/yRLYijD2tbw/m/w2_MiMmAAAAJ
  https://groups.google.com/g/syzkaller-bugs/c/yRLYijD2tbw/m/hfsQqSOPAAAJ

Patch https://syzkaller.appspot.com/x/patch.diff?x=145e4c9ad00000 generated
console output https://syzkaller.appspot.com/x/log.txt?x=162f9fced00000 .

Patch https://syzkaller.appspot.com/x/patch.diff?x=14839931d00000 did not
flood the console output enough to fire khungtaskd.

Maybe it is because /dev/ttyprintk can be opened/closed by multiple processes
without serialization?

Running

  for i in $(seq 1 100); do sleep 1 > /dev/ttyprintk & done

results in

  tty_port_close_start: tty->count = 1 port count = 100

. If tty_port_open() from tpk_open() can do

  spin_lock_irq(&port->lock);
  ++port->count;
  spin_unlock_irq(&port->lock);

when tty_port_close_start() from tty_port_close() from tpk_close() is doing

  spin_lock_irqsave(&port->lock, flags);
  if (tty->count == 1 && port->count != 1) {
    tty_warn(tty, "%s: tty->count = 1 port count = %d\n", __func__,
             port->count);
    port->count = 1;
  }
  if (--port->count < 0) {
    tty_warn(tty, "%s: bad port count (%d)\n", __func__,
             port->count);
    port->count = 0;
  }

  if (port->count) {
    spin_unlock_irqrestore(&port->lock, flags);
    return 0;
  }
  spin_unlock_irqrestore(&port->lock, flags);

, what prevents port->count from getting larger than 1 ?
