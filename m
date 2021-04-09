Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47ED35A1D2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 17:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbhDIPQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 11:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbhDIPQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 11:16:44 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4E7C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 08:16:29 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id j18so10294573lfg.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 08:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2SRv6ETQgBpUM26UkRKrVH/kghy1rKUWbqGRJ74+lCQ=;
        b=LnHYGtcU6slR/lElyWQmVCU0UXwU2OrDCIleeRSAh8avHoe/w+Y79C6NOKgKBQEaFB
         bWM4qR0lgztda1GtjnsOWovPsEXsQR0zrHptUS+ji+RkKMCD5/hW5RgnGbVBCuTIrpps
         UuG8b2pULN8c6d/vkDoGVtTxqZsFzTLVG7vgrzRTW7qTW3WoiDK+0jXFq4EXdfEny4O/
         lssIx01nqamVPxys2/4zBSNx3KLYFM3znILK4RdqqJ/xEAgjpUKLZe7xF+RY9TCxW6v1
         5bQmfF2WK4zJdUnfb0Ya8CzFfkhjvkYEIvByI9tLrn6rEUjA1Q/JPVQxWj3muHHP2DAG
         ag9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2SRv6ETQgBpUM26UkRKrVH/kghy1rKUWbqGRJ74+lCQ=;
        b=cKYDVEUNQ/o7Cr1GNqXL6/WV6+ielPEchAuAljZj2fGRb8u8+va0HXQARUThFshilI
         Ou1SHx8prZBbWoBgONUpxKdP2E1MTEOtYN4+CKjS5PO8ifKnGNYr33ZVz+jRcjVU3vda
         SUZZu030BWcdTzATJZoCyJWw6nTVlc/h7hYEy6yRK6h3mtnMYG3PGDGFBly1bX4YhF/5
         uaQRGEhxoG5NABmrsdVMfsTDCFajodfnfDkQiprj0S49zPkwb8UD5l+RrWdUkPhEvQxe
         1P6yKExWd/1gGzubrqGESzGTgYIaXpwy+g3/hVRzBAQBiY3G5ZbfkDy+PwsvePy1cryg
         5Qmg==
X-Gm-Message-State: AOAM532X+ZK1EdNuu0EErXrNvtsXjN2FnbW6P0UKURlM66ltlSS4/0f0
        SLS2lrfVlr7dcbpfYtFTEmxZIImQoz+E3xK4RggwhQ==
X-Google-Smtp-Source: ABdhPJxaDTm5+KtjMV61noXUAjmBuge8+BqGVOGm6YuJQXVKU1EzkLV7uWDUwPUkUtW4E6dWa+xwOgt22f6hc7lTCM4=
X-Received: by 2002:ac2:5083:: with SMTP id f3mr2193090lfm.562.1617981387631;
 Fri, 09 Apr 2021 08:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <1617961246-4502-1-git-send-email-hangl@codeaurora.org> <1617961246-4502-3-git-send-email-hangl@codeaurora.org>
In-Reply-To: <1617961246-4502-3-git-send-email-hangl@codeaurora.org>
From:   Todd Kjos <tkjos@google.com>
Date:   Fri, 9 Apr 2021 08:16:15 -0700
Message-ID: <CAHRSSEw8jx9oc6qscjicTCPM_6i8cv420W-EC4eHt_h_+k3OjQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] binder: tell userspace to dump current backtrace when
 detected oneway spamming
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

