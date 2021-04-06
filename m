Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7212355CD4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 22:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238283AbhDFU04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 16:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbhDFU0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 16:26:54 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D574DC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 13:26:43 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id o16so17999102ljp.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 13:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FyxYTJq0hjg0lF4D+eRjh7iOhJYKtIuYcc2vlDiey1o=;
        b=d/oAVJsTenaIPKUauQKNCycTdDa77daDCUpMXOfIhEl92kf6cCM2yUYe2UVySbOTCH
         DzUSP/OuUjQPYyWcL71YQUHoEo3cmEuDwFf2wIom8A4ooxHBb+FCykmQAqf4JPLnjr/5
         e7IXVyKmC5IFFI10dWZJdxSMfX/aX/7ZNXdgb/ycjzeJUgkV8FcZofd/zOETSs7lsAik
         ydjUoUqLhxIhMSCu5TrHyHIf51AaOxN1uELR/H5azh4FrZOJ9uPI8ZJPHj43ZN09U86o
         SqYpEueEzsuddZtS6s5Z9w2bYRn0hwtIOAzogiH699UNc5p1/lGvEJfuz+qzl1rxKUau
         UiXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FyxYTJq0hjg0lF4D+eRjh7iOhJYKtIuYcc2vlDiey1o=;
        b=OJNA2P0eqwx1pSkEYsMNuB1jAwtFh5rjSNHi8L2CigzwdEB+oJDirXMqDobSZ7l0hJ
         UXnE2QAgHhh3ExTXGspcacoecZUfcOwL6rA7g1LUdtXgh55txSW4Ir6ylVeySnpYICMX
         5Ok1V+eH74/b/UPhZxXxu3osTr2GYR57/GjTJtMLWdtiDL8JBnC6+JbXbUdM4D3hywLj
         8P6LR+ApKBQNX1XoE9vpZal9RLkDTWvLUrHUyD+Qdu5lMJ9SjJs3sGqAwfqX3U1Xh7dM
         7cptBq5fByLMLzUe8quMdMzyl9rBtORY4wiXmRApu/cEwy4lEtukDXP4CKrTR2AadkHr
         yCbQ==
X-Gm-Message-State: AOAM530ByK4uxYzZiLkCKACUQTy3QxZL2xcAHtQZHSX6qWpYLIu9w371
        8iDtDPmtIGKfl7ofxUsSwXKd4tw/O4xf/SLWqfO5IA==
X-Google-Smtp-Source: ABdhPJyEzFeVHuL3axVYxAmd/vRmCyPKTb4s2xSamvzatwjhi6r4/KiyWwak0226mOBVNcO85HbSSWDF0cyNzNoNpYM=
X-Received: by 2002:a05:651c:1b9:: with SMTP id c25mr20238075ljn.155.1617740801882;
 Tue, 06 Apr 2021 13:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <5035e2d0-8093-5570-88e0-01c81b9ae6ed@codeaurora.org> <1617265699-503-1-git-send-email-hangl@codeaurora.org>
In-Reply-To: <1617265699-503-1-git-send-email-hangl@codeaurora.org>
From:   Todd Kjos <tkjos@google.com>
Date:   Tue, 6 Apr 2021 13:26:28 -0700
Message-ID: <CAHRSSEyp2ffVBaeJ4-uO=F02ppdh6j_jwf5AgxpFfNAHuwZXEw@mail.gmail.com>
Subject: Re: [PATCH v2] binder: tell userspace to dump current backtrace when
 detecting oneway spamming
To:     Hang Lu <hangl@codeaurora.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>, rdunlap@infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 1, 2021 at 1:29 AM Hang Lu <hangl@codeaurora.org> wrote:
>
> When async binder buffer got exhausted, some normal oneway transaction
> will also be discarded and finally caused system/app stop.

"...be discarded and may cause system or application failures" ?

> By that time,
> the binder debug information we dump may not relevant to the root cause.

"may not be relevant"

> And this issue is difficult to debug if without the backtrace of thread
> sending spam.

"...backtrace of the thread..."

>
> This change will send BR_ONEWAY_SPAM_SUSPECT to userspace when detecting
> oneway spamming, request to dump current backtrace.

"to userspace when oneway spamming is detected

