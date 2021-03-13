Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D83339A4D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 01:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235935AbhCMAII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 19:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbhCMAHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 19:07:33 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12341C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 16:07:32 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 9so9437544ljd.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 16:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vo9Ds2p7ZTRdygb1CNZixssOPWsBAJIixTFMLb5+SLY=;
        b=K4TcHTgP6bwgveRf3jHJPDOViPdwLCTpgpPvLQCZjh26+EvoRbpbYRi8Y1yctIT2yY
         RKvUcG1n8OwrO9lLNLERPINl0+rrRC4Eh1g+qdKg4KB9Kf0sSkgXfO/vA1RXeadbkByL
         /m1WJKzHOZrYesB39+FMqd7ha9GA0/5nmgNMS6AoG6EhbW3MVWpHnOh8UM3JbpnuUUZH
         wp2fo/6HXjF2X0jnrCROB9+IN8eACWxqQQNiWA1+02oMJdUzSKBgGqCMKp0oiNp/9XxB
         GwIsuWZP1pl5FvHCOPPbohJIK7rP4xvdLF9Dv8zQIuWzWqeqJgvR2gQ0SFvM0O4WoTHx
         tBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vo9Ds2p7ZTRdygb1CNZixssOPWsBAJIixTFMLb5+SLY=;
        b=nJxNowlO3abqlJl9taeqyNMameHnd++0X7coU8+Ju3UGcPHY9KMh4bcHekKgm9or3B
         9Tw5p+ZIiEoNDopGQMn7EyLoM+Tne47qOZ4ysk4jYTZQRA8fGH/BSiPBUyj7tPlq2gNb
         KBEo2FK0qv3LQuXGs9Is/LkiN5O8JMZjVwNPRiCidfWGVO60XxpznwJSqg/mUuMUEIDC
         d2oC5F2+Zdh2LJZOP2eQ863ozsT8ckEUoS4uCxNF+et11gxqImR9vIJ27351JDHGAWP3
         oCS5cUGDRoAElJdxP9xxPeW1YRH6eKJwo9GUjCiYUib65jOY8xlzpQREo3tkblFg1sJy
         K9Og==
X-Gm-Message-State: AOAM532nY8mE5k9Y3qo8K2zhwVCOlt8HrnLI6qn/acrgwz46vTti8iqD
        Ita75XahlQzrkXbaPK9zQshe2h4A0s0KACVRXOBN0g==
X-Google-Smtp-Source: ABdhPJxo9Wbb0yWL8tKwiR3yrEJLZIKbUfYDlxIYTV9ha45zSqUNsxXc1n3CpHVI4DfIpfp6IwshLK9/cs8olr1noqs=
X-Received: by 2002:a2e:8018:: with SMTP id j24mr3875242ljg.188.1615594050328;
 Fri, 12 Mar 2021 16:07:30 -0800 (PST)
