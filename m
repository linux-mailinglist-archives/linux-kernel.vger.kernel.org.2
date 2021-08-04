Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5383E04D0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 17:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239559AbhHDPuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 11:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239541AbhHDPuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 11:50:04 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F023C06179A
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 08:49:52 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d17so3417477plr.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 08:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lolJOQ/pDkhpZmSstAwhBf30dRWZ/dheUOrA2K0SwbY=;
        b=yHkcs5WpZZ/7l2UtWYCvh20javqvwsDJ3PKfmGJZHPamOaNlIhiXjqz6G8wcHMdX1L
         xMkOJUZtC41vudQ6UdYH7QEbQxDGwQexiShJJU6Jy+u59FHJXF8cll79WLfO1HyG/Pvm
         uk7ZKpFnMFqH7vbNPhpULUpUoxmX1F48oEJXEa4EpOAj8XKpWkuzcmjxWpVR2oZ0DvqY
         jWfTQ1tDCMe7Lc6hsrf3/TtnCi52sc7U1lZFiX76QerC/7JMBhAHAWUdxn8ws0EYuj9+
         lS4UHz/vTT87ZGWepS9e5Ib5GPhGwqCgqVjficXMlxJiRD2oNlwiju8gHdXSrRNXOTyK
         1dcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lolJOQ/pDkhpZmSstAwhBf30dRWZ/dheUOrA2K0SwbY=;
        b=ls2aN9UmmZ/3kZF4OqmOnAY8voLb8cA1oF2rk6PoYBzg5ELDjee4Y0EQQfwQlELXa9
         CgVPDeUtuvQU9xWQ5hZULZT+e3hJmtb1rn02Hi4GEKZj0fwDPIl7Vi+5cA8hIITUBGhZ
         K0aSeQz4Q1GwWL5L3PAntq4bdBlpkxFkSCdwAwgRxF6DlGqCSb9T/an70dDCGwX8pqTx
         U+R02LgB6WWA1Tf2zl1axFdIcdTnJzPU1PkZ75cQIHWP8NciZPuPWoxJ7DDUZxtHkmeF
         0dnJFjHCJ0vkNk8fcv8won0AbJGexgvbo+bWd1spD/KFZJqmAUI+tV1+Qj5mkpDVVdBz
         dAdg==
X-Gm-Message-State: AOAM531BsBL0wBGSdgTEk6UFTOP4dggdE9HOj6Ji9KKepIm0sxp0ZdtR
        zEwjNAuVtntY+R6++YW9XC+S9Q==
X-Google-Smtp-Source: ABdhPJw+7sCX4Aa7+vI/gBTqDNQzVEL9sb2COLEp4EqgfOhxlMwlqyZ1n+oCSM7+3xXJbqiQIK8jVw==
X-Received: by 2002:a17:90a:a103:: with SMTP id s3mr28826345pjp.121.1628092191384;
        Wed, 04 Aug 2021 08:49:51 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id a12sm3516429pfg.120.2021.08.04.08.49.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 08:49:50 -0700 (PDT)
Subject: Re: [ANNOUNCE] v5.14-rc4-rt4
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <wagi@monom.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
References: <20210802162750.santic4y6lzcet5c@linutronix.de>
 <20210804082418.fbibprcwtzyt5qax@beryllium.lan>
 <20210804104340.fhdjwn3hruymu3ml@linutronix.de>
 <20210804104803.4nwxi74sa2vwiujd@linutronix.de>
 <20210804110057.chsvt7l5xpw7bo5r@linutronix.de>
 <20210804131731.GG8057@worktop.programming.kicks-ass.net>
 <4f549344-1040-c677-6a6a-53e243c5f364@kernel.dk>
 <feebf183-2e33-36b5-4538-62a40b2a58b6@kernel.dk>
 <20210804153308.oasahcxjmcw7vivo@linutronix.de>
 <f2d0a028-fe85-28ff-9cea-8ab1d26a15d0@kernel.dk>
 <20210804154743.niogqvnladdkfgi2@linutronix.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7c946918-ae0d-6195-6a78-b019f9bc1fd3@kernel.dk>
