Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CE045B5E6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 08:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbhKXHxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 02:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhKXHxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 02:53:37 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CB6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 23:50:28 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id p18so1140712plf.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 23:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p7OhNw7NbkljdbC5vTeDhFSiwSIC4ljGbACHNY+8bQM=;
        b=BavmOPuIL0k1VlR3fAsPBXGxTBkbYdcJppi/S+JG5i1PWc1ABO8erBGnid8hUGkvDC
         h3Pv1BjppE9UEpQRctxp0Zu8uwJDyQNTehg27ubQcF/+ZIRpYgg9RNRr3gX2Y6cu9Hwq
         GH1XjWTMaCDdaxkkBLMvsZRC1LAQV3O2Hujmz4FnBVuO/4GZexXCrYtECu50zqUdHvU4
         Y6slSclJHbQ2wcNB8xX31AYWfVAcnp7inscC9URNH/WXxtey2Vy1IpsZCAYtMzx02qbx
         APJ5DKrrpR14Mj2loicU8+JdTVmOTF3tLw/+pz92h15XJBg4jSI+rp4KPs1afKhY4TZa
         ulUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p7OhNw7NbkljdbC5vTeDhFSiwSIC4ljGbACHNY+8bQM=;
        b=zgiRRlMbt8v/Nm/TUWVfvgXB0dFQuqOW+lZ9XEoYTP8bxMHDOB6M6GH5efabWPTPXh
         vHpKNQjM3MLnl37pxIUDoLCVY/Dd9ZAOYTxh3gBH0eFT2dDipj52/8Whzddsj34KMNty
         wILHmswG+2uwCifZ5VtuZtWMACegHAF7yiT+jUSWCz8lCAziAYJ9uuOI5jFKHgAPdnKk
         3LpfBj+xgtiszGsq+CXjbqVgH8Al7h98aRekufbGS3wM+MrGAbHmesdRCfKc70Au+BUJ
         2nY863nOezLM9FTlL3ymV6NjeLq5rNZsA4+GRhG2py74S6f1TLXFcoEBIRvqhCYPeobA
         rwZQ==
X-Gm-Message-State: AOAM530MBKf+uO5842sg4ahRW5CPMwBrwf1gFJ/WcQfa7/XfJ4Px6aS3
        draLLSm/1eak/GXG+elfKp/+4KAAKFXLirld5kiQnA==
X-Google-Smtp-Source: ABdhPJzd2KAsk08tgqnM/ayX4Sib0q/U+FXoHCxCI/DRwYrkc67Wuwp+kqcSN9oc5beplSuLchRda15L4lqJDxw5wlA=
X-Received: by 2002:a17:903:246:b0:143:c007:7d41 with SMTP id
 j6-20020a170903024600b00143c0077d41mr14932168plh.59.1637740227895; Tue, 23
 Nov 2021 23:50:27 -0800 (PST)
MIME-Version: 1.0
References: <20211123191737.1296541-1-tkjos@google.com> <20211123191737.1296541-2-tkjos@google.com>
In-Reply-To: <20211123191737.1296541-2-tkjos@google.com>
From:   Martijn Coenen <maco@android.com>
Date:   Wed, 24 Nov 2021 08:50:17 +0100
Message-ID: <CAB0TPYFffM1R4n7SxjB2f8wM-hJc9JN+SC3xgd_wTROaERyVZg@mail.gmail.com>
Subject: Re: [PATCH 1/3] binder: avoid potential data leakage when copying txn
To:     Todd Kjos <tkjos@google.com>
Cc:     gregkh@linuxfoundation.org, christian@brauner.io, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com, joel@joelfernandes.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 8:17 PM 'Todd Kjos' via kernel-team
<kernel-team@android.com> wrote:
>
> Transactions are copied from the sender to the target
> first and objects like BINDER_TYPE_PTR and BINDER_TYPE_FDA
> are then fixed up. This means there is a short period where
> the sender's version of these objects are visible to the
> target prior to the fixups.
>
> Instead of copying all of the data first, copy data only
> after any needed fixups have been applied.
>
> Signed-off-by: Todd Kjos <tkjos@google.com>
Reviewed-by: Martijn Coenen <maco@android.com>