MIME-Version: 1.0
References: <20210311184629.589725-1-dualli@chromium.org> <20210311184629.589725-4-dualli@chromium.org>
In-Reply-To: <20210311184629.589725-4-dualli@chromium.org>
From:   Todd Kjos <tkjos@google.com>
Date:   Fri, 12 Mar 2021 16:07:19 -0800
Message-ID: <CAHRSSEyQTn6T6yDET-euQNrJuJa_ahCQ9ZtgPK3Os16ED2yfmQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] binder: BINDER_GET_FROZEN_INFO ioctl
To:     Li Li <dualli@chromium.org>
Cc:     Li Li <dualli@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 10:46 AM Li Li <dualli@chromium.org> wrote:
>
> From: Marco Ballesio <balejs@google.com>
>
> User space needs to know if binder transactions occurred to frozen
> processes. Introduce a new BINDER_GET_FROZEN ioctl and keep track of
> transactions occurring to frozen proceses.
>
> Signed-off-by: Marco Ballesio <balejs@google.com>
> Signed-off-by: Li Li <dualli@google.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/binder.c            | 55 +++++++++++++++++++++++++++++
>  drivers/android/binder_internal.h   |  6 ++++
>  include/uapi/linux/android/binder.h |  7 ++++
>  3 files changed, 68 insertions(+)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 38bbf9a4ce99..b4999ed04b2e 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -2360,6 +2360,10 @@ static int binder_proc_transaction(struct binder_transaction *t,
>         }
>
>         binder_inner_proc_lock(proc);
> +       if (proc->is_frozen) {
> +               proc->sync_recv |= !oneway;
> +               proc->async_recv |= oneway;
> +       }
>
>         if ((proc->is_frozen && !oneway) || proc->is_dead ||
>                         (thread && thread->is_dead)) {
> @@ -4636,6 +4640,8 @@ static int binder_ioctl_freeze(struct binder_freeze_info *info,
>
>         if (!info->enable) {
>                 binder_inner_proc_lock(target_proc);
> +               target_proc->sync_recv = false;
> +               target_proc->async_recv = false;
>                 target_proc->is_frozen = false;
>                 binder_inner_proc_unlock(target_proc);
>                 return 0;
> @@ -4647,6 +4653,8 @@ static int binder_ioctl_freeze(struct binder_freeze_info *info,
>          * for transactions to drain.
>          */
>         binder_inner_proc_lock(target_proc);
> +       target_proc->sync_recv = false;
> +       target_proc->async_recv = false;
>         target_proc->is_frozen = true;
>         binder_inner_proc_unlock(target_proc);
>
> @@ -4668,6 +4676,33 @@ static int binder_ioctl_freeze(struct binder_freeze_info *info,
>         return ret;
>  }
>
> +static int binder_ioctl_get_freezer_info(
> +                               struct binder_frozen_status_info *info)
> +{
> +       struct binder_proc *target_proc;
> +       bool found = false;
> +
> +       info->sync_recv = 0;
> +       info->async_recv = 0;
> +
> +       mutex_lock(&binder_procs_lock);
> +       hlist_for_each_entry(target_proc, &binder_procs, proc_node) {
> +               if (target_proc->pid == info->pid) {
> +                       found = true;
> +                       binder_inner_proc_lock(target_proc);
> +                       info->sync_recv |= target_proc->sync_recv;
> +                       info->async_recv |= target_proc->async_recv;
> +                       binder_inner_proc_unlock(target_proc);
> +               }
> +       }
> +       mutex_unlock(&binder_procs_lock);
> +
> +       if (!found)
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
>  static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  {
>         int ret;
> @@ -4846,6 +4881,24 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>                         goto err;
>                 break;
>         }
> +       case BINDER_GET_FROZEN_INFO: {
> +               struct binder_frozen_status_info info;
> +
> +               if (copy_from_user(&info, ubuf, sizeof(info))) {
> +                       ret = -EFAULT;
> +                       goto err;
> +               }
> +
> +               ret = binder_ioctl_get_freezer_info(&info);
> +               if (ret < 0)
> +                       goto err;
> +
> +               if (copy_to_user(ubuf, &info, sizeof(info))) {
> +                       ret = -EFAULT;
> +                       goto err;
> +               }
> +               break;
> +       }
>         default:
>                 ret = -EINVAL;
>                 goto err;
> @@ -5156,6 +5209,8 @@ static void binder_deferred_release(struct binder_proc *proc)
>
>         proc->is_dead = true;
>         proc->is_frozen = false;
> +       proc->sync_recv = false;
> +       proc->async_recv = false;
>         threads = 0;
>         active_transactions = 0;
>         while ((n = rb_first(&proc->threads))) {
> diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
> index e6a53e98c6da..2872a7de68e1 100644
> --- a/drivers/android/binder_internal.h
> +++ b/drivers/android/binder_internal.h
> @@ -376,6 +376,10 @@ struct binder_ref {
>   * @is_frozen:            process is frozen and unable to service
>   *                        binder transactions
>   *                        (protected by @inner_lock)
> + * @sync_recv:            process received sync transactions since last frozen
> + *                        (protected by @inner_lock)
> + * @async_recv:           process received async transactions since last frozen
> + *                        (protected by @inner_lock)
>   * @freeze_wait:          waitqueue of processes waiting for all outstanding
>   *                        transactions to be processed
>   *                        (protected by @inner_lock)
> @@ -422,6 +426,8 @@ struct binder_proc {
>         int outstanding_txns;
>         bool is_dead;
>         bool is_frozen;
> +       bool sync_recv;
> +       bool async_recv;
>         wait_queue_head_t freeze_wait;
>
>         struct list_head todo;
> diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/android/binder.h
> index 7eb5b818b3c1..156070d18c4f 100644
> --- a/include/uapi/linux/android/binder.h
> +++ b/include/uapi/linux/android/binder.h
> @@ -223,6 +223,12 @@ struct binder_freeze_info {
>         __u32            timeout_ms;
>  };
>
> +struct binder_frozen_status_info {
> +       __u32            pid;
> +       __u32            sync_recv;
> +       __u32            async_recv;
> +};
> +
>  #define BINDER_WRITE_READ              _IOWR('b', 1, struct binder_write_read)
>  #define BINDER_SET_IDLE_TIMEOUT                _IOW('b', 3, __s64)
>  #define BINDER_SET_MAX_THREADS         _IOW('b', 5, __u32)
> @@ -234,6 +240,7 @@ struct binder_freeze_info {
>  #define BINDER_GET_NODE_INFO_FOR_REF   _IOWR('b', 12, struct binder_node_info_for_ref)
>  #define BINDER_SET_CONTEXT_MGR_EXT     _IOW('b', 13, struct flat_binder_object)
>  #define BINDER_FREEZE                  _IOW('b', 14, struct binder_freeze_info)
> +#define BINDER_GET_FROZEN_INFO         _IOWR('b', 15, struct binder_frozen_status_info)
>
>  /*
>   * NOTE: Two special error codes you should check for when calling
> --
> 2.31.0.rc2.261.g7f71774620-goog
>
