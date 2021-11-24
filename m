Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B6445B5EC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 08:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239947AbhKXHyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 02:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhKXHyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 02:54:14 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F210BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 23:51:04 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so4350120pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 23:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=czf7PZpdwbA/EMClCpyC/1nStu6kUX6JuMsXM+ogJ2M=;
        b=Dgqkx4QPFsTCo7ZSMp4doGo6YIm9C+v3TtsffbjvtTv9SIo0jGdhpxWqDw7pI1SLbg
         94BexqEcFHlzeW+UFiqTVAM02Bap8g8n/A2T8u1zB4DSZYB85lyZ1JLpZIxn4BNX1ZU5
         ybqNuGnA7v0uIWM9bmW1NFu6pczN9DteG+5FhRqWbEwgeILTMCBdJJY9UUAR0CY2rFRk
         Ry3BZeX+PCgIbb9xv7r9JoBazxZvseMfofuc+wkfgYH0crYlqRKlMAUweCCWEFrESXV4
         7YB0DOh96d4YiIGs9kW/1+EQzkzGKFShpXQr87kqq0q5QwidRezklOMaHhJOfmJS2TT6
         ln1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=czf7PZpdwbA/EMClCpyC/1nStu6kUX6JuMsXM+ogJ2M=;
        b=Xw57hnWwzueDeJaWrJ4OZW59f/Qc+nfJP9373veiu6i1iDH2Htl1lxL+GnEo3nfa8N
         7qMrb5pzh+LP8M25s+DfuhqOmqUCGDeS0X/hgBoJJR6jt5VbdkXIJqWoEpXU69+qXM4p
         UsggeC1zeGdDjPoljvXk/1RGpdzSkz7tDbhaconTU32ZAR37YInc6ZNJ2IYlMmEXIQDe
         sGQF+5XQ2lnhVlxevQXr06hDebOH2hkdwPlXW94Z5RmOeJEW078nRC8HBo0ajYLe3KKP
         R5jda89LptJKQb/RS2zZr9N0maBmnGFZubz8q0nCmuj7zDOZOCAlypAu2jgXZMa7xmBA
         uzcw==
X-Gm-Message-State: AOAM533Cn3s5JUw6g3Qw0EBVoiQbF3wQ+61aZv/XNEshZl4S6qnHEJgS
        Jn3sTtpR4TXonkKf9Z+BiucW+l5KeURhaWkhfNvlhqge+y1PMQ==
X-Google-Smtp-Source: ABdhPJyLogq4A3sS2R7A9urcCJyaCZHwOt/NVsxrowG4DCOqg6UO5bz5l4m5fQXIYvDMLmFGZ1XPQPB1S8XN56CNiN0=
X-Received: by 2002:a17:90a:1913:: with SMTP id 19mr12323641pjg.174.1637740264323;
 Tue, 23 Nov 2021 23:51:04 -0800 (PST)
MIME-Version: 1.0
References: <20211123191737.1296541-1-tkjos@google.com> <20211123191737.1296541-4-tkjos@google.com>
In-Reply-To: <20211123191737.1296541-4-tkjos@google.com>
From:   Martijn Coenen <maco@android.com>
Date:   Wed, 24 Nov 2021 08:50:53 +0100
Message-ID: <CAB0TPYHCyLvfMC2VcyBQD5gSE_-1M=0EMiwWB3gWi8E8_b3PVg@mail.gmail.com>
Subject: Re: [PATCH 3/3] binder: defer copies of pre-patched txn data
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
> BINDER_TYPE_PTR objects point to memory areas in the
> source process to be copied into the target buffer
> as part of a transaction. This implements a scatter-
> gather model where non-contiguous memory in a source
> process is "gathered" into a contiguous region in
> the target buffer.
>
> The data can include pointers that must be fixed up
> to correctly point to the copied data. To avoid making
> source process pointers visible to the target process,
> this patch defers the copy until the fixups are known
> and then copies and fixeups are done together.
>
> There is a special case of BINDER_TYPE_FDA which applies
> the fixup later in the target process context. In this
> case the user data is skipped (so no untranslated fds
> become visible to the target).
>
> Signed-off-by: Todd Kjos <tkjos@google.com>
Reviewed-by: Martijn Coenen <maco@android.com>