> ---
>  drivers/android/binder.c | 95 +++++++++++++++++++++++++++++-----------
>  1 file changed, 70 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 49fb74196d02..571d3c203557 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -1608,15 +1608,21 @@ static void binder_cleanup_transaction(struct binder_transaction *t,
>  /**
>   * binder_get_object() - gets object and checks for valid metadata
>   * @proc:      binder_proc owning the buffer
> + * @u:         sender's user pointer to base of buffer
>   * @buffer:    binder_buffer that we're parsing.
>   * @offset:    offset in the @buffer at which to validate an object.
>   * @object:    struct binder_object to read into
>   *
> - * Return:     If there's a valid metadata object at @offset in @buffer, the
> + * Copy the binder object at the given offset into @object. If @u is
> + * provided then the copy is from the sender's buffer. If not, then
> + * it is copied from the target's @buffer.
> + *
> + * Return:     If there's a valid metadata object at @offset, the
>   *             size of that object. Otherwise, it returns zero. The object
>   *             is read into the struct binder_object pointed to by @object.
>   */
>  static size_t binder_get_object(struct binder_proc *proc,
> +                               const void __user *u,
>                                 struct binder_buffer *buffer,
>                                 unsigned long offset,
>                                 struct binder_object *object)
> @@ -1626,10 +1632,16 @@ static size_t binder_get_object(struct binder_proc *proc,
>         size_t object_size = 0;
>
>         read_size = min_t(size_t, sizeof(*object), buffer->data_size - offset);
> -       if (offset > buffer->data_size || read_size < sizeof(*hdr) ||
> -           binder_alloc_copy_from_buffer(&proc->alloc, object, buffer,
> -                                         offset, read_size))
> +       if (offset > buffer->data_size || read_size < sizeof(*hdr))
>                 return 0;
> +       if (u) {
> +               if (copy_from_user(object, u + offset, read_size))
> +                       return 0;
> +       } else {
> +               if (binder_alloc_copy_from_buffer(&proc->alloc, object, buffer,
> +                                                 offset, read_size))
> +                       return 0;
> +       }
>
>         /* Ok, now see if we read a complete object. */
>         hdr = &object->hdr;
> @@ -1702,7 +1714,7 @@ static struct binder_buffer_object *binder_validate_ptr(
>                                           b, buffer_offset,
>                                           sizeof(object_offset)))
>                 return NULL;
> -       object_size = binder_get_object(proc, b, object_offset, object);
> +       object_size = binder_get_object(proc, NULL, b, object_offset, object);
>         if (!object_size || object->hdr.type != BINDER_TYPE_PTR)
>                 return NULL;
>         if (object_offsetp)
> @@ -1767,7 +1779,8 @@ static bool binder_validate_fixup(struct binder_proc *proc,
>                 unsigned long buffer_offset;
>                 struct binder_object last_object;
>                 struct binder_buffer_object *last_bbo;
> -               size_t object_size = binder_get_object(proc, b, last_obj_offset,
> +               size_t object_size = binder_get_object(proc, NULL, b,
> +                                                      last_obj_offset,
>                                                        &last_object);
>                 if (object_size != sizeof(*last_bbo))
>                         return false;
> @@ -1882,7 +1895,7 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
>                 if (!binder_alloc_copy_from_buffer(&proc->alloc, &object_offset,
>                                                    buffer, buffer_offset,
>                                                    sizeof(object_offset)))
> -                       object_size = binder_get_object(proc, buffer,
> +                       object_size = binder_get_object(proc, NULL, buffer,
>                                                         object_offset, &object);
>                 if (object_size == 0) {
>                         pr_err("transaction release %d bad object at offset %lld, size %zd\n",
> @@ -2455,6 +2468,7 @@ static void binder_transaction(struct binder_proc *proc,
>         binder_size_t off_start_offset, off_end_offset;
>         binder_size_t off_min;
>         binder_size_t sg_buf_offset, sg_buf_end_offset;
> +       binder_size_t user_offset = 0;
>         struct binder_proc *target_proc = NULL;
>         struct binder_thread *target_thread = NULL;
>         struct binder_node *target_node = NULL;
> @@ -2469,6 +2483,8 @@ static void binder_transaction(struct binder_proc *proc,
>         int t_debug_id = atomic_inc_return(&binder_last_id);
>         char *secctx = NULL;
>         u32 secctx_sz = 0;
> +       const void __user *user_buffer = (const void __user *)
> +                               (uintptr_t)tr->data.ptr.buffer;
>
>         e = binder_transaction_log_add(&binder_transaction_log);
>         e->debug_id = t_debug_id;
> @@ -2692,7 +2708,7 @@ static void binder_transaction(struct binder_proc *proc,
>                              "%d:%d BC_REPLY %d -> %d:%d, data %016llx-%016llx size %lld-%lld-%lld\n",
>                              proc->pid, thread->pid, t->debug_id,
>                              target_proc->pid, target_thread->pid,
> -                            (u64)tr->data.ptr.buffer,
> +                            (u64)user_buffer,
>                              (u64)tr->data.ptr.offsets,
>                              (u64)tr->data_size, (u64)tr->offsets_size,
>                              (u64)extra_buffers_size);
> @@ -2701,7 +2717,7 @@ static void binder_transaction(struct binder_proc *proc,
>                              "%d:%d BC_TRANSACTION %d -> %d - node %d, data %016llx-%016llx size %lld-%lld-%lld\n",
>                              proc->pid, thread->pid, t->debug_id,
>                              target_proc->pid, target_node->debug_id,
> -                            (u64)tr->data.ptr.buffer,
> +                            (u64)user_buffer,
>                              (u64)tr->data.ptr.offsets,
>                              (u64)tr->data_size, (u64)tr->offsets_size,
>                              (u64)extra_buffers_size);
> @@ -2780,19 +2796,6 @@ static void binder_transaction(struct binder_proc *proc,
>         t->buffer->clear_on_free = !!(t->flags & TF_CLEAR_BUF);
>         trace_binder_transaction_alloc_buf(t->buffer);
>
> -       if (binder_alloc_copy_user_to_buffer(
> -                               &target_proc->alloc,
> -                               t->buffer, 0,
> -                               (const void __user *)
> -                                       (uintptr_t)tr->data.ptr.buffer,
> -                               tr->data_size)) {
> -               binder_user_error("%d:%d got transaction with invalid data ptr\n",
> -                               proc->pid, thread->pid);
> -               return_error = BR_FAILED_REPLY;
> -               return_error_param = -EFAULT;
> -               return_error_line = __LINE__;
> -               goto err_copy_data_failed;
> -       }
>         if (binder_alloc_copy_user_to_buffer(
>                                 &target_proc->alloc,
>                                 t->buffer,
> @@ -2837,6 +2840,7 @@ static void binder_transaction(struct binder_proc *proc,
>                 size_t object_size;
>                 struct binder_object object;
>                 binder_size_t object_offset;
> +               binder_size_t copy_size;
>
>                 if (binder_alloc_copy_from_buffer(&target_proc->alloc,
>                                                   &object_offset,
> @@ -2848,8 +2852,27 @@ static void binder_transaction(struct binder_proc *proc,
>                         return_error_line = __LINE__;
>                         goto err_bad_offset;
>                 }
> -               object_size = binder_get_object(target_proc, t->buffer,
> -                                               object_offset, &object);
> +
> +               /*
> +                * Copy the source user buffer up to the next object
> +                * that will be processed.
> +                */
> +               copy_size = object_offset - user_offset;
> +               if (copy_size && (user_offset > object_offset ||
> +                               binder_alloc_copy_user_to_buffer(
> +                                       &target_proc->alloc,
> +                                       t->buffer, user_offset,
> +                                       user_buffer + user_offset,
> +                                       copy_size))) {
> +                       binder_user_error("%d:%d got transaction with invalid data ptr\n",
> +                                       proc->pid, thread->pid);
> +                       return_error = BR_FAILED_REPLY;
> +                       return_error_param = -EFAULT;
> +                       return_error_line = __LINE__;
> +                       goto err_copy_data_failed;
> +               }
> +               object_size = binder_get_object(target_proc, user_buffer,
> +                               t->buffer, object_offset, &object);
>                 if (object_size == 0 || object_offset < off_min) {
>                         binder_user_error("%d:%d got transaction with invalid offset (%lld, min %lld max %lld) or object.\n",
>                                           proc->pid, thread->pid,
> @@ -2861,6 +2884,11 @@ static void binder_transaction(struct binder_proc *proc,
>                         return_error_line = __LINE__;
>                         goto err_bad_offset;
>                 }
> +               /*
> +                * Set offset to the next buffer fragment to be
> +                * copied
> +                */
> +               user_offset = object_offset + object_size;
>
>                 hdr = &object.hdr;
>                 off_min = object_offset + object_size;
> @@ -2956,7 +2984,11 @@ static void binder_transaction(struct binder_proc *proc,
>                         }
>                         ret = binder_translate_fd_array(fda, parent, t, thread,
>                                                         in_reply_to);
> -                       if (ret < 0) {
> +                       if (ret < 0 ||
> +                           binder_alloc_copy_to_buffer(&target_proc->alloc,
> +                                                       t->buffer,
> +                                                       object_offset,
> +                                                       fda, sizeof(*fda))) {
>                                 return_error = BR_FAILED_REPLY;
>                                 return_error_param = ret;
>                                 return_error_line = __LINE__;
> @@ -3028,6 +3060,19 @@ static void binder_transaction(struct binder_proc *proc,
>                         goto err_bad_object_type;
>                 }
>         }
> +       /* Done processing objects, copy the rest of the buffer */
> +       if (binder_alloc_copy_user_to_buffer(
> +                               &target_proc->alloc,
> +                               t->buffer, user_offset,
> +                               user_buffer + user_offset,
> +                               tr->data_size - user_offset)) {
> +               binder_user_error("%d:%d got transaction with invalid data ptr\n",
> +                               proc->pid, thread->pid);
> +               return_error = BR_FAILED_REPLY;
> +               return_error_param = -EFAULT;
> +               return_error_line = __LINE__;
> +               goto err_copy_data_failed;
> +       }
>         if (t->buffer->oneway_spam_suspect)
>                 tcomplete->type = BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT;
>         else
> --
> 2.34.0.rc2.393.gf8c9666880-goog
>
>