On Fri, Apr 9, 2021 at 2:42 AM Hang Lu <hangl@codeaurora.org> wrote:
>
> When async binder buffer got exhausted, some normal oneway transactions
> will also be discarded and may cause system or application failures. By
> that time, the binder debug information we dump may not be relevant to
> the root cause. And this issue is difficult to debug if without the
> backtrace of the thread sending spam.
>
> This change will send BR_ONEWAY_SPAM_SUSPECT to userspace when oneway
> spamming is detected, request to dump current backtrace. Oneway spamming
> will be reported only once when exceeding the threshold (target process
> dips below 80% of its oneway space, and current process is responsible for
> either more than 50 transactions, or more than 50% of the oneway space).
> And the detection will restart when the async buffer has returned to a
> healthy state.
>
> Signed-off-by: Hang Lu <hangl@codeaurora.org>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/binder.c            | 27 ++++++++++++++++++++++++---
>  drivers/android/binder_alloc.c      | 15 ++++++++++++---
>  drivers/android/binder_alloc.h      |  8 +++++++-
>  drivers/android/binder_internal.h   |  6 +++++-
>  include/uapi/linux/android/binder.h |  8 ++++++++
>  5 files changed, 56 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index be34da3..63d2c43 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -3020,7 +3020,10 @@ static void binder_transaction(struct binder_proc *proc,
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
> @@ -3893,9 +3896,14 @@ static int binder_thread_read(struct binder_proc *proc,
>
>                         binder_stat_br(proc, thread, cmd);
>                 } break;
> -               case BINDER_WORK_TRANSACTION_COMPLETE: {
> +               case BINDER_WORK_TRANSACTION_COMPLETE:
> +               case BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT: {
> +                       if (proc->oneway_spam_detection_enabled &&
> +                                  w->type == BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT)
> +                               cmd = BR_ONEWAY_SPAM_SUSPECT;
> +                       else
> +                               cmd = BR_TRANSACTION_COMPLETE;
>                         binder_inner_proc_unlock(proc);
> -                       cmd = BR_TRANSACTION_COMPLETE;
>                         kfree(w);
>                         binder_stats_deleted(BINDER_STAT_TRANSACTION_COMPLETE);
>                         if (put_user(cmd, (uint32_t __user *)ptr))
> @@ -4897,6 +4905,18 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
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
> @@ -5561,6 +5581,7 @@ static const char * const binder_return_strings[] = {
>         "BR_CLEAR_DEATH_NOTIFICATION_DONE",
>         "BR_FAILED_REPLY",
>         "BR_FROZEN_REPLY",
> +       "BR_ONEWAY_SPAM_SUSPECT",
>  };
>
>  static const char * const binder_command_strings[] = {
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index 7caf74a..340515f 100644
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
> +        * async space (which is 25% of total buffer size). Oneway spam is only
> +        * detected when the threshold is exceeded.
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
> index a507166..810c0b8 100644
> --- a/drivers/android/binder_internal.h
> +++ b/drivers/android/binder_internal.h
> @@ -155,7 +155,7 @@ enum binder_stat_types {
>  };
>
>  struct binder_stats {
> -       atomic_t br[_IOC_NR(BR_FROZEN_REPLY) + 1];
> +       atomic_t br[_IOC_NR(BR_ONEWAY_SPAM_SUSPECT) + 1];
>         atomic_t bc[_IOC_NR(BC_REPLY_SG) + 1];
>         atomic_t obj_created[BINDER_STAT_COUNT];
>         atomic_t obj_deleted[BINDER_STAT_COUNT];
> @@ -174,6 +174,7 @@ struct binder_work {
>         enum binder_work_type {
>                 BINDER_WORK_TRANSACTION = 1,
>                 BINDER_WORK_TRANSACTION_COMPLETE,
> +               BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT,
>                 BINDER_WORK_RETURN_ERROR,
>                 BINDER_WORK_NODE,
>                 BINDER_WORK_DEAD_BINDER,
> @@ -409,6 +410,8 @@ struct binder_ref {
>   * @outer_lock:           no nesting under innor or node lock
>   *                        Lock order: 1) outer, 2) node, 3) inner
>   * @binderfs_entry:       process-specific binderfs log file
> + * @oneway_spam_detection_enabled: process enabled oneway spam detection
> + *                        or not
>   *
>   * Bookkeeping structure for binder processes
>   */
> @@ -444,6 +447,7 @@ struct binder_proc {
>         spinlock_t inner_lock;
>         spinlock_t outer_lock;
>         struct dentry *binderfs_entry;
> +       bool oneway_spam_detection_enabled;
>  };
>
>  /**
> diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/android/binder.h
> index 156070d..20e435f 100644
> --- a/include/uapi/linux/android/binder.h
> +++ b/include/uapi/linux/android/binder.h
> @@ -241,6 +241,7 @@ struct binder_frozen_status_info {
>  #define BINDER_SET_CONTEXT_MGR_EXT     _IOW('b', 13, struct flat_binder_object)
>  #define BINDER_FREEZE                  _IOW('b', 14, struct binder_freeze_info)
>  #define BINDER_GET_FROZEN_INFO         _IOWR('b', 15, struct binder_frozen_status_info)
> +#define BINDER_ENABLE_ONEWAY_SPAM_DETECTION    _IOW('b', 16, __u32)
>
>  /*
>   * NOTE: Two special error codes you should check for when calling
> @@ -428,6 +429,13 @@ enum binder_driver_return_protocol {
>          * The target of the last transaction (either a bcTRANSACTION or
>          * a bcATTEMPT_ACQUIRE) is frozen.  No parameters.
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
