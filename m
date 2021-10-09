Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABEC74279D0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 13:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbhJIL5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 07:57:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232664AbhJIL5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 07:57:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DF1560EE9;
        Sat,  9 Oct 2021 11:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633780554;
        bh=pJABJ1JzJYukeyq4nIhuXfqM6wKmGcJGn3PyObatZxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lhjEKytDQn7a443MT8nwdCQOHxRHPAAyXRJwge8eC5aRs2y+ZofQPjiMdWpAsFxsF
         H46jA6kTZJ6IUkNRs6p5Hbaqmsecjvjcrs1EJuVXtY6bDMi3gftFFMZ9srQaEed366
         Gkfsxsb6Y/hiWQD6LKl9b34DXLogfFP9xQjvlWyo=
Date:   Sat, 9 Oct 2021 13:55:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     jirislaby@kernel.org, amit@kernel.org, arnd@arndb.de,
        osandov@fb.com, shile.zhang@linux.alibaba.com,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 2/3] tty: hvc: pass DMA capable memory to put_chars()
Message-ID: <YWGDSF04jEjc/FgJ@kroah.com>
References: <20211009114829.1071021-1-xianting.tian@linux.alibaba.com>
 <20211009114829.1071021-3-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211009114829.1071021-3-xianting.tian@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 09, 2021 at 07:48:28PM +0800, Xianting Tian wrote:
> As well known, hvc backend can register its opertions to hvc backend.
> the operations contain put_chars(), get_chars() and so on.
> 
> Some hvc backend may do dma in its operations. eg, put_chars() of
> virtio-console. But in the code of hvc framework, it may pass DMA
> incapable memory to put_chars() under a specific configuration, which
> is explained in commit c4baad5029(virtio-console: avoid DMA from stack):
> 1, c[] is on stack,
>    hvc_console_print():
> 	char c[N_OUTBUF] __ALIGNED__;
> 	cons_ops[index]->put_chars(vtermnos[index], c, i);
> 2, ch is on stack,
>    static void hvc_poll_put_char(,,char ch)
>    {
> 	struct tty_struct *tty = driver->ttys[0];
> 	struct hvc_struct *hp = tty->driver_data;
> 	int n;
> 
> 	do {
> 		n = hp->ops->put_chars(hp->vtermno, &ch, 1);
> 	} while (n <= 0);
>    }
> 
> Commit c4baad5029 is just the fix to avoid DMA from stack memory, which
> is passed to virtio-console by hvc framework in above code. But I think
> the fix is aggressive, it directly uses kmemdup() to alloc new buffer
> from kmalloc area and do memcpy no matter the memory is in kmalloc area
> or not. But most importantly, it should better be fixed in the hvc
> framework, by changing it to never pass stack memory to the put_chars()
> function in the first place. Otherwise, we still face the same issue if
> a new hvc backend using dma added in the furture.
> 
> In this patch, add 'char cons_outbuf[]' as part of 'struct hvc_struct',
> so hp->cons_outbuf is no longer the stack memory, we can use it in above
> case 1. Add 'char outchar' as part of 'struct hvc_struct', we can use it
> in above case 2. We also add lock for each above buf to protect them
> separately instead of using the global lock of hvc.
> 
> Introduce another array(cons_hvcs[]) for hvc pointers next to the
> cons_ops[] and vtermnos[] arrays. With the array, we can easily find
> hvc's cons_outbuf and its lock.
> 
> With the patch, we can revert the fix c4baad5029.
> 
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
> ---
>  drivers/tty/hvc/hvc_console.c | 37 +++++++++++++++++++++--------------
>  drivers/tty/hvc/hvc_console.h | 24 +++++++++++++++++++++--
>  2 files changed, 44 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
> index 5bb8c4e44..4d8f112f2 100644
> --- a/drivers/tty/hvc/hvc_console.c
> +++ b/drivers/tty/hvc/hvc_console.c
> @@ -41,16 +41,6 @@
>   */
>  #define HVC_CLOSE_WAIT (HZ/100) /* 1/10 of a second */
>  
> -/*
> - * These sizes are most efficient for vio, because they are the
> - * native transfer size. We could make them selectable in the
> - * future to better deal with backends that want other buffer sizes.
> - */
> -#define N_OUTBUF	16
> -#define N_INBUF		16
> -
> -#define __ALIGNED__ __attribute__((__aligned__(sizeof(long))))
> -

Are you sure this applies on top of patch 1/3 here?

> +/*
> + * These sizes are most efficient for vio, because they are the
> + * native transfer size. We could make them selectable in the
> + * future to better deal with backends that want other buffer sizes.
> + */
> +#define N_OUTBUF	16
> +#define N_INBUF		16
> +
> +#define __ALIGNED__ __attribute__((__aligned__(sizeof(long))))

Again, are you sure this is correct?

thanks,

greg k-h
