Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051CA432136
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 17:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbhJRPCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 11:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbhJRPCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:02:03 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FFEC061765
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 07:59:52 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 5so255025edw.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 07:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YJXyN0UIElY50a5XJPn2+iRYHpqREIziBI8QTTbJHTQ=;
        b=ju95/sHhmc/Gl35ZwBH4TXCn8Z7gPIBpDjiVJDLAmFp9+WuMNAICbKKT3HDjW7Pov9
         4RlYo8TRtYK4I8bPbmiPBZIVHkuRQZUr0Nz7zcuoZE/J+MNmvVtQKnktCbrEhKbEnLTU
         og0fZxXEXgxPRrW3JxUJtsMyLnPVlr7OAW1pEJqBTTR8L3zei2IRtvzqqLN169IdUW7X
         SlHgvtPjfUFv89PhoW65F67cMO94pHr+R6UqeNTNenynVBp+K7NUAXfER4ey+AhjyKRX
         XEQwDCyDHKaDKCJUTbyr4etn5mhT4vrpDbR8IxaF+Lf7Oi5j0QFdMLIeOQoKsvnF4oz7
         ed2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YJXyN0UIElY50a5XJPn2+iRYHpqREIziBI8QTTbJHTQ=;
        b=CbE8FihvwFZWeGXa2bAenOSTQw8vpTrRZDEP3mfrwrqlLFfyhl6iERvDwoJZQnDxh9
         wgKm6xHPneBLWIiTBjZ2XXaRlaZ7getu1nYb6YtOwYztAJ8WjEg0w5d9bgOYGcXnU6/C
         ju+GobIja/fNHFbvUyFG5oDKMQSTH0T4iviPAtzqvCHCtUWcpHMfP6z8U09esn+JP1Sd
         /fMNYREHdbrY90gaUHS/PTGxiciXLe0Yf4avPzKlw/p71GJdTbR4xGRJVN1/jR5Fh4pg
         ijPsjbVn68N6GdJQUw7PNkp6xN0r46GpiWRTxR9ohMVjs67Fh8JdVi0Ms97WzaiRJjLE
         BZug==
X-Gm-Message-State: AOAM530+y41lHMVsOGLYYhx08AgviubyNqkuAptJZ9aFqQRv/I1EVe7w
        Bf2wvIFp6OBxZDUndWQiDToffRI5ZDFXuv9jenXx5g==
X-Google-Smtp-Source: ABdhPJxsBUYTRIVO3OKFxjznS88NQlt9EXIdu9jx4sK3ZBMV5U86ynstK6tQA5ztLjR55k4Ko9+m5TSk1XZakDVPd+E=
X-Received: by 2002:aa7:c2da:: with SMTP id m26mr46118067edp.89.1634569179251;
 Mon, 18 Oct 2021 07:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <20211018090247.3779368-1-tzungbi@google.com>
In-Reply-To: <20211018090247.3779368-1-tzungbi@google.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 18 Oct 2021 07:59:28 -0700
Message-ID: <CABXOdTfs4BPcx=A=Np--zVymJZ5g6S2P=Q5JE2T63zpJKUgJJA@mail.gmail.com>
Subject: Re: [RESEND PATCH] platform/chrome: cros_ec_debugfs: detach log
 reader wq from devm
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 2:03 AM Tzung-Bi Shih <tzungbi@google.com> wrote:
>
> Debugfs console_log uses devm memory (see struct cros_ec_debugfs in
> cros_ec_console_log fops).  However, lifecycles of device and debugfs
> are independent.  An use-after-free issue is observed if userland
> program operates the debugfs after the memory has been freed.
>

It would help to see the backtrace. Without it, it is difficult to
determine where the UAF is observed. Also, most if not all of the
touched functions access struct cros_ec_debugfs all over the place,
not only for the wait queue, so I am not sure if moving the wait queue
out of the data structure is the correct fix. It might instead be
necessary to disconnect memory allocations from the ec device.

Guenter



Guenter

