Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5BAE355767
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 17:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345502AbhDFPK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 11:10:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:50866 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229558AbhDFPKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:10:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617721845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mu4G1CpYpvjYiF6y0A7b0Ox7sDz+F1oXyt9b9Xt/Rps=;
        b=XB6Otjori4ndSz5kLok4LT6KjE9Y+ScaApAzHLI8tmCBDt+F/tQLHljVXoN122P9cAj5La
        9+taDuSoJIpcfIzRVb52xhjAn9tU2Uj0MsOxik7dPkB9BY5Xt97B6lXT4BV8S4REIlCsOB
        6W3jjVYhew94zY2Loy//0Wfxxb8QUNc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 447C7B1F7;
        Tue,  6 Apr 2021 15:10:45 +0000 (UTC)
Date:   Tue, 6 Apr 2021 17:10:44 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: use printk_safe context at tty_msg()
Message-ID: <YGx59PEq2Y015YdK@alley>
References: <20210403041444.4081-1-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210403041444.4081-1-penguin-kernel@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2021-04-03 13:14:44, Tetsuo Handa wrote:
> syzbot is reporting circular locking dependency due to calling printk()
> with port lock held [1]. When this problem was reported, we worried

Could you please include the lockdep report into the commit message?
External links are not guaranteed to stay.


> whether printk_safe context will remain available in future kernels [2],
> and then this problem was forgotten. But in order to utilize syzbot's
> resource for finding other bugs/reproducers by closing this one of
> top

Is it possible to quantify how many resources are wasted by this
bug, please? Is this visible in one run from 10 or from 1000
or from 100000 runs?

I ask because this is just a workaround. It takes our time instead
of working on the proper solution. It will also add extra work when
the right solution is in please. See below for more details.

