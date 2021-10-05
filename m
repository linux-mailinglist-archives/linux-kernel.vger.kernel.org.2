Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA3F422319
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 12:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbhJEKLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 06:11:46 -0400
Received: from www84.your-server.de ([213.133.104.84]:40794 "EHLO
        www84.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhJEKLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 06:11:45 -0400
X-Greylist: delayed 1603 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Oct 2021 06:11:45 EDT
Received: from [88.134.96.152] (helo=skynet.local)
        by www84.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <stefani@seibold.net>)
        id 1mXgyT-0003K5-6Q; Tue, 05 Oct 2021 11:43:01 +0200
Message-ID: <5cb013d281fc064a7e928eb16bdfa9d5d77987e1.camel@seibold.net>
Subject: Re: [PATCH] samples/kfifo: Rename read_lock/write_lock
From:   Stefani Seibold <stefani@seibold.net>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Tue, 05 Oct 2021 11:42:57 +0200
In-Reply-To: <20210923172918.o22iwgvn3w7ilh44@linutronix.de>
References: <20210923172918.o22iwgvn3w7ilh44@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: stefani@seibold.net
X-Virus-Scanned: Clear (ClamAV 0.103.3/26313/Tue Oct  5 11:04:18 2021)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked by Stefani Seibold <stefani@seibold.net>

On Thu, 2021-09-23 at 19:29 +0200, Sebastian Andrzej Siewior wrote:
> The variables names read_lock and write_lock can clash with functions
> used for
> read/writer locks.
> 
> Rename read_lock to read_access and write_lock to write_access to avoid
> a name
> collision.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Link:
> https://lkml.kernel.org/r/20210806152551.qio7c3ho6pexezup@linutronix.de
> ---
> 
> Repost.
> 
>  samples/kfifo/bytestream-example.c |   12 ++++++------
>  samples/kfifo/inttype-example.c    |   12 ++++++------
>  samples/kfifo/record-example.c     |   12 ++++++------
>  3 files changed, 18 insertions(+), 18 deletions(-)
> ---
> --- a/samples/kfifo/bytestream-example.c
> +++ b/samples/kfifo/bytestream-example.c
> @@ -22,10 +22,10 @@
>  #define        PROC_FIFO       "bytestream-fifo"
>  
>  /* lock for procfs read access */
> -static DEFINE_MUTEX(read_lock);
> +static DEFINE_MUTEX(read_access);
>  
>  /* lock for procfs write access */
> -static DEFINE_MUTEX(write_lock);
> +static DEFINE_MUTEX(write_access);
>  
>  /*
>   * define DYNAMIC in this example for a dynamically allocated fifo.
> @@ -116,12 +116,12 @@ static ssize_t fifo_write(struct file *f
>         int ret;
>         unsigned int copied;
>  
> -       if (mutex_lock_interruptible(&write_lock))
> +       if (mutex_lock_interruptible(&write_access))
>                 return -ERESTARTSYS;
>  
>         ret = kfifo_from_user(&test, buf, count, &copied);
>  
> -       mutex_unlock(&write_lock);
> +       mutex_unlock(&write_access);
>         if (ret)
>                 return ret;
>  
> @@ -134,12 +134,12 @@ static ssize_t fifo_read(struct file *fi
>         int ret;
>         unsigned int copied;
>  
> -       if (mutex_lock_interruptible(&read_lock))
> +       if (mutex_lock_interruptible(&read_access))
>                 return -ERESTARTSYS;
>  
>         ret = kfifo_to_user(&test, buf, count, &copied);
>  
> -       mutex_unlock(&read_lock);
> +       mutex_unlock(&read_access);
>         if (ret)
>                 return ret;
>  
> --- a/samples/kfifo/inttype-example.c
> +++ b/samples/kfifo/inttype-example.c
> @@ -22,10 +22,10 @@
>  #define        PROC_FIFO       "int-fifo"
>  
>  /* lock for procfs read access */
> -static DEFINE_MUTEX(read_lock);
> +static DEFINE_MUTEX(read_access);
>  
>  /* lock for procfs write access */
> -static DEFINE_MUTEX(write_lock);
> +static DEFINE_MUTEX(write_access);
>  
>  /*
>   * define DYNAMIC in this example for a dynamically allocated fifo.
> @@ -109,12 +109,12 @@ static ssize_t fifo_write(struct file *f
>         int ret;
>         unsigned int copied;
>  
> -       if (mutex_lock_interruptible(&write_lock))
> +       if (mutex_lock_interruptible(&write_access))
>                 return -ERESTARTSYS;
>  
>         ret = kfifo_from_user(&test, buf, count, &copied);
>  
> -       mutex_unlock(&write_lock);
> +       mutex_unlock(&write_access);
>         if (ret)
>                 return ret;
>  
> @@ -127,12 +127,12 @@ static ssize_t fifo_read(struct file *fi
>         int ret;
>         unsigned int copied;
>  
> -       if (mutex_lock_interruptible(&read_lock))
> +       if (mutex_lock_interruptible(&read_access))
>                 return -ERESTARTSYS;
>  
>         ret = kfifo_to_user(&test, buf, count, &copied);
>  
> -       mutex_unlock(&read_lock);
> +       mutex_unlock(&read_access);
>         if (ret)
>                 return ret;
>  
> --- a/samples/kfifo/record-example.c
> +++ b/samples/kfifo/record-example.c
> @@ -22,10 +22,10 @@
>  #define        PROC_FIFO       "record-fifo"
>  
>  /* lock for procfs read access */
> -static DEFINE_MUTEX(read_lock);
> +static DEFINE_MUTEX(read_access);
>  
>  /* lock for procfs write access */
> -static DEFINE_MUTEX(write_lock);
> +static DEFINE_MUTEX(write_access);
>  
>  /*
>   * define DYNAMIC in this example for a dynamically allocated fifo.
> @@ -123,12 +123,12 @@ static ssize_t fifo_write(struct file *f
>         int ret;
>         unsigned int copied;
>  
> -       if (mutex_lock_interruptible(&write_lock))
> +       if (mutex_lock_interruptible(&write_access))
>                 return -ERESTARTSYS;
>  
>         ret = kfifo_from_user(&test, buf, count, &copied);
>  
> -       mutex_unlock(&write_lock);
> +       mutex_unlock(&write_access);
>         if (ret)
>                 return ret;
>  
> @@ -141,12 +141,12 @@ static ssize_t fifo_read(struct file *fi
>         int ret;
>         unsigned int copied;
>  
> -       if (mutex_lock_interruptible(&read_lock))
> +       if (mutex_lock_interruptible(&read_access))
>                 return -ERESTARTSYS;
>  
>         ret = kfifo_to_user(&test, buf, count, &copied);
>  
> -       mutex_unlock(&read_lock);
> +       mutex_unlock(&read_access);
>         if (ret)
>                 return ret;
>  


