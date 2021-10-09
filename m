Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E154279E6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 13:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244861AbhJIMAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 08:00:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:44642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232865AbhJIMAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 08:00:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C90860EE9;
        Sat,  9 Oct 2021 11:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633780726;
        bh=+OEjWjipj45LByfaax3IC8mrbba3ydp9JA4U4ynR9rI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mkCpX97DtP87MbbFXKOvS+YAu0qSRrD74iQqaPGxGyRJsrY10jekAwJKiGtJtApBB
         8UsomooHdrFybbbw4FL03YwBS2WRVf5XZ8pKF6VT2/S7LswA8yWPInqdbx6WgjcrhD
         ANdNm19s2lwdoEvrbjE/5Ldyv7GuJviBkfcNo8mg=
Date:   Sat, 9 Oct 2021 13:58:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     jirislaby@kernel.org, amit@kernel.org, arnd@arndb.de,
        osandov@fb.com, shile.zhang@linux.alibaba.com,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 2/3] tty: hvc: pass DMA capable memory to put_chars()
Message-ID: <YWGD8y9VfBIQBu2h@kroah.com>
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
> --- a/drivers/tty/hvc/hvc_console.h
> +++ b/drivers/tty/hvc/hvc_console.h
> @@ -32,13 +32,21 @@
>   */
>  #define HVC_ALLOC_TTY_ADAPTERS	8
>  
> +/*
> + * These sizes are most efficient for vio, because they are the
> + * native transfer size. We could make them selectable in the
> + * future to better deal with backends that want other buffer sizes.
> + */
> +#define N_OUTBUF	16
> +#define N_INBUF		16
> +
> +#define __ALIGNED__ __attribute__((__aligned__(sizeof(long))))

Does this conflict with what is in hvcs.c?

> +
>  struct hvc_struct {
>  	struct tty_port port;
>  	spinlock_t lock;
>  	int index;
>  	int do_wakeup;
> -	char *outbuf;
> -	int outbuf_size;
>  	int n_outbuf;
>  	uint32_t vtermno;
>  	const struct hv_ops *ops;
> @@ -48,6 +56,18 @@ struct hvc_struct {
>  	struct work_struct tty_resize;
>  	struct list_head next;
>  	unsigned long flags;
> +
> +	/* the buf is used in hvc console api for putting chars */
> +	char cons_outbuf[N_OUTBUF] __ALIGNED__;
> +	spinlock_t cons_outbuf_lock;

Did you look at the placement using pahole as to how this structure now
looks?

> +
> +	/* the buf is for putting single char to tty */
> +	char outchar;
> +	spinlock_t outchar_lock;

So you have a lock for a character and a different one for a longer
string?  Why can they not just use the same lock?  Why are 2 needed at
all, can't you just use the first character of cons_outbuf[] instead?
Surely you do not have 2 sends happening at the same time, right?

> +
> +	/* the buf is for putting chars to tty */
> +	int outbuf_size;
> +	char outbuf[0] __ALIGNED__;

I thought we were not allowing [0] anymore in kernel structures?

thanks,

greg k-h