> crashers, let's apply a patch which counts on availability of printk_safe
> context.
> 
> syzbot is also reporting same dependency due to memory allocation fault
> injection at tty_buffer_alloc(). Although __GFP_NOWARN cannot prevent
> memory allocation fault injection from calling printk(), let's use
> __GFP_NOWARN at tty_buffer_alloc() in addition to using printk_safe
> context, for generating many lines of messages due to warn_alloc() is
> annoying. If we want to report it, we can use pr_warn() instead.
> 
> [1] https://syzkaller.appspot.com/bug?id=39ea6caa479af471183997376dc7e90bc7d64a6a
> [2] https://lkml.kernel.org/r/20190218054649.GA26686@jagdpanzerIV
> 
> Reported-by: syzbot <syzbot+43e93968b964e369db0b@syzkaller.appspotmail.com>
> Reported-by: syzbot <syzbot+3ed715090790806d8b18@syzkaller.appspotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Fixes: b6da31b2c07c46f2 ("tty: Fix data race in tty_insert_flip_string_fixed_flag")
> Cc: <stable@vger.kernel.org> # 4.18+
> ---
>  drivers/tty/tty_buffer.c | 5 ++++-
>  include/linux/tty.h      | 9 ++++++++-
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
> index 6d4995a5f318..d59f7873bc49 100644
> --- a/drivers/tty/tty_buffer.c
> +++ b/drivers/tty/tty_buffer.c
> @@ -156,6 +156,7 @@ static struct tty_buffer *tty_buffer_alloc(struct tty_port *port, size_t size)
>  {
>  	struct llist_node *free;
>  	struct tty_buffer *p;
> +	unsigned long flags;
>  
>  	/* Round the buffer size out */
>  	size = __ALIGN_MASK(size, TTYB_ALIGN_MASK);
> @@ -172,7 +173,9 @@ static struct tty_buffer *tty_buffer_alloc(struct tty_port *port, size_t size)
>  	   have queued and recycle that ? */
>  	if (atomic_read(&port->buf.mem_used) > port->buf.mem_limit)
>  		return NULL;
> -	p = kmalloc(sizeof(struct tty_buffer) + 2 * size, GFP_ATOMIC);
> +	printk_safe_enter_irqsave(flags);
> +	p = kmalloc(sizeof(struct tty_buffer) + 2 * size, GFP_ATOMIC | __GFP_NOWARN);
> +	printk_safe_exit_irqrestore(flags);

I do not see tty_buffer_alloc() anywhere at
https://syzkaller.appspot.com/bug?id=39ea6caa479af471183997376dc7e90bc7d64a6a

Could you please provide more details why this is needed?


>  	if (p == NULL)
>  		return NULL;
>  
> diff --git a/include/linux/tty.h b/include/linux/tty.h
> index 95fc2f100f12..7ae8eb46fec3 100644
> --- a/include/linux/tty.h
> +++ b/include/linux/tty.h
> @@ -14,6 +14,7 @@
>  #include <uapi/linux/tty.h>
>  #include <linux/rwsem.h>
>  #include <linux/llist.h>
> +#include <../../kernel/printk/internal.h>

Do not do this, please! We would need to make the printk_safe() API
public if we want to use it outside kernel/printk/

>  /*
> @@ -773,7 +774,13 @@ static inline void proc_tty_unregister_driver(struct tty_driver *d) {}
>  #endif
>  
>  #define tty_msg(fn, tty, f, ...) \
> -	fn("%s %s: " f, tty_driver_name(tty), tty_name(tty), ##__VA_ARGS__)
> +	do {						\
> +		unsigned long flags;			\
> +							\
> +		printk_safe_enter_irqsave(flags);	\
> +		fn("%s %s: " f, tty_driver_name(tty), tty_name(tty), ##__VA_ARGS__); \
> +		printk_safe_exit_irqrestore(flags);	\
> +	} while (0)

There is no need to call single printk() in printk_safe() context.
printk_deferred() is enough.

Anyway, I am not sure if it is really a deadlock. One part of the
cycle is:

PU: 1 PID: 9840 Comm: syz-executor339 Not tainted 5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2127
 check_prev_add kernel/locking/lockdep.c:2936 [inline]
 check_prevs_add kernel/locking/lockdep.c:3059 [inline]
 validate_chain kernel/locking/lockdep.c:3674 [inline]
 __lock_acquire+0x2b14/0x54c0 kernel/locking/lockdep.c:4900
 lock_acquire kernel/locking/lockdep.c:5510 [inline]
 lock_acquire+0x1ab/0x740 kernel/locking/lockdep.c:5475
 console_lock_spinning_enable kernel/printk/printk.c:1714 [inline]
 console_unlock+0x371/0xc80 kernel/printk/printk.c:2573
 vprintk_emit+0x1ca/0x560 kernel/printk/printk.c:2098
 vprintk_func+0x8d/0x1e0 kernel/printk/printk_safe.c:401
 printk+0xba/0xed kernel/printk/printk.c:2146
 tty_port_close_start.part.0+0x503/0x550 drivers/tty/tty_port.c:569
 tty_port_close_start drivers/tty/tty_port.c:641 [inline]
 tty_port_close+0x46/0x170 drivers/tty/tty_port.c:634
 tty_release+0x45e/0x1210 drivers/tty/tty_io.c:1779
 __fput+0x288/0x920 fs/file_table.c:280
 task_work_run+0xdd/0x1a0 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x249/0x250 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:301
 entry_SYSCALL_64_after_hwframe+0x44/0xae

It guess that the tty using this port_lock is not longer
registered console when tty_port_close() is called. If this
is true than the problematic port_lock will not longer
be taken from console_unlock().


Sure, this report breaks the test and might prevent finding
real problems.

Just note that printk_deferred()/printk_safe() is only temporary
solution. It will get obsoleted by offloading the console handling
to kthreads. It goes slowly because it is not trivial. We want
to do it a clean way and carefully. Any historic or new
workarounds/hacks would only slow it down.

My estimation is that we could have the offloaded consoles
within the next 3-4 development cycles.

Please, consider whether it is really worth adding these workarounds.

Best Regards,
Petr