> ---
>  drivers/android/binder.c | 311 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 286 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 2300fa8e09d5..56dc814b8dde 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -2233,7 +2233,258 @@ static int binder_translate_fd(u32 fd, binder_size_t fd_offset,
>         return ret;
>  }
>
> -static int binder_translate_fd_array(struct binder_fd_array_object *fda,
> +/**
> + * struct binder_ptr_fixup - data to be fixed-up in target buffer
> + * @offset     offset in target buffer to fixup
> + * @skip_size  bytes to skip in copy (fixup will be written later)
> + * @fixup_data data to write at fixup offset
> + * @node       list node
> + *
> + * This is used for the pointer fixup list (pf) which is created and consumed
> + * during binder_transaction() and is only accessed locally. No
> + * locking is necessary.
> + *
> + * The list is ordered by @offset.
> + */
> +struct binder_ptr_fixup {
> +       binder_size_t offset;
> +       size_t skip_size;
> +       binder_uintptr_t fixup_data;
> +       struct list_head node;
> +};
> +
> +/**
> + * struct binder_sg_copy - scatter-gather data to be copied
> + * @offset     offset in target buffer
> + * @uaddr      user address in source buffer
> + * @length     bytes to copy
> + * @node       list node
> + *
> + * This is used for the sg copy list (sgc) which is created and consumed
> + * during binder_transaction() and is only accessed locally. No
> + * locking is necessary.
> + *
> + * The list is ordered by @offset.
> + */
> +struct binder_sg_copy {
> +       binder_size_t offset;
> +       const void __user *uaddr;
> +       size_t length;
> +       struct list_head node;
> +};
> +
> +/**
> + * binder_do_deferred_txn_copies() - copy and fixup scatter-gather data
> + * @alloc:     binder_alloc associated with @buffer
> + * @buffer:    binder buffer in target process
> + * @sgc_head:  list_head of scatter-gather copy list
> + * @pf_head:   list_head of pointer fixup list
> + *
> + * Processes all elements of @sgc_head, applying fixups from @pf_head
> + * and copying the scatter-gather data from the source process' user
> + * buffer to the target's buffer. It is expected that the list creation
> + * and processing all occurs during binder_transaction() so these lists
> + * are only accessed in local context.
> + *
> + * Return: 0=success, else -errno
> + */
> +static int binder_do_deferred_txn_copies(struct binder_alloc *alloc,
> +                                        struct binder_buffer *buffer,
> +                                        struct list_head *sgc_head,
> +                                        struct list_head *pf_head)
> +{
> +       int ret = 0;
> +       struct list_head *entry, *tmp;
> +       struct binder_ptr_fixup *pf =
> +               list_first_entry_or_null(pf_head, struct binder_ptr_fixup,
> +                                        node);
> +
> +       list_for_each_safe(entry, tmp, sgc_head) {
> +               size_t bytes_copied = 0;
> +               struct binder_sg_copy *sgc =
> +                       container_of(entry, struct binder_sg_copy, node);
> +
> +               while (bytes_copied < sgc->length) {
> +                       size_t copy_size;
> +                       size_t bytes_left = sgc->length - bytes_copied;
> +                       size_t offset = sgc->offset + bytes_copied;
> +
> +                       /*
> +                        * We copy up to the fixup (pointed to by pf)
> +                        */
> +                       copy_size = pf ? min(bytes_left, (size_t)pf->offset - offset)
> +                                      : bytes_left;
> +                       if (!ret && copy_size)
> +                               ret = binder_alloc_copy_user_to_buffer(
> +                                               alloc, buffer,
> +                                               offset,
> +                                               sgc->uaddr + bytes_copied,
> +                                               copy_size);
> +                       bytes_copied += copy_size;
> +                       if (copy_size != bytes_left) {
> +                               BUG_ON(!pf);
> +                               /* we stopped at a fixup offset */
> +                               if (pf->skip_size) {
> +                                       /*
> +                                        * we are just skipping. This is for
> +                                        * BINDER_TYPE_FDA where the translated
> +                                        * fds will be fixed up when we get
> +                                        * to target context.
> +                                        */
> +                                       bytes_copied += pf->skip_size;
> +                               } else {
> +                                       /* apply the fixup indicated by pf */
> +                                       if (!ret)
> +                                               ret = binder_alloc_copy_to_buffer(
> +                                                       alloc, buffer,
> +                                                       pf->offset,
> +                                                       &pf->fixup_data,
> +                                                       sizeof(pf->fixup_data));
> +                                       bytes_copied += sizeof(pf->fixup_data);
> +                               }
> +                               list_del(&pf->node);
> +                               kfree(pf);
> +                               pf = list_first_entry_or_null(pf_head,
> +                                               struct binder_ptr_fixup, node);
> +                       }
> +               }
> +               list_del(&sgc->node);
> +               kfree(sgc);
> +       }
> +       BUG_ON(!list_empty(pf_head));
> +       BUG_ON(!list_empty(sgc_head));
> +
> +       return ret;
> +}
> +
> +/**
> + * binder_cleanup_deferred_txn_lists() - free specified lists
> + * @sgc_head:  list_head of scatter-gather copy list
> + * @pf_head:   list_head of pointer fixup list
> + *
> + * Called to clean up @sgc_head and @pf_head if there is an
> + * error.
> + */
> +static void binder_cleanup_deferred_txn_lists(struct list_head *sgc_head,
> +                                             struct list_head *pf_head)
> +{
> +       struct list_head *entry, *tmp;
> +
> +       list_for_each_safe(entry, tmp, sgc_head) {
> +               struct binder_sg_copy *sgc =
> +                       container_of(entry, struct binder_sg_copy, node);
> +               list_del(&sgc->node);
> +               kfree(sgc);
> +       }
> +       list_for_each_safe(entry, tmp, pf_head) {
> +               struct binder_ptr_fixup *pf =
> +                       container_of(entry, struct binder_ptr_fixup, node);
> +               list_del(&pf->node);
> +               kfree(pf);
> +       }
> +}
> +
> +/**
> + * binder_defer_copy() - queue a scatter-gather buffer for copy
> + * @sgc_head:  list_head of scatter-gather copy list
> + * @offset:    binder buffer offset in target process
> + * @uaddr:     user address in source process
> + * @length:    bytes to copy
> + *
> + * Specify a scatter-gather block to be copied. The actual copy must
> + * be deferred until all the needed fixups are identified and queued.
> + * Then the copy and fixups are done together so un-translated values
> + * from the source are never visible in the target buffer.
> + *
> + * We are guaranteed that repeated calls to this function will have
> + * monotonically increasing @offset values so the list will naturally
> + * be ordered.
> + *
> + * Return: 0=success, else -errno
> + */
> +static int binder_defer_copy(struct list_head *sgc_head, binder_size_t offset,
> +                            const void __user *uaddr, size_t length)
> +{
> +       struct binder_sg_copy *bc = kzalloc(sizeof(*bc), GFP_KERNEL);
> +
> +       if (!bc)
> +               return -ENOMEM;
> +
> +       bc->offset = offset;
> +       bc->uaddr = uaddr;
> +       bc->length = length;
> +       INIT_LIST_HEAD(&bc->node);
> +
> +       /*
> +        * We are guaranteed that the deferred copies are in-order
> +        * so just add to the tail.
> +        */
> +       list_add_tail(&bc->node, sgc_head);
> +
> +       return 0;
> +}
> +
> +/**
> + * binder_add_fixup() - queue a fixup to be applied to sg copy
> + * @pf_head:   list_head of binder ptr fixup list
> + * @offset:    binder buffer offset in target process
> + * @fixup:     bytes to be copied for fixup
> + * @skip_size: bytes to skip when copying (fixup will be applied later)
> + *
> + * Add the specified fixup to a list ordered by @offset. When copying
> + * the scatter-gather buffers, the fixup will be copied instead of
> + * data from the source buffer. For BINDER_TYPE_FDA fixups, the fixup
> + * will be applied later (in target process context), so we just skip
> + * the bytes specified by @skip_size. If @skip_size is 0, we copy the
> + * value in @fixup.
> + *
> + * This function is called *mostly* in @offset order, but there are
> + * exceptions. Since out-of-order inserts are relatively uncommon,
> + * we insert the new element by searching backward from the tail of
> + * the list.
> + *
> + * Return: 0=success, else -errno
> + */
> +static int binder_add_fixup(struct list_head *pf_head, binder_size_t offset,
> +                           binder_uintptr_t fixup, size_t skip_size)
> +{
> +       struct binder_ptr_fixup *pf = kzalloc(sizeof(*pf), GFP_KERNEL);
> +       struct list_head *tmp;
> +
> +       if (!pf)
> +               return -ENOMEM;
> +
> +       pf->offset = offset;
> +       pf->fixup_data = fixup;
> +       pf->skip_size = skip_size;
> +       INIT_LIST_HEAD(&pf->node);
> +
> +       /* Fixups are *mostly* added in-order, but there are some
> +        * exceptions. Look backwards through list for insertion point.
> +        */
> +       if (!list_empty(pf_head)) {
> +               list_for_each_prev(tmp, pf_head) {
> +                       struct binder_ptr_fixup *tmppf =
> +                               list_entry(tmp, struct binder_ptr_fixup, node);
> +
> +                       if (tmppf->offset < pf->offset) {
> +                               list_add(&pf->node, tmp);
> +                               return 0;
> +                       }
> +               }
> +               /*
> +                * if we get here, then the new offset is the lowest so
> +                * insert at the head
> +                */
> +               list_add(&pf->node, pf_head);
> +               return 0;
> +       }
> +       list_add_tail(&pf->node, pf_head);
> +       return 0;
> +}
> +
> +static int binder_translate_fd_array(struct list_head *pf_head,
> +                                    struct binder_fd_array_object *fda,
>                                      const void __user *u,
>                                      struct binder_buffer_object *parent,
>                                      struct binder_buffer_object *uparent,
> @@ -2245,6 +2496,7 @@ static int binder_translate_fd_array(struct binder_fd_array_object *fda,
>         binder_size_t fda_offset;
>         const void __user *ufda_base;
>         struct binder_proc *proc = thread->proc;
> +       int ret;
>
>         fd_buf_size = sizeof(u32) * fda->num_fds;
>         if (fda->num_fds >= SIZE_MAX / sizeof(u32)) {
> @@ -2276,9 +2528,12 @@ static int binder_translate_fd_array(struct binder_fd_array_object *fda,
>                                   proc->pid, thread->pid);
>                 return -EINVAL;
>         }
> +       ret = binder_add_fixup(pf_head, fda_offset, 0, fda->num_fds * sizeof(u32));
> +       if (ret)
> +               return ret;
> +
>         for (fdi = 0; fdi < fda->num_fds; fdi++) {
>                 u32 fd;
> -               int ret;
>                 binder_size_t offset = fda_offset + fdi * sizeof(fd);
>                 binder_size_t uoffset = fdi * sizeof(fd);
>
> @@ -2292,7 +2547,8 @@ static int binder_translate_fd_array(struct binder_fd_array_object *fda,
>         return 0;
>  }
>
> -static int binder_fixup_parent(struct binder_transaction *t,
> +static int binder_fixup_parent(struct list_head *pf_head,
> +                              struct binder_transaction *t,
>                                struct binder_thread *thread,
>                                struct binder_buffer_object *bp,
>                                binder_size_t off_start_offset,
> @@ -2338,14 +2594,7 @@ static int binder_fixup_parent(struct binder_transaction *t,
>         }
>         buffer_offset = bp->parent_offset +
>                         (uintptr_t)parent->buffer - (uintptr_t)b->user_data;
> -       if (binder_alloc_copy_to_buffer(&target_proc->alloc, b, buffer_offset,
> -                                       &bp->buffer, sizeof(bp->buffer))) {
> -               binder_user_error("%d:%d got transaction with invalid parent offset\n",
> -                                 proc->pid, thread->pid);
> -               return -EINVAL;
> -       }
> -
> -       return 0;
> +       return binder_add_fixup(pf_head, buffer_offset, bp->buffer, 0);
>  }
>
>  /**
> @@ -2487,8 +2736,12 @@ static void binder_transaction(struct binder_proc *proc,
>         int t_debug_id = atomic_inc_return(&binder_last_id);
>         char *secctx = NULL;
>         u32 secctx_sz = 0;
> +       struct list_head sgc_head;
> +       struct list_head pf_head;
>         const void __user *user_buffer = (const void __user *)
>                                 (uintptr_t)tr->data.ptr.buffer;
> +       INIT_LIST_HEAD(&sgc_head);
> +       INIT_LIST_HEAD(&pf_head);
>
>         e = binder_transaction_log_add(&binder_transaction_log);
>         e->debug_id = t_debug_id;
> @@ -3006,8 +3259,8 @@ static void binder_transaction(struct binder_proc *proc,
>                                 return_error_line = __LINE__;
>                                 goto err_bad_parent;
>                         }
> -                       ret = binder_translate_fd_array(fda, user_buffer,
> -                                                       parent,
> +                       ret = binder_translate_fd_array(&pf_head, fda,
> +                                                       user_buffer, parent,
>                                                         &user_object.bbo, t,
>                                                         thread, in_reply_to);
>                         if (ret < 0 ||
> @@ -3038,19 +3291,14 @@ static void binder_transaction(struct binder_proc *proc,
>                                 return_error_line = __LINE__;
>                                 goto err_bad_offset;
>                         }
> -                       if (binder_alloc_copy_user_to_buffer(
> -                                               &target_proc->alloc,
> -                                               t->buffer,
> -                                               sg_buf_offset,
> -                                               (const void __user *)
> -                                                       (uintptr_t)bp->buffer,
> -                                               bp->length)) {
> -                               binder_user_error("%d:%d got transaction with invalid offsets ptr\n",
> -                                                 proc->pid, thread->pid);
> -                               return_error_param = -EFAULT;
> +                       ret = binder_defer_copy(&sgc_head, sg_buf_offset,
> +                               (const void __user *)(uintptr_t)bp->buffer,
> +                               bp->length);
> +                       if (ret) {
>                                 return_error = BR_FAILED_REPLY;
> +                               return_error_param = ret;
>                                 return_error_line = __LINE__;
> -                               goto err_copy_data_failed;
> +                               goto err_translate_failed;
>                         }
>                         /* Fixup buffer pointer to target proc address space */
>                         bp->buffer = (uintptr_t)
> @@ -3059,7 +3307,8 @@ static void binder_transaction(struct binder_proc *proc,
>
>                         num_valid = (buffer_offset - off_start_offset) /
>                                         sizeof(binder_size_t);
> -                       ret = binder_fixup_parent(t, thread, bp,
> +                       ret = binder_fixup_parent(&pf_head, t,
> +                                                 thread, bp,
>                                                   off_start_offset,
>                                                   num_valid,
>                                                   last_fixup_obj_off,
> @@ -3099,6 +3348,17 @@ static void binder_transaction(struct binder_proc *proc,
>                 return_error_line = __LINE__;
>                 goto err_copy_data_failed;
>         }
> +
> +       ret = binder_do_deferred_txn_copies(&target_proc->alloc, t->buffer,
> +                                           &sgc_head, &pf_head);
> +       if (ret) {
> +               binder_user_error("%d:%d got transaction with invalid offsets ptr\n",
> +                                 proc->pid, thread->pid);
> +               return_error = BR_FAILED_REPLY;
> +               return_error_param = ret;
> +               return_error_line = __LINE__;
> +               goto err_copy_data_failed;
> +       }
>         if (t->buffer->oneway_spam_suspect)
>                 tcomplete->type = BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT;
>         else
> @@ -3172,6 +3432,7 @@ static void binder_transaction(struct binder_proc *proc,
>  err_bad_offset:
>  err_bad_parent:
>  err_copy_data_failed:
> +       binder_cleanup_deferred_txn_lists(&sgc_head, &pf_head);
>         binder_free_txn_fixups(t);
>         trace_binder_transaction_failed_buffer_release(t->buffer);
>         binder_transaction_buffer_release(target_proc, NULL, t->buffer,
> --
> 2.34.0.rc2.393.gf8c9666880-goog
>
>
