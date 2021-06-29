Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9EA3B75CC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 17:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbhF2Pot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 11:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbhF2Por (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 11:44:47 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFD8C061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 08:42:20 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id b5-20020a17090a9905b029016fc06f6c5bso2710787pjp.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 08:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S1nyxTNyKIv6xPRsPeUnMhjNpagEaP2nZRgi4aFLtaw=;
        b=UeEhSFFPEVOqaeCDh9HPSYx9BslW6V/lxvu1G8a1WGahdxjh/bPELhJiLcJW8DAcPF
         7cULCet3DIstVFDjtFQOX0cG97gyRNrZedE3QIEKlZFk0Lp98uw3V6qLoRO9VqgG48Cw
         GVgw8v7pcVWA+PKvYn5bFhsRpB0JImGixeFtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S1nyxTNyKIv6xPRsPeUnMhjNpagEaP2nZRgi4aFLtaw=;
        b=sbVqhwZKLTlrWzcmcTlcSvGDbaVwTjFgyjZ/hEoADks3rWo+4JHdesghD/+y/CYgih
         eaczvpqdnoGD83IC5Rk2FN5h+HBGfU/iTo77uiF/h03+f6X/YtY3BrxUuY0fvqaprtZX
         GeTlJg1/yX0SeFy16s3qt7zxDKEmZ5VZ8LYrY4aUpyvLj3DQgBR+Rm8pancT923Ym24L
         DtqA/pe4ZHAkFf9lh/PtYww6rD2B91Wa4qslkAMI8bA0may0GGM8xUuj1KVS/AbsyB/G
         KA5TxBKWyBQT8VQbwi2xt41U+J//9AetIOCZZrgz29YKFCA0jnqMQNfxwA11daKpQNfG
         Gq+Q==
X-Gm-Message-State: AOAM530E0TTOLlF7RPaczgojKkaWZDW+i2l13EHV1j4ugccJU7aZE8ex
        E27J53Oxql3hje7mrW0MPnHNfw==
X-Google-Smtp-Source: ABdhPJymoQ3YJNOyzIF+WKlkFMhbnMI+nB6DPkOBsPxlAC6ibhrSWi0U6DceQHlMpLstqbjQgR8ZJQ==
X-Received: by 2002:a17:90a:14a4:: with SMTP id k33mr32674856pja.13.1624981339641;
        Tue, 29 Jun 2021 08:42:19 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:d87f:6819:b50a:74b])
        by smtp.gmail.com with ESMTPSA id ck1sm3650199pjb.3.2021.06.29.08.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 08:42:18 -0700 (PDT)
Date:   Wed, 30 Jun 2021 00:42:13 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] printk/console: Check consistent sequence number when
 handling race in console_unlock()
Message-ID: <YNs/Vbi2Yt0s10Ye@google.com>
References: <20210629143341.19284-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629143341.19284-1-pmladek@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/06/29 16:33), Petr Mladek wrote:
> The standard printk() tries to flush the message to the console
> immediately. It tries to take the console lock. If the lock is
> already taken then the current owner is responsible for flushing
> even the new message.
> 
> There is a small race window between checking whether a new message is
> available and releasing the console lock. It is solved by re-checking
> the state after releasing the console lock. If the check is positive
> then console_unlock() tries to take the lock again and process the new
> message as well.
[..]
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 142a58d124d9..87411084075e 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2545,6 +2545,7 @@ void console_unlock(void)
>  	bool do_cond_resched, retry;
>  	struct printk_info info;
>  	struct printk_record r;
> +	u64 next_seq;
>  
>  	if (console_suspended) {
>  		up_console_sem();
> @@ -2654,8 +2655,10 @@ void console_unlock(void)
>  			cond_resched();
>  	}
>  
> -	console_locked = 0;
> +	/* Get consistent value of the next-to-be-used sequence number. */
> +	next_seq = console_seq;
>  
> +	console_locked = 0;
>  	up_console_sem();
>  
>  	/*
> @@ -2664,7 +2667,7 @@ void console_unlock(void)
>  	 * there's a new owner and the console_unlock() from them will do the
>  	 * flush, no worries.
>  	 */
> -	retry = prb_read_valid(prb, console_seq, NULL);
> +	retry = prb_read_valid(prb, next_seq, NULL);
>  	printk_safe_exit_irqrestore(flags);
>  
>  	if (retry && console_trylock())

Maybe it's too late here in my time zone, but what are the consequences
of this race?

`retry` can be falsely set, console_trylock() does not spin on owner,
so the context that just released the lock can grab it again only if
it's unlocked. For the context that just has released the console_sem
and then acquired it again, because of the race, - console_seq will be
valid after it acquires the lock, then it'll jump to `retry` and
re-validated the console_seq - prb_read_valid(). If it's valid, it'll
print the message; and should another CPU printk that CPU will spin on
owner and then the current console_sem owner will yield to it via
console_lock_spinning branch.

One way or the other, good catch and nice to have it fixed.

Acked-by: Sergey Senozhatsky <senozhatsky@chromium.org>