Date:   Wed, 4 Aug 2021 09:49:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210804154743.niogqvnladdkfgi2@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/21 9:47 AM, Sebastian Andrzej Siewior wrote:
> On 2021-08-04 09:39:30 [-0600], Jens Axboe wrote:
>> I'm confused, the waitqueue locks are always IRQ disabling.
> 
> spin_lock_irq() does not disable interrupts on -RT. The patch above
> produces:
> 
> | BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:35
> | in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 2020, name: iou-wrk-2018
> | 1 lock held by iou-wrk-2018/2020:
> |  #0: ffff888111a47de8 (&hash->wait){+.+.}-{0:0}, at: io_worker_handle_work+0x443/0x630
> | irq event stamp: 10
> | hardirqs last  enabled at (9): [<ffffffff81c47818>] _raw_spin_unlock_irqrestore+0x28/0x70
> | hardirqs last disabled at (10): [<ffffffff81c4769e>] _raw_spin_lock_irq+0x3e/0x40
> | softirqs last  enabled at (0): [<ffffffff81077238>] copy_process+0x8f8/0x2020
> | softirqs last disabled at (0): [<0000000000000000>] 0x0
> | CPU: 5 PID: 2020 Comm: iou-wrk-2018 Tainted: G        W         5.14.0-rc4-rt4+ #97
> | Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
> | Call Trace:
> |  dump_stack_lvl+0x45/0x59
> |  ___might_sleep.cold+0xa6/0xb6
> |  rt_spin_lock+0x35/0xc0
> |  ? io_worker_handle_work+0x443/0x630
> |  io_worker_handle_work+0x443/0x630
> |  io_wqe_worker+0xb4/0x340
> |  ? lockdep_hardirqs_on_prepare+0xd4/0x170
> |  ? _raw_spin_unlock_irqrestore+0x28/0x70
> |  ? _raw_spin_unlock_irqrestore+0x28/0x70
> |  ? io_worker_handle_work+0x630/0x630
> |  ? rt_mutex_slowunlock+0x2ba/0x310
> |  ? io_worker_handle_work+0x630/0x630
> |  ret_from_fork+0x22/0x30
> 
> 
> But indeed, you are right, my snippet breaks non-RT. So this then maybe:
> 
> diff --git a/fs/io-wq.c b/fs/io-wq.c
> index 57d3cdddcdb3e..0b931ac3c83e6 100644
> --- a/fs/io-wq.c
> +++ b/fs/io-wq.c
> @@ -384,7 +384,7 @@ static void io_wait_on_hash(struct io_wqe *wqe, unsigned int hash)
>  {
>  	struct io_wq *wq = wqe->wq;
>  
> -	spin_lock(&wq->hash->wait.lock);
> +	spin_lock_irq(&wq->hash->wait.lock);
>  	if (list_empty(&wqe->wait.entry)) {
>  		__add_wait_queue(&wq->hash->wait, &wqe->wait);
>  		if (!test_bit(hash, &wq->hash->map)) {
> @@ -392,7 +392,7 @@ static void io_wait_on_hash(struct io_wqe *wqe, unsigned int hash)
>  			list_del_init(&wqe->wait.entry);
>  		}
>  	}
> -	spin_unlock(&wq->hash->wait.lock);
> +	spin_unlock_irq(&wq->hash->wait.lock);
>  }
>  
>  static struct io_wq_work *io_get_next_work(struct io_wqe *wqe)
> @@ -430,9 +430,9 @@ static struct io_wq_work *io_get_next_work(struct io_wqe *wqe)
>  	}
>  
>  	if (stall_hash != -1U) {
> -		raw_spin_unlock(&wqe->lock);
> +		raw_spin_unlock_irq(&wqe->lock);
>  		io_wait_on_hash(wqe, stall_hash);
> -		raw_spin_lock(&wqe->lock);
> +		raw_spin_lock_irq(&wqe->lock);
>  	}
>  
>  	return NULL;
> 
> (this is on-top of the patch you sent earlier and Daniel Cc: me on after
> I checked that the problem/warning still exists).

That'd work on non-RT as well, but it makes it worse on non-RT as well with
the irq enable/disable dance. While that's not the end of the world, would
be nice to have a solution that doesn't sacrifice anything, yet doesn't
make RT unhappy.

-- 
Jens Axboe

