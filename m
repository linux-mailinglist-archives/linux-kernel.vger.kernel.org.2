Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEED3FC3A2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 10:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239853AbhHaHZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 03:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239538AbhHaHZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 03:25:47 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FC5C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 00:24:52 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id x16so8422319pll.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 00:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HRmn2HSjIyoyl5frN1JOdwhv1jt4tYR/jznN931pQCc=;
        b=W41bBzENunWIPZGT70XTQ00/4JnKxG7675YoBNn/BC+6i5PNbLAeodHCYDxybVjcmu
         qFgp3TB+nSH2E7rmZt0sBiBYw+Y5c4JQ36hyuDIc1JQxwAyuTZwQYlqIswJnTJYUELXD
         aZf1VLcJ+mWmrLj/QrFDipHMTaroujCrLRBKcLLJHOCPlGHWRS5cmsZ4oHgZgtMgRk54
         F7oOCW3GwlVFet1305G9xWZj5Ay6FX8oCjgyYyDJORSk5QTOsQ/53otmyUmx5Z4xyU1C
         67+E8kKZzk7vJ9j1kKnLVZY3QpUIim4uXEZ7BN7M9JSu36TBNWiEOfFrg6RGo/phzAVu
         JgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HRmn2HSjIyoyl5frN1JOdwhv1jt4tYR/jznN931pQCc=;
        b=ftUgipEJPdXCNb4vrS5Ta0lqtrJ6l3KSp4AuS5RdEmf2PxYcNupay5irBFyQYsk9bl
         jco0wRvrWcriUAvSQVEhhjljonxndW+gKpGXejezF/wZXTw7ogX2WuB9ppuOXllYTQdb
         dozxfuh7NOCVFDXyC+YuQkyvR5wy4rpJAT3Jt1EAJBEw/H+gSfMuGZiC31/VZ3YT4rWh
         YLSysKsWc+yAaCmeQrXjizryfi/ktkoBvi5bi6f4NJ8R8oKJLAJboc4gmjXtOFsZBZBj
         LivZyYa35CDaOZWDzw8vfcBrGA5yxt1NUX8I/b2II13jqQUvg3WWOwkqjduAQwYTdErb
         XIsA==
X-Gm-Message-State: AOAM530DskI505BuqrjK2IfLFI7dDrU4r1ARkjmNqPEvOdcUZa0srbUW
        afBaIbh6kgi5uYQbfqjMNP7C4bLV7OqcXcrRiCeM7Q==
X-Google-Smtp-Source: ABdhPJzoS9DdKnYQUkbtZAQSn4bnjxyR+xzpi2fokmo+9QTwxCtzqiKfpyGKOpBi7GwEiy1jX+9pldHWJo0DUuequSM=
X-Received: by 2002:a17:90b:78f:: with SMTP id l15mr3754035pjz.181.1630394691968;
 Tue, 31 Aug 2021 00:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210830195146.587206-1-tkjos@google.com>
In-Reply-To: <20210830195146.587206-1-tkjos@google.com>
From:   Martijn Coenen <maco@android.com>
Date:   Tue, 31 Aug 2021 09:24:40 +0200
Message-ID: <CAB0TPYFmUgPTONABLTJAdonK7fY7oqURKCpLp1-WqHLtyen7Zw@mail.gmail.com>
Subject: Re: [PATCH] binder: make sure fd closes complete
To:     Todd Kjos <tkjos@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 9:51 PM 'Todd Kjos' via kernel-team
<kernel-team@android.com> wrote:
>
> During BC_FREE_BUFFER processing, the BINDER_TYPE_FDA object
> cleanup may close 1 or more fds. The close operations are
> completed using the task work mechanism -- which means the thread
> needs to return to userspace or the file object may never be
> dereferenced -- which can lead to hung processes.
>
> Force the binder thread back to userspace if an fd is closed during
> BC_FREE_BUFFER handling.
>
> Signed-off-by: Todd Kjos <tkjos@google.com>
Reviewed-by: Martijn Coenen <maco@android.com>

> ---
>  drivers/android/binder.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index bcec598b89f2..c2823f0d588f 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -1852,6 +1852,7 @@ static void binder_deferred_fd_close(int fd)
>  }
>
>  static void binder_transaction_buffer_release(struct binder_proc *proc,
> +                                             struct binder_thread *thread,
>                                               struct binder_buffer *buffer,
>                                               binder_size_t failed_at,
>                                               bool is_failure)
> @@ -2011,8 +2012,16 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
>                                                 &proc->alloc, &fd, buffer,
>                                                 offset, sizeof(fd));
>                                 WARN_ON(err);
> -                               if (!err)
> +                               if (!err) {
>                                         binder_deferred_fd_close(fd);
> +                                       /*
> +                                        * Need to make sure the thread goes
> +                                        * back to userspace to complete the
> +                                        * deferred close
> +                                        */
> +                                       if (thread)
> +                                               thread->looper_need_return = true;
> +                               }
>                         }
>                 } break;
>                 default:
> @@ -3105,7 +3114,7 @@ static void binder_transaction(struct binder_proc *proc,
>  err_copy_data_failed:
>         binder_free_txn_fixups(t);
>         trace_binder_transaction_failed_buffer_release(t->buffer);
> -       binder_transaction_buffer_release(target_proc, t->buffer,
> +       binder_transaction_buffer_release(target_proc, NULL, t->buffer,
>                                           buffer_offset, true);
>         if (target_node)
>                 binder_dec_node_tmpref(target_node);
> @@ -3184,7 +3193,9 @@ static void binder_transaction(struct binder_proc *proc,
>   * Cleanup buffer and free it.
>   */
>  static void
> -binder_free_buf(struct binder_proc *proc, struct binder_buffer *buffer)
> +binder_free_buf(struct binder_proc *proc,
> +               struct binder_thread *thread,
> +               struct binder_buffer *buffer)
>  {
>         binder_inner_proc_lock(proc);
>         if (buffer->transaction) {
> @@ -3212,7 +3223,7 @@ binder_free_buf(struct binder_proc *proc, struct binder_buffer *buffer)
>                 binder_node_inner_unlock(buf_node);
>         }
>         trace_binder_transaction_buffer_release(buffer);
> -       binder_transaction_buffer_release(proc, buffer, 0, false);
> +       binder_transaction_buffer_release(proc, thread, buffer, 0, false);
>         binder_alloc_free_buf(&proc->alloc, buffer);
>  }
>
> @@ -3414,7 +3425,7 @@ static int binder_thread_write(struct binder_proc *proc,
>                                      proc->pid, thread->pid, (u64)data_ptr,
>                                      buffer->debug_id,
>                                      buffer->transaction ? "active" : "finished");
> -                       binder_free_buf(proc, buffer);
> +                       binder_free_buf(proc, thread, buffer);
>                         break;
>                 }
>
> @@ -4107,7 +4118,7 @@ static int binder_thread_read(struct binder_proc *proc,
>                         buffer->transaction = NULL;
>                         binder_cleanup_transaction(t, "fd fixups failed",
>                                                    BR_FAILED_REPLY);
> -                       binder_free_buf(proc, buffer);
> +                       binder_free_buf(proc, thread, buffer);
>                         binder_debug(BINDER_DEBUG_FAILED_TRANSACTION,
>                                      "%d:%d %stransaction %d fd fixups failed %d/%d, line %d\n",
>                                      proc->pid, thread->pid,
> --
> 2.33.0.259.gc128427fd7-goog
>
>
