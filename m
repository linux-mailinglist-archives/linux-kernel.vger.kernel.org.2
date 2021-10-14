Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293E842D548
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 10:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhJNInV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 04:43:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230042AbhJNInU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 04:43:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1338D60F9E;
        Thu, 14 Oct 2021 08:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634200875;
        bh=rY9vGtlLDIvkDgY0wX20Oxpih5WsKZMgiPYMwz/VsXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TsvQCRJ72G2+iekhh/WK3vT5lHlv7ZD6YNQNgAj3L2thXFnBxsGvyUNRW7BamuMqV
         1IPExSgJeQI9q0Wym4ATW8HhvO4Aw4CJX4+DsF+KHwMiO6IDjMMu0SjL/bAsfi1hLh
         r4jkVd+UWyWv+rIV5buFUYY+dM3WYR0t5NCyZNCs=
Date:   Thu, 14 Oct 2021 10:41:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     jirislaby@kernel.org, amit@kernel.org, arnd@arndb.de,
        osandov@fb.com, shile.zhang@linux.alibaba.com,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 2/3] tty: hvc: pass DMA capable memory to put_chars()
Message-ID: <YWftKQ3fTb8QlM6/@kroah.com>
References: <20211009114829.1071021-1-xianting.tian@linux.alibaba.com>
 <20211009114829.1071021-3-xianting.tian@linux.alibaba.com>
 <YWGD8y9VfBIQBu2h@kroah.com>
 <3516c58c-e8e6-2e5a-2bc8-ad80e2124d37@linux.alibaba.com>
 <YWJ7NuapWOZ4QirJ@kroah.com>
 <4dbeddb9-1068-d282-2758-55d0f788ea61@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4dbeddb9-1068-d282-2758-55d0f788ea61@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 04:34:59PM +0800, Xianting Tian wrote:
> 
> 在 2021/10/10 下午1:33, Greg KH 写道:
> > On Sat, Oct 09, 2021 at 11:45:23PM +0800, Xianting Tian wrote:
> > > 在 2021/10/9 下午7:58, Greg KH 写道:
> > > > Did you look at the placement using pahole as to how this structure now
> > > > looks?
> > > thanks for all your commnts. for this one, do you mean I need to remove the
> > > blank line?  thanks
> > > 
> > No, I mean to use the tool 'pahole' to see the structure layout that you
> > just created and determine if it really is the best way to add these new
> > fields, especially as you are adding huge buffers with odd alignment.
> 
> thanks,
> 
> Based on your comments, I removed 'char outchar',  remian the position of
> 'int outbuf_size' unchanged to keep outbuf_size and lock in the same cache
> line.  Now hvc_struct change as below,
> 
>  struct hvc_struct {
>         struct tty_port port;
>         spinlock_t lock;
>         int index;
>         int do_wakeup;
> -       char *outbuf;
>         int outbuf_size;
>         int n_outbuf;
>         uint32_t vtermno;
> @@ -48,6 +57,16 @@ struct hvc_struct {
>         struct work_struct tty_resize;
>         struct list_head next;
>         unsigned long flags;
> +
> +       /*
> +        * the buf is used in hvc console api for putting chars,
> +        * and also used in hvc_poll_put_char() for putting single char.
> +        */
> +       char cons_outbuf[N_OUTBUF] __ALIGNED__;
> +       spinlock_t cons_outbuf_lock;
> +
> +       /* the buf is used for putting chars to tty */
> +       char outbuf[] __ALIGNED__;
>  };
> 
> pahole for above hvc_struct as below,  is it ok for you?  do we need to pack
> the hole? thanks
> 
> struct hvc_struct {
>     struct tty_port            port;                 /*     0 352 */
>     /* --- cacheline 5 boundary (320 bytes) was 32 bytes ago --- */
>     spinlock_t                 lock;                 /*   352 4 */
>     int                        index;                /*   356 4 */
>     int                        do_wakeup;            /*   360 4 */
>     int                        outbuf_size;          /*   364 4 */
>     int                        n_outbuf;             /*   368 4 */
>     uint32_t                   vtermno;              /*   372 4 */
>     const struct hv_ops  *     ops;                  /*   376 8 */
>     /* --- cacheline 6 boundary (384 bytes) --- */
>     int                        irq_requested;        /*   384 4 */
>     int                        data;                 /*   388 4 */
>     struct winsize             ws;                   /*   392 8 */
>     struct work_struct         tty_resize;           /*   400 32 */
>     struct list_head           next;                 /*   432 16 */
>     /* --- cacheline 7 boundary (448 bytes) --- */
>     long unsigned int          flags;                /*   448 8 */
> 
>     /* XXX 56 bytes hole, try to pack */
> 
>     /* --- cacheline 8 boundary (512 bytes) --- */
>     char                       cons_outbuf[16];      /*   512 16 */
>     spinlock_t                 cons_outbuf_lock;     /*   528 4 */
> 
>     /* XXX 44 bytes hole, try to pack */

Why not move the spinlock up above the cons_outbuf?  Will that not be a
bit better?

Anyway, this is all fine, and much better than before, thanks.

greg k-h