> The detection will
> happened only once when exceeding the threshold (target process dips

"Oneway spamming will be reported only once..."

> below 80% of its oneway space, and current process is responsible for
> either more than 50 transactions, or more than 50% of the oneway space).
> And the detection will restart when the async buffer has returned to a
> healthy state.
>
> Signed-off-by: Hang Lu <hangl@codeaurora.org>
> ---
> v2: make the detection on/off switch to be per-proc
>
>  drivers/android/binder.c            | 26 +++++++++++++++++++++++---
>  drivers/android/binder_alloc.c      | 15 ++++++++++++---
>  drivers/android/binder_alloc.h      |  8 +++++++-
>  drivers/android/binder_internal.h   |  4 ++++
>  include/uapi/linux/android/binder.h |  8 ++++++++
>  5 files changed, 54 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index c119736..93964d1 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -3007,7 +3007,10 @@ static void binder_transaction(struct binder_proc *proc,
>                         goto err_bad_object_type;
>                 }
>         }
> -       tcomplete->type = BINDER_WORK_TRANSACTION_COMPLETE;
> +       if (t->buffer->oneway_spam_suspect)
> +               tcomplete->type = BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT;
> +       else
> +               tcomplete->type = BINDER_WORK_TRANSACTION_COMPLETE;
>         t->work.type = BINDER_WORK_TRANSACTION;
>
>         if (reply) {
> @@ -3875,9 +3878,14 @@ static int binder_thread_read(struct binder_proc *proc,
>
>                         binder_stat_br(proc, thread, cmd);
>                 } break;
> -               case BINDER_WORK_TRANSACTION_COMPLETE: {
> +               case BINDER_WORK_TRANSACTION_COMPLETE:
> +               case BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT: {
> +                       if (proc->oneway_spam_detection_enabled &&
> +                                  w->type == BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT)
> +                               cmd = BR_ONEWAY_SPAM_SUSPECT;

Doesn't "BR_ONEWAY_SPAM_SUSPECT" need to be added to binder_return_strings[]?

> +                       else
> +                               cmd = BR_TRANSACTION_COMPLETE;
>                         binder_inner_proc_unlock(proc);
> -                       cmd = BR_TRANSACTION_COMPLETE;
>                         kfree(w);
>                         binder_stats_deleted(BINDER_STAT_TRANSACTION_COMPLETE);
>                         if (put_user(cmd, (uint32_t __user *)ptr))
> @@ -4727,6 +4735,18 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>                 }
>                 break;
>         }
> +       case BINDER_ENABLE_ONEWAY_SPAM_DETECTION: {
> +               uint32_t enable;
> +
> +               if (copy_from_user(&enable, ubuf, sizeof(enable))) {
> +                       ret = -EINVAL;
> +                       goto err;
> +               }
> +               binder_inner_proc_lock(proc);
> +               proc->oneway_spam_detection_enabled = (bool)enable;
> +               binder_inner_proc_unlock(proc);
> +               break;
> +       }
>         default:
>                 ret = -EINVAL;
>                 goto err;
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index 7caf74a..a09872b 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -338,7 +338,7 @@ static inline struct vm_area_struct *binder_alloc_get_vma(
>         return vma;
>  }
>
> -static void debug_low_async_space_locked(struct binder_alloc *alloc, int pid)
> +static bool debug_low_async_space_locked(struct binder_alloc *alloc, int pid)
>  {
>         /*
>          * Find the amount and size of buffers allocated by the current caller;
> @@ -366,13 +366,19 @@ static void debug_low_async_space_locked(struct binder_alloc *alloc, int pid)
>
>         /*
>          * Warn if this pid has more than 50 transactions, or more than 50% of
> -        * async space (which is 25% of total buffer size).
> +        * async space (which is 25% of total buffer size). Oneway spam only
> +        * detect once when exceed the threshold.

"Oneway spam is only detected when the threshold is exceeded"

>          */
>         if (num_buffers > 50 || total_alloc_size > alloc->buffer_size / 4) {
>                 binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
>                              "%d: pid %d spamming oneway? %zd buffers allocated for a total size of %zd\n",
>                               alloc->pid, pid, num_buffers, total_alloc_size);
> +               if (!alloc->oneway_spam_detected) {
> +                       alloc->oneway_spam_detected = true;
> +                       return true;
> +               }
>         }
> +       return false;
>  }
>
>  static struct binder_buffer *binder_alloc_new_buf_locked(
> @@ -525,6 +531,7 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
>         buffer->async_transaction = is_async;
>         buffer->extra_buffers_size = extra_buffers_size;
>         buffer->pid = pid;
> +       buffer->oneway_spam_suspect = false;
>         if (is_async) {
>                 alloc->free_async_space -= size + sizeof(struct binder_buffer);
>                 binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC_ASYNC,
> @@ -536,7 +543,9 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
>                          * of async space left (which is less than 10% of total
>                          * buffer size).
>                          */
> -                       debug_low_async_space_locked(alloc, pid);
> +                       buffer->oneway_spam_suspect = debug_low_async_space_locked(alloc, pid);
> +               } else {
> +                       alloc->oneway_spam_detected = false;
>                 }
>         }
>         return buffer;
> diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
> index 6e8e001..7dea57a 100644
> --- a/drivers/android/binder_alloc.h
> +++ b/drivers/android/binder_alloc.h
> @@ -26,6 +26,8 @@ struct binder_transaction;
>   * @clear_on_free:      %true if buffer must be zeroed after use
>   * @allow_user_free:    %true if user is allowed to free buffer
>   * @async_transaction:  %true if buffer is in use for an async txn
> + * @oneway_spam_suspect: %true if total async allocate size just exceed
> + * spamming detect threshold
>   * @debug_id:           unique ID for debugging
>   * @transaction:        pointer to associated struct binder_transaction
>   * @target_node:        struct binder_node associated with this buffer
> @@ -45,7 +47,8 @@ struct binder_buffer {
>         unsigned clear_on_free:1;
>         unsigned allow_user_free:1;
>         unsigned async_transaction:1;
> -       unsigned debug_id:28;
> +       unsigned oneway_spam_suspect:1;
> +       unsigned debug_id:27;
>
>         struct binder_transaction *transaction;
>
> @@ -87,6 +90,8 @@ struct binder_lru_page {
>   * @buffer_size:        size of address space specified via mmap
>   * @pid:                pid for associated binder_proc (invariant after init)
>   * @pages_high:         high watermark of offset in @pages
> + * @oneway_spam_detected: %true if oneway spam detection fired, clear that
> + * flag once the async buffer has returned to a healthy state
>   *
>   * Bookkeeping structure for per-proc address space management for binder
>   * buffers. It is normally initialized during binder_init() and binder_mmap()
> @@ -107,6 +112,7 @@ struct binder_alloc {
>         uint32_t buffer_free;
>         int pid;
>         size_t pages_high;
> +       bool oneway_spam_detected;
>  };
>
>  #ifdef CONFIG_ANDROID_BINDER_IPC_SELFTEST
> diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
> index 6cd7901..eb87669 100644
> --- a/drivers/android/binder_internal.h
> +++ b/drivers/android/binder_internal.h
> @@ -174,6 +174,7 @@ struct binder_work {
>         enum binder_work_type {
>                 BINDER_WORK_TRANSACTION = 1,
>                 BINDER_WORK_TRANSACTION_COMPLETE,
> +               BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT,
>                 BINDER_WORK_RETURN_ERROR,
>                 BINDER_WORK_NODE,
>                 BINDER_WORK_DEAD_BINDER,
> @@ -396,6 +397,8 @@ struct binder_ref {
>   * @outer_lock:           no nesting under innor or node lock
>   *                        Lock order: 1) outer, 2) node, 3) inner
>   * @binderfs_entry:       process-specific binderfs log file
> + * @oneway_spam_detection_enabled: process enabled oneway spam detection
> + *                        or not
>   *
>   * Bookkeeping structure for binder processes
>   */
> @@ -426,6 +429,7 @@ struct binder_proc {
>         spinlock_t inner_lock;
>         spinlock_t outer_lock;
>         struct dentry *binderfs_entry;
> +       bool oneway_spam_detection_enabled;
>  };
>
>  /**
> diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/android/binder.h
> index ec84ad1..d0da772 100644
> --- a/include/uapi/linux/android/binder.h
> +++ b/include/uapi/linux/android/binder.h
> @@ -227,6 +227,7 @@ struct binder_node_info_for_ref {
>  #define BINDER_GET_NODE_DEBUG_INFO     _IOWR('b', 11, struct binder_node_debug_info)
>  #define BINDER_GET_NODE_INFO_FOR_REF   _IOWR('b', 12, struct binder_node_info_for_ref)
>  #define BINDER_SET_CONTEXT_MGR_EXT     _IOW('b', 13, struct flat_binder_object)
> +#define BINDER_ENABLE_ONEWAY_SPAM_DETECTION    _IOW('b', 15, __u32)
>
>  /*
>   * NOTE: Two special error codes you should check for when calling
> @@ -408,6 +409,13 @@ enum binder_driver_return_protocol {
>          * The last transaction (either a bcTRANSACTION or
>          * a bcATTEMPT_ACQUIRE) failed (e.g. out of memory).  No parameters.
>          */
> +
> +       BR_ONEWAY_SPAM_SUSPECT = _IO('r', 19),
> +       /*
> +        * Current process sent too many oneway calls to target, and the last
> +        * asynchronous transaction makes the allocated async buffer size exceed
> +        * detection threshold.  No parameters.
> +        */
>  };
>
>  enum binder_driver_command_protocol {
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
