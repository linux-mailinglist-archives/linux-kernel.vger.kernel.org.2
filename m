Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62828354BCF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 06:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243629AbhDFEvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 00:51:50 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:40952 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242465AbhDFEvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 00:51:48 -0400
Received: by mail-wr1-f51.google.com with SMTP id v11so12679457wro.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 21:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9R9v6jduJsXDs1Ee5qjaXCVasduz+b0k+mS/nqmF/wQ=;
        b=OStdaWSL18yuZwotRTEE+hbzU9QEIts0QI6/Gk/vAhRIrHH6gFgHCbhqKSEa5h7xxm
         9uR++rx2KMIOvUkSYs3IX/8wzFpwkN5xAwvvss3UisEImqV1HnK8TzajnD4V9zSdiOjO
         WoLPaexwVJRGKs+W9IT6j2AqhwC9L9KO/J6t1jD24NDtHzy9uBKF11voGzFBnjw8qJlt
         NERzxzuRgvrEFNg8yEY7rFcpj4SXF+KBk6kFR6Sig+Aa34Fi6BS2GtXNvePNYF9KzCh7
         fiNJm3wORWp+Z+21MhYE8SLMtkESbJk3WRAdtqPc2CWoPlu82dpDUb6XqVu+DyKT7lSj
         leQw==
X-Gm-Message-State: AOAM531kB8wVY5IkHCSLO5pxUQxF96CoYW02dmMtZ24JFVKcA3snNvKi
        Ut5BBCcfks2fwUEXCSeBUiLw5Mf1Z1c=
X-Google-Smtp-Source: ABdhPJwKhtsHvu8sx3V0r5GOJNrq6/e3K3oVpLXF8lh6l73sB2Q8sVAm5ZcoudXgrYIMma+SILHIbg==
X-Received: by 2002:a5d:4683:: with SMTP id u3mr8865735wrq.358.1617684699072;
        Mon, 05 Apr 2021 21:51:39 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id o14sm19066611wrc.3.2021.04.05.21.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Apr 2021 21:51:38 -0700 (PDT)
Subject: Re: [PATCH] tty: use printk_safe context at tty_msg()
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
References: <20210403041444.4081-1-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <a7f5103f-0912-30e1-611c-36c18a1eefd6@kernel.org>
Date:   Tue, 6 Apr 2021 06:51:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210403041444.4081-1-penguin-kernel@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03. 04. 21, 6:14, Tetsuo Handa wrote:
> syzbot is reporting circular locking dependency due to calling printk()
> with port lock held [1]. When this problem was reported, we worried
> whether printk_safe context will remain available in future kernels [2],
> and then this problem was forgotten. But in order to utilize syzbot's
> resource for finding other bugs/reproducers by closing this one of top
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
>   drivers/tty/tty_buffer.c | 5 ++++-
>   include/linux/tty.h      | 9 ++++++++-
>   2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
> index 6d4995a5f318..d59f7873bc49 100644
> --- a/drivers/tty/tty_buffer.c
> +++ b/drivers/tty/tty_buffer.c
> @@ -156,6 +156,7 @@ static struct tty_buffer *tty_buffer_alloc(struct tty_port *port, size_t size)
>   {
>   	struct llist_node *free;
>   	struct tty_buffer *p;
> +	unsigned long flags;
>   
>   	/* Round the buffer size out */
>   	size = __ALIGN_MASK(size, TTYB_ALIGN_MASK);
> @@ -172,7 +173,9 @@ static struct tty_buffer *tty_buffer_alloc(struct tty_port *port, size_t size)
>   	   have queued and recycle that ? */
>   	if (atomic_read(&port->buf.mem_used) > port->buf.mem_limit)
>   		return NULL;
> -	p = kmalloc(sizeof(struct tty_buffer) + 2 * size, GFP_ATOMIC);
> +	printk_safe_enter_irqsave(flags);
> +	p = kmalloc(sizeof(struct tty_buffer) + 2 * size, GFP_ATOMIC | __GFP_NOWARN);
> +	printk_safe_exit_irqrestore(flags);
>   	if (p == NULL)
>   		return NULL;
>   
> diff --git a/include/linux/tty.h b/include/linux/tty.h
> index 95fc2f100f12..7ae8eb46fec3 100644
> --- a/include/linux/tty.h
> +++ b/include/linux/tty.h
> @@ -14,6 +14,7 @@
>   #include <uapi/linux/tty.h>
>   #include <linux/rwsem.h>
>   #include <linux/llist.h>
> +#include <../../kernel/printk/internal.h>

Including printk's internal header in linux/tty.h doesn't look correct 
to me.

> @@ -773,7 +774,13 @@ static inline void proc_tty_unregister_driver(struct tty_driver *d) {}
>   #endif
>   
>   #define tty_msg(fn, tty, f, ...) \
> -	fn("%s %s: " f, tty_driver_name(tty), tty_name(tty), ##__VA_ARGS__)
> +	do {						\
> +		unsigned long flags;			\
> +							\
> +		printk_safe_enter_irqsave(flags);	\
> +		fn("%s %s: " f, tty_driver_name(tty), tty_name(tty), ##__VA_ARGS__); \
> +		printk_safe_exit_irqrestore(flags);	\
> +	} while (0)
>   
>   #define tty_debug(tty, f, ...)	tty_msg(pr_debug, tty, f, ##__VA_ARGS__)
>   #define tty_info(tty, f, ...)	tty_msg(pr_info, tty, f, ##__VA_ARGS__)
> 


-- 
js