> An userland program example in Python code:
> ... import select
> ... p = select.epoll()
> ... f = open('/sys/kernel/debug/cros_scp/console_log')
> ... p.register(f, select.POLLIN)
> ... p.poll(1)
> [(4, 1)]                    # 4=fd, 1=select.POLLIN
>
> [ shutdown cros_scp at the point ]
>
> ... p.poll(1)
> [(4, 16)]                   # 4=fd, 16=select.POLLHUP
> ... p.unregister(f)
>
> An use-after-free issue raises here.  It called epoll_ctl with
> EPOLL_CTL_DEL which in turn to use the workqueue in the devm (i.e.
> log_wq).
>
> The calling stack:
> do_raw_spin_lock
> _raw_spin_lock_irqsave
> remove_wait_queue
> ep_unregister_pollwait
> ep_remove
> do_epoll_ctl
>
> Detaches log reader's workqueue from devm to make sure it is persistent
> even if the device has been removed.
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
> ---
> As for 2 other cases:
>
> Case 1. userland program opens the debugfs after the device has been removed
>
> ENOENT.  cros_ec_debugfs_remove() calls debugfs_remove_recursive().
>
> Case 2. userland program is reading when the device is removing
>
> If the userland program is waiting in cros_ec_console_log_read(), the device
> removal will wait for it.
>
> See the calling stack for the case:
> wait_for_completion
> __debugfs_file_removed
> remove_one
> simple_recursive_removal
> debugfs_remove
> cros_ec_debugfs_remove
> platform_drv_remove
> device_release_driver_internal
> device_release_driver
> bus_remove_device
> device_del
> platform_device_del
> platform_device_unregister
>
>  drivers/platform/chrome/cros_ec_debugfs.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
> index 272c89837d74..0dbceee87a4b 100644
> --- a/drivers/platform/chrome/cros_ec_debugfs.c
> +++ b/drivers/platform/chrome/cros_ec_debugfs.c
> @@ -25,6 +25,9 @@
>
>  #define CIRC_ADD(idx, size, value)     (((idx) + (value)) & ((size) - 1))
>
> +/* waitqueue for log readers */
> +static DECLARE_WAIT_QUEUE_HEAD(cros_ec_debugfs_log_wq);
> +
>  /**
>   * struct cros_ec_debugfs - EC debugging information.
>   *
> @@ -33,7 +36,6 @@
>   * @log_buffer: circular buffer for console log information
>   * @read_msg: preallocated EC command and buffer to read console log
>   * @log_mutex: mutex to protect circular buffer
> - * @log_wq: waitqueue for log readers
>   * @log_poll_work: recurring task to poll EC for new console log data
>   * @panicinfo_blob: panicinfo debugfs blob
>   */
> @@ -44,7 +46,6 @@ struct cros_ec_debugfs {
>         struct circ_buf log_buffer;
>         struct cros_ec_command *read_msg;
>         struct mutex log_mutex;
> -       wait_queue_head_t log_wq;
>         struct delayed_work log_poll_work;
>         /* EC panicinfo */
>         struct debugfs_blob_wrapper panicinfo_blob;
> @@ -107,7 +108,7 @@ static void cros_ec_console_log_work(struct work_struct *__work)
>                         buf_space--;
>                 }
>
> -               wake_up(&debug_info->log_wq);
> +               wake_up(&cros_ec_debugfs_log_wq);
>         }
>
>         mutex_unlock(&debug_info->log_mutex);
> @@ -141,7 +142,7 @@ static ssize_t cros_ec_console_log_read(struct file *file, char __user *buf,
>
>                 mutex_unlock(&debug_info->log_mutex);
>
> -               ret = wait_event_interruptible(debug_info->log_wq,
> +               ret = wait_event_interruptible(cros_ec_debugfs_log_wq,
>                                         CIRC_CNT(cb->head, cb->tail, LOG_SIZE));
>                 if (ret < 0)
>                         return ret;
> @@ -173,7 +174,7 @@ static __poll_t cros_ec_console_log_poll(struct file *file,
>         struct cros_ec_debugfs *debug_info = file->private_data;
>         __poll_t mask = 0;
>
> -       poll_wait(file, &debug_info->log_wq, wait);
> +       poll_wait(file, &cros_ec_debugfs_log_wq, wait);
>
>         mutex_lock(&debug_info->log_mutex);
>         if (CIRC_CNT(debug_info->log_buffer.head,
> @@ -377,7 +378,6 @@ static int cros_ec_create_console_log(struct cros_ec_debugfs *debug_info)
>         debug_info->log_buffer.tail = 0;
>
>         mutex_init(&debug_info->log_mutex);
> -       init_waitqueue_head(&debug_info->log_wq);
>
>         debugfs_create_file("console_log", S_IFREG | 0444, debug_info->dir,
>                             debug_info, &cros_ec_console_log_fops);
> --
> 2.33.0.1079.g6e70778dc9-goog
>
